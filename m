Return-Path: <linux-kernel+bounces-150846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5188AA590
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EC81F215D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4024B4DA03;
	Thu, 18 Apr 2024 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3uofsCc"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F21286AF;
	Thu, 18 Apr 2024 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713481001; cv=none; b=Jmlv06fULTJAP5CutneboWWlmTjZnUcroS/vqp2paZB5A3J6FvczYxhWDbbdzDMm12kRZP307Qc/btsuZ1Gib574nnkFVglOfFiqGZwU3GD92o3Sy5MyeX2aohZYW1vNx7h9UACPGbG2oNHZCwEdRpR0ThjlHWXAXsvFe+U7zTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713481001; c=relaxed/simple;
	bh=bHJCGzkyI/xV99l7MF5GV4Nn6oNmJKgGAoB0mOAvELk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJAW3Qhg13GHUpq2RhQWsfkborWLXDQDnL7Wia+WQtGKuk96oyLDv2FclIKMsPRRR1j7nLnQj1wD9ODns99G0RDI6aRYDjdUMqAqiLbJq/ToZUSGkjAHVRMS7Zt8QxoBEyGAW/R2cs7LGLgkrq5G0pfmUfEEeegKIW2ciXTjP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3uofsCc; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b59c10720so8241256d6.3;
        Thu, 18 Apr 2024 15:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713480999; x=1714085799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1ppV7Fh/1Iy/7RRfewnFGGAltFLGrqr5zJ2zdSeDXI=;
        b=W3uofsCcgjq+jufEPDD8MSq/Nf0++MUBopztwTL6x0OLzInrVa8EbwaS989DO2RkL1
         2i73b01Kcy1He3nPAVtR5eufmG9/NJx4kNFbLq8Ih7vGbdK4f+bec163NHy16FzNG8gl
         Dj+kgz2TtTAxgIwzyZHANzRoZRF5EvrdQE35kV4yaP1R+Yl1YkL5isnjicVumZl2izNN
         1BGk0S+kDG0HSa21kRKdBfpk1MUss4cgwk5n14lmQGKlme0SxAG8cLOKD9UEuaOGu5mk
         tns9WxIQf9eiKtn1InLIneWIhHNfwHqhtnUsVQmubb7wEVwZmbIWnPTctqLvHusInM8a
         xBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713480999; x=1714085799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1ppV7Fh/1Iy/7RRfewnFGGAltFLGrqr5zJ2zdSeDXI=;
        b=Dc+Ohjr5S3CSpNDIkcyGic4IVdhS+asLGiKTagG6ORLjD0Kmd3keqIWgEM7jTpDav3
         bcMOvOeyZf7tUVzwrpenetdD8llZAFlA3Z2NFqshAXJkG/mCyKI0u4RW6GNBVNP14Whu
         t4+ppL6zIcVTrRir3Jd9S5g88jn9+B7zUK0MQqIuToIokAIV7ifGP4eecC1xpoDuoNgl
         qyCm/unurn0Dp8lhc/JKMjNM0FbL93eHjbMGWd5pbmwTDDti6Q6nnZJQyTdDgoHNtf3R
         zR/oul5fRpjZiMr4HhDLTuyrVqhAbq/cLRZAK9Fvg2jq6l8l4+gCuRrEXnx/6uza43LD
         UJoA==
X-Forwarded-Encrypted: i=1; AJvYcCWOb8vaWEBQGbMaS4wM1kAiLOZlHRkIEFPJz2vbQIj004zfu1UdrW1yse3lOCygAF21xl6P9Au1Psv55AyKbbMAvev5oVWeYEOTTZFozVemF+hBp1aOHEGaDe/Mvw583FpLBtBW9tF5/KxcG/E=
X-Gm-Message-State: AOJu0Yx578sQETIp1ZHcJ/vcIbOQGt8k+hx2hHCi72ChZ4efW4JJNztO
	UUjK4+J6yATTT9AzaVptbs8oJJGtfkMeNZBiARgVfid7gMr5+5vn
X-Google-Smtp-Source: AGHT+IHJM9HcyMUvnziIjo9BnAimxWSPyNQZw63kKsHcZeY+F0D8c+NSU9CBu/ztB4ikC/Hh0gEFkA==
X-Received: by 2002:a05:6214:a52:b0:699:1f58:398c with SMTP id ee18-20020a0562140a5200b006991f58398cmr447097qvb.5.1713480998697;
        Thu, 18 Apr 2024 15:56:38 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id a13-20020a0ce38d000000b0069b23dd33besm1042193qvl.126.2024.04.18.15.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 15:56:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 2BC041200032;
	Thu, 18 Apr 2024 18:56:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 18 Apr 2024 18:56:37 -0400
X-ME-Sender: <xms:JKUhZuGHX4MjYtDMwuL6XKCQaZEtK45sSciI8KLmBwpGlPdZwwULjQ>
    <xme:JKUhZvUcI23fxtqYlzD6yOr1goDzVkzeNYjBzltsMh0ul_agIdDrMbBM2bssWDSP9
    -ATpVNaNUIbb-I32Q>
