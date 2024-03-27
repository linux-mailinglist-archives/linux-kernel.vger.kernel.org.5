Return-Path: <linux-kernel+bounces-121844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B78F88EE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008A629C5B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F851509A2;
	Wed, 27 Mar 2024 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8dWtw+X"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5112E1ED;
	Wed, 27 Mar 2024 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565042; cv=none; b=aBHvhf3Vs8hZ5+YRv96Ctu72nkTXKunaS1RkKMYP+vdAD/Mwcb1HTpuNnEIw1FeP0qloPTpqJAWyXmYfdg/jFIvtaMVa1y6se2ReUy14nPh88nNpK26qZ0xQVCPZ11lH2Td/je+rySpk/kROkuI9fMAJwY1QM1vZz/Buw2bPjCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565042; c=relaxed/simple;
	bh=MmbQ7l55uIxHWEVCvKQEum7s8u121+kvms3xmDzdD1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+MT5ZPUuife0RQyK9wCZbhvrDmnCSSrx8CWWs8P/0P8LUdRUciLFCGWyYzuM0cnJm1HqZaILvtNQHxR/akOHXAaNZjziGvrtBQ3755++DXmDfnizplaGCaYp82qtZfMbTrLczIIYY9VkwVSJnyiv1BFgQXF56X4w58aeYirLo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8dWtw+X; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so133629276.0;
        Wed, 27 Mar 2024 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711565039; x=1712169839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B7fLV582raHuZTYVRrBAxPwi8zQF2aGd//F2aXwdbxQ=;
        b=J8dWtw+XPmQ3N8zhuQKXVwmSm3ozfQYgf7IcMSVL0novxwzeZ87ipLuKIxhX/PHnI9
         imCSv7DBFS6c3XHOaiqZaWZVX765/z+HtEADZPDDvzCCNAwm1zDTToP8GegNQtNVJ4iR
         touN7KtgE/FJQUega5Hifc3rcMJGR9EavesSy+xCbyBc1u+q1Exsg3Gnn4eURppjeunH
         5sAnnWcKuUZm4BIyYbtoGg3fyNIJsDZEqFaDfAfMWCaTCaxAgs4+2Hvs0mKXE7veN03p
         0hBt4p0rikzBak3z4whtIw4bSply1iXKHPP3l9svBxayjs6FBd5bjSKivMHAWzS06hT2
         8sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711565039; x=1712169839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7fLV582raHuZTYVRrBAxPwi8zQF2aGd//F2aXwdbxQ=;
        b=MLF25FgL3lAMB/zhIMEndE/4wNhFjDetq26vbJWxUGB89mJWp6WG3QMV5TSiMI5dH/
         I2EmSOOQyeofBKxwdgJsu/hLhn6Qkn9+A1TkzAK1ROgLGzLNfwUZdpwQ3F0spp1dkZjA
         Kpo2rGnAnQvs9iI1YNphqSiGsoFrrQgw5kzKvtZlggTHqjTSmpQUt+vWaeY/imT8Irbf
         SopN4b/UStFq5B89Q783Q0QHWaExCNttNVlCgjyAIP4Uf6i9ZzdjNvMbQ/UQk8eUvPLn
         T8gK7btv0fPJ5FEaJ/RW/sProiPwG1wLFwmpXjUB9sHwbpbXkd+lymgM6t1JjYZPWgy7
         yQQA==
X-Forwarded-Encrypted: i=1; AJvYcCViF6JvB1Rb4M7GEKI1kfdxOMYcvD6iczopQyKhJM8SffHI3uuKsiK1B1TPcg8kT6C+uCkgu+P7O7O6PX5CGI1P3NxD4QjTKHIUM1RV
X-Gm-Message-State: AOJu0YyNPBNwPMqvaeecl2YMpxUFklgLbnypdruOrdNhaR8+e48PmO1g
	jCYHEWHXhK/Q4RoXlLmaDaFx6AxnArN7aiwxf1L1Ir0fEDR/oEBTEYYTkTSSTPzCtt4UaijwIY+
	liPI+QJWPisN0V9L06xsQE+aJJGM=
X-Google-Smtp-Source: AGHT+IHdqkNJpApZYbpkDAbcg69anTE3CI1Ez+jkXI9nyo6PCPdcu8isBhBteSKG57eBFc0y4UK4Sn8WAnYazXZTZew=
X-Received: by 2002:a25:ac48:0:b0:dda:aace:9665 with SMTP id
 r8-20020a25ac48000000b00ddaaace9665mr584717ybd.60.1711565039300; Wed, 27 Mar
 2024 11:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327023531.187880-1-wedsonaf@gmail.com> <20240327023531.187880-7-wedsonaf@gmail.com>
 <d9c96a73-bde7-4bd3-bb05-4422fa85c743@proton.me>
In-Reply-To: <d9c96a73-bde7-4bd3-bb05-4422fa85c743@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 27 Mar 2024 15:43:48 -0300
Message-ID: <CANeycqpZ-g2RUT5p4bUD3E_Fyz6u-27WTru4pLsrnPF2pymSBQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] rust: alloc: introduce the `BoxExt` trait
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 14:09, Benno Lossin <benno.lossin@proton.me> wrote:
>
> On 27.03.24 03:35, Wedson Almeida Filho wrote:
> > diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> > index 01ad139e19bc..fc0439455faa 100644
> > --- a/rust/kernel/alloc/allocator.rs
> > +++ b/rust/kernel/alloc/allocator.rs
> > @@ -15,7 +15,11 @@
> >  ///
> >  /// - `ptr` can be either null or a pointer which has been allocated by this allocator.
> >  /// - `new_layout` must have a non-zero size.
> > -unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bindings::gfp_t) -> *mut u8 {
> > +pub(crate) unsafe fn krealloc_aligned(
> > +    ptr: *mut u8,
> > +    new_layout: Layout,
> > +    flags: bindings::gfp_t,
>
> I think it is a good idea to use `Flags` here as well.

Yes, sounds like a good idea. I will do it in the `Flags` patch in v3.

>
> > +) -> *mut u8 {
> >      // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
> >      let layout = new_layout.pad_to_align();
> >
> > diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
> > new file mode 100644
> > index 000000000000..aaa6a20d12b6
> > --- /dev/null
> > +++ b/rust/kernel/alloc/box_ext.rs
> > @@ -0,0 +1,62 @@
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
> > +
> > +    #[cfg(not(any(test, testlib)))]
> > +    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
> > +        let ptr = if core::mem::size_of::<T>() == 0 {
> > +            core::ptr::NonNull::<T>::dangling().as_ptr()
> > +        } else {
> > +            let layout = core::alloc::Layout::new::<T>();
> > +
> > +            // SAFETY: Memory is being allocated (first arg is null). The only other source of
> > +            // safety issues is sleeping on atomic context, which is addressed by klint. Lastly,
> > +            // the type is not a SZT (checked above).
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
> Note that the expression `MaybeUninit::<T>::uninit()` introduces a
> temporary which will be allocated on the stack. If the type `T` is very
> big, then this function will cause immediate stack overflows.
>
> I would recommend to implement `new` in terms of `new_uninit`. The
> `new_uninit` implementation can be almost the same as the current
> implementation of `new`, just remove the `ptr.write(x)` statement.

That's a good point.

For v3 I will implement `new_uninit` with `krealloc_aligned` and use
that to implement `new`.

> --
> Cheers,
> Benno
>
> > +    }
> > +}
>

