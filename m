Return-Path: <linux-kernel+bounces-72350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D57A85B253
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A095D1F2448E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAFD56B9C;
	Tue, 20 Feb 2024 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7bx/V/K"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C4A54FA0;
	Tue, 20 Feb 2024 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407387; cv=none; b=s3Df+FRtsKiOPhH/T2AzNhB6WEA2iTx2bFDxVFKpHZpzXppkxgFkXwhmemTnlaPOugZ74ZiZs1cmCMXFVlwjVrxyF6Pt8uFi0G3/6+endnj3lUOnKqHk8dIAPHOxQRcVeubck1AoCa3wbONrMTCuhe83qkLJBtyOrRkCghcnRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407387; c=relaxed/simple;
	bh=xyIQusYKt9ehEP8fBy/oK7NAGJShA0lLMZOP159AO68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1X94PLp0KsjgTiPYyJFkh2JINN54NQjYqHUSikX1U7GoGhSLMgy14n+oIjCqReLAlBY/QpkuadpuH21un17D6D9uKG43wa3lt4WBZ+E7+FqkgAshpyA0ORBL27wOQqd//zbz7K1Fr2iVmPqTYH37vdQRc4n2/asSS1L99uRyOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7bx/V/K; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a4516ec46so54596381cf.0;
        Mon, 19 Feb 2024 21:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708407384; x=1709012184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPoj/GBmRVxE2Hbxo4fV51+00H1ou0rrTPdWMJ87ap8=;
        b=f7bx/V/KzDNsXJ2/7lXZfsOBCwFzUCEoNn8EP9BSl9goSoqcSaKJ46hSlPwJ4brh3L
         3F6oxOFOu0JEFTXnhx+MulE+00FvdVkz4YCjw9PWmV4AMl32imu0hhB/Sp4+Dl5I/LAr
         9iPKq6ptQmZ+X58vM6qOB5Sfub328Cs57O4w7Lb/j9SfNR7YWpliS9sXoi4RLQa9f6Sh
         WIXaPjWddGMwlNtOrzMwIaxF/1vxDyjn17gyfZRJH2yYZjHLFcJBpNJl/Wdk759mcobn
         g00l2ZWZl16VGWI0nqt1RNjlgu8cWaI5+41/HZVI+qatB6gO7fMnG1PFyeRiG36TGAJ5
         6rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708407384; x=1709012184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPoj/GBmRVxE2Hbxo4fV51+00H1ou0rrTPdWMJ87ap8=;
        b=QknYKg6InZf6gGLdg92qHRplmn/JEUK9PtjMxdVqClIdCxjuOGcPV1YepZdIrK5Y08
         IHviHEkV/V3fw4LgS74em5ZoL2UoA9V/YQab8b7NlGYHeFJp3cZPEJArweRzLasoPZwb
         D6pluRwb5a77RKnaHrpOWUATYLXFnlHqzcnHQUiRAw5VIneYo6jhruMDF9IDmJRfkKsJ
         b/hlCg/NXNxYJ1KgNyqsx9/lsgJ3hBxqapS+J8AWvFqVlkVbI3h4wT2Cha3YZPcr5hqo
         6vjKfwGQRA57vgfKw7PIvQ7z9QhQKod//wEG782gGW2y70vBa1EUnuWoh/cBiDALWofb
         SiLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFCiyodBHhJ6OTVusD4K4DW/V+Q0Tv31V1d1y5iVmIR/XbbmNfzHUhD5mWIPT16eLjzJJzV8B5Pug60691c4jDnI4WNDcdq+0W/RfwM2zAMD4fOYln+d6+wr9q0eTGU+H9j5OcvThGTpet3Qs=
X-Gm-Message-State: AOJu0Yx5ervUgo6uTfuLnWCbYNblcEX/l/iafBqvn7AVOqtpyXhcNJyt
	DVZiTNnFTg46scpCzSSaCDUW2UKWGn+mREjOPt52o8VfDjKcUfH1
X-Google-Smtp-Source: AGHT+IGYwu+r2kN4BSroO24XFTd4yIVr7Xb4qJa1UZw5N2n7nds55MiO1Ob/oid1u4PYU139bxzBqg==
X-Received: by 2002:ac8:5e4a:0:b0:42d:bf56:89b5 with SMTP id i10-20020ac85e4a000000b0042dbf5689b5mr21531696qtx.2.1708407384155;
        Mon, 19 Feb 2024 21:36:24 -0800 (PST)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id c19-20020ac85193000000b0042c524de19asm3169864qtn.58.2024.02.19.21.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 21:36:23 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 017D01200043;
	Tue, 20 Feb 2024 00:36:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 20 Feb 2024 00:36:23 -0500
