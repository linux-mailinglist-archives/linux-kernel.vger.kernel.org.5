Return-Path: <linux-kernel+bounces-121320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCDA88E5EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2951C2D530
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32636137765;
	Wed, 27 Mar 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ibw6LTki"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C248137749;
	Wed, 27 Mar 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543864; cv=none; b=UNwp+tFf2KJiXywTxDjTLc+hbZDUhR7sToMva1/BSzedcAhpHwwQo7OTMiKPDS1SzNLIULQHKqXtkl0otMVi2qJN/kbybd3b0vli31Qk7aFeqQsmZQgJKZUmReeiVLr+zLXWVFZNmSGq9Ktse/YE9q8sGvM6OCpKauUTbR3RmGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543864; c=relaxed/simple;
	bh=fS6w+vfuAACucWDgPNQUe9sHdSzc9iZ6l94DU6VIXaE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ly1rbfcYVrHunAlDlZnXOmPmFbw9qcUETWXlD04M5kFPGoGcQUcxTzt10gcSs0JXydSA9j/TMo//xU0ZbGR1VeLoLc2ey8a7WH22GnbNkLqEJuhPmEJtxSEfQayh+VZKfF8Gj4ayIM7HWwfkF7xSdvDqx+RuiBovkAfuIubyGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ibw6LTki; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=bg2oeawsjrhsloml6ikhsg4wbq.protonmail; t=1711543858; x=1711803058;
	bh=C9j9icvWUZHeELj3CV4tqk50BX3HHFMwnJFINnp3JyA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ibw6LTkilVdqr0qEI8usHh8AwwoXiGLXoMeLzij9jCyAumZ3KbLR+osG5mA6YuTMK
	 vjzDwDCh+hX9VSjsXNfEW6osXZ+xpLDU4UGhH3UwpU2s8AoQO3JXEb2zHNlVlovhoS
	 7Ryba8py5YHDy50y5JU0kq60SSkv/y5WTidZNBXh0Dx4sc6mUG4hU3mJusbFMWlaZJ
	 DXLF1rM2g9WLJ7emOjQdFhHmgf7CM9yoUe3tRIDFEqXTXS6/GOHNKZc8pTCHMBzhxG
	 Bu1cJADKtBkGldTzEcaR1Kze0Q49wyiw2yslPPo1F8jdNh5Nucax8MnZEd0rzCzp71
	 Rb4s7UBt2wcAA==
