Return-Path: <linux-kernel+bounces-150652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8948AA252
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67229284BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DB617AD7E;
	Thu, 18 Apr 2024 18:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDVi0ibU"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B597917335B;
	Thu, 18 Apr 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466406; cv=none; b=h7CiSt/X/vqlbSSZIOdyjiqibORyYI3Ow6xJG7pyEeBrFTDNuvjYx9HdlOOFtm3iIlV/WtAwC/fDLy0M8MPQvNHeurpEWb6QZP1K2tEyqK8duoWuMR8dm2w9xmPYnPZYDzbK8ODXbmIOeEc8XxZk7f/WXPkwujTlhcy5mgWLa6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466406; c=relaxed/simple;
	bh=NErdMtdTcltTG+B8NDqZl8S8L5b+1hC0gXiSoSWJphI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg3JOFr8mRHnEFun+9eaj+zuRqKp2697F6WaOsqZALPaxtSnJNQRjwwxi+8DIA1mN57uU4dj3DG6yNuE4pC3IAtZb6pSlJeD06s7oSbSJ00aoMlSU2bnyaNOprwrv0T1ypwblUehtPBOg+ORlptpVjVAL9DYA0j1xBoRXBlP8I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDVi0ibU; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b137d09e3so7960746d6.1;
        Thu, 18 Apr 2024 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713466403; x=1714071203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r7Cqzwpa0N6ahjvlQwho0MrL0UhOcI3CGtbp3521uQ=;
        b=DDVi0ibUTpoixT6pxbPuB9zcUQp8Jy6yLnHBc8J4V854m+7WnEQg5bybQ3Lj9DHgDT
         63/UFKtSd/hjEOjYBOhNdtVH7GQsgWDxUeLdry0wDq0o5ctFZUmwfshCqZxk9nWfDf8v
         hhAaLB4iFN6VaIiBaM9CrwzCNLkhFCSCcL5R3OIEPQ9bnzOhm9FTj3pNFL29davtdiJF
         AiZlEyH/MDkaQgTYPCaYgIQJd+r/X4aQq4iOl2Wotz9J50LyfXHJ3SBS97hO9/czl5ZL
         6Q3YaSFkgClFfzeDyB4nDQqCzRb5wDtm7U7tL+g8IZBv2XlAz1pa1wwFXbSJO4x+JfJz
         JHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713466403; x=1714071203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9r7Cqzwpa0N6ahjvlQwho0MrL0UhOcI3CGtbp3521uQ=;
        b=Bk3XN9RC4saLbS/+YkfFsCtc7OqEc3XKXbLCeHqbn33M1UcWWJkCE+Lrk2Ay905YlI
         udAr3yyG5TWAA6zzUixcrrlUpdeOUYqsjMZZlxMF9OKtndx16W7HXbKKUbLExSq6SSlU
         FzvjTF0NOrhx5VAtjE4mpjwoNp69bs++KDtoLXmo4p40mnXdKlk3rOUydTE80zYM56nL
         DPyTigU92B+/gQHsBkQ7QykkoTX0DKZgtqMFe+nf58t9+au7uqClo7OettDuf7vi8HTg
         +mO4XRNLpWMaCKk3afRIwmVi1ff/ZOWDb+Hm3tWxmwo3fnlmLntG+W1g8jjgSJrph04E
         mU+g==
X-Forwarded-Encrypted: i=1; AJvYcCVg3BPGliM7Sk9w8V5F0ADH52OlEWxCa7nj0ZLpIK0Cu84iub0xA211jjNE55YAvM5tuld5Lw5NIx3uRjmSL+Fmt9T+CaL3dKByjeRbxVfOZmtVHu4Q3wMLezMY7jBkkMIQFNoz7JfdRfJZfNU=
X-Gm-Message-State: AOJu0YzC93nHSJJFkndazzpGRvC+/TmoTBR60nKamgVcEkbIm5swKUjy
	CCywBxJPku7UTKZvnEypj73cRboEnP/rLe8muzSFUNJKHLMvG72G
X-Google-Smtp-Source: AGHT+IGYj8Z9DdNusXwRbFDJgf6QW2DcyYlg/XNuCin6S3U7WarnpdkqqVX9H+XSmkhJvov6jUOCIA==
X-Received: by 2002:a0c:c252:0:b0:69b:1e3b:61d8 with SMTP id w18-20020a0cc252000000b0069b1e3b61d8mr3630668qvh.29.1713466403444;
        Thu, 18 Apr 2024 11:53:23 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id g11-20020a0caacb000000b006994062299dsm886050qvb.33.2024.04.18.11.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:53:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id DC63D1200032;
	Thu, 18 Apr 2024 14:53:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 18 Apr 2024 14:53:21 -0400
X-ME-Sender: <xms:IWwhZpAlkd8M4B55j5SLy8hO71yigh1lbfnJbE3xFfBBVT8hGDjOmg>
    <xme:IWwhZnh6QmEVCGYPvxysUF9jSq5LdI_OcMED9jut6ySM5GhB0DL4hpkssbkVnf-J9
    Q28S0liH1AId6JmlQ>
