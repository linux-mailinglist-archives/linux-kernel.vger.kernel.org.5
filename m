Return-Path: <linux-kernel+bounces-121764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4045388ED57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640611C2B0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C51153506;
	Wed, 27 Mar 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sjealq06"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F614F13F;
	Wed, 27 Mar 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561830; cv=none; b=X4uwr7aTq0cU6he8x6yfnHhlDfsMAwYBWdxaEo+BqQ346iyDlY2lI7xoJcuzNTqRmnDOPZ4N2o0EZSUfWwtuF5Ewb/Ht5pWceLB5345Uv2owHLW/IMq79l5NyG0Ea2pSOOLGFRnsCWQ8yt1NmgUJeSDR3PtoJDk/iWwMqottr68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561830; c=relaxed/simple;
	bh=jSrI8f+0WHime70CtD6JWOJKTtwPj8gpVVqn8XzW2rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnQe7KCxuVZ0zeM8D5+O0anbUq6RfdUYrN94N692IdlrnSG5WotFyraRyo8qqfzcqZlD22KrfHER7g9DGXEqbNX5zZ06daYP0b4gA6D5D0DDr65VYKpfVNH+9Z3V1oTMR3NjtY3TEehr/siXeCnxAUgB1qwnQSFH/h97nQsZ0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sjealq06; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c3ae8fa863so82611b6e.2;
        Wed, 27 Mar 2024 10:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711561828; x=1712166628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68jA08xSlThbpLPscVbPB/44K2PEdU1UR7hQ+UQDb/Y=;
        b=Sjealq06oRsqc//ZM3n1C85TI9dIgMH74466PITgpaiz+q8i/67syPja3WWCci0G49
         sflwhxaDZ/UGuRNqBXzaag7trw42xtQ9PbmLDaKxiD2EYUla6CMeBF0zZUqY8/v63PZe
         RxMPayeHYUaCRA8sXHRcKe3I6rUTcVc1ZpQPriHlOpTy273nI6MRaSAfUrwIzVS3uEjV
         T7z1Xbh+VNcGUS9SoleoAmVfUKnDuRk1X+kbm65Mar748DetVM9vptNPbuhwT47mYUXr
         XGyBefjy4DiqnBZZBkKFIDMME6nRhD2Hdv2CFu5wgS5Md+Q7/I+XPSRuoAHZGXbhUKo5
         2tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711561828; x=1712166628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68jA08xSlThbpLPscVbPB/44K2PEdU1UR7hQ+UQDb/Y=;
        b=aClgR4WNXvo0P9Tq9NvbXASDRqNnqIp/7awqQ78FVTDXxEQaCfDm2MK+L4/1XQaGkL
         9xiERcipwtKZdRv2bV6UNaIYcK317Yp1U4yuPkqJGXbcB0h7H/N8qEYLxMEzQ9G92e+v
         tvyPTHED52oD+TlpmFG79tGg/VOS8/tmptmr1Iyo5zQ/e4A8Hr1BvTw1bkydigwTiqxI
         tkUw3kSnPaTAWl0nPOUVamVrKlLTyy5SBmg9cJc1X/bHV5r6faq8rBfrfvYdrVXLEF2q
         Myws1rZvYmwtJts30iSePBqBRERExr8LlaHf/O6HfrIpv1TNc0YZkBzs2u5WdmW1qkWz
         tE8g==
X-Forwarded-Encrypted: i=1; AJvYcCXlEfx4ZItxS/FCI09mkD22FnDHLPVDIkpWuB/Tc0hCBuEqIzoBVACWO4G4rJlBKLO8eLQYesjGn2tmL8MOANR4Je4vwAaGGswnDV1P
X-Gm-Message-State: AOJu0YxC4wDbMDGyCyG/zsyrQ39RUA80ASRaQlTSJHHhC7ko/mGqaNmq
	60+UzJ4Lx5hR019hQcARQHYj800pH9a19uLs8bX+6SvDumiAdskR
