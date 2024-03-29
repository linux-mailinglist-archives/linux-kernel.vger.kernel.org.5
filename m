Return-Path: <linux-kernel+bounces-125267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610C9892317
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CD01F22803
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C32D52F79;
	Fri, 29 Mar 2024 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOUarjed"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA6F1E893;
	Fri, 29 Mar 2024 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735207; cv=none; b=U9TwkIYrYNO+sSwAzRmI43CtOIfNIbKuxgjdNKUNALzGg78Mx++pCR/qWsmYK2CvC60eoXcWoey/N/Or7gKolt8y5jctqcJD+gheWimZ+RFgMxA0oE7ndh6a+k6pk1snlVKbK1e/UrmNW5uH8V707EwGwRbUtvL3zZ+CnBD6vTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735207; c=relaxed/simple;
	bh=emlV9Q5PjY09S2AGsJFyLMrHOzGU+5421Us+5zLpyEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLra/OaPdJF8eyh8eUNpx4Yd5e9Lqio3vAfpwm05YnM98eIXbGUa3EkIYSQU0SIsE2MqSyFj9kNPulf4dbTSTYv878UBQer2FU238X2zikv1VQy+aOs9l1Q6W93fZcG0AOUPNL7U/TXHPF76Nua8o3GEU8rCBP4JfCuEy//cmOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOUarjed; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61444fb1d2bso6737797b3.3;
        Fri, 29 Mar 2024 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711735204; x=1712340004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvHT6XIk5yf7N2YmNeAfioG0CmuxxDnTNjG9kq5b64A=;
        b=bOUarjedbVsJ7otCl8/tWRd3QSjRriMmpN5VY8RDAIvnXfsXcKpHI5EPHY6rbkENIS
         kZy8cwt3hCy6otd4Jt4BE8XpIi/kpgersG+XDLZpsr76ndbxiiP7uhBFPTSx5KPAfRrJ
         oqyL1NZfhGCxtLWqs6KippMasj8dLIGUW1FyryvsnYe6M/bAMlf5TN2LA1RgCkZ3zavA
         m/fFK76T7DCowd9N0/H62ac2X4B04Pzus4c4AXYD51ID66RmjGqs5xU6L9ck30crfQMK
         AU9Z/cCqhnTEjZx5xfwVBH8V89crmV4V7wEL9Du032PR5+cpETFZSRs0KMVvOUNu6Jcn
         mmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711735204; x=1712340004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvHT6XIk5yf7N2YmNeAfioG0CmuxxDnTNjG9kq5b64A=;
        b=vl2YqvuvqEaTEt1PLw4Sgy532trJ01yu4a7HBKdheHykt2ZpzpzysWKEqMgkYEFNvn
         WpAKwToQhsQEF7vYyeDvulJ7Co07IjuZ52ijZ9GFOxTKwxKkOtRC6NeKm995nVvWKwiL
         LGsRrj255a9iOi/7M1QUSEZAkUhB7KJ+dnmF/O5AyPKNIR19rxf4a8YmGtGu4oIWiHEB
         kAa+sf6DYz54ZzCIQEb4HEftXy1IqwwUPpeO7LvcOlq/HBMGM3XANdfIPOpODziBfCt3
         MyC8K09HZnqS0/YPSDovNKPnW79JkeooWvVlLNGtyRTmbbRW4LPXA5ehPHyYPlN1O6xz
         y66A==
X-Forwarded-Encrypted: i=1; AJvYcCWX28UbCWKos/CS6puojotiUoVGgCzNjdtTDAoi14CHB9rn1olXZd5pBD9yf/BhAlIYqfvCpgc9ur9AaK0EVv81yQJflzaNhhfJHpTt
X-Gm-Message-State: AOJu0YzQcpovuuyRfXYXqpjw0yJi2dFH5ukDjoDYKxnG0nBreyl6lTUr
	IQnLx0ioydw2Pip2nQXcuZn4oWq5n2fGL8UEBQ14YaBpQIsAffmFUDnhNKc3
X-Google-Smtp-Source: AGHT+IH+QabeyKBiq4x31PNIsVw9DkVPH8G0E/xK6z3ZQs5+sfk07QNnYEydgg+98Y6NaF7n2swWYg==
X-Received: by 2002:a81:6c89:0:b0:609:7055:f725 with SMTP id h131-20020a816c89000000b006097055f725mr2928694ywc.18.1711735204101;
        Fri, 29 Mar 2024 11:00:04 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id c13-20020a05620a200d00b0078a390fb634sm1529171qka.47.2024.03.29.11.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 11:00:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 3B7191200069;
	Fri, 29 Mar 2024 14:00:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 29 Mar 2024 14:00:02 -0400