X-ME-Received: <xmr:JKUhZoLKMyP3xSFQA5d8GfXaWC49rzQ3n9f5pTYbNfbLyzbfn6MoPZd9lEI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhprghmrfhhohhnvgdqohhuthculdehtddtmdenucfjughrpeffhffvvefukfhfgggt
    uggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrd
    hfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeu
    tddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedvnecuufhprghmrfhhohhnvg
    epudektdegvdegvddthedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:JaUhZoFxuTWwu6t4mxEXHAbPzLuUHNGv7TMmgnKUMhoVPALm_dITSQ>
    <xmx:JaUhZkX-HjnOIdthpG8GcJOfpEJuuAOO_OrnEYP8ShR4GHAfvdYexQ>
    <xmx:JaUhZrPdJulVkvVsMFLruG80lwYcGa4hsRVw8___4NNFq6sqH3PYJw>
    <xmx:JaUhZr3IXD5MPtAYgXXb3lvKARkjU6CM6UCQUCf7oXTW2VAd-gtpXA>
    <xmx:JaUhZlUTyOZeCGxrmuXr5iPZB1KyhXarHAIjB1RSvn3SFSmme0ftUmst>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 18:56:36 -0400 (EDT)
Date: Thu, 18 Apr 2024 15:56:11 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
Message-ID: <ZiGlC5AtRRikE1AI@boqun-archlinux>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-4-cb8f3e5d688f@google.com>
 <ZiFsCLb-BZWbBHsu@boqun-archlinux>
 <87dc4cdf-ccf6-4b08-8915-313aad313f93@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87dc4cdf-ccf6-4b08-8915-313aad313f93@proton.me>

On Thu, Apr 18, 2024 at 10:08:40PM +0000, Benno Lossin wrote:
> On 18.04.24 20:52, Boqun Feng wrote:
> > On Thu, Apr 18, 2024 at 08:59:20AM +0000, Alice Ryhl wrote:
> >> +    /// Runs a piece of code with a raw pointer to a slice of this page, with bounds checking.
> >> +    ///
> >> +    /// If `f` is called, then it will be called with a pointer that points at `off` bytes into the
> >> +    /// page, and the pointer will be valid for at least `len` bytes. The pointer is only valid on
> >> +    /// this task, as this method uses a local mapping.
> >> +    ///
> >> +    /// If `off` and `len` refers to a region outside of this page, then this method returns
> >> +    /// `EINVAL` and does not call `f`.
> >> +    ///
> >> +    /// # Using the raw pointer
> >> +    ///
> >> +    /// It is up to the caller to use the provided raw pointer correctly. The pointer is valid for
> >> +    /// `len` bytes and for the duration in which the closure is called. The pointer might only be
> >> +    /// mapped on the current thread, and when that is the case, dereferencing it on other threads
> >> +    /// is UB. Other than that, the usual rules for dereferencing a raw pointer apply: don't cause
> >> +    /// data races, the memory may be uninitialized, and so on.
> >> +    ///
> >> +    /// If multiple threads map the same page at the same time, then they may reference with
> >> +    /// different addresses. However, even if the addresses are different, the underlying memory is
> >> +    /// still the same for these purposes (e.g., it's still a data race if they both write to the
> >> +    /// same underlying byte at the same time).
> >> +    fn with_pointer_into_page<T>(
> >> +        &self,
> >> +        off: usize,
> >> +        len: usize,
> >> +        f: impl FnOnce(*mut u8) -> Result<T>,
> > 
> > I wonder whether the way to go here is making this function signature:
> > 
> >      fn with_slice_in_page<T> (
> >          &self,
> > 	       off: usize,
> > 	       len: usize,
> > 	       f: iml FnOnce(&UnsafeCell<[u8]>) -> Result<T>
> >      ) -> Result<T>
> > 
> > , because in this way, it makes a bit more clear that what memory that
> > `f` can access, in other words, the users are less likely to use the
> > pointer in a wrong way.
> > 
> > But that depends on whether `&UnsafeCell<[u8]>` is the correct
> > abstraction and the ecosystem around it: for example, I feel like these
> > two functions:
> > 
> > 	    fn len(slice: &UnsafeCell<[u8]>) -> usize
> > 	    fn as_ptr(slice: &UnsafeCell<[u8]>) -> *mut u8
> > 
> > should be trivially safe, but I might be wrong. Again this is just for
> > future discussion.
> 
> I think the "better" type would be `&[UnsafeCell<u8>]`. Since there you
> can always access the length.
> 

Hmm.. here is the thing, having `&UnsafeCell<[u8]>` means having a `*mut
[u8]>`, and it should always be safe to get a "length" of `*mut [u8]`,
right? I haven't found any method doing that, but the length should be
just a part of fat pointer, so I think getting that is a defined
behavior. But maybe I'm missing something.

> Another question would be if page allows for uninitialized bits, in that
> case, we would need `&[Opaque<u8>]`.
> 

Yes, or `&Opaque<[u8>]`.

Regards,
Boqun

> But I don't remember how to get a valid raw pointer from
> `&[UnsafeCell<u8>]`.
> 
> -- 
> Cheers,
> Benno
> 

