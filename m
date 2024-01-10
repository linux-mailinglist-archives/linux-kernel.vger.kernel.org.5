Return-Path: <linux-kernel+bounces-21648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23628829255
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CE61F2762F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91588210B;
	Wed, 10 Jan 2024 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH6rN1F3"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805C15C0;
	Wed, 10 Jan 2024 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-680a9796b38so25969506d6.0;
        Tue, 09 Jan 2024 18:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704852576; x=1705457376; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l/n+fptsND7yVOrUC6m2sodqqv1jzoc1voLAHrh9SZA=;
        b=JH6rN1F3Fg0bj0kIH4lI6bA+LCGIR4nHHbez7IfiwNnJZOwMtHWqFNTRAEoWaGbwnb
         BsMPnU4ZTDk5TZHs2zThqkm8SSzEwT+P0Q5rOh9ODae/cj4oV1IoCkMwW5d9NlG4/Fo8
         HWbE0M5lQCBG6H88NwKrXXLuuVIJG7n3yE0yi6acL4LA/Xi3/joEziAMZD8LWoSye+jL
         fEimbWyE9HlGYyxgkD0t5lclG7aIvcLyrarQUjAxpvb0XxRl/Vi/WWkzvez4Zx9YTUg3
         yN1jq1zrbSNwfWliIzWHru8+V0zsv3bHOR0fs5yQbaUpAmIN9Una4+Lr3Q6DF9sWeYxO
         I/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704852576; x=1705457376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/n+fptsND7yVOrUC6m2sodqqv1jzoc1voLAHrh9SZA=;
        b=ciVAq64tJ07UtHq7Qulw146ejp78EYVUsBV0paX+DgGkhFkyZCgFzhw9bs8T1nfrs3
         WLA50QBVncwnT1XPab1NwF3rE9WfGvQWIMa+s1uIZITNxr2CGBBoTUbkqKqMTL5QJyVn
         1Aaqm84F0w7cyphvhAunf9Uj6/YLae+lUeUW5yG+g1ObCra9VQ3QomTh/cObY8ANBCo2
         AVkTQ+Zi4pW+jF1duk7xvgGDJtPpw1IX5jmE3hZ/L9u4Rs1cwhjGv3TUaFg+xq2XhfVe
         9ZdUUZyr0YJA8XPU0b/JCYogeA3qxxOIpc2s7LFk7KxZHIth34Z3BuQDELDeP+0+GhAS
         pNMA==
X-Gm-Message-State: AOJu0YxFiPspt5HETxZTjrVXwkWf6IuDOKam+O/iqYRygibrBMgPPtZa
	Q7i8avvo+2nipiqZ1IHUG7E=
X-Google-Smtp-Source: AGHT+IEdjG/Cj5CKMLDag0lY9TTm9FpJagOtbf2RBcN/eNOu3Bn56uDhD6bksZ99efhDW3CVaJyWGg==
X-Received: by 2002:a05:6214:19c4:b0:67f:3d91:cfcc with SMTP id j4-20020a05621419c400b0067f3d91cfccmr576697qvc.15.1704852576213;
        Tue, 09 Jan 2024 18:09:36 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i11-20020a0cfccb000000b006810b63d26fsm1367562qvq.59.2024.01.09.18.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 18:09:35 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 2D03827C005A;
	Tue,  9 Jan 2024 21:09:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 09 Jan 2024 21:09:35 -0500
X-ME-Sender: <xms:XvydZdET9CiFJbOTafIypuKecB2NKE1ZxZbyg7i8rLwBWf2sclJIng>
    <xme:XvydZSVSXITd4rTM7ils_d3vj9LumrY6vEqIjxL80L9RR_MJU4Hc2x1siMrYRPyGQ
    GPZPokUNUT7QaXElQ>
X-ME-Received: <xmr:XvydZfKPmBScn4MVoVGrlzVqpBwxL4MUkTzaMTaVYpxclyM37SqCBj4grA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepjefhieekkeffjeeggeeuvefftdegfeduteelgeejledvffetiefhleef
    hedvgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:XvydZTEiRKphxOx8jLI9R0tBS1EUcKUHi8phiV3pn1aRusk8G-H6_g>
    <xmx:XvydZTVZKvWO0jR0Y1o4u7NWPSH4Bh3KdBkPLHHzgSkmNXa5aZpRxg>
    <xmx:XvydZeM18CKdFINZemvsbNBEun3c3d1-Kguy47vscsSFIuOMkZB-xA>
    <xmx:X_ydZXkoqquEm_A4UQUEqU867Yh1JkUNgiLF9t2sA6wdYHKItZbbSA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jan 2024 21:09:33 -0500 (EST)
Date: Tue, 9 Jan 2024 18:09:32 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: WANG Rui <wangrui@loongson.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v1 0/2] Rust enablement for LoongArch
Message-ID: <ZZ38XMQw18mw2sTA@Boquns-Mac-mini.home>
References: <20240108032117.215171-1-wangrui@loongson.cn>
 <ZZ2fn0scbDKBXWe5@boqun-archlinux>
 <CAHirt9iox8FGV2wrMyxwFRjab2avfOcyLKvBc9K=AqiHxqHXKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHirt9iox8FGV2wrMyxwFRjab2avfOcyLKvBc9K=AqiHxqHXKg@mail.gmail.com>

On Wed, Jan 10, 2024 at 09:41:38AM +0800, WANG Rui wrote:
> Hi Boqun,
> 
> On Wed, Jan 10, 2024 at 3:35 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Hi,
> >
> > Thanks for the patch.
> >
> > On Mon, Jan 08, 2024 at 11:21:15AM +0800, WANG Rui wrote:
> > > Enable Rust support for the LoongArch architecture.
> > >
> >
> > Could you share how you build and test? For example, I wonder the clang
> > or gcc version you used and bindgen version you used. Thanks.
> 
> You are welcome! The versions I'm using are listed in
> scripts/min-tool-version.sh, and I have tested Rust samples and the
> rnull block driver.
> 
> llvm: main branch (ea3c7b3397f8de8e885ea7cd1ed5138ec4a72d50)

This means the LLVM support is yet to release? Or does LLVM 17 also
work?

Regards,
Boqun

> rustc: 1.74.1
> bindgen: 0.65.1
> 
> Here are the build steps:
> 
> 1. Build llvm
> 2. Install rust, rust-src (using rustup) and bindgen
> 3. Build kernel
> 
> For more details, refer to Documentation/rust/quick-start.rst; there
> is nothing special about it.
> 
> Regards,
> Rui
> 
> >
> > Regards,
> > Boqun
> >
> > > Previous versions:
> > > v0: https://lore.kernel.org/loongarch/20240106065941.180796-1-wangrui@loongson.cn/
> > >
> > > Changes in v1:
> > >  - Address htmldocs warning.
> > >
> > > WANG Rui (2):
> > >   Documentation: rust: Add a character to the first column
> > >   LoongArch: Enable initial Rust support
> > >
> > >  Documentation/rust/arch-support.rst | 13 +++++++------
> > >  arch/loongarch/Kconfig              |  1 +
> > >  arch/loongarch/Makefile             |  3 +++
> > >  scripts/generate_rust_target.rs     | 10 ++++++++++
> > >  4 files changed, 21 insertions(+), 6 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> >
> 

