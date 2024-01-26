Return-Path: <linux-kernel+bounces-39468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A55483D1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56D528BD59
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7952C1115;
	Fri, 26 Jan 2024 00:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrDb0ydF"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E877362;
	Fri, 26 Jan 2024 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706230026; cv=none; b=F4vpM/t1XVvIcwJOI9N5PUCs+UVCvy54qBA3ed1iHbzrwJeC7B+Tus/mfM6qio2Q4XM4feM9/Hebt4imVXMdUWv+LQ6NaMqfbTBisbq1Rz5b8GdDrJdWxY5C8BD3sNOWGkj4039yrVe+5snynK41/hNbaXYLCHH+XTXFIbwkkvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706230026; c=relaxed/simple;
	bh=aZU67BcgtYdYWLFpivNFnPhz4A5DSRb9LWCNArdlDik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AifIpL+pKk83seIXxllOTP0dqHmf7RfZchYO213GV5A5h3Qp5p2Grw99fzKk4gn32Un7orkEManeERQ6sw3WEGzh23Yyb5x1GA9woCBNrrENOFgMFC1Q9wcM9E6vpX9RyXUyDbF81LsY8I+hyyLKUYBK8+XbPpLtlejVW9HRgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrDb0ydF; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-783cf58221fso1162385a.2;
        Thu, 25 Jan 2024 16:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706230024; x=1706834824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eb0k+mslh6p4v5lTPXQ4s3OPRdfCkOzWaYkI73LF69Y=;
        b=nrDb0ydFV9gB9/NgQQwP4cIfEYCQ+KIqvIxo//WYKGUiBihfsjyzGLbvySUDRyHVdN
         0sVt468TdvIadHHwAeEeRsP/43NO1fdUmG+ENvzWY29GfJDvbMYYUyIf4dnwm8hbhfd9
         nIp5sS1ThBU8UJRMTQomXbQ1tJzbSau1u4dW1YLT3ai4+LtnriTNDW7kE7xJyijmYOuK
         csOd7bNNiHBjX4PE68qVRaA3J8eSjs8Ch21VESboBV9IEdva/XOU7SdHCy/awONT0uNN
         VJjxx3Si80REQU2+WIgu2/8o8r/x8V07yKt42Z1bPDcJrPknkYbMH83obx9/3FZDemS8
         Y3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706230024; x=1706834824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eb0k+mslh6p4v5lTPXQ4s3OPRdfCkOzWaYkI73LF69Y=;
        b=dw2JqNWbj8JBHx+cmtJRXN/x34kAVxHnazMFCmqH4ydiIqz3eiT3TAezZWWvGqm1B2
         fdUz1+mbtSLBARtjE7ym5GtHb2TtCffg+Yj1rh1EdP68Y4t1LvTpxRzOXa8q9wczu9T6
         XYTiO+8350w4bNdqHZXGYO83AbKCB8cpnQ3YFZP4qsXME9DAjD/s40uLV6BD1TGb7WUA
         jwJjKQYe+vVfdty5lEXPCyI0b+dslXJ8ao4eoZs2t+DckIspQoTXyx/3aqnzOfnUsovZ
         f/NM47d0KSqIzUfPzhH8uHcUSbhAZ6/uDZXI4KC7AmdszZh1MbctE226QKaVnZV6b3Aj
         j1Lg==
X-Gm-Message-State: AOJu0YxKfyTpAMpvoJYCHgLM7h/MSNmG/oXjF/3oBhHgvByPAyPRTwDw
	nxoBvtEpBM8L7/OLDRT4sC/unmrbcXDQiHTEKuxX7Wht0fcIWGsN
X-Google-Smtp-Source: AGHT+IG2J8w56HlcU6RBuC4uKuoBV3MrlGDHdSu4bpeB7MKWZ25NaYZaPmZQNqTKIsr82eJm6uHyQw==
X-Received: by 2002:a37:ef15:0:b0:783:c869:8367 with SMTP id j21-20020a37ef15000000b00783c8698367mr562326qkk.139.1706230023816;
        Thu, 25 Jan 2024 16:47:03 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id m3-20020ae9e003000000b00781bdb17d8asm70244qkk.118.2024.01.25.16.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 16:47:03 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailauth.nyi.internal (Postfix) with ESMTP id ACDFC27C005B;
	Thu, 25 Jan 2024 19:47:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 25 Jan 2024 19:47:02 -0500
X-ME-Sender: <xms:BQGzZTpNLb-jIIK4H0LjfW4sX1bZQkxI474SgYxjCBAk3E-JP_3jcg>
    <xme:BQGzZdoZGt9NsZcvE_06KmSO3M3XbttZoz4WRIZm4wBUD3W1aMGVdQ36i4tZXsQ54
    QRVCOt9gSALG1ryBA>
