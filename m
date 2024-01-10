Return-Path: <linux-kernel+bounces-21643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B620829236
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C58E0B25284
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1304D1870;
	Wed, 10 Jan 2024 01:42:01 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BC01375
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [209.85.219.181])
	by gateway (Coremail) with SMTP id _____8AxCurj9Z1lgLEDAA--.7442S3;
	Wed, 10 Jan 2024 09:41:56 +0800 (CST)
Received: from mail-yb1-f181.google.com (unknown [209.85.219.181])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxS9ze9Z1lmvYJAA--.26306S3;
	Wed, 10 Jan 2024 09:41:51 +0800 (CST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbd715ed145so2656931276.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 17:41:51 -0800 (PST)
X-Gm-Message-State: AOJu0Yzg108VXAqfoZwiOleMYrnPqRgtMXnWmfuF3jeVx0r5vCZC562T
	HGa8CB9WFIfGzYicCfQDt4sDQ/Edhenr+4fUN6GEnRXuxnEVmQ==
X-Google-Smtp-Source: AGHT+IFGt23l19RvWe7u/09i6msGSYglWfrLjSgX4g2U8Pt+hIzJyRXUH8Z8WRcK14GmDck2BQKYnlRjXVeZ7mu7+k4=
X-Received: by 2002:a25:730e:0:b0:dbe:5353:3174 with SMTP id
 o14-20020a25730e000000b00dbe53533174mr204149ybc.57.1704850909353; Tue, 09 Jan
 2024 17:41:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108032117.215171-1-wangrui@loongson.cn> <ZZ2fn0scbDKBXWe5@boqun-archlinux>
In-Reply-To: <ZZ2fn0scbDKBXWe5@boqun-archlinux>
From: WANG Rui <wangrui@loongson.cn>
Date: Wed, 10 Jan 2024 09:41:38 +0800
X-Gmail-Original-Message-ID: <CAHirt9iox8FGV2wrMyxwFRjab2avfOcyLKvBc9K=AqiHxqHXKg@mail.gmail.com>
Message-ID: <CAHirt9iox8FGV2wrMyxwFRjab2avfOcyLKvBc9K=AqiHxqHXKg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Rust enablement for LoongArch
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:AQAAf8DxS9ze9Z1lmvYJAA--.26306S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF1fCrW8CFWUGw45WFy5Jrc_yoW8Gw1Dpa
	y29F1Ykr4kGr1xGrsavw1UWFn8Aw1fKrWxXw1rt34xKr4rArn7ZrW7KrWfWFyDZrW8AFWj
	vF4F9w13tF4UAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUP529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jwtxhUUUUU=

Hi Boqun,

On Wed, Jan 10, 2024 at 3:35=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Hi,
>
> Thanks for the patch.
>
> On Mon, Jan 08, 2024 at 11:21:15AM +0800, WANG Rui wrote:
> > Enable Rust support for the LoongArch architecture.
> >
>
> Could you share how you build and test? For example, I wonder the clang
> or gcc version you used and bindgen version you used. Thanks.

You are welcome! The versions I'm using are listed in
scripts/min-tool-version.sh, and I have tested Rust samples and the
rnull block driver.

llvm: main branch (ea3c7b3397f8de8e885ea7cd1ed5138ec4a72d50)
rustc: 1.74.1
bindgen: 0.65.1

Here are the build steps:

1. Build llvm
2. Install rust, rust-src (using rustup) and bindgen
3. Build kernel

For more details, refer to Documentation/rust/quick-start.rst; there
is nothing special about it.

Regards,
Rui

>
> Regards,
> Boqun
>
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
>


