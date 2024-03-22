Return-Path: <linux-kernel+bounces-111257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084098869CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39F11F2426B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD60C23778;
	Fri, 22 Mar 2024 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="b19OwU7R"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A3224CF;
	Fri, 22 Mar 2024 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101417; cv=none; b=bQMEHZbC8KfH1IsNC1Hw8caBFOuA6zRpwtf+s2tG38hjg8NMrItjGF2e8btvtWLcdNfEe+wLsR8fmMJX+lrXuHR1hOZh4ZkFg6YJgAWXg9HOFwNHEFkLZA5BWWyEjoL1j8EUG3TSCLVaOVE1bfNhWsLHpwzDH2xdKZ/lxoKsNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101417; c=relaxed/simple;
	bh=WKWZ/KICR+3/pNg0wrbFmwo4Yb28kZbDtGwYfzPTtko=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2YkkcNgeNao7ogszT2K2whY1wtj+xLtvm1SQxhh/KHVQDSo+wUVbHsAPv2z+Fnq6ZUZsBxHK8psVe5AAEu+1QVl/fvWW+LZqWsql7lQTY/Qm/pLnqvVNlz2cT4/EuPXH7Hi1uW2XaFfmFKlUd6n2aijegXHtjCex7u7oBssJwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=b19OwU7R; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=modqwmhza5bkfgbjxu6nf6ij3m.protonmail; t=1711101412; x=1711360612;
	bh=YAAnBuxNM7tVgIu9+wxVQ7JSvFKV0lJF3itk6SdkcfE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b19OwU7RLVBUrXyLzmCIuleRw6VLcau5MD21ndRCbpwNJGwisIvcSbnTFXHPfLSnj
	 vKfM1cZj0wBkwQTbou81ZUm/4dEJ2oIihIZZHxC2DLQIeLlqM4zEPG5kqVw/1yO8P3
	 l4fJufGtV+KBxhch9/OPkCuERVXIC0XHz+AFrkIgasjXLVutgl8lAOsFr/qgJoSbyI
	 4fCA6yhSi5Uyi7XiaYVRnCWRHzKP+ukZo0jS3F7jftc4JreVGhWpYNh1kW4SPamNc4
	 q+klWutUh9skCoLnfT/5mZOyQUWi4NtqDVDKnxTUUuZL1lnnhtXED90FJCIx9rRlpT
	 fu6YbZI3/UokA==
Date: Fri, 22 Mar 2024 09:56:36 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: time: add Ktime
Message-ID: <2ecf6529-5408-4621-becc-2f30e1039079@proton.me>
In-Reply-To: <20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com>
References: <20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/22/24 09:59, Alice Ryhl wrote:
> Introduce a wrapper around `ktime_t` with a few different useful
> methods.
>=20
> Rust Binder will use these bindings to compute how many milliseconds a
> transaction has been active for when dumping the current state of the
> Binder driver. This replicates the logic in C Binder [1].
>=20
> For a usage example in Rust Binder, see [2].
>=20
> The `ktime_get` method cannot be safely called in NMI context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [3] or a similar tool will be used to check it in the future.
>=20
> Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830f=
ab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
> Link: https://r.android.com/3004103 [2]
> Link: https://rust-for-linux.com/klint [3]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

I have one comment below, I don't mind leaving it as-is:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
> Changes in v2:
> - Mention that ktime_get cannot be safely called in NMI context.
> - Link to v1: https://lore.kernel.org/r/20240320-rust-ktime_ms_delta-v1-1=
-ccb8672a0941@google.com
> ---
>   rust/kernel/time.rs | 60 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 60 insertions(+)
>=20
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 25a896eed468..6811d5cadbd4 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -5,6 +5,9 @@
>   //! This module contains the kernel APIs related to time and timers tha=
t
>   //! have been ported or wrapped for usage by Rust code in the kernel.
>=20
> +/// The number of nanoseconds per millisecond.
> +pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
> +
>   /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
>   pub type Jiffies =3D core::ffi::c_ulong;
>=20
> @@ -18,3 +21,60 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
>       // matter what the argument is.
>       unsafe { bindings::__msecs_to_jiffies(msecs) }
>   }
> +
> +/// A Rust wrapper around a `ktime_t`.
> +#[repr(transparent)]
> +#[derive(Copy, Clone)]
> +pub struct Ktime {
> +    inner: bindings::ktime_t,
> +}
> +
> +impl Ktime {
> +    /// Create a `Ktime` from a raw `ktime_t`.
> +    #[inline]
> +    pub fn from_raw(inner: bindings::ktime_t) -> Self {
> +        Self { inner }
> +    }
> +
> +    /// Get the current time using `CLOCK_MONOTONIC`.
> +    #[inline]
> +    pub fn ktime_get() -> Self {
> +        // SAFETY: It is always safe to call `ktime_get` outside of NMI =
context.
> +        Self::from_raw(unsafe { bindings::ktime_get() })
> +    }
> +
> +    /// Divide the number of nanoseconds by a compile-time constant.
> +    #[inline]
> +    fn divns_constant<const DIV: i64>(self) -> i64 {
> +        self.to_ns() / DIV
> +    }
> +
> +    /// Returns the number of nanoseconds.
> +    #[inline]
> +    pub fn to_ns(self) -> i64 {
> +        self.inner
> +    }
> +
> +    /// Returns the number of milliseconds.
> +    #[inline]
> +    pub fn to_ms(self) -> i64 {
> +        self.divns_constant::<NSEC_PER_MSEC>()
> +    }
> +}
> +
> +/// Returns the number of milliseconds between two ktimes.
> +#[inline]
> +pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
> +    (later - earlier).to_ms()
> +}

Is there a reason for this function being standalone?

--=20
Cheers,
Benno

> +
> +impl core::ops::Sub for Ktime {
> +    type Output =3D Ktime;
> +
> +    #[inline]
> +    fn sub(self, other: Ktime) -> Ktime {
> +        Self {
> +            inner: self.inner - other.inner,
> +        }
> +    }
> +}
>=20
> ---
> base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
> change-id: 20240320-rust-ktime_ms_delta-74b00c9ab872
>=20
> Best regards,
> --
> Alice Ryhl <aliceryhl@google.com>
>=20


