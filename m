Return-Path: <linux-kernel+bounces-94385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C61B873E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11941F2132C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D2913DB96;
	Wed,  6 Mar 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZbJbXne+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KL34O+bc"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29995D48F;
	Wed,  6 Mar 2024 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749178; cv=none; b=UJ1sSUccnuhNiwaByu3IF1GUjPIx3ynFsuE4TN2sej7IPPGEysMDjFrBRraZ0d4iZPdVm/LeuiGx9Mua4UXD2WriW75pcRPy319qy0y/i+wdZKjAPEu14bmgdTTN2RwYdUS0X/7iull1di91f8WijcvHmEwcDTs0gfjJop8JE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749178; c=relaxed/simple;
	bh=KhlJ/Ab+W1AWjLf+j3juvafBR8eh3gB4I0CcT472KlA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=icrz8VknTcwfo1zzgB/vp+jXUx2ipBJf1KDU2qy4DYNzf+wlCBT+ZUKOt8DExIQD3EqZKfM0nZtEBJNQIjyIhRFaWdwREAhROTIxg535eFQ0SwjCvKaDvQcLDwsePeSEqQq2sbHUlYX5LvF5GpkYymUcw6C0J5uA809prqtl3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZbJbXne+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KL34O+bc; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id DCA8918000B0;
	Wed,  6 Mar 2024 13:19:34 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 13:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709749174; x=1709835574; bh=lo1Pj86qFJ
	EkBBfYsfFvyUEgtJ0BHAS3UhI2od29BS4=; b=ZbJbXne+U5F4DQlgT7/OSVkhU9
	XDiMkIJgGNcJVzEBgc1ud4nwDUt4awZTKV/9GSzvWjYx35/BIjjfjXmr3tABVlF5
	F9NE7aXPSORotdqc2nhgxB+lNEtUettRH7zAl/0UjHCUJE4PFxcQI5ycN82qVI4z
	6mvBg6iGmdF0ubP1E8HIBgXf1Z8bBU+IefIJxDWZwqCBVye22SRKWHvgCHp1yAhw
	eZYO2YUlbn/OL3pyXiriBWNxxA2WrtSC+T5WnH3BZ7gH4V91AyYL4ylgpWutGz+1
	wLyfgypXvrzYczq+lh0d9FP7huqX3+d9/5xhkqbDmGRM19xhTw2GlWpQLkgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709749174; x=1709835574; bh=lo1Pj86qFJEkBBfYsfFvyUEgtJ0B
	HAS3UhI2od29BS4=; b=KL34O+bcSXak4L7wUl5l279a0PjG2INm6xj1pSK09boo
	DDdwFB0By2FDjOxnh5GLgqnTwIZRyUdR8lLvp7RfKsA6VjFLQYTKittpckBfYHsY
	WxmgGsST1nRu9VCjB4iiZIHUW5ryYBOQ8j6XViGAr9Hb+d8Eq5DHtET2re/upU7K
	rM2hHT4FDHWesI1V0MOd9pSZH8XqPiXOU4HhEhDD9/JxYRgNs1+qeFPMnPlHNVNs
	3fq2CcErpzMC2srghM1/EXzRRIo1q0qnxSl9QXFiYHmoviOn8gz6csmzqxyNT2yg
	KRPwHxMRnhn+ic927pJHKJjdNzbh8eEt6J0Qsure1A==
X-ME-Sender: <xms:tbPoZRzfFwFF5k3GX9MqPrTnib2c4P-n73ALEx_B0soOsiQaar9egw>
    <xme:tbPoZRRDYyd4RdghtSctobtzuwbdfez8eWl2WtebpKjx7vaTIuAIjODEd_X91IU6H
    AME4ggQqP0xF_XKBgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:tbPoZbXfVxnPwLJkipb8DXXTopckc63XqbLltvLP7qBjLmRWjDTfdQ>
    <xmx:tbPoZThKJjPnIHtIuc7HUoCPItR1_SrYSbGhR-SNa8jNPDwpUlrTVw>
    <xmx:tbPoZTCu32U-Yy4BL_an_kc_eHoczjZdkVErteugy0Kt9xcC0P-bXQ>
    <xmx:trPoZX0fwpROSn-VM02InywUWNA98K7mJJAWDlt8pQVcxawhGKWlFPwagiY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 87B3AB6008D; Wed,  6 Mar 2024 13:19:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5568f26d-9e1a-4530-a086-564659b21666@app.fastmail.com>
In-Reply-To: <001ba36a-9d4c-45c4-b1f2-448824848afc@app.fastmail.com>
References: 
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
 <8d5780f5-1047-48d7-a9c9-09b95c7b5604@gaisler.com>
 <5648dca0-4853-4dfb-91cf-282a656beb1e@app.fastmail.com>
 <bc33b608-e0b5-4dff-aa05-8513dce409b3@gaisler.com>
 <75a4a08d-85c2-4a60-9cbd-90dd50f765a8@app.fastmail.com>
 <5d97d50a-9d40-4651-8071-073dee5f9aa8@gaisler.com>
 <001ba36a-9d4c-45c4-b1f2-448824848afc@app.fastmail.com>
Date: Wed, 06 Mar 2024 19:19:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andreas Larsson" <andreas@gaisler.com>,
 "Sam Ravnborg" <sam@ravnborg.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, "Randy Dunlap" <rdunlap@infradead.org>
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
Content-Type: text/plain

On Wed, Mar 6, 2024, at 17:22, Arnd Bergmann wrote:
> On Wed, Mar 6, 2024, at 16:31, Andreas Larsson wrote:

> On a relate note, it does seem odd to have such a small
> lowmem area, and I wonder if that could be extended.
> The 192MB lowmem limit comes from 
>
> #define SRMMU_MAXMEM            0x0c000000
>
> but I don't understand if that is a hardware limitation
> or a design choice that can be changed, and if it is
> even valid on leon or only on the old sun machines.

I had another look and found that this is a result of

arch/sparc/include/asm/page_32.h:#define PAGE_OFFSET    0xf0000000

which gives 3840MiB to userspace addresses, leaving only
256MiB for kernel lowmem and vmalloc space, which is
less than any other architectures.

I still don't know the history behind this choice, but I
see this was already configured the same when arch/sparc/
was originally merged. You can probably change it to a more
sensible 0xc0000000 or 0x80000000 like on other
architectures and run without highmem on anything with
less than 2GB of total RAM.

How much RAM do Leon machines have typically, or at the
maximum?

     Arnd