X-ME-Received: <xmr:IWwhZklNVhHXyjyv_U3HOh4xA-NL26snAoJbiTvFV1nc-cdEH7roV8uFEJ-Jug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudektddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:IWwhZjzqXb0hAKxR8W28ZtpfTJyLOMucSPtxL1mynN5RSfSFLCwAsA>
    <xmx:IWwhZuRnAjVe6y1VkbSYyQ-ZYszZWK7Rfxce4bm4WgThEXF7Xaptgg>
    <xmx:IWwhZmawc7rr28an9vUnC2Ax4S1isr1rfagk8GjM4XDdv7WHYCEzLA>
    <xmx:IWwhZvRQY9gkdKoOulybi4fP0MVSeT2qs-QccQnSr42_VPqRhOvXAw>
    <xmx:IWwhZsB8pZ6HxZhyR4VlL30sVFvh9-NpJUzjK8Vcn_Cgf06CFbkSIdec>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 14:53:21 -0400 (EDT)
Date: Thu, 18 Apr 2024 11:52:56 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 4/4] rust: add abstraction for `struct page`
Message-ID: <ZiFsCLb-BZWbBHsu@boqun-archlinux>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-4-cb8f3e5d688f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-alice-mm-v6-4-cb8f3e5d688f@google.com>

On Thu, Apr 18, 2024 at 08:59:20AM +0000, Alice Ryhl wrote:
> Adds a new struct called `Page` that wraps a pointer to `struct page`.
> This struct is assumed to hold ownership over the page, so that Rust
> code can allocate and manage pages directly.
> 
> The page type has various methods for reading and writing into the page.
> These methods will temporarily map the page to allow the operation. All
> of these methods use a helper that takes an offset and length, performs
> bounds checks, and returns a pointer to the given offset in the page.
> 
> This patch only adds support for pages of order zero, as that is all
> Rust Binder needs. However, it is written to make it easy to add support
> for higher-order pages in the future. To do that, you would add a const
> generic parameter to `Page` that specifies the order. Most of the
> methods do not need to be adjusted, as the logic for dealing with
> mapping multiple pages at once can be isolated to just the
> `with_pointer_into_page` method.
> 

Thank you for doing this, and breaking the chicken-and-egg problem chain
;-) For sure, the whole package of page API would need more time to
design, implement and review, but this patch looks good enough to me.

> Rust Binder needs to manage pages directly as that is how transactions
> are delivered: Each process has an mmap'd region for incoming
> transactions. When an incoming transaction arrives, the Binder driver
> will choose a region in the mmap, allocate and map the relevant pages
> manually, and copy the incoming transaction directly into the page. This
> architecture allows the driver to copy transactions directly from the
> address space of one process to another, without an intermediate copy
> to a kernel buffer.
> 
> This code is based on Wedson's page abstractions from the old rust
> branch, but it has been modified by Alice by removing the incomplete
> support for higher-order pages, by introducing the `with_*` helpers
> to consolidate the bounds checking logic into a single place, and
> various other changes.
> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Something I want to bring up for discussion below:

[...]

> +    /// Runs a piece of code with a raw pointer to a slice of this page, with bounds checking.
> +    ///
> +    /// If `f` is called, then it will be called with a pointer that points at `off` bytes into the
> +    /// page, and the pointer will be valid for at least `len` bytes. The pointer is only valid on
> +    /// this task, as this method uses a local mapping.
> +    ///
> +    /// If `off` and `len` refers to a region outside of this page, then this method returns
> +    /// `EINVAL` and does not call `f`.
> +    ///
> +    /// # Using the raw pointer
> +    ///
> +    /// It is up to the caller to use the provided raw pointer correctly. The pointer is valid for
> +    /// `len` bytes and for the duration in which the closure is called. The pointer might only be
> +    /// mapped on the current thread, and when that is the case, dereferencing it on other threads
> +    /// is UB. Other than that, the usual rules for dereferencing a raw pointer apply: don't cause
> +    /// data races, the memory may be uninitialized, and so on.
> +    ///
> +    /// If multiple threads map the same page at the same time, then they may reference with
> +    /// different addresses. However, even if the addresses are different, the underlying memory is
> +    /// still the same for these purposes (e.g., it's still a data race if they both write to the
> +    /// same underlying byte at the same time).
> +    fn with_pointer_into_page<T>(
> +        &self,
> +        off: usize,
> +        len: usize,
> +        f: impl FnOnce(*mut u8) -> Result<T>,

I wonder whether the way to go here is making this function signature:

    fn with_slice_in_page<T> (
        &self,
	off: usize,
	len: usize,
	f: iml FnOnce(&UnsafeCell<[u8]>) -> Result<T>
    ) -> Result<T>

, because in this way, it makes a bit more clear that what memory that
`f` can access, in other words, the users are less likely to use the
pointer in a wrong way.

But that depends on whether `&UnsafeCell<[u8]>` is the correct
abstraction and the ecosystem around it: for example, I feel like these
two functions:

	fn len(slice: &UnsafeCell<[u8]>) -> usize
	fn as_ptr(slice: &UnsafeCell<[u8]>) -> *mut u8

should be trivially safe, but I might be wrong. Again this is just for
future discussion.

Regards,
Boqun

> +    ) -> Result<T> {
> +        let bounds_ok = off <= PAGE_SIZE && len <= PAGE_SIZE && (off + len) <= PAGE_SIZE;
> +
> +        if bounds_ok {
> +            self.with_page_mapped(move |page_addr| {
> +                // SAFETY: The `off` integer is at most `PAGE_SIZE`, so this pointer offset will
> +                // result in a pointer that is in bounds or one off the end of the page.
> +                f(unsafe { page_addr.add(off) })
> +            })
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
> +
[...]
> 
> -- 
> 2.44.0.683.g7961c838ac-goog
> 

