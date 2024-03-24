Return-Path: <linux-kernel+bounces-112845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 075AB887EF0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64176281263
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF661C686;
	Sun, 24 Mar 2024 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl+WANKo"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044914A8B;
	Sun, 24 Mar 2024 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711313599; cv=none; b=ccct5IlLjau5Yyxwp5stPa/YqBfgAwPADrIkFMge/9gQjPWpQJGF8a7EmINYczkqpwizg1kqycIGA1ZDOT+YS6gqOXeosRCTZ77d+3RrbB+LWvg1FZMq3jDFDiS3ZGqbj4jwOOWBMBlVw3jGN2cYM4GppNoe6CDvWWx2Hl6ZZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711313599; c=relaxed/simple;
	bh=w6QTSRCvCbXIJrQo5a6zGJPG94YkF0nbOhX1LdeWJEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVO6PrXQzrCW18R0zZtKq/Dy2X6tOH6CrXZ2mOknUNCNC7R6S8SXxHh0+nWpsQRyjdN4QifgL2/AbhFWddqpM8GDxKm8e/1f6boIG3w3kKG/EvGbyxwfmsJfxY2qhQXpEH97XcPaE3pT3q4bpP2DYzzoohA1wtRGDz+XF9Qjexc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl+WANKo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78a2290b48eso306905385a.3;
        Sun, 24 Mar 2024 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711313596; x=1711918396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxtRI5+ytv/BNpsQ8idpKFv7xKjtqglSJCYa2B+VzLU=;
        b=Wl+WANKo3BxSUXbEE6bR1ufOk6dU/X2BPClQdEE2S/BKxkhxuQZe4JoscdSWW4qXLS
         uoHSXoP3ZTXpAHvCrQuKEkHA1af+rpry42FjKiP3faM9BV0xjvOtgSv+cvCocqqVevDE
         vHpO1rHK1oFh0TuDx0wWy37K3/7o4ScYSdVfcevWRyqWuVY+lciG8Hjg/h7JcyipacT3
         2rLtv6LvfljrKqYNrJ/c0Ytod0hC8WhErE7kJBRYaJPG66is77KOmXXwMf5BwVjrEJZh
         F7ZL6XItpYHrkG7eN/3uZIpVAOq62uEWetwbxgl8qGJQexX58+A7Nkw3DS6m4u92BS93
         8l1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711313596; x=1711918396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxtRI5+ytv/BNpsQ8idpKFv7xKjtqglSJCYa2B+VzLU=;
        b=PQWuMsNNnxm9QnhJM1FU0Wgyjijx1NkjH2YzQEgF4j0nPe+5mIzg+5jQfALnKdtRvF
         syDlZdTvMJUzZeeHf1X0EnkDIHsMkKDxYmzciW6yMIVz6A+kaY2Me635oqbXjW3qCKKJ
         A9NWPkGDDgAK6s+UtNBlSM3N7W6+tJiwpbVjIy5fB8xFnlLMLkhTkszE4VhFWAPjDTf0
         JZTjwehaxvh/uorFzFb5k1lReM1W0r93Ks6r86BmEw9f2bLb8pEKmupTMGc7KPDWdDin
         ZtC6v2knKIBQWiQtQAhYir7ykzPHPehwrOvVFR10xGjGTQcxJ9DXhq9anDre+urYMtus
         txHg==
X-Forwarded-Encrypted: i=1; AJvYcCW025hREto1tx7FagNNr1UwpIHkTO2U017Lcyo+e39M+IA50VbOxM75Pxd/GDgW3D84nRuL9YONe30jFk+HMU5SzdcELTZ5jF9WEqwfQulLLd2rDH9p/wKSpVoZm++e1w3X19So5/X47T4N5bM=
X-Gm-Message-State: AOJu0YxSc0vUZLbh72Q3JiY3buMPGsVxHmq/z2hfSA7lnOgdv5PbFYuk
	/OErEdmm39eyqP9Ov9hWp0eGOClbNYkOIROCDP1cGJXQ7dvLUQwO
X-Google-Smtp-Source: AGHT+IF6W/p34C19UjwLYUEO/kx8St7XcSjoR2eTBVXs58kI0FufeNmZJc3O8401gwnI0qbmaTDg0Q==
X-Received: by 2002:ad4:5cca:0:b0:690:7928:87bf with SMTP id iu10-20020ad45cca000000b00690792887bfmr6869122qvb.22.1711313596529;
        Sun, 24 Mar 2024 13:53:16 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id jq7-20020ad45fc7000000b006961d023d2fsm3366374qvb.17.2024.03.24.13.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 13:53:15 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 55AFD1200032;
	Sun, 24 Mar 2024 16:53:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 24 Mar 2024 16:53:15 -0400
X-ME-Sender: <xms:upIAZh5lVByEvW0rwzFc3JuR9aAuvAdXTF6-7TPdrd2_VH4hCntNiQ>
    <xme:upIAZu4dZmb_QHwXxxvJmx-SZlJGz83T8DgiF4KzYbjAJQ0uGzRellqB8aFjJpB7T
    _7irZDg0_qhzKs7bg>
