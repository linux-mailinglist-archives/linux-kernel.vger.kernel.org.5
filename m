Return-Path: <linux-kernel+bounces-158713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621168B2415
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190ED288DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D7F14A09A;
	Thu, 25 Apr 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQYXhIiM"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC4E763F1;
	Thu, 25 Apr 2024 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055331; cv=none; b=nRjH4v+J1uxqdrbBHKxcb75VsatH1t0evRRR17vS/LXvUSYryAvw9i+TDpGv+QXE0ZpjiWSR5ei90lvspsthhP0iRAgJw1tQIA4T/6cuvX0V4TaNR0EJlAnyk47rYkFvfdw7WQfTXFCpucCJNMocRcIsYCsZEQriQq/zKEJLDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055331; c=relaxed/simple;
	bh=xbNVq1GeT15x3KtRKYWeAIzqUgsbPeVW9DovaUqSTCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HB7At/ydagloR6CLoA9Kwik+oPLO7G8VxJPV3sQqvytye0N5rvbWkp7/sRXG9lFHaoLzQR2S9uxJYCvrhbmGLbH/Cw+DHpcBgrVbu3ZtPrBNs70cn18Xb8x+ErxP2Bp02aRxnWWQrONDqRUhDZlpasBnKHDZ3cC3S2JJ/eagXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQYXhIiM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78edc3ad5fdso98371585a.0;
        Thu, 25 Apr 2024 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714055329; x=1714660129; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rn302mOlE6lx5HQwiCG5zCrZGkXLkA8PRwPNsmFPHcA=;
        b=HQYXhIiMKm3P8a9vve7Nm/uuE3GDiK941JEuq0MXFYlMAVNmvaIPjnylI616EXe2UV
         DyrI766IlEnndP2BRnZoV6gfRPWVodLXv6Hstd0suqoIVRMJ3rWwsTFQ8F9u+BQ6MzKj
         CEsrpK6n0z6J5Lg0CbRgl+3QWUQoE4owVdyDOX/KqWkHqr/iMCEOuFqsM+DwTjQZjE+8
         tRvn2PlTMZ5qdcJO2FFrj1IMZZjaWMDCkmU4fupsf6k+XTGBOqd7JLju2EXdoY2om8Nm
         8jpokimIRAGcqqHwArhlE+gkaQsbW9VhaX6icEwLy2guPSE5ZVWyKVVsQBCCmx9fesq0
         Fy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714055329; x=1714660129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rn302mOlE6lx5HQwiCG5zCrZGkXLkA8PRwPNsmFPHcA=;
        b=HLL9yfp8DuulSfnyh461Pc8DM5Gw+5nuTw4P8oBYLavj2MuPB34/LgaAGavbish3pz
         zzYXi8eklaydtq+XEkqgEWbrVYwvcZC9jnhkOvB079E2m96e/qrSmNCvOKLCVpIw8LZy
         gZyXoDoJHhTDXK4jlV14PygJN5RQR245GGn1EF24QZles7d0XTyKPrj/vMtvdhsJ8xpC
         hl+Fufhy7Bldpw757Y8lfZrluTnoH/EgLitb3EUXShInXMFwKRoxpR1unCUfHG6WRCG4
         l7fYLfj6UItafu1vEnA6aHuKQvdczAScUWR9djSMQhPlgp4TmnzAdChd1f391emW6JsQ
         MZmg==
X-Forwarded-Encrypted: i=1; AJvYcCWvePE2+6tgoXDSPSOGhIeAwIPkPymKShvRfyHV9u+X1pPA+foaLF9WNWxctNlDyadt6AjusQVTodCz80L+E8lRk0bhw+OyCBHWmel5yVVtwSylKqnWN3JLvVGzffgaIc/BViVqMgMwBFZVmQ8=
X-Gm-Message-State: AOJu0YwFzkOib/JGdIFeJH2kOS+Znsv3jDPMexfTF1W2GPnOOOthNagR
	zNNdDiLHWXV0Sq9Q1hm5GiKDoq1naXKdGHM5C14psAjTW40MYf6H
X-Google-Smtp-Source: AGHT+IFkcNqvcsJjprkk/iE6VuGNgJP35p310+NI7j+3CpzA+/hcy/h6t5jknfaX2IvHgrjQ0/QkHQ==
X-Received: by 2002:a05:620a:3907:b0:78f:ff3:7c8e with SMTP id qr7-20020a05620a390700b0078f0ff37c8emr5497169qkn.7.1714055328724;
        Thu, 25 Apr 2024 07:28:48 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a149000b0078f1a57ac0csm6049360qkj.83.2024.04.25.07.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 07:28:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A93941200032;
	Thu, 25 Apr 2024 10:28:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 25 Apr 2024 10:28:47 -0400
X-ME-Sender: <xms:n2gqZodfZMtgF37AyQc52e8JOzwowA1bnPMGnHBF9TDKSMfkutplDQ>
    <xme:n2gqZqMS-jGLtmiCV_UsAlggeD5uO6J3ph9Gf4_rWD8j0oWWFP44X8zuO2Yw56iDO
    r1QhZX1SbbIB_2NQw>
