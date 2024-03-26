Return-Path: <linux-kernel+bounces-119059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D888788C365
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072DD1C36D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEAC745DC;
	Tue, 26 Mar 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WKhKWrvY"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36774411
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459846; cv=none; b=F+apjVwnoUAA6ZGg3LYLAip+MdVPBx1/MoIub0pRtKjOHFLjfExAqYQaR+eNzSpf1ItO+UybbG+qH/a/yRujIeN+UtmjaY/BViNiAr0XC9nwI7JawqYB6r4b+ci/fPAap+/0sTtVhsA2/f5W7JE/w2RljTj57X7s4NId0u4IeGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459846; c=relaxed/simple;
	bh=70AG2YjbJYgkjFfQ8mU0frlGAVmRzwphrZANyFalLkE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APmZ7JYb2UShkgTlmDd4oPym5dFZwhaZgK9puMonhLHobU/HhMhIAhMkaomftdd2V2loapr3lRacRZ47Mvvz9XrGc5qBqyj79u68GN5R51qeUUbhf2Tz+Dm24IfMAlkqaJhp1nSR96zspLsD0XNqPkiukYjonFr6anau/cmoAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WKhKWrvY; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711459841; x=1711719041;
	bh=3zjQ7eC3k+N5mljsGCsXBKGxRRF33muyXP+mt9iMhxc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WKhKWrvYk/VWRvJ/ue+hTCzftOtGCmLJRnUdtviNEV10TKZGlO0z3TWpmkFY65vk2
	 NvyroSufVio5X1UWlAXTfM/2oWyyBIyPANLtbEuzTFXAGtV0lMnNTGEkT3vqPb8JvX
	 VFx/1/aamSD/wwd2ilFs0V6MSbAJ4ZzT4AHlYrbDGts5Fxq2V89wyYjwzUJM6LfDOZ
	 wvkFBy7+6gqK62K007tkgw29R9CwZNtU57+tfMXBrFl6K3uzYuy9YcdthzK5Vxe64F
	 qIoqJVqPky3eXcHfOFSpWuYtvRlBVwWvv5uI4SO93qblLS4wuu3pRpdmnH4WfsmUbi
	 JGmEQ3o+gavzA==
Date: Tue, 26 Mar 2024 13:30:23 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 06/10] rust: alloc: introduce the `BoxExt` trait
Message-ID: <4HXcIXSpP2nHdpuTb2aAIwspZ8Az9XYU3KUp18oUlsi3yIqXNPvbe80x57P0hLIYHrlf67DUCxD96blhqCsGmR3oecopCnaZA6kRlvKCl5g=@proton.me>
In-Reply-To: <CANeycqrbuzDwDhUjz+rZv2Q_peK54L1yPG6A1L6-PwjyLKiSAw@mail.gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-7-wedsonaf@gmail.com> <9AmQ4moOGHvMXp-MH65qG1fS7v14hypIjEwsPlYLdLJD2NMVOQFwFvzpETrxHSSMt-Y6Gz_TZfwXgROJys72ZIpB-Je4obAuZ2knpT9R3yo=@proton.me> <CANeycqrbuzDwDhUjz+rZv2Q_peK54L1yPG6A1L6-PwjyLKiSAw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.03.24 01:17, Wedson Almeida Filho wrote:
> On Mon, 25 Mar 2024 at 19:37, Benno Lossin <benno.lossin@proton.me> wrote=
:
>>
>> On 25.03.24 20:54, Wedson Almeida Filho wrote:
>>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>>>
>>> Make fallible versions of `new` and `new_uninit` methods available in
>>> `Box` even though it doesn't implement them because we build `alloc`
>>> with the `no_global_oom_handling` config.
>>>
>>> They also have an extra `flags` parameter that allows callers to pass
>>> flags to the allocator.
>>>
>>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>>> ---
>>>    rust/kernel/alloc.rs           |  1 +
>>>    rust/kernel/alloc/allocator.rs |  6 +++-
>>>    rust/kernel/alloc/boxext.rs    | 61 ++++++++++++++++++++++++++++++++=
++
>>>    rust/kernel/init.rs            | 13 ++++----
>>>    rust/kernel/prelude.rs         |  2 +-
>>>    rust/kernel/sync/arc.rs        |  3 +-
>>>    6 files changed, 77 insertions(+), 9 deletions(-)
>>>    create mode 100644 rust/kernel/alloc/boxext.rs
>>>
>>> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
>>> index ad48ac8dc13d..5712c81b1308 100644
>>> --- a/rust/kernel/alloc.rs
>>> +++ b/rust/kernel/alloc.rs
>>> @@ -5,6 +5,7 @@
>>>    #[cfg(not(test))]
>>>    #[cfg(not(testlib))]
>>>    mod allocator;
>>> +pub mod boxext;
>>>    pub mod vecext;

One thing I forgot to say: I think these modules should be named
`box_ext` and `vec_ext`. It fits better with the usual style.

>>>
>>>    /// Flags to be used when allocating memory.
>>> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocat=
or.rs
>>> index 01ad139e19bc..fc0439455faa 100644
>>> --- a/rust/kernel/alloc/allocator.rs
>>> +++ b/rust/kernel/alloc/allocator.rs
>>> @@ -15,7 +15,11 @@
>>>    ///
>>>    /// - `ptr` can be either null or a pointer which has been allocated=
 by this allocator.
