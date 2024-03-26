Return-Path: <linux-kernel+bounces-119577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D284A88CAA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1045DB265B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B161CF8F;
	Tue, 26 Mar 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhtthlM9"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA671C6B0;
	Tue, 26 Mar 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473721; cv=none; b=pZWhtrWJS6mNechfSM7/672boc9CAdKClMxU61Z6DiqFDFwZwQ3DmiZRER8RqHl2slzZ+ANusPtjZ+T3XdkJa3ZWOXkO25v+UmBKeuy1ZCRnFf4o3QGcrCuXUyTm8ywwb1tPaABQN2vpGtklb/bwAo9jTLpWQg45BwzYirepzd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473721; c=relaxed/simple;
	bh=jZd3DMYTrkPjgcF+GXb0XDthojSFtmH0ibUcyxTWHgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snF8vsuxekFQR7TjUodmvzzJMWrhiNYJVzJI+SW6NUEktP5g8cn8Fjiyl+cdZDxe9i41H9EFzSE3MtAx8F1pr3V1Ic94xb2LvgYUZ70IyoaSkPW1sitzThJLdWlSbFt4qQHWH3LRPpVc3rZ4IMl78uGmjuVrVkn34VhEhZu0z3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhtthlM9; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-789db917876so351186285a.1;
        Tue, 26 Mar 2024 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711473719; x=1712078519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7T5hEhkUDazJ47kggL6Q/TiVuUfZy8/rH8kDSRQfdQM=;
        b=BhtthlM9bFY0vBOiLrF4eyxTrmb8l8V0AnhjaCENBIkCfmjQ1lxZvhkc8yaZXPauHA
         JhIzfG48RqvECKlNPG94CXXU8BAi0IqhGTlWd8n9LlrW6f+cDmX4jq4f4z+WTy5tJ8DW
         TYkBlfKMGdkvDLTFr2Eq/coBguHA+Ojez0VJuthMz8IgU1RuJgMdQtETQD0amaA4+Hd0
         jhXFLLh/ymKCUGLKc7vsawOLLAzQ/E4lGWl6UOx3rccqN48aNfag2t3anSm6FZed2A9o
         ZFigZ+Im+/BrG20iO8Ug47vgj770XEFRs+cUEFzsL4m8zF8y/hJ9R5jzg2WtkSgJPmwp
         Qo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711473719; x=1712078519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7T5hEhkUDazJ47kggL6Q/TiVuUfZy8/rH8kDSRQfdQM=;
        b=U5avNB5vmvQLsccnF6ZJ+F6dR5nT8cbj/a6MKlNo7mO7FUu1/oYIBWXK6/pXEWbP8s
         cc6DUYkAnwWcMM9aUXofe7xCysI1brSxD2e2DpRZ6GZH7IH+W9Aut+55OB46aRZHxeuf
         MBVRFp2+9iMu5OXWOpw9kAMWEkIIaD1SjcN62ABpv6R0omeKu2NL6rVIsIsBUeF/A3GG
         7U8iR8yyzXVwMAsXtQbUlqSoVHuZ8n6RfBZYFGuWhy3ZBQrpSQgiwJHisXpl05P8HUNo
         tAX5x7fhMNTG6K9yGsI6lMOrkXsXOH+pyaefedpc9E5VeCMvGssbTnnynzJChhEl00cs
         Nchw==
X-Forwarded-Encrypted: i=1; AJvYcCX+KpG1HlkdsYPmGeJit/5WsM+e9Jnq1OFC2xxtsLE/XEYp4e4Zy0UUuZ/cYs6Eu1CGQsvnpxOlMhlcKDZikj6fIzWgfhItdgUxQdwr
X-Gm-Message-State: AOJu0YzFeq4J/bu3vbp6OX5vP1mLzl+SFZdC5kRd2xweuOh410BbFQsG
	L0vpDBScOYIxj2VCd62QhRt8Mpw0dXT9h43/AKKh9cnJ5prP2aRc
