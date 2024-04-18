Return-Path: <linux-kernel+bounces-150850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA6C8AA59D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CBD285153
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681DB74297;
	Thu, 18 Apr 2024 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxHye5wx"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE24A20;
	Thu, 18 Apr 2024 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713481523; cv=none; b=hOGYPfGi5ISsB4MqnYKZibnf7NWcec4vlU2mrrm0lJCFf2nuDUBlR7ZU73swrbZGtELsMwtic6USVuhW/4ar0t49AsHhBpXKvHJC0uayekSVsxwqYV4yXc9r1ZmhKJRPuZXiTN3J64F++2wajGw+DbGkfS/kL0GDuKPN/uFJXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713481523; c=relaxed/simple;
	bh=07lL1pZy+3UR/j8DyO1ktTFtaIZFvXnwC4CCopusKdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4PFObGgMKyj6XcI5p7oXRusF2R90OQHXUE/RqBaS7k8cLRkUFWoPzHGLLHxl3j3C2kMh1TOG5SdWnf0sR4Uv0JidHZN0TI6PXEUq5JF12lQnpPf91ToMVpRcGksztNeXzahj1K2QbMbHnoDlf9wqdWPjyijTtHzFRph9AqHc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxHye5wx; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa1b7a37b5so917568eaf.2;
        Thu, 18 Apr 2024 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713481521; x=1714086321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvHGL8IFMHbrcf+pVPbylnOJOYY5+Yhex1+9u/nVOnc=;
        b=gxHye5wxYTYP9I+TAe3rX79xp6HpjzFX5CqDcqqSXKEV+acz6h1ezgVu6B40HAFTdz
         VesZFQtZOyc5dtOfJ9Eywnlrx31t97TAC8xNzpVULA8xhnBKR7glIOJ7OGTGiDJSU4wM
         ChQpDvxSIj5RB3kbwql+lJKfFEXNQPZ64w7u+zGOYnJp1QC26XVGd6xqKBG5QzgzmhQH
         ou6qLJ/F3ok/D2F5563IIb9L+GNJxq3vZmCYF1xE22J4BKKbIpUp1NWct/qkpZETCd4A
         R401H+pPaFWEATuxW+KOPdAXS4WVdNhsf4vaLVV03e/KrIicKRl5DxJSJR4IMVA+M7DY
         o31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713481521; x=1714086321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvHGL8IFMHbrcf+pVPbylnOJOYY5+Yhex1+9u/nVOnc=;
        b=Am7aHOV+dcCXv5947xfRtDaFAab/cMGUgO8notlDyLpq5vADnKSSrx9AiXt6+A0Q1W
         x+wbWm5964WTioLjGhuiyj6MSeQJ4jUtXuvp01DutT0MsBzeRlTsGZy/oqAil84eSikI
         mZGzDG8nhPYDErDD+u98eS67bvtwoiQgcl6Mp1lcV6Vd8p5VT30wEsh1FxADvlH48xeb
         RKmSSoINHlrFWRvDV++s0c5F9PonV3J0Jgwb06NUJ2LczLoIq6hTEv4WBc8cMN7xD0v+
         3qAk2s4OiCTMRqeR6Z8e7wZJ5AW+QNKdKBP8IjiSV6aODp8qKyjGRWvlJ2QnAIGgrY9x
         0/9A==
X-Forwarded-Encrypted: i=1; AJvYcCWPOWW47LmUJQcusnmVJ5j1HKWKoB9q/56vEOzg2+BsbmugzllPFVGT1UFm9XejCEaWd94IW/AtBPYIrDaCFigITGdImCZbX4KI6aoC5tAcQQblwQojO+OziFyFc3I5IChLJx8FhLtYDZG42h8=
X-Gm-Message-State: AOJu0YwNpze4s9q6f5d1BPb0flSYP9cuyIg6HAwVMqUKpGauZKfqVyRT
	O31krToHd6Zw1z+ZVHxzvXLSMkPNIhlAppOXbMn2gL/2ZcI7orhD
X-Google-Smtp-Source: AGHT+IGaGcAg7aUZYx8CG4VqIhha4Z9dYkC687PU2DC81EdXMDCwsAe7gdVQn3Y0qr2SHcuZQcwS8g==
X-Received: by 2002:a05:6358:6a4f:b0:183:7f41:8c10 with SMTP id c15-20020a0563586a4f00b001837f418c10mr609589rwh.31.1713481521098;
        Thu, 18 Apr 2024 16:05:21 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id l4-20020a0cac04000000b00698fa74199fsm1068529qvb.1.2024.04.18.16.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 16:05:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 587AF1200032;
	Thu, 18 Apr 2024 19:05:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 18 Apr 2024 19:05:18 -0400
X-ME-Sender: <xms:LqchZrfwI7qkzKibg4Wj5snZQvVbe-V0bmfWqoe6cDbwzKG5yqlunQ>
    <xme:LqchZhMEPG7Rfm-xSCzlbktQdjXENVe9aE63hJcvFMplZXISBfp1cYP8XW-NnnnsV
    jpih90Khc_d1J6rWg>
