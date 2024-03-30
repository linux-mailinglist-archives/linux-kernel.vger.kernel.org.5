Return-Path: <linux-kernel+bounces-125557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18666892883
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 01:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C384728329A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E741869;
	Sat, 30 Mar 2024 00:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHPN2oAn"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1797A10FF;
	Sat, 30 Mar 2024 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711760244; cv=none; b=O5kU+feZBxygalS3Sqh6O/WnPhREh3u+GRICaAHFft1Yk+Zx6aTz6K6dI7Zn/Zp5hduMjjcREcZQbeL0WEubPctDOe9S6hN6m+TFBrX6/6eNfxHpOj8yiT7zeqhq+tLLcYqBeG5BrpjJUfct1lupNreErIsaFbDASEU5ThpNKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711760244; c=relaxed/simple;
	bh=Ue1JJLziHW6spZxizNt7JKufb2uby2ccMf7PhyOksXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RR4lVR37R0YagzA9bvuH/KSAZvEzJ9QAM93Z2mYkfD7TbpkbRYiKAtrSgX/ELfChQoolMlQspsZCtc7RpIvpDpwKPMuj4MRBy/8dom2Zip8a+jn7DBGYYxf3pQZ+oJm7X6kcCbmnOkhckfAreaBOlKdCC1Nrg4dpiJPna4kpmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHPN2oAn; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61431e25ca5so16131107b3.2;
        Fri, 29 Mar 2024 17:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711760242; x=1712365042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VTC9H20T6m7/ByIM+hnHVqtIqVtNwducSugduOzTMqo=;
        b=IHPN2oAnMESFFzyXj1mfKCQskxDf/dEVrxh9ZD29DTQz2aOOVNw1j6kJU0w6U3jRAc
         +h4pwF//pP1goI+1ltLZY0lduumdDeX39ZI8YCnXxgo5BEM5r6X2cXjSYNQuX+JTEQQE
         n44yipg9v9BTuhq21qb0Q1P7ItLf3t6H3mQJzNQYkdrcF4Qsh+plcKMz8JVuJ8lTb3mP
         cE/6vMylwI0StKeAm/5Mr212THxqcgewUkcK8pS4I0E4oklWXjF9zzAkRdw4eTfyGIEV
         9W21oLIBUR9HsJQXGblt/vfoBM8XHP3oWAerRIE8rz9/gpEStzuce34SMxlMq2Y7CytM
         AmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711760242; x=1712365042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTC9H20T6m7/ByIM+hnHVqtIqVtNwducSugduOzTMqo=;
        b=I1CRYkXd4qdooIjsWZsqGZNGW7yaDr8bsmXA9tx+dv0x/JRPOPEHcQLBhhkFzMXsyJ
         IxieCjseCqux4/UP9ReVV9whbFdqwRMRCzIPU3sUtqvzR9Pq5sMrzdod8x3VCem9MJlA
         g8InH4e9jXP/r6SHL0P8UxZWhVL3nE0DH0iB/yoL0OXAPp0Zt6qsV4PWIzMKji5pmAOn
         1TEG1e3ehpOP5RhcitDf9BPazzCzx7BQQWrSozvBdffqMVAvhe5MmRR6Xh6BfsyAd/aS
         R8UlU+MVMNSnu8vq+ac/p+UXmzrDLh/1op8uPB2ysDVXkawfb8O+ehpvHRzn+F/MBIkT
         Gldw==
X-Forwarded-Encrypted: i=1; AJvYcCXTKodN9GMhJgfqQwnYqEfjHp6a00IrGY9kC0A2CxRhymc3RtrZ1ma4S3t0e7ipQj6mhryXYgF+zB4E6pUCNzgq5UFDQiyiJ8snOytg
X-Gm-Message-State: AOJu0Yz1hfvmFWHOIcAU6y+kGiwg7QjRK3ic0tOteWP+UEW1hSv81oB5
	k9NKgGSio4IOhFLsA/js1iqnNezwZ5JRCSNiT4AenneV5lzM5iXhYIoAGXt7dnIFtcBHGM2YiiF
	X3lTk4C3HLTWHFOS0dwq6E+6wsZY=
X-Google-Smtp-Source: AGHT+IFvskvkmWg0t6vLWiiUqTjEUt/wjG55TxzlHdMnjnVdCnoIaR0Df1RuPSFpSzlPDGGo8+iHyuLGTxLfEBkzH9g=
X-Received: by 2002:a81:7707:0:b0:611:2960:e52b with SMTP id
 s7-20020a817707000000b006112960e52bmr4158666ywc.47.1711760242057; Fri, 29 Mar
 2024 17:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328013603.206764-1-wedsonaf@gmail.com> <20240328013603.206764-7-wedsonaf@gmail.com>
 <ZgcBdlELp_5Stdxl@boqun-archlinux>
In-Reply-To: <ZgcBdlELp_5Stdxl@boqun-archlinux>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Fri, 29 Mar 2024 21:57:11 -0300
Message-ID: <CANeycqqKiOXTLoSo5YwL9Qbybdm66uOQ9YeM5exeqTX2PhAUEA@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] rust: alloc: introduce the `BoxExt` trait
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 15:00, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Wed, Mar 27, 2024 at 10:35:59PM -0300, Wedson Almeida Filho wrote:
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
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>
> A small nit below..
>
> > ---
> >  rust/kernel/alloc.rs           |  1 +
> >  rust/kernel/alloc/allocator.rs |  2 +-
> >  rust/kernel/alloc/box_ext.rs   | 60 ++++++++++++++++++++++++++++++++++
> >  rust/kernel/init.rs            | 13 ++++----
> >  rust/kernel/prelude.rs         |  2 +-
> >  rust/kernel/sync/arc.rs        |  3 +-
> >  6 files changed, 72 insertions(+), 9 deletions(-)
> >  create mode 100644 rust/kernel/alloc/box_ext.rs
> >
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index fd5541991a22..9bc1b48b5641 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -5,6 +5,7 @@
> >  #[cfg(not(test))]
> >  #[cfg(not(testlib))]
> >  mod allocator;
> > +pub mod box_ext;
> >  pub mod vec_ext;
> >
> >  /// Flags to be used when allocating memory.
> > diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> > index 8cc7099d6ae1..ff88bce04fd4 100644
> > --- a/rust/kernel/alloc/allocator.rs
> > +++ b/rust/kernel/alloc/allocator.rs
> > @@ -16,7 +16,7 @@
> >  ///
> >  /// - `ptr` can be either null or a pointer which has been allocated by this allocator.
> >  /// - `new_layout` must have a non-zero size.
> > -unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
> > +pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
> >      // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
> >      let layout = new_layout.pad_to_align();
> >
> > diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
> > new file mode 100644
> > index 000000000000..c62db0aa4dd1
> > --- /dev/null
> > +++ b/rust/kernel/alloc/box_ext.rs
> > @@ -0,0 +1,60 @@
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
> > +    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
> > +        let mut b = <Self as BoxExt<_>>::new_uninit(flags)?;
> > +        b.write(x);
> > +        // SAFETY: The contents were just initialised in the line above.
> > +        Ok(unsafe { b.assume_init() })
>
> , since we have the new_uninit feature selected, we can actually do
>
>         fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
>             <Self as BoxExt<_>>::new_uninit(flags).map(|b| Box::write(b, x))
>         }

Oh, this avoids an unsafe block, I like it. Though I think I'm going
to do a slightly different version:

    let b = <Self as BoxExt<_>>::new_uninit(flags)?;
    Ok(Box::write(b, x))

> here.
>
> Regards,
> Boqun
>
> > +    }
> > +
> [...]

