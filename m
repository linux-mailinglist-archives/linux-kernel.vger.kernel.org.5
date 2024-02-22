Return-Path: <linux-kernel+bounces-76080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082C885F2AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853121F232DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4C18E1C;
	Thu, 22 Feb 2024 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="enXFF73o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GxjZVZIt"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069A417C7C;
	Thu, 22 Feb 2024 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590050; cv=none; b=RnkejLYOc+/pBiCzMfbzZMleV3moyV/5IW4bB7Vd+ZZEF5gsEqf8KEyCPtgZRXPVoWcbrhm8XIbRuA9Si/RLmQhglvRICjwp2XF2fM8V6I63U+YAGwKwLghPU5BEtZSESMC/6LjjpYiHG7VdLzKcFfQBD+nDfY1/dz3iMKghRX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590050; c=relaxed/simple;
	bh=4MClZqbuQ1LXpOwb1LZxVl0+YjjYmGDFWMdoAB/Z15M=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PxWGCtT4z0q8c5s9kTeF/X/Zn/ztm+5uW2CM0Wevx1ke2RQPoeCX23NNXpY7AUwcM/R6J3RZKQNduQ0u5ra8+yFaNjyNXCuYeQN/6cCWAcXlMoLyNPA23Hh8lCh4EJmzfjBaF7lRnWNa332brDyoxjxBeq1CwfM50iG4reMmWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=enXFF73o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GxjZVZIt; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id EC0CA13800A6;
	Thu, 22 Feb 2024 03:20:46 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 22 Feb 2024 03:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708590046;
	 x=1708676446; bh=kxGPWuzo0SG9vjq2VYft63fIP589ClwRv7B1K2FKclE=; b=
	enXFF73o5R+6qA/OcZqDSjng/cnvSbChsHJ+4GwY3PrsrxKc/jANGyg8bOL8oTbH
	i+Ro1fLXVXn0aW713bbIRvCvUCnHgW5JHcxuiSrvAbnFuz0ucaOK2yWZfEopwkbW
	Mb1x0RYgBoZUOsBRTlfxdxvXe5Qzs12v/jNaL77riiRLiqIWtEn5eJTqvw8VcIbi
	vBfL9nyQS4Wq2Q9sM0HAJ0G+6xPBcbJD4rxDJw9fGitWMRzJ08F47EWvYCrNoiiL
	VG2aFwL7Z2gfTpFjNUCajzWJeu3FqOQDnfgWU/r+ic3ceZ6jzP+2iCTIvSwRxf3h
	6hbMPWBLstXIgtpvohpt4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708590046; x=
	1708676446; bh=kxGPWuzo0SG9vjq2VYft63fIP589ClwRv7B1K2FKclE=; b=G
	xjZVZIt7dMNwUNN03o2kaxV9vfkhoD25WKVetSoQJapocStHxLPEzaC1/Bz/XP76
	eiR3aa/Fb86l2e1QUBij9T1rWJVXPn/0fB7J/P1gbvXNAenPYIApM8BOlcKLN5vN
	iS+69XcvzCcgbTkEloRVq1NCj2RXgvb/NwDGdAi9EG1LaOilcxS5Np4kCGsAEeiu
	SFwZ9MFer1qaWFfvYZTKpRbAno2jpNL8+rc35dCpPh6Qn4rUkjyodrIsCeS7c0Il
	NLlGZSIiGPt9yHDQw9tYuKzLkWA264kA00w9XSYGgpY7Q72NXC6ZjppYH+n5fcjV
	28UI1sd/rEn9KoFE7GM9w==
X-ME-Sender: <xms:3gPXZY7TTRusOSU-Zhw0yzK1Gw4BgtWkjd9CuALbR1uZZmpmZxperA>
    <xme:3gPXZZ7DEv97BjSd8Qp1Zmp_k_jf2bj8mM450Y0bO0jD3JMn_ZZlm4fpOrAlA4PQd
    9bt_mvSZARwkDSH2mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:3gPXZXeWxcdaczpF0Wyyf4yRHZeDYPaL1Q5KYicImBm53Vuw9HiYew>
    <xmx:3gPXZdJm58Dg9nD-5zU5ok-Q02nXi0SCnIGMkll0UhF3i9cpQmctuQ>
    <xmx:3gPXZcI3wyp9R8LebycpKLTKN0tPTE1ctNRGGagplde1lF9ekqezPQ>
    <xmx:3gPXZVpxTL90BporghlE1GrudzbQMDKUxKfcVNmeEW9MKeOSxkS1Og>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7877CB6008D; Thu, 22 Feb 2024 03:20:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d419dc3f-ce85-4bae-bb93-05e0103a1c6c@app.fastmail.com>
In-Reply-To: 
 <CAK7LNAQG_dX8p0Lch-wg8cOVRQzaJUh2zFJL+3tgpcT8_iSTow@mail.gmail.com>
References: <20240221202655.2423854-1-jannh@google.com>
 <20240221202655.2423854-2-jannh@google.com>
 <CAK7LNAQG_dX8p0Lch-wg8cOVRQzaJUh2zFJL+3tgpcT8_iSTow@mail.gmail.com>
Date: Thu, 22 Feb 2024 09:20:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Masahiro Yamada" <masahiroy@kernel.org>, "Jann Horn" <jannh@google.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Zhen Lei" <thunder.leizhen@huawei.com>,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/2] kallsyms: build faster by using .incbin
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024, at 05:06, Masahiro Yamada wrote:
> On Thu, Feb 22, 2024 at 5:27=E2=80=AFAM Jann Horn <jannh@google.com> w=
rote:
>> This change reduces the time for an incremental kernel rebuild
>> (touch fs/ioctl.c, then re-run make) from 27.7s to 24.1s (medians
>> over 16 runs each) on my machine - saving around 3.6 seconds.

Nice!

..

> This reverts bea5b74504742f1b51b815bcaf9a70bddbc49ce3
>
> Somebody might struggle with debugging again, but I am not sure.
>
> Arnd?

So far, I have not needed it again, but it's only been a year.

> If the effort were "I invented a way to do kallsyms in
> one pass instead of three", it would be so much more attractive.
>
>
> I am not so sure if this grain of the optimization is exciting,
> but I confirmed that a few seconds were saved for the defconfig.
>
> I am neutral about this.

I think the time savings are worth it, especially since this
is going to help anyone building on large machines where
the compile stage is already optimized a lot but the link
stage is limited by single-thread performance.

      Arnd

