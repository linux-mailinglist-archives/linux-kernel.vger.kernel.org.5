Return-Path: <linux-kernel+bounces-106570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B8287F072
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F081E1C215D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2444356B7F;
	Mon, 18 Mar 2024 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTtiht4X"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4B56468;
	Mon, 18 Mar 2024 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710790427; cv=none; b=Mu1JJo62nXSSF3s0DN021VgSCIxaVY+97nvBk2On+srIVja4PSwoNT6adbDauvzdK4898ap0hW1zKxV5sUOlUw/VywD5y4gJxKPI1JxTGpqfm1jZDBt6D7gfFwytRyt/WDNtaH0uN+K1N7a2ymL7VSeQPlw1c1xgpFINmg1OsWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710790427; c=relaxed/simple;
	bh=uPxVSnVSbl5l7qo1E3lKmpBywF3ZcXQe1tAltEs5ke0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVNMqG09cdzLuJUSVy3p2o1MhHKU7SFClBA7qgD2kTJac6itZi3g5VH5woKJaUfjPlV41L7K/qrbJ6ONUjQ2L81csWDS7N/rW5+FjgbJFWj6c2er/iWwVWCGidyGYQeJQN5i6IiW8AfjrIc9TQsp+uqYubGfQ+PVH4rMUBi5yZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTtiht4X; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e69543fc1eso693536a34.3;
        Mon, 18 Mar 2024 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710790425; x=1711395225; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e/vcR/G2jUCRQOvGxjdpHUEzdMswpJzejJydIrt8p88=;
        b=JTtiht4X8rFDL8WoseDNFGn2H3r6LavW5IngnVOqcOV1nrSKeFz6/LX8LdHvoYTTGl
         21ASQMDkgTxrVDW9+L3Gj8PP22d5D4QneYLcGPhZ902ZTiCAhbwsRDk6/nobr15aNcCS
         Xqv0KqM+x9PQpWzneb7jvx4qcWzDQEesb8ZNdx7NjvrkyXEQfSIXqBJrNaS7/5/j8yps
         LAKwMGOmP8Pq0gjwzq1NkyyfZG3AnO4XYlpXGOB4Vtb5cNsVQQjtjnaKDPI8cOxFh8KQ
         aqzn0615F3K/sewSdS8M0CbaAIVn8esAz2FKSP+jDaE5sN3Xu3E4Hy1cFS2KK2pqGSPU
         qnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710790425; x=1711395225;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/vcR/G2jUCRQOvGxjdpHUEzdMswpJzejJydIrt8p88=;
        b=ieWXv5M71mPRAyV3q5cdriaUnYZn8oP32RXMaqEW70HcXzI5Yz886LGK3MCs8yWUeY
         WOOlurj3GD/jubWC2GDZRH9Bzxzpmodj/cQfNiiH2lzXbo6rUDoRDXqn7htJMNG8diV5
         OvdE3d7ITMDjK5Lluz9AvY2VNvS9Y559xhb7eG6rTpl6cDmWTyK7vTFtIYMVoygL5Lu9
         Fgre7aDVx5ocC0M4CdCcesqQi3A4TAIQ4AwDBk6fN+RJHmEGQletx1gKAIsEEV5LO3Rz
         s4n9JUbRtxqPvgH6qgI+3VJFhw/OGK/6hRaCfb2WnrOzPO461XTrMPq/zkJYJYT7lk1G
         +Jgw==
X-Forwarded-Encrypted: i=1; AJvYcCXiWievHcYvXpIt0HQn7UpoPycoEZMXyCm6F0PeQVHRFEGYsgczV0t8kIuyO5fJXg8Nz0NrCW10/PAthTU8c0pfWyYsNrykqEr0Jj3aUoPH2ha3dQm+yK7zXRqJoZR4INk1VZbboLyDrRuW/JM=
X-Gm-Message-State: AOJu0Yyi2UJTNjDBZLwHtUXAE/g6uv2d1R1zeKggWpmvngym9LG/KHf2
	32vcya3fLW/Hzw7F744VuPfMhLKmh7k+zLFdT8be6mnPhTL5m0M2
