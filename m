Return-Path: <linux-kernel+bounces-108358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6886880992
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC581C21EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1308494;
	Wed, 20 Mar 2024 02:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2ndfG3c"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCF37489;
	Wed, 20 Mar 2024 02:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710901677; cv=none; b=f44dXxfESXyoAdpC0gpFcb0jS4tQofw4tsNVMFCHkrnOn4SIds2GkvaKg0JcpMGu/WIuzAj7BeP4kx9dHqxwJzp9a5xQiJ0ZVlAwvQdiCJ64AjIoA8wUKHeFYucS6xsDBfnq4iOUPy2CgeZiHzTUdUbDwqMiNvOfzuxXXhxipAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710901677; c=relaxed/simple;
	bh=6CJWoFb4kvUK4ntLfUsptms1BUN5l+ymtlBqPsp9uoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDGlHiDvv//MCa9igrUe5zQjtGewVZWcaLLgxDboloEM3ZlARiJxHIob0duLmkUazme086Iaxy/6ZpDR1HHWblFpHTAwxwIir22ezkcV0PAQtW9p6DchVpFMHXCOInOKj6BlGtmNDfSN1Qs8yXyFpe+Jd90kfSCuilSHjsfqP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2ndfG3c; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-789e4a4d3a5so302130185a.1;
        Tue, 19 Mar 2024 19:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710901675; x=1711506475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoYH80sJnhdliON/wfQAq4dWt7OAKJu6XRvbeyVwYo0=;
        b=F2ndfG3calznTzI4/X6AkGWT7gD4WyYCuOMOlAZEsURNRsemM2OQ+STQuUrLd13FtD
         jXJeltP+cJAzHjkazP95GQ/ECEaK076uXk5AF3ffDx/y3ZVTgb2pRqRCFt+VlV3duXS7
         lVoBxxKEAuFstgdJDJn8FyBgKgecUGxK8q2jRDa5hgHD+kIU9/TlokrmD9Bkz8Fi6akR
         K74vRdgKcQYEfixmM8vZOfPs0sICTJ5OhWm68G4XK2fe8Lsr8RxA7rczgpemoDESmCMe
         pechVgiGdcm+sN/7S1TXx6m+RB0m1VDFX4q5bpIWMeobqksQ9SmA0f5GmsPnyGfo4Pvu
         UHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710901675; x=1711506475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoYH80sJnhdliON/wfQAq4dWt7OAKJu6XRvbeyVwYo0=;
        b=vvegdtu8woptZQrvurhrF4J9i11oWSAGtEPGut4J9uBOq8Kh7QM5HjN5CnkY/q6Mi3
         JcquKPvvWRzLutkh6OUtcD4JFAot4MBowFcqha3l/hqAQGPlTorAD4e6y/HDM8VcKDAR
         0MU2Z4TzBZSdTx0mnh79N+RwUneD8jFduDa2Zjf3/tiP8ZGIjZkiXhqQLSssf91nHW1W
         pYD9vef14r8bUf7vikRGnQT16144AoOmWkhwk665JBBTPXHWr4uv1NSiK2kSmXSPlygm
         Z2GJO+/kHbiWeQD7U7PF/7q6lw3yLWDLMOtshSE0wDpR4E1Ce7yuO++AjxMv4ijHhveR
         d2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCU/kVe8/J+LitZmZF53eQ8JyV0n3LsF0kxEM5mkCSQYy8liIAV6TKil3KoUDfYNHNd3kmyltB7YcYV/4/XmLuR5nJkYINnJ2NJySxXpkGMQ2K1PdpEgxfz4nZL9jPRTjowxLY+qASxVNA/00qs=
X-Gm-Message-State: AOJu0YzEKuVXmpJt9o+1WSs8wKcWFB68bOnCw33nNrnlvcJtPFlG2q2D
	JD1mhG/3X6Ei+KqlqQlAekBN7rQeGZK3Vm9zORs9D5/G4VSS/4yv
X-Google-Smtp-Source: AGHT+IHkAo9eiqZEBwRiPx6Er0DVaobmgBZ9GU8BbZoe5uwTFIH5mrJndnxU84N5b4b+Ka9j6hodbw==
X-Received: by 2002:a05:6214:5188:b0:690:bdd5:f25e with SMTP id kl8-20020a056214518800b00690bdd5f25emr618855qvb.59.1710901674843;
        Tue, 19 Mar 2024 19:27:54 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id j10-20020a0cf30a000000b006915cc2f655sm7167436qvl.30.2024.03.19.19.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 19:27:54 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A9CAF1200032;
	Tue, 19 Mar 2024 22:27:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 19 Mar 2024 22:27:53 -0400
