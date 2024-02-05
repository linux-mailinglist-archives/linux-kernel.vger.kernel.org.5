Return-Path: <linux-kernel+bounces-53097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B77C84A09F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDC41C21A49
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D844C6B;
	Mon,  5 Feb 2024 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5njpc12"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B9B44C60;
	Mon,  5 Feb 2024 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153909; cv=none; b=dfEfcg1pzC0dUETlOovXKBSDIDsi9vMLtVOiVDXR0veS04kq16xHNgY/dGOO/fs9wyBVCuqHIzOhMTiMEvJ0H9eURB9F+rusMIPu0No4iQFHbEuCB1gxVWx1FV3XYGtV6BlHtnPFrCMqm2UAzEBn2dM/br9FlOSKn6Jf3U6gSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153909; c=relaxed/simple;
	bh=d19VFgDS03vvtjMyufp38CqLNpLc+fMbtV3FQXMkhhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahYNnLflOEXgbGYPVe80xxqGvQcd5+8S/Dj919wKec2sVCLfkAsUtysf1OIteNVKL71ozWUd0N81OVy7GrcuzxwP3f5yujDhG267yC/8//AopTb3Wa/wST78n6jRVGIiBEEVfs976PUgdTxYamop1wSc3C1W93BTx4fs1siBI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5njpc12; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e12b917df2so2918475a34.1;
        Mon, 05 Feb 2024 09:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707153907; x=1707758707; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K+cat8wRiFE8ayUEL9AAC8rZ9xDFXFmCN5IZ9qalElU=;
        b=Y5njpc125ADGWk6778kSHCR7Iiiev2bpgP3hPOQ8NuAaaBqJYeoFxtL8qGh6rEv39o
         TUSgudoeRM4Xrbx39/2mzyIrzckXN+m23G6hThXhA/O1G8G6QrJK8oyyuq3TB7+cGI7Y
         i2mnwTKwjEejVhAAaSkBQGErruzbKgCuU6N8ycXBrAiPLVVKNz3GktHq5FGGbKJ9ii0L
         d1MRikkiy40vAV9TIk2DZ54uueIIgxtc0l6sKVPAbBIx8p+N16Z6OMROGa2RnYr34dp9
         DJdyvzjkKFnOEsBe5iOmDxihOnGWMvw94/UWOrwuEdsxcbDd/rVhTBKdplbDADQyqOG+
         iQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153907; x=1707758707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+cat8wRiFE8ayUEL9AAC8rZ9xDFXFmCN5IZ9qalElU=;
        b=n0yulka1CnHDWe/xbxPBKFrHngqX0zgFM7bVRLIbIYOf3Th4BMe7wKQMWGYKWKKqa9
         uRIL/MOdG1f4RAp5Ic9pIyPsYhTtGCd0zcdRYTmEX9ZMmkdktYwdakMXeMOzcVHVvwtN
         oUMBpiy9r+iqaUfeWDgZJbzr6Ju7ECu48u2IBwCvF++J4lJNraUJfBZNl/T4FqRs1ych
         +FBEMbKy0coiWF/6e8lMqC33ddNKxLgYgynTaxZ2pgGbb3SWUic4XvVw2OFjCHlAsR+C
         ERIraaoGycYXywXw2N5aaY136nyKpPrUTljLgPhE73eekWdofwjZRJXNhUTSJThcroTK
         1mBw==
X-Gm-Message-State: AOJu0YxSr3V/ViWrGSXbGwrK592GphedEV+x37bwZHc0/zesbQOxZTcd
	db7vjROcV0OK3MCFHcw5x9ARfc2sjfF6JmuqwB+IcGWXKqpnaqFL
