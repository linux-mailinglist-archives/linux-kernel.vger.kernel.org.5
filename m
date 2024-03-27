Return-Path: <linux-kernel+bounces-120188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0AD88D40F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631F91C24B44
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 01:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599FF20313;
	Wed, 27 Mar 2024 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcdnjaOY"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6611D558;
	Wed, 27 Mar 2024 01:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711504557; cv=none; b=lUeHtADCt3dkF1ytYKh19LVsCbdp7Kctlkng+sUSmgZgEQqXAcZZ/PNl0/Gfwqc80/VG49e5xdDJO43nuIttPDpD+z5Qki6aIHoqo+f6Qnuotk2Mt5rlEmSRs56drj/Sz2ywBpK/kgrY5Pb+kbmCak7kGbZBpZSZyd8pBx7bx24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711504557; c=relaxed/simple;
	bh=UycgFYJkC6B+eNaf0pABfiDLaxalrtUXiws4fyinvfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Apdmy3EvOCQ9T/twy/LWNy9CnlU1IxilS38kN8CXcduhFtsQRi4kzb9ibdbYXuCT7usczCzcngMz5ZysIACH5P7+C1QEbyMP/vEkGMAImyqcGIpJTFlbU1qWtkMJBlOPEc4hD99kSIShTY2EGu1F4Tn5Wpze3aF+DD+YhwYaDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcdnjaOY; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-609f4155b76so66445877b3.1;
        Tue, 26 Mar 2024 18:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711504555; x=1712109355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kvb2heaB5MlFNklb0U8+GEqGfobjRGt+M5eC5wBBXm8=;
        b=hcdnjaOYAbtzYRRk8hC57L8l529MF7hqw0upxUjobSZv6ruOxx0MHVRliRiiKOtCNm
         HfR/FGiI86L5KYlwCQsdflFjtTn6fePJ+tQyRPaPYsFieIjFXnLbv+mS6lyzLlgjj5+m
         cliJiS1K1uKne5HLnTmQXrHjnTw0+viwdgPySdJmxqFCEBDgV36vZ4mlIbYbgnPLg/q0
         IJGOD6y8ZIGcuFx4wQGo6Rg7RsEnEWeDazSKvfgVXkdvP9y0E9G4Vci+/4dCqoChDxWf
         BUTTa8cEdM4Rm4Plz7ip9GIkAT/a7+xZHxjOz3/1tmkt5+0iu+zIrhPGoRZ5m7h//mJC
         52vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711504555; x=1712109355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kvb2heaB5MlFNklb0U8+GEqGfobjRGt+M5eC5wBBXm8=;
        b=AJHD+hHGRb/BxVfET0J/AfnkCXm1WKXmCYNejs6eU5w5gafGTW7phx+qrSZ9LB5QtC
         Sd5NK1FTFhj8rs5jUty7cgLo6sGvaDk445YVifnn//wRESxb3FeBwjHWg9RI7Sx/mWEd
         S7djAKTVjkSQUF/1S2vbaAFwGkO235WcZDuatPKYvdi7TItkOjPqyE9VtdAPxPwplr58
         i8Umvx2kdpGRt+7isFDpDK07hDaX7WaPKBwedoVerySY7u4kK3fsDvJV6ZqA+oEUfszX
         SDdMSjAnXgy7shTzo8iu5OvGsGPdH1JGnmXwzUN6WnREqQu6cn7rnqaRl21+9vYxezyn
         OGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwZcRo7OvccOz7hq6VoF8Hji7DjXraITPox9TG9HhugcGNaKo/9EMhleX3Tv6ioN2ot2pRdNeBrHbwg0D56V0+3vZBWzNh4BGvEBWZ
X-Gm-Message-State: AOJu0YwM63mCAFXnT9McrDFIzLUCAEZwgdRQ1Q7+Y2tDgkwbSGDiYDb7
	6yKmkQHpEkbiBi9q8sUvJgz9/joafBb2DUfF7QTkOkQfxWLraQ3zsQ9RRypTCPys6CGIYxL5fy7
	gVQlhwzO4gex1Xt2/k+9fBGUeRc4=