X-ME-Received: <xmr:LqchZkgmGw7L9OqyAdRHzME5lBVKQsOfufYwhdDxqVvdNFoa3IXehXZtMBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekuddgudelucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:LqchZs9oN2Xmn71xtI0eDyHrL4lX5EKH7i4kVOo7VHDBb4DoBKF8-g>
    <xmx:LqchZnte2T0o4iFMi2dFClNxxtsmyiDUMQKQB1BtOiuSbB0THjfKdQ>
    <xmx:LqchZrFYuuR_ohh6Mgg3DF0GjeeClXTK9lqJPkKZYKoShkliCYtJsA>
    <xmx:LqchZuNa0II5dLEtjUQftOC9FBGyAzZALIkuqcu8vFFW5Q7nusLk8w>
    <xmx:LqchZoNxU5DtBadNpfnMzvLSotM6F1GqhjwuBIr4MhgrtZDC0GSQl3cJ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 19:05:17 -0400 (EDT)
Date: Thu, 18 Apr 2024 16:04:52 -0700
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
Message-ID: <ZiGnFI7cz5v-cowt@boqun-archlinux>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-4-cb8f3e5d688f@google.com>
 <ZiFsCLb-BZWbBHsu@boqun-archlinux>
 <87dc4cdf-ccf6-4b08-8915-313aad313f93@proton.me>
 <ZiGlC5AtRRikE1AI@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiGlC5AtRRikE1AI@boqun-archlinux>

On Thu, Apr 18, 2024 at 03:56:11PM -0700, Boqun Feng wrote:
> On Thu, Apr 18, 2024 at 10:08:40PM +0000, Benno Lossin wrote:
> > On 18.04.24 20:52, Boqun Feng wrote:
> > > On Thu, Apr 18, 2024 at 08:59:20AM +0000, Alice Ryhl wrote:
> > >> +    /// Runs a piece of code with a raw pointer to a slice of this page, with bounds checking.
> > >> +    ///
> > >> +    /// If `f` is called, then it will be called with a pointer that points at `off` bytes into the
> > >> +    /// page, and the pointer will be valid for at least `len` bytes. The pointer is only valid on
> > >> +    /// this task, as this method uses a local mapping.
> > >> +    ///
> > >> +    /// If `off` and `len` refers to a region outside of this page, then this method returns
> > >> +    /// `EINVAL` and does not call `f`.
> > >> +    ///
> > >> +    /// # Using the raw pointer
> > >> +    ///
> > >> +    /// It is up to the caller to use the provided raw pointer correctly. The pointer is valid for
> > >> +    /// `len` bytes and for the duration in which the closure is called. The pointer might only be
> > >> +    /// mapped on the current thread, and when that is the case, dereferencing it on other threads
> > >> +    /// is UB. Other than that, the usual rules for dereferencing a raw pointer apply: don't cause
> > >> +    /// data races, the memory may be uninitialized, and so on.
> > >> +    ///
> > >> +    /// If multiple threads map the same page at the same time, then they may reference with
> > >> +    /// different addresses. However, even if the addresses are different, the underlying memory is
> > >> +    /// still the same for these purposes (e.g., it's still a data race if they both write to the
> > >> +    /// same underlying byte at the same time).
> > >> +    fn with_pointer_into_page<T>(
> > >> +        &self,
> > >> +        off: usize,
> > >> +        len: usize,
> > >> +        f: impl FnOnce(*mut u8) -> Result<T>,
> > > 
> > > I wonder whether the way to go here is making this function signature:
> > > 
> > >      fn with_slice_in_page<T> (
> > >          &self,
> > > 	       off: usize,
> > > 	       len: usize,
> > > 	       f: iml FnOnce(&UnsafeCell<[u8]>) -> Result<T>
> > >      ) -> Result<T>
> > > 
> > > , because in this way, it makes a bit more clear that what memory that
> > > `f` can access, in other words, the users are less likely to use the
> > > pointer in a wrong way.
> > > 
> > > But that depends on whether `&UnsafeCell<[u8]>` is the correct
> > > abstraction and the ecosystem around it: for example, I feel like these
> > > two functions:
> > > 
> > > 	    fn len(slice: &UnsafeCell<[u8]>) -> usize
> > > 	    fn as_ptr(slice: &UnsafeCell<[u8]>) -> *mut u8
> > > 
> > > should be trivially safe, but I might be wrong. Again this is just for
> > > future discussion.
> > 
> > I think the "better" type would be `&[UnsafeCell<u8>]`. Since there you
> > can always access the length.
> > 
> 
> Hmm.. here is the thing, having `&UnsafeCell<[u8]>` means having a `*mut
> [u8]>`, and it should always be safe to get a "length" of `*mut [u8]`,
> right? I haven't found any method doing that, but the length should be
> just a part of fat pointer, so I think getting that is a defined
> behavior. But maybe I'm missing something.
> 

Hmm... but I guess one of the problems of this approach, is how to
construct a `&UnsafeCell<[u8]>` from a pointer and length...

Regards,
Boqun

> > Another question would be if page allows for uninitialized bits, in that
> > case, we would need `&[Opaque<u8>]`.
> > 
> 
> Yes, or `&Opaque<[u8>]`.
> 
> Regards,
> Boqun
> 
> > But I don't remember how to get a valid raw pointer from
> > `&[UnsafeCell<u8>]`.
> > 
> > -- 
> > Cheers,
> > Benno
> > 

