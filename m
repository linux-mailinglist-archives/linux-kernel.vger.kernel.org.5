Return-Path: <linux-kernel+bounces-119559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4557E88CA71
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7C432480E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8781CF8D;
	Tue, 26 Mar 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX6A0oE3"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302391CAAD;
	Tue, 26 Mar 2024 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473105; cv=none; b=CsIadOWxdQ6CKBV464l3Rji7sECErCIQQkxQKNk3T/6136GNwhLg1RrSb19lBlrFcFaBPmvVU9Spc8zFZ2+06kfvN051dj1rGYlPPjg7czupKuQuQVE7uQ5E4JWZVq2DaUCrnvDAvp/UKBkOWWfrFXAGlN+rsBg1G5funLx//kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473105; c=relaxed/simple;
	bh=2H4seo235TtcNfGay7H2sbkZqoRkvg1ndzz5RqCoHR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZM4Waw/K0t4KwYHRUcRnVnm6LFlMJ9I03+CkyxT0YJsvr+nheKkx+XxbTIzPYJU/g/TH57exmPO+1uMnXtCBcxHZ3ncoE5/fewSqice3Y6IQi2TGOeWxm5Mtvkwj/Ra4/Jlz9Ucam1aOlss0xaZcQKN30rRx83HjTj7zKVi5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX6A0oE3; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-430c45ab240so33688611cf.0;
        Tue, 26 Mar 2024 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711473103; x=1712077903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgy6KTgPoHVTqXlGJ95HB7f9RHaWGhN9Lg4BvWlkQqs=;
        b=fX6A0oE3G6pUfmEBQs3ydtyTudGP6CF9ZkYk011fNUFnLttWW0Mm57yeAUVg0tS5Df
         tr5M43ghc4NijvgKtb7H5fG/dBaPd/Krjt7ZAmyPNdiHgOotWIJU9WtejKE4aeiA1wWv
         CEPea9DbXUz3pUYtmFtdqrKs9+lhL9i0MYNa5FsK4VQDpKP69eLi4qzaS6lqBBpkR+CB
         qICeb0MKQKq8U7348dMZjMjvBml+2kzy5icFK8tt/fLRDnlLmplr3sQU0GLSt+0KsLbN
         3V6/XYU5akCzZ4s/ZNfBVqSBbdcZrqdxbIGfqSj3KzkXslnK/NMgZAZ78TNat/s6tDar
         K4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711473103; x=1712077903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgy6KTgPoHVTqXlGJ95HB7f9RHaWGhN9Lg4BvWlkQqs=;
        b=auxj3Cx/kwPcL9wfhW2wuqUNQ9nDgaulYZ0essgnIHEcmHPf3nr47qi1xX6+BQLQeq
         0ZZPUuWsjdyBCKYSGUEmxG8NZeCFgWEQdXVzWU02MgbMizf/qNEMzEjHK5v7thJOc57C
         yaWOo8WuCxHEkXM+wfUKgI30Spw+ON1uOUkH+MVdletVhLEoyxKiKcWZ4nPoZjZdiRnB
         KWNnhvTpU5mViYAHx41p4D3n7862Uq5cm6UA4L4gL9JB0Lxu+4f23+UhvjYij5WA+g5m
         yLgttdkXETa44WdUcggelwUvh5v7RRCcFCGjE8UYGBkS1wSxaaqYBSVzMkbt/Sa4775Z
         kaZw==
X-Forwarded-Encrypted: i=1; AJvYcCWmQXTr+Tfw1aOvU903nuCpZoEWQ4MUe0kEvbB+15eeECR/Wczc2QogGjd9k+sbhuRFzpgaIWfbwxmyrgtfba2u/FR3RtD30P45JkuX
X-Gm-Message-State: AOJu0Yzg9L5E5YkTQZira5D+wUPrn1tugkIB+Gz2J4akgz/YbZR24e+5
	yWskNdPTLAwKjYV20aUZyMM2Gca9q7zLWTTXhwAFxhARuwrSfr43
X-Google-Smtp-Source: AGHT+IGNCJc1VsvWRQt2uXwV8nb0GH2RiXeF6dhSm7DBEJOxTsa0SxTL0nvauUxmSt8At/uKBZZZqg==
X-Received: by 2002:a05:6214:262f:b0:696:987d:7922 with SMTP id gv15-20020a056214262f00b00696987d7922mr1412880qvb.9.1711473102734;
        Tue, 26 Mar 2024 10:11:42 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id x11-20020ad4458b000000b00696a47179a1sm418788qvu.14.2024.03.26.10.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:11:42 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 7A67F1200069;
	Tue, 26 Mar 2024 13:11:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 26 Mar 2024 13:11:41 -0400
