Return-Path: <linux-kernel+bounces-118067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC61E88B66F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D07B2AD46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BAF6FE27;
	Mon, 25 Mar 2024 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="P/3B1GTf"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABDF5A4D3;
	Mon, 25 Mar 2024 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403804; cv=none; b=Q18Tkmkfo1UjmHsd93HcR2aFnnMudK9qijMHO0QfFOFKRXdIJFAIODIw/r9lrv56mz3C58RRk9ECz0lJNDl2/bDndXWTFLUcORasU7/c+YjGJKjyFej5grNIdDwfH2HO9mkiVr7o8YRoe7TmU+3jaRcECA/qMI/Wb75sqbtc3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403804; c=relaxed/simple;
	bh=xSuiLJKJgLrr21rIadSu5fyq8t/EMn4wKpn41CCECRI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9tKwhdJF5opyaEwsB1qzzVTE1Ml/4u7LXzmRmgh94hMYwlhCC5OtqN7+OQtEyuN1V81WvMIhlW5lvL94Obqg5+tdPix9vSrrkQt5kDOBk+f1Xx47uPmggcopKH8qqiyfmSY9y9OFuzbofjLX89qqKJSmdeFAjqh1K0cas6R5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=P/3B1GTf; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=jgurfofczvevtg3jg4ynhn3lsy.protonmail; t=1711403799; x=1711662999;
	bh=Dz6q83jJ87/t3Ux+v9A/Asnbjs+qqD36qRD+CLPZW0Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=P/3B1GTfjq/JZeCR+3RvCiPu+ikuPAfj44GV/OZk4fqTuOlH1BBZ6wflegTV8HuxD
	 aA0m26FIZxUVVCEQAtwnXs4IjCGNFhcJH1p/DanHmXgOG0sgq8mLud99heF1aN62dI
	 hxFLj7t7DcH/2XSsmwdILsy3hrAWQLOFe8Hj7/xIiUFrNwacHBUPS7QQ8ok+D2Baqo
	 9SsPj6ZHxElQGGbDOdZlNPWxdMUcCh9BLpH9kB7KRVgG0QZ3iOwPU9xGIkTidsNZXv
	 IRHP5BmupgS2U8DuSxie0CsdToFZkWYBNidzQ8DBHCikYW9uprHFLDDUHQNzN1aO2C
	 YCOwjPyIJUcRQ==
Date: Mon, 25 Mar 2024 21:56:30 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 01/10] rust: kernel: move `allocator` module under `alloc`
Message-ID: <-uzW9xCfocYgSqqwoHB8D6k5CKhc5Rxnrmjq9N8XmTTNVZI3CYHIK9uigpGprs7EDYHWkALopDuv7e9w_FVfZW-9iGh3VlV9WpuSAKAWhFc=@proton.me>
In-Reply-To: <20240325195418.166013-2-wedsonaf@gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-2-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.03.24 20:54, Wedson Almeida Filho wrote:> From: Wedson Almeida Filho =
<walmeida@microsoft.com>
>=20
> We will add more to the `alloc` module in subsequent patches (e.g.,
> allocation flags and extension traits).
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

One nit below, but feel free to add:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>   rust/kernel/alloc.rs                 | 7 +++++++
>   rust/kernel/{ =3D> alloc}/allocator.rs | 0
>   rust/kernel/lib.rs                   | 4 +---
>   3 files changed, 8 insertions(+), 3 deletions(-)
>   create mode 100644 rust/kernel/alloc.rs
>   rename rust/kernel/{ =3D> alloc}/allocator.rs (100%)
>=20
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> new file mode 100644
> index 000000000000..ccd4149932c3
> --- /dev/null
> +++ b/rust/kernel/alloc.rs
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Allocation support.

I think 'Extensions to the `alloc` crate.' fits better.

--=20
Cheers,
Benno

> +
> +#[cfg(not(test))]
> +#[cfg(not(testlib))]
> +mod allocator;
> diff --git a/rust/kernel/allocator.rs b/rust/kernel/alloc/allocator.rs
> similarity index 100%
> rename from rust/kernel/allocator.rs
> rename to rust/kernel/alloc/allocator.rs
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index be68d5e567b1..51f30e55bd00 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -28,9 +28,7 @@
>   // Allow proc-macros to refer to `::kernel` inside the `kernel` crate (=
this crate).
>   extern crate self as kernel;
>=20
> -#[cfg(not(test))]
> -#[cfg(not(testlib))]
> -mod allocator;
> +pub mod alloc;
>   mod build_assert;
>   pub mod error;
>   pub mod init;
> --
> 2.34.1
> 

