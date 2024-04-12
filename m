Return-Path: <linux-kernel+bounces-142710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4F68A2F39
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E988B22B28
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9974B8248B;
	Fri, 12 Apr 2024 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKfQHbSX"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE79823DD;
	Fri, 12 Apr 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927920; cv=none; b=W1O/7Gaoi9ga5uAJDytiTAkei+EeSs7Q7jc34ocvJy279iV2v/wDiL5AmExPQ0dTxhT2UkTR5Sc87Tw9Om3RN6PUad/+CZMAFtcHwPUqsB1OnAHPyCm6mRjWMF/N2N/uFnDAPsiBD97DOzZQW8muvi3z3v1YIrlybWr4yMyS/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927920; c=relaxed/simple;
	bh=Z9Zr9qGhk68dFbUMGN1jDdvvnvltbx0+U2tX4dpQlec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhC93k8WkMPojCaYQDGNAb4ZkLPsvCBuiv5KEJhS4mM/v7IVJqRCneScDS1UbJn4wFUUiaRfyrk5TiZ7s1CazTs3KueKG5MiWY429hi1VBL/D+mcCz1l0mnYitiUQoTrXvVnvjSZLawZUBKrcpu7SgD15Q2HYKlJYJcriLtJ3vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKfQHbSX; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6964b1c529cso6382986d6.0;
        Fri, 12 Apr 2024 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712927918; x=1713532718; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rSNuM2Kf5MYQqfZJieIp/X2StUo6oV+qQVXx+kHA/pw=;
        b=SKfQHbSXdgVHzabpe54wcNaifsvR/IUR1CUQwVLiW2vupZSLvhZW9EF5KwgU3peh1y
         AoSJQ9OdYR19JWKxMtKr8Xys+btn44xh40AFMcSFRG6e/L9Tb29snWD510g6euhoQMkG
         VacTNHcbVl0kkK5B+US66ByN37/SlKfuOHzokruY1zBABXnBB4geUOtwgs3Rh6uVBH5a
         iFhdcqauJYDke6Ndg1Xgcslhkf4RWYsUwlmilOBI0tyvdcyVy7zUjj8z6Iih8kyUrq42
         wInI3foYX7Gf90w1gnHpJsyxdwNNosVYPG4LUwsO/72CFLC8KuYXR/gH91Q6s53l9LDO
         SnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927918; x=1713532718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSNuM2Kf5MYQqfZJieIp/X2StUo6oV+qQVXx+kHA/pw=;
        b=dsXYQSATmNliqB49SFrH3daKQc7jIkMyRBNLedirD/l4MJ23jer4mognO7Z9RtQUOE
         R/87CRuRuNdVsZEoiVAWiUlmQKoAYG4FS98V75jG0dRpGpWnrw8qt353Cj/B9LHCI6rC
         xljV9bD6T2XT3xnKSsG9oRA19f2WlA4QYiMOzHJLbyiJtFF7NN6Hc27K5Yxz82ypA1i5
         X9TkEcyFBasm91YxLeX0Quu8V3bMZmpSNcsQsHj9tjd6o01zM0PpZnnRavcpWX4yTBf9
         FuELpJ8p7xuDmHTR153kb3NME4BUyUfnYCj1BkJVdi/UAd5ega6IDaqC8kbB5YuyJRVo
         fQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXamTo9cvYOT0GIrydOnMjZ1+jbGWnu8/c/vpagO+xm6Ypq6aYmPntwMebpvRPGgFdmPnjY11KQdwW1Wr2ySUlIfl+PYKeIcmf+7Zx7AcRR+OWUn7wUms4WiiEIJW3ycuNRTMxFKw902NDz7l4=
X-Gm-Message-State: AOJu0Yym0x0za5JEMiEqpC690v3szwhLUG4VYln7fqf+nqwnu8Hh5hV8
	GE3oa1fENDVnPv2U0DFyA7s78ybga8NQ8xxznUoa/4eceDwIkjH9
