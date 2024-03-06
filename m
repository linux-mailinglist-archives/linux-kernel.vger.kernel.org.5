Return-Path: <linux-kernel+bounces-94150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FEB873A9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD2E284410
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE67B1353E2;
	Wed,  6 Mar 2024 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ykNoruf2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ez3qY4MF"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592D133402;
	Wed,  6 Mar 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738676; cv=none; b=bWi1K7X1t5TaF+Q79c9S9olnMsvbR2ZIxRJOliWRgU6CK4MrB2s9CNCs7hXhJKHUIOMXdp/1xLVB/dSQpAXpJefMhdWBmaQqTG6icVZ4DF1LwIhG3UhixrdAz5LjY12TKiAOEyoVFh9gfVDnwOCted077EZjfWHDQV+Q0wu7Tdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738676; c=relaxed/simple;
	bh=/0VqDz2UIu0+cfOsCSrTAnJyiyHmrm+TUFtAK1PFAwA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=MnO4Q2DGA+QTmFZHMzif8GwO1537vHU5d093M3/bRkR44JFYxmRLGFtGwiSyMmsvYmFqnfo/SRMm560hg2MBJKHhr1rSziR5yKYU8/rmjN2/e/2FuVAv+VvnZUWh+Fudl0u/acuUHyWU74oikQvdd+CFCW7QKXkWz07YCc00TyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ykNoruf2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ez3qY4MF; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 69D6E1C000C1;
	Wed,  6 Mar 2024 10:24:32 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 10:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709738671; x=1709825071; bh=FCtZTjzE5o
	yWPrrBsm0oZsGBE71NFluIUILuLO0a/z0=; b=ykNoruf2EuASTUPLT0n1H+GFaO
	6Ku+dR0onI91/Zo9wGix2jzOGDUu0QMFapyitfDgFswF1vRjAUQB4E1Ru6Oo/w81
	7qmEhoO6/gRebytxitzAK9urHL/WIzsoCh51Foga7xKqCEGBUDaqMOx6vXmjiwtA
	UTL2TsEpAelgmUwvurHEufVEqfOJf71UbASoxVnFI8okEFxYnnLxE1PSok/499ae
	ZvbymSkWRl+tyL9M5W7J83ZkWmnJlHnCuxNQxGetIFwR+e/1CpOgzKw/DppCYVkg
	THz3XGB94d9OKqIMAWm0Vwf/tt8YLDiPRhjbs0dDnAg/pUXJmbtp2flAWYug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709738671; x=1709825071; bh=FCtZTjzE5oyWPrrBsm0oZsGBE71N
	FluIUILuLO0a/z0=; b=ez3qY4MFkz8UwDlZo5Hz+ydAJZpq8ZIjgEPfpLfkfE3L
	4RPuVXiBjqM/BGHmVie49CR7dV0dhb7NV2RVfusO6ZjLDVo18QEJly99GKp+UOZm
	0TKSaOMlrdf9xvkQL+nbwacsSogAetoQWvAFzPYkygBfQ2/cNWVcCfJp03sUKZwv
	wLPQCYXQVkh9JbhgJB5E/QtDXCMLglZNbuFF/iX3qeci2Tts6CIDAGUFDJYCwe8M
	awBuJlvg3TKGDauEKPLnFMo9eGOHMDbo0nMD+0qthmhX9rNbTLpA935Q5Dhuhe15
	x8+r4Zc2eliY953srFi0gAebwPQIz6psoalnBZtBDg==
X-ME-Sender: <xms:r4roZT23L_I28IMj9Dgqub33DbiAWTfAn6eZV6vLe7Wdh4S0nQ5_IA>
    <xme:r4roZSHvIxc6EOOI8yVUNN72wXPO0VjojBOpjvjjbTWbbIqbaqemkFD6Hglg-qec5
    tvvqPWjOsFakto-Ua8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:r4roZT7P8Co7u63upfj4UniV96vbACQmwceakT0CTxF8tJmzE3XcFw>
    <xmx:r4roZY1dxbj85rJ4nzPvj7VbBnOtp9Xv52Db_ItUEb6kMKcDOE4c5A>
    <xmx:r4roZWFHVb6Jzjdo1G0S9EoTykeW7ISfmirx59OsOiTpaV5dsoRhxA>
    <xmx:r4roZSHa0Mt03W0W6kiHY0QpuDD3c8pJ855LHKWjzMmIcmJRDGfK4iSkKxs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 090A6B6008D; Wed,  6 Mar 2024 10:24:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9f6c9e65-d7f5-46cf-bdf8-9ff01b135ea9@app.fastmail.com>
In-Reply-To: <ZeiGBuMN_I9V94Mx@infradead.org>
References: 
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
 <8d5780f5-1047-48d7-a9c9-09b95c7b5604@gaisler.com>
 <5648dca0-4853-4dfb-91cf-282a656beb1e@app.fastmail.com>
 <bc33b608-e0b5-4dff-aa05-8513dce409b3@gaisler.com>
 <ZeiGBuMN_I9V94Mx@infradead.org>
Date: Wed, 06 Mar 2024 16:24:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@infradead.org>,
 "Andreas Larsson" <andreas@gaisler.com>
Cc: "Sam Ravnborg" <sam@ravnborg.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, sparclinux@vger.kernel.org,
 "Randy Dunlap" <rdunlap@infradead.org>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, "Takashi Iwai" <tiwai@suse.de>,
 iommu@lists.linux.dev, linux-kbuild@vger.kernel.org,
 "Masahiro Yamada" <masahiroy@kernel.org>
Subject: Re: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
Content-Type: text/plain

On Wed, Mar 6, 2024, at 16:04, Christoph Hellwig wrote:
> On Wed, Mar 06, 2024 at 03:19:52PM +0100, Andreas Larsson wrote:
>> > I think that is the correct thing to do then: the only
>> > drivers that I see with this dependency are PCI sound cards
>> > that apparently rely on DMA to the 16MB ISA range, which is
>> > not provided by sparc.
>> 
>> The ZONE_DMA dependency does not seem related to ISA per se. Commit
>> 80ab8eae70e5 ("ALSA: Enable CONFIG_ZONE_DMA for smaller PCI DMA masks")
>> that started to introduce it did were about ensuring 32-bit masks.
>
> Yikes!  That commit is just unbelievable buggy.  CONFIG_ZONE_DMA
> is only for architetures to select, not drivers.  A driver randomly
> enabling such an arch zone is just crazy.

It looks like it did not remain that way for long, as
2db1a57986d3 ("ALSA: pci: depend on ZONE_DMA") removed
the broken select again.

> I've been wondering for a while if we need some Kconfig magic
> so that certain symbols can only be select from arch/* and not
> elsewhere to prevent this (we had a few other similar cases like
> DMA_MAP_OPS).

It's a nice idea, but it would require a lot of reworks to get right,
with things like drivers/platform/x86 or drivers/{parisc,s390,sh}
that are still somewhat architecture code, and subsystems like
drivers/gpu/drm that typically just select whatever they want
instead of using dependencies.

      Arnd