X-ME-Sender: <xms:VjrUZaepqXSBEma02pr-hq7nxQWuY4H6RaeaPLm3hiPogqoHL0VUDA>
    <xme:VjrUZUNik5pobLJrRgwgh0bvWT6TYuzR3RG_0LaHn6HAht0Xf6wkjKSCtDG1lUClr
    eho58dpVu7nwQX3hA>
X-ME-Received: <xmr:VjrUZbhgLeLgO0HVLEpf8IvIedm-LOsxcpZ93g1WvaUjL4Ph3axcmhVN-B8l1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdtkeei
    hedvnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqh
    hunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:VjrUZX_quhCIXnYC8qn32oZHDykDM93PGFEiL0IKsT__XOnpZMAuRg>
    <xmx:VjrUZWu2m5kRwwIz1Zog6xG48HxcLRGE1FAJbktROnJxUwkYg00GTw>
    <xmx:VjrUZeFpu8JR9CIkPNM6oAyNERvP1qb2A_w1H7E9_HxDy6YfrCkwtA>
    <xmx:VjrUZXm52JDcK9RmlxqmWd7tPdJZpS88ouv7qm9mAmVZcHvQ5NXjARp79M0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 00:36:22 -0500 (EST)
Date: Mon, 19 Feb 2024 21:36:05 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: sync: add `ArcBorrow::from_raw`
Message-ID: <ZdQ6RRYtvazV7WPR@boqun-archlinux>
References: <20240219-arc-for-list-v1-0-d98cd92c760b@google.com>
 <20240219-arc-for-list-v1-1-d98cd92c760b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219-arc-for-list-v1-1-d98cd92c760b@google.com>

