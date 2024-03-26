Return-Path: <linux-kernel+bounces-119646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02488CB82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84A81C2A11F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1329980C1F;
	Tue, 26 Mar 2024 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6xoPK3g"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99B482EE;
	Tue, 26 Mar 2024 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476335; cv=none; b=FCFU3uklS1mK/1OMUt41UYzP2I4lVR8OUv8d0tAxeOZNg29JARk9lA0O25yfu1r3vkh05+++ViwcjguUdzxL2V3RYItgKXp1uBgnBkKQbTzFwdGS1J2yqKkJX4ueLWUL55qmmrmAz5T8ITaEQJtAW0fbyLdrYArKmRxY7ECHCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476335; c=relaxed/simple;
	bh=Hv4vka0g3KZRnfDy76dTJ9fCXHDjjTLzWVYBzJ9Zlfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC/PsXza1hion7IcF++K3z1PkSIXOeejsmjq2kuWo7nGzFVTgIU5hLRJ98EdeHiQn/Gswf3uHjStF8BDH07BXMCAI6NbbzYyA8DRIYUEAGx0mBKJnWLKqr9EfLaVHdV5J3SQQ9PL4HDMTrSKJ7HlH5AZiVBQKN5ssUSDOw0GeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6xoPK3g; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-430c4e67d40so38128781cf.3;
        Tue, 26 Mar 2024 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711476332; x=1712081132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZSO9NgzHjU3V7f5NqNNxEr8uk+T/G+ECQGvq3goiMU=;
        b=k6xoPK3gss7+3+8rJ/V0Kzx9ZEy3EmMraJPrRk2mzw1EH+jHAvHLKAzVVafivThZd4
         cBVyeCeMVLz8/jNBekr4KGlbhsbbRlwoqnCuiVv6bMkj3PjLECsc9bCIlm9kXCNGgNGJ
         istXlXuzrSTjt5tVXJNkV0a9Fm5Yf5wOomb7jH5QsB630LZJnyfMdB2W1ZNHqki2i9ck
         pwTOUdPe3pmlYe1x4ORDgqYjIleh4DkqTjcKiKevhB0M9RKYSlUZBaVzxaMGa3ozb9Vt
         CFvLc35Ir6pY1YTZAzuWp494LskUiS1v6ohetj4v5kWXCv+hUxymAZGDqna5n6cbrk3n
         GZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711476332; x=1712081132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZSO9NgzHjU3V7f5NqNNxEr8uk+T/G+ECQGvq3goiMU=;
        b=Huz5Kjraa5Y2r+ndiE41oxxAmic1cMGgOUcyLn2OFpFEMEmid8GjU1cgwsHf3DcMyL
         JthZVQJ+PeC0YXJ1bUqOi5exc2VTCdTbFAMV9kpOTIv1EV8ZltJKYCBGM0ngC9yiqOdk
         v3pTigl5Hr6dmfB7u6r5taz6rrf+oiGJk8o/PcPmeRVCBRvkWF123R7XvS6I/YtNxCXf
         diSCHfPwTiT7roOB2K99OI9yTgaIt4GDviAcKZ6g3qkffO6panQVltsfz7OQj7O+NWP/
         8uAiumYygFX7vj4tHZdPNqDUVcnN9/ea/dlGrOQaahAWfHCEaYxx559ClxHTmWL9jI/G
         7RCg==
X-Forwarded-Encrypted: i=1; AJvYcCWYKx3+Fx18/5sxnezUZLSymYy79XTsPyFMsfJNqiaZoCUE/w3lv21A5ZijYFK63ZJErEFs+pwutwBAyq147GDguBUkC/xUnbbRBWqH
X-Gm-Message-State: AOJu0YzG0A21p34x30MSO9tN4OC8wfONbk5W/kJ4olKnAt2fVvhKnTzv
	eEW1WMeI+nNqGgJVcCzINRk8kgs182GxJo5whbJ3eDZGrPYht2FT
X-Google-Smtp-Source: AGHT+IG8gHA4dkXqWrakr7SeqRSzlyXdkOE2gvjVAiu+TH5/Qlx0bJSYPgcttD13NxcF/jfGxJDJ/w==
X-Received: by 2002:ac8:5886:0:b0:431:3d52:2fdc with SMTP id t6-20020ac85886000000b004313d522fdcmr1670387qta.65.1711476332466;
        Tue, 26 Mar 2024 11:05:32 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id eh15-20020a05622a578f00b004309cd26bedsm3918473qtb.72.2024.03.26.11.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:05:32 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 840031200066;
	Tue, 26 Mar 2024 14:05:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 14:05:31 -0400
