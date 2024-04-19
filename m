Return-Path: <linux-kernel+bounces-151820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E7B8AB452
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DF328766C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3933412E1ED;
	Fri, 19 Apr 2024 17:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKoHsi9P"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044C1E502;
	Fri, 19 Apr 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713547456; cv=none; b=lVTQ9XqX3kTWfGY66RJhV+O4GJBleZbtWUYi7zVY5UwtVVznbLvZBKwu9g+6s9s8vYFcw0LqQhFiZDEDnp0ID1+xCqniFU4id551sBZrhiTj2ydt5fAVT8Bw84e4oFon20LI1RV3zknXuogxmScijU2DzoZNEYjGDo51oj3P2aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713547456; c=relaxed/simple;
	bh=b9RUGImUcmHqC8YZ/B0r0QzIgbx1tblindrwTIEdNuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6pbPJQuSFXlg++m1TvCpLpsws5fRgjEFUEnzjN8T/DbAkKk/t+/Kp9ylufPsYnIwBcYP7Yg4/2Z9M/YeZx7M9tVUeEwlNgNmEBkO4mqEKpTDMUyBPQaibIvjVyPpe3CzRcBON2R8qm0Z/9BwhX48m2+QKv76Ow4CCpbJzB4rKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKoHsi9P; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c61486d3fcso1324976b6e.2;
        Fri, 19 Apr 2024 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713547454; x=1714152254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl1RUdIK+yEUkdLv0005F+A+5B6IMLIV9UGoxVMvVCU=;
        b=gKoHsi9PGwK+qCP/TJU09hOxGFZ1LeSIOu+4V7aBAAqjejuBEaPdozxCBOVBqadkE3
         8guiKA+MUbGQ5huEJwacEuoH6lvQVfFc0ReDm5f6fnjxXos3iJvcBVJlZm1w5g+fdvpZ
         pjVOoUCXuWLNYdqCDYvt+sCwnWI8caMvnb0rxro59Nf9E/DpmlTaMRHb+6j6gy9Ypj96
         Lkot8Ufdm5V3Fuk3t3/TUCFZpOxds+e3QyJ/+lZHStOGkKnulCVX3/3TWE/z9JtX8R0R
         qPI/Pw6cOqPqu4I8KdDVWvuX5X6mZAxKTCbkA+YgRpurrQZXJt2+39jl2rXNXPS+GQM+
         a5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713547454; x=1714152254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wl1RUdIK+yEUkdLv0005F+A+5B6IMLIV9UGoxVMvVCU=;
        b=WZ/0USaO53OBA+471aiT++BRKim/nUboZTUU7wj/tuaDC4n1nv72yRFkkQvAlEztSH
         RaSdvDwQ/fU/2x54mdMeMuBz8BMnfIxB9EwFyg1tCqsOqgwLCNtfNEUtURWcN2lQUYaM
         VQmmviG8b/jT+UlIk6CuOwCJSFXLXskZa+MaXA2bD3KhopLcIM9xZhugjQ82GnfXt+MJ
         Y0pw68xPEesKb8oq1zVOUk5o8NeE9+Zq/HzZnISwCF7DpfMJKvgoK8c6OOzvXlMtoVg5
         KGTVDRJ+gbwJU6LL5y1PXfcHa1ssNgfXtUq9g76A9MtAcbGsbugNfjR1uE3spyYqc3JN
         sUGg==
X-Forwarded-Encrypted: i=1; AJvYcCVWLoWlTB/pWCHuqCuNYOEGfMPXCut1vOzXUWM2ycoEeNXGuIAZTQ56rVADdjTBL1oQ9Qp2MCavDKxU8TJHyLb5UzmtIC+HF0a+Q9puDsjR/Myh8K46Hp0p8J0NCCt0YrFsim9PYuzash9ISOw=
X-Gm-Message-State: AOJu0Yz/lI5Mkgj8Davskw9gvjtaq3UuAy49NiMI2xQN4vamFopQ7ErH
	vRnpwfuaEdM5tfyoxev6kitsg9BA6vhBLNLp/uSj07+z+4JOOXRY