X-Google-Smtp-Source: AGHT+IHQs2HjZ0BJmwhBo4wwhQSLy5dFnitSXqQXKBq4Ri2owY3hVtVth7HRqrQYXKO3Yzj/+tIbiNHUJWBhEUCRxv0=
X-Received: by 2002:a05:690c:3184:b0:608:d673:f7c3 with SMTP id
 fd4-20020a05690c318400b00608d673f7c3mr8192498ywb.49.1711504554732; Tue, 26
 Mar 2024 18:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325195418.166013-1-wedsonaf@gmail.com> <20240325195418.166013-7-wedsonaf@gmail.com>
 <9AmQ4moOGHvMXp-MH65qG1fS7v14hypIjEwsPlYLdLJD2NMVOQFwFvzpETrxHSSMt-Y6Gz_TZfwXgROJys72ZIpB-Je4obAuZ2knpT9R3yo=@proton.me>
 <CANeycqrbuzDwDhUjz+rZv2Q_peK54L1yPG6A1L6-PwjyLKiSAw@mail.gmail.com> <4HXcIXSpP2nHdpuTb2aAIwspZ8Az9XYU3KUp18oUlsi3yIqXNPvbe80x57P0hLIYHrlf67DUCxD96blhqCsGmR3oecopCnaZA6kRlvKCl5g=@proton.me>
