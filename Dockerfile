FROM centos:7
MAINTAINER tribou

# Add Node.js rpm
#RUN curl -sL https://rpm.nodesource.com/setup_4.x | bash -

# Install dependencies
RUN yum update -y && \
  yum clean all && \
  yum install -y \
  gcc-c++ \
  make

# Install nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 4.3.0

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | bash \
  && source $NVM_DIR/nvm.sh \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/v$NODE_VERSION/bin:$PATH

# Install NPM
RUN $NVM_BIN/npm install -g npm@3

# Install global NPM modules
RUN $NVM_BIN/npm install -g \
  babel-node-debug \
  bower \
  instant-markdown-d \
  nodemon \
  nsp \
  react-native-cli \
  serverless \
  slush \
  typescript

# Create app folder
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Instant markdown
EXPOSE 8090

# Node processes
EXPOSE 8000

# Browsersync
EXPOSE 3000
EXPOSE 3001