X-ME-Sender: <xms:oQEHZmzX0cxBIyAEUYgWvj4_6KW4ayaRSHL6nDmnUW8HhupYH0mpNw>
    <xme:oQEHZiTdaUTwqFT2dVlYoumNor_oxWGYXWlSJfYvsQhMrpdr6ag4QGrSQbNTG_G8q
    nR3tTuXN4qbWObc4Q>
X-ME-Received: <xmr:oQEHZoXYUUoGSRNQps04nRhEKZaGVwN0NV7rNtvZPIzBrm7XT2q-wu1aGsQdPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvvddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:oQEHZsga4GKdbQia3I-L9quQzQyz2Bj-NzuazctXg-p6iLfMOdhFlg>
    <xmx:oQEHZoDbHs4RH3Y_LLW5vDj3pMPVtoQDhRF14DXt02X2hzEAuvBzIw>
    <xmx:oQEHZtIRP1eUc9frkEl686T3Ij2N3fQgcUVS8xsiXElAj4xaEAO41w>
    <xmx:oQEHZvDTEswbEMOQQVBSnAtUk2deRigCOGgQtO-7AWhVluPD66AILQ>
    <xmx:ogEHZk6w26VhBGcqLxi7uo0xFr9o4WdMecbq9vMuOnSNmGHJzV7SaVaMA6Y>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Mar 2024 14:00:01 -0400 (EDT)
Date: Fri, 29 Mar 2024 10:59:18 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v3 06/10] rust: alloc: introduce the `BoxExt` trait
Message-ID: <ZgcBdlELp_5Stdxl@boqun-archlinux>
References: <20240328013603.206764-1-wedsonaf@gmail.com>
 <20240328013603.206764-7-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328013603.206764-7-wedsonaf@gmail.com>

On Wed, Mar 27, 2024 at 10:35:59PM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> Make fallible versions of `new` and `new_uninit` methods available in
> `Box` even though it doesn't implement them because we build `alloc`
> with the `no_global_oom_handling` config.
> 
> They also have an extra `flags` parameter that allows callers to pass
> flags to the allocator.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

A small nit below..

> ---
>  rust/kernel/alloc.rs           |  1 +
>  rust/kernel/alloc/allocator.rs |  2 +-
>  rust/kernel/alloc/box_ext.rs   | 60 ++++++++++++++++++++++++++++++++++
>  rust/kernel/init.rs            | 13 ++++----
>  rust/kernel/prelude.rs         |  2 +-
>  rust/kernel/sync/arc.rs        |  3 +-
>  6 files changed, 72 insertions(+), 9 deletions(-)
>  create mode 100644 rust/kernel/alloc/box_ext.rs
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index fd5541991a22..9bc1b48b5641 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -5,6 +5,7 @@
>  #[cfg(not(test))]
>  #[cfg(not(testlib))]
>  mod allocator;
> +pub mod box_ext;
>  pub mod vec_ext;
>  
>  /// Flags to be used when allocating memory.
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> index 8cc7099d6ae1..ff88bce04fd4 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -16,7 +16,7 @@
>  ///
>  /// - `ptr` can be either null or a pointer which has been allocated by this allocator.
>  /// - `new_layout` must have a non-zero size.
> -unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
> +pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
>      // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
>      let layout = new_layout.pad_to_align();
>  
> diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
> new file mode 100644
> index 000000000000..c62db0aa4dd1
> --- /dev/null
> +++ b/rust/kernel/alloc/box_ext.rs
> @@ -0,0 +1,60 @@
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
> +    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
> +}
> +
> +impl<T> BoxExt<T> for Box<T> {
> +    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
> +        let mut b = <Self as BoxExt<_>>::new_uninit(flags)?;
> +        b.write(x);
> +        // SAFETY: The contents were just initialised in the line above.
> +        Ok(unsafe { b.assume_init() })

, since we have the new_uninit feature selected, we can actually do

	fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
	    <Self as BoxExt<_>>::new_uninit(flags).map(|b| Box::write(b, x))
	}

here.

Regards,
Boqun

> +    }
> +
[...]

