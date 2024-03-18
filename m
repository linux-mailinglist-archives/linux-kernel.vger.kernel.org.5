Return-Path: <linux-kernel+bounces-106536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7890287F00E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFE01F21BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080A456455;
	Mon, 18 Mar 2024 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chjhjM+X"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6FF4779F;
	Mon, 18 Mar 2024 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788375; cv=none; b=hQikiAwMy5ZkTM0jlq/ADyQSk007WwGgxKfIypx5pWOmGHnp+8TUbc/Jq3KN1Zlvf+o4Sw8wP+6cB1VmemnwVH3REvIf785NRQtxqHSwtmto8Sz9XPczIwnLmX4IC7+wjWfgEjzWUFW0JvZ6oyCKrl5FaxHpezWcXL99l0Otaq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788375; c=relaxed/simple;
	bh=l5t8MphKyGtWNovhRr2a0wnmyVUSJcwUE4jX+Oab91Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/aJHV69sZsxF2+ydq9Hohm33mlxUQa20Mhg8dRj9a/Hhr5wUhHWhSh6CCqw9ctaz1zJXm+OhzQKLaL0Vg5VHrDn4lS5P46NrCdHZBz4vDylaei9fqqOVHLzG7IS54ksHdZeuolCtwEKbUHxmZ1m5kgfFqs3llKZGlzWwjYmQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chjhjM+X; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-789e3f17a6eso239464085a.0;
        Mon, 18 Mar 2024 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710788372; x=1711393172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h7+2OWF6v/Pkb4i25rctRGD7lK8C3lTs+tkkbaSwa4=;
        b=chjhjM+XTeKOB1/GWnoklznxLEMHWIvzz0YDBSqcSXiVqP/w7G+7OKQ6oTfumrlnJp
         kAbeLIKrSdKzROfoa/1SirZUgIOKEjahW/aHGcOw3UawPA/CsLFpiMJGtVlWam82hrbA
         9wjtBKEzeCa/I4G0r48MKLta09uyRR7Fh090J45FTEPHD0ATaESHuiUcEj6wGoeIgFE6
         TOuAbcHNUl8fHk1twFR/VdKL3t7lPZMgUlqyubDTX+lkX3GhCZO7SDR36m652udw6CD2
         aS4Tea4H1iUe3Bm1ND5fEmB+hBLdQXj2/C0AQNHz4VlJwIxEwGlyGh5yuJxyzwtdJL5G
         05+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710788372; x=1711393172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h7+2OWF6v/Pkb4i25rctRGD7lK8C3lTs+tkkbaSwa4=;
        b=O6c9vH1xV+XghHBAawrbyTAppWSL8YGPcAvxpEHY/V36yLME9T1R/fKk6sKVaAv8wv
         Es0FU6dx1CFx4fhFd+cgcs7aGJ/EQPWmcdWdjfbU0KunvVg64goYgn5+7QI7HhvYY8wX
         JLeIalQBC8k/j15eHSby2Jo3yikbM0+zA8abg6/4aZQNu663/2SfvTJMOlx6MlG2/51A
         lj3PIN6SEIUN7ThBdXp/BmgQYL7Vbo27xpiDBYe25qwvbdK+4LaKgBAR275Yq158HZ4m
         jF23/JONJJxjcVQwMQcbVLedRni8D910VP+kf5Q19XL7PRsiJ2L3l+DWvPwcSnmTLEjA
         /1wA==
X-Forwarded-Encrypted: i=1; AJvYcCWguJ2OZDOomEXL1EfKA5xkGoD9u+p+Ba4xEAGlwQVg2HjNkZhjpMtWNWuPPDjZAlRrcVO+d304XcliMIzkxmYpUYsz8xBC9h1Rc3NmzJGMt1KBEwAUqpS4ROFlLaSmmEogG7Pvmq4hRl3HohY=
X-Gm-Message-State: AOJu0YyOXVPPcwpaZhijhpj+c1ORqoMHskheL/JVxjyOt7egFngTJLnU
	gYNVgEwr+YH+Q0kkzvbjcOZT+4ZsLBQyRZlCPqthjA0C9cTO6Mpi
X-Google-Smtp-Source: AGHT+IFJ+deQPfORoCfSt7LaRwTfKef28eErqe6B6pNphIrPzybCAUbOKyybda1jxKsb8KNqouAViA==
X-Received: by 2002:a05:6214:8e7:b0:690:a862:9444 with SMTP id dr7-20020a05621408e700b00690a8629444mr263495qvb.47.1710788372450;
        Mon, 18 Mar 2024 11:59:32 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id pn4-20020a056214130400b006961c1d2b6fsm1521540qvb.80.2024.03.18.11.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 11:59:31 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 4A78B1200032;
	Mon, 18 Mar 2024 14:59:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 18 Mar 2024 14:59:30 -0400
X-ME-Sender: <xms:EY_4ZfbMJgQAsXxE2Jv7isWpXdPqTEJHw6ZSzvJwsvB_uPPz0Phb9w>
    <xme:EY_4ZeZkaC_ASxLSx71HR3kjT8JdSO39gOaiG3TEUgEyLokAYVIm2GJCqcZdGkxSl
    UtSQsvoRzCy2UPkaQ>
X-ME-Received: <xmr:EY_4ZR_ygWl-jUBCc_o4hWdI5ERmzU6ggkwyM_Vr7m3TkGLvkQPHyWUCRvc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedvhedtgfefgfffvdffgfetheehtdfhfeekveelieeiudegheehleelteef
    gfefffenucffohhmrghinhepshhprghrvggptggrphgrtghithihpghmuhhtrdgrshenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvg
