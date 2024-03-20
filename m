Return-Path: <linux-kernel+bounces-109301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50A3881762
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3372CB21450
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBFE8529D;
	Wed, 20 Mar 2024 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5TIoIGo"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01914F214;
	Wed, 20 Mar 2024 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959994; cv=none; b=PyCxHCSWDy0BGa2VEIjTV+88YoMj+URjARyaWAWr6aK2LGiVE+Aeg9TIiLhcS37u/RtZDY8oKSWpoO7iiPoyAuUBtEcCz9qrIx/uIuZeYx+LtmEnCde031l0+RxxPnNRI1V/AnhqJdIlxENCXGMn/hou3QR+CcG+p9Scs7ZnOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959994; c=relaxed/simple;
	bh=S/sytZTQ/V3fEb3RY0qv+twoobr9IaTxQMa2BQaJYzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR87SUe8BFHuxu8IeZ1h1n9c1iAHqqsaYU32d3Xa7Bjb8Ghhb1gED4ylLXO8q9yhGibHNEpJEVIuMXcEbfK9dPVaau1EJItzri11rUv+GX3zlLMU9IBXi49wy49VWsHL3VaYfzljACjMReSHLbjKnf52u7nk0jQi3UaFD13zjaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5TIoIGo; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430a7497700so1302031cf.1;
        Wed, 20 Mar 2024 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710959992; x=1711564792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWRvU83WE/XxBo1v/F0X5t/KDOzdzaHYVuEHQEDHtYc=;
        b=H5TIoIGoevzaoQUUJ+xBevuzfXysfgwcWqbsiNERd84oyEwpTiggF3ODIjjfSnku9x
         zeLO1EFpufEHDvUMe0rrcR/EzbhdJa0ELd2rdHdi93/2u8yzsFcEySyCh3kEqEElq+uh
         wbk7JPlkNnGfiOfIb3ugNeEIeSTaBVwPGf6O+fb3WSwQFyghxs1x8MFedogloiygajfW
         XjTSpKW0+IULbjPtWXk344XscuCrOLpa/qBM7xmWpuQflye1A+EMsFeQ5fA71noPeCBA
         tBBaBKzgP2HVhjfRJK4kD7nI6i7dMH2s8hrDfk9tMrgrifCRsREZISXQP8NKGlpYY99z
         43mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710959992; x=1711564792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWRvU83WE/XxBo1v/F0X5t/KDOzdzaHYVuEHQEDHtYc=;
        b=HykhJh5t95OQ2GZ7ERhhXkYTiH29PXEXz2sNV0/Rk5a6o7huCzWsUCRumaqgpRC41M
         caQb0yWcXha+cop0aTAADFD94YY6VfD2WPQ65EHHO1AM7pDI1qPpgoeOv+hvIL03TQBt
         43RKLlp6mZxFt8S1Htmetf8TscKxuEjUwYaCO3PzGXS+2cQfdD8m3Ie6EnvisuJIuJCT
         yD0I9NctKnFYQsw2R57MS7npSPoQyqNJAZ81g65gZccsmddnoIJcwburKdZwH6DfdnY4
         qTV7e563+yh/0Bby8GxQFTp20S41S7KFZySSeDNoeBh1+m9omoxNj6YE4PhKWo+QyMRk
         Kztg==
X-Forwarded-Encrypted: i=1; AJvYcCV6CikpnL5frIs1ZCzTeqnfiwMee0LmZcZx889YNPY5rX9stALf+mYvAJKKupykTyy60STjbp7ExzDlDFKNxUZZT43uwoNN8581VCSGJsnUxualKhJJ5R9q/XeEgvCKcxQYTgDWa8024SV4E+s=
X-Gm-Message-State: AOJu0YzsamEDoGKCfVAZACsGcA/ol+c6BZhsLfdY9g2hTsLWp3niNX8b
	4FrdH8xrnyKJiwKgonWo4fMw17D/QkMt7mvIEz14VhPTXyKiVfli
X-Google-Smtp-Source: AGHT+IFS9uSNLSBh1XOFh0ALtqPOKyEM9BMZXRgz5Y/IEkIql9atTB8xsItHCTfp9JxRAMGj2zrWjg==
X-Received: by 2002:a05:622a:1804:b0:430:ba7a:fe7b with SMTP id t4-20020a05622a180400b00430ba7afe7bmr14742759qtc.44.1710959991779;
        Wed, 20 Mar 2024 11:39:51 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id fb19-20020a05622a481300b004309cf16815sm4019519qtb.39.2024.03.20.11.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:39:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A2C461200066;
	Wed, 20 Mar 2024 14:39:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 20 Mar 2024 14:39:50 -0400
X-ME-Sender: <xms:dS37ZTNLe09Fb7QwOs_4Cujp7ENOGs-njgdpGennczPhcTwd-YgdVA>
    <xme:dS37Zd_yCHIJFuLvi_TKJu0-dPELv3Bf73eEmduVhXvuhQqRo3maMfitV-R9wWc7U
    K3GCxI41HRCDwCd8g>