X-Google-Smtp-Source: AGHT+IEV7OSycLt2CYOE+PQTzZDjE/oTijPoZdsYGKrbPPhTdw9WbElQ6iio5Pz/zfZXTii78W5/Fw==
X-Received: by 2002:a05:6830:314a:b0:6e6:9847:8ef3 with SMTP id c10-20020a056830314a00b006e698478ef3mr3074103ots.20.1710790425025;
        Mon, 18 Mar 2024 12:33:45 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id g21-20020a37e215000000b00788663d8a1esm1701175qki.112.2024.03.18.12.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 12:33:44 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id C94171200066;
	Mon, 18 Mar 2024 15:33:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 18 Mar 2024 15:33:43 -0400
X-ME-Sender: <xms:Fpf4ZWyrS4HrYwz5ilDdovYp-0riSlw_SRjX7lgS4-tWejQPjO33nw>
    <xme:Fpf4ZSQhwQAHLQecVuqeawoK2yr9vZeIWaysf1Q3OK7MYG2GQe55U4ozhYKIObwqO
    YOQBUtK9G9NRh5mRQ>
X-ME-Received: <xmr:Fpf4ZYXMkZLOF_7-XQ-BP8U9GTtCHgmf3lGS13hJSMp7mlodWOr5dIWsqv2-Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Fpf4Zcj-UovtfOoNb0MlOXrBFV5QgRFqpZuClYSVa56OBbnUvqVAyA>
    <xmx:Fpf4ZYDv4W-AkmWHIHzCGgKy8FV2-x5O9-j9s07ukIDmuBOOgl0vkw>
    <xmx:Fpf4ZdKVRuteSw0vUW1VT20nJRzzuL6Z_Fd0mrVgjqDU3TJCMhISAQ>
    <xmx:Fpf4ZfAH3kOdTy73bIweRW89kqW0iv62pfKtXW9HDqu_g2oHvRN_Fw>
    <xmx:F5f4ZbaIQY5gSgqyrWq9jSxe9upnGnGp1WXy9mmKHqyNzadITUMXutYZ0P4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 15:33:42 -0400 (EDT)
Date: Mon, 18 Mar 2024 12:33:32 -0700
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
Message-ID: <ZfiXDA7mhW17_ed7@boqun-archlinux>
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
 <20240311-alice-mm-v3-1-cdf7b3a2049c@google.com>
 <ZfiPB_iavHr8hNbm@boqun-archlinux>
 <CAH5fLghs7=V2hHYBnQE-h=xpQYKX5ZxrV1iVdB4ybt7pAXFMWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghs7=V2hHYBnQE-h=xpQYKX5ZxrV1iVdB4ybt7pAXFMWQ@mail.gmail.com>

On Mon, Mar 18, 2024 at 08:12:27PM +0100, Alice Ryhl wrote:
> On Mon, Mar 18, 2024 at 7:59 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Mar 11, 2024 at 10:47:13AM +0000, Alice Ryhl wrote:
> > > +
> > > +    /// Reads raw data from the user slice into a raw kernel buffer.
> > > +    ///
> > > +    /// Fails with `EFAULT` if the read encounters a page fault.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// The `out` pointer must be valid for writing `len` bytes.
> > > +    pub unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result {
> >
> > I don't think we want to promote the pub usage of this unsafe function,
> > right? We can provide a safe version:
> >
> >         pub fn read_slice(&mut self, to: &[u8]) -> Result
> >
> > and all users can just use the safe version (with the help of
> > slice::from_raw_parts_mut() if necessary).
> 
> Personally, I think having the function be unsafe is plenty discouragement.
> 
> Also, this method would need an &mut [u8], which opens the can of
> worms related to uninitialized memory. The _raw version of this method

make it a `&mut [MayUninit<u8>]` then? If that works, then _raw version
is not more powerful therefore no need to pub it.

> is strictly more powerful.
> 
> I don't think I actually use it directly in Binder, so I can make it
> private if you think that's important. It needs to be pub(crate),

I might be too picky, but avoiding pub unsafe functions if not necessary
could help us reduce unnecessary unsafe code ;-)

Regards,
Boqun

> though, since it is used in `Page`.
> 
> Alice