X-Google-Smtp-Source: AGHT+IHtH7OmVncncj8pvfBW2eOV/vPtnSTY5ldt2l137sW1ZTpwfP1mlTS9uZ9CtCKxCPOxbf3yGQ==
X-Received: by 2002:a05:6808:15a6:b0:3c3:7a97:3de4 with SMTP id t38-20020a05680815a600b003c37a973de4mr653528oiw.15.1711561828290;
        Wed, 27 Mar 2024 10:50:28 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id i5-20020ac813c5000000b004312a7b4715sm4954354qtj.88.2024.03.27.10.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 10:50:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 2B60C1200066;
	Wed, 27 Mar 2024 13:50:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 13:50:27 -0400
X-ME-Sender: <xms:YlwEZnKWHSLocMaTYZ0NcG7xQ__mQU0V4AmbDeZqPMNL0YSt1ctRPQ>
    <xme:YlwEZrKW0fDF4dEBc2E4g5irTQ8E0fWCZcyG5jk_vjWDNrJgTelyAkdnlx6DTyOY_
    P0D4_Rt81jwyQDKqQ>
X-ME-Received: <xmr:YlwEZvttGRbBEc3POC6dYLmjObOQcPczA0Hgi5QkZOcbtoiulyRAL6Db3c02mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:YlwEZgbC6pNRjosKm4jByXOIX9_f0KU49Ecs9TeiSD8Ae1_SjPbpNA>
    <xmx:YlwEZubEETNseIgHb1Yy_W37fbJNgrH7H7JLi5OawxxC86MiPesKhQ>
    <xmx:YlwEZkAWZi75nlPiuNjvKp2_JNRBXwb9UXi-gOhtcI16BXnLMxRxog>
    <xmx:YlwEZsaKEu-wX5naF8_K1PaJmfKspM4d-GF0fifI_ZfplP8U9FMOSQ>
    <xmx:Y1wEZgss17AahhJdH73U5Vr0gzbXWGoo1ok77QpKmNXuiq9X1o_XKO9WUT4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 13:50:25 -0400 (EDT)
Date: Wed, 27 Mar 2024 10:49:49 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	Heghedus Razvan <heghedus.razvan@protonmail.com>,
	Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 3/5] rust: time: Introduce clock reading framework
Message-ID: <ZgRcPd8nA3GQILmr@boqun-archlinux>
References: <20240324223339.971934-1-boqun.feng@gmail.com>
 <20240324223339.971934-4-boqun.feng@gmail.com>
 <c2XJe4xCqT5WrHu9XZKQ03ggEZLwd2KBuSBb9Onivny9v7fqKBkm1aywmztjiDyuLKqr2Igt_6XUJiuArLl9JVwq0xa4gKfocP2H5YZDrFk=@proton.me>
 <ZgMfsaiOlA87PAUf@boqun-archlinux>
 <15DXPOXjBar-JYHVrrgVXI_f3BF5JenfeXEmmxgra6my42Ot9O9Wrc-nc-0O13C5EFTnm0SDac1Muau15mHLmb4So2292uALNSwXKoK75FQ=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15DXPOXjBar-JYHVrrgVXI_f3BF5JenfeXEmmxgra6my42Ot9O9Wrc-nc-0O13C5EFTnm0SDac1Muau15mHLmb4So2292uALNSwXKoK75FQ=@proton.me>

