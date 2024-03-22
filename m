Return-Path: <linux-kernel+bounces-111704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8740F886FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2DD1C219C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A6952F9B;
	Fri, 22 Mar 2024 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkrBJ4D5"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B843AAB;
	Fri, 22 Mar 2024 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711121553; cv=none; b=HLI5/9c9FiZxrDh1c95y2Ot00Lb0b0vWOiCLyL2OGlq4DTitHBuN0D4I/8YRduccRz7n1kL0fO7y5koXA0DTxmiilV62/uZdmuLQLn1A/HtuS4xGLiGdq57/gPWeFIli+wivtuofsn3mxb+L2IT432Z7GG5CAi873pk541MW1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711121553; c=relaxed/simple;
	bh=P3wyIxoBFXK1mVKfrTE7kGKRqmQadcn0/NHqsFnj96c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL3kbza457z7JmO6KnE5bKcfz5fELjGgl4MKzbfX3vgP7ZZ1nz/ZzRr3vlS6WKXbdJwmtVRCrWEZAhWendiCFj5Eaz80j+aHnjsBaC9x9BaoMWXWSrI2eHQc56AVTHMutf8hivQ+lGzefUdVqvoz3X7g3za2svsd556p7llJOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkrBJ4D5; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6918781a913so18623706d6.3;
        Fri, 22 Mar 2024 08:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711121550; x=1711726350; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h1K6z7fXnB/y40CAaLq2u2T8rIHyCDP9Eyty22Wlld8=;
        b=GkrBJ4D5IbQfzmyu9sgFoJc4AZz9+nptw/f9uqsLT5GK/ApxI7dsRNT5CXXHkAUiU/
         gUlbphfbgY5mNo9G7Zpnt0Q1rjvEW92Hk1efT0YiwzfEu2gC9tL2MSurG5kGbGbHDZ+L
         bg6f+7M0Ji87Va86GUjAq+tl4T9jntRPxXF1JVxhPKFTfNS/dvmEH1pGMWLLDvEy0OcU
         JVgr9VetwT0EtePOJNdu82Lr5pcg9y6RlJjomKYjJZPpJwHWtFpwStyVTRTKZV1D53AX
         JErhoKwBW807iAVmuSdLsuWdWK4+lzB6nfLOiSGIhna6qaVfDBDT+LjiU5A9dS14dzZD
         6w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711121550; x=1711726350;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1K6z7fXnB/y40CAaLq2u2T8rIHyCDP9Eyty22Wlld8=;
        b=jxg+MSPhzl6/6uE16Hw/jMTS1HzS0Y1qoQkKIY6zko8DtoBnP0njAv4RvyviFzeGBa
         8N1Hi0cxuxSl1NDXW8mNzLHw2+eGnQmIXh7elr2bR6pFXmoJYJ4ZaboVCh49YA6chC7N
         PqLDs2RsfAy97fh4qMz6WsIEjim3K+nKZOgJNaabcsmqHKxwQjpd/TIRyraUWxHgVAoV
         yfm5Oc62OrA++X1mKHgj7fS9gSVpeDPz+1mtDrBf1zL/jR6ShTqNTAYsXbGEghzerWsP
         dzG81sigixXCpLSSHdDHiIoZsMZib+//LyMkLwtJ4B1YHtM8ccHMjcZft/pFFbYVXYVS
         xIxw==
X-Forwarded-Encrypted: i=1; AJvYcCU+2ikN+PkVjNY6zpA7KrPATs/IEmr29fyL4f9Ot2WYqHikQybnaSJzyK+H99lSuBY+kHHW+p5wGokwOw4n5G/yNS+k5CJYJMPHOUE9QAB3sbmNzWDMywd2ncdptiqT9f9nYzbHsO5xJrsvvTw=
X-Gm-Message-State: AOJu0YxB/85gnGgDxbDQn7cc3VKCrCgEmEEed/GYZbgt67E4Ba8YSgky
	FlQ/wpAA9za+a4Kj9WsPdztkHIZgOlZAjyPybpQVHonr3q2Sn5Mb
X-Google-Smtp-Source: AGHT+IGaO1+EvCcnVniGMfSPDZOPk8jpiG5xa91KWDNtek3tBbzaK6IbL+JZODUhmds+LX1/btEYaA==
X-Received: by 2002:ad4:5fcf:0:b0:690:d754:284 with SMTP id jq15-20020ad45fcf000000b00690d7540284mr2259366qvb.27.1711121550448;
        Fri, 22 Mar 2024 08:32:30 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id cy17-20020a05621418d100b0068f6e1c3582sm425573qvb.146.2024.03.22.08.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:32:29 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 6EEAA1200066;
	Fri, 22 Mar 2024 11:32:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 22 Mar 2024 11:32:29 -0400
