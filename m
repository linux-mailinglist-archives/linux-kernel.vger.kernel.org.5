Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D9E77F9B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352327AbjHQOxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352340AbjHQOxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:53:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ABC10E;
        Thu, 17 Aug 2023 07:53:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso12635400e87.0;
        Thu, 17 Aug 2023 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692283995; x=1692888795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MXDhLNOC2CfcyjAC22ml0jBH6WAGStlYi1BEiZsQY78=;
        b=igXJ5OtXndwCk4Jh7kfC+v3FVQeSEnmR9MEyZI9Hlw3I0MhZfyI8lLU5nZeLsO66cf
         N3Q/zFsQRX6QwTz8uaiDQgW/tLXAIPJlF87teBPMa6G8NhKLZ1VqrqOwVNXOElyWPyk/
         pCNCo+tQjDEtCnV5sDzkHA9FVGiFeTrImBDAfGvkaK/3D+83lx3rjonFT+ySNp6Lsm1d
         1jGrCfLTLb6SLxDfVkxEQQARPTLadushVbOxmU3ZFiQxMj7ALj+Egwpj7FRccP/xbkdz
         XujtNQFeOkz7dQnlSV/mZEc3B+7g3WrYehkWaPK3vGJPzPVRi4tMdemo7wSyN1dxd/b2
         BKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283995; x=1692888795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXDhLNOC2CfcyjAC22ml0jBH6WAGStlYi1BEiZsQY78=;
        b=AQhoq1+TttWusdP0H+/eWRWjHBStqwkgriRtHL6akKf3zHDHGA8U0HnSKuFbSiOzHQ
         b/4BMF0mCzSi+WkpqO1lfWknnoeKzz94x8y0/WLM6+cr5SYuImyS0q0hJO6wQq41gRVe
         IPWnJQxu5DhLuY2Og/WbeIpMCgJ1Hj08qXTcLNQyngajY7YBXgy7thn4R/Ly7lQYbjsg
         jQPKQGtNWXcZVz71YGSljgJ/Agrnak9m7oivAPDUrqaF7lIGM7tIRlmQz3ifcGrB1BIu
         xjTtqDuZy+Ttf4ivc1vIAMco9Y1RBzlCrtlqo8S84V/izPu9DBUArc/yiS47AoPwRwhL
         8/jw==
X-Gm-Message-State: AOJu0Yy7hrkaTHxUUrFE578u5G7cEJfwHd3fFTlsLWbaqXN7cHSpvzTa
        dPNvpzAvhueXGoOleYKZ6KiUrlX/uaZR4VMZfH8=
X-Google-Smtp-Source: AGHT+IFAorIYFlqYpnj+tRwdDR9uZT7s93L82q01x37sDXsKaFNnqwrpRD7mEGOHYqGzMAIkToanaqYnkRMh1VJl2FU=
X-Received: by 2002:a05:6512:39c4:b0:4fe:1e69:c379 with SMTP id
 k4-20020a05651239c400b004fe1e69c379mr5095918lfu.13.1692283994389; Thu, 17 Aug
 2023 07:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
 <2023081411-apache-tubeless-7bb3@gregkh> <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
 <CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com> <e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch>
In-Reply-To: <e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch>
From:   Michele Dalle Rive <dallerivemichele@gmail.com>
Date:   Thu, 17 Aug 2023 16:53:03 +0200
Message-ID: <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Davide Rovelli <davide.rovelli@usi.ch>,
        rust-for-linux@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 at 23:36, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > There is a long standing tradition in Linux, you don't get a new API
> > > merged without a user.
> >
> > Sorry for not being clear on that.
> >
> > These abstractions are meant to be used by modules: having them, modules
> > can start using the kernel network functionalities through a first, high level
> > interface.
> >
> > Since there is currently no network support in Rust, this patch series
> > represents a first step to provide access to networking to modules.
> > Sockets are just the highest layer of the network stack: the goal would be
> > to port structures deeper in the network stack, to give modules more
> > access to the network api. However, you need to start somewhere.
> >
> > >
> > > There is not too much use of in kernel sockets. Network file systems
> > > like NFS, and SMB are one. These need to be careful with memory usage,
> > > you could be busy writing blocks out because the system is low on
> > > memory and trying to free some up, and asking for more memory might
> > > not work.  Sending kernel log messages to a server. But that needs
> > > care because of the different contexts it can be used in. Without
> > > knowing what it will be used for, it is hard for us the point the
> > > special considerations which need to be made.
> > >
> > > So please also let us see the code using this API.
> > >
> > >         Andrew
> >
> > The lack of these abstractions was noticed in the context of a research
> > of the usability of Rust for the development of consensus algorithms using UDP.
>
> O.K, so what are the use cases for consensus algorithms using UDP
> within the kernel? Where is this code? Ideally you should post it for
> merging alongside the rust API to sockets its needs. We can then
> review both together, just as we would if somebody were submitting a
> new API in C along with its user.
>
>     Andrew

