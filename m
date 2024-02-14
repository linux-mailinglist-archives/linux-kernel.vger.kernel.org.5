Return-Path: <linux-kernel+bounces-65881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2661F855337
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2811C25A71
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C0313B79E;
	Wed, 14 Feb 2024 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3eWZzYN"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F6412D76E;
	Wed, 14 Feb 2024 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938978; cv=none; b=bDLOmUZXs/4iL4QZys9CALo5oI6nStJIpNegc17Eoyir216y3ty7nnYsIYmX8yPvCryzeM6hQJzQth1oxKeeZDE1TTtqibZmF0RmI53waIH69c3cWkJzUZwNTwa/wJFjc0BXvxNMDrRspFCS+whP5OUxXt/FNd/0DwLtJ1rBTjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938978; c=relaxed/simple;
	bh=Nu/AiYO0cZHPXxcq7qHdK3J+BhmArbnGSgTitnJB4/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmNSJyiQCkQ6X1HVSWqiD/x9/VWWOAJctpzm0UrrZyFEzHZK2mJFaBz5SZaqdOyl8Bb/AMf9Y8tJErayiAq2K9pxGj0Ho2OV7NN7oqOhx+5PwL2AHKBhgdTl6c7Cjh2T+LRcvA39h6rc2tL30r7Hp9q3fdhfKmigMmpaEX1mWyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3eWZzYN; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68ce2fe86e3so698266d6.3;
        Wed, 14 Feb 2024 11:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707938976; x=1708543776; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxKxd0YOf3Ety49fAv0PO6SpvuAL0dCmkIegxDtI/W8=;
        b=G3eWZzYNaS2sIh2QjBPVkSq8KmF4bCMudktCfS7HT5/N1+OcU/cT+I5YLwpEysKmZ+
         Tf1DVPxGCMCl5j2xcxkejcLK72qBt/VO/07yvk1ntX90GFJ5hUQvRlxt2ZoJu0JIgR4R
         YtgxQkpmFwPoZHWMU16BAuxdIOK5ykQa7g6mJ/3kfNgd6uSw3L9Y1G6E6kiA7lz8acNl
         hgzW+r4IwuBMXaMGSsTU+pST0QCCfzZU12AL9QIgEni/byxwDxdvV46+l7oOwf5+Ggau
         SvBvJM3aIDMGrANthisLFiXNOLtfaR30I70oPR0jya6FcL/4ePugCQE5/hMQgOlykilv
         NNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707938976; x=1708543776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxKxd0YOf3Ety49fAv0PO6SpvuAL0dCmkIegxDtI/W8=;
        b=WpCc29GUjfJFmspWqUZG2THSqkyJ3AgqTrZH6WJV29Gfflqw1uW2QrKh9CtqwL4/bC
         ewKM1ScrSTtsAm847OVANcFxvaAnCmkXuJGsUifnMvK0AvIR3Ueb4hdRf1x5NfxkC/bA
         nRkvMuvHLTMdS8GCLKf6uuXVe4uyYvBc5b3Nw9ut/xpkZmAUqfY7WNmb5gjzJbm5xCVl
         I0l3RvcgBJYWAAhxP/6rCr9RvqHGvI+TtLUi21AQauBEUPi9QRbd9lyZ0SS6aw9AjRbp
         DhIQuJvgbrQdUEsDrl/RnRYWPUFTguHKB6l3LURnqOLHikg0LdSZzk5Fwh0/6KzupjWV
         qHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZihp45Slsu+GbVCPpvvFYgCnNesDRAXdwhJUu3u2YQqOn41fx8cGX48MqNz4X0R1+XhcAINt9O1BodsT7rlbheXZgqGuCyk/diY4ZOWJ+6J3MH7TxEJaUspqe0okl22hhbyfZHp0LjBoGTus=
X-Gm-Message-State: AOJu0YyOf6E8fw3gH4On7U648YuzOrGtbXeElqz8imI2/Ndk4T4aO8OA
	S+u8/oa2byF4FTLlc0VQ2EBlUdJ817d7Ant15w9euVGYjqT2bmmJ
X-Google-Smtp-Source: AGHT+IFR+G2jABSWo8VjAzNAPcu10ITYHuaYab0euOGfRiZrRTKb/GJdEjEDdbw0PJ7e/lR17O6mkw==
X-Received: by 2002:a0c:cb0c:0:b0:68f:10bf:6ec9 with SMTP id o12-20020a0ccb0c000000b0068f10bf6ec9mr863632qvk.13.1707938975741;
        Wed, 14 Feb 2024 11:29:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVo4GFgA+hc09NEfLHstdTrSzSAKE5leRPjHoIEvGVv8+hQwzV6TnbBhi71fBYjns5hCpYrVOJxMvT9z4+L0XXLR+yQZaHk2XXcTU8Bh1gq68SzaKLNvZ27fWc4i7MztR0ZnppI+l5apDBp2HLU5pQ/w0AEFlBwMryQmjrstyHdJiF+p78xdPHQIWVyQ7v8Xb++xVjC+gNc8FKZV/+NkWwAfsBtUSr9IEAK5fheZ7mP839UUbTW1ZoMLigyV03Uube9XrJoIlqbD3+dmTdWQ6RI6rAgiXVQ7KoC+66OJMav5cDxM3jAgEhGDlKV8S0JEolPQ2hgX1uXmBXm1vLvh+o9anZdneF1ck26Vw+wGw/ycihKy6c8M95p/hO+
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d8-20020a0cf6c8000000b0068cbc630dc8sm2555319qvo.49.2024.02.14.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:29:35 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 8D2441200066;
	Wed, 14 Feb 2024 14:29:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 14 Feb 2024 14:29:34 -0500