X-ME-Sender: <xms:jKT9ZXW8juNAixHYWl23vDN4r2HD-_LY4H3gga8fw9I7Cs6EJubA6Q>
    <xme:jKT9Zfl36ZrZJ1cLP42wEl1-PujlvOA_ZdeR1LRqMceGK7zCujJO3hW0RN6XrHo_7
    A-jS680h9WOztxomg>
X-ME-Received: <xmr:jKT9ZTYjHjZVlRWiuxg9mvy52l-_AHlbSzZv1K6UzY7GgVhW9kkpQwRFsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnheptdeijeetheelhedvfeehgeegjeeihfeihedvlefhveehueetffetieev
    udegudeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprghnughrohhiugdrtghomh
    dprhhushhtqdhfohhrqdhlihhnuhigrdgtohhmpdgvlhgrphhsvggurdhtohenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvg
    hsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheeh
    hedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:jKT9ZSXuIq2ExToqdvKjKaEjbF8AuPJtE1HEle0py0KOB79B4xKh5A>
    <xmx:jKT9ZRloNPb020IzhvRKk9ouIMDsxHgtAQrpdt-L8PJcONKUJwP-XQ>
    <xmx:jKT9ZfdkyQ825Fgo8VhPqlDWPd4j76vMwuxIxNuGOswvC3mAF5sVAA>
    <xmx:jKT9ZbF4x2G1bbxC35nLVxXfMJUpEDRjc60ZfW6c3JB4whEPZ5jBoQ>
    <xmx:jaT9ZT3ZOqVvishrBoettkZDpY24Gfv6NwGjzZ41mjoVy4qdQS6M2WQPKr4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Mar 2024 11:32:28 -0400 (EDT)
Date: Fri, 22 Mar 2024 08:32:26 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: benno.lossin@proton.me, a.hindborg@samsung.com, alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com, gary@garyguo.net, jstultz@google.com,
	linux-kernel@vger.kernel.org, ojeda@kernel.org,
	rust-for-linux@vger.kernel.org, sboyd@kernel.org,
	tglx@linutronix.de, wedsonaf@gmail.com, lina@asahilina.net,
	heghedus.razvan@protonmail.com
Subject: Re: [PATCH v2] rust: time: add Ktime
Message-ID: <Zf2kio8NYG5DEgyY@tardis>
References: <2ecf6529-5408-4621-becc-2f30e1039079@proton.me>
 <20240322101803.400735-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240322101803.400735-1-aliceryhl@google.com>

On Fri, Mar 22, 2024 at 10:18:02AM +0000, Alice Ryhl wrote:
> Benno Lossin <benno.lossin@proton.me> wrote:
> > On 3/22/24 09:59, Alice Ryhl wrote:
> >> +/// Returns the number of milliseconds between two ktimes.
> >> +#[inline]
> >> +pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
> >> +    (later - earlier).to_ms()
> >> +}
> >=20
> > Is there a reason for this function being standalone?
>=20
> I think for a Rust time API, we should make one of two choices:
>=20
> * Match the C ktime_t API as closely as possible.
> * Match the Rust standard library std::time API as closely as possible.
>=20
> This patchset has made the former choice, and that is why I went with
> this design.
>=20
> In the future it could make sense to add a more "Rusty" API, but even
> then I think it could make sense to have both and implement the latter
> in terms of the former. That way, only the API that closely matches the
> C ktime_t API needs to concern itself with unsafely calling into C.
>=20

So I create the following one based on this patch and the previous we
have. I changed the title a bit, did a s/Ktime/KTime and add the part of
`Instant`, please take a look, I think the binder usage is still
covered.

Benno, I dropped your Reviewed-by since the patch has been changed.
Please take annother look.

Thomas, I tried to resolve a few comments you had for the previous
version, please let me know whether this version looks OK to you.

Regards,
Boqun

---------------------------->8
Subject: [PATCH] rust: time: Add clock source reading functionality

Introduce wrappers around `ktime_t` with a time duration type `KTime`
and a timestamp type `Instant`.

Rust Binder will use these bindings to compute how many milliseconds a
transaction has been active for when dumping the current state of the
Binder driver. This replicates the logic in C Binder [1].

For a usage example in Rust Binder, see [2].

The `ktime_get` method cannot be safely called in NMI context. This
requirement is not checked by these abstractions, but it is intended
that klint [3] or a similar tool will be used to check it in the future.

Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830fab=
=2E1682333709.git.zhangchuang3@xiaomi.com/ [1]
Link: https://r.android.com/3004103 [2]
Link: https://rust-for-linux.com/klint [3]
Originally-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
Originally-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/time.rs | 158 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 25a896eed468..50cc063aa9b4 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -4,6 +4,15 @@
 //!
 //! This module contains the kernel APIs related to time and timers that
 //! have been ported or wrapped for usage by Rust code in the kernel.
