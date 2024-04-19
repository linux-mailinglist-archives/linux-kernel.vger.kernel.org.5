Return-Path: <linux-kernel+bounces-151908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDF58AB5A1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07331C2190E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FCC13C91F;
	Fri, 19 Apr 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzrnqDBv"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77721C10;
	Fri, 19 Apr 2024 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713555350; cv=none; b=bV2t3aFl5oBfbes4a5XrVV9zf206A0UUSGq9wcHO3RtmtaxOm6+BqKpg/Ya62eq5DxS4U3H/n/nvfLAKdAwOlb9ScmYwzKevfI4d0vD6VNuvj/XnrbPcg11mirpcNvoKuzyeQOZk+pDFGiHAK6/NgNtZCAWjjjTYZJp+qlUN1gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713555350; c=relaxed/simple;
	bh=FWRrYM05Gl24NysJZA4lFfJmUGtilj/4tzDe1726Ysc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEmcLEDf/WPOV5rNb7bk224nCJwbLtxwL4LQHErcLkEATEAbnWSy5LH88sYmPzba8+3l+pRl3yTPpRrvYQRNLHRquPL/TUPDmy6GkT1LUZ4Fg4QvmS96UUCCwYZUIeruxj6JBFtXeZQ3SrmKdCq2MG1a2Kbw9QEBM8rmgJf5kiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzrnqDBv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78f049ddd7dso160331685a.1;
        Fri, 19 Apr 2024 12:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713555347; x=1714160147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhQJU3CrlVoAGP7ZGiJSNVNFVjdkVbIc18tFWpLQjSo=;
        b=XzrnqDBvmy46CuoX6QpPy5LgguhsrK+XDRH33tM/9FFhdIRh3HRQpJCdKJgkKo9Alz
         +G//6gSsmwo0WvROO4fTwXRoNNVyx+7mx7XlDaaKPztY2p2lhmxOjI5q8KgrY5i2mmOh
         RR7E99vdO272vm8+f9K5Wa8FGcm2N+8W5M2lkpSZSZm5U3VI0Co+XI+NBzRuql9qtSgW
         8dEI8rGj9G7s5bo+MSzg7xiEui36Zm4Q08FQ0VJ8mI1vMAkvZQWqcI4HRwVLnwgKKsj/
         5sfk2R/13aiypCkjVmtW5KWNHMfUg5ZyAs8j7d0iAx+cCpA2NNgFEEnWuXtQ8QF99n+h
         NrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713555347; x=1714160147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhQJU3CrlVoAGP7ZGiJSNVNFVjdkVbIc18tFWpLQjSo=;
        b=A0x4SR8ppL4z9ceeUx7+XhW2UFUuvagbunvbCkU0F0Zaa3siTOlCnSVZI8TMvMei/T
         f1cDkIMJCYzyuK9CZtRRI65/oFlWAk0ZRWcUENQZGg8T+cpq5MHFrKPTMwmMcGe7HYPM
         xOy4y2dsMXt+SjiwfUs3CEzPvXfVjUTsFlpKmM7AxlxjKCiUJHlNpo5KLgAjPgMhy7Js
         3UhufJ7zkDFimS8s9isXVTm2vJufLV6LOe+m78HAHHoZ2DfkNMLVcf1jOR9vA6YjM+5z
         lCEriSIJDqppdk+BvYqiqX4o2utsk7gOpbdWxmJH6iNvgf6kVsHG3+1G+MNM099Q+01A
         pKxg==
X-Forwarded-Encrypted: i=1; AJvYcCWMLQxwwnAg4Bf7MVzMjKSlSLll8bucVF08OuBeoICoOhi2pgFAfEE3ZgsdwQM3JLbXkeFgXgTWa89qMw4MLyYTiaE5N5ZtiutBCJmO+kDfKCVdWSm8l9Ow2GXOvmg3ghxrZDqdBm7s3Su02wA=
X-Gm-Message-State: AOJu0Yx3XHS/JEsQeKF6LYOls3uesRCnv1wU1+fHyoHE/YPs+j+XyyJ4
	2Vg//UZQO8rEApQLNA9IRavW8DIE33GGJLSpdkVaz5DDEdUadOtC
X-Google-Smtp-Source: AGHT+IGMzxbgo4MC6cWlaiaYeVDGJBl+nICEONZyC/N08VTx98tp07xM/2TX/V8ztom/HuGyYxampA==
X-Received: by 2002:a05:620a:d53:b0:78a:724b:af30 with SMTP id o19-20020a05620a0d5300b0078a724baf30mr3536555qkl.24.1713555347483;
        Fri, 19 Apr 2024 12:35:47 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a13e600b0078f044ff474sm1874956qkl.35.2024.04.19.12.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 12:35:46 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1CE041200032;
	Fri, 19 Apr 2024 15:35:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 19 Apr 2024 15:35:46 -0400