X-ME-Sender: <xms:qUn6ZZusapBKdG8mib9oUwmKQcnjaqz7jBvHqEEWkk9Cs5CjOpqJkA>
    <xme:qUn6ZSfcWCVnKoBJVQigrM5uMEth7blFIFn6pJqzA73sDcGvZ9SwJ-6r80w2QMQo4
    Mu5I0Momtt_8nPY9g>
X-ME-Received: <xmr:qUn6Zcwe9XmQw1XNJ2fOCI3WJjW9nQQr6fwck-Syfl1NBxma9lPL0OEhXU31IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledvgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvefhueduudehhedtffehffdutddugefgteeihfdvvddvhfdufefggefgfefg
    vdelnecuffhomhgrihhnpehrvggrshhonhdrthhopdduqddvtddtuddrshhonecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehhe
    ehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:qUn6ZQPR_Lf5Y75aF5eYaCwaKfOihzuNyMLk04eiZOrJYaq4ocVhNQ>
    <xmx:qUn6ZZ90df_frOZRY8I8YvX3Kl8FwAL-9pK5w7FifxEGy8LzFP4nNQ>
    <xmx:qUn6ZQUeRDGu4gQd8f7pn-TXeFGni2QBy63EQAWYNPa7SwRxMAV85Q>
    <xmx:qUn6ZafXMqIrzwu8_ERu4cE8_c8DM6gsdAO2ZySMinCFIQgiheioxA>
    <xmx:qUn6ZXEU4IIpQn_FyLvxltU7RZTQwslvH9GxisGWZvXtUELgmMp3uD9UJKI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 22:27:52 -0400 (EDT)
Date: Tue, 19 Mar 2024 19:27:38 -0700
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
Message-ID: <ZfpJmmO2h4PxGshH@boqun-archlinux>
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

Hi Alice,

I was trying to work on a patch for UserSlice::read_slice(), and I found
a few place that may need some documentation improvements. Please see
below:

On Mon, Mar 11, 2024 at 10:47:13AM +0000, Alice Ryhl wrote:
[...]
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> new file mode 100644
> index 000000000000..020f3847683f
> --- /dev/null
> +++ b/rust/kernel/uaccess.rs
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! User pointers.

Since the type is renamed as UserSlice, maybe:

//! Slices to user space memory regions.

?

> +//!
> +//! C header: [`include/linux/uaccess.h`](srctree/include/linux/uaccess.h)
> +
> +use crate::{bindings, error::code::*, error::Result};
> +use alloc::vec::Vec;
> +use core::ffi::{c_ulong, c_void};
> +
> +/// A pointer to an area in userspace memory, which can be either read-only or
> +/// read-write.
> +///
> +/// All methods on this struct are safe: attempting to read or write invalid
> +/// pointers will return `EFAULT`. Concurrent access, *including data races

Probably reword this a little bit:

"All methods on this struct are safe: attempting to read or write on bad
addresses (either out of the bound of the slice or unmapped addresses)
will return `EFAULT`."

, please see below for the reason.

> +/// to/from userspace memory*, is permitted, because fundamentally another
> +/// userspace thread/process could always be modifying memory at the same time
> +/// (in the same way that userspace Rust's [`std::io`] permits data races with
> +/// the contents of files on disk). In the presence of a race, the exact byte
> +/// values read/written are unspecified but the operation is well-defined.
> +/// Kernelspace code should validate its copy of data after completing a read,
> +/// and not expect that multiple reads of the same address will return the same
> +/// value.
> +///
> +/// These APIs are designed to make it difficult to accidentally write TOCTOU
> +/// (time-of-check to time-of-use) bugs. Every time a memory location is read,
> +/// the reader's position is advanced by the read length and the next read will
> +/// start from there. This helps prevent accidentally reading the same location
> +/// twice and causing a TOCTOU bug.
> +///
> +/// Creating a [`UserSliceReader`] and/or [`UserSliceWriter`] consumes the
> +/// `UserSlice`, helping ensure that there aren't multiple readers or writers to
> +/// the same location.
> +///
> +/// If double-fetching a memory location is necessary for some reason, then that
> +/// is done by creating multiple readers to the same memory location, e.g. using
> +/// [`clone_reader`].
> +///

[...]

> +    /// Reads raw data from the user slice into a raw kernel buffer.
> +    ///
> +    /// Fails with `EFAULT` if the read encounters a page fault.

Technically, this is not correct, since normal page faults can happen
during copy_from_user() (for example, userspace memory gets swapped). So
returning `EFAULT` really means the read happens on a bad address, which
also matches `EFAULT`'s definition:

	EFAULT          Bad address (POSIX.1-2001).

so maybe reword this and the similar ones below into something like:

	/// Fails with `EFAULT` if the read happens on a bad address.

Otherwise, people may think that this function just abort whenever there
is a page fault. Thoughts?

Regards,
Boqun

> +    ///
> +    /// # Safety
> +    ///
> +    /// The `out` pointer must be valid for writing `len` bytes.
> +    pub unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result {
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
[...]

