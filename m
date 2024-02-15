Return-Path: <linux-kernel+bounces-67331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCA38569FF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FDB284F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D0C135A52;
	Thu, 15 Feb 2024 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edPh7iGQ"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19639FFA;
	Thu, 15 Feb 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015918; cv=none; b=rbj8jlnjnp5cvUHO+GKmQYI7Yfn+f1OoI63sP/0d7ebGX/UaQdnpBrVBVE19N7yAhIxH8xhY0j3GWsEQ976LzGYuhF2O9z0UxwGfWFcue5wMrYkk8pM44Rdr7vl7sCL+WaO1gz4lPG+y4atw+snGKZI6N7aA4Uv16necFfiHHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015918; c=relaxed/simple;
	bh=bIb87f0ha+k0rSp3f5fOXxGzlX1ygs8vIwmMGPt3xRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbSME0XQaoyXvF7HK+aiySvxO173omWxXJCCy/y7piNxlt0+mS+7yuurbHXXxqY/m3T5NGX+hLZn7LpkOqcJtpwrFrPgt4i9ficCTR9mlBH0eV4qLhBC3tRpRtNMvE1trwt9czRCmdPH4BmHyGvB/vxbZs+DpnegXX8i+sferKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edPh7iGQ; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5961a2726aaso589096eaf.0;
        Thu, 15 Feb 2024 08:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708015916; x=1708620716; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=durVeKI5gvuv8IHAPsa9p6xinXAW6bhXjTGZ7TLW0Uc=;
        b=edPh7iGQPnSZmIOk5TWP4WT6pH3ygZrPVf0Ikr8uEUOWhFDo3Vq2WCD1BPLDRqAQDb
         y3BubifrdJZJNQytky8Yrsn4L3W8MoNIrKHRCbKvBjV1MWtfHFvt3OLtgUccfOLmJkBD
         XsLHL2AXQAG9soX6nFLS4O19jLyfzEPmN7JwrVHzAIq6H1qhrhoHWvT/HGqtw3SwzOSJ
         o8II1qWimBdni5snwyF8GJtD6/oYS3Ivf2MBFm1hdFf+1CiICYmz8bHaRhHaQDKon5Ug
         i2QSDSli/vdJ51276PpIPIukHBZEYa+i68dDdxGex8OebZVnVcmV1ajNO3kWKdg7Wjyk
         WSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708015916; x=1708620716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=durVeKI5gvuv8IHAPsa9p6xinXAW6bhXjTGZ7TLW0Uc=;
        b=qHJ2GsUYw/ivq6zWUSDCTccEBTKvYPi8L90qKeafLGcxBidFOOVKy4ncb0+MlFxs9n
         c0iFJ1VqYnzN/wCwH1vCE7qRzkAcEMd58yHMK8CJxa6ySz1L1rbyIGD5Dlx5nWNqDP8a
         06c13y9PNjIx8/jb124csOoI1sbiVtgC7jGSQXN+EGjpUUMRkPX7ZAABDkvgLAPo4ntE
         bKJZBgOI13hyDPmCzDyy5rLefg814K9fRLJULshdRlmF2bYnESGvdn28ynGdpSc0Zd7t
         w6pWxk0bL+hGN4qdpEJlNAwjQ3uOPQ5ZulbblNbhbAd57svJZzruzPSU9DlzJwKcHGXL
         ikNA==
X-Forwarded-Encrypted: i=1; AJvYcCWxVYhJoCgBmR7lsj31iOnGwwpLbscVa8ylB5L6Hrl1bR/yB0REFN788jpiPKwG0igogY3L6GJDfz4MLqgnJ84664MMjjj+EZlxBCRslsz7o/BGzmU4GKQB9M4cMRlgbZmpN6R0ZC/IFMosj4Q=
X-Gm-Message-State: AOJu0Yx9tGG44eKeNqVyd4yigjso9VQ8rvM6W/5YgSfMnwQv8UeB10mR
	QLICH2ruxiqGBDoRJn7xGm1NI3EFjmHLF0tO8rGG54mEs/wj7U98MPylbisa
X-Google-Smtp-Source: AGHT+IHZesbuT3/Li6hgbi52LevzFXLA7HIbT4zp86JZJYkBMC0NgAGBi0PowxYYCctrC6zEiDVr5A==
X-Received: by 2002:a05:6358:578e:b0:176:8263:9a71 with SMTP id m14-20020a056358578e00b0017682639a71mr2463765rwf.13.1708015915729;
        Thu, 15 Feb 2024 08:51:55 -0800 (PST)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id k16-20020ac84790000000b0042c774f882asm714987qtq.73.2024.02.15.08.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 08:51:55 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id C8EF71200043;
	Thu, 15 Feb 2024 11:51:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Feb 2024 11:51:54 -0500
X-ME-Sender: <xms:KkHOZSslqJ1eJNIX9C3efVtKu--lGadGvi_lEww3LO-0QuR2kTnNwg>
    <xme:KkHOZXeRlgdm7sj8mzTc2ub5HcypOkzqmcsEUktK5zyRNHYcJG4GkanPTqLGjjBko
    YeToYlnS87vd7cRVg>
