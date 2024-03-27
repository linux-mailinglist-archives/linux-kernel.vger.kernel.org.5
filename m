Return-Path: <linux-kernel+bounces-120168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839E388D39D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A296CB2385A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83BA1B966;
	Wed, 27 Mar 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2GiNHXM"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31647FBF3;
	Wed, 27 Mar 2024 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711501777; cv=none; b=FUiyJ1KRF1RvKlgWDRO9PLHHh/4Ct9TLrQ8yha7+V7il0jDgP/qH19sAtC8Ga+Sp40fkO/MHFQSciGRTHMNWblWMRd4lGGuvzKVj6h7/RIwrhUx01jOOpD3LNFtcK4+7nEDnYbCyQXFop+5jvN/U2yW4WfyFfwvV47UgUetuZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711501777; c=relaxed/simple;
	bh=4xJGVsSwc3bYXikj8qE73hqlz4j7RG3Hpke3JHTiY28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBqjjQyGCuEgRT+OlbLjzCwwuzgbDRDxrXA6t9XdUC0KUxBRomo5h6NsG7ikHc8Nlu0Dlh5ouD+4lgbb0sln0V0OvFaa1d/Z2JMNpFaqwV7h5ByM4OBPZCn+KDbSkMet/J0LOC8BOb59ycb93p2haMP0gO6WwDuOKOBf1W8D/8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2GiNHXM; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43143f0ddbcso2982401cf.0;
        Tue, 26 Mar 2024 18:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711501775; x=1712106575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEBSgXro8eqlhooP6m53oo4/1luQww0zqtBn7WEF+cE=;
        b=A2GiNHXMz6I4eyEh9581lDz4Kro6OE40j9kzfbamUO3y2fTyc09J3Fw4wCFIwUXbRV
         KwYVGNBFK6VcgitGcwlWEe/ly8VPgQAL0oqXeD+VndXbJVeTbkhBGcLYOkduRtbGjRz9
         wNj1Zj+fp4W0J+KixkdnwVGwxqZNcgWb0ROxJAP+WJSabYRwq2COL1Xi85SxD4Cquj0b
         TLDnrKk+u2DJUUBf4lWMSxwI0EX/TSxoQfhQw6grzMXY7kVdJkMjnR+ljj2tixeoaJ2/
         fqKneGVCYMaUfQOWRK8yKQ7DH3uH5NWyoVyGb0XWiiBOmHz7p15a/Ekl0w7Y7X0nZ9oZ
         RXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711501775; x=1712106575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEBSgXro8eqlhooP6m53oo4/1luQww0zqtBn7WEF+cE=;
        b=YARZWu+D7T4A9YolmhvWHvMutxY2RN7lfqlatvPQDw7Ib75x7y8BFLWSWYwXvCsTEg
         0RP84nTWaxkltuOSCA/wE7l49Bb8wQGWl8qf8NxvgpzlSBgBUOg/eCsfK2tPsvBTZn6j
         bzak/qDcQYUtl+xGAVudbEQ547fUE+yPX+M3J6rw3ZREKWk6RqE6+ZPPLNNcrlCDgkz8
         UrBErXiwIDklJLtIhHFpmiTDCRx8sCwwr1K4I13Qv1vgEpwB/6Wsw+g0wg1+fnuKB1mU
         9FAvJbsYZyjmWX4RWnn/tKbYFwrxHC5r4EL65oT9gl0tEBeXUlEYJLACnpyyE6Pg2RE5
         GQsA==
X-Forwarded-Encrypted: i=1; AJvYcCUSzI9LBdd453HfXGqr4UOvwqoekVH40Z8qcVOyz+qhM/N7PdAsZLHLS87VHXxtzSzV4Jlo40IbaWX2F5MLB06jiIXgI+/MPD50PLjI
X-Gm-Message-State: AOJu0YwldsD9cOKSNIlzUFyItIXwHsGWnr28ntfMFDCRAW+HzrbbyWEH
	j8UIdcTFr0f9e7Ml2IdKU3l9MozdAqhwUZKcrRnveBMc2EOhGEZl
X-Google-Smtp-Source: AGHT+IHwrjY2ooVOO8ozb2Hu2PhIT+7JJL6mrvbH4FGZYiL2O/JADl1Mf08RYjNu2OoLgns8MOj8rw==
X-Received: by 2002:a05:622a:1d1:b0:431:7ebe:d037 with SMTP id t17-20020a05622a01d100b004317ebed037mr701857qtw.5.1711501774853;
        Tue, 26 Mar 2024 18:09:34 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id h16-20020ac87150000000b00430b772f3dfsm4240753qtp.55.2024.03.26.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 18:09:34 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A9FA01200066;
	Tue, 26 Mar 2024 21:09:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 26 Mar 2024 21:09:33 -0400