X-ME-Sender: <xms:aw4DZlkacnFatkwzA5RkY_rVwFbXZDRlC_HqGKtAKkMrl_8eVvzjSw>
    <xme:aw4DZg1KQ5ECql0RVcLEfLvzMPqkT0UoJSzmiXZWFWQxizqpFYNOXQTm8xsjElXL4
    vdnWzM4Xg_ss_x7zA>
X-ME-Received: <xmr:aw4DZrqNis8bnnnO6laBW1Q98o0vNfDCKBQx9uXSUyw_rnj3P_TSercRp9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:aw4DZlngrhFODrWi-nCoqnMlCBa0w0DFS9eLkDrtofiADq1znlRpfA>
    <xmx:aw4DZj1AVeEVItFqJia_jZQj3JOGmqq1My61UDbxjylf_2vp3JleSA>
    <xmx:aw4DZkvEJSiJjeHE-j6_w0kZm4Ahd2jIUro0dOQy8hHVrP9pYuvfAQ>
    <xmx:aw4DZnWHMXgsXCTGPO_xJEuD6KUxulmGYt9-4C42-0FxJiOtuCYGlQ>
    <xmx:aw4DZn50GFpZ1OGBPHG3IIf3TX-yq7T3r0iqZZdj9OHFKAmXc4zCfyZI3Pc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 14:05:30 -0400 (EDT)
Date: Tue, 26 Mar 2024 11:04:57 -0700
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
	Valentin Obst <kernel@valentinobst.de>,
	Heghedus Razvan <heghedus.razvan@protonmail.com>,
	Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 5/5] rust: time: Add Instant::elapsed() for monotonic
 clocks
Message-ID: <ZgMOSQFZl3Hwev0Z@boqun-archlinux>
References: <20240324223339.971934-1-boqun.feng@gmail.com>
 <20240324223339.971934-6-boqun.feng@gmail.com>
 <kZmwObXVcyEJFVR3I05Nab0WdjcccDVARoOm6U9EmXhd89fxYRjvNmEAUZsueWTUlBlHp8jpU3i2YfgN9aWCLZameta0tPT_OgQdBOWUIko=@proton.me>
 <ZgMNVNOjoLH4S4Fb@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgMNVNOjoLH4S4Fb@boqun-archlinux>

On Tue, Mar 26, 2024 at 11:00:52AM -0700, Boqun Feng wrote:
[...]
> > 
> > Now that I thought a bit more about the design, I think allowing
> > negative durations is a bad idea.
> > Do you disagree?
> > 
> 
> So yes, I don't think allowing negative duration is really good design.
> But as I mentioned in the cover letter, I hope to support cases where:
> 
> 	d = ts2 - ts1;
> 	ts = ts3 + d;
> 
> 	(where ts1, ts2, ts3 is Instant, and d is of course Duration)
> 
> without any branch instruction in the asm code. It's useful in the case

To be accurate, the "ts = ts3 + d" can have (and should have) a branch
to check overflows (and reset to KTIME_MAX if so), but that's the only
branch.

Regards,
Boqun

> where ts1 is a old time base, and ts3 is the new one, and you want to
> "remain" the delta between ts2 and t1 and apply that on ts3. To me there
> are three options to achieve that: 1) allow negative durations (this
> also mirrors what `ktime_t` represents for timedelta AKAIU), 2) have
> a timedelta type that differs from Duration, and it can be negative, 3)
> provide a function to do the above calculation for `Instant`. I choose
> the first one because it's quick and simple (also easy to map to
> `ktime_t`). But I don't have my own preference on these three options.
> 
> Regards,
> Boqun
> 
> > If there is a case where you have a non-monotonic clock, or you are not
> > sure if two timestamps are in the correct relation, we could have a
> > function that returns a `Option<Duration>` or `Result<Duration>`.
> > 
> > -- 
> > Cheers,
> > Benno
> > 
> > > +    /// ```
> > > +    pub fn elapsed(&self) -> Duration {
> > > +        T::now() - *self
> > > +    }
> > > +}
> > > +
> > >  /// Contains the various clock source types available to the kernel.
> > >  pub mod clock {
> > >      use super::*;
> > > --
> > > 2.44.0
> > >