X-ME-Sender: <xms:zAEDZkXh08TLa6Zo1jOZaFQ4Xzuq_k3ReeB3WswtOOhKvzBwvpk1XQ>
    <xme:zAEDZokELfQmxxvmQlcsiHBn8wP4WD3IwWNu8-sQRAbPa5yishXRgvwmFJxQwRr2t
    Mzwj7_ZYgI5B_BIPQ>
X-ME-Received: <xmr:zAEDZoZc6lxmw2RComFkPR3pFXU3EbBAe2nRsZSaQ-Azql3fXiySo11EPFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:zAEDZjU1VeOXje7QWr0O_miWwEmwkKKFtamdiLDA0lEomiiCBnz43A>
    <xmx:zAEDZukJNZiYdpoMMb4qVNG5fxxWDFL8C3fkx2ro3T3W8FlUz8oXEw>
    <xmx:zAEDZocqLyfJ2WqBgxVNEvHyDp_QKOihMH3saCXHUOLuZdR3P0oQFg>
    <xmx:zAEDZgH3W8gSXsPtih95XHA5EeU9XEHQmDvgk6m4Qm-aszJZ8cRqQA>
    <xmx:zQEDZqlKRFBrQVsZY0r9z1uu9GRr6gItZj1UKo56NBeo-mH3DKE4mDx0AlE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 13:11:40 -0400 (EDT)
Date: Tue, 26 Mar 2024 10:11:07 -0700
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
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH 2/5] rust: time: Introduce Duration type
Message-ID: <ZgMBqzv0r98_EGGR@boqun-archlinux>
References: <20240324223339.971934-1-boqun.feng@gmail.com>
 <20240324223339.971934-3-boqun.feng@gmail.com>
 <4hYJbftgOk1JOPbJ6CfKZell6ngp8GljwIUIB1vOQvIf-7jiogG5xDtCvcMlF7cIJAdy9fO5HLQh_8ohnWNB3MAaj0xjAGeyyDowemgunOU=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4hYJbftgOk1JOPbJ6CfKZell6ngp8GljwIUIB1vOQvIf-7jiogG5xDtCvcMlF7cIJAdy9fO5HLQh_8ohnWNB3MAaj0xjAGeyyDowemgunOU=@proton.me>

On Tue, Mar 26, 2024 at 04:50:02PM +0000, Benno Lossin wrote:
> On 24.03.24 23:33, Boqun Feng wrote:> From: Alice Ryhl <aliceryhl@google.com>
> > 
> > Introduce a type representing time duration. Define our own type instead
> > of using `core::time::Duration` because in kernel C code, an i64
> > (ktime_t) is used for representing time durations, an i64 backed
> > duration type is more efficient when interacting with time APIs in C.
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > [boqun: Rename `Ktime` to `Duration`, and make it a type of durations]
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/kernel/time.rs | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> > index bbb666e64dd7..b238b3a4e899 100644
> > --- a/rust/kernel/time.rs
> > +++ b/rust/kernel/time.rs
> > @@ -7,6 +7,9 @@
> >  //!
> >  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
> > 
> > +/// The number of nanoseconds per millisecond.
> > +pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
> > +
> >  /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
> >  pub type Jiffies = core::ffi::c_ulong;
> > 
> > @@ -20,3 +23,44 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
> >      // matter what the argument is.
> >      unsafe { bindings::__msecs_to_jiffies(msecs) }
> >  }
> > +
> > +/// A time duration.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let one_second = kernel::time::Duration::new(1000_000_000);
> > +///
> > +/// // 1 second is 1000 milliseconds.
> > +/// assert_eq!(one_second.to_ms(), 1000);
> > +/// ```
> > +#[repr(transparent)]
> > +#[derive(Copy, Clone, Debug)]
> > +pub struct Duration {
> > +    inner: i64,
> 
> Why not use the name `ns` or `nanos`?
> 

Good point, I will rename it in next version.

> > +}
> > +
> > +impl Duration {
> > +    /// Creates a new duration of `ns` nanoseconds.
> > +    pub const fn new(ns: i64) -> Self {
> > +        Self { inner: ns }
> > +    }
> > +
> > +    /// Divides the number of nanoseconds by a compile-time constant.
> > +    #[inline]
> > +    fn divns_constant<const DIV: i64>(self) -> i64 {
> > +        self.to_ns() / DIV
> > +    }
> 
> I am a bit confused, why is this better than writing
> `self.to_ns() / DIV` at the callsite?
> 

Hmm.. you're right, there should be no difference I think. If there is
nothing I'm missing from Alice, I will drop this function in the next
version.

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 
> > +
> > +    /// Returns the number of milliseconds.
> > +    #[inline]
> > +    pub fn to_ms(self) -> i64 {
> > +        self.divns_constant::<NSEC_PER_MSEC>()
> > +    }
> > +
> > +    /// Returns the number of nanoseconds.
> > +    #[inline]
> > +    pub fn to_ns(self) -> i64 {
> > +        self.inner
> > +    }
> > +}
> > --
> > 2.44.0
> >

