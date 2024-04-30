Return-Path: <linux-kernel+bounces-164241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E58B7B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9272E1F23BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF802143732;
	Tue, 30 Apr 2024 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaLh7vrw"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92CB152799;
	Tue, 30 Apr 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490247; cv=none; b=qLkYF2S/lnhsz50UCE7sQ7yxxbYaaL96nZ91WHQ3h8qB61hGwZx27K6bwQ1OA13kpQ/36cm11XnZe/rqck7SzL+cGaNwzosJJsgclFdQaX0rfRZYEvlmsj+deCPkNbHIB+gNp0yAA1YjgIxSHNyzoJMTg15HvV++Tg+XH05fVL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490247; c=relaxed/simple;
	bh=kWp1Z0MGrG5ywNgdIVA70qKym3MH/fgTkmEAdT1eZ8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEFEvJgbTn2GKBLX2guXcMZnw8jAQu7bgCgpXkN5//dva5p+jPx8viLYuMh7nHwT9Ko+Mpb6XmeTmrCQZpvrHPk2yU5RCB4u12Z9dqhhF2itYiIUbbtkQeVHF4TUIeZASWhCC9Hq+SuuqjRBLSQaAE1+lVxLLB74fLM/16yrN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaLh7vrw; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-790fb9d1b55so161812885a.3;
        Tue, 30 Apr 2024 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714490244; x=1715095044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idAHpuNGr09iY0JVj3Uq2+CukRYw2YB03EpKFunXlK4=;
        b=MaLh7vrwgJxNn+2mdQfqBdkwtfa/jHeIsnOBJsEZmyw8azW/jicBmoGnZDgSyhCgCo
         sR0Rx1ntNs0NdCm4RGs7QR2jwwhCZS06Da1sZCwPJzscIZ2ZqtJxm7eX+K++QjZpjsc2
         ZDYHEJUPLtepX/OiCVEQdtjeV1rCcwIYgmIrnP7g4izrUX1WZVjJyd+3b98euj0HhQlg
         M9KDVzm/1ZotZjcqmJ5TorTpAY+b+BffKWULxAfCHbLio1DqIcfef17jOZMHDOcl9Msr
         xUIHRhxopbUpx+PDVpw+w3uyxEuKkNM1itVd0+3fPlRHUcJwYteCOVTZxHHSk14NEmPM
         pTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490244; x=1715095044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idAHpuNGr09iY0JVj3Uq2+CukRYw2YB03EpKFunXlK4=;
        b=TGu6yaPoRLBBaLFI/O9/u0BmUztCd/6KZEqXbziMIo9K/lTKnaDLpXrnUe5HIITI7l
         MtqVVK0IKua/w3ab1NbSKqyOMPEKH0mm0y3KXJHMTuhgZnVVVniVtvvdlTzqayOJ9hHX
         gNeR0k0xSlQja2IQ2+z4y0+oPDBX1wI4royMaSHzc9jn4K6mvPX6P31Y1ZIl7V25nRAb
         DCHauY62sXW2uXD1BcVDybwbVMU6THqMEv9PUbeBQM4ZfjXg7Z2XncoZ72fVM8sCHPAX
         FAIFOKacIMkwwzQihGWogUXNY1EUdspY8yNESqPrKHgHEVlauHlZy0xo1MCX8OeGb+/J
         xtvA==
X-Forwarded-Encrypted: i=1; AJvYcCUCF/CszOtq6aAJAD+xButGFBQq3PM/ULubj4dz0ssVWbXoc45r9Ax9K0eAP1e+VtVGcCWpgW0T4n2ml1a8K6C4PsslfXruaJKWDSIWjQ22YWs1DtjXXEPzUuFvSo+wrIXkh+4Ow0WEneSg9tU=
X-Gm-Message-State: AOJu0Yx2nVD+zBWwi+ZpSDKScUGo8sU0CorJpzIbLK4hlbqJLHJBI0GR
	7ipNwGymfXcCmQ0naMow/sKHphkpuzoRY/3bBevzgiCLFQeQP4Md
