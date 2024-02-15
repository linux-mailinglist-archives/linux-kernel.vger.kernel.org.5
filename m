Return-Path: <linux-kernel+bounces-66219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6568558A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36361C225B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A94137E;
	Thu, 15 Feb 2024 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoW4vett"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF1EC7;
	Thu, 15 Feb 2024 01:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707959903; cv=none; b=Sw+FSq8zk7gSY4tn6YLDjecLDtvmNZvUtWYbfxr/VFAtA8B+eMpmvmsHOq+29ZSB2a7EDeTae2kdVotvmp8sq90BI1KrBAA395nmWnE3OwbcpchTZpMRQ3mryHm9jHUsaX+nwEQCiqKIsQVUYmNxapZWcN7bbmjA6xk674BDOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707959903; c=relaxed/simple;
	bh=tnxO7okG/QnTvg85xQhfypbjQ/GBXvumu4CdW9QwfWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJqVQH0OzIwE/9EEE5bH3BowH9tl2YgJ9qM3M8rzzCmKGtmDUQIGDDhBsloLAzZyFMbyQqdrRfdrfmEiAj6Ciw+7dP0VZmJqK9+5kAiZXKfrm2EAJvUbzgAO4syV68mYTZlG2aqS99L9dTag2mEzS+w4KdXwq7MDBlB8sEcpS7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoW4vett; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7872bc61fccso21032185a.1;
        Wed, 14 Feb 2024 17:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707959900; x=1708564700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XscNX1S4OAZLTrAysDt47+uc78vf7AUGIPxwxeCZN6Y=;
        b=OoW4vettQDgnCSkTPTy1NdNqHhxQ1Kc/plXJCpdGeQsJx+6D6a5EUlBb9qeLDJSQ+p
         sjxjRmFoGIZuak8/WoaOyLucKfsRjFgdlm3FVzMUSUXFa+hoO/rcNBny5WzwU/i7HKNS
         Fux7w4cQ0ojWA2DXSPyh/KaUxBhaCMij8rdtvHY6RByG/h2Y1i5qWie8vOjFnA3alaC0
         vNoUu+IydVKB4tNxJ0OnLIcatut9HpbS+A/+eZ2/MzWwSjNDGdYV326S5e0v2tmd1dnQ
         Hf3kA49UxpaVWa8E+I1CKOksSv15/vlnAyVXkeqIKDAmq1yW7AY95C3wykYcIuvpR51M
         wHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707959900; x=1708564700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XscNX1S4OAZLTrAysDt47+uc78vf7AUGIPxwxeCZN6Y=;
        b=NViuAzyLNx4P+ZgdvR7YbZbIxag4yvL4oi2pi3iugnd/kP3HwJn7jEIFzRiKKpOS/C
         7s7GuZ+/VZokGrylP6RioXZAacMBubU3A2Mav3KD8w2dcVdnM+N4j9mYa+6smZ85JdEp
         FzQtW9eoYwmoiD2XPqVyrPhWqQFCdrZQVCk3XKBYT84KfWzMn/HgCmoDMbKOb7Z8xwn3
         B7dICSq5FOufxIrJVgf5hYZWE3l8wH7ltZDSLS3a/WKIlrZaRdPO7MjQux7d4i/PvxPb
         c/bmeFZs6jP3JuchbsQyNEmUPewYV3UaCIK4nWQNrOL1vDvmNz1Wil3K0YFiNzU2FwIg
         kv3w==
X-Forwarded-Encrypted: i=1; AJvYcCU4nvhpRqlVBdsxN4b7YIwj/1qlchVA1d+Z6Be+GTeO35YzQ655AHyBl43Ck5ir7M9uxr2d2ANy3Z220vgCvKlKMfsDit8TmQbkJJ5I9u4n4Ry0SfAmo4PZ0If2ke7uF4m1qyi8h/jDfTzWf/4=
X-Gm-Message-State: AOJu0YxEEUBqVZxXRcbiwMKkLFnb4vZ+iquON8xzUwdMLrnumb6LAOx+
	QZ1HnN65Tj51NzaU5as0XVr7acBecYhGn+Oqow/hDomMW6OzLI19
X-Google-Smtp-Source: AGHT+IER3duMv8mX/TwlWcMzAowYkEMbpcBDzR4ElI9qYlUcBBDhEuYgW6qr80o23C7jHxThW3GzMw==
X-Received: by 2002:a0c:b71a:0:b0:68f:e08:ee96 with SMTP id t26-20020a0cb71a000000b0068f0e08ee96mr351557qvd.60.1707959900544;
        Wed, 14 Feb 2024 17:18:20 -0800 (PST)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id mf18-20020a0562145d9200b0068c39b7a7cfsm145390qvb.12.2024.02.14.17.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:18:19 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id EFEF21200043;
	Wed, 14 Feb 2024 20:18:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 14 Feb 2024 20:18:18 -0500
X-ME-Sender: <xms:WmbNZd3FFUUAjhmGtL3Eujym7c5eSMsdr_qk09vXUvttK9qpUoYQtw>
    <xme:WmbNZUHpu0-Dj_2_86UOEIu7BNYjhf16RaYzCQU6nY9qUcc1XOONvLqqdqGYfr7pn
    l8ucIJFoROs1Q9BMw>