X-Google-Smtp-Source: AGHT+IE2zf0CBtwqYDKHSINkdodmruF5zYLe0Iwxw1I5CLoZnpITPBXNBIEIi5EIs6pSc+YnsorQOA==
X-Received: by 2002:a05:6870:5692:b0:218:7643:26cf with SMTP id p18-20020a056870569200b00218764326cfmr397934oao.10.1707153906935;
        Mon, 05 Feb 2024 09:25:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVd1jCv1k+pmp2tP5dozwRgkWN3WSpCTmwZy8ZuZKKbPdDZGaiixHmFM8QfDNg1rmiefqgWfz4BFCBsd860M3PuUGMPZuZCRnzLZK0Lxq5YaSLZgIaCWUgciYZKI2W2G9yzbN19+wSwgnP/JYIdiqg3iHKGHOqJxja8v51QeOGU/9G7c3OwNsyxWCNpRNflOcqGCxSkJ+j77XDS7nqP+mGwclNRSkrdBAip300lOFg+04o69Aqy0ARALtyPMpzmh868LoL1AXfoEf5Mt6N/cEOJkIRVtgeANq/uEyjmJhGktrPqxHZvLLWd0gKFcLIpJKo8dn+W1CkIYxSrKmQpzx/KtZakZv8eq32RJlgZ46l8WugKBVG/BQTTh9vFCr8/bzvYllz4dLnk4W2H6uk0eNt2XGTrE3xMwduQbKrs/7hqazvE2f7UkcJ+g7igGxgRY6h5VylwtSQUDzZLkPInScxNk8dyawI81fCHpeZG9c9Mb4lYmWByhyRygmDf/5zTE/UtTr17BPwXLMeOeJG9VEvhV6J2Ge0rA28+5d8V/hHiMDiFAxSwp7yqmvaHuRpY4mkrenkuiHLllSKNgNotSh57+oMHUxVmkMC44D2lEl8o4gaVLOXOpnidKnZSM7+Pn4PSLVqvuoKLdUXJnBu39LcJ58e5epqfqTtyrL1H5cN5CTc2nzT6B7ZUoNKmvM5od0wEsF8ftbiEby98/1lUQdkC9LN9BZE+nOYg+GoU
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b16-20020ad45190000000b0068ca40389besm162134qvp.101.2024.02.05.09.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:25:06 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailauth.nyi.internal (Postfix) with ESMTP id 9FAA527C0082;
	Mon,  5 Feb 2024 12:25:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 05 Feb 2024 12:25:05 -0500
X-ME-Sender: <xms:8BnBZSg7_SDRZG8laUArOl7iVYuvomgKOtIpkUSupOyvW7EklRvjBQ>
    <xme:8BnBZTA8zg8Owk_LrXR4ljozXOg3PPHrfg0c9ul8f-O6MUIIrrOXLZidSpjS8YLlg
    CDcb7MTPybVceQ-7w>
X-ME-Received: <xmr:8BnBZaEYgxhQbDz6qyEDZWbw1UfBKKsyMHc3YXCqxEfEwlcurrdk-nosqZF4JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvuddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:8BnBZbSOQc8ZQc2OIynmbXefMCgjpsFczPyd0AASkvLmCEh0LjVNJQ>
    <xmx:8BnBZfw-UwdvlSelmWX3LiCHpJdEDF8zO4lhkT7WlwvbejpE1kmQzw>
    <xmx:8BnBZZ7VPgIaVPAVBZ-XFBJvZOauo_h0QsX0zjYm70zlqUfDOeHoWw>
    <xmx:8RnBZUjf77aJlmG-8auTd5hV8Fe7wn1LGEgggd_-kwo9qYBXVsFJkQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 12:25:04 -0500 (EST)
Date: Mon, 5 Feb 2024 09:23:46 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Trevor Gross <tmgross@umich.edu>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Kees Cook <keescook@chromium.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 3/3] rust: add abstraction for `struct page`
Message-ID: <ZcEZosrTCkLXeHh2@boqun-archlinux>
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-3-d1abcec83c44@google.com>
 <ZbMA1yiM6Bqv9Sqg@boqun-archlinux>
 <CAH5fLgiNphSebaG82XkQHGFPFp1Mf1egyaiX6MFzsU2X3-Ni8w@mail.gmail.com>
 <ZbP50nEIMqULfVuj@Boquns-Mac-mini.home>
 <CALNs47uy5rQ15wByzQA0_YzORM0nTFdi9-TvwyC4+ZTXVQBj4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALNs47uy5rQ15wByzQA0_YzORM0nTFdi9-TvwyC4+ZTXVQBj4g@mail.gmail.com>

