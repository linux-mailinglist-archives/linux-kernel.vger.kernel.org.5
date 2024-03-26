Return-Path: <linux-kernel+bounces-119140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E33D88C4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400511C615FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB412BF05;
	Tue, 26 Mar 2024 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="N6Adbbgg"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB8112B17E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462103; cv=none; b=RXDAhRw2x7cv4drnZUYWvO528R9Kyw90y1E9ejjuMog0x6yxJNcRzlDKwCovdvYWirP65DqLPFGmMoZjQSIbSssq0XOVP16xpd7BQJ88s3SmfZMK9V2AeAwe72lfhKzWpQrW9f7WcubKErfPgu8ZtGwsjhzcJZEqNAmiLQTsy+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462103; c=relaxed/simple;
	bh=nXoAUhc7XKG3E9m4AJ3lF49JqT9r8jaxsr9VCcXGEiU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OG3Og3/UOppBw6mGbAEtdp+r9R/LJxJEct+0pZ9X4ZX3lEyZuCctJA4ym8HGqJnnrZmH133dK9UykTxDpMRi4C6ASgTA7uudxFOIgiDfwpC9bgFz7Ah5uGyeVs+ElCIpYvlkwXqZ0EqtZrGmLQdcK8oiCdqD5Qh870xcXtWtwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=N6Adbbgg; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711462099; x=1711721299;
	bh=ygtCkVMY1u+TmO6tCQeJusdDZZEhvhbXgk+XZTvcwDA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=N6AdbbggLgumVhxke7MmXSZKAMa/y/7nIj0WqHxG8PAgIXF3s87P7fTpf9rPcpZR+
	 2frHZ22MGhZOaMcGxm1/v0y9HD+sWktcOrUYvjtQ+YCk1K2O0JOe1HlL9mx0QXRr3w
	 Vly60E1DZQQbaEsBqKCjmDm2A1f65aEEV4Yjp4om6bv5kXBFVpAAKYoY2s/ntPeNjQ
	 mp9u8J4Ln5sOz9aynHG5xjq80/ii4JfnW5LIeBO8G5sRRFncZpbIU886ezAhqGtcpS
	 kxxOiuin9cRSZZDjEA9LiLn2vxlBDh+B+//hQZkPCp5NzUh+zKAtgLLKlaXLcWTaot
	 Gt0oHf1SW7o0w==
Date: Tue, 26 Mar 2024 14:08:10 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 09/10] rust: init: update `init` module to take allocation flags
Message-ID: <kiqpEglPExNZBB0TsooPwQsQTwFfYadAnVfztU9sFzYJ5CU_Rg0PC_KYEQF4duxv7qOo6gOBUFVnR-GfuEsIEYqgBSWnOGEZAcl3t06cB2s=@proton.me>
In-Reply-To: <20240325195418.166013-10-wedsonaf@gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-10-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.03.24 20:54, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> This is the last component in the conversion for allocators to take
> allocation flags as parameters.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/kernel/init.rs               | 49 ++++++++++++++++---------------
>   rust/kernel/sync/arc.rs           | 17 ++++++-----
>   rust/kernel/sync/condvar.rs       |  2 +-
>   rust/kernel/sync/lock/mutex.rs    |  2 +-
>   rust/kernel/sync/lock/spinlock.rs |  2 +-
>   rust/kernel/workqueue.rs          | 13 +++++---
>   6 files changed, 47 insertions(+), 38 deletions(-)

One formatting issue below, with that fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 077200f5350b..af539c5eb4bc 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -565,13 +565,16 @@ pub fn new(value: T, flags: Flags) -> Result<Self, =
AllocError> {
>       }
>=20
>       /// Tries to allocate a new [`UniqueArc`] instance whose contents a=
re not initialised yet.
> -    pub fn new_uninit(_flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>=
, AllocError> {
> +    pub fn new_uninit(flags: Flags) -> Result<UniqueArc<MaybeUninit<T>>,=
 AllocError> {
>           // INVARIANT: The refcount is initialised to a non-zero value.
> -        let inner =3D Box::try_init::<AllocError>(try_init!(ArcInner {
> +        let inner =3D Box::try_init::<AllocError>(
> +            try_init!(ArcInner {
>               // SAFETY: There are no safety requirements for this FFI ca=
ll.
>               refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }=
),
>               data <- init::uninit::<T, AllocError>(),
> -        }? AllocError))?;
> +        }? AllocError),
> +            flags,
> +        )?;

The indentation looks wrong, rustfmt sadly cannot handle the pin-init
macros. This looks better to me:

        let inner =3D Box::try_init::<AllocError>(
            try_init!(ArcInner {
                // SAFETY: There are no safety requirements for this FFI ca=
ll.
                refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }=
),
                data <- init::uninit::<T, AllocError>(),
            }? AllocError),
            flags,
        )?;

--=20
Cheers,
Benno

>           Ok(UniqueArc {
>               // INVARIANT: The newly-created object has a refcount of 1.
>               // SAFETY: The pointer from the `Box` is valid.

