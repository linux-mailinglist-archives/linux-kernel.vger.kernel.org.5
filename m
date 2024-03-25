Return-Path: <linux-kernel+bounces-118131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD6688B445
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624E12E05AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1FC6E2AB;
	Mon, 25 Mar 2024 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PdAH9vk6"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA08002D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406285; cv=none; b=pyT5tyYb7a4VaajAfBV+VWs1p0NkguDwfuYeY/8bbCmiS2f6yGMNMxahPX39nDWDavMGeVikhRVEawEnRhKp1IVoE9WlmEg0NJoYZEW9ViK+dbt6wKeAF2o4u+u9co3RxAx4A03I3JRsk+k92QjymwPoei+Rlvf8y/URxlo9lOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406285; c=relaxed/simple;
	bh=zP+0rRcRHR6p8T9Hy4FNacD6Oivxud0R+BGUwmTMPu4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unDwLITOrtCWn3TbgjKEodXBPfT0P6N6TjOC8u6RT/Uc7OuAfTMwQ/u70/M+OKEf2FBvWnnWxnV8jgfsaazoaXY7GX89eT8fuhZSNVR+dTH69dNWlTwfV4Ta+2Nbsz7mYtU0vTh2QfvlZ/1/FgpOyqIpJ/EJs5xjUBl0lqnXsPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PdAH9vk6; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711406275; x=1711665475;
	bh=xVbIMg1PeHvgwBHzCHVhang4QHG16Vcy43jFIo22emM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PdAH9vk6g7XmxIxH58O2SDttQGLyAiGcj3+j68gQFYaqAnr3xlZbOeBt7dO1qFx5A
	 CR5C+JVjhVQprk6GWt9OdUc7e3kF3K2rxxHhJaM664zHuNcNcOu7HHpmNCHiEPN3j1
	 9ea2b3xFTpkKVMc5/MQPvoOFs6tQYXniAh9Tbh/3tH2NSOeXILgvlYVd9rlo3+9YgI
	 +CCvxnTeDv6cO2zN9nXi8sga4Z5cVRpLPr/ot86OWdHBdeUvho6E72U724ZeN4Em4X
	 coRxc+MChLeCC9hQvf7ZUyo7nLOq9fOyJMxflIO6etFYoQgoa34bOWKs9pfRvrrLdm
	 oyuxyJahedy6Q==
Date: Mon, 25 Mar 2024 22:37:50 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 06/10] rust: alloc: introduce the `BoxExt` trait
Message-ID: <9AmQ4moOGHvMXp-MH65qG1fS7v14hypIjEwsPlYLdLJD2NMVOQFwFvzpETrxHSSMt-Y6Gz_TZfwXgROJys72ZIpB-Je4obAuZ2knpT9R3yo=@proton.me>
In-Reply-To: <20240325195418.166013-7-wedsonaf@gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-7-wedsonaf@gmail.com>
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
> Make fallible versions of `new` and `new_uninit` methods available in
> `Box` even though it doesn't implement them because we build `alloc`
> with the `no_global_oom_handling` config.
>=20
> They also have an extra `flags` parameter that allows callers to pass
> flags to the allocator.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/kernel/alloc.rs           |  1 +
>   rust/kernel/alloc/allocator.rs |  6 +++-
>   rust/kernel/alloc/boxext.rs    | 61 ++++++++++++++++++++++++++++++++++
>   rust/kernel/init.rs            | 13 ++++----
>   rust/kernel/prelude.rs         |  2 +-
>   rust/kernel/sync/arc.rs        |  3 +-
>   6 files changed, 77 insertions(+), 9 deletions(-)
>   create mode 100644 rust/kernel/alloc/boxext.rs
>=20
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index ad48ac8dc13d..5712c81b1308 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -5,6 +5,7 @@
>   #[cfg(not(test))]
>   #[cfg(not(testlib))]
>   mod allocator;
> +pub mod boxext;
>   pub mod vecext;
>=20
>   /// Flags to be used when allocating memory.
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator=
rs
> index 01ad139e19bc..fc0439455faa 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -15,7 +15,11 @@
>   ///
>   /// - `ptr` can be either null or a pointer which has been allocated by=
 this allocator.
>   /// - `new_layout` must have a non-zero size.
> -unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bind=
ings::gfp_t) -> *mut u8 {
> +pub(crate) unsafe fn krealloc_aligned(
> +    ptr: *mut u8,
> +    new_layout: Layout,
> +    flags: bindings::gfp_t,
> +) -> *mut u8 {
>       // Customized layouts from `Layout::from_size_align()` can have siz=
e < align, so pad first.
>       let layout =3D new_layout.pad_to_align();
>=20
> diff --git a/rust/kernel/alloc/boxext.rs b/rust/kernel/alloc/boxext.rs
> new file mode 100644
> index 000000000000..26a918df7acf
> --- /dev/null
> +++ b/rust/kernel/alloc/boxext.rs
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Extensions to [`Box`] for fallible allocations.
> +
> +use super::Flags;
> +use alloc::boxed::Box;
> +use core::alloc::AllocError;
> +use core::mem::MaybeUninit;
> +use core::result::Result;
> +
> +/// Extensions to [`Box`].
> +pub trait BoxExt<T>: Sized {
> +    /// Allocates a new box.
> +    ///
> +    /// The allocation may fail, in which case an error is returned.
> +    fn new(x: T, flags: Flags) -> Result<Self, AllocError>;
> +
> +    /// Allocates a new uninitialised box.
> +    ///
> +    /// The allocation may fail, in which case an error is returned.
> +    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocErro=
r>;
> +}
> +
> +impl<T> BoxExt<T> for Box<T> {
> +    #[cfg(any(test, testlib))]
> +    fn new(x: T, _flags: Flags) -> Result<Self, AllocError> {
> +        Ok(Box::new(x))
> +    }

When running under `cfg(test)`, are we using the normal standard
library? Or why is this needed?

> +
> +    #[cfg(not(any(test, testlib)))]
> +    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
> +        let ptr =3D if core::mem::size_of::<T>() =3D=3D 0 {
> +            core::ptr::NonNull::<T>::dangling().as_ptr()
> +        } else {
> +            let layout =3D core::alloc::Layout::new::<T>();
> +
> +            // SAFETY: Memory is being allocated (first arg is null). Th=
e only other source of
> +            // safety issues is sleeping on atomic context, which is add=
ressed by klint.

The `krealloc_aligned` function states:

/// # Safety
///
/// - `ptr` can be either null or a pointer which has been allocated by thi=
s allocator.
/// - `new_layout` must have a non-zero size.

So it should also mention that you checked for `layout.size() > 0`
above.

> +            let ptr =3D unsafe {
> +                super::allocator::krealloc_aligned(core::ptr::null_mut()=
, layout, flags.0)
> +            };
> +            if ptr.is_null() {
> +                return Err(AllocError);
> +            }
> +
> +            let ptr =3D ptr.cast::<T>();
> +
> +            // SAFETY: We just allocated the memory above, it is valid f=
or write.
> +            unsafe { ptr.write(x) };
> +            ptr
> +        };
> +
> +        // SAFETY: For non-zero-sized types, we allocate above using the=
 global allocator. For
> +        // zero-sized types, we use `NonNull::dangling`.
> +        Ok(unsafe { Box::from_raw(ptr) })
> +    }
> +
> +    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocErro=
r> {
> +        <Box<_> as BoxExt<_>>::new(MaybeUninit::<T>::uninit(), flags)

Why do you use the extended syntax? I tried to use `Box::new` and it
compiled.

--=20
Cheers,
Benno

