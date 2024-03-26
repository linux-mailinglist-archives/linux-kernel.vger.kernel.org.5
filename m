Return-Path: <linux-kernel+bounces-118209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22B988B5E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1141F38D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A4517F8;
	Tue, 26 Mar 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWm2c+AE"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE6652;
	Tue, 26 Mar 2024 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412286; cv=none; b=UNgnvIeeWKFlkGyC14uPG+GeHGw1ADNLS4LJhiV1v77k7PwMV0nHsbFx4747KyOlIZiMCMAavQTlh+jlaBgpZoNBvq5dSl4wi+NhH0SvQIwyAgTxi98WK1oIjms9wRjMaI9UykgQ27WV9+HTHDs5ur2gwko5r9LHELRiuVeerfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412286; c=relaxed/simple;
	bh=5mxENDN2n+SPVgHKjyiptOuKizNcc2aVvP7c/sNAGjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcIZh1omlp9Vj9+xhKyrIeKW8M1wQnLUkkIJfUtD6jaGDuqulXWtgZoggs7Ba/1YCOfSeb5TZ300kAvGkoGFaK8WNhSFm+FvXl17EV2KrsKccjEMyT6Uj06T1DQiSCjw0WzqSX5fiaBBaie9vrh2o2kYHJZwJKz48RQGk3kdKTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWm2c+AE; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60a0579a968so52936287b3.3;
        Mon, 25 Mar 2024 17:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711412284; x=1712017084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+liYJF3hfCD+d+hZyHARAb2yKZhPPpj/oeQo7CNC2gM=;
        b=DWm2c+AExdCUWJf2glftRPrj2lQKvKfXAo1XvV8XVzevSBRYwFNXoBKgEZzqWJQyp4
         T8cjOZGh36pStkbT1jOM02GF99k5Pe13alFCwMBnwCQDYbjHfbNonC0D7OZmgAYWQuks
         fA9ktasMpgjwfY58uHUwElUWSXRSpAxt/eKwVmO88tm2kX4R33VNRWfV3Oess7Zc41wT
         wR8sHd6IW2IpRgDWaj53Aio1b9OIZTeGvmlDPyApL15Zmc1C+Go916q8S/qcEN74OQJ7
         0nOGkSLunI4Cs6V09KdgqmJuXV8UAnkPHBW8g03G887MggqLMUVfGp4BdEmYIN6t08Rt
         A5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711412284; x=1712017084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+liYJF3hfCD+d+hZyHARAb2yKZhPPpj/oeQo7CNC2gM=;
        b=I6JAb31KUz7bLUSk+EoNfWtSmSOBfkr3CllhrNdmX50CP2PSkwI8iWr86B4skEDiqo
         4FaL+mN6XUARkhsXrgkMQipJE0J0JjcOzHM6fb7uRZDoYsmmDH3ZHnh+v0CD/Lg968CP
         nYijlTRLo9B3scu8NGhw8Z8Td33e/4US7ocojd5/1Ti7zeKDSPOVRAbfTMVlzrVKajjn
         1aDhqcN8hQurFrtNZbmpwU9Z7bi9KuSONZMT0K3lp61DMCTZugBMJUpBtOPIzWrM23MI
         0914nmH9khd2y4crpRROk5VZFmw2BG1yiDuSvKIFcyVWfqF3CB+LCf2o+aQpFl0FP7kh
         jdng==
X-Forwarded-Encrypted: i=1; AJvYcCWrGZghd20Wp7lJN/Q/ZqOtRGxNJYbWeW0oJgza4+ljs4A76NvlQNBUIa7hqpsJdDZoQ2c+fFbvMveJsTq8dReTs/1h1amtPOQ7KRyR
X-Gm-Message-State: AOJu0YwZJ5bXw6oLeTsFqXx0q4sYKDrveJ2i98QDnU21q1IiFj14wsm2
	tXUT9tAFALIHMZGp+onApM00fYQlZqvKxrZwiPX3DYZebtJ6h/8nO5tiSyZYrvT06CO41xlVZe0
	pH2rCdJFDTcogJtZ9/ripLjLmIfA=
X-Google-Smtp-Source: AGHT+IG1Tcg6VkC9U+78/C7en4O1adZJtIO9GwVHgAg5hPyBBPv8EJwzDt2rz/TdVXA9XgFuZ5fCJ0U72+mqspHrxKA=
X-Received: by 2002:a0d:cc16:0:b0:610:f5db:697f with SMTP id
 o22-20020a0dcc16000000b00610f5db697fmr8556739ywd.11.1711412283133; Mon, 25
 Mar 2024 17:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-7-wedsonaf@gmail.com>
 <9AmQ4moOGHvMXp-MH65qG1fS7v14hypIjEwsPlYLdLJD2NMVOQFwFvzpETrxHSSMt-Y6Gz_TZfwXgROJys72ZIpB-Je4obAuZ2knpT9R3yo=@proton.me>
