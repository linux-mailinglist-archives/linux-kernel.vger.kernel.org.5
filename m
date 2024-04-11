Return-Path: <linux-kernel+bounces-141468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E258A1EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38887293D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18944BAA6;
	Thu, 11 Apr 2024 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2xHnzhF"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1B32BD06;
	Thu, 11 Apr 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859554; cv=none; b=gVNWZm88FL3Ll74YAbXGBQvjtoG0tuQdUky2v2VPtGJ7oDdT39Dj8qxfQXT6azE9ptNfHOw08kyCVFY3d4r4AaAD72hnPtb74XIbAyrrCF/RdVTWgnxoN5yw7lgpDPpME7bHSC4Bg5lQSZqLXI9mjQsgeImkU6ZPJBu6ARmC/+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859554; c=relaxed/simple;
	bh=m92tSawmZwdtKqQkxWpgKSfbELdIpb7nVqEdEcUMwRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuVdBO3vx4rnQmBeSQgr0aWJtAFXQrQq+aFVfBb3AqSh10NDkFgMeKSjQ1RDBdTqErtt5REK+/nQ7EicWJjHgDipAv1tz3qX8DebGQIPU2PkPjsRg0Hhm4Siit7fmi0jJDhtifdOWYmoLNhiJWlWDIgPM147u6BUD1/XGc1spsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2xHnzhF; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5aa691c2349so84106eaf.1;
        Thu, 11 Apr 2024 11:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712859552; x=1713464352; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+f58RdMhShayqlYFljJTlJb1wIelX2IhUti5xNHKmbk=;
        b=k2xHnzhFRh1zp8vogqae5TYWxfzdXGZjjqpB6BNGAKvuw2B0cD8cJkRR0my6pQkNPd
         JJzPSJfNVPnBJ1dph9dRlAjjFsrm7xMh1wXoUGIm1DrG8qLmdJmJ7jk2tFxMmS8UVeap
         keF0zAhpY4LDQYGfm7YYI0lXKWROc0Rc9jZz5a/wXjPKoMUnxGuOA53zSFplXfe7iCwx
         hqebLIbdSWMrAdrXIsxTNUea04TNyy85OdAfy9yyPzxlkpPQw5N+lNnSdYfOfHMudNqM
         0gcQTDneywMuDpNhJyPmmOPV/LRW7hC5fJWwv7ZNg+4Ifq+hCW37ryRgD/sRB2qhVASy
         oeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859552; x=1713464352;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+f58RdMhShayqlYFljJTlJb1wIelX2IhUti5xNHKmbk=;
        b=wJI1mFCV3c6UDfQpGe2soxnhFXJjmF8fISVOWlfezl8zs+wI5kFX/K2VvyiYgi0J8U
         mPG+D+IdsSx58DfAvTN3W5dp37jKORUkB7/y/Jib9BH2XzKzKqPXJ7tadQ8At9bjjqQe
         QdhafGypjZqkihTzygciXA1Q22ZAjQpBoKlOErHBSqJJNrCfNViR2biDm97KAzeoG0Gq
         6YRj9cuNflky0HZN73q09LCSuc6sgpJGaHGXtCDzqobUqMzeAU3ZsbgBftBXFpV7s02W
         IcS1uPHbJjEh3yk6uXyEQJXAjZIIxR4X9HVKNqzPRJpBkQJOn4xEOJ4VUG/aSI6to+io
         N/QA==
X-Forwarded-Encrypted: i=1; AJvYcCVPbKtEiRenxoHSs0vG3T8m3/YIAoPz0rHGW/kSYQhA/X0d/zXNno6abfdu+Gkji5866PPdJImQBv/ZmCAXD4NvOyV7Rv7x0Dr4owd6GITyi8stlzMuqQifJzoQwV9eF4vLlZzh+w6mPxwPfis=
X-Gm-Message-State: AOJu0YzlpEH0MzGEgjOsTtJ14SZLqqgIDPOVKwjsMK7k1tYO8hkdBaJf
	+fZfLW8tVTQksgAH/bVcsFg/UMY9W6yE0bHiB7lx42Quuo/+hiTy