Date: Wed, 27 Mar 2024 12:50:50 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Valentin Obst <kernel@valentinobst.de>, Heghedus Razvan <heghedus.razvan@protonmail.com>, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 3/5] rust: time: Introduce clock reading framework
Message-ID: <15DXPOXjBar-JYHVrrgVXI_f3BF5JenfeXEmmxgra6my42Ot9O9Wrc-nc-0O13C5EFTnm0SDac1Muau15mHLmb4So2292uALNSwXKoK75FQ=@proton.me>
In-Reply-To: <ZgMfsaiOlA87PAUf@boqun-archlinux>
References: <20240324223339.971934-1-boqun.feng@gmail.com> <20240324223339.971934-4-boqun.feng@gmail.com> <c2XJe4xCqT5WrHu9XZKQ03ggEZLwd2KBuSBb9Onivny9v7fqKBkm1aywmztjiDyuLKqr2Igt_6XUJiuArLl9JVwq0xa4gKfocP2H5YZDrFk=@proton.me> <ZgMfsaiOlA87PAUf@boqun-archlinux>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.03.24 20:19, Boqun Feng wrote:
> On Tue, Mar 26, 2024 at 05:00:39PM +0000, Benno Lossin wrote:
>> On 24.03.24 23:33, Boqun Feng wrote:
>>> To make sure Rust code doesn't mix timestamps from different clocks, a
>>> type safe clock reading framework is introduced. It includes:
>>>
>>> * A `Clock` trait that represents different clocks, to read a particula=
r
>>>    clock, one needs implement the `Clock::now()` function.
>>>
>>> * A `Instant<Clock>` type that represents timestamps of different
>>>    clocks, whose implementation is just a `ktime_t`, so all the
>>>    calculation on `ktime_t` should apply to it as well.
>>>
>>> Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
>>> Signed-off-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
>>> Co-developed-by: Asahi Lina <lina@asahilina.net>
>>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>>> ---
>>>   rust/kernel/time.rs | 49 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>>   1 file changed, 49 insertions(+)
>>>
>>> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
>>> index b238b3a4e899..0f9f5605ed48 100644
>>> --- a/rust/kernel/time.rs
>>> +++ b/rust/kernel/time.rs
>>> @@ -6,6 +6,9 @@
>>>   //! have been ported or wrapped for usage by Rust code in the kernel.
>>>   //!
>>>   //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffi=
es.h).
>>> +//! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h)=
.
>>> +
>>> +use core::marker::PhantomData;
>>>
>>>   /// The number of nanoseconds per millisecond.
>>>   pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
>>> @@ -64,3 +67,49 @@ pub fn to_ns(self) -> i64 {
>>>           self.inner
>>>       }
>>>   }
>>> +
>>> +/// Represents a clock, that is, a unique time source and it can be qu=
eried for the current time.
>>> +pub trait Clock: Sized {
>>> +    /// Returns the current time for this clock.
>>> +    fn now() -> Instant<Self>;
>>> +}
>>> +
>>> +/// Marker trait for clock sources that are guaranteed to be monotonic=
.
>>> +pub trait Monotonic {}
>>
>> Why is this trait not an extension of `Clock`?
>>
>=20
> This was carried over from the old version, for myself, it doesn't make
> much difference between:
>=20
> =09trait A { .. }
> =09trait B { .. }
>=20
> =09impl<T: A + B> ...
>=20
> vs
>=20
> =09trait A { .. }
> =09trait B: A { .. }
>=20
> =09impl<T: B> ...
>=20
> hence I kept it as it is, but yes, it a `Monotonic` *`Clock`*, so I will
> change it in the next version.

I think it would also make sense to rename it to `MonotonicClock`.

>=20
>>> +
>>> +/// A timestamp of a given [`Clock`]
>>
>> Missing '.'.
>>
>=20
> Fixed locally.
>=20
>>> +#[repr(transparent)]
>>> +#[derive(Debug)]
>>> +pub struct Instant<T: Clock> {
>>> +    inner: bindings::ktime_t,
>>> +    clock: PhantomData<T>,
>>> +}
>>> +
>>> +impl<T: Clock> Clone for Instant<T> {
>>> +    fn clone(&self) -> Self {
>>> +        *self
>>> +    }
>>> +}
>>> +
>>> +impl<T: Clock> Copy for Instant<T> {}
>>> +
>>> +impl<T: Clock> Instant<T> {
>>> +    fn new(ktime: bindings::ktime_t) -> Self {
>>
>> When compiling, this function is marked as dead-code in this patch.
>>
>=20
> Hmm... I cannot trigger any compile errors with this patch. If you see
> an error, could you share the build command? It's not a `pub` function
> though.

I created a fresh config using `menuconfig` and enabled CONFIG_RUST.
Then I get this error:

    error: associated function `new` is never used
      --> rust/kernel/time.rs:97:8
       |
    96 | impl<T: Clock> Instant<T> {
       | ------------------------- associated function in this implementati=
on
    97 |     fn new(ktime: bindings::ktime_t) -> Self {
       |        ^^^
       |
       =3D note: `-D dead-code` implied by `-D warnings`
       =3D help: to override `-D warnings` add `#[allow(dead_code)]`
   =20
    error: aborting due to 1 previous error

Note that the error vanishes in the next patch, since there you do have
a user for `new`.

--=20
Cheers,
Benno

