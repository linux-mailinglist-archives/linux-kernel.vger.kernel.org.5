Return-Path: <linux-kernel+bounces-78006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E49DD860DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1721F23BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242845C8E8;
	Fri, 23 Feb 2024 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="xngZSMKr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YK/bGgC9"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E245B687
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680377; cv=none; b=BeTYebSuOIRFwLLLdHafWVghKCviesYFssWc7rjm/XPBXcsW61qNHoRPFxLWe/f7rjhEWVXosNbGp37Lc2H+zvYHKm3aHrTZ0+lvhwt6xwAktrmjWxhBaoC4IdMClZHoclIsikPijxGrAPjKdygkqxRzW+MiOWmMWljsA9HtI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680377; c=relaxed/simple;
	bh=nhqozpdV0S9ZYiVhyDPyJK90u88tqPWrNxt1fWdoTH4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=XSTEOL+z9HG34XL31kXUzXPN+9eJOeQtAWUTWgINzVK9Dxs1mLx0xLNV7+dNAEDr6qb1mmzlNgk/PNvA6BXXYrzoQf3aRatAq3696j/94vegtDYyuRlfrM1aUObebdHg/b4q/h9HUMm/p7lnuv/dGw8AvwXhPiwuUsUMFjNidT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=xngZSMKr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YK/bGgC9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id B2A6413800D9;
	Fri, 23 Feb 2024 04:26:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 23 Feb 2024 04:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708680374; x=1708766774; bh=/QlPIDjVVl
	zKBideWNCbnn92dUK56p9N16qOUVbhOBk=; b=xngZSMKr2OjIyfLEslGLzM9xim
	XF4XxPu8th+8wnShqf/plTT89jqNGYjx4qGeNoaKV1Rjh8J2WRAGbrj678G2MiMy
	tNkfwz2Fl5jAaZgRDDU93O7Hhr7UryyZJ3WsIQuDDfGG5/EeEOlM0qIOEQXDjvQ6
	ek3FUMiWswXPaCQWZM5SIfVeTvT78svlODF5dQ57NOv87fEzlaye9cW6fqlnWQ+0
	Wvr+/jrFJFe/0sM/D4LfMRpntcxTlwwF4IKqYrYSd9+pIv+5EBV6M84ZqnRok6f1
	NaV/RQ4H/yZ8kB2TBkz3mWn2SVUFbxQb9Y97aHeYdeGrIrXZQwCENtnTBKnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708680374; x=1708766774; bh=/QlPIDjVVlzKBideWNCbnn92dUK5
	6p9N16qOUVbhOBk=; b=YK/bGgC969cFZ+quPp+slt4s5c8fLFDkrVLCkgx78vYM
	wjz3+S5gvCAltV2MskaDhjBLxzoRyAM0hWIVlbSWTAa5+1Udh2c8K9LkuQqEqpNA
	4z65V+rtipYxb29V/lpByAeLj4c51gzwuxFscTwdCsktkd6Q3ObhPfv2KpNHNaRl
	rlJjShKsYe1jM58Oqbla6eZwfnqQ32ZpfErZSGuK5S0yyfCLm02qQHaA1lEKwDEy
	njEgrCs7dnrTB+W3jPxcagcY3Ir7SqCErUVV/JbaTmaUhBD596EcJClHLabNrKj9
	fHfgEFuInBVZDGu5jdu2WPEhhJsEQH1cUAabZqLzeg==
X-ME-Sender: <xms:tmTYZer5GuE7kcnvU_a9Z4bLBQmTKjxNcBTnKHdraWdigpNwXUUoxw>
    <xme:tmTYZcrAsqwsA0Qcr7UEcrPUbTK_C-gmMtFBmmpJdSp0EyvAMN7Q5iWvMhRO8I18O
    RB2J9g5E3HPKUY-pUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeigddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:tmTYZTPq6f5fn_d1gIlHZzsAY3bvG0x2QLOHy5ME7t6TuHf6oqF7aw>
    <xmx:tmTYZd716ReqXomrkLNRWzP4910cyvEC8JllEvYGV0vQxrRdTaVefw>
    <xmx:tmTYZd7nbsqsXVcRosm5ZLhq_qaXs9Y_TrnZP351eucsQjLdA8koug>
    <xmx:tmTYZSFKAKyWZIWHeIfvySuqGqLtBboWCCCN7SOV10dVF2mSG4XwyA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 314D6B6008D; Fri, 23 Feb 2024 04:26:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0fe0add2-6b17-441f-a0e1-7c1ee9b0ea71@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com>
References: 
 <CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com>
Date: Fri, 23 Feb 2024 10:25:49 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>
Cc: "Ard Biesheuvel" <ardb@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Kees Cook" <keescook@chromium.org>
Subject: Re: arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name
 'u128'
Content-Type: text/plain

On Fri, Feb 23, 2024, at 10:10, Naresh Kamboju wrote:
> In file included from arch/arm64/include/asm/lse.h:5,
>                  from arch/arm64/include/asm/cmpxchg.h:14,
>                  from arch/arm64/include/asm/atomic.h:16,
>                  from include/linux/atomic.h:7,
>                  from include/asm-generic/bitops/atomic.h:5,
>                  from arch/arm64/include/asm/bitops.h:25,
>                  from include/linux/bitops.h:68,
>                  from arch/arm64/include/asm/memory.h:209,
>                  from arch/arm64/include/asm/page.h:46,
>                  from include/vdso/datapage.h:22,
>                  from lib/vdso/gettimeofday.c:5,
>
>                  from <command-line>:
> arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name 'u128'
>   298 |         u128 full;
>       |         ^~~~
> arch/arm64/include/asm/atomic_ll_sc.h:305:24: error: unknown type name 'u128'
>   305 | static __always_inline u128

The problem here is the separation of vdso/*.h headers and
linux/*.h headers.

Commit a0d2fcd62ac2 ("vdso/ARM: Make union vdso_data_store
available for all architectures") introduced a reference to
the asm/page.h in include/vdso/datapage.h, but this is outside
of the vdso/*.h namespace and doesn't work in the compat vdso.

I think it is only needed because of the PAGE_SIZE macro,
so that constant needs to come from somewhere else.

I have an older patch that I never merged to unify the
page size configuration in Kconfig, and could try to
dig that out if nobody has a better idea. If we do that,
we could introduce a CONFIG_PAGE_SIZE.

    Arnd

