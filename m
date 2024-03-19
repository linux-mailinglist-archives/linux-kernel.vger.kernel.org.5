Return-Path: <linux-kernel+bounces-108067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44F188057D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1B71F23281
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004313BBC0;
	Tue, 19 Mar 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWv7ep4E"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD93B289;
	Tue, 19 Mar 2024 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876789; cv=none; b=n5nkBqaxlcdXDLs/dUb1q8dUjsycdsCjjwlPei+nmgGQwzq10kLlARwXLafu85nRAjXHBrInwzMtfmnN5qllh5czLLrMxhdOkIlQFzFZbbKmwvMjthcQb+BMlRsHPINcAXa6CR0G5SiIGtyjs1j8IgETZlMd9ieoJNJsYVZGAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876789; c=relaxed/simple;
	bh=4rFd3TVErriJNhhMqeXGwN0oupdCKObtCaZ2O17N7qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/XbC9HubXwU7V6cF8bjLUCwZvqGkdZf0bvFptn3KK128xFf0386/hp0nmqYYKYUkap1DsTmrUNo8Knkn/ZeIkaSQbYp1wDJKjd7MhlaSrglBpeO9CclLqWoX+Ck0u6v4Fcu/mkH757iVj+EjsjmHQDE+rkhV95d+5wfpvB0MsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWv7ep4E; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so4768419276.0;
        Tue, 19 Mar 2024 12:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710876786; x=1711481586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYOLOG9hKOFqz5xSRG6U5vM/st2PrJ7TeyrVBhptWm8=;
        b=fWv7ep4EoFUgpJJ+fPoZcdGGmwjcJTpWd3SgoK3V/DJxMbhdI9Z8eyX2kiBusBZnew
         1T/cZQv614spd6VEpMCvam6XLewbMBaowV5g6jJg7/d3uNar30NyN6JJSXbZ0kHLnf23
         SXydERphui/JQ6m6h1VsNIoFyDkvNyMzOsTCljh0Qvp6ukYdzB+BUPqYoKhAtPH8tFru
         CX1JLcojzycBlq8eg+eOY6EeOk0EeZZnrnJiUHDeTPkxsdAjZ+FQCy8iIY0g3ZHKTOlQ
         YqXmYpc7rn8pDBL8bnqYhe//yZKkOkCZvuKDZvlujdkzMHpLvaEVtdTQoLu+lvezIK3c
         +wOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710876786; x=1711481586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYOLOG9hKOFqz5xSRG6U5vM/st2PrJ7TeyrVBhptWm8=;
        b=eAQW3YgfRelddAQr7l43JIcXacrZK0AfEtGITXsogxGYRqfsLMQ5ZBldY6MmuA8Mde
         Nvp2OV7Kyp+l4hvHdmdxkDe7fszhwx5KYhceuNYFbV5zM+uUx1/BLTHBdd6tt+sXyuj6
         /pocqvB+g0clArjY6OkajhPLSXhUXd+qT69orfVDElIXLFNpDNubqcEZPbqywf/f7pI2
         AH8ZPzcGVJKR+vylkIfnXdgmdES+CMrqh2PR/zhIyv1CFhOsweiFbj1rf8wrOTdOJ3yL
         dErWvPf9B5pHrdA66VwxQgAP87xmDe1YPvOQyzNG7k3makyt5eEPDWxEvhESCPl9kBwX
         eBBg==
X-Forwarded-Encrypted: i=1; AJvYcCVKKhXuPc+yn7Oc2Sy14BODWAKXswE3BhfnSXEUwW1xiO+jZ/o/+d76y707OgbsbQuCtbl0N6Lm4sEbkkP9C6oE0BzdTAGbLq4pyiPgr3Le5d0H/cHb8ESYIBE1sMQ3Ht4zmwqXLqNLZ9tVEl8=
X-Gm-Message-State: AOJu0YzySy1yeV/351sxyoweZMJgqt955A6IfRN/SP6qleLgSRwroaFr
	oLLrAAB5cApuNVrq7xkDhaQSIb94pblGCpnLiO3r83w2NLBrDmrH