X-ME-Received: <xmr:dS37ZSQb-NYnQ1yYjHx8GtzVqhXmtY62C6woSsHouHuE-My41hy_g5xYvGimWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeggdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedvveevleevhfekhefftdek
    ieehvdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:di37ZXtSGfJ4RJiEyvT6nQBMtYNjN417sebdNcahW2VJ27hGoq8NOQ>
    <xmx:di37ZbdkisSEkTyCzfdzGZ3luAiBYSGNElPGLy-tvk3l1XEbmSY17g>
    <xmx:di37ZT3oAxGEE_yQp_rk9e19dg15LESFaPP63oZOqs8wlqSPmjq1Sw>
    <xmx:di37ZX9BKjIVQXbhRVtudAZ7rGPrcTvVNMWRjmCPbiox5G5ke6bugQ>
    <xmx:di37ZemxcpF3Eo5mHsgVJRWuSxWUfQnKBdLyruG4jkKOjg6lIA-c8yOIHF4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Mar 2024 14:39:49 -0400 (EDT)
Date: Wed, 20 Mar 2024 11:39:33 -0700
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
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 1/4] rust: uaccess: add userspace pointers
Message-ID: <ZfstZZbagFLj7dqq@boqun-archlinux>
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
 <20240311-alice-mm-v3-1-cdf7b3a2049c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311-alice-mm-v3-1-cdf7b3a2049c@google.com>

On Mon, Mar 11, 2024 at 10:47:13AM +0000, Alice Ryhl wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
[...]
> +/// # Examples
> +///
> +/// Takes a region of userspace memory from the current process, and modify it
> +/// by adding one to every byte in the region.
> +///
> +/// ```no_run
> +/// use alloc::vec::Vec;
> +/// use core::ffi::c_void;
> +/// use kernel::error::Result;
> +/// use kernel::uaccess::UserSlice;
> +///
> +/// pub fn bytes_add_one(uptr: *mut c_void, len: usize) -> Result<()> {

I hit the following compile error when trying to run kunit test:

	ERROR:root:error: unreachable `pub` item
	    --> rust/doctests_kernel_generated.rs:4167:1
	     |
	4167 | pub fn bytes_add_one(uptr: *mut c_void, len: usize) -> Result<()> {
	     | ---^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	     | |
	     | help: consider restricting its visibility: `pub(crate)`
	     |
	     = help: or consider exporting it for use by other crates
	     = note: requested on the command line with `-D unreachable-pub`

	error: unreachable `pub` item
	    --> rust/doctests_kernel_generated.rs:4243:1
	     |
	4243 | pub fn get_bytes_if_valid(uptr: *mut c_void, len: usize) -> Result<Vec<u8>> {
	     | ---^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	     | |
	     | help: consider restricting its visibility: `pub(crate)`
	     |
	     = help: or consider exporting it for use by other crates

	error: aborting due to 2 previous errors

, which should be fixed if we make the function in the example not
`pub`.

> +///     let (read, mut write) = UserSlice::new(uptr, len).reader_writer();
> +///
> +///     let mut buf = Vec::new();
> +///     read.read_all(&mut buf)?;
> +///
> +///     for b in &mut buf {
> +///         *b = b.wrapping_add(1);
> +///     }
> +///
> +///     write.write_slice(&buf)?;
> +///     Ok(())
> +/// }
> +/// ```
> +///
> +/// Example illustrating a TOCTOU (time-of-check to time-of-use) bug.
> +///
> +/// ```no_run
> +/// use alloc::vec::Vec;
> +/// use core::ffi::c_void;
> +/// use kernel::error::{code::EINVAL, Result};
> +/// use kernel::uaccess::UserSlice;
> +///
> +/// /// Returns whether the data in this region is valid.
> +/// fn is_valid(uptr: *mut c_void, len: usize) -> Result<bool> {
> +///     let read = UserSlice::new(uptr, len).reader();
> +///
> +///     let mut buf = Vec::new();
> +///     read.read_all(&mut buf)?;
> +///
> +///     todo!()
> +/// }
> +///
> +/// /// Returns the bytes behind this user pointer if they are valid.
> +/// pub fn get_bytes_if_valid(uptr: *mut c_void, len: usize) -> Result<Vec<u8>> {

Ditto here.

> +///     if !is_valid(uptr, len)? {
> +///         return Err(EINVAL);
> +///     }
> +///
> +///     let read = UserSlice::new(uptr, len).reader();
> +///
> +///     let mut buf = Vec::new();
> +///     read.read_all(&mut buf)?;
> +///
> +///     // THIS IS A BUG! The bytes could have changed since we checked them.
> +///     //
> +///     // To avoid this kind of bug, don't call `UserSlice::new` multiple
> +///     // times with the same address.
> +///     Ok(buf)
> +/// }
> +/// ```
> +///
> +/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
> +/// [`clone_reader`]: UserSliceReader::clone_reader
> +pub struct UserSlice {
> +    ptr: *mut c_void,
> +    length: usize,
> +}
> +

Regards,
Boqun

[...]

