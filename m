Return-Path: <linux-kernel+bounces-25506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B915082D14D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D16B2134F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613683C2D;
	Sun, 14 Jan 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0hdRpNE"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879A23D6;
	Sun, 14 Jan 2024 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e0a89b98e4so1161548a34.1;
        Sun, 14 Jan 2024 07:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705247037; x=1705851837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6fsnynes0vO+z8SDnt6jjjUyKp+VvnkB7fpxe78CwY=;
        b=a0hdRpNEOgp6tfMDBhnZbvIHUpAapuJbdJcEkcxvJWaIJUmF9yAsMxO2HcPi+gB0D2
         /GciiVt/hPb8IackUUHKoRFAVSym90SKt/Lf0Fx9TVv4ZULWgHGmVtWc4LO5YXq88tI0
         bEdO/GCkpzAdmhcjq/lqUiXpg3lZ4FgTUUET6p+5b1XzNvU9IBUG70t6q9Gy1OJyMmS+
         wL582Hl3fLwjv7H60PCxZJKLocZOP6FAR/AtoHdkUeUuNX2TPDNjJnhHnn8QzKCpf+ZB
         3YyRC2eOB6y12VyF+0xTrc+laXSrJt+XW7Vvh3jMY1gt/DC0b/pGAofWnq9gPWLHhbFm
         2qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705247037; x=1705851837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6fsnynes0vO+z8SDnt6jjjUyKp+VvnkB7fpxe78CwY=;
        b=TpsI0zUSaWMjw/JhO6E52QrEB6q3DXUoLHJ9G0+oEMfvfa34/gYVZliDvA+QRoo/Ob
         Q8eu5QMTDK66KdhgskGwbo28dEZ8PvLpvoLccdXLpdnsVS7TlIC/PPVCRuZzap8r0p64
         E+zPaUafzHf9d2KiczaFHjSL9M8fdYLzvtPcg/nYENSS4VSfeq6pNLODpXeDXCTV2gcW
         ZQhm70SIjLOCpI7uDV1UCkO1d+6eWPbuS7VKO1WA+9wNNu34pzkXhS0+14LGwyBQqkwd
         07iKP9DI5LfrjGcfBz4d6O+Ye4F2k2lS1Lck9qU+2/1sNwaZn2/UYX5IBhi1b4B2EdFG
         trHw==
X-Gm-Message-State: AOJu0YylZxXOGhbL4ZbmSCesCiRKCuZY/eePSysBYAzuKnfOJ6w8C/J6
	CBfSXWsjTL9YNsGf1hNdkVV8hOZEuDI5PnyxxXU=
X-Google-Smtp-Source: AGHT+IEBUS1Lk9KquvNh+AEEgwGYDkKmF9ia0vinlcAsqnTVB/V+nqiprHElf2rORE5ktsStx+qC6yV6xTNuDc/rWoc=
X-Received: by 2002:a05:6359:2ea2:b0:175:ca98:881b with SMTP id
 rp34-20020a0563592ea200b00175ca98881bmr2063172rwb.34.1705247037364; Sun, 14
 Jan 2024 07:43:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108032117.215171-1-wangrui@loongson.cn> <ZZ2fn0scbDKBXWe5@boqun-archlinux>
 <CAHirt9iox8FGV2wrMyxwFRjab2avfOcyLKvBc9K=AqiHxqHXKg@mail.gmail.com>
 <ZZ38XMQw18mw2sTA@Boquns-Mac-mini.home> <CAHirt9jQSVvBF=1wc=sT9FxngeSP30P4FDpu8m0JH_0fOPSO-w@mail.gmail.com>
 <CANiq72=X3cggAn0HLMi7jVFAfypBhog=ZkPB57yfaX4ZUzT-HA@mail.gmail.com> <CAHirt9hdtGSsEofxDb0FCtcFeAw9n9LKJALz23Qdqh4n2=Ua5A@mail.gmail.com>
In-Reply-To: <CAHirt9hdtGSsEofxDb0FCtcFeAw9n9LKJALz23Qdqh4n2=Ua5A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 14 Jan 2024 16:43:46 +0100
Message-ID: <CANiq72n7K8LcKrs+beF2sbt1XLdr4zEhEw4xcy3yh4wgTrvYeg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Rust enablement for LoongArch
To: WANG Rui <wangrui@loongson.cn>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:16=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wrot=
e:
>
> 6.8

Thanks, that is quite expedited...

Please `rustfmt` the code to avoid failing the `rustfmtcheck` target.
I see you already created the 6.8 tag but I have not seen it in
linux-next yet and you did not send the PR, so it would be ideal if
you could fix this before it goes to Linus.

diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target=
rs
index 3edda6a10..0da52b548 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -163,10 +163,7 @@ fn main() {
         ts.push("target-pointer-width", "64");
     } else if cfg.has("LOONGARCH") {
         ts.push("arch", "loongarch64");
-        ts.push(
-            "data-layout",
-            "e-m:e-p:64:64-i64:64-i128:128-n64-S128",
-        );
+        ts.push("data-layout", "e-m:e-p:64:64-i64:64-i128:128-n64-S128");
         ts.push("features", "-f,-d");
         ts.push("llvm-target", "loongarch64-linux-gnusf");
         ts.push("llvm-abiname", "lp64s");

Thanks!

Cheers,
Miguel

