Return-Path: <linux-kernel+bounces-131145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B338983AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A741F2191A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746147353B;
	Thu,  4 Apr 2024 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="n3IppDF2"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2281B7F4;
	Thu,  4 Apr 2024 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221299; cv=none; b=kEyNyC1aTrHZnrjUt+j3gsqLEv4w59zv9uUFvA0LciTQg4/FDlh6HBr5MNgjeELDKeSfn5uPUETtDHKUb6jXYZ0B5uwhh4ebJ3PGV7OxmbBWhixp0fzZUcjJRkWPMAivVnoEk1txFFxJnembVc8L9CYF+vgjYxlJ/nmsI4Pg+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221299; c=relaxed/simple;
	bh=Z/+X+5Tr3shbeJv5Dt06oyq1ofubRAN9gc2I5U/VGZU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxngPP2taxHYMKoJJSKKFVLMRzOtn5CK+/H2y6OasLNnzzcj53pUzR4gNIlv6/xvwajyOkynVwO7LlPzCJyfTF3M5wPB88on4rrgdFU0Ap4bIERBT/6SAXJ+THwZ6uI1anLc1bItIk/KKkPWur8KSZSbpKckMattc6O5K1EKEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=n3IppDF2; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712221296; x=1712480496;
	bh=IsWHRkAXzz0UFSHl8jcWKwFQLylEunjH34ao/KOO2o4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=n3IppDF26eBYlHo3/SjMpauyZtRy38wc3c/ljWVqqL5zgkDHpFYElSp7LPeB3T0K7
	 Awby4gLHSFodM8e3Z6XP7WHuMtVuW6XZNM1KLaVkfESbvu1JKK8YN4WPhcEaaJbv63
	 Avf6LdO4GGGX/wZVBV+aKslc1YrRJkrOj/+ulqpYl8dAkMCqO2wbTUKx3xZqQzClFB
	 49e0DuVVcrDmxVVLTwixKU9Ete9f9l68ooAvLD7G5yq7Ddx/e9ucpybIBG56qSkaUi
	 vToTqyhD/N+CLkJJRsOGwkT9tTcpMRn4KdW9dZfqnUDj69favdBsn9bPITmcOOZ1eX
	 BT7QflqDLPBhA==
Date: Thu, 04 Apr 2024 09:01:26 +0000
To: Laine Taffin Altman <alexanderaltman@me.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, rust-for-linux@vger.kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, lkml <linux-kernel@vger.kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v4] rust: init: remove impl Zeroable for Infallible
Message-ID: <d3423fb5-c117-4bd1-9f86-db35590a0562@proton.me>
In-Reply-To: <CA160A4E-561E-4918-837E-3DCEBA74F808@me.com>
References: <CA160A4E-561E-4918-837E-3DCEBA74F808@me.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.04.24 23:06, Laine Taffin Altman wrote:
> In Rust, producing an invalid value of any type is immediate undefined
> behavior (UB); this includes via zeroing memory.  Therefore, since an
> uninhabited type has no valid values, producing any values at all for it =
is
> UB.
>=20
> The Rust standard library type `core::convert::Infallible` is uninhabited=
,
> by virtue of having been declared as an enum with no cases, which always
> produces uninhabited types in Rust.
>=20
> The current kernel code allows this UB to be triggered, for example by co=
de
> like `Box::<core::convert::Infallible>::init(kernel::init::zeroed())`.
>=20
> Thus, remove the implementation of `Zeroable` for `Infallible`, thereby
> avoiding the unsoundness (potential for future UB).
>=20
> Cc: stable@vger.kernel.org
> Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and `init::zeroed`=
 function")
> Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
> Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
> V3 -> V4: Address review nits; run checkpatch properly.
> V2 -> V3: Email formatting correction.
> V1 -> V2: Added more documentation to the comment, with links; also added=
 more details to the commit message.
>=20
>  rust/kernel/init.rs | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 424257284d16..3859c7ff81b7 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -1292,8 +1292,15 @@ macro_rules! impl_zeroable {
>      i8, i16, i32, i64, i128, isize,
>      f32, f64,
>=20
> -    // SAFETY: These are ZSTs, there is nothing to zero.
> -    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, Infallibl=
e, (),
> +    // Note: do not add uninhabited types (such as `!` or `core::convert=
::Infallible`) to this list;
> +    // creating an instance of an uninhabited type is immediate undefine=
d behavior.  For more on
> +    // uninhabited/empty types, consult The Rustonomicon:
> +    // https://doc.rust-lang.org/stable/nomicon/exotic-sizes.html#empty-=
types The Rust Reference
> +    // also has information on undefined behavior:
> +    // https://doc.rust-lang.org/stable/reference/behavior-considered-un=
defined.html
> +    //
> +    // SAFETY: These are inhabited ZSTs; there is nothing to zero and a =
valid value exists.
> +    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, (),
>=20
>      // SAFETY: Type is allowed to take any value, including all zeros.
>      {<T>} MaybeUninit<T>,
>=20
> base-commit: c85af715cac0a951eea97393378e84bb49384734

I don't see this commit in the kernel tree, what did you specify as
`--base` when running `git format`?

--=20
Cheers,
Benno


