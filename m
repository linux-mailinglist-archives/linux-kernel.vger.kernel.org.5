Return-Path: <linux-kernel+bounces-145958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D058A5D42
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7EB284BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06F9157491;
	Mon, 15 Apr 2024 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2Wl6ORK"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42315748F;
	Mon, 15 Apr 2024 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713218007; cv=none; b=I3KybHy26y3eey8fImJkoGK6pPBnfS/GXxD9Evo6PPDQtS848m8XFuYm+ia7hDfICd1mFj9Tplu3aexwJ4g0eJ6d1ZjJYF1qogwVxBEEGple7qiW+CsPF/a2XMcODFInWTN+MZuy/L5SqUWIZwiZvaZpqkzX4fIKtPlF2hbzMZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713218007; c=relaxed/simple;
	bh=SGvEdSzbVNIXs1MJvKUdxXW7XodkwPkxff947Nmcznk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVOVRFmSbfAo/c3A3+KXePuqOCPS8B0SL9YYySvemgvQul1SxNhy75FTsXFDwcGOTv3Q8sQjX2wh85S5WWKY5jhR6V7p1qVy8+U6yEaHJIBokXmu0u36meAJFbwbiL0kAl0CC1PM2EbNzIkzhWcN79GW9Dw6P4Gp2LMuUP05U6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2Wl6ORK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-434b7ab085fso41637051cf.1;
        Mon, 15 Apr 2024 14:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713218005; x=1713822805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4QjxBzsTXB7diBcl5dTgdSW8x93qRsLQtekUiqvII8=;
        b=X2Wl6ORKNems0fbCb+yACb/WTNhMuuCFlL2xm9xZQtQG2ZOWmoQWFsS8XCMQ61Zo0x
         p7fE8DEGha9NdZVm+skX0ty9NipE8e0oTatDZ1Udz7Oeow0/2AisNsc0XR9GskJp5TPz
         UiwOfa2Z4NQLO9ALBYvY47YkaJHi/OjCfy/5BZck2coCsV4ghUTu/W+Qvc8/MxBLhM14
         uYdkS0ssocba/JjzMMW591t0bmFIyN6zPufrQvuzS3UuiJMiJwLD6+svRq/LUzzuUX2G
         /mooQ+ETgFmJAWzpaCZ3UGH1UGnFCkrBmbnlVZ3wVqgRXD+JJj4L4KYWM03OFjwmIBIE
         z6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713218005; x=1713822805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4QjxBzsTXB7diBcl5dTgdSW8x93qRsLQtekUiqvII8=;
        b=uJ1a1kIDZhZhh91AaaZki+B4BaFxDi7DB5YSk5mx7+M+752U9Gvr1Kw3Iwue4F4FW5
         d3pcjnhZnwrxnvmCxAmry47sWlDnSO2L2+juGvUHEuBAzc+JcN5SsBF+Z1jR39JxbLt6
         UmFtwo/LHgO6p+4UTnCzIlk1sOqhvnj1yKrYZBetYexnRth3wpfS6cHbNnJr0OxgFgua
         2DC30imb3ba/HRfwFZfDLQT1MX3Rm0vOLwHxv8fgD/K8/y7ok6nWVnoDuti7zGqzbOq8
         GD5CaTXEZSiHQuzfnzUe9d1xvPoidtBzv8HUdEdrLtQVA61fA530aOH1HNWXd0wKywO1
         1seg==
X-Forwarded-Encrypted: i=1; AJvYcCUsIQ77ifuqs0090QeTJl54GXCPwAMvTho6RspEViCapbvIsvkrvUARHGOyiiTVrmh6jV6g2ieVXbdYNIH9NBKpKnDsi/hl6ChA3Ij3cbRvTiuZBbeUtumvp8/v9W+Srl1MuKkBFwfm7s8x3m0=
X-Gm-Message-State: AOJu0YyxUyJ1YM1cNy69H41b1qqzDT5TSvodq8cl8qL5IpGkx0+Zs6vT
	ZTmkkceENVTfLO1Wa6VFe5t7dEyKPWKPykAxJR0zLVvg7QvejY07
X-Google-Smtp-Source: AGHT+IGfTlcT01C0SngR63rLuC0OJbsEwwsCHS3hFr45/xbB+8hfJ+Wejt8gAURALG3QrWoVnNJJ3w==
X-Received: by 2002:ac8:5741:0:b0:434:e7d6:b51b with SMTP id 1-20020ac85741000000b00434e7d6b51bmr1616157qtx.31.1713218004948;
        Mon, 15 Apr 2024 14:53:24 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id fu28-20020a05622a5d9c00b00436510ddc5esm6517347qtb.34.2024.04.15.14.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:53:24 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 8E4381200066;
	Mon, 15 Apr 2024 17:53:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 15 Apr 2024 17:53:23 -0400
X-ME-Sender: <xms:06EdZnbbQsUxwI70OOpFVwVBknIqzstgBF3Dcl3RjOpREREYr0DidA>
    <xme:06EdZmaRYft-3hFYAxqAtXI2pdojN1VHDxq9LlOz5FdmKQUfMm6PqqWSf2bSs9yoQ
    C5J3YJSnOcn8L29yw>