X-ME-Sender: <xms:nhTNZVxtpzUWzm4CTVRgyfgUuZ16GiEBTgd2LXGzuMROIkarYhwVcQ>
    <xme:nhTNZVRUUCW0Hc797rQ0EBQJ2ORh6SmRVg5YgQHDdB-HfmQPJUQY_Y3wxyXZ5kA9N
    zVFwEyLsCdRGrqh7g>
X-ME-Received: <xmr:nhTNZfW3x5uUh7eVfuHhCQ4NA9ndoA38hXwoze-Z2sp24HeTiOuA-6KRA7UO4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejtefftdfgueehgffhkedttddtgeetvdeukeetueeggffhhefffeeuledu
    ieefveenucffohhmrghinhepiihulhhiphgthhgrthdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:nhTNZXjdDhQUwftC2U5qVzOtiUfru18ci223bgIVxAMwRVFC-9jiSg>
    <xmx:nhTNZXDgMVygXH49bJFVXeY9FPLynR-FUP8OD88nHKAILjsS-GBI8A>
    <xmx:nhTNZQLMB5m0YngTOTxNybbsn8q7cJ3aVZeSmI27gKaBO5ZY0JAejQ>
    <xmx:nhTNZULjEFrIzDqIU44CbbAD-NUqnfvSkUgvu2iCPRmEFr31SPyIs1JOYHg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 14:29:34 -0500 (EST)
Date: Wed, 14 Feb 2024 11:27:49 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: str: add {make,to}_{upper,lower}case() to
 CString
Message-ID: <Zc0UNUGbmmBlzBAv@boqun-archlinux>
References: <20240214172505.5044-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214172505.5044-1-dakr@redhat.com>

On Wed, Feb 14, 2024 at 06:24:10PM +0100, Danilo Krummrich wrote:
> Add functions to convert a CString to upper- / lowercase, either
> in-place or by creating a copy of the original CString.
> 
> Naming followes the one from the Rust stdlib, where functions starting
> with 'to' create a copy and functions starting with 'make' perform an
> in-place conversion.
> 
> This is required by the Nova project (GSP only Rust successor of
> Nouveau) to convert stringified enum values (representing different GPU
> chipsets) to strings in order to generate the corresponding firmware
> paths. See also [1].
> 
> [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/String.20manipulation.20in.20kernel.20Rust
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
> Changes in V3:
>   - add an `impl DerefMut for CString`, such that these functions can be defined
>     for `CStr` as `&mut self` and still be called on a `CString`
> Changes in V2:
>   - expand commit message mentioning the use case
>   - expand function doc comments to match the ones from Rust's stdlib
>   - rename to_* to make_* and add the actual to_* implementations
> ---
>  rust/kernel/str.rs | 81 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 7d848b83add4..02d6e510b852 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -5,7 +5,7 @@
>  use alloc::alloc::AllocError;
>  use alloc::vec::Vec;
>  use core::fmt::{self, Write};
> -use core::ops::{self, Deref, Index};
> +use core::ops::{self, Deref, DerefMut, Index};
>  
>  use crate::{
>      bindings,
> @@ -143,6 +143,19 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
>          unsafe { core::mem::transmute(bytes) }
>      }
>  
> +    /// Creates a mutable [`CStr`] from a `[u8]` without performing any
> +    /// additional checks.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `bytes` *must* end with a `NUL` byte, and should only have a single
> +    /// `NUL` byte (or the string will be truncated).
> +    #[inline]
> +    pub const unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
> +        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
> +        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }

First `.cast::<[u8]>().cast::<CStr>()` is preferred than `as`. Besides,
I think the dereference (or reborrow) is only safe if `CStr` is
`#[repr(transparent)]. I.e.

	#[repr(transparent)]
	pub struct CStr([u8]);

with that you can implement the function as (you can still use `cast()`
implementation, but I sometimes find `transmute` is more simple).

    pub const unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
	// SAFETY: `CStr` is transparent to `[u8]`, so the transmute is
	// safe to do, and per the function safety requirement, `bytes`
	// is a valid `CStr`.
	unsafe { core::mem::transmute(bytes) }
    }

but this is just my thought, better wait for others' feedback as well.

Regards,
Boqun

