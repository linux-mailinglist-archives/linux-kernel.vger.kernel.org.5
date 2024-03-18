Return-Path: <linux-kernel+bounces-106669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B2787F1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37421C212CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEAD5A0E7;
	Mon, 18 Mar 2024 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GieAZG0d"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7859B42;
	Mon, 18 Mar 2024 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796078; cv=none; b=WJNDIk+bAcJu61YqTKbtFAtmaJP30V4ziFA+6Aaz4TA8zrAtrGLwzS4TotlTAe9LOLZLJgf9+IO4mUu4AGS9R4qQPlcYJO4Uet+MQLaUyGtj8+dT82DCmYjxOUyQh/0tZ4pH+GRB7F6mRnkXIeHArR5oSoSHIDkz2t3P/iq92aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796078; c=relaxed/simple;
	bh=h+WqgvzP4/+gDNp7hG5rTOgG1PQ4RqFRMSs71a95YrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfL4dOaRNYS/HU4YUhnyxXl03eiCLJfmarsNxcTEQ5DmGOny033JpsFo1a6wYCmpxlNHNh/P21q9jcyC+qOZ+VEFiqudmnsHcADn2s8gL7nGOO0j9mdzhaFNHLTbLgxDx4ZdMm4ETK5rYW3YF70CBQ2HZJUTS2ErH6SvzY2dYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GieAZG0d; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-781753f52afso265070185a.2;
        Mon, 18 Mar 2024 14:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710796076; x=1711400876; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eiVYCH3ebRwARaRqeO4Qvn+w/sqdsvs+eK65f6OjZ8c=;
        b=GieAZG0dTZRPCEG2Nv/ReVyP3nOVEO9DcVRYxEGx93fsIjuZs4Vc9JmgOaUflUUT+Q
         gv2ejQDssAxGesJX3lX5hvj7mX4PdFe0KHgGyt/EI1faDvL9EGLDl/RKV1sIQg4wxPeJ
         +V3kNPrTmDYoy7NiUfb+YH64XBmY2zHnSOpTDmUwYahQUDMGVyS5SQfmrB1f+r3sMo/9
         GWkYN44crTrB4c1hvncMt0Zsv8R/Ovs7adfWkuVTSm6X6ybeiBWHi14JOfsW1qKw/NTP
         K/hRQTvJpqmJ/rkaEDMzCRmBusTcs8pHbBgjJJbo0AXkafJOEB2iZV5SseARAqU7+WA2
         IBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710796076; x=1711400876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiVYCH3ebRwARaRqeO4Qvn+w/sqdsvs+eK65f6OjZ8c=;
        b=AP8hc4bl/hENBH3T8NogqHt1cXuVbYm1srrPmi5R44k+3MtrHNPSJZRH7wO8y581P3
         c10qnHal1/S0LJ5eoYk1WzLv/OPUUdiWLMPhEJ0l/02Wq3/1n2pKfIrDvR1aYGyaK5lB
         2DZwzsLeNYtgLn0V+H7AQUOK+zf5LIe5QYMKQynIxH1xN4yGnUAOiSwO7+p8W5dWux6C
         vl8TTM/C+EYxpiSnuSSUXKh3X/Z6JRH2XVYkiX/e35i1CSe2nsdNODdwOfU7gZ6XNF3a
         yQ0Vo30V/jVXdhDh+ZoX/8Gdh250Zg2Vrvq2npjt52/XTG8TFj0/uNsuGpCgOAofJ7Z1
         Guvw==
X-Forwarded-Encrypted: i=1; AJvYcCVCefiEiNFrX6n3xI7FKKiPmMgDA40OVeGR+iY2xY14Nw7ubUDduaFmP/Z2hjPlTzwrB0OkiRbQJZzO/LCYPUEnhaBPToarDel5UlfLKcvnpn0oqgz1lX7rTSHjBs+9ci2OevOdG+9XMxpdPRQ=
X-Gm-Message-State: AOJu0Yx0WcSH8SZl6DZeUuHfi94d1PfcdYd+jvChE8T6V+z0+c17qPqh
	jaoubVSoslpIuej3w3l5LN8S7Hkb5TvORbzFLOOAuM9QwP9uMO/9
X-Google-Smtp-Source: AGHT+IFEGdB2ae30dqn+0fOOHR9nVxS27IfG+d/7Ow0+sJwZwSUmc8SgVHnnzbFqXyfj/Rc2mIWS/g==
X-Received: by 2002:a05:6214:1084:b0:691:3c21:2c11 with SMTP id o4-20020a056214108400b006913c212c11mr575731qvr.26.1710796075858;
        Mon, 18 Mar 2024 14:07:55 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id g12-20020a0caacc000000b0069186a078b3sm3649840qvb.143.2024.03.18.14.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:07:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id BB7281200032;
	Mon, 18 Mar 2024 17:07:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Mar 2024 17:07:54 -0400
X-ME-Sender: <xms:Ka34ZfxhrY75omeDsLRVoNHQXY3SkX57vsKF4OcjPQifcFj9FPUpNA>
    <xme:Ka34ZXQ8IarNsX5o9ke3wHXeiDxFEzOFT_Mp0z9grQ_P1-33n6gR71uHO9gLRUPwF
    LM0g0KjU9Ls9Axx2g>
