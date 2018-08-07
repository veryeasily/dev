FROM debian:9.5-slim
RUN apt-get update && apt-get install -y wget curl git vim-nox \
  && mkdir -p /root/.vim/autoload /root/.vim/undo /root/.vim/backups /root/.vim/swaps \
  && mkdir -p /tmp/downloads /usr/share/man/man1 \
  && cd /tmp/downloads \
  && wget https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep-0.8.1-x86_64-unknown-linux-musl.tar.gz \
  && tar -zxvf ripgrep-0.8.1-x86_64-unknown-linux-musl.tar.gz \
  && cd ripgrep-0.8.1-x86_64-unknown-linux-musl \
  && mv rg /usr/bin/rg && mv ./doc/rg.1 /usr/share/man/man1/rg.1 \
  && cd /tmp && rm -rf downloads

WORKDIR /root
ADD ["root", "/root/"]
RUN tic ./screen-256color.ti && rm screen-256color.ti \
  && vim +PlugInstall +qall

ENV SHELL=/bin/bash
ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["/bin/bash"]