X-ME-Received: <xmr:n2gqZpi53HM1T6XfWhDEy8MOuCjQter_lr6imE1WT3HYULq-lC9GPrK5cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepieehfeekgfdvfeetjeejudekhfeiveelfeefveehheeffffhkefhteev
    ffevhffgnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsg
    hoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:n2gqZt8BvdD9ZZg7R--ZQgVnw9XbKJbTM9ynSeNpdweqzZto-Dc0zw>
    <xmx:n2gqZkvq_wdTPmpNC3vu3SGHbIdCEs3FiOZFBAc-5xlxqblsrYuSHw>
    <xmx:n2gqZkHAgNyzj7dbT6V6swC0iZsGcp8WOIorcJXICjq4T6sdcgVV5w>
    <xmx:n2gqZjPTFZwKue9z5S7Zrr_OcJQAok7XAsJLGFpuyat2mCj_u5hciw>
    <xmx:n2gqZpOLvwZ5jReMKsbRVMr8tH0_DDZoT2hJKYl1H9dt2zdkD0ctM-eg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 10:28:46 -0400 (EDT)
Date: Thu, 25 Apr 2024 07:28:45 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Alice Ryhl <aliceryhl@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Miguel Ojeda <ojeda@kernel.org>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
Message-ID: <ZiponXmzv1iIO3dJ@Boquns-Mac-mini.home>
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
 <20240411230801.1504496-3-boqun.feng@gmail.com>
 <CAH5fLgg0CkZO9KF58boui6Y5ajpXHuGh0OxyNru2aEG5pNObwQ@mail.gmail.com>
 <Zhk0q-0eM4z5JHqn@Boquns-Mac-mini.home>
 <CAH5fLghL=G-ihevf1_D0aGffmJMtxtSpMDoTGtrmdiDfhwpKnw@mail.gmail.com>
 <877cgln7f4.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cgln7f4.fsf@metaspace.dk>

On Thu, Apr 25, 2024 at 11:00:31AM +0200, Andreas Hindborg wrote:
> Alice Ryhl <aliceryhl@google.com> writes:
> 
> > On Fri, Apr 12, 2024 at 3:18 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>
> >> On Fri, Apr 12, 2024 at 10:36:05AM +0200, Alice Ryhl wrote:
> >> > On Fri, Apr 12, 2024 at 1:08 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >> > >
> >> > > Currently since Rust code is compiled with "-Coverflow-checks=y", so a
> >> > > normal substraction may be compiled as an overflow checking and panic
> >> > > if overflow happens:
> >> > >
> >> > >         subq    %rsi, %rdi
> >> > >         jo      .LBB0_2
> >> > >         movq    %rdi, %rax
> >> > >         retq
> >> > > .LBB0_2:
> >> > >         pushq   %rax
> >> > >         leaq    str.0(%rip), %rdi
> >> > >         leaq    .L__unnamed_1(%rip), %rdx
> >> > >         movl    $33, %esi
> >> > >         callq   *core::panicking::panic::h59297120e85ea178@GOTPCREL(%rip)
> >> > >
> >> > > although overflow detection is nice to have, however this makes
> >> > > `Ktime::sub()` behave differently than `ktime_sub()`, moreover it's not
> >> > > clear that the overflow checking is helpful, since for example, the
> >> > > current binder usage[1] doesn't have the checking.
> >> >
> >> > I don't think this is a good idea at all. Any code that triggers an
> >> > overflow in Ktime::sub is wrong, and anyone who enables
> >> > CONFIG_RUST_OVERFLOW_CHECKS does so because they want such bugs to be
> >> > caught. You may have been able to find one example of a subtraction
> >> > that doesn't have a risk of overflow, but overflow bugs really do
> >>
> >> The point is you won't panic the kernel because of an overflow. I
> >> agree that overflow is something we want to catch, but currently
> >> ktime_t doesn't panic if overflow happens.
> >
> > What the CONFIG_RUST_OVERFLOW_CHECKS option does is enable panics on
> > overflow. So I don't understand how "it panics on overflow" is an
> > argument for removing the overflow check. That's what you asked for!
> > One could perhaps argue about whether CONFIG_RUST_OVERFLOW_CHECKS is a
> > good idea (I think it is), but that is orthogonal. When
> > CONFIG_RUST_OVERFLOW_CHECKS is enabled, you should respect the flag.
> 
> I would agree. If users do not want panics on overflow, they disable
> RUST_OVERFLOW_CHECKS. If the config is enabled, overflows in ktime sub
> should panic, even if it does not do so in equivalent C code.
> 

What's reason then? If we think a piece of API should have a different
semantics than its C counterpart, that suggests we also need to change
the C side for the same reason. Don't keep good stuffs only to ourselves
;-)

Plus, what if users don't want to panic on ktime API but still want
overflow checks for other parts? Using RUST_OVERFLOW_CHECKS to determine
whether ktime should perform overflow checkings seems a bad to me
regardless of what semantics we end up with. For reference, the Rust std
`Duration` performs always overflow checking:

	https://doc.rust-lang.org/src/std/time.rs.html#429-435

We shouldn't define that overflow checking of ktime follows the general
rule of overflow checking of any i64, instead, we should have a clear
rule for it.

Regards,
Boqun

> BR Andreas