X-ME-Sender: <xms:kcciZjTWqxGCUxifFZ_8CJI18-1xfUzuIQDTib51K0AWSNij2ZdXrg>
    <xme:kcciZkwIg8CWPyhqvuRKXVvXZqSefFgPJNC4_sl_BOQsxkPJtvq5Ly4xB_OjKIBXr
    eyg2azN4vBFagl_eg>
X-ME-Received: <xmr:kcciZo0orzaXTjnkB0rLLUvkArpuy9kEsMlKboQi7i01UdqK4zcl85bCzBsvPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:kcciZjBe4pPetv2Z9f3bplpd7rLkyhJ9mvyOF3RqnNSUqa2gO8c1JQ>
    <xmx:kcciZsj-hAizIeILIJgz8dkf15DXKKjPmYBTyEZMfg2Eqr3mnzFNvg>
    <xmx:kcciZnrHzu7LsI8S9fJLnzr4iHaiWY--kEnhqDHpGZNkHGhuB4YI_Q>
    <xmx:kcciZngcWJh1KhnbqifomY1MGwJwkRq_eSXXitP_id3AebLuiV6vOw>
    <xmx:ksciZvS7aF6YwrdvWA2PryR-yCu5OHX9W1ES6BwWQkr6GzyuBifwiQm->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 15:35:45 -0400 (EDT)
Date: Fri, 19 Apr 2024 12:35:18 -0700
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
Message-ID: <ZiLHdiXzPS5wa6p-@boqun-archlinux>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-4-cb8f3e5d688f@google.com>
 <ZiFsCLb-BZWbBHsu@boqun-archlinux>
 <87dc4cdf-ccf6-4b08-8915-313aad313f93@proton.me>
 <ZiGlC5AtRRikE1AI@boqun-archlinux>
 <ZiGnFI7cz5v-cowt@boqun-archlinux>
 <079c88af-2e6d-45fe-bf58-afebbf7583b4@proton.me>
 <ZiKooOjXh209i8je@boqun-archlinux>
 <c500f9c6-8811-44c4-89a4-603a67d09e78@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c500f9c6-8811-44c4-89a4-603a67d09e78@proton.me>