X-Google-Smtp-Source: AGHT+IFkQHxFGx1xKXoEXkVaYL+KrFmPigSsiGXUCXRCmlINoIoDDmUg4obo223OtVlntao+/rurmQ==
X-Received: by 2002:a05:6214:2404:b0:6a0:cd1b:9f9f with SMTP id fv4-20020a056214240400b006a0cd1b9f9fmr3369680qvb.38.1714490244493;
        Tue, 30 Apr 2024 08:17:24 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id e13-20020a056214110d00b006a0cc5fc18bsm2159284qvs.14.2024.04.30.08.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:17:23 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 240111200066;
	Tue, 30 Apr 2024 11:17:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Apr 2024 11:17:23 -0400
X-ME-Sender: <xms:ggsxZjsnhboHJZF8IEWCQR1gKRWphS_8WHSBZDMkr-twU3pQdRbkMg>
    <xme:ggsxZkfSSqgwhHDvjNSvjj-Rb33JqUnVtAxI7Ra67B2MUoZNI1ACTcH-7utA6jKBs
    BqSaA_RB0RdYH-moA>
X-ME-Received: <xmr:ggsxZmyqm0NhkZnKPeHPPslxdlZVtxqkcjn1TUu139iH3mKvq1OL46wNVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ggsxZiME2KwjbRVtB31Z9kdQNVGleUPVstOKIhqE-cwgSPJ1Cgtqdg>
    <xmx:ggsxZj_5OBIrt79Ke00r-XZBmPoHH1AXmFO4x2b4kRe0gWLLF1dMMQ>
    <xmx:ggsxZiVWK9u-RJREGqYmBqv8EpLwMozcQAPMl8UYYxtkdrWRyTI0Jg>
    <xmx:ggsxZkd9kjPzmLNR4GlYeIeGgujP0kdCR0XJRxvc5VBoGcuNurtfcw>
    <xmx:gwsxZhfuEapja9mvsQzYxTEPvuMbKcL2ljNcdaj3u12DGeca2w0HPaqd>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 11:17:22 -0400 (EDT)
Date: Tue, 30 Apr 2024 08:17:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: hrtimer: introduce hrtimer support
Message-ID: <ZjELgVzzX4oru0gi@Boquns-Mac-mini.home>
References: <20240425094634.262674-1-nmi@metaspace.dk>
 <a7a560c7-fb8c-4adf-9f46-2e272f24b335@proton.me>
 <87v844lbhm.fsf@metaspace.dk>
 <Zi_Zb1lBOBBUFJFV@boqun-archlinux>
 <87plu7jahd.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plu7jahd.fsf@metaspace.dk>

On Tue, Apr 30, 2024 at 02:33:50PM +0200, Andreas Hindborg wrote:
[...]
> >
> > Could you see if you can replace this with a `SpinLock<bool>` +
> > `CondVar`? We shouldn't use Rust atomic in kernel now. I know it's
> > unfortunate that LKMM atomics are still work in process, but in real
> > world, you won't do busy waiting for a timer to fire, so a
> > `CondVar::wait` is better for example purpose.
> 
> Since this is only using the atomic from Rust code, it should be fine
> right? There is no mixing of memory models on this memory location.
> 

It's better compared to mixing accesses on a same location, but it's
still not allowed (for now, at least) to avoid mixing memory models on
ordering guarantees, for example:

(assume all memory location is initialized as 0)

	CPU 0				CPU 1
	-----				-----
	x.store(1, RELAXED); // Rust native atomic
	smp_store_release(&y, 1); // LKMM atomic
					let r0 = smp_load_acquire(&y);
					let r1 = x.load(RELAXED);

The smp_store_release() and smp_load_acquire() pairs per LKMM, and
provide certain rel-acq ordering. But to make it (r0 == 1 && r1 == 0),
C11 memory model needs to understand this sort of orderings, but
currently there is no such thing as an "external ordering" to C11 memory
model.

I admit this is much of a theorical concern for code reasoning, in real
world, it must "just work", but "if you want to have fun, start with
one" ;-)

Regards,
Boqun

