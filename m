Return-Path: <linux-kernel+bounces-119510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0F988C9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9D61F825E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6794617543;
	Tue, 26 Mar 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kUb1cvG0"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF412E75
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471826; cv=none; b=nrlewx5Hzbbss1UNmgIwxdGKHh2Sou9dSGJAnufGOOadw8x4BBch112kMHzJPZgr1XS7h0T7eLWg8u5TlNs/f0faLi8ur35TnoIsDiqVDcJWE1edVcIEoOlxuIEJXjm+1tLlKi+9gb6A4+fgooSfWpqkbJ37qsbMxnATXswKnFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471826; c=relaxed/simple;
	bh=thkwkBIp8sKzplRqO5fWwXLASWkgEarF09La/1n1ueI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqKQ3A4yEwqYTVu18iUILxK195vUGBHc2Y858/0u6/XVpmmqd6RcSATDi5UwxmX8AJur2/ZxaK5royX9mennTadBowNeeCkj7Dmxa40DLWujek/vomhnuAF0RhHZj27yBD00XmKDWCHj7VSzyQfVR/4aJqTxGp+fb8OH3o8tzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kUb1cvG0; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711471816; x=1711731016;
	bh=M8iwvbhpOATjweWhFPW47CfCpl16/7tE0ZvIX5/xl+w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kUb1cvG01FEm4rdZce80HUbXy4mjznFQk4QaeC8LbDvBgKvy3xh6AIaiCkff6/w3j
	 I8rcFMEbjQyWYAhUXA/gzWagE/vqGcDF1wCfwFr0Bu96pufim1nmvP4ZcgtMgY0cm6
	 2hYwrHVW4GGfetKKajDTCrQ3+njeyYvlGDQSMaMn2o/Tm+26ClvNXZEgI0+5NLvJcb
	 R+cEkvVbQ1nKCrMazbgxSihRo7qbQLL50rjbll5AHyGKpzR1xx7dH/fBN9wt6qgs8Y
	 4iuYWp5bFtoT13R/6ctU4H9wtnYOmv+TR0cXOHKlaHISDmFDmdiIkHRf6YzfAk58Cy
	 IZXcWBtiQIZfw==
Date: Tue, 26 Mar 2024 16:50:02 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH 2/5] rust: time: Introduce Duration type
Message-ID: <4hYJbftgOk1JOPbJ6CfKZell6ngp8GljwIUIB1vOQvIf-7jiogG5xDtCvcMlF7cIJAdy9fO5HLQh_8ohnWNB3MAaj0xjAGeyyDowemgunOU=@proton.me>
In-Reply-To: <20240324223339.971934-3-boqun.feng@gmail.com>
References: <20240324223339.971934-1-boqun.feng@gmail.com> <20240324223339.971934-3-boqun.feng@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.03.24 23:33, Boqun Feng wrote:> From: Alice Ryhl <aliceryhl@google.co=
m>
>=20
> Introduce a type representing time duration. Define our own type instead
> of using `core::time::Duration` because in kernel C code, an i64
> (ktime_t) is used for representing time durations, an i64 backed
> duration type is more efficient when interacting with time APIs in C.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> [boqun: Rename `Ktime` to `Duration`, and make it a type of durations]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/time.rs | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>=20
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index bbb666e64dd7..b238b3a4e899 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -7,6 +7,9 @@
>  //!
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.=
h).
>=20
> +/// The number of nanoseconds per millisecond.
> +pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
> +
>  /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
>  pub type Jiffies =3D core::ffi::c_ulong;
>=20
> @@ -20,3 +23,44 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
>      // matter what the argument is.
>      unsafe { bindings::__msecs_to_jiffies(msecs) }
>  }
> +
> +/// A time duration.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let one_second =3D kernel::time::Duration::new(1000_000_000);
> +///
> +/// // 1 second is 1000 milliseconds.
> +/// assert_eq!(one_second.to_ms(), 1000);
> +/// ```
> +#[repr(transparent)]
> +#[derive(Copy, Clone, Debug)]
> +pub struct Duration {
> +    inner: i64,

Why not use the name `ns` or `nanos`?

> +}
> +
> +impl Duration {
> +    /// Creates a new duration of `ns` nanoseconds.
> +    pub const fn new(ns: i64) -> Self {
> +        Self { inner: ns }
> +    }
> +
> +    /// Divides the number of nanoseconds by a compile-time constant.
> +    #[inline]
> +    fn divns_constant<const DIV: i64>(self) -> i64 {
> +        self.to_ns() / DIV
> +    }

I am a bit confused, why is this better than writing
`self.to_ns() / DIV` at the callsite?

--=20
Cheers,
Benno

> +
> +    /// Returns the number of milliseconds.
> +    #[inline]
> +    pub fn to_ms(self) -> i64 {
> +        self.divns_constant::<NSEC_PER_MSEC>()
> +    }
> +
> +    /// Returns the number of nanoseconds.
> +    #[inline]
> +    pub fn to_ns(self) -> i64 {
> +        self.inner
> +    }
> +}
> --
> 2.44.0
> 