X-ME-Proxy: <xmx:EY_4ZVpdUwcQp8X3O-f2iUKoMTzgb2MayMuMuCmcz2PkVVryxtClOQ>
    <xmx:EY_4ZapfmVs3sCQHD8zdOkypyQipM4EX8nhAfomqwzh-nKKXSlHSmg>
    <xmx:EY_4ZbQT3-lR9DpFpi91Q5w2de0QgxEM1K1a5SpOFGKmipSyN32vog>
    <xmx:EY_4ZSqtPLSuEuJAu3XL5ldzGAFI_j359hrlIvZzg6leKhq7LYW70g>
    <xmx:Eo_4ZUiY_tLYYrF788VoX5Mob2DslNV9W4y7EjHgnGBksNNvCNUi8Itfn8Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 14:59:29 -0400 (EDT)
Date: Mon, 18 Mar 2024 11:59:19 -0700
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
Message-ID: <ZfiPB_iavHr8hNbm@boqun-archlinux>
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
> +
> +/// A reader for [`UserSlice`].
> +///
> +/// Used to incrementally read from the user slice.
> +pub struct UserSliceReader {
> +    ptr: *mut c_void,
> +    length: usize,
> +}
> +
> +impl UserSliceReader {
[...]
> +
> +    /// Reads raw data from the user slice into a raw kernel buffer.
> +    ///
> +    /// Fails with `EFAULT` if the read encounters a page fault.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The `out` pointer must be valid for writing `len` bytes.
> +    pub unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result {

I don't think we want to promote the pub usage of this unsafe function,
right? We can provide a safe version:

	pub fn read_slice(&mut self, to: &[u8]) -> Result

and all users can just use the safe version (with the help of
slice::from_raw_parts_mut() if necessary).

> +        if len > self.length {
> +            return Err(EFAULT);
> +        }
> +        let Ok(len_ulong) = c_ulong::try_from(len) else {
> +            return Err(EFAULT);
> +        };
> +        // SAFETY: The caller promises that `out` is valid for writing `len` bytes.
> +        let res = unsafe { bindings::copy_from_user(out.cast::<c_void>(), self.ptr, len_ulong) };
> +        if res != 0 {
> +            return Err(EFAULT);
> +        }
> +        // Userspace pointers are not directly dereferencable by the kernel, so
> +        // we cannot use `add`, which has C-style rules for defined behavior.
> +        self.ptr = self.ptr.wrapping_byte_add(len);
> +        self.length -= len;
> +        Ok(())
> +    }
> +
> +    /// Reads the entirety of the user slice, appending it to the end of the
> +    /// provided buffer.
> +    ///
> +    /// Fails with `EFAULT` if the read encounters a page fault.
> +    pub fn read_all(mut self, buf: &mut Vec<u8>) -> Result {
> +        let len = self.length;
> +        buf.try_reserve(len)?;
> +
> +        // SAFETY: The call to `try_reserve` was successful, so the spare
> +        // capacity is at least `len` bytes long.
> +        unsafe { self.read_raw(buf.spare_capacity_mut().as_mut_ptr().cast(), len)? };
> +
> +        // SAFETY: Since the call to `read_raw` was successful, so the next
> +        // `len` bytes of the vector have been initialized.
> +        unsafe { buf.set_len(buf.len() + len) };
> +        Ok(())
> +    }
> +}
> +
> +/// A writer for [`UserSlice`].
> +///
> +/// Used to incrementally write into the user slice.
> +pub struct UserSliceWriter {
> +    ptr: *mut c_void,
> +    length: usize,
> +}
> +
> +impl UserSliceWriter {
> +    /// Returns the amount of space remaining in this buffer.
> +    ///
> +    /// Note that even writing less than this number of bytes may fail.
> +    pub fn len(&self) -> usize {
> +        self.length
> +    }
> +
> +    /// Returns `true` if no more data can be written to this buffer.
> +    pub fn is_empty(&self) -> bool {
> +        self.length == 0
> +    }
> +
> +    /// Writes raw data to this user pointer from a raw kernel buffer.
> +    ///
> +    /// Fails with `EFAULT` if the write encounters a page fault.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The `data` pointer must be valid for reading `len` bytes.
> +    pub unsafe fn write_raw(&mut self, data: *const u8, len: usize) -> Result {

Same here, just remove the `pub`, and users should use write_slice()
(with the help of slice::from_raw_parts() if necessary).

Regards,
Boqun

> +        if len > self.length {
> +            return Err(EFAULT);
> +        }
> +        let Ok(len_ulong) = c_ulong::try_from(len) else {
> +            return Err(EFAULT);
> +        };
> +        let res = unsafe { bindings::copy_to_user(self.ptr, data.cast::<c_void>(), len_ulong) };
> +        if res != 0 {
> +            return Err(EFAULT);
> +        }
> +        // Userspace pointers are not directly dereferencable by the kernel, so
> +        // we cannot use `add`, which has C-style rules for defined behavior.
> +        self.ptr = self.ptr.wrapping_byte_add(len);
> +        self.length -= len;
> +        Ok(())
> +    }
> +
> +    /// Writes the provided slice to this user pointer.
> +    ///
> +    /// Fails with `EFAULT` if the write encounters a page fault.
> +    pub fn write_slice(&mut self, data: &[u8]) -> Result {
> +        let len = data.len();
> +        let ptr = data.as_ptr();
> +        // SAFETY: The pointer originates from a reference to a slice of length
> +        // `len`, so the pointer is valid for reading `len` bytes.
> +        unsafe { self.write_raw(ptr, len) }
> +    }
> +}
> 
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 