X-Google-Smtp-Source: AGHT+IHZ/eq/CxIM+mg36xmxu8syXIoS3NwfCHd6hxjId2jrSd92vjK0q6Ytk+uO46AGtE233+1LZw==
X-Received: by 2002:a05:6214:3211:b0:69b:54b2:1add with SMTP id qj17-20020a056214321100b0069b54b21addmr3569891qvb.50.1712927918431;
        Fri, 12 Apr 2024 06:18:38 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id f15-20020a0cc30f000000b0069b114bcb2esm2311628qvi.46.2024.04.12.06.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 06:18:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 47B5B1200043;
	Fri, 12 Apr 2024 09:18:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 12 Apr 2024 09:18:37 -0400
X-ME-Sender: <xms:rTQZZqur1yTLEbv6tcy8wGRvSiwvVf5StIWvInqW60lycuBw7-POUw>
    <xme:rTQZZvfVqUen-Fdv5_qZqYhbajdVLPg5X-px0L96lj7eE56S2Hac5Ggew_y5ADrpu
    UgD35g3_ARGdT4SMQ>
X-ME-Received: <xmr:rTQZZlxcoILYCcbzV-JJHgWvU7USw1xspDSJkOq0IBdxHMmq1Pp7lGwZoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:rTQZZlNn9eIAtGI0gvvrkQNUgg3MvYnUMSqyVkAq9olblASxyDIsHg>
    <xmx:rTQZZq9UGZSc529Jm5gC8ZjXz_2jDapllLbMjv6egivKcOg_SR0KkQ>
    <xmx:rTQZZtXkGCUFIICrqVXm7pbMJAudvJjMUK5XjCX6ESFw-SLSMGHdKA>
    <xmx:rTQZZjdeKkZLElPxs02S1d64-91el3XxZWvgPtlr3nJhsGLML--a-g>
    <xmx:rTQZZkdUFIbfqP2OAp22bPdl1zEpEtjIVCGU8czGP81upjNDcis_NWFF>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 09:18:36 -0400 (EDT)
Date: Fri, 12 Apr 2024 06:18:35 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
Message-ID: <Zhk0q-0eM4z5JHqn@Boquns-Mac-mini.home>
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
 <20240411230801.1504496-3-boqun.feng@gmail.com>
 <CAH5fLgg0CkZO9KF58boui6Y5ajpXHuGh0OxyNru2aEG5pNObwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgg0CkZO9KF58boui6Y5ajpXHuGh0OxyNru2aEG5pNObwQ@mail.gmail.com>

On Fri, Apr 12, 2024 at 10:36:05AM +0200, Alice Ryhl wrote:
> On Fri, Apr 12, 2024 at 1:08 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Currently since Rust code is compiled with "-Coverflow-checks=y", so a
> > normal substraction may be compiled as an overflow checking and panic
> > if overflow happens:
> >
> >         subq    %rsi, %rdi
> >         jo      .LBB0_2
> >         movq    %rdi, %rax
> >         retq
> > .LBB0_2:
> >         pushq   %rax
> >         leaq    str.0(%rip), %rdi
> >         leaq    .L__unnamed_1(%rip), %rdx
> >         movl    $33, %esi
> >         callq   *core::panicking::panic::h59297120e85ea178@GOTPCREL(%rip)
> >
> > although overflow detection is nice to have, however this makes
> > `Ktime::sub()` behave differently than `ktime_sub()`, moreover it's not
> > clear that the overflow checking is helpful, since for example, the
> > current binder usage[1] doesn't have the checking.
> 
> I don't think this is a good idea at all. Any code that triggers an
> overflow in Ktime::sub is wrong, and anyone who enables
> CONFIG_RUST_OVERFLOW_CHECKS does so because they want such bugs to be
> caught. You may have been able to find one example of a subtraction
> that doesn't have a risk of overflow, but overflow bugs really do

The point is you won't panic the kernel because of an overflow. I
agree that overflow is something we want to catch, but currently
ktime_t doesn't panic if overflow happens.

Regards,
Boqun

> happen in the real world. I have seen real examples of bugs in Rust
> code, where overflow checks were the reason the bug was not a security
> vulnerability.
> 
> > Therefore make `Ktime::sub()` have the same semantics as `ktime_sub()`:
> > overflow behaves like 2s-complement wrapping sub.
> 
> From Miguel's reply, it sounds like 2s-complement wrapping is not even
> the semantics of ktime_sub. The semantics are just UB.
> 
> Alice

