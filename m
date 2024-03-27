Return-Path: <linux-kernel+bounces-120274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E47E88D52B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74122A347D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E209D22F17;
	Wed, 27 Mar 2024 03:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfr3dYvq"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD20C20DD0;
	Wed, 27 Mar 2024 03:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511327; cv=none; b=ZeCmljYgrUN8e1MQijk2olWf8eve9syJp1hJYpx54Qf1uhaG29upR4G2M0vzwX+GSoLFPp+aNxDGLsRBeM6xvWZ8ShGKyrXn5nyFsx73UE3WezxL5P7G9h+dDnRrZZPZCO/UQWbW8sa4+1oWNQaowTSLRjOApjZItG/iHr+dC/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511327; c=relaxed/simple;
	bh=5qjQPrBi6e/x3EXYcON8v93mBisLOC72LJ9+ecA/udM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktZ5Z24QOHL3tTmatmSLBAaXGbAfZbo3gfIWnMKbdlhyCyx88+EYCsBdOhJA/lxnjlgx2w5qKh/SGjYKvpJePZXx2UEpj9Ari6jl6yaYvBsMXWGSsitAdV6X7RfqjCYQmpwXQip8sdXm7VDt5K2CLSGUxGf+zp2spK956r4OOzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfr3dYvq; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609ed7ca444so61891557b3.1;
        Tue, 26 Mar 2024 20:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711511325; x=1712116125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abKYYR0MbH3vAM67c27QBpKh6djYCTiVvSMZ6eYuCEo=;
        b=mfr3dYvqNMRLTowOKpch8xBYr1+0cAOuPkveMpdSYpigfSo0YmJ3sJZLblkIg5Hb5P
         nPNoWGUdzTQLCGBJd53NJ27sQaodBvdlmzGmlz54isIGzxUkAva7L79X7TB/iCJJfjCz
         Y21mGpUW2Ru4XM2QuOk4mQyn+/FQOltYX2Plkjg7RJgSWetjqCgo1PkMcAsarO5xernB
         tUMFygjWYNrTLy4vwZxfakH7nlPpYgEJoser1lbYcziGETfCbA8Pkbf0QmxjShjDotCQ
         /oX+nKUcp6s87IFGzz38NLg5Y/dBA7q9w7ggTtvdvArCBkAwJu3d/HkQBAstQ8byzcKi
         zS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711511325; x=1712116125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abKYYR0MbH3vAM67c27QBpKh6djYCTiVvSMZ6eYuCEo=;
        b=bAFxLjwqS+fj/4cgiwXPG9694xB8mZytu+BHngF5/XO6Q8/ZgmeJom1ze8ST3spDVp
         M8lSlm1HSIivHTCqCcVb2RhGMI7GBmO//fZ01vRVlPsd8Bti8+e9tT6OfVVPPnczeTt6
         64eGbwx/JZK2wKnAbX58buNtpM8aciUvjYJNxudJ5GwLcUBPSUejWE0LQFwrDTZ+zB+s
         TTZXKQU+FUiJAt1HMDLhoa3ZiAOLWxxgvmp/LPS2fEhZ+AyIGuNymQc7duN3YYCNJtud
         8uaTNkCtiEL8RnAhpl1xoKEyLPT4yYvkC47m6OKzuu/nT/H7Ibmd28YJVow47/yI3Xus
         k2vg==
X-Forwarded-Encrypted: i=1; AJvYcCVzZh46iIlz3Tp0ehYBmSF6k+Qo+433JEgMgp7+X95+6HmZTE3Jfe7JV1R8Q3jJzO/XUKlcK5WN1VbWbDK0s/eDVNh+ye95OdwY+20F
X-Gm-Message-State: AOJu0YxCRBkOZJmP37qUd5J44LZFUSBJPuyz2b67oWN+G6bpymxjpsrZ
	gLEv0uEGcOYEpD8C+dGDJxCg0l7nlqpvu4aEv5yZLmh3l9HDMn6q
X-Google-Smtp-Source: AGHT+IGOthuw15pTc217L+OY0k7NDpxRks9kYlR+XMpTcSa3rC/VN8z/royd7MJC87t+WQvK8E8+kg==
X-Received: by 2002:a0d:e602:0:b0:611:2cf3:22 with SMTP id p2-20020a0de602000000b006112cf30022mr2896796ywe.33.1711511324398;
        Tue, 26 Mar 2024 20:48:44 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id he37-20020a05622a602500b00430bad81704sm4363708qtb.52.2024.03.26.20.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 20:48:43 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 5362D1200032;
	Tue, 26 Mar 2024 23:48:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 26 Mar 2024 23:48:43 -0400