>>>    /// - `new_layout` must have a non-zero size.
>>> -unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bi=
ndings::gfp_t) -> *mut u8 {
>>> +pub(crate) unsafe fn krealloc_aligned(
>>> +    ptr: *mut u8,
>>> +    new_layout: Layout,
>>> +    flags: bindings::gfp_t,
>>> +) -> *mut u8 {
>>>        // Customized layouts from `Layout::from_size_align()` can have =
size < align, so pad first.
>>>        let layout =3D new_layout.pad_to_align();
>>>
>>> diff --git a/rust/kernel/alloc/boxext.rs b/rust/kernel/alloc/boxext.rs
>>> new file mode 100644
>>> index 000000000000..26a918df7acf
>>> --- /dev/null
>>> +++ b/rust/kernel/alloc/boxext.rs
>>> @@ -0,0 +1,61 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! Extensions to [`Box`] for fallible allocations.
>>> +
>>> +use super::Flags;
>>> +use alloc::boxed::Box;
>>> +use core::alloc::AllocError;
>>> +use core::mem::MaybeUninit;
>>> +use core::result::Result;
>>> +
>>> +/// Extensions to [`Box`].
>>> +pub trait BoxExt<T>: Sized {
>>> +    /// Allocates a new box.
>>> +    ///
>>> +    /// The allocation may fail, in which case an error is returned.
>>> +    fn new(x: T, flags: Flags) -> Result<Self, AllocError>;
>>> +
>>> +    /// Allocates a new uninitialised box.
>>> +    ///
>>> +    /// The allocation may fail, in which case an error is returned.
>>> +    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocEr=
ror>;
>>> +}
>>> +
>>> +impl<T> BoxExt<T> for Box<T> {
>>> +    #[cfg(any(test, testlib))]
>>> +    fn new(x: T, _flags: Flags) -> Result<Self, AllocError> {
>>> +        Ok(Box::new(x))
>>> +    }
>>
>> When running under `cfg(test)`, are we using the normal standard
>> library? Or why is this needed?
>=20
> Because it uses 34 other crates that rely on `Box::new` and friends.
>=20
> I discussed this with Miguel recently and once he's done with the
> build system changes, he will think about what to do with tests. It
> may be that we abandon the current method of running standalone tests
> and run everything in kunit, or perhaps we'll find a way to exclude
> code that won't run in standalone tests anyway...

Ah I see, I think it would be nice to not need this. Let's see what the
new build system can do here.

>=20
>>> +
>>> +    #[cfg(not(any(test, testlib)))]
>>> +    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
>>> +        let ptr =3D if core::mem::size_of::<T>() =3D=3D 0 {
>>> +            core::ptr::NonNull::<T>::dangling().as_ptr()
>>> +        } else {
>>> +            let layout =3D core::alloc::Layout::new::<T>();
>>> +
>>> +            // SAFETY: Memory is being allocated (first arg is null). =
The only other source of
>>> +            // safety issues is sleeping on atomic context, which is a=
ddressed by klint.
>>
>> The `krealloc_aligned` function states:
>>
>> /// # Safety
>> ///
>> /// - `ptr` can be either null or a pointer which has been allocated by =
this allocator.
>> /// - `new_layout` must have a non-zero size.
>>
>> So it should also mention that you checked for `layout.size() > 0`
>> above.
>=20
> Good point. I mentioned this in the VecExt version but not here. I
> will update this for v2.
>=20
>>> +            let ptr =3D unsafe {
>>> +                super::allocator::krealloc_aligned(core::ptr::null_mut=
(), layout, flags.0)
>>> +            };
>>> +            if ptr.is_null() {
>>> +                return Err(AllocError);
>>> +            }
>>> +
>>> +            let ptr =3D ptr.cast::<T>();
>>> +
>>> +            // SAFETY: We just allocated the memory above, it is valid=
 for write.
>>> +            unsafe { ptr.write(x) };
>>> +            ptr
>>> +        };
>>> +
>>> +        // SAFETY: For non-zero-sized types, we allocate above using t=
he global allocator. For
>>> +        // zero-sized types, we use `NonNull::dangling`.
>>> +        Ok(unsafe { Box::from_raw(ptr) })
>>> +    }
>>> +
>>> +    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocEr=
ror> {
>>> +        <Box<_> as BoxExt<_>>::new(MaybeUninit::<T>::uninit(), flags)
>>
>> Why do you use the extended syntax? I tried to use `Box::new` and it
>> compiled.
>=20
> It works when compiling the kernel but fails when compiling for
> userspace with regular (no_global_oom_handling disabled) `alloc` when
> running `make rusttest`. In the latter case, it chooses the inherent
> version of `Box::new` which is infallible and doesn't take flags so it
> fails to compile.
>=20
> Using the extended syntax allows it always pick the right version,
> regardless of how `alloc` is compiled.
>=20
> There are 5 places in existing code that required this change and this
> is limited to the kernel crate (e.g., drivers, samples and
> documentation examples can continue to use `Box::new`). So we thought
> it was ok until Miguel figures out what we want to do with tests.

Thanks for the explanation, again it would be nice to be able to just
write `Box::new`.

--=20
Cheers,
Benno