X-ME-Received: <xmr:06EdZp_klCYwjnxXnNolqcKumqyt2PIrSzTc0SEKaJvRQNAKkXWI6GkpLug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejfedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:06EdZtqdQxxTQQ8KLC1OnHbTi7thQxoXyL_4HNFUSsLl-nhKzLmRvg>
    <xmx:06EdZirW15UQnC31snfijPs7Z04o54oZl5e7flxp08qRCf2tEG85mw>
    <xmx:06EdZjSI7hIAp0sfzDZ6TJOsmLQYzMy8JDwVtPLzvAZNAWDt3xkZ5A>
    <xmx:06EdZqpHfHhU2EV4NAOUgMyOmfNUVGTayouj-IgVMoaeFHCo1LUmsw>
    <xmx:06EdZj4Mtno7waCTRl_37lhLDXx69MSjfE1JyRjYVkvEjTs6-b3WEHkE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 17:53:22 -0400 (EDT)
Date: Mon, 15 Apr 2024 14:53:07 -0700
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
Subject: Re: [PATCH v5 1/4] rust: uaccess: add userspace pointers
Message-ID: <Zh2hw0uQrkN5yVVA@boqun-archlinux>
References: <20240415-alice-mm-v5-0-6f55e4d8ef51@google.com>
 <20240415-alice-mm-v5-1-6f55e4d8ef51@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415-alice-mm-v5-1-6f55e4d8ef51@google.com>

On Mon, Apr 15, 2024 at 07:13:53AM +0000, Alice Ryhl wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> A pointer to an area in userspace memory, which can be either read-only
> or read-write.
> 
> All methods on this struct are safe: attempting to read or write on bad
> addresses (either out of the bound of the slice or unmapped addresses)
> will return `EFAULT`. Concurrent access, *including data races to/from
> userspace memory*, is permitted, because fundamentally another userspace
> thread/process could always be modifying memory at the same time (in the
> same way that userspace Rust's `std::io` permits data races with the
> contents of files on disk). In the presence of a race, the exact byte
> values read/written are unspecified but the operation is well-defined.
> Kernelspace code should validate its copy of data after completing a
> read, and not expect that multiple reads of the same address will return
> the same value.
> 
> These APIs are designed to make it difficult to accidentally write
> TOCTOU bugs. Every time you read from a memory location, the pointer is
> advanced by the length so that you cannot use that reader to read the
> same memory location twice. Preventing double-fetches avoids TOCTOU
> bugs. This is accomplished by taking `self` by value to prevent
> obtaining multiple readers on a given `UserSlicePtr`, and the readers
> only permitting forward reads. If double-fetching a memory location is
> necessary for some reason, then that is done by creating multiple
> readers to the same memory location.
> 
> Constructing a `UserSlicePtr` performs no checks on the provided
> address and length, it can safely be constructed inside a kernel thread
> with no current userspace process. Reads and writes wrap the kernel APIs
> `copy_from_user` and `copy_to_user`, which check the memory map of the
> current process and enforce that the address range is within the user
> range (no additional calls to `access_ok` are needed).
> 
> This code is based on something that was originally written by Wedson on
> the old rust branch. It was modified by Alice by removing the
> `IoBufferReader` and `IoBufferWriter` traits, and various other changes.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Thanks!

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Two small nits below..

> ---
>  rust/helpers.c         |  14 +++
>  rust/kernel/lib.rs     |   1 +
>  rust/kernel/uaccess.rs | 304 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 319 insertions(+)
> 
[...]
> +    /// Reads raw data from the user slice into a kernel buffer.
> +    ///
> +    /// Fails with `EFAULT` if the read happens on a bad address.

.. we probably want to mention that `out` may get modified even in
failure cases.

> +    pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
> +        // SAFETY: The types are compatible and `read_raw` doesn't write uninitialized bytes to
> +        // `out`.
> +        let out = unsafe { &mut *(out as *mut [u8] as *mut [MaybeUninit<u8>]) };
> +        self.read_raw(out)
> +    }
> +
[...]
> +
> +impl UserSliceWriter {
[...]
> +
> +    /// Writes raw data to this user pointer from a kernel buffer.
> +    ///
> +    /// Fails with `EFAULT` if the write happens on a bad address.

Same here, probably mention that: the userspace memory may be modified
even in failure cases.

Anyway, they are not correctness critical, so we can do these in later
patches.

Regards,
Boqun

> +    pub fn write_slice(&mut self, data: &[u8]) -> Result {
> +        let len = data.len();
> +        let data_ptr = data.as_ptr().cast::<c_void>();
> +        if len > self.length {
> +            return Err(EFAULT);
> +        }
> +        let Ok(len_ulong) = c_ulong::try_from(len) else {
> +            return Err(EFAULT);
> +        };
> +        // SAFETY: `data_ptr` points into an immutable slice of length `len_ulong`, so we may read
> +        // that many bytes from it.
> +        let res = unsafe { bindings::copy_to_user(self.ptr, data_ptr, len_ulong) };
> +        if res != 0 {
> +            return Err(EFAULT);
> +        }
> +        // Userspace pointers are not directly dereferencable by the kernel, so
> +        // we cannot use `add`, which has C-style rules for defined behavior.
> +        self.ptr = self.ptr.wrapping_byte_add(len);
> +        self.length -= len;
> +        Ok(())
> +    }
> +}
> 
> -- 
> 2.44.0.683.g7961c838ac-goog
> 
> 