X-ME-Received: <xmr:Ka34ZZVNx5b424OzWjOGU5c31a-gYueSt6kMyNjkXh-XbXavFEGURuTxdNimCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Ka34ZZhSz0Krj4iKgfeC0pItkHFBltijMUoY_ho_jVl7s_eYcAw1Ww>
    <xmx:Ka34ZRB_3ubA-AEkqQp3Q6igHRvdDYOrObbjv8cIwhM52Vb0OsEF2g>
    <xmx:Ka34ZSIWi7ZQ-tuFoq3BFjgngzdW-NN2ZNiDxy8U_ElAK0Wk9UOnPw>
    <xmx:Ka34ZQCKEAVZooj4tGRexvzCkuOe8BLw1C280VBtzu5bc0Ww9X4E5w>
    <xmx:Kq34ZYYEBHJwCggtw0UqmTadvDFqgSvAIGIjsUETX5NLgNczfdU4p3OdWXI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 17:07:53 -0400 (EDT)
Date: Mon, 18 Mar 2024 14:07:43 -0700
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
Message-ID: <ZfitHxqZEOnD1wei@boqun-archlinux>
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
 <20240311-alice-mm-v3-1-cdf7b3a2049c@google.com>
 <ZfiPB_iavHr8hNbm@boqun-archlinux>
 <CAH5fLghs7=V2hHYBnQE-h=xpQYKX5ZxrV1iVdB4ybt7pAXFMWQ@mail.gmail.com>
 <ZfiXDA7mhW17_ed7@boqun-archlinux>
 <CAH5fLgg=7qyOiW6szF4+N=_oNfpqBBSmreeK4VT=HXq9qm_KAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgg=7qyOiW6szF4+N=_oNfpqBBSmreeK4VT=HXq9qm_KAg@mail.gmail.com>

On Mon, Mar 18, 2024 at 09:10:07PM +0100, Alice Ryhl wrote:
> On Mon, Mar 18, 2024 at 8:33 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Mar 18, 2024 at 08:12:27PM +0100, Alice Ryhl wrote:
> > > On Mon, Mar 18, 2024 at 7:59 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Mon, Mar 11, 2024 at 10:47:13AM +0000, Alice Ryhl wrote:
> > > > > +
> > > > > +    /// Reads raw data from the user slice into a raw kernel buffer.
> > > > > +    ///
> > > > > +    /// Fails with `EFAULT` if the read encounters a page fault.
> > > > > +    ///
> > > > > +    /// # Safety
> > > > > +    ///
> > > > > +    /// The `out` pointer must be valid for writing `len` bytes.
> > > > > +    pub unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result {
> > > >
> > > > I don't think we want to promote the pub usage of this unsafe function,
> > > > right? We can provide a safe version:
> > > >
> > > >         pub fn read_slice(&mut self, to: &[u8]) -> Result
> > > >
> > > > and all users can just use the safe version (with the help of
> > > > slice::from_raw_parts_mut() if necessary).
> > >
> > > Personally, I think having the function be unsafe is plenty discouragement.
> > >
> > > Also, this method would need an &mut [u8], which opens the can of
> > > worms related to uninitialized memory. The _raw version of this method
> >
> > make it a `&mut [MayUninit<u8>]` then? If that works, then _raw version
> > is not more powerful therefore no need to pub it.
> 
> Nobody actually has a need for that. Also, it doesn't even remove the

I want to use read_slice() to replace read_raw(), and avoid even
pub(crate) for read_raw().

> need for unsafe code in the caller, since the caller still needs to
> assert that the call has initialized the memory.
> 

If we have the read_slice():

    pub fn read_slice(&mut self, to: &mut [MayUninit<u8>]) -> Result

then the read_all() function can be implemented as:

    pub fn read_all(mut self, buf: &mut Vec<u8>) -> Result {
        let len = self.length;
        buf.try_reserve(len)?;

	// Append `len` bytes in the `buf`.
        self.read_slice(&mut buf.spare_capacity_mut()[0..len])?;

	// SAFETY: Since the call to `read_slice` was successful, so the
	// next `len` bytes of the vector have been initialized.
        unsafe { buf.set_len(buf.len() + len) };
        Ok(())
    }	

one unsafe block has been removed, and yes, you're right, there is still
need of unsafe here, since the caller still needs to assert the memory
has been initialized. However, to me, it's still an improvement, since
one unsafe block gets removed because we get away from reasoning based
on raw pointers and length.


And yes, for the worst case, we still have the same amount of unsafe
code. For example in `Page::copy_from_user_slice`, if read_slice() is
used, we still need to:

    let mut s = unsafe { slice::from_raw_part_mut(dst.cast::<MayUninit<u8>>(), len) };
    reader.read_slice(&mut s);

i.e. move the unsafe part from `reader` to the construction of a
"writable slice". However, it's still better, since contructing a slice
is quite common in Rust so it's easy to check the safety requirement.


I generally think replacing a pointer+length pair with a slice is
better.

Regards,
Boqun

> > > is strictly more powerful.
> > >
> > > I don't think I actually use it directly in Binder, so I can make it
> > > private if you think that's important. It needs to be pub(crate),
> >
> > I might be too picky, but avoiding pub unsafe functions if not necessary
> > could help us reduce unnecessary unsafe code ;-)
> >
> > Regards,
> > Boqun
> >
> > > though, since it is used in `Page`.
> > >
> > > Alice