On Thu, Feb 01, 2024 at 01:50:53AM -0500, Trevor Gross wrote:
> On Fri, Jan 26, 2024 at 1:28 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Fri, Jan 26, 2024 at 01:33:46PM +0100, Alice Ryhl wrote:
> > > On Fri, Jan 26, 2024 at 1:47 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Wed, Jan 24, 2024 at 11:20:23AM +0000, Alice Ryhl wrote:
> > > > > [...]
> > > > > +    /// Maps the page and writes into it from the given buffer.
> > > > > +    ///
> > > > > +    /// # Safety
> > > > > +    ///
> > > > > +    /// Callers must ensure that `src` is valid for reading `len` bytes.
> > > > > +    pub unsafe fn write(&self, src: *const u8, offset: usize, len: usize) -> Result {
> > > >
> > > > Use a slice like type as `src` maybe? Then the function can be safe:
> > > >
> > > >         pub fn write<S: AsRef<[u8]>>(&self, src: S, offset: usize) -> Result
> > > >
> > > > Besides, since `Page` impl `Sync`, shouldn't this `write` and the
> > > > `fill_zero` be a `&mut self` function? Or make them both `unsafe`
> > > > because of potential race and add some safety requirement?
> > >
> > > Ideally, we don't want data races with these methods to be UB. They
> >
> > I understand that, but in the current code, you can write:
> >
> >         CPU 0                   CPU 1
> >         =====                   =====
> >
> >         page.write(src1, 0, 8);
> >                                 page.write(src2, 0, 8);
> >
> > and it's a data race at kernel end. So my question is more how we can
> > prevent the UB ;-)
> 
> Hm. Would the following work?
> 
>     // Change existing functions to work with references, meaning they need an
>     // exclusive &mut self
>     pub fn with_page_mapped<T>(
>         &mut self,
>         f: impl FnOnce(&mut [u8; PAGE_SIZE]) -> T
>     ) -> T
> 
>     pub fn with_pointer_into_page<T>(
>         &mut self,
>         off: usize,
>         len: usize,
>         f: impl FnOnce(&mut [u8]) -> Result<T>,
>     ) -> Result<T>
> 
>     // writing methods now take &mut self
>     pub fn write(&mut self ...)
>     pub fn fill_zero(&mut self ...)
>     pub fn copy_into_page(&mut self ...)
> 
>     // Add two new functions that take &self, but return shared access
>     pub fn with_page_mapped_raw<T>(
>         &self,
>         f: impl FnOnce(&UnsafeCell<[u8; PAGE_SIZE]>) -> T
>     ) -> T
> 
>     pub fn with_pointer_into_page_raw<T>(
>         &self,
>         off: usize,
>         len: usize,
>         f: impl FnOnce(&[UnsafeCell<u8>]) -> Result<T>,
>     ) -> Result<T>
> 
> This would mean that anyone who can obey rust's mutability rules can
> use a page without any safety or race conditions to worry about, much
> better for usability.
> 
> But if you do need to allow the data to be shared and racy, such as
> the userspace example, the `_raw` methods allow for that and you can
> `.get()` a `*mut u8` from the UnsafeCell. This moves the interior
> mutability only to the mapped data rather than the Page itself, which
> I think is more accurate anyway.
> 

Looks good to me ;-) Thanks!

Regards,
Boqun

> Leveraging UnsafeCell would also make some things with UserSlicePtr
> more clear too.
> 
> - Trevor
> 
> > Regards,
> > Boqun
> >
> > > could be mapped into the address space of a userspace process.
> > >
> > > Alice
> >
> 