X-ME-Sender: <xms:GpcDZg6OmVslLCyKrd9dDY0MCGp399d0WjDWsRD73jdqZfXeOT49tQ>
    <xme:GpcDZh4s4FakdF64j7WW7tI3OblYPosm_hDvHoGIchWXSKzIJ5JDlbeX1hKbweJI2
    Vnr_HQFEmzaEKBn4Q>
X-ME-Received: <xmr:GpcDZvcUHgybV08fMSOB8f1E-8MDFQSx8CYc8uwNVA63Tck0p7VuiK-0WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedvveevleevhfekhefftdek
    ieehvdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:GpcDZlJDPPrxz62kZXWj52E4claMAqlwTYk65xInLVC6gHFtzI7LPA>
    <xmx:GpcDZkIaABgtHo2YDQJj_gF_8vzVkTd7vIdH0wboiy4qzYO1yTapdg>
    <xmx:GpcDZmwWYUGCWbKh4v-XUg7DbLjGqqD3odkd-f6MR53Ow7301wHV7Q>
    <xmx:GpcDZoIlqdZ77b3o3oDhWQV-Q38PmZpzhYxqH21fLbFtKABIcEJGiQ>
    <xmx:G5cDZmCK0ThrA9GOcAIkYM4tpLt7f3Yz_mB3j1Vjbvr7eFumBjfPFqQRAVM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 23:48:42 -0400 (EDT)
Date: Tue, 26 Mar 2024 20:48:41 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 07/10] rust: alloc: update `VecExt` to take allocation
 flags
Message-ID: <ZgOXGSDmIgrENB7d@Boquns-Mac-mini.home>
References: <20240327023531.187880-1-wedsonaf@gmail.com>
 <20240327023531.187880-8-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327023531.187880-8-wedsonaf@gmail.com>

