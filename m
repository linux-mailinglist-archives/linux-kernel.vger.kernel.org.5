Return-Path: <linux-kernel+bounces-21660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFEC829286
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC06D1F26C20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808826117;
	Wed, 10 Jan 2024 02:49:48 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390B04689
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [209.85.219.174])
	by gateway (Coremail) with SMTP id _____8BxHLsPAZ5lYLQDAA--.3203S3;
	Wed, 10 Jan 2024 10:29:35 +0800 (CST)
Received: from mail-yb1-f174.google.com (unknown [209.85.219.174])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Axqt0MAZ5lQwgKAA--.26941S3;
	Wed, 10 Jan 2024 10:29:34 +0800 (CST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbd715ed145so2676749276.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 18:29:34 -0800 (PST)
X-Gm-Message-State: AOJu0YwLSgqU839JRqu+XGqh0shyjcpxQVhiHZZeOj1kwriIKtzuNwm9
	H1uPfS1h396akX7NI5+PX8G7yG2PeF7yKI0ChBSrGAppN/iw3A==
X-Google-Smtp-Source: AGHT+IGFu70ifP6sZpWVKvAz9jkvhFQs0aK9sfB9mzmNZLo6qnO/qlrCw7c+TfeqTmvh2JMP1DwvoCXJuMWwzU2xTgI=
X-Received: by 2002:a05:6902:351:b0:dbd:5b5e:820b with SMTP id
 e17-20020a056902035100b00dbd5b5e820bmr195849ybs.98.1704853772254; Tue, 09 Jan
 2024 18:29:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108032117.215171-1-wangrui@loongson.cn> <ZZ2fn0scbDKBXWe5@boqun-archlinux>
 <CAHirt9iox8FGV2wrMyxwFRjab2avfOcyLKvBc9K=AqiHxqHXKg@mail.gmail.com> <ZZ38XMQw18mw2sTA@Boquns-Mac-mini.home>
In-Reply-To: <ZZ38XMQw18mw2sTA@Boquns-Mac-mini.home>
From: WANG Rui <wangrui@loongson.cn>
Date: Wed, 10 Jan 2024 10:29:21 +0800
X-Gmail-Original-Message-ID: <CAHirt9jQSVvBF=1wc=sT9FxngeSP30P4FDpu8m0JH_0fOPSO-w@mail.gmail.com>
Message-ID: <CAHirt9jQSVvBF=1wc=sT9FxngeSP30P4FDpu8m0JH_0fOPSO-w@mail.gmail.com>
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
X-CM-TRANSID:AQAAf8Axqt0MAZ5lQwgKAA--.26941S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFW3tF4xtr43Jw1xZw1kWFX_yoW8urW3p3
	y7ZFn0kr4kGr13Jrna9w15WF1Yyw1fKr97X3WDJryxKr90yr1qyrWxtrW3Wa4DZry8CFW0
	vr1Uu3ZxJF1UAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU70Pf
	DUUUU
X-Gw-Check: e078b1bea2556669

On Wed, Jan 10, 2024 at 10:09=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> On Wed, Jan 10, 2024 at 09:41:38AM +0800, WANG Rui wrote:
> > Hi Boqun,
> >
> > On Wed, Jan 10, 2024 at 3:35=E2=80=AFAM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > Hi,
> > >
> > > Thanks for the patch.
> > >
> > > On Mon, Jan 08, 2024 at 11:21:15AM +0800, WANG Rui wrote:
> > > > Enable Rust support for the LoongArch architecture.
> > > >
> > >
> > > Could you share how you build and test? For example, I wonder the cla=
ng
> > > or gcc version you used and bindgen version you used. Thanks.
> >
> > You are welcome! The versions I'm using are listed in
> > scripts/min-tool-version.sh, and I have tested Rust samples and the
> > rnull block driver.
> >
> > llvm: main branch (ea3c7b3397f8de8e885ea7cd1ed5138ec4a72d50)
>
> This means the LLVM support is yet to release? Or does LLVM 17 also
> work?

LLVM 17 doesn't work. The minimum LLVM version required for LoongArch
is 18.0.0. This is the reason why we have updated the
scripts/min-tool-version.sh. [1]

[1] https://lore.kernel.org/loongarch/20240108033138.217032-1-wangrui@loong=
son.cn/

Regards,
Rui

>
> Regards,
> Boqun
>
> > rustc: 1.74.1
> > bindgen: 0.65.1
> >
> > Here are the build steps:
> >
> > 1. Build llvm
> > 2. Install rust, rust-src (using rustup) and bindgen
> > 3. Build kernel
> >
> > For more details, refer to Documentation/rust/quick-start.rst; there
> > is nothing special about it.
> >
> > Regards,
> > Rui
> >
> > >
> > > Regards,
> > > Boqun
> > >
> > > > Previous versions:
> > > > v0: https://lore.kernel.org/loongarch/20240106065941.180796-1-wangr=
ui@loongson.cn/
> > > >
> > > > Changes in v1:
> > > >  - Address htmldocs warning.
> > > >
> > > > WANG Rui (2):
> > > >   Documentation: rust: Add a character to the first column
> > > >   LoongArch: Enable initial Rust support
> > > >
> > > >  Documentation/rust/arch-support.rst | 13 +++++++------
> > > >  arch/loongarch/Kconfig              |  1 +
> > > >  arch/loongarch/Makefile             |  3 +++
> > > >  scripts/generate_rust_target.rs     | 10 ++++++++++
> > > >  4 files changed, 21 insertions(+), 6 deletions(-)
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > >
> >
>


--=20
WANG Rui


