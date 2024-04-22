FROM rust:1.77.2
WORKDIR /app
# Install the required system dependencies for our linking configuration
RUN apt update && apt install lld clang -y

# Copy all files from our working environment to our Docker image
COPY . .
ENV SQLX_OFFLINE true

# Build our binary
# We'll use the release profile to make it faaast
RUN cargo build --release
ENV APP_ENVIRONMENT production

# When `docker run` is executed, launch the biary!
ENTRYPOINT [ "./target/release/zero2prod" ]