On Fri, Apr 19, 2024 at 07:24:31PM +0000, Benno Lossin wrote:
> On 19.04.24 19:23, Boqun Feng wrote:
> > On Fri, Apr 19, 2024 at 08:36:11AM +0000, Benno Lossin wrote:
> >> On 19.04.24 01:04, Boqun Feng wrote:
> >>> On Thu, Apr 18, 2024 at 03:56:11PM -0700, Boqun Feng wrote:
> >>>> On Thu, Apr 18, 2024 at 10:08:40PM +0000, Benno Lossin wrote:
> >>>>> On 18.04.24 20:52, Boqun Feng wrote:
> >>>>>> On Thu, Apr 18, 2024 at 08:59:20AM +0000, Alice Ryhl wrote:
> >>>>>>> +    /// Runs a piece of code with a raw pointer to a slice of this page, with bounds checking.
> >>>>>>> +    ///
> >>>>>>> +    /// If `f` is called, then it will be called with a pointer that points at `off` bytes into the
> >>>>>>> +    /// page, and the pointer will be valid for at least `len` bytes. The pointer is only valid on
> >>>>>>> +    /// this task, as this method uses a local mapping.
> >>>>>>> +    ///
> >>>>>>> +    /// If `off` and `len` refers to a region outside of this page, then this method returns
> >>>>>>> +    /// `EINVAL` and does not call `f`.
> >>>>>>> +    ///
> >>>>>>> +    /// # Using the raw pointer
> >>>>>>> +    ///
> >>>>>>> +    /// It is up to the caller to use the provided raw pointer correctly. The pointer is valid for
> >>>>>>> +    /// `len` bytes and for the duration in which the closure is called. The pointer might only be
> >>>>>>> +    /// mapped on the current thread, and when that is the case, dereferencing it on other threads
> >>>>>>> +    /// is UB. Other than that, the usual rules for dereferencing a raw pointer apply: don't cause
> >>>>>>> +    /// data races, the memory may be uninitialized, and so on.
> >>>>>>> +    ///
> >>>>>>> +    /// If multiple threads map the same page at the same time, then they may reference with
> >>>>>>> +    /// different addresses. However, even if the addresses are different, the underlying memory is
> >>>>>>> +    /// still the same for these purposes (e.g., it's still a data race if they both write to the
> >>>>>>> +    /// same underlying byte at the same time).
> >>>>>>> +    fn with_pointer_into_page<T>(
> >>>>>>> +        &self,
> >>>>>>> +        off: usize,
> >>>>>>> +        len: usize,
> >>>>>>> +        f: impl FnOnce(*mut u8) -> Result<T>,
> >>>>>>
> >>>>>> I wonder whether the way to go here is making this function signature:
> >>>>>>
> >>>>>>        fn with_slice_in_page<T> (
> >>>>>>            &self,
> >>>>>> 	       off: usize,
> >>>>>> 	       len: usize,
> >>>>>> 	       f: iml FnOnce(&UnsafeCell<[u8]>) -> Result<T>
> >>>>>>        ) -> Result<T>
> >>>>>>
> >>>>>> , because in this way, it makes a bit more clear that what memory that
> >>>>>> `f` can access, in other words, the users are less likely to use the
> >>>>>> pointer in a wrong way.
> >>>>>>
> >>>>>> But that depends on whether `&UnsafeCell<[u8]>` is the correct
> >>>>>> abstraction and the ecosystem around it: for example, I feel like these
> >>>>>> two functions:
> >>>>>>
> >>>>>> 	    fn len(slice: &UnsafeCell<[u8]>) -> usize
> >>>>>> 	    fn as_ptr(slice: &UnsafeCell<[u8]>) -> *mut u8
> >>>>>>
> >>>>>> should be trivially safe, but I might be wrong. Again this is just for
> >>>>>> future discussion.
> >>>>>
> >>>>> I think the "better" type would be `&[UnsafeCell<u8>]`. Since there you
> >>>>> can always access the length.
> >>>>>
> >>>>
> >>>> Hmm.. here is the thing, having `&UnsafeCell<[u8]>` means having a `*mut
> >>>> [u8]>`, and it should always be safe to get a "length" of `*mut [u8]`,
> >>>> right? I haven't found any method doing that, but the length should be
> >>>> just a part of fat pointer, so I think getting that is a defined
> >>>> behavior. But maybe I'm missing something.
> >>
> >> There is `to_raw_parts` [1], but that is unstable. (Note that
> >> `<[T] as Pointee>::Metadata = usize`, see [2])
> >>
> > 
> > Oh, that's good to know, thank you! ;-)
> >
> >>> Hmm... but I guess one of the problems of this approach, is how to
> >>> construct a `&UnsafeCell<[u8]>` from a pointer and length...
> >>
> >> We could use `from_raw_parts` [3]. But when making the slice the outer
> >> type, we can use a stable function to convert a pointer and a length to
> >> a slice [4].
> >>
> > 
> > Yes, but there appears no way to get a pointer with larger provenance
> > from a `&[UnsafeCell<u8>]`, right?
> 
> What do you mean by "larger provenance"?
> 

Say you have a `&[UnsafeCell<u8>]` whose length is 64, what's the proper
way to get a `*mut u8` (or any other pointer) has the provenance for the
whole 64 bytes, so that you can pass it to a memcpy like function?
"larger" means the size of the provenance is larger than u8.

> >>>>> Another question would be if page allows for uninitialized bits, in that
> >>>>> case, we would need `&[Opaque<u8>]`.
> >>>>>
> >>>>
> >>>> Yes, or `&Opaque<[u8>]`.
> >>
> >> I don't think that putting the slice on the inside is what we want. Also
> > 
> > Hmm.. why? So in `&UnsafeCell<[u8]>` vs `&[UnsafeCell<u8>]` case, I
> > think the former represent "a slice of u8 that can be modified in the
> > same time" very well, and this is what a pointer-and-length pair usually
> > represents in kernel, I think. But yes, the latter is OK to me as well,
> > just hard to play the provenance game I guess?
> 
> Ultimately it again comes down to missing field projections :)
> 
> The type `&UnsafeCell<[u8]>` is less *useful*, since you cannot even get
> the length of the slice. Also indexing into this type is not easily
> possible. This is because the only way to get/change the inner value of
> an `UnsafeCell` is via `get`.
> 
> Compare this with the slice type. It allows getting the length, indexing
> into it (ie a form of field projections, if we consider slices as having
> a variable amount of fields).
> 
> All those issues would be solved by (good) field projections.
> 
> 
> Field projections also give a reason for why using `&[UnsafeCell<u8>]`
> is not really different from `&UnsafeCell<[u8]>`: At any point in time
> we ought to be able to project `&UnsafeCell<[u8]> -> &[UnsafeCell<u8>]`.
> 

Right, to me there is no significant difference between these two. Maybe
because I'm full field projected minded ;-)

> So it's fine to just use that from the get-go.
> 
> >> note that `Opaque<T>` requires that `T: Sized` and that is not the case
> >> for `[u8]`.
> > 
> > Oh, you're right. In case of MaybeUninit, it requires `T: Sized`, so
> > `Opaque<[u8]>` doesn't quite work.
> > 
> > Moving forward, maybe the first step is to see whether `&[Opaque<u8>]`
> > and `&[UnsafeCell<u8>]` can have a good way to generate a pointer with
> > proper provenance? Time to ping t-opsem maybe?
> 
> Good idea, do you want to do that, or should I do it?
> 

A way to get a larger provenance (explained above) is currently my only
question, so if you think that's something reasonable to ask, i.e.
nothing you know of can help. I will post a message there.

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 

