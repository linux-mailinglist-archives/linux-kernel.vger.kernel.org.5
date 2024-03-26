Return-Path: <linux-kernel+bounces-119566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D085F88CA82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FE3322F92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8016E1CA8C;
	Tue, 26 Mar 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AY/oPqhF"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8C1C69C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473231; cv=none; b=LlT3fSxKOuaIcbf8Jts7dhWLU8d7UXTIO5aSKtq4qKKh2cHkSgOChl1a2BoU6QUMxvYlt6njFZhuONL5aKybnPIFsRuiOHHBSgDkUbfmri1DKC4ZJxRJDOYdJUQHknsW71GP0rZdNTIrps89zyLMzeJIX/6sNHhbd/Ay1TIDlRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473231; c=relaxed/simple;
	bh=FrW4urb3kaGNnmCDOoJ/pJREbGJJEOcKrsesprEishU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLzCMJWu+l2U63EBcs32gnMWVG8YFufiKz75jlEdN+vEtqBHTBEATnBlYZ/l3YpCm2Z2xlBjgKOXGAVbOlJ/DJMvFnJawYWuSRsgrnhZ9KN+jxFnJxWxS2gSAT0VINeQL6aL7nPtfSJxqhjok2Oabuj+Wxo6FJSCJZENyRXxK40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AY/oPqhF; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711473227; x=1711732427;
	bh=2SMAljw4XINFd821G0mOj/hS2BbJyOq2IwtofbwqjYM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AY/oPqhFT+U/f9Jb34/v0EuZ9Y6G7v5QpAIgG/qKhmEwTwMQUg7LVx9edtm/wvfAL
	 BuqY0+sQf8DmK2UUU+uVyDSyq6pLg3e4KJuKvcBXjqUxc8aNbyRr+QiWOX08grkAhX
	 JyNDw4gxpYj+SRlWsyCK7i3yWoQG8Z5KEVqCGEQzKASxoubipZoicMK4lWlv5acRub
	 6ynza26Kypc8FdmGPTTI+sSkCYSV+/5bUSaHEDV9wW2nbhgnvAR6z8qNcyENN+CtG7
	 9d4zQNfcpM15EZtUJgE2ww478Un+/QI3FVMe0jIcdqskzR9Wuzc2Z1zoP3cwxX05N1
	 AS2FY5L160fug==
Date: Tue, 26 Mar 2024 17:13:38 +0000
To: Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Valentin Obst <kernel@valentinobst.de>, Heghedus Razvan <heghedus.razvan@protonmail.com>, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 5/5] rust: time: Add Instant::elapsed() for monotonic clocks
Message-ID: <kZmwObXVcyEJFVR3I05Nab0WdjcccDVARoOm6U9EmXhd89fxYRjvNmEAUZsueWTUlBlHp8jpU3i2YfgN9aWCLZameta0tPT_OgQdBOWUIko=@proton.me>
In-Reply-To: <20240324223339.971934-6-boqun.feng@gmail.com>
References: <20240324223339.971934-1-boqun.feng@gmail.com> <20240324223339.971934-6-boqun.feng@gmail.com>
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
> This is a convenient way to do:
>=20
> =09t1 =3D Clock::now();
> =09...
> =09delta =3D  Clock::now() - t1;
>=20
> Hence add it.
>=20
> Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> Signed-off-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> Co-developed-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/time.rs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 5cd669cbea01..cd1e45169517 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -114,6 +114,31 @@ fn sub(self, other: Self) -> Self::Output {
>      }
>  }
>=20
> +impl<T: Clock + Monotonic> Instant<T> {
> +    /// Returns the time elapsed since this [`Instant`].
> +    ///
> +    /// This provides a convenient way to calculate time elapsed since a=
 previous [`Clock::now`].
> +    /// Note even though the function only exists for monotonic clocks, =
it could still return
> +    /// negative [`Duration`] if the current time is earlier than the ti=
me of `&self`, and this
> +    /// could happen if `&self` is a timestamp generated by a [`Instant`=
] + [`Duration`].

But there currently is no way to add an `Instant<T>` to a `Duration`.

> +    ///
> +    /// But for typical usages, it should always return non-negative [`D=
uration`]:
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::time::{Clock, clock::KernelTime};
> +    ///
> +    /// let ts =3D KernelTime::now();
> +    ///
> +    /// // `KernelTime` is monotonic.
> +    /// assert!(ts.elapsed().to_ns() >=3D 0);

Now that I thought a bit more about the design, I think allowing
negative durations is a bad idea.
Do you disagree?

If there is a case where you have a non-monotonic clock, or you are not
sure if two timestamps are in the correct relation, we could have a
function that returns a `Option<Duration>` or `Result<Duration>`.

--=20
Cheers,
Benno

> +    /// ```
> +    pub fn elapsed(&self) -> Duration {
> +        T::now() - *self
> +    }
> +}
> +
>  /// Contains the various clock source types available to the kernel.
>  pub mod clock {
>      use super::*;
> --
> 2.44.0
> 

