Return-Path: <linux-kernel+bounces-118080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC4888B364
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C9F3056AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FDD71756;
	Mon, 25 Mar 2024 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OVRRyW8T"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77670CA7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404358; cv=none; b=VQ69FPLaerlZwlLmvrhbmoCUU9HjyCS16RK5vKY3XUzh6cV3+jW7D7N6Hi/qUq9emICcX2ft3k9R3xxyDIE3V+gmxCLq1Xll7DiaUpr+B98pjmml6WUzNTFgknTNXY727sN7TOrUAJr3YNAljU298Mkgqm6lxxES7D+6R+joFSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404358; c=relaxed/simple;
	bh=ZFvuyhlVXgsXqn+uiOPjOuC5HwV1VdVaF4Yn0pW8M4M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzCnFedfnLvOdRSHs08lcklWmq/uKadinmx6OP6VxviOzRrjv+qHVhGg7PODZjcwjY+oK47WGlVdTbiRMuveJRts2Ovt1Auia0tqa+jjYE60ovBb6Irc1v4Wj9BcA37xbhnKHNRrvXB3VA8tX+P6Ric6eSWof9ahzp5/BRA3mf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OVRRyW8T; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711404348; x=1711663548;
	bh=tN0+ubZJmKVdLvvMpKN2/OFQiM5GjH39Al+PCbsrl/Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OVRRyW8ThiI6rpDGKa5zg2dheAWiiV3l53xdA7onmobWe3rTmsBn0Nv9qOAdBtg0P
	 LGGHI3L5/P17Z4lPpvted5S2vyYAZSBhwNKdzufXNXjCRh4B8fHkZm25dlSsgoCkWi
	 ZsNCntOaYlPIqcTwtYpeFRQ+qT0mYBQX1SuUJ48wzrNUFlRFPL06afTtH7ZaM/bcLC
	 INMudYDgzCAyPXDyXQf3B7jMTi8q5QmF1a0amvwd7+151Vdz6hNS1ETdK97OWVHZYS
	 vThx9PsvTTllKWXrYyGccU8CUjpXwky4c0RIV01HhPb4TyK0SxAr/2mAk94+rwxgBP
	 Ke6JzxBiF+8mg==
Date: Mon, 25 Mar 2024 22:05:33 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 02/10] rust: alloc: introduce the `VecExt` trait
Message-ID: <g2iK91tWPKM5kXi-N6Nn3tn5jG4qvB6txrpq0ejLnQYgRNZJE1OO__SDANkSNP0JjMrqhEdc0m6YyxNlicxqzGr4hEsLAxPgCyPeyRoXLq0=@proton.me>
In-Reply-To: <20240325195418.166013-3-wedsonaf@gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-3-wedsonaf@gmail.com>
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
> Make `try_with_capacity`, `try_push`, and `try_extend_from_slice`
> methods available in `Vec` even though it doesn't implement them. It is
> implemented with `try_reserve` and `push_within_capacity`.
>=20
> This is in preparation for switching to the upstream `alloc` crate.
>=20
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/kernel/alloc.rs        |  1 +
>   rust/kernel/alloc/vecext.rs | 52 +++++++++++++++++++++++++++++++++++++
>   rust/kernel/lib.rs          |  1 +
>   rust/kernel/prelude.rs      |  2 ++
>   4 files changed, 56 insertions(+)
>   create mode 100644 rust/kernel/alloc/vecext.rs
>=20
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index ccd4149932c3..8ad57a2e693e 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -5,3 +5,4 @@
>   #[cfg(not(test))]
>   #[cfg(not(testlib))]
>   mod allocator;
> +pub mod vecext;
> diff --git a/rust/kernel/alloc/vecext.rs b/rust/kernel/alloc/vecext.rs
> new file mode 100644
> index 000000000000..59e92bab534e
> --- /dev/null
> +++ b/rust/kernel/alloc/vecext.rs
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Extensions to [`Vec`] for fallible allocations.
> +
> +use alloc::{collections::TryReserveError, vec::Vec};
> +use core::result::Result;
> +
> +/// Extensions to [`Vec`].
> +pub trait VecExt<T>: Sized {
> +    /// Creates a new [`Vec`] instance with at least the given capacity.
> +    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveErro=
r>;
> +
> +    /// Appends an element to the back of the [`Vec`] instance.
> +    fn try_push(&mut self, v: T) -> Result<(), TryReserveError>;
> +
> +    /// Pushes clones of the elements of slice into the [`Vec`] instance=
.
> +    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryRe=
serveError>
> +    where
> +        T: Clone;

All of the non `try_` prefix functions require=20
`not(no_global_oom_handling)`, so we could also drop the `try_` prefix
here.
What do you think?

> +}
> +
> +impl<T> VecExt<T> for Vec<T> {
> +    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveErro=
r> {
> +        let mut v =3D Vec::new();
> +        v.try_reserve(capacity)?;
> +        Ok(v)
> +    }
> +
> +    fn try_push(&mut self, v: T) -> Result<(), TryReserveError> {
> +        if let Err(retry) =3D self.push_within_capacity(v) {
> +            self.try_reserve(1)?;
> +            let _ =3D self.push_within_capacity(retry);
> +        }
> +        Ok(())
> +    }
> +
> +    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryRe=
serveError>
> +    where
> +        T: Clone,
> +    {
> +        let extra_cap =3D self.capacity() - self.len();
> +        if extra_cap > 0 {
> +            self.try_reserve(extra_cap)?;
> +        }

I am confused, why are you doing this? Did you mean to do this?:
    let extra_cap =3D self.capacity() - self.len() - other.len();

--=20
Cheers,
Benno

> +
> +        for item in other {
> +            self.try_push(item.clone())?;
> +        }
> +
> +        Ok(())
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 51f30e55bd00..7f2841a18d05 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -19,6 +19,7 @@
>   #![feature(offset_of)]
>   #![feature(receiver_trait)]
>   #![feature(unsize)]
> +#![feature(vec_push_within_capacity)]
>=20
>   // Ensure conditional compilation based on the kernel configuration wor=
ks;
>   // otherwise we may silently break things like initcall handling.
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index ae21600970b3..a0177f195dec 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -14,6 +14,8 @@
>   #[doc(no_inline)]
>   pub use core::pin::Pin;
>=20
> +pub use crate::alloc::vecext::VecExt;
> +
>   #[doc(no_inline)]
>   pub use alloc::{boxed::Box, vec::Vec};
>=20
> --
> 2.34.1
> 

