Return-Path: <linux-kernel+bounces-119533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED688C9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735B51F65190
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9113D53C;
	Tue, 26 Mar 2024 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Bq8BxIi3"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3834F13C91F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472453; cv=none; b=RpqIDl7NVPM39En5IKJ1zcaSYr9madK8/aOpPJwJ7lreFvgFUD5Eb6ZdFdtKTKMox9OUezwM7yvmfV+4Wgu4sTCCHvRmIp10m2kcTeuD/yzYuCBfA75llAltPu+8Hh5R83A/zNgi3wF0dz1gCMxOlBlQE//zqTEtMlX4SN+W64Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472453; c=relaxed/simple;
	bh=CtLOcxudgrp9+pmo6QzQf8rk8HsbaSoWbUzcGjkYPpg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cp7leSTq6+XGnB9eV8vFpz/lOaQHPU52QGyV7Ph4m59JNPMVmQWZb017lepR1WK1nfaz+qyhCePlLWE2YDBRLrC77PGcBuV9uDAR3Nn6pdIAHFAdGNtQH7d7mdX69V1pgiW2vb2HaFkYAIpar7+81Jb0S8k0A/YvK2obKibavpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Bq8BxIi3; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711472449; x=1711731649;
	bh=JbKvJkvXu2iWSuwGdU1AIzET2bU96rDLVAc7bBO6aLw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Bq8BxIi3qd+9EkR1NWQWDt5q8Prr2Fm1Ac2IhTEUUxaOW6KBU6GWhluOBpMaSl6y7
	 01zCTsOYMhDrhWApuTstxbepjc5uWNulk81Ew5AXYb0OR21s87HSZ+i5Fd30Qmc1DM
	 rORVqAYnEwmGmZ0y7aU9/KmybTyYTwb4lHJMCVb3zo3Ol4yMcB+pL1jQzAEEVpOejO
	 zkxvrhp5SWXKIIZ/sk1tKtBmuWVHbJmtpsMppUAK32D1Y9Xu/HDJTZ+CiPWZICWYHM
	 nzmr0IzmCKKcUn4/LLV36U7MZn5hqbGGxNdnpCufxVte8Gv5kJommIzKvKy5+NHeJy
	 GebvbgHJdWLcw==
Date: Tue, 26 Mar 2024 17:00:39 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Valentin Obst <kernel@valentinobst.de>, Heghedus Razvan <heghedus.razvan@protonmail.com>, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 3/5] rust: time: Introduce clock reading framework
Message-ID: <c2XJe4xCqT5WrHu9XZKQ03ggEZLwd2KBuSBb9Onivny9v7fqKBkm1aywmztjiDyuLKqr2Igt_6XUJiuArLl9JVwq0xa4gKfocP2H5YZDrFk=@proton.me>
In-Reply-To: <20240324223339.971934-4-boqun.feng@gmail.com>
References: <20240324223339.971934-1-boqun.feng@gmail.com> <20240324223339.971934-4-boqun.feng@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.03.24 23:33, Boqun Feng wrote:
> To make sure Rust code doesn't mix timestamps from different clocks, a
> type safe clock reading framework is introduced. It includes:
>=20
> * A `Clock` trait that represents different clocks, to read a particular
>   clock, one needs implement the `Clock::now()` function.
>=20
> * A `Instant<Clock>` type that represents timestamps of different
>   clocks, whose implementation is just a `ktime_t`, so all the
>   calculation on `ktime_t` should apply to it as well.
>=20
> Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> Signed-off-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> Co-developed-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/time.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>=20
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index b238b3a4e899..0f9f5605ed48 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -6,6 +6,9 @@
>  //! have been ported or wrapped for usage by Rust code in the kernel.
>  //!
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.=
h).
> +//! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
> +
> +use core::marker::PhantomData;
>=20
>  /// The number of nanoseconds per millisecond.
>  pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
> @@ -64,3 +67,49 @@ pub fn to_ns(self) -> i64 {
>          self.inner
>      }
>  }
> +
> +/// Represents a clock, that is, a unique time source and it can be quer=
ied for the current time.
> +pub trait Clock: Sized {
> +    /// Returns the current time for this clock.
> +    fn now() -> Instant<Self>;
> +}
> +
> +/// Marker trait for clock sources that are guaranteed to be monotonic.
> +pub trait Monotonic {}

Why is this trait not an extension of `Clock`?

> +
> +/// A timestamp of a given [`Clock`]

Missing '.'.

> +#[repr(transparent)]
> +#[derive(Debug)]
> +pub struct Instant<T: Clock> {
> +    inner: bindings::ktime_t,
> +    clock: PhantomData<T>,
> +}
> +
> +impl<T: Clock> Clone for Instant<T> {
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<T: Clock> Copy for Instant<T> {}
> +
> +impl<T: Clock> Instant<T> {
> +    fn new(ktime: bindings::ktime_t) -> Self {

When compiling, this function is marked as dead-code in this patch.

--=20
Cheers,
Benno

> +        Self {
> +            inner: ktime,
> +            clock: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T: Clock> core::ops::Sub for Instant<T> {
> +    type Output =3D Duration;
> +
> +    /// Returns the difference of two timestamps.
> +    #[inline]
> +    fn sub(self, other: Self) -> Self::Output {
> +        // `ktime_t` is an `i64` value of nanoseconds, and kernel define=
s signed overflow to behave
> +        // like 2s-complement, hence `wrapping_sub()` is used here to mi=
rror `ktime_sub()`.
> +        Duration::new(self.inner.wrapping_sub(other.inner))
> +    }
> +}
> --
> 2.44.0
> 