In-Reply-To: <4HXcIXSpP2nHdpuTb2aAIwspZ8Az9XYU3KUp18oUlsi3yIqXNPvbe80x57P0hLIYHrlf67DUCxD96blhqCsGmR3oecopCnaZA6kRlvKCl5g=@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Tue, 26 Mar 2024 22:55:44 -0300
Message-ID: <CANeycqpCGPHpEyXxtmPcOHewdmdXj-X8K0WAndPqQGomeyQRpg@mail.gmail.com>
Subject: Re: [PATCH 06/10] rust: alloc: introduce the `BoxExt` trait
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 10:30, Benno Lossin <benno.lossin@proton.me> wrote:
>
> On 26.03.24 01:17, Wedson Almeida Filho wrote:
> > On Mon, 25 Mar 2024 at 19:37, Benno Lossin <benno.lossin@proton.me> wrote:
> >>
> >> On 25.03.24 20:54, Wedson Almeida Filho wrote:
> >>> From: Wedson Almeida Filho <walmeida@microsoft.com>
> >>>
> >>> Make fallible versions of `new` and `new_uninit` methods available in
> >>> `Box` even though it doesn't implement them because we build `alloc`
> >>> with the `no_global_oom_handling` config.
> >>>
> >>> They also have an extra `flags` parameter that allows callers to pass
> >>> flags to the allocator.
> >>>
> >>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> >>> ---
> >>>    rust/kernel/alloc.rs           |  1 +
> >>>    rust/kernel/alloc/allocator.rs |  6 +++-
> >>>    rust/kernel/alloc/boxext.rs    | 61 ++++++++++++++++++++++++++++++++++
> >>>    rust/kernel/init.rs            | 13 ++++----
> >>>    rust/kernel/prelude.rs         |  2 +-
> >>>    rust/kernel/sync/arc.rs        |  3 +-
> >>>    6 files changed, 77 insertions(+), 9 deletions(-)
> >>>    create mode 100644 rust/kernel/alloc/boxext.rs
> >>>
> >>> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> >>> index ad48ac8dc13d..5712c81b1308 100644
> >>> --- a/rust/kernel/alloc.rs
> >>> +++ b/rust/kernel/alloc.rs
> >>> @@ -5,6 +5,7 @@
> >>>    #[cfg(not(test))]
> >>>    #[cfg(not(testlib))]
> >>>    mod allocator;
> >>> +pub mod boxext;
> >>>    pub mod vecext;
>
> One thing I forgot to say: I think these modules should be named
> `box_ext` and `vec_ext`. It fits better with the usual style.
>
> >>>
> >>>    /// Flags to be used when allocating memory.
> >>> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> >>> index 01ad139e19bc..fc0439455faa 100644
> >>> --- a/rust/kernel/alloc/allocator.rs
> >>> +++ b/rust/kernel/alloc/allocator.rs
> >>> @@ -15,7 +15,11 @@
> >>>    ///
> >>>    /// - `ptr` can be either null or a pointer which has been allocated by this allocator.
> >>>    /// - `new_layout` must have a non-zero size.
> >>> -unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bindings::gfp_t) -> *mut u8 {
> >>> +pub(crate) unsafe fn krealloc_aligned(
> >>> +    ptr: *mut u8,
> >>> +    new_layout: Layout,
> >>> +    flags: bindings::gfp_t,
> >>> +) -> *mut u8 {
> >>>        // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
> >>>        let layout = new_layout.pad_to_align();
> >>>
> >>> diff --git a/rust/kernel/alloc/boxext.rs b/rust/kernel/alloc/boxext.rs
> >>> new file mode 100644
> >>> index 000000000000..26a918df7acf
> >>> --- /dev/null
> >>> +++ b/rust/kernel/alloc/boxext.rs
> >>> @@ -0,0 +1,61 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +
> >>> +//! Extensions to [`Box`] for fallible allocations.
> >>> +
> >>> +use super::Flags;
> >>> +use alloc::boxed::Box;
> >>> +use core::alloc::AllocError;
> >>> +use core::mem::MaybeUninit;
> >>> +use core::result::Result;
> >>> +
> >>> +/// Extensions to [`Box`].
> >>> +pub trait BoxExt<T>: Sized {
> >>> +    /// Allocates a new box.
> >>> +    ///
> >>> +    /// The allocation may fail, in which case an error is returned.
> >>> +    fn new(x: T, flags: Flags) -> Result<Self, AllocError>;
> >>> +
> >>> +    /// Allocates a new uninitialised box.
> >>> +    ///
> >>> +    /// The allocation may fail, in which case an error is returned.
> >>> +    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
> >>> +}
> >>> +
> >>> +impl<T> BoxExt<T> for Box<T> {
> >>> +    #[cfg(any(test, testlib))]
> >>> +    fn new(x: T, _flags: Flags) -> Result<Self, AllocError> {
> >>> +        Ok(Box::new(x))
> >>> +    }
> >>
> >> When running under `cfg(test)`, are we using the normal standard
> >> library? Or why is this needed?
> >
> > Because it uses 34 other crates that rely on `Box::new` and friends.
> >
> > I discussed this with Miguel recently and once he's done with the
> > build system changes, he will think about what to do with tests. It
> > may be that we abandon the current method of running standalone tests
> > and run everything in kunit, or perhaps we'll find a way to exclude
> > code that won't run in standalone tests anyway...
>
> Ah I see, I think it would be nice to not need this. Let's see what the
> new build system can do here.
>
> >
> >>> +
> >>> +    #[cfg(not(any(test, testlib)))]
> >>> +    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
> >>> +        let ptr = if core::mem::size_of::<T>() == 0 {
> >>> +            core::ptr::NonNull::<T>::dangling().as_ptr()
> >>> +        } else {
> >>> +            let layout = core::alloc::Layout::new::<T>();
> >>> +
> >>> +            // SAFETY: Memory is being allocated (first arg is null). The only other source of
> >>> +            // safety issues is sleeping on atomic context, which is addressed by klint.
> >>
> >> The `krealloc_aligned` function states:
> >>
> >> /// # Safety
> >> ///
> >> /// - `ptr` can be either null or a pointer which has been allocated by this allocator.
> >> /// - `new_layout` must have a non-zero size.
> >>
> >> So it should also mention that you checked for `layout.size() > 0`
> >> above.
> >
> > Good point. I mentioned this in the VecExt version but not here. I
> > will update this for v2.
> >
> >>> +            let ptr = unsafe {
> >>> +                super::allocator::krealloc_aligned(core::ptr::null_mut(), layout, flags.0)
> >>> +            };
> >>> +            if ptr.is_null() {
> >>> +                return Err(AllocError);
> >>> +            }
> >>> +
> >>> +            let ptr = ptr.cast::<T>();
> >>> +
> >>> +            // SAFETY: We just allocated the memory above, it is valid for write.
> >>> +            unsafe { ptr.write(x) };
> >>> +            ptr
> >>> +        };
> >>> +
> >>> +        // SAFETY: For non-zero-sized types, we allocate above using the global allocator. For
> >>> +        // zero-sized types, we use `NonNull::dangling`.
> >>> +        Ok(unsafe { Box::from_raw(ptr) })
> >>> +    }
> >>> +
> >>> +    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
> >>> +        <Box<_> as BoxExt<_>>::new(MaybeUninit::<T>::uninit(), flags)
> >>
> >> Why do you use the extended syntax? I tried to use `Box::new` and it
> >> compiled.
> >
> > It works when compiling the kernel but fails when compiling for
> > userspace with regular (no_global_oom_handling disabled) `alloc` when
> > running `make rusttest`. In the latter case, it chooses the inherent
> > version of `Box::new` which is infallible and doesn't take flags so it
> > fails to compile.
> >
> > Using the extended syntax allows it always pick the right version,
> > regardless of how `alloc` is compiled.
> >
> > There are 5 places in existing code that required this change and this
> > is limited to the kernel crate (e.g., drivers, samples and
> > documentation examples can continue to use `Box::new`). So we thought
> > it was ok until Miguel figures out what we want to do with tests.
>
> Thanks for the explanation, again it would be nice to be able to just
> write `Box::new`.

Indeed, that's what I had originally but we don't want to break rusttest.