X-ME-Received: <xmr:upIAZofqJku5FtHJ6EaYj2Oa-FMsQnLm3vgDwj3URYKPbv-cjPM7TMdg6Hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtjedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtrodttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhg
    sehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffuddtgffhhfevlefhtdfggf
    euleetvefgueeukeelffeghfdtlefgvdeiheduhfenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgpdgrnhgurhhoihgurdgtohhmpdhruhhsthdqfhhorhdqlhhinhhugidrtghomh
    dpvghlrghpshgvugdrthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:upIAZqKRnoG7rwvoLYJE12TXJRdCRIp-PaD8fE70PxpS8BWYCqyRww>
    <xmx:upIAZlJS96CNBAfyB64q1haAApB9Imj7E4bZJvtzZp3HWBRsm_IFHA>
    <xmx:upIAZjxVwj1_ik8jpsjcnfQotKmQ6Ecz3wuJAWn3Vm2a9Oz6N4sb0w>
    <xmx:upIAZhLEP_JX_GfUrY_qNPeiiOIx1m_4hznP75_4NncVzMj0Uo-WAA>
    <xmx:u5IAZifSamPtKXETpUPHAoRXsnlMFjd8ylZ-jhT2GL2TMi_4kyI-i_eZ5PA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Mar 2024 16:53:14 -0400 (EDT)
Date: Sun, 24 Mar 2024 13:52:46 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Valentin Obst <kernel@valentinobst.de>
Cc: aliceryhl@google.com, a.hindborg@samsung.com, alex.gaynor@gmail.com,
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, gary@garyguo.net,
	heghedus.razvan@protonmail.com, jstultz@google.com,
	lina@asahilina.net, linux-kernel@vger.kernel.org, ojeda@kernel.org,
	rust-for-linux@vger.kernel.org, sboyd@kernel.org,
	tglx@linutronix.de, wedsonaf@gmail.com
Subject: Re: [PATCH v2] rust: time: add Ktime
Message-ID: <ZgCSnoSQCYiOlYNU@boqun-archlinux>
References: <Zf2kio8NYG5DEgyY@tardis>
 <20240324094023.22317-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324094023.22317-1-kernel@valentinobst.de>