X-ME-Received: <xmr:BQGzZQM2r0klbLGdkqN3KUiC8DR8s4-cFQYehtyOaczC-Yvc2TPFwf2tL7sb0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeliedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:BQGzZW4dyHNYH64caFYAOtBkiCVOtmlIdpr-KTlGqa_K9-z6RcZ7FQ>
    <xmx:BQGzZS4gUdgquBGt7HjiErutSJpi64dK0Obw2VEEFqdvsoDJlEA0_Q>
    <xmx:BQGzZeijwgxTu45JPPSy4v3YNAw_AEeEmgaMQ7kU6aHXd455ZDETRg>
    <xmx:BgGzZXqMg67gyNizQa_kuMmDORp5Cv1kTaX5LGlCPZ-wmQ6jQbL4TQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jan 2024 19:47:01 -0500 (EST)
Date: Thu, 25 Jan 2024 16:46:15 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
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
Message-ID: <ZbMA1yiM6Bqv9Sqg@boqun-archlinux>
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
 <20240124-alice-mm-v1-3-d1abcec83c44@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124-alice-mm-v1-3-d1abcec83c44@google.com>

On Wed, Jan 24, 2024 at 11:20:23AM +0000, Alice Ryhl wrote:
[...]
> +    /// Runs a piece of code with a raw pointer to a slice of this page, with
> +    /// bounds checking.
> +    ///
> +    /// If `f` is called, then it will be called with a pointer that points at
> +    /// `off` bytes into the page, and the pointer will be valid for at least
> +    /// `len` bytes. The pointer is only valid on this task, as this method uses
> +    /// a local mapping.
> +    ///
> +    /// If `off` and `len` refers to a region outside of this page, then this
> +    /// method returns `EINVAL` and does not call `f`.
> +    pub fn with_pointer_into_page<T>(

Name it as `with_slice_in_page` maybe?

> +        &self,
> +        off: usize,
> +        len: usize,
> +        f: impl FnOnce(*mut u8) -> Result<T>,
> +    ) -> Result<T> {
> +        let bounds_ok = off <= PAGE_SIZE && len <= PAGE_SIZE && (off + len) <= PAGE_SIZE;
> +
> +        if bounds_ok {
> +            self.with_page_mapped(move |page_addr| {
> +                // SAFETY: The `off` integer is at most `PAGE_SIZE`, so this pointer offset will
> +                // result in a pointer that is in bounds or one off the end of the page.
> +                f(unsafe { page_addr.cast::<u8>().add(off) })
> +            })
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
> +
> +    /// Maps the page and reads from it into the given buffer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `dest` is valid for writing `len` bytes.
> +    pub unsafe fn read(&self, dest: *mut u8, offset: usize, len: usize) -> Result {
> +        self.with_pointer_into_page(offset, len, move |from_ptr| {
> +            // SAFETY: If `with_pointer_into_page` calls into this closure, then
> +            // it has performed a bounds check and guarantees that `from_ptr` is
> +            // valid for `len` bytes.
> +            unsafe { ptr::copy(from_ptr, dest, len) };
> +            Ok(())
> +        })
> +    }
> +
> +    /// Maps the page and writes into it from the given buffer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `src` is valid for reading `len` bytes.
> +    pub unsafe fn write(&self, src: *const u8, offset: usize, len: usize) -> Result {

Use a slice like type as `src` maybe? Then the function can be safe:

	pub fn write<S: AsRef<[u8]>>(&self, src: S, offset: usize) -> Result

Besides, since `Page` impl `Sync`, shouldn't this `write` and the
`fill_zero` be a `&mut self` function? Or make them both `unsafe`
because of potential race and add some safety requirement?

Regards,
Boqun

> +        self.with_pointer_into_page(offset, len, move |to_ptr| {
> +            // SAFETY: If `with_pointer_into_page` calls into this closure, then
> +            // it has performed a bounds check and guarantees that `to_ptr` is
> +            // valid for `len` bytes.
> +            unsafe { ptr::copy(src, to_ptr, len) };
> +            Ok(())
> +        })
> +    }
> +
> +    /// Maps the page and zeroes the given slice.
> +    pub fn fill_zero(&self, offset: usize, len: usize) -> Result {
> +        self.with_pointer_into_page(offset, len, move |to_ptr| {
> +            // SAFETY: If `with_pointer_into_page` calls into this closure, then
> +            // it has performed a bounds check and guarantees that `to_ptr` is
> +            // valid for `len` bytes.
> +            unsafe { ptr::write_bytes(to_ptr, 0u8, len) };
> +            Ok(())
> +        })
> +    }
> +
> +    /// Copies data from userspace into this page.
> +    pub fn copy_into_page(
> +        &self,
> +        reader: &mut UserSlicePtrReader,
> +        offset: usize,
> +        len: usize,
> +    ) -> Result {
> +        self.with_pointer_into_page(offset, len, move |to_ptr| {
> +            // SAFETY: If `with_pointer_into_page` calls into this closure, then
> +            // it has performed a bounds check and guarantees that `to_ptr` is
> +            // valid for `len` bytes.
> +            unsafe { reader.read_raw(to_ptr, len) }
> +        })
> +    }
> +}
> +
> +impl Drop for Page {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, we have ownership of the page and can
> +        // free it.
> +        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
> +    }
> +}
> 
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