X-ME-Sender: <xms:zHEDZmwqWCCI8-Hx0zimyLEjxhi6oRr93Pe9hzLPyK-k7XfyFQ26aw>
    <xme:zHEDZiQ0LQchmn2fT6eixaLWLiNKeTbJ90PFSG3D4lVXJkTIhq7DFKTUKM_UUlYhM
    sjR7C9DJizUN9iVZw>
X-ME-Received: <xmr:zHEDZoXjp-vNoavsSMWgp40schyKozBTzV0iu_UDW7OoMfF78p7Edu0DhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejleduveeuhfeiffeigeffueffgeehhfdvvdeuhefgveffhfdvvdfgheev
    keekgeenucffohhmrghinhepvghlrghpshgvugdrthhonecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:zHEDZsjJZIYXW66M8qVvHUZzjPzWUSS-MSW7Ncm_DQre25MXuJMSZw>
    <xmx:zHEDZoBe13ZbEOgr0RK106TQGSHK0_euLOBcAPdoMqVF_b4axziJJA>
    <xmx:zHEDZtLYgLetvYwGgiOt-5o9apxI4iJ-IjWEshcc8775kSU5hk2ckA>
    <xmx:zHEDZvCO3lQl_zv70be1H_ZWM6ghcrkUxVyZxaSwruBA-N1UQ1Fu-w>
    <xmx:zXEDZo0u8cVvht4I0ZdiAln3dhKTvYha375aSbtQQtOjsDCGrt38FEG_A_I>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 21:09:32 -0400 (EDT)
Date: Tue, 26 Mar 2024 18:09:31 -0700
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
Message-ID: <ZgNxy70__7-x0c-8@Boquns-Mac-mini.home>
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
> On Tue, Mar 26, 2024 at 05:13:38PM +0000, Benno Lossin wrote:
> > On 24.03.24 23:33, Boqun Feng wrote:
> > > This is a convenient way to do:
> > > 
> > > 	t1 = Clock::now();
> > > 	...
> > > 	delta =  Clock::now() - t1;
> > > 
> > > Hence add it.
> > > 
> > > Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> > > Signed-off-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> > > Co-developed-by: Asahi Lina <lina@asahilina.net>
> > > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > >  rust/kernel/time.rs | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> > > index 5cd669cbea01..cd1e45169517 100644
> > > --- a/rust/kernel/time.rs
> > > +++ b/rust/kernel/time.rs
> > > @@ -114,6 +114,31 @@ fn sub(self, other: Self) -> Self::Output {
> > >      }
> > >  }
> > > 
> > > +impl<T: Clock + Monotonic> Instant<T> {
> > > +    /// Returns the time elapsed since this [`Instant`].
> > > +    ///
> > > +    /// This provides a convenient way to calculate time elapsed since a previous [`Clock::now`].
> > > +    /// Note even though the function only exists for monotonic clocks, it could still return
> > > +    /// negative [`Duration`] if the current time is earlier than the time of `&self`, and this
> > > +    /// could happen if `&self` is a timestamp generated by a [`Instant`] + [`Duration`].
> > 
> > But there currently is no way to add an `Instant<T>` to a `Duration`.
> > 
> 
> This is kinda the disadvantages of "upstreaming the bits you only need",
> we know for sure there will be a way to generate an `Instant` with an
> addition of a `Duration`. I can of course provide that function in this
> series. But let's settle down on "negative durations" first.
> 

Hmm... I'd like to propose a change here. After some thoughts, I think
we should have two timestamp types: `Instant` and `KTime`, where
`Instant` represents solely a reading of a clocksource, and `KTime` is
just the normal timestamp. This means the only way to get an `Instant`
is via `Clock::now()`, and you cannot get an `Instant` by `Instant` +
`Duration` (this could return a `KTime`). And a `Instant` can always
`into_ktime()` return a `KTime` which support add/sub a duration. But
again you cannot get an `Instant` from a `KTime`.

Having this setup means for the same monotonic clocksource,
`Clock::now()` is always later than any `Instant`, since any `Instant`
must be created by a previous `Clock::now()`. And this makes a lot of
sense. Moreover, I could introduce `KTime` in a later patchset, since
`Instant` and `Duration` can fulfill the current requirement. We still
need two duration types though...

Regards,
Boqun

> > > +    ///
> > > +    /// But for typical usages, it should always return non-negative [`Duration`]:
> > > +    ///
> > > +    /// # Examples
> > > +    ///
> > > +    /// ```
> > > +    /// use kernel::time::{Clock, clock::KernelTime};
> > > +    ///
> > > +    /// let ts = KernelTime::now();
> > > +    ///
> > > +    /// // `KernelTime` is monotonic.
> > > +    /// assert!(ts.elapsed().to_ns() >= 0);
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