On Tue, Mar 26, 2024 at 11:35:28PM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> We also rename the methods by removing the `try_` prefix since the names
> are available due to our usage of the `no_global_oom_handling` config
> when building the `alloc` crate.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/kernel/alloc/vec_ext.rs | 106 ++++++++++++++++++++++++++++++-----
>  rust/kernel/error.rs         |  11 +---
>  rust/kernel/lib.rs           |   1 -
>  rust/kernel/str.rs           |   6 +-
>  rust/kernel/types.rs         |   4 +-
>  samples/rust/rust_minimal.rs |   6 +-
>  6 files changed, 100 insertions(+), 34 deletions(-)
> 
> diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
> index 311e62cc5784..bb6cb1c4ea67 100644
> --- a/rust/kernel/alloc/vec_ext.rs
> +++ b/rust/kernel/alloc/vec_ext.rs
> @@ -2,47 +2,123 @@
>  
>  //! Extensions to [`Vec`] for fallible allocations.
>  
> -use alloc::{collections::TryReserveError, vec::Vec};
> +use super::Flags;
> +use alloc::{alloc::AllocError, vec::Vec};
>  use core::result::Result;
>  
>  /// Extensions to [`Vec`].
>  pub trait VecExt<T>: Sized {
>      /// Creates a new [`Vec`] instance with at least the given capacity.
> -    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError>;
> +    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError>;
>  
>      /// Appends an element to the back of the [`Vec`] instance.
> -    fn try_push(&mut self, v: T) -> Result<(), TryReserveError>;
> +    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError>;
>  
>      /// Pushes clones of the elements of slice into the [`Vec`] instance.
> -    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
> +    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
>      where
>          T: Clone;
> +
> +    /// Ensures that the capacity exceeds the length by at least `additional` elements.
> +    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError>;
>  }
>  
>  impl<T> VecExt<T> for Vec<T> {
> -    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError> {
> +    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError> {
>          let mut v = Vec::new();
> -        v.try_reserve(capacity)?;
> +        <Self as VecExt<_>>::reserve(&mut v, capacity, flags)?;
>          Ok(v)
>      }
>  
> -    fn try_push(&mut self, v: T) -> Result<(), TryReserveError> {
> -        if let Err(retry) = self.push_within_capacity(v) {
> -            self.try_reserve(1)?;
> -            let _ = self.push_within_capacity(retry);
> -        }
> +    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
> +        <Self as VecExt<_>>::reserve(self, 1, flags)?;
> +        let s = self.spare_capacity_mut();
> +        s[0].write(v);
> +
> +        // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
> +        // by 1. We also know that the new length is <= capacity because of the previous call to
> +        // `reserve` above.
> +        unsafe { self.set_len(self.len() + 1) };
>          Ok(())
>      }
>  
> -    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
> +    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
>      where
>          T: Clone,
>      {
> -        self.try_reserve(other.len())?;
> -        for item in other {
> -            self.try_push(item.clone())?;
> +        <Self as VecExt<_>>::reserve(self, other.len(), flags)?;
> +        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), other) {
> +            slot.write(item.clone());

/me likes this! ;-) Too bad `write_slice_cloned()` is not stablized:

	https://doc.rust-lang.org/core/mem/union.MaybeUninit.html#method.write_slice_cloned

>          }
>  
> +        // SAFETY: We just initialised the `other.len()` spare entries, so it is safe to increase
> +        // the length by the same amount. We also know that the new length is <= capacity because
> +        // of the previous call to `reserve` above.
> +        unsafe { self.set_len(self.len() + 1) };

should be

	unsafe { self.set_len(self.len() + other.len()) };

, right?

We probably should put some unit tests for these functions.

> +        Ok(())
> +    }
> +
> +    #[cfg(any(test, testlib))]
> +    fn reserve(&mut self, additional: usize, _flags: Flags) -> Result<(), AllocError> {
> +        Vec::reserve(self, additional);
>          Ok(())
>      }
> +
> +    #[cfg(not(any(test, testlib)))]
> +    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
> +        let len = self.len();
> +        let cap = self.capacity();
> +
> +        if cap - len >= additional {
> +            return Ok(());
> +        }
> +
> +        if core::mem::size_of::<T>() == 0 {
> +            // The capacity is already `usize::MAX` for SZTs, we can't go higher.
> +            return Err(AllocError);
> +        }
> +
> +        // We know cap is <= `isize::MAX` because `Layout::array` fails if the resulting byte size
> +        // is greater than `isize::MAX`. So the multiplication by two won't overflow.
> +        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
> +        let layout = core::alloc::Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
> +
> +        let (ptr, len, cap) = destructure(self);
> +
> +        // SAFETY: `ptr` is valid because it's either NULL or comes from a previous call to
> +        // `krealloc_aligned`. We also verified that the type is not a ZST.
> +        let new_ptr = unsafe { super::allocator::krealloc_aligned(ptr.cast(), layout, flags.0) };

One optimization we can do later: if the alignment requirement of `T` is
larger than SLAB_MINALIGN, `krealloc_aligned()` will allocate a power
of 2 bytes big enough to hold `layout`, that means we may have enough
room to fit extra `T`s, for example:

	if align of `T` is 32 and size of `T` is 96, `new_cap` is 4,
	then the size of array is 96 * 4 = 384, and `krealloc_aligned()`
	will allocate 512 bytes, and we can fit an extra `T` here
	(because 512 - 384 = 128 > 96)

But of course, I don't think we have such a user yet. I will open an
issue later this week if this sounds reasonable.