X-ME-Received: <xmr:KkHOZdwx4cSBWdPGW6LT6vw0zTTQS6iHs5wRjjelddj5AtFyVc4CzfZPLbk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffg
    geelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:KkHOZdNOYSoj1ylfPqGKxjYGIQZuO2T89UR2wd2QAoZbw8qq-jtc3A>
    <xmx:KkHOZS_mB1nNS8VT5WhUD7nJONcquSlmVNEIKKr5NxV6JUvdUx7WLA>
    <xmx:KkHOZVXYZXfjBIU7w6js4uvqhLRG4keXZebCAhTsNxdmc-wfgfgQRg>
    <xmx:KkHOZdVnJVbErNlepq9lUrLBfW73zT6P0M4lryzVdHLMRXzn1LiwRN2hefg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 11:51:53 -0500 (EST)
Date: Thu, 15 Feb 2024 08:51:50 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Alice Ryhl <alice@ryhl.io>, Danilo Krummrich <dakr@redhat.com>,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: str: add {make,to}_{upper,lower}case() to
 CString
Message-ID: <Zc5BJvyGIXgDQ21j@boqun-archlinux>
References: <20240214172505.5044-1-dakr@redhat.com>
 <Zc0UNUGbmmBlzBAv@boqun-archlinux>
 <2d94d420-fca2-47c1-aee7-bbce7a1505cf@ryhl.io>
 <Zc1mWCBKNuLrS-tI@boqun-archlinux>
 <CAH5fLghO6Jy_hJXhRU_+eBSDHHveAvEOJA6fNkmMS9mqHvS6iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghO6Jy_hJXhRU_+eBSDHHveAvEOJA6fNkmMS9mqHvS6iQ@mail.gmail.com>

On Thu, Feb 15, 2024 at 10:38:07AM +0100, Alice Ryhl wrote:
> On Thu, Feb 15, 2024 at 2:18 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Wed, Feb 14, 2024 at 08:59:06PM +0100, Alice Ryhl wrote:
> > > On 2/14/24 20:27, Boqun Feng wrote:
> > > > On Wed, Feb 14, 2024 at 06:24:10PM +0100, Danilo Krummrich wrote:
> > > > > --- a/rust/kernel/str.rs
> > > > > +++ b/rust/kernel/str.rs
> > > > > @@ -5,7 +5,7 @@
> > > > >   use alloc::alloc::AllocError;
> > > > >   use alloc::vec::Vec;
> > > > >   use core::fmt::{self, Write};
> > > > > -use core::ops::{self, Deref, Index};
> > > > > +use core::ops::{self, Deref, DerefMut, Index};
> > > > >   use crate::{
> > > > >       bindings,
> > > > > @@ -143,6 +143,19 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
> > > > >           unsafe { core::mem::transmute(bytes) }
> > > > >       }
> > > > > +    /// Creates a mutable [`CStr`] from a `[u8]` without performing any
> > > > > +    /// additional checks.
> > > > > +    ///
> > > > > +    /// # Safety
> > > > > +    ///
> > > > > +    /// `bytes` *must* end with a `NUL` byte, and should only have a single
> > > > > +    /// `NUL` byte (or the string will be truncated).
> > > > > +    #[inline]
> > > > > +    pub const unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
> > > > > +        // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
> > > > > +        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
> > > >
> > > > First `.cast::<[u8]>().cast::<CStr>()` is preferred than `as`. Besides,
> > > > I think the dereference (or reborrow) is only safe if `CStr` is
> > > > `#[repr(transparent)]. I.e.
> > > >
> > > >     #[repr(transparent)]
> > > >     pub struct CStr([u8]);
> > > >
> > > > with that you can implement the function as (you can still use `cast()`
> > > > implementation, but I sometimes find `transmute` is more simple).
> > > >
> > > >      pub const unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
> > > >     // SAFETY: `CStr` is transparent to `[u8]`, so the transmute is
> > > >     // safe to do, and per the function safety requirement, `bytes`
> > > >     // is a valid `CStr`.
> > > >     unsafe { core::mem::transmute(bytes) }
> > > >      }
> > > >
> > > > but this is just my thought, better wait for others' feedback as well.
> > >
> > > Transmuting references is generally frowned upon. It's better to use a
> > > pointer cast.
> > >
> >
> > Ok, but honestly, I don't think the pointer casting is better ;-) What
> > wants to be done here is simply converting a `&mut [u8]` to `&mut CStr`,
> > adding two levels of pointer casting is kinda noise. (Also
> > `from_bytes_with_nul` uses `transmute` as well).
> 
> Here's my logic for preferring pointer casts: Transmute raises
> questions about the layout of fat pointers, whereas pointer casts are
> obviously okay.
> 

But in this case, eventually you need to worry about fat pointer layout
when you dereference the `*mut CStr`, right? In other words, the
dereference is only safe if `*mut [u8]` has the same fat pointer layout
as `*mut CStr`. I prefer to transmute here because it's a newtype
paradigm, and transmute kinda makes that clear.

Regards,
Boqun

> Alice