X-Google-Smtp-Source: AGHT+IEkTetvSYPIdmojYakGwp8F2J3lrbHRow5batA+rBhiFfPZCEjfol7f2JHkMK9xqf/GOmAn8w==
X-Received: by 2002:a05:6808:10d2:b0:3c7:47e5:d10c with SMTP id s18-20020a05680810d200b003c747e5d10cmr3534845ois.8.1713547453693;
        Fri, 19 Apr 2024 10:24:13 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id x16-20020ac87a90000000b0043686104e87sm1761576qtr.9.2024.04.19.10.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 10:24:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 46F631200043;
	Fri, 19 Apr 2024 13:24:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 19 Apr 2024 13:24:12 -0400
X-ME-Sender: <xms:vKgiZh2-E7x5NZ7rK_Y9wjmNkvVZlIfsJkXxZKntW-ERCxJHuKUrjw>
    <xme:vKgiZoEc6IFv50yGbksefoYwpKjpZlqHUNH_mfa5q1AMoluExOqx6NRHxKgBYmHNE
    hA0u50YIbkpzlRNTg>
X-ME-Received: <xmr:vKgiZh5hvPWDYuE2Mspy6Qj9rXGkrfzWEmnRI6esXY9grYPx3D5D6ThUCY_RwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdt
    keeihedvnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsg
    hoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:vKgiZu25AbE_FXtYC0KZD2s2l6vqUzrqM0Bf_zW9yhOyUGroO1ZEpQ>
    <xmx:vKgiZkHchhPJtAwAadf3N6hsQxxtskGBZ5YYaT8tfL0WwJXIld9b8w>
    <xmx:vKgiZv_JIGUjFuBh5N8KKlMXLviDnunNfviUJvan43YiF1cT_PfnKA>
    <xmx:vKgiZhmtIlA8iYwXwDeifUO37FhEjyG1Gr4W9bPiRlm2JIcZkSu6LQ>
    <xmx:vKgiZoH2BJDeyOn0GQi8w3w6DyZ-fy8s7OwFLGdZLvJ_WVb6ufKBAsxW>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 13:24:11 -0400 (EDT)
Date: Fri, 19 Apr 2024 10:23:44 -0700
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
Message-ID: <ZiKooOjXh209i8je@boqun-archlinux>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
 <20240418-alice-mm-v6-4-cb8f3e5d688f@google.com>
 <ZiFsCLb-BZWbBHsu@boqun-archlinux>
 <87dc4cdf-ccf6-4b08-8915-313aad313f93@proton.me>
 <ZiGlC5AtRRikE1AI@boqun-archlinux>
 <ZiGnFI7cz5v-cowt@boqun-archlinux>
 <079c88af-2e6d-45fe-bf58-afebbf7583b4@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <079c88af-2e6d-45fe-bf58-afebbf7583b4@proton.me>