The rest looks good to me. (`destructure` and `rebuild` are obviously
very creative to me ;-))

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> +        if new_ptr.is_null() {
> +            // SAFETY: We are just rebuilding the existing `Vec` with no changes.
> +            unsafe { rebuild(self, ptr, len, cap) };
> +            Err(AllocError)
> +        } else {
> +            // SAFETY: `ptr` has been reallocated with the layout for `new_cap` elements. New cap
> +            // is greater than `cap`, so it continues to be >= `len`.
> +            unsafe { rebuild(self, new_ptr.cast::<T>(), len, new_cap) };
> +            Ok(())
> +        }
> +    }
> +}
> +
> +#[cfg(not(any(test, testlib)))]
> +fn destructure<T>(v: &mut Vec<T>) -> (*mut T, usize, usize) {
> +    let mut tmp = Vec::new();
> +    core::mem::swap(&mut tmp, v);
> +    let mut tmp = core::mem::ManuallyDrop::new(tmp);
> +    let len = tmp.len();
> +    let cap = tmp.capacity();
> +    (tmp.as_mut_ptr(), len, cap)
> +}
> +
> +/// Rebuilds a `Vec` from a pointer, length, and capacity.
> +///
> +/// # Safety
> +///
> +/// The same as [`Vec::from_raw_parts`].
> +#[cfg(not(any(test, testlib)))]
> +unsafe fn rebuild<T>(v: &mut Vec<T>, ptr: *mut T, len: usize, cap: usize) {
> +    // SAFETY: The safety requirements from this function satisfy those of `from_raw_parts`.
> +    let mut tmp = unsafe { Vec::from_raw_parts(ptr, len, cap) };
> +    core::mem::swap(&mut tmp, v);
>  }
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 4786d3ee1e92..e53466937796 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -6,10 +6,7 @@
>  
>  use crate::str::CStr;
>  
> -use alloc::{
> -    alloc::{AllocError, LayoutError},
> -    collections::TryReserveError,
> -};
> +use alloc::alloc::{AllocError, LayoutError};
>  
>  use core::convert::From;
>  use core::fmt;
> @@ -192,12 +189,6 @@ fn from(_: Utf8Error) -> Error {
>      }
>  }
>  
> -impl From<TryReserveError> for Error {
> -    fn from(_: TryReserveError) -> Error {
> -        code::ENOMEM
> -    }
> -}
> -
>  impl From<LayoutError> for Error {
>      fn from(_: LayoutError) -> Error {
>          code::ENOMEM
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 7f2841a18d05..51f30e55bd00 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -19,7 +19,6 @@
>  #![feature(offset_of)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
> -#![feature(vec_push_within_capacity)]
>  
>  // Ensure conditional compilation based on the kernel configuration works;
>  // otherwise we may silently break things like initcall handling.
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index e1be6c5e72a9..58f2ddafb326 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -2,7 +2,7 @@
>  
>  //! String representations.
>  
> -use crate::alloc::vec_ext::VecExt;
> +use crate::alloc::{flags::*, vec_ext::VecExt};
>  use alloc::alloc::AllocError;
>  use alloc::vec::Vec;
>  use core::fmt::{self, Write};
> @@ -730,7 +730,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
>          let size = f.bytes_written();
>  
>          // Allocate a vector with the required number of bytes, and write to it.
> -        let mut buf = Vec::try_with_capacity(size)?;
> +        let mut buf = <Vec<_> as VecExt<_>>::with_capacity(size, GFP_KERNEL)?;
>          // SAFETY: The buffer stored in `buf` is at least of size `size` and is valid for writes.
>          let mut f = unsafe { Formatter::from_buffer(buf.as_mut_ptr(), size) };
>          f.write_fmt(args)?;
> @@ -771,7 +771,7 @@ impl<'a> TryFrom<&'a CStr> for CString {
>      fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
>          let mut buf = Vec::new();
>  
> -        buf.try_extend_from_slice(cstr.as_bytes_with_nul())
> +        <Vec<_> as VecExt<_>>::extend_from_slice(&mut buf, cstr.as_bytes_with_nul(), GFP_KERNEL)
>              .map_err(|_| AllocError)?;
>  
>          // INVARIANT: The `CStr` and `CString` types have the same invariants for
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index aa77bad9bce4..8fad61268465 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -157,11 +157,11 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
>  ///     let mut vec =
>  ///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
>  ///
> -///     vec.try_push(10u8)?;
> +///     vec.push(10u8, GFP_KERNEL)?;
>  ///     if arg {
>  ///         return Ok(());
>  ///     }
> -///     vec.try_push(20u8)?;
> +///     vec.push(20u8, GFP_KERNEL)?;
>  ///     Ok(())
>  /// }
>  ///
> diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
> index dc05f4bbe27e..2a9eaab62d1c 100644
> --- a/samples/rust/rust_minimal.rs
> +++ b/samples/rust/rust_minimal.rs
> @@ -22,9 +22,9 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
>          pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
>  
>          let mut numbers = Vec::new();
> -        numbers.try_push(72)?;
> -        numbers.try_push(108)?;
> -        numbers.try_push(200)?;
> +        numbers.push(72, GFP_KERNEL)?;
> +        numbers.push(108, GFP_KERNEL)?;
> +        numbers.push(200, GFP_KERNEL)?;
>  
>          Ok(RustMinimal { numbers })
>      }
> -- 
> 2.34.1
> 