X-Google-Smtp-Source: AGHT+IHCXG3xzMmTxa1DKywKi/TlD+cjAa+sCSpdtV87oMnu6QfzR/ctvgMOWc4Gnxx9Tm2lFypRmQ==
X-Received: by 2002:ae9:f714:0:b0:78a:2900:418e with SMTP id s20-20020ae9f714000000b0078a2900418emr1875997qkg.60.1711473718776;
        Tue, 26 Mar 2024 10:21:58 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id z22-20020ae9c116000000b0078a68410731sm415879qki.25.2024.03.26.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:21:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 82FE71200074;
	Tue, 26 Mar 2024 13:17:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 13:17:47 -0400
X-ME-Sender: <xms:OwMDZhf4NHW2bPRgdqYgkYnpi9VUXwdo3aonn5pXf16BIqGgiLkWew>
    <xme:OwMDZvNnnG3QsB03Z1_5315VZz2dXn4xqrKy81PCULIbMnr20BmIvczZQUOYHXhaa
    4dZMFlCHMditpspDQ>
X-ME-Received: <xmr:OwMDZqjsYLYXwNwBAglwBsyW-y4ZYALaEvbOYlQvvJbNNAMg1uvEY3hycTqv9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:OwMDZq8fp9u8t8n2pUdXNVvl0DFquFdAT7-UtY7LtZyPZPKyWDCl3w>
    <xmx:OwMDZtt7N-D2WskEQ2GtlkJO80VYP_f5W_QHK1hPFNciwsnnucjS2g>
    <xmx:OwMDZpEasenjjFejRwZKKT3HsNk8f146m-6Ks22DCYvZ1Tqzoec0bQ>
    <xmx:OwMDZkMnkEzL7nLxu322eP9bmJpOi9FdUGVtpyZaJag6x4NRBiBQxw>
    <xmx:OwMDZtPvLxTyr19lAIPRkHuMbDMCFNe3XXl_t0DDSfeMRTcWXq1gbDvSpRc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 13:17:46 -0400 (EDT)
Date: Tue, 26 Mar 2024 10:17:13 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH 2/5] rust: time: Introduce Duration type
Message-ID: <ZgMDGYMj7V50PZbP@boqun-archlinux>
References: <20240324223339.971934-1-boqun.feng@gmail.com>
 <20240324223339.971934-3-boqun.feng@gmail.com>
 <4hYJbftgOk1JOPbJ6CfKZell6ngp8GljwIUIB1vOQvIf-7jiogG5xDtCvcMlF7cIJAdy9fO5HLQh_8ohnWNB3MAaj0xjAGeyyDowemgunOU=@proton.me>
 <ZgMBqzv0r98_EGGR@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgMBqzv0r98_EGGR@boqun-archlinux>

On Tue, Mar 26, 2024 at 10:11:07AM -0700, Boqun Feng wrote:
[...]
> > > +impl Duration {
> > > +    /// Creates a new duration of `ns` nanoseconds.
> > > +    pub const fn new(ns: i64) -> Self {
> > > +        Self { inner: ns }
> > > +    }
> > > +
> > > +    /// Divides the number of nanoseconds by a compile-time constant.
> > > +    #[inline]
> > > +    fn divns_constant<const DIV: i64>(self) -> i64 {
> > > +        self.to_ns() / DIV
> > > +    }
> > 
> > I am a bit confused, why is this better than writing
> > `self.to_ns() / DIV` at the callsite?
> > 
> 
> Hmm.. you're right, there should be no difference I think. If there is
> nothing I'm missing from Alice, I will drop this function in the next
> version.
> 

On a second thought, I think this prevents accidentally divide a
non-const value, in other words, if you use this function, you're
guaranteed the divisor is a constant, and you have the compiler checking
that for you. So in that sense, I think it makes sense to remain it
here. Thoughts?

Regards,
Boqun

> Regards,
> Boqun
> 
> > -- 
> > Cheers,
> > Benno
> > 
> > > +
> > > +    /// Returns the number of milliseconds.
> > > +    #[inline]
> > > +    pub fn to_ms(self) -> i64 {
> > > +        self.divns_constant::<NSEC_PER_MSEC>()
> > > +    }
> > > +
> > > +    /// Returns the number of nanoseconds.
> > > +    #[inline]
> > > +    pub fn to_ns(self) -> i64 {
> > > +        self.inner
> > > +    }
> > > +}
> > > --
> > > 2.44.0
> > >