On Mon, Feb 19, 2024 at 02:54:11PM +0000, Alice Ryhl wrote:
> Allows access to a value in an `Arc` that is currently held as a raw
> pointer due to use of `Arc::into_raw`, without destroying or otherwise
> consuming that raw pointer.
> 
> This is a dependency of the linked list that Rust Binder uses. The
> linked list uses this method when iterating over the linked list.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/arc.rs | 72 ++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 54 insertions(+), 18 deletions(-)
> 
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 7d4c4bf58388..a5314df409e7 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -232,27 +232,13 @@ pub fn into_raw(self) -> *const T {
>      /// `ptr` must have been returned by a previous call to [`Arc::into_raw`]. Additionally, it
>      /// must not be called more than once for each previous call to [`Arc::into_raw`].
>      pub unsafe fn from_raw(ptr: *const T) -> Self {
> -        let refcount_layout = Layout::new::<bindings::refcount_t>();
> -        // SAFETY: The caller guarantees that the pointer is valid.
> -        let val_layout = Layout::for_value(unsafe { &*ptr });
> -        // SAFETY: We're computing the layout of a real struct that existed when compiling this
> -        // binary, so its layout is not so large that it can trigger arithmetic overflow.
> -        let val_offset = unsafe { refcount_layout.extend(val_layout).unwrap_unchecked().1 };
> -
> -        // Pointer casts leave the metadata unchanged. This is okay because the metadata of `T` and
> -        // `ArcInner<T>` is the same since `ArcInner` is a struct with `T` as its last field.
> -        //
> -        // This is documented at:
> -        // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
> -        let ptr = ptr as *const ArcInner<T>;
> -
> -        // SAFETY: The pointer is in-bounds of an allocation both before and after offsetting the
> -        // pointer, since it originates from a previous call to `Arc::into_raw` and is still valid.
> -        let ptr = unsafe { ptr.byte_sub(val_offset) };
> +        // SAFETY: The pointer returned by `into_raw` points at the `data` field of an
> +        // `ArcInner<T>`, as promised by the caller.
> +        let ptr = unsafe { raw_to_inner_ptr(ptr) };
>  
>          // SAFETY: By the safety requirements we know that `ptr` came from `Arc::into_raw`, so the
>          // reference count held then will be owned by the new `Arc` object.
> -        unsafe { Self::from_inner(NonNull::new_unchecked(ptr.cast_mut())) }
> +        unsafe { Self::from_inner(ptr) }
>      }
>  
>      /// Returns an [`ArcBorrow`] from the given [`Arc`].
> @@ -273,6 +259,35 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>      }
>  }
>  
> +/// Converts a pointer to the contents of an [`Arc`] into a pointer to the [`ArcInner`].
> +///
> +/// # Safety
> +///
> +/// The provided pointer must point the `data` field of an `ArcInner<T>` value.
> +unsafe fn raw_to_inner_ptr<T: ?Sized>(ptr: *const T) -> NonNull<ArcInner<T>> {

Nit: put this into an `impl<T:?Sized> ArcInner<T>` block maybe?

> +    let refcount_layout = Layout::new::<bindings::refcount_t>();
> +    // SAFETY: The caller guarantees that the pointer is valid.
> +    let val_layout = Layout::for_value(unsafe { &*ptr });
> +    // SAFETY: We're computing the layout of a real struct that existed when compiling this
> +    // binary, so its layout is not so large that it can trigger arithmetic overflow.
> +    let val_offset = unsafe { refcount_layout.extend(val_layout).unwrap_unchecked().1 };
> +
> +    // Pointer casts leave the metadata unchanged. This is okay because the metadata of `T` and
> +    // `ArcInner<T>` is the same since `ArcInner` is a struct with `T` as its last field.
> +    //
> +    // This is documented at:
> +    // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
> +    let ptr = ptr as *const ArcInner<T>;
> +
> +    // SAFETY: The pointer is in-bounds of an allocation both before and after offsetting the
> +    // pointer, since it originates from a previous call to `Arc::into_raw` and is still valid.

"since it originate from a previous call to `Arc::into_raw`" is the
safety requirement of `Arc::from_raw`, since the safety requirement of
`raw_to_inner_ptr` is different, so I think we should say "since the
function safety requirement guarantees `ptr` points to `data` field,
which is exactly `val_offset` away from the beginning of `ArcInner<T>`".
Thoughts?

BTW, in fat pointer cases, by "must point the `data` field of an
`ArcInner<T>` value", it means both the address and the metadata should
be the same as the original object in `ArcInner<T>`, right? In other
words, the following code should not be safe, i.e. the
raw_to_inner_ptr() safety requirement is not satisfied.

	let x: Arc<[u8]> // assume x.len() == 4

	let y = &(x[0..1]) as *const [u8] // y has the same address of
					  // the `data` field of `x`.
	
	let inner = unsafe { raw_to_inner_ptr(y) };
	// ^^^ the safety requirement is not satisfied???

This may not be important since the users of `raw_to_inner_ptr` all have
stronger safey guarantees ("`ptr` must come from `Arc::into_raw()`"),
and `raw_to_inner_ptr` is not a pub function, but I just wonder whether
we need to improve the current safety requirements, or "point" means
both address and metadata for fat pointers?

Regards,
Boqun

> +    let ptr = unsafe { ptr.byte_sub(val_offset) };
> +
> +    // SAFETY: The pointer can't be null since you can't have an `ArcInner<T>` value at the null
> +    // address.
> +    unsafe { NonNull::new_unchecked(ptr.cast_mut()) }
> +}
> +
>  impl<T: 'static> ForeignOwnable for Arc<T> {
>      type Borrowed<'a> = ArcBorrow<'a, T>;
>  
> @@ -453,6 +468,27 @@ unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
>              _p: PhantomData,
>          }
>      }
> +
> +    /// Creates an [`ArcBorrow`] to an [`Arc`] that has previously been deconstructed with
> +    /// [`Arc::into_raw`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// * The provided pointer must originate from a call to [`Arc::into_raw`].
> +    /// * For the duration of the lifetime annotated on this `ArcBorrow`, the reference count must
> +    ///   not hit zero.
> +    /// * For the duration of the lifetime annotated on this `ArcBorrow`, there must not be a
> +    ///   [`UniqueArc`] reference to this value.
> +    pub unsafe fn from_raw(ptr: *const T) -> Self {
> +        // SAFETY: The pointer returned by `into_raw` points at the `data` field of an
> +        // `ArcInner<T>`.
> +        let ptr = unsafe { raw_to_inner_ptr(ptr) };
> +
> +        // SAFETY: The caller promises that the value remains valid since the reference count must
> +        // not hit zero, and no mutable reference will be created since that would involve a
> +        // `UniqueArc`.
> +        unsafe { Self::new(ptr) }
> +    }
>  }
>  
>  impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
> 
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