In-Reply-To: <9AmQ4moOGHvMXp-MH65qG1fS7v14hypIjEwsPlYLdLJD2NMVOQFwFvzpETrxHSSMt-Y6Gz_TZfwXgROJys72ZIpB-Je4obAuZ2knpT9R3yo=@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Mon, 25 Mar 2024 21:17:52 -0300
Message-ID: <CANeycqrbuzDwDhUjz+rZv2Q_peK54L1yPG6A1L6-PwjyLKiSAw@mail.gmail.com>
Subject: Re: [PATCH 06/10] rust: alloc: introduce the `BoxExt` trait
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 19:37, Benno Lossin <benno.lossin@proton.me> wrote:
>
> On 25.03.24 20:54, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > Make fallible versions of `new` and `new_uninit` methods available in
> > `Box` even though it doesn't implement them because we build `alloc`
> > with the `no_global_oom_handling` config.
> >
> > They also have an extra `flags` parameter that allows callers to pass
> > flags to the allocator.
> >
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> >   rust/kernel/alloc.rs           |  1 +
> >   rust/kernel/alloc/allocator.rs |  6 +++-
> >   rust/kernel/alloc/boxext.rs    | 61 ++++++++++++++++++++++++++++++++++
> >   rust/kernel/init.rs            | 13 ++++----
> >   rust/kernel/prelude.rs         |  2 +-
> >   rust/kernel/sync/arc.rs        |  3 +-
> >   6 files changed, 77 insertions(+), 9 deletions(-)
> >   create mode 100644 rust/kernel/alloc/boxext.rs
> >
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index ad48ac8dc13d..5712c81b1308 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -5,6 +5,7 @@
> >   #[cfg(not(test))]
> >   #[cfg(not(testlib))]
> >   mod allocator;
> > +pub mod boxext;
> >   pub mod vecext;
> >
> >   /// Flags to be used when allocating memory.
> > diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> > index 01ad139e19bc..fc0439455faa 100644
> > --- a/rust/kernel/alloc/allocator.rs
> > +++ b/rust/kernel/alloc/allocator.rs
> > @@ -15,7 +15,11 @@
> >   ///
> >   /// - `ptr` can be either null or a pointer which has been allocated by this allocator.
> >   /// - `new_layout` must have a non-zero size.
> > -unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bindings::gfp_t) -> *mut u8 {
> > +pub(crate) unsafe fn krealloc_aligned(
> > +    ptr: *mut u8,
> > +    new_layout: Layout,
> > +    flags: bindings::gfp_t,
> > +) -> *mut u8 {
> >       // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
> >       let layout = new_layout.pad_to_align();
> >
> > diff --git a/rust/kernel/alloc/boxext.rs b/rust/kernel/alloc/boxext.rs
> > new file mode 100644
> > index 000000000000..26a918df7acf
> > --- /dev/null
> > +++ b/rust/kernel/alloc/boxext.rs
> > @@ -0,0 +1,61 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Extensions to [`Box`] for fallible allocations.
> > +
> > +use super::Flags;
> > +use alloc::boxed::Box;
> > +use core::alloc::AllocError;
> > +use core::mem::MaybeUninit;
> > +use core::result::Result;
> > +
> > +/// Extensions to [`Box`].
> > +pub trait BoxExt<T>: Sized {
> > +    /// Allocates a new box.
> > +    ///
> > +    /// The allocation may fail, in which case an error is returned.
> > +    fn new(x: T, flags: Flags) -> Result<Self, AllocError>;
> > +
> > +    /// Allocates a new uninitialised box.
> > +    ///
> > +    /// The allocation may fail, in which case an error is returned.
> > +    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
> > +}
> > +
> > +impl<T> BoxExt<T> for Box<T> {
> > +    #[cfg(any(test, testlib))]
> > +    fn new(x: T, _flags: Flags) -> Result<Self, AllocError> {
> > +        Ok(Box::new(x))
> > +    }
>
> When running under `cfg(test)`, are we using the normal standard
> library? Or why is this needed?

Because it uses 34 other crates that rely on `Box::new` and friends.

I discussed this with Miguel recently and once he's done with the
build system changes, he will think about what to do with tests. It
may be that we abandon the current method of running standalone tests
and run everything in kunit, or perhaps we'll find a way to exclude
code that won't run in standalone tests anyway...

> > +
> > +    #[cfg(not(any(test, testlib)))]
> > +    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
> > +        let ptr = if core::mem::size_of::<T>() == 0 {
> > +            core::ptr::NonNull::<T>::dangling().as_ptr()
> > +        } else {
> > +            let layout = core::alloc::Layout::new::<T>();
> > +
> > +            // SAFETY: Memory is being allocated (first arg is null). The only other source of
> > +            // safety issues is sleeping on atomic context, which is addressed by klint.
>
> The `krealloc_aligned` function states:
>
> /// # Safety
> ///
> /// - `ptr` can be either null or a pointer which has been allocated by this allocator.
> /// - `new_layout` must have a non-zero size.
>
> So it should also mention that you checked for `layout.size() > 0`
> above.

Good point. I mentioned this in the VecExt version but not here. I
will update this for v2.

> > +            let ptr = unsafe {
> > +                super::allocator::krealloc_aligned(core::ptr::null_mut(), layout, flags.0)
> > +            };
> > +            if ptr.is_null() {
> > +                return Err(AllocError);
> > +            }
> > +
> > +            let ptr = ptr.cast::<T>();
> > +
> > +            // SAFETY: We just allocated the memory above, it is valid for write.
> > +            unsafe { ptr.write(x) };
> > +            ptr
> > +        };
> > +
> > +        // SAFETY: For non-zero-sized types, we allocate above using the global allocator. For
> > +        // zero-sized types, we use `NonNull::dangling`.
> > +        Ok(unsafe { Box::from_raw(ptr) })
> > +    }
> > +
> > +    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
> > +        <Box<_> as BoxExt<_>>::new(MaybeUninit::<T>::uninit(), flags)
>
> Why do you use the extended syntax? I tried to use `Box::new` and it
> compiled.

It works when compiling the kernel but fails when compiling for
userspace with regular (no_global_oom_handling disabled) `alloc` when
running `make rusttest`. In the latter case, it chooses the inherent
version of `Box::new` which is infallible and doesn't take flags so it
fails to compile.

Using the extended syntax allows it always pick the right version,
regardless of how `alloc` is compiled.

There are 5 places in existing code that required this change and this
is limited to the kernel crate (e.g., drivers, samples and
documentation examples can continue to use `Box::new`). So we thought
it was ok until Miguel figures out what we want to do with tests.