+//!
+//! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
+//! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
+
+use crate::pr_err;
+use core::marker::PhantomData;
+
+/// The number of nanoseconds per millisecond.
+pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
=20
 /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
 pub type Jiffies =3D core::ffi::c_ulong;
@@ -18,3 +27,152 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
     // matter what the argument is.
     unsafe { bindings::__msecs_to_jiffies(msecs) }
 }
+
+/// A kernel time duration.
+///
+/// This type basically wraps the `ktime_t` with one restriction: it shoul=
d only be used for
+/// representing a time duration, in other words, it's not the type for ti=
mestamps.
+#[repr(transparent)]
+#[derive(Debug, Copy, Clone, PartialEq, PartialOrd)]
+pub struct KTime {
+    inner: bindings::ktime_t,
+}
+
+impl KTime {
+    /// Create a [`KTime`] from a raw `ktime_t`.
+    #[inline]
+    pub fn from_raw(inner: bindings::ktime_t) -> Self {
+        Self { inner }
+    }
+
+    /// Divide the number of nanoseconds by a compile-time constant.
+    #[inline]
+    fn divns_constant<const DIV: i64>(self) -> i64 {
+        self.to_ns() / DIV
+    }
+
+    /// Returns the number of nanoseconds.
+    #[inline]
+    pub fn to_ns(self) -> i64 {
+        self.inner
+    }
+
+    /// Returns the number of milliseconds.
+    #[inline]
+    pub fn to_ms(self) -> i64 {
+        self.divns_constant::<NSEC_PER_MSEC>()
+    }
+}
+
+impl core::ops::Sub for KTime {
+    type Output =3D KTime;
+
+    #[inline]
+    fn sub(self, other: KTime) -> KTime {
+        Self {
+            inner: self.inner - other.inner,
+        }
+    }
+}
+
+/// Represents a clock, that is, a unique time source and it can be querie=
d for the current time.
+pub trait Clock: Sized {
+    /// Returns the current time for this clock.
+    fn now() -> Instant<Self>;
+}
+
+/// Marker trait for clock sources that are guaranteed to be monotonic.
+pub trait Monotonic {}
+
+/// An instant in time associated with a given clock source.
+#[derive(Debug)]
+pub struct Instant<T: Clock> {
+    ktime: KTime,
+    _type: PhantomData<T>,
+}
+
+impl<T: Clock> Clone for Instant<T> {
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<T: Clock> Copy for Instant<T> {}
+
+impl<T: Clock> Instant<T> {
+    fn new(ktime: KTime) -> Self {
+        Instant {
+            ktime,
+            _type: PhantomData,
+        }
+    }
+
+    /// Returns the time elapsed since an earlier [`Instant`], or None if =
the argument is a later
+    /// Instant.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::time::{Clock, clock::KernelTime};
+    ///
+    /// let a =3D KernelTime::now();
+    /// let b =3D KernelTime::now();
+    ///
+    /// // `KernelTime` is monotonic.
+    /// assert_eq!(a.since(b), None);
+    /// assert_eq!(b.since(a).map(|d| d.to_ns() >=3D 0), Some(true));
+    ///
+    /// ```
+    pub fn since(&self, earlier: Instant<T>) -> Option<KTime> {
+        if self.ktime < earlier.ktime {
+            None
+        } else {
+            Some(self.ktime - earlier.ktime)
+        }
+    }
+}
+
+impl<T: Clock + Monotonic> Instant<T> {
+    /// Returns the time elapsed since this [`Instant`].
+    ///
+    /// This is guaranteed to return a non-negative result, since it is on=
ly implemented for
+    /// monotonic clocks.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::time::{Clock, clock::KernelTime};
+    ///
+    /// let a =3D KernelTime::now();
+    ///
+    /// // `KernelTime` is monotonic.
+    /// assert!(a.elapsed().to_ns() >=3D 0);
+    ///
+    /// ```
+    pub fn elapsed(&self) -> KTime {
+        self.since(T::now()).unwrap_or_else(|| {
+            pr_err!(
+                "Monotonic clock {} went backwards!",
+                core::any::type_name::<T>()
+            );
+            KTime::from_raw(0)
+        })
+    }
+}
+
+/// Contains the various clock source types available to the kernel.
+pub mod clock {
+    use super::*;
+
+    /// A clock representing the default kernel time source (`CLOCK_MONOTO=
NIC`).
+    pub struct KernelTime;
+
+    impl Monotonic for KernelTime {}
+    impl Clock for KernelTime {
+        #[inline]
+        fn now() -> Instant<Self> {
+            // SAFETY: It is always safe to call `ktime_get` outside of NM=
I context.
+            Instant::<Self>::new(KTime::from_raw(unsafe { bindings::ktime_=
get() }))
+        }
+    }
+}
--=20
2.43.0


