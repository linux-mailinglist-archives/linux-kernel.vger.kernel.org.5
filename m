Return-Path: <linux-kernel+bounces-20690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E6828384
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0677A28692C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684D35EE5;
	Tue,  9 Jan 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY/IpNaR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4E36084;
	Tue,  9 Jan 2024 09:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E2EC43399;
	Tue,  9 Jan 2024 09:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704794075;
	bh=nUyCPiAyC900yjLJBF6FBZMNZjPj9Z7ekOmNLj96sgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FY/IpNaRzfxBGF2r5e7bvVmvFEqGVQfKKkzLjdnlIsB8Y70JU/QWm6862DFrkD4Bu
	 +A927GtZwHQk9M2e9a6zsJYQPQHpncrkSxFjrY+SPEoa9YZzog46jBdJ4sVc9vzT6f
	 DX5tdeemQ7pzuKbje5CcRIcOKmF5YuGv5S2qpA/gsDRGHXjAYHaSKSVLJLu8x4g1Jn
	 a95k9c4+BXrNRM3qFcO9wVYDctiRPYwHJWl2nFTd+j+zgqJMKQjY1c56qRBaBxsnp1
	 VrTw2xHX0wCiZ5n2hGRISQUWivpQfqx7EmB4ee97TsbqhZn/DcUWj81u2KAEo2PeYS
	 oM8+jCK5VuqPA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28b0207c1dso214293466b.3;
        Tue, 09 Jan 2024 01:54:35 -0800 (PST)
X-Gm-Message-State: AOJu0YzxhUMmIQXRva2It4QGbZ6YQ0vkuC1tmipw0iRdGq2imoYBmYKe
	2IAeOFw442WIlGLjUnMVbsSdk+kS6f60mLCCzhQ=
X-Google-Smtp-Source: AGHT+IEvDGvLc6D4bw2e+BJBgBwS2p8x5UT6WM8XEfurhQgq9Bh61t9DsvH6nkZtagTYGgq74PHclQ23T+XHEalQxf8=
X-Received: by 2002:a17:906:225c:b0:a28:fdc0:e704 with SMTP id
 28-20020a170906225c00b00a28fdc0e704mr422802ejr.53.1704794073913; Tue, 09 Jan
 2024 01:54:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108032117.215171-1-wangrui@loongson.cn> <CAAhV-H7qGSiXZFybw20p4inLVphtucUgcvw4H=JkSAfCRoe-sA@mail.gmail.com>
In-Reply-To: <CAAhV-H7qGSiXZFybw20p4inLVphtucUgcvw4H=JkSAfCRoe-sA@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 9 Jan 2024 17:54:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4fUbpvTgFFHnndDk=2-eZbNX=9PxJYV6SWON3barRjiQ@mail.gmail.com>
Message-ID: <CAAhV-H4fUbpvTgFFHnndDk=2-eZbNX=9PxJYV6SWON3barRjiQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Rust enablement for LoongArch
To: WANG Rui <wangrui@loongson.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Squashed and applied, thanks.

Huacai

On Mon, Jan 8, 2024 at 12:23=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> No need to split patches.
>
> Huacai
>
> On Mon, Jan 8, 2024 at 11:21=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wr=
ote:
> >
> > Enable Rust support for the LoongArch architecture.
> >
> > Previous versions:
> > v0: https://lore.kernel.org/loongarch/20240106065941.180796-1-wangrui@l=
oongson.cn/
> >
> > Changes in v1:
> >  - Address htmldocs warning.
> >
> > WANG Rui (2):
> >   Documentation: rust: Add a character to the first column
> >   LoongArch: Enable initial Rust support
> >
> >  Documentation/rust/arch-support.rst | 13 +++++++------
> >  arch/loongarch/Kconfig              |  1 +
> >  arch/loongarch/Makefile             |  3 +++
> >  scripts/generate_rust_target.rs     | 10 ++++++++++
> >  4 files changed, 21 insertions(+), 6 deletions(-)
> >
> > --
> > 2.43.0
> >

