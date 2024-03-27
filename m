Return-Path: <linux-kernel+bounces-121394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD6188E762
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D14301FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C533B15DBDD;
	Wed, 27 Mar 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="grTOPeG+"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA3F15DBC5;
	Wed, 27 Mar 2024 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547634; cv=none; b=RIJM9NUBEQKFqGJjm/cu/Z41wWTxN+RYUeGuFHzBxSXaC1i4nhhcIbGj176GEYFbbabMxJ25qL0x9xcH3rD0PW340ZTJyxRcRXSkH5jsLSmJcYuiWCTUtUQdS7TzQ3rNiUo6kqXl2Sx3qEvh/U6SllR4DnAUm2b+GQvGBJORVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547634; c=relaxed/simple;
	bh=PYKcrln81x8z3Qo4vIUuoUg+0Pyz3VOd7xpWYi5tU+M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GY+pBBBoG1BJXCBfItFf/6uJGrBobDpIByYAKEsypbErresS+Nz7SEh/RvLDcy0r53qBt8oFjymUqkNS1386xIcQ7zpgCzBI7EdU74cEAjb9rI0ZzcdTZABnU1ULgwRddQ8+80mlEUky0qVJnOI47shTQaJ0o/GxlweWrBzxpSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=grTOPeG+; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=qk3erv7bpnda7fik5nay6uxary.protonmail; t=1711547630; x=1711806830;
	bh=/KrGQPoa4XBEU6DDwx50UKASQ/ZJLt8f1jEe0AMQoto=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=grTOPeG+dT+t1VUrin8lKlmqwqEh2CM2cMGUNXFKyoPDxAuUvQXnRIELS5cWaW5ZL
	 7xzwXPbq553XTsmrbIqVbQ1wasodBvZvUdIwflXHcOEJl/SgTarU0Gi1m1c/UHpyO1
	 Pf2BZ9DJcDM5Mqr5KUNbWstdoGhZaBfqP8Nnb2AcD1z3C7wFjreX5Wc+eih5aMtNXE
	 eSqAjNsaZDvmIKI/8vzJCGhgwbox1nm2C3YPvNE9EUM2kbBvUBYu6cvFu20gvFOlSB
	 souYPudMxHxIe/gvfGegN0IJKEyADxSdXoYb3w4fx9i82mzwCnMLzCKLbLk6koEoqx
	 OIbQsdAgyb9sA==
Date: Wed, 27 Mar 2024 13:53:33 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 2/2] samples: rust: add in-place initialisation sample
Message-ID: <ffuYV4VQCfRoM7Fws9Z7TOVXS_dJp89q9--Sv9fipzWpOUqkjad5EfXsZPcBZ8ciGzrPo-U-2rEy5CUOitXNp4e4hAJHwZ0uH_u3zDxr0zE=@proton.me>
In-Reply-To: <20240327032337.188938-3-wedsonaf@gmail.com>
References: <20240327032337.188938-1-wedsonaf@gmail.com> <20240327032337.188938-3-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.03.24 04:23, Wedson Almeida Filho wrote:
> diff --git a/samples/rust/rust_inplace.rs b/samples/rust/rust_inplace.rs
> new file mode 100644
> index 000000000000..ba8d051cac56
> --- /dev/null
> +++ b/samples/rust/rust_inplace.rs
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust minimal in-place sample.
> +
> +use kernel::prelude::*;
> +
> +module! {
> +    type: RustInPlace,
> +    name: "rust_inplace",
> +    author: "Rust for Linux Contributors",
> +    description: "Rust minimal in-place sample",
> +    license: "GPL",
> +}
> +
> +#[pin_data(PinnedDrop)]
> +struct RustInPlace {
> +    numbers: Vec<i32>,
> +}
> +
> +impl kernel::InPlaceModule for RustInPlace {
> +    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
> +        pr_info!("Rust minimal sample (init)\n");

This text needs updating.

> +        pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
> +        try_pin_init!(Self {
> +            numbers: {
> +                let mut numbers =3D Vec::new();
> +                numbers.push(72, GFP_KERNEL)?;
> +                numbers.push(108, GFP_KERNEL)?;
> +                numbers.push(200, GFP_KERNEL)?;
> +                numbers
> +            },
> +        })

I think it might be useful to also have a field that needs pin-init, eg
a `Mutex` or similar. What about placing the `Vec` inside of a mutex?

--=20
Cheers,
Benno

> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for RustInPlace {
> +    fn drop(self: Pin<&mut Self>) {
> +        pr_info!("My numbers are {:?}\n", self.numbers);
> +        pr_info!("Rust minimal inplace sample (exit)\n");
> +    }
> +}
> --
> 2.34.1
>=20