Hello Andrew,
in the last few days, I had the opportunity to discuss with some people from
the RustForLinux community.

I apologize for not being clear: the goal of these APIs was to give some
network support to, in particular, out-of-tree modules; they were not meant to
be used by a specific module that was planned to get upstreamed as well.
The idea behind this patch is that, as of now, Rust is not a viable option for
any OOT module that requires even the highest-level network support.

I am wondering whether the `net` subsystem is interested in reviewing, giving
feedback and eventually accepting code that is currently OOT-only.

Also, it would be interesting if you could provide us any module or
functionality you are planning to get in-tree which might use this interface;
it could be useful in order to understand the applicability of these
abstractions and find a concrete in-kernel use-case.

I included in the email a couple of sample OOT modules that showcase the
functionalities of the socket API; they will be attached as an actual patch if
there will be a v2.

Thank you for your time,
Michele


From 4c966f6ff3acd3b7c27f7a558648722b227d45a7 Mon Sep 17 00:00:00 2001
From: Michele Dalle Rive <dallerivemichele@gmail.com>
Date: Thu, 17 Aug 2023 15:51:47 +0200
Subject: [PATCH] rust: net: add OOT sample modules.

Add two sample modules that showcase some functionalities of the Rust
socket API.

Signed-off-by: Michele Dalle Rive <dallerivemichele@gmail.com>
---
 samples/rust/rust_socket.rs     | 45 +++++++++++++++++++++++++++++++++
 samples/rust/rust_tcp_server.rs | 34 +++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 samples/rust/rust_socket.rs
 create mode 100644 samples/rust/rust_tcp_server.rs

diff --git a/samples/rust/rust_socket.rs b/samples/rust/rust_socket.rs
new file mode 100644
index 000000000000..fc1ed8536e57
--- /dev/null
+++ b/samples/rust/rust_socket.rs
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust minimal sample.
+
+use core::str::FromStr;
+use kernel::prelude::*;
+use kernel::net::socket::*;
+use kernel::net::ip::IpProtocol;
+use kernel::net::addr::{SocketAddr};
+use kernel::net::AddressFamily;
+use kernel::flag_set;
+
+module! {
+    type: RustSocket,
+    name: "rust_socket",
+    author: "Rust for Linux Contributors",
+    description: "Rust sockets support sample",
+    license: "GPL",
+}
+
+struct RustSocket {}
+
+impl kernel::Module for RustSocket {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        let sock = Socket::new(AddressFamily::Inet,
SockType::Datagram, IpProtocol::Udp)?;
+        let addr = "0.0.0.0:8000";
+        sock.bind(SocketAddr::from_str(addr)?)?;
+
+        sock.set_option::<opts::sock::ReuseAddr>(true)?;
+
+        assert_eq!(sock.sockname()?, SocketAddr::from_str(addr)?);
+
+        let mut buf = [0; 1024];
+        while let Ok((bytes, msghdr)) = sock.receive_msg(&mut buf,
flag_set!()) {
+            if bytes == 0 {
+                break;
+            }
+            pr_info!("Received {} bytes from {}", bytes,
msghdr.address().unwrap());
+            if msghdr.flags().contains(flags::MessageFlag::Trunc) {
+                pr_info!("The message was truncated");
+            }
+        }
+        Ok(Self{})
+    }
+}
\ No newline at end of file
diff --git a/samples/rust/rust_tcp_server.rs b/samples/rust/rust_tcp_server.rs
new file mode 100644
index 000000000000..987c4c752d2b
--- /dev/null
+++ b/samples/rust/rust_tcp_server.rs
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust echo server sample.
+
+use core::str::FromStr;
+use kernel::prelude::*;
+use kernel::net::tcp::TcpListener;
+use kernel::net::addr::SocketAddr;
+use kernel::flag_set;
+
+module! {
+    type: RustTcpServer,
+    name: "rust_tcp_server",
+    author: "Rust for Linux Contributors",
+    license: "GPL",
+}
+
+struct RustTcpServer {}
+
+impl kernel::Module for RustTcpServer {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        let listener =
TcpListener::new(SocketAddr::from_str("0.0.0.0:8000")?)?;
+        while let Ok(stream) = listener.accept() {
+            let mut buf = [0; 1024];
+            while let Ok(size) = stream.receive(&mut buf, flag_set!()) {
+                if size == 0 {
+                    break;
+                }
+                stream.send(&buf[..size], flag_set!())?;
+            }
+        }
+        Ok(Self {})
+    }
+}
-- 
2.41.0