X-Google-Smtp-Source: AGHT+IG9bRjYyrcLzYy6IcFa6swGBcRboo/7yUTSVWzJrscqzUm7UhAz7AYzSrKeRBJxUJw29WmKIQ==
X-Received: by 2002:a05:6871:7a86:b0:22e:b2b3:ae20 with SMTP id pd6-20020a0568717a8600b0022eb2b3ae20mr330402oac.7.1712859551750;
        Thu, 11 Apr 2024 11:19:11 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id l25-20020a05620a211900b0078d67d40c49sm1323791qkl.70.2024.04.11.11.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:19:11 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A7DEF1200066;
	Thu, 11 Apr 2024 14:19:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 11 Apr 2024 14:19:09 -0400
X-ME-Sender: <xms:nSkYZkIeMI_QI1dfiXo1We4lmOjlZTFPu4_paKdURAjDWouuM8z7eA>
    <xme:nSkYZkJKepvY23eWqUP6ZN51isQuT1rdrg2Ql6qn9rqx4HYdB4MM5G1b5nGUonu8y
    LdUy2FFg3rfdyrNWw>
X-ME-Received: <xmr:nSkYZktCAbplSYa_i8-oCk9FsvUWoHJOyIbRSUS_8dKlHYzLrMFPHSK6Lrc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudek
    hffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:nSkYZhYIIMAEn11kmejTXAZKpsoJfo80DH-5I8_NF_BGkLE_6JdKqQ>
    <xmx:nSkYZrb5clnVPCWzE0VGW9KISevOgRfrFJ1LPJjJ0ryZyb8WncIHRQ>
    <xmx:nSkYZtBy_OqSnv2CC3K_CMdN0nl-iJ5bW-RT-ICwvUqEQXGR0tyy1A>
    <xmx:nSkYZhZUAYf7SQDFaMIf8TeHUMnTbeH61XWiHpWuo0CCEyvft_ENog>
    <xmx:nSkYZjpeFU5Ei6Rrn0efq_kw7pVnvYjIGQIRgc7L2cjr3Ez_-uLnmyTU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 14:19:09 -0400 (EDT)
Date: Thu, 11 Apr 2024 11:19:05 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: time: add Ktime
Message-ID: <ZhgpmUF8Y1UZMase@boqun-archlinux>
References: <20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com>
 <ZhgISqMcEl21QZmW@boqun-archlinux>
 <CAH5fLgh4-OunYFmKYJ4L-jWthiB2D_moESpsZ7vwz0gUxdC6kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgh4-OunYFmKYJ4L-jWthiB2D_moESpsZ7vwz0gUxdC6kQ@mail.gmail.com>

On Thu, Apr 11, 2024 at 06:21:43PM +0200, Alice Ryhl wrote:
> On Thu, Apr 11, 2024 at 5:57 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Fri, Mar 22, 2024 at 08:59:38AM +0000, Alice Ryhl wrote:
> > > +    /// Returns the number of milliseconds.
> > > +    #[inline]
> > > +    pub fn to_ms(self) -> i64 {
> > > +        self.divns_constant::<NSEC_PER_MSEC>()
> > > +    }
> > > +}
> > > +
> > > +/// Returns the number of milliseconds between two ktimes.
> > > +#[inline]
> > > +pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
> > > +    (later - earlier).to_ms()
> > > +}
> > > +
> > > +impl core::ops::Sub for Ktime {
> > > +    type Output = Ktime;
> > > +
> > > +    #[inline]
> > > +    fn sub(self, other: Ktime) -> Ktime {
> > > +        Self {
> > > +            inner: self.inner - other.inner,
> >
> > Nit: although we use "Release mode" to compile Rust code in kernel, so
> > i64 substraction behaves as 2's complement wrap, I think it's better we
> > use wrapping_sub here:
> >
> >         self.inner.wrapping_sub(other.inner)
> >
> > however it's not a correctness issue for now, so with or without it,
> 
> We enable overflow checks even on release mode right now. But I don't

Oh, I was missing that, then we actually have to skip the overflow
checking with wrapping_sub() to mirror what C side does, for performance
reasons and for avoiding panics.

Regards,
Boqun

> understand this nit because we only have an overflow condition if the
> two ktimes differ by more than 2^31, and if that happens then that's a
> *legitimate* overflow that we would want to catch. Or is there
> something I am missing?
> 
> Alice