X-ME-Received: <xmr:WmbNZd4O3yPehAW3wyNtKAkagWPjMjxTyG13q4sbgHyWu9c2zMEeo8CU91A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepjeetffdtgfeuhefghfektddttdegtedvueekteeugefghfehffefueeludei
    feevnecuffhomhgrihhnpeiiuhhlihhptghhrghtrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqh
    hunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:WmbNZa004CpTieltdzoWGAmnivnkxxk3ADPv8Frya5Nkcnp14HHt0w>
    <xmx:WmbNZQGgiYLWqMLDZIEI4D24uyBgCbi_Ft7PF2EFoK-B4sq-Sobnqg>
    <xmx:WmbNZb-iLBptq0H7Qa9Xp_zYnD2ht2r_KZQWJgZWM_eUSKqZxhMQ7Q>
    <xmx:WmbNZXffdQwgixAMrQxB9ught3QeoSjQVAdM3uLemln3AodZ6ffiX7qJsSs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 20:18:18 -0500 (EST)
Date: Wed, 14 Feb 2024 17:18:16 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <alice@ryhl.io>
Cc: Danilo Krummrich <dakr@redhat.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: str: add {make,to}_{upper,lower}case() to
 CString
Message-ID: <Zc1mWCBKNuLrS-tI@boqun-archlinux>
References: <20240214172505.5044-1-dakr@redhat.com>
 <Zc0UNUGbmmBlzBAv@boqun-archlinux>
 <2d94d420-fca2-47c1-aee7-bbce7a1505cf@ryhl.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d94d420-fca2-47c1-aee7-bbce7a1505cf@ryhl.io>

On Wed, Feb 14, 2024 at 08:59:06PM +0100, Alice Ryhl wrote:
> On 2/14/24 20:27, Boqun Feng wrote:
> > On Wed, Feb 14, 2024 at 06:24:10PM +0100, Danilo Krummrich wrote:
> > > Add functions to convert a CString to upper- / lowercase, either
> > > in-place or by creating a copy of the original CString.
> > > 
> > > Naming followes the one from the Rust stdlib, where functions starting
> > > with 'to' create a copy and functions starting with 'make' perform an
> > > in-place conversion.
> > > 
> > > This is required by the Nova project (GSP only Rust successor of
> > > Nouveau) to convert stringified enum values (representing different GPU
> > > chipsets) to strings in order to generate the corresponding firmware
> > > paths. See also [1].
> > > 
> > > [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/String.20manipulation.20in.20kernel.20Rust
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > > ---
> > > Changes in V3:
> > >    - add an `impl DerefMut for CString`, such that these functions can be defined
> > >      for `CStr` as `&mut self` and still be called on a `CString`
> > > Changes in V2:
> > >    - expand commit message mentioning the use case
> > >    - expand function doc comments to match the ones from Rust's stdlib
> > >    - rename to_* to make_* and add the actual to_* implementations
> > > ---
> > >   rust/kernel/str.rs | 81 +++++++++++++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 80 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > > index 7d848b83add4..02d6e510b852 100644
> > > --- a/rust/kernel/str.rs
> > > +++ b/rust/kernel/str.rs
> > > @@ -5,7 +5,7 @@
> > >   use alloc::alloc::AllocError;
> > >   use alloc::vec::Vec;
> > >   use core::fmt::{self, Write};
> > > -use core::ops::{self, Deref, Index};
> > > +use core::ops::{self, Deref, DerefMut, Index};
> > >   use crate::{
> > >       bindings,
> > > @@ -143,6 +143,19 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
> > >           unsafe { core::mem::transmute(bytes) }
> > >       }
> > > +    /// Creates a mutable [`CStr`] from a `[u8]` without performing any
> > > +    /// additional checks.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// `bytes` *must* end with a `NUL` byte, and should only have a single
> > > +    /// `NUL` byte (or the string will be truncated).
> > > +    #[inline]
> > > +    pub const unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
> > > +        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
> > > +        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
> > 
> > First `.cast::<[u8]>().cast::<CStr>()` is preferred than `as`. Besides,
> > I think the dereference (or reborrow) is only safe if `CStr` is
> > `#[repr(transparent)]. I.e.
> > 
> > 	#[repr(transparent)]
> > 	pub struct CStr([u8]);
> > 
> > with that you can implement the function as (you can still use `cast()`
> > implementation, but I sometimes find `transmute` is more simple).
> > 
> >      pub const unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
> > 	// SAFETY: `CStr` is transparent to `[u8]`, so the transmute is
> > 	// safe to do, and per the function safety requirement, `bytes`
> > 	// is a valid `CStr`.
> > 	unsafe { core::mem::transmute(bytes) }
> >      }
> > 
> > but this is just my thought, better wait for others' feedback as well.
> 
> Transmuting references is generally frowned upon. It's better to use a
> pointer cast.
> 

Ok, but honestly, I don't think the pointer casting is better ;-) What
wants to be done here is simply converting a `&mut [u8]` to `&mut CStr`,
adding two levels of pointer casting is kinda noise. (Also
`from_bytes_with_nul` uses `transmute` as well).

> As for .cast() vs the `as` operator, I'm not sure you can use .cast() in
> this case since the pointers are unsized. So you might have to use `as`
> instead.
> 

You're right, that's a bit unfortunate..

Regards,
Boqun

> Alice