On Fri, Apr 19, 2024 at 08:36:11AM +0000, Benno Lossin wrote:
> On 19.04.24 01:04, Boqun Feng wrote:
> > On Thu, Apr 18, 2024 at 03:56:11PM -0700, Boqun Feng wrote:
> >> On Thu, Apr 18, 2024 at 10:08:40PM +0000, Benno Lossin wrote:
> >>> On 18.04.24 20:52, Boqun Feng wrote:
> >>>> On Thu, Apr 18, 2024 at 08:59:20AM +0000, Alice Ryhl wrote:
> >>>>> +    /// Runs a piece of code with a raw pointer to a slice of this page, with bounds checking.
> >>>>> +    ///
> >>>>> +    /// If `f` is called, then it will be called with a pointer that points at `off` bytes into the
> >>>>> +    /// page, and the pointer will be valid for at least `len` bytes. The pointer is only valid on
> >>>>> +    /// this task, as this method uses a local mapping.
> >>>>> +    ///
> >>>>> +    /// If `off` and `len` refers to a region outside of this page, then this method returns
> >>>>> +    /// `EINVAL` and does not call `f`.
> >>>>> +    ///
> >>>>> +    /// # Using the raw pointer
> >>>>> +    ///
> >>>>> +    /// It is up to the caller to use the provided raw pointer correctly. The pointer is valid for
> >>>>> +    /// `len` bytes and for the duration in which the closure is called. The pointer might only be
> >>>>> +    /// mapped on the current thread, and when that is the case, dereferencing it on other threads
> >>>>> +    /// is UB. Other than that, the usual rules for dereferencing a raw pointer apply: don't cause
> >>>>> +    /// data races, the memory may be uninitialized, and so on.
> >>>>> +    ///
> >>>>> +    /// If multiple threads map the same page at the same time, then they may reference with
> >>>>> +    /// different addresses. However, even if the addresses are different, the underlying memory is
> >>>>> +    /// still the same for these purposes (e.g., it's still a data race if they both write to the
> >>>>> +    /// same underlying byte at the same time).
> >>>>> +    fn with_pointer_into_page<T>(
> >>>>> +        &self,
> >>>>> +        off: usize,
> >>>>> +        len: usize,
> >>>>> +        f: impl FnOnce(*mut u8) -> Result<T>,
> >>>>
> >>>> I wonder whether the way to go here is making this function signature:
> >>>>
> >>>>       fn with_slice_in_page<T> (
> >>>>           &self,
> >>>> 	       off: usize,
> >>>> 	       len: usize,
> >>>> 	       f: iml FnOnce(&UnsafeCell<[u8]>) -> Result<T>
> >>>>       ) -> Result<T>
> >>>>
> >>>> , because in this way, it makes a bit more clear that what memory that
> >>>> `f` can access, in other words, the users are less likely to use the
> >>>> pointer in a wrong way.
> >>>>
> >>>> But that depends on whether `&UnsafeCell<[u8]>` is the correct
> >>>> abstraction and the ecosystem around it: for example, I feel like these
> >>>> two functions:
> >>>>
> >>>> 	    fn len(slice: &UnsafeCell<[u8]>) -> usize
> >>>> 	    fn as_ptr(slice: &UnsafeCell<[u8]>) -> *mut u8
> >>>>
> >>>> should be trivially safe, but I might be wrong. Again this is just for
> >>>> future discussion.
> >>>
> >>> I think the "better" type would be `&[UnsafeCell<u8>]`. Since there you
> >>> can always access the length.
> >>>
> >>
> >> Hmm.. here is the thing, having `&UnsafeCell<[u8]>` means having a `*mut
> >> [u8]>`, and it should always be safe to get a "length" of `*mut [u8]`,
> >> right? I haven't found any method doing that, but the length should be
> >> just a part of fat pointer, so I think getting that is a defined
> >> behavior. But maybe I'm missing something.
> 
> There is `to_raw_parts` [1], but that is unstable. (Note that
> `<[T] as Pointee>::Metadata = usize`, see [2])
> 

Oh, that's good to know, thank you! ;-)

> >>
> > 
> > Hmm... but I guess one of the problems of this approach, is how to
> > construct a `&UnsafeCell<[u8]>` from a pointer and length...
> 
> We could use `from_raw_parts` [3]. But when making the slice the outer
> type, we can use a stable function to convert a pointer and a length to
> a slice [4].
> 

Yes, but there appears no way to get a pointer with larger provenance
from a `&[UnsafeCell<u8>]`, right?

> > 
> > Regards,
> > Boqun
> > 
> >>> Another question would be if page allows for uninitialized bits, in that
> >>> case, we would need `&[Opaque<u8>]`.
> >>>
> >>
> >> Yes, or `&Opaque<[u8>]`.
> 
> I don't think that putting the slice on the inside is what we want. Also

Hmm.. why? So in `&UnsafeCell<[u8]>` vs `&[UnsafeCell<u8>]` case, I
think the former represent "a slice of u8 that can be modified in the
same time" very well, and this is what a pointer-and-length pair usually
represents in kernel, I think. But yes, the latter is OK to me as well,
just hard to play the provenance game I guess?

> note that `Opaque<T>` requires that `T: Sized` and that is not the case
> for `[u8]`.

Oh, you're right. In case of MaybeUninit, it requires `T: Sized`, so
`Opaque<[u8]>` doesn't quite work.

Moving forward, maybe the first step is to see whether `&[Opaque<u8>]`
and `&[UnsafeCell<u8>]` can have a good way to generate a pointer with
proper provenance? Time to ping t-opsem maybe?

Regards,
Boqun

> 
> [1]: https://doc.rust-lang.org/nightly/core/primitive.pointer.html#method.to_raw_parts
> [2]: https://doc.rust-lang.org/nightly/core/ptr/trait.Pointee.html#pointer-metadata
> [3]: https://doc.rust-lang.org/nightly/core/ptr/fn.from_raw_parts.html
> [4]: https://doc.rust-lang.org/nightly/core/slice/fn.from_raw_parts.html
> 
> -- 
> Cheers,
> Benno
> 