On Sun, Mar 24, 2024 at 10:40:23AM +0100, Valentin Obst wrote:
> > Subject: [PATCH] rust: time: Add clock source reading functionality
> >
> > Introduce wrappers around `ktime_t` with a time duration type `KTime`
> > and a timestamp type `Instant`.
> >
> > Rust Binder will use these bindings to compute how many milliseconds a
> > transaction has been active for when dumping the current state of the
> > Binder driver. This replicates the logic in C Binder [1].
> >
> > For a usage example in Rust Binder, see [2].
> >
> > The `ktime_get` method cannot be safely called in NMI context. This
> > requirement is not checked by these abstractions, but it is intended
> > that klint [3] or a similar tool will be used to check it in the future.
> >
> > Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
> > Link: https://r.android.com/3004103 [2]
> > Link: https://rust-for-linux.com/klint [3]
> > Originally-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> > Originally-by: Asahi Lina <lina@asahilina.net>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/kernel/time.rs | 158 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 158 insertions(+)
> >
> > diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> > index 25a896eed468..50cc063aa9b4 100644
> > --- a/rust/kernel/time.rs
> > +++ b/rust/kernel/time.rs
> > @@ -4,6 +4,15 @@
> >  //!
> >  //! This module contains the kernel APIs related to time and timers that
> >  //! have been ported or wrapped for usage by Rust code in the kernel.
> > +//!
> > +//! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
> > +//! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
> > +
> > +use crate::pr_err;
> > +use core::marker::PhantomData;
> > +
> > +/// The number of nanoseconds per millisecond.
> > +pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
> >
> >  /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
> >  pub type Jiffies = core::ffi::c_ulong;
> > @@ -18,3 +27,152 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
> >      // matter what the argument is.
> >      unsafe { bindings::__msecs_to_jiffies(msecs) }
> >  }
> > +
> > +/// A kernel time duration.
> > +///
> > +/// This type basically wraps the `ktime_t` with one restriction: it should only be used for
> > +/// representing a time duration, in other words, it's not the type for timestamps.
> > +#[repr(transparent)]
> > +#[derive(Debug, Copy, Clone, PartialEq, PartialOrd)]
> > +pub struct KTime {
> > +    inner: bindings::ktime_t,
> > +}
> > +
> > +impl KTime {
> > +    /// Create a [`KTime`] from a raw `ktime_t`.
> > +    #[inline]
> > +    pub fn from_raw(inner: bindings::ktime_t) -> Self {
> > +        Self { inner }
> > +    }
> 
> Eventually we might want to be able to create instances of types that
> represent durations in const contexts, e.g., for fixed thresholds or
> fixed offsets to relative timers. Would it make sense to '/fn/const fn/'
> for the `KTime` (or `Ktime`) methods that support it?
> 

Yeah, that makes sense. Besides, I'm going to rename `KTime` as
`Duration`, since it really represents a duration of time, and...

> [For that use case the naming/signature `from_raw(inner: bindings::ktime_t)`
> could maybe also be changed to something like `new(duration: i64)`, i.e.,
> make it sound less like an internal API.]
> 

..it makes more sense for a `Duration::new()` instead of a
`KTime::from_raw()`. I will send an updated version soon, since I also
find a few problems:

> 	- Best Valentin
> 
> > +
> > +    /// Divide the number of nanoseconds by a compile-time constant.
> > +    #[inline]
> > +    fn divns_constant<const DIV: i64>(self) -> i64 {
> > +        self.to_ns() / DIV
> > +    }
> > +
> > +    /// Returns the number of nanoseconds.
> > +    #[inline]
> > +    pub fn to_ns(self) -> i64 {
> > +        self.inner
> > +    }
> > +
> > +    /// Returns the number of milliseconds.
> > +    #[inline]
> > +    pub fn to_ms(self) -> i64 {
> > +        self.divns_constant::<NSEC_PER_MSEC>()
> > +    }
> > +}
> > +
> > +impl core::ops::Sub for KTime {
> > +    type Output = KTime;
> > +
> > +    #[inline]
> > +    fn sub(self, other: KTime) -> KTime {
> > +        Self {
> > +            inner: self.inner - other.inner,

This doesn't handle the overflow cases.

> > +        }
> > +    }
> > +}
> > +
> > +/// Represents a clock, that is, a unique time source and it can be queried for the current time.
> > +pub trait Clock: Sized {
> > +    /// Returns the current time for this clock.
> > +    fn now() -> Instant<Self>;
> > +}
> > +
> > +/// Marker trait for clock sources that are guaranteed to be monotonic.
> > +pub trait Monotonic {}
> > +
> > +/// An instant in time associated with a given clock source.
> > +#[derive(Debug)]
> > +pub struct Instant<T: Clock> {
> > +    ktime: KTime,
> > +    _type: PhantomData<T>,
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
> > +    fn new(ktime: KTime) -> Self {
> > +        Instant {
> > +            ktime,
> > +            _type: PhantomData,
> > +        }
> > +    }
> > +
> > +    /// Returns the time elapsed since an earlier [`Instant`], or None if the argument is a later
> > +    /// Instant.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// use kernel::time::{Clock, clock::KernelTime};
> > +    ///
> > +    /// let a = KernelTime::now();
> > +    /// let b = KernelTime::now();
> > +    ///
> > +    /// // `KernelTime` is monotonic.
> > +    /// assert_eq!(a.since(b), None);
> > +    /// assert_eq!(b.since(a).map(|d| d.to_ns() >= 0), Some(true));
> > +    ///
> > +    /// ```
> > +    pub fn since(&self, earlier: Instant<T>) -> Option<KTime> {
> > +        if self.ktime < earlier.ktime {
> > +            None
> > +        } else {
> > +            Some(self.ktime - earlier.ktime)
> > +        }
> > +    }
> > +}
> > +
> > +impl<T: Clock + Monotonic> Instant<T> {
> > +    /// Returns the time elapsed since this [`Instant`].
> > +    ///
> > +    /// This is guaranteed to return a non-negative result, since it is only implemented for
> > +    /// monotonic clocks.
> > +    ///

And this is not quite right, since if we implement `Add` trait for
`Instant` (`Instant` + `Duration`, i.e. the "wrapper" for
ktime_add_safe()), we could have an `Instant` of monotonic clocks that
points to the future (i.e. now() is earlier than `self`). I will remove
the `pr_err()` below (since it's not an error anymore). But the bound of
`Monotonic` will still be remained, since it's mostly a convenient
interface for monotonic clocks.

> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// use kernel::time::{Clock, clock::KernelTime};
> > +    ///
> > +    /// let a = KernelTime::now();
> > +    ///
> > +    /// // `KernelTime` is monotonic.
> > +    /// assert!(a.elapsed().to_ns() >= 0);
> > +    ///
> > +    /// ```
> > +    pub fn elapsed(&self) -> KTime {
> > +        self.since(T::now()).unwrap_or_else(|| {
> > +            pr_err!(
> > +                "Monotonic clock {} went backwards!",
> > +                core::any::type_name::<T>()
> > +            );
> > +            KTime::from_raw(0)
> > +        })
> > +    }
> > +}
> > +
> > +/// Contains the various clock source types available to the kernel.
> > +pub mod clock {
> > +    use super::*;
> > +
> > +    /// A clock representing the default kernel time source (`CLOCK_MONOTONIC`).
> > +    pub struct KernelTime;
> > +
> > +    impl Monotonic for KernelTime {}
> 
> nit: blank line missing
> 

Thanks, I will add it in a new version.

Regards,
Boqun

> > +    impl Clock for KernelTime {
> > +        #[inline]
> > +        fn now() -> Instant<Self> {
> > +            // SAFETY: It is always safe to call `ktime_get` outside of NMI context.
> > +            Instant::<Self>::new(KTime::from_raw(unsafe { bindings::ktime_get() }))
> > +        }
> > +    }
> > +}

