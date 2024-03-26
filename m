Return-Path: <linux-kernel+bounces-119786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA0788CCF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0442330478A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD20713D258;
	Tue, 26 Mar 2024 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh57NNlP"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF1613D24D;
	Tue, 26 Mar 2024 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480792; cv=none; b=VBbLUmkQOKsbyAvQpEJ96T/Q7Nhfxwh3uuhOh95icTIrRYnPnsh7N8LYXNdvuie3zomHd7qP6it7nSRnmEdWsJEw4rhC6BIkaXWEu00zktQEXxEBiR1VK0jX7FefKX7CNqJw2CzqcB5v1+6TkWfXGUjyAilfMZX1VMDdSTxFYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480792; c=relaxed/simple;
	bh=fD4liC5+90RHaKqBG1UsPLqW4TCZsUCriJvYw3AkKug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2iwiKTdWcI2N9QyYxlM0j35+kAscmvs4zsRTZ6h25hPf5vu4v/SXcm+nGdT3LcIdWdFPIIlnTQ+DJ0KFfjVZodZVn+OxkSf7WM4WcTa4cPCrj/oDGXzzluPMZG246cB7Jmmpb/2+Y5aCjfbLDVqn6H5Z7YogmbC2uoRBqdqlKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hh57NNlP; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2218a0f55e1so3274407fac.1;
        Tue, 26 Mar 2024 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711480789; x=1712085589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAHLc8V57srrv+2HTnRA6urvVJxa3hc+VE/zPYkPcYw=;
        b=Hh57NNlPJ/OVhXzp+qpD44wA5DNBbggEl+siKPNNjQIBuMVbtWGF3pPuRDZpUWH3Kj
         QvFxV6E2kbLsz3tWO9AWcvpS8NQsHXUifUKv3vjOmSUXdqVA9xpt45h7xq5347IVOg/o
         N6eSUBXUR5BwQB2Y9jozlk/9eYItSojqVhxe0I6TNq5ToDkYG9vzvxBGLE179IQKNF2t
         he+0lD/hwosMFoDWSbiJcQAn8maVMYi9zbvlw0E9gWUgAUIPykOz9/lVwbTbkMDGWeD5
         lGAhSt1OSDjbcK1iin+FQfktmeMQigANxQuJdtdhFrUOqtLxPMggWoeSI69FNGLNNgs1
         lCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480789; x=1712085589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAHLc8V57srrv+2HTnRA6urvVJxa3hc+VE/zPYkPcYw=;
        b=eDlkshlDg1WrFoHq6+SRSa0MC4JpL7bbeEzK1NPzGiO2HIh7jeDKCzyhfL2XQAMZTL
         7Bw78ibza/vPe4qg8RRX0KwV99OVaBvSz40zzq4GGLUUNf+AoxHwHRvmbHBwYvEziKNB
         LVjedKh2SbX1LsOo+qVlwx7Z8+N8VJmZ6BBbI7hlBcwIdLe4TqdtOFUhRBy6rbB36eyX
         zOipbn+KbAOlTi13aEwMydeQlTdAk9xR3miZEaxZLQiJs19SQh3J+eHw5mWzLknrgtXH
         1dY7oSrzNmvCkff2jlflr2NZIJGFqXNwIaLvY+h46TROjOZYHDvUE1ZtOzphpkdRTF3P
         QPag==
X-Forwarded-Encrypted: i=1; AJvYcCWvYntRWG4mYbZTPGUtg/W+fRPoSVNiIvA4Vg2ZwWO71C90PyoEszYms8aqaRXva9cs+wzn4piqGbI104oUfWHIAyxU/b++Y8A+qJ1X
X-Gm-Message-State: AOJu0YyiqfwJ/5DdT11irYIdMXPO4mVX44LVFTOB6BY0WyUUpwlJiOdi
	jzGLjjh+2gKkUZsdCceRMSBcqUGVILg9EXRfcErYNaj0YCxnS5u/
X-Google-Smtp-Source: AGHT+IHstzDiQk2sv8Bx6JwivmgnUg6U3jhY2Zf99g2hG9nm16SQjX/J6Dt4u4aLVYalJZHCcNLLrw==
X-Received: by 2002:a05:6870:a8a8:b0:22a:2e6:b82e with SMTP id eb40-20020a056870a8a800b0022a02e6b82emr2795255oab.38.1711480788986;
        Tue, 26 Mar 2024 12:19:48 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id gd14-20020a05622a5c0e00b0042f21fe66f7sm3975014qtb.73.2024.03.26.12.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:19:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 08F9B1200068;
	Tue, 26 Mar 2024 15:19:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 26 Mar 2024 15:19:48 -0400
X-ME-Sender: <xms:0x8DZsA8-kHMMWZPftcJ0Il0XS_GwGkNCNBeVyt4nmfgaH5oQu_5Pw>
    <xme:0x8DZuh5FrOwuVu06BxcKNTC1qYsy0C1Xc002opwWYXxr4fwPrvBjrcRcqL8cYGnb
    aZJkB9lBen7KRQnuA>