On Wed, Mar 27, 2024 at 12:50:50PM +0000, Benno Lossin wrote:
> On 26.03.24 20:19, Boqun Feng wrote:
> > On Tue, Mar 26, 2024 at 05:00:39PM +0000, Benno Lossin wrote:
> >> On 24.03.24 23:33, Boqun Feng wrote:
> >>> To make sure Rust code doesn't mix timestamps from different clocks, a
> >>> type safe clock reading framework is introduced. It includes:
> >>>
> >>> * A `Clock` trait that represents different clocks, to read a particular
> >>>    clock, one needs implement the `Clock::now()` function.
> >>>
> >>> * A `Instant<Clock>` type that represents timestamps of different
> >>>    clocks, whose implementation is just a `ktime_t`, so all the
> >>>    calculation on `ktime_t` should apply to it as well.
> >>>
> >>> Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> >>> Signed-off-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> >>> Co-developed-by: Asahi Lina <lina@asahilina.net>
> >>> Signed-off-by: Asahi Lina <lina@asahilina.net>
> >>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> >>> ---
> >>>   rust/kernel/time.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++
> >>>   1 file changed, 49 insertions(+)
> >>>
> >>> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> >>> index b238b3a4e899..0f9f5605ed48 100644
> >>> --- a/rust/kernel/time.rs
> >>> +++ b/rust/kernel/time.rs
> >>> @@ -6,6 +6,9 @@
> >>>   //! have been ported or wrapped for usage by Rust code in the kernel.
> >>>   //!
> >>>   //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
> >>> +//! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
> >>> +
> >>> +use core::marker::PhantomData;
> >>>
> >>>   /// The number of nanoseconds per millisecond.
> >>>   pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
> >>> @@ -64,3 +67,49 @@ pub fn to_ns(self) -> i64 {
> >>>           self.inner
> >>>       }
> >>>   }
> >>> +
> >>> +/// Represents a clock, that is, a unique time source and it can be queried for the current time.
> >>> +pub trait Clock: Sized {
> >>> +    /// Returns the current time for this clock.
> >>> +    fn now() -> Instant<Self>;
> >>> +}
> >>> +
> >>> +/// Marker trait for clock sources that are guaranteed to be monotonic.
> >>> +pub trait Monotonic {}
> >>
> >> Why is this trait not an extension of `Clock`?
> >>
> > 
> > This was carried over from the old version, for myself, it doesn't make
> > much difference between:
> > 
> > 	trait A { .. }
> > 	trait B { .. }
> > 
> > 	impl<T: A + B> ...
> > 
> > vs
> > 
> > 	trait A { .. }
> > 	trait B: A { .. }
> > 
> > 	impl<T: B> ...
> > 
> > hence I kept it as it is, but yes, it a `Monotonic` *`Clock`*, so I will
> > change it in the next version.
> 
> I think it would also make sense to rename it to `MonotonicClock`.
> 
> > 
> >>> +
> >>> +/// A timestamp of a given [`Clock`]
> >>
> >> Missing '.'.
> >>
> > 
> > Fixed locally.
> > 
> >>> +#[repr(transparent)]
> >>> +#[derive(Debug)]
> >>> +pub struct Instant<T: Clock> {
> >>> +    inner: bindings::ktime_t,
> >>> +    clock: PhantomData<T>,
> >>> +}
> >>> +
> >>> +impl<T: Clock> Clone for Instant<T> {
> >>> +    fn clone(&self) -> Self {
> >>> +        *self
> >>> +    }
> >>> +}
> >>> +
> >>> +impl<T: Clock> Copy for Instant<T> {}
> >>> +
> >>> +impl<T: Clock> Instant<T> {
> >>> +    fn new(ktime: bindings::ktime_t) -> Self {
> >>
> >> When compiling, this function is marked as dead-code in this patch.
> >>
> > 
> > Hmm... I cannot trigger any compile errors with this patch. If you see
> > an error, could you share the build command? It's not a `pub` function
> > though.
> 
> I created a fresh config using `menuconfig` and enabled CONFIG_RUST.
> Then I get this error:
> 
>     error: associated function `new` is never used
>       --> rust/kernel/time.rs:97:8
>        |
>     96 | impl<T: Clock> Instant<T> {
>        | ------------------------- associated function in this implementation
>     97 |     fn new(ktime: bindings::ktime_t) -> Self {
>        |        ^^^
>        |
>        = note: `-D dead-code` implied by `-D warnings`
>        = help: to override `-D warnings` add `#[allow(dead_code)]`
>     
>     error: aborting due to 1 previous error
> 
> Note that the error vanishes in the next patch, since there you do have
> a user for `new`.
> 

Seems I didn't select CONFIG_WERROR=y, so I missed it as a warning.
and I can hit it now with that config. Will fix it in the next version.
Thanks!

Regards

> -- 
> Cheers,
> Benno