X-Google-Smtp-Source: AGHT+IGyhzzuzo2fbeyEEutYpQHNHgNytYw/2oxy6RUhbTVX4Hwu18JQfDCF7UAcyT+VipOhCoHWnw==
X-Received: by 2002:a25:9388:0:b0:dcd:b034:b504 with SMTP id a8-20020a259388000000b00dcdb034b504mr2781428ybm.27.1710876786538;
        Tue, 19 Mar 2024 12:33:06 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id bv12-20020a05622a0a0c00b00430ef755b74sm639052qtb.27.2024.03.19.12.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 12:33:05 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id EC3721200032;
	Tue, 19 Mar 2024 15:33:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 19 Mar 2024 15:33:04 -0400
X-ME-Sender: <xms:cOj5ZaeNtfRqJ31XFlPmNBihefK5ralnIyI4l2-SuLTRbTDUOa0UXw>
    <xme:cOj5ZUN2e_7F7Ck0Vb3wdj0l2iji2PNKjvwSSU691meFAnKDdJzSSi1Ve05Itdgjz
    2BfKkz0lrEg2qsaQg>
X-ME-Received: <xmr:cOj5Zbjk9V1LN8i6nlmCwER0m48OJ3cEZyeyIyaD-68clj3PgNSYAkY5JbgSqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:cOj5ZX8es5ueJWYzJS2c4l8w4Cx97jRvKcBnKcnH8UeLO4OAfwQ3uQ>
    <xmx:cOj5ZWvaAbQLbP_B4xBZk3OSPeTvQ_lJpQesjzUsezIs26gfAFesAw>
    <xmx:cOj5ZeG9kPTlrIACgELr6k3T-Ju_aa0i3K19yb9wq5JQmkMd1Ui_iQ>
    <xmx:cOj5ZVOQQsgo9kKrOmSZ_c0k-73-fI7UeibNRC5hHdnbcYAwEgDpdw>
    <xmx:cOj5Ze3PlhOc3tEhd3tg-atBEmoj3-AtKhnv7FTFsDJrIpo6AWJ1ZA5YtuA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 15:33:03 -0400 (EDT)
Date: Tue, 19 Mar 2024 12:32:50 -0700
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
Subject: Re: [PATCH v3 3/4] rust: uaccess: add typed accessors for userspace
 pointers
Message-ID: <ZfnoYoki--zy2Qq0@boqun-archlinux>
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
 <20240311-alice-mm-v3-3-cdf7b3a2049c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311-alice-mm-v3-3-cdf7b3a2049c@google.com>

On Mon, Mar 11, 2024 at 10:47:15AM +0000, Alice Ryhl wrote:
> Add safe methods for reading and writing Rust values to and from
> userspace pointers.
> 
> The C methods for copying to/from userspace use a function called
> `check_object_size` to verify that the kernel pointer is not dangling.
> However, this check is skipped when the length is a compile-time
> constant, with the assumption that such cases trivially have a correct
> kernel pointer.
> 
> In this patch, we apply the same optimization to the typed accessors.
> For both methods, the size of the operation is known at compile time to
> be size_of of the type being read or written. Since the C side doesn't
> provide a variant that skips only this check, we create custom helpers
> for this purpose.
> 
> The majority of reads and writes to userspace pointers in the Rust
> Binder driver uses these accessor methods. Benchmarking has found that
> skipping the `check_object_size` check makes a big difference for the
> cases being skipped here. (And that the check doesn't make a difference
> for the cases that use the raw read/write methods.)
> 
> This code is based on something that was originally written by Wedson on
> the old rust branch. It was modified by Alice to skip the
> `check_object_size` check, and to update various comments, including the
> notes about kernel pointers in `WritableToBytes`.
> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  rust/kernel/types.rs   | 67 ++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/uaccess.rs | 75 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 141 insertions(+), 1 deletion(-)
[...]