X-ME-Received: <xmr:0x8DZvmvWPu57LoooWvd6vWBmd3U09d1yixqwaELlN_mvjBQDSOsOXM3URLd9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:0x8DZiwPTB-Gj0TvGORyqR4t4EslOpdJv1EtiwYLpuEEEv_TClY47g>
    <xmx:0x8DZhTC1wlMKFnaZrvnvKdo5k-BuVgp3BXIc2CTQvKq7E5Ul313KA>
    <xmx:0x8DZtY2kszNrQADkV5RTF1z2vh24NSW1cJWyQSWTvIl-zQe6ZN-GQ>
    <xmx:0x8DZqQuawtcKGSDYdlPncM22lynFg-3mXX4PopHn_Z9DVCoqZTE2A>
    <xmx:1B8DZnF9_R8nc-megodBzvkmiTdUeoJbZugJxXeEGgkLxQMuUCPN7phhQUA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 15:19:47 -0400 (EDT)
Date: Tue, 26 Mar 2024 12:19:13 -0700
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
Subject: Re: [PATCH 3/5] rust: time: Introduce clock reading framework
Message-ID: <ZgMfsaiOlA87PAUf@boqun-archlinux>
References: <20240324223339.971934-1-boqun.feng@gmail.com>
 <20240324223339.971934-4-boqun.feng@gmail.com>
 <c2XJe4xCqT5WrHu9XZKQ03ggEZLwd2KBuSBb9Onivny9v7fqKBkm1aywmztjiDyuLKqr2Igt_6XUJiuArLl9JVwq0xa4gKfocP2H5YZDrFk=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2XJe4xCqT5WrHu9XZKQ03ggEZLwd2KBuSBb9Onivny9v7fqKBkm1aywmztjiDyuLKqr2Igt_6XUJiuArLl9JVwq0xa4gKfocP2H5YZDrFk=@proton.me>

On Tue, Mar 26, 2024 at 05:00:39PM +0000, Benno Lossin wrote:
> On 24.03.24 23:33, Boqun Feng wrote:
> > To make sure Rust code doesn't mix timestamps from different clocks, a
> > type safe clock reading framework is introduced. It includes:
> > 
> > * A `Clock` trait that represents different clocks, to read a particular
> >   clock, one needs implement the `Clock::now()` function.
> > 
> > * A `Instant<Clock>` type that represents timestamps of different
> >   clocks, whose implementation is just a `ktime_t`, so all the
> >   calculation on `ktime_t` should apply to it as well.
> > 
> > Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> > Signed-off-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> > Co-developed-by: Asahi Lina <lina@asahilina.net>
> > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/kernel/time.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> > 
> > diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> > index b238b3a4e899..0f9f5605ed48 100644
> > --- a/rust/kernel/time.rs
> > +++ b/rust/kernel/time.rs
> > @@ -6,6 +6,9 @@
> >  //! have been ported or wrapped for usage by Rust code in the kernel.
> >  //!
> >  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
> > +//! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
> > +
> > +use core::marker::PhantomData;
> > 
> >  /// The number of nanoseconds per millisecond.
> >  pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
> > @@ -64,3 +67,49 @@ pub fn to_ns(self) -> i64 {
> >          self.inner
> >      }
> >  }
> > +
> > +/// Represents a clock, that is, a unique time source and it can be queried for the current time.
> > +pub trait Clock: Sized {
> > +    /// Returns the current time for this clock.
> > +    fn now() -> Instant<Self>;
> > +}
> > +
> > +/// Marker trait for clock sources that are guaranteed to be monotonic.
> > +pub trait Monotonic {}
> 
> Why is this trait not an extension of `Clock`?
> 

This was carried over from the old version, for myself, it doesn't make
much difference between:

	trait A { .. }
	trait B { .. }

	impl<T: A + B> ...

vs

	trait A { .. }
	trait B: A { .. }

	impl<T: B> ...

hence I kept it as it is, but yes, it a `Monotonic` *`Clock`*, so I will
change it in the next version.

> > +
> > +/// A timestamp of a given [`Clock`]
> 
> Missing '.'.
> 

Fixed locally.

> > +#[repr(transparent)]
> > +#[derive(Debug)]
> > +pub struct Instant<T: Clock> {
> > +    inner: bindings::ktime_t,
> > +    clock: PhantomData<T>,
> > +}
> > +
> > +impl<T: Clock> Clone for Instant<T> {
> > +    fn clone(&self) -> Self {
> > +        *self
> > +    }
> > +}
> > +
> > +impl<T: Clock> Copy for Instant<T> {}
> > +
> > +impl<T: Clock> Instant<T> {
> > +    fn new(ktime: bindings::ktime_t) -> Self {
> 
> When compiling, this function is marked as dead-code in this patch.
> 

Hmm... I cannot trigger any compile errors with this patch. If you see
an error, could you share the build command? It's not a `pub` function
though.

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 
> > +        Self {
> > +            inner: ktime,
> > +            clock: PhantomData,
> > +        }
> > +    }
> > +}
> > +
> > +impl<T: Clock> core::ops::Sub for Instant<T> {
> > +    type Output = Duration;
> > +
> > +    /// Returns the difference of two timestamps.
> > +    #[inline]
> > +    fn sub(self, other: Self) -> Self::Output {
> > +        // `ktime_t` is an `i64` value of nanoseconds, and kernel defines signed overflow to behave
> > +        // like 2s-complement, hence `wrapping_sub()` is used here to mirror `ktime_sub()`.
> > +        Duration::new(self.inner.wrapping_sub(other.inner))
> > +    }
> > +}
> > --
> > 2.44.0
> >

