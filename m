Return-Path: <linux-kernel+bounces-79585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B01886247A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEABE1F22C22
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0E025564;
	Sat, 24 Feb 2024 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cBjda1JD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YHzr0rC1"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A103B179BF;
	Sat, 24 Feb 2024 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708773867; cv=none; b=EOxtrhcGKQOxB7qrlZFAzL84FORGH+atiu2um1mutoiQ9H+L6UzRbbY0ARo4bFn1q1b8+RsFadAMwiDujHFEFYMLcipdzquyYbYhi2QHcFZG3ldc7W9RIOMb07LtKRavzOJUOHITlfuVtRSCvGl/hlcVQlpTD0UrC/FKlRRkmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708773867; c=relaxed/simple;
	bh=bGkCdxzEKMkUtAPj5FqR9Cq8bDMISoqfITNAIp3FGIg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=tlTc2r7zxv0mUwA71PxixsP+PE5KIv7sSneTqOF//MTO/iaGA/NTPJx69Q0qSJMPEuTe4wh/QRgoq8/sfw3p9Sw7qe/uQ1ZuEGHTp1vLSvhBNGwDrSlCnu3sanLgTyIXNMup4ZABf1mSK1X6dOIxf5vSWviFgI/4NVkacj8PbKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cBjda1JD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YHzr0rC1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id A802E1380095;
	Sat, 24 Feb 2024 06:24:23 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 24 Feb 2024 06:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708773863; x=1708860263; bh=L3G2QYTU9L
	8h8IhhKruxfW6eljwc8LJWadajPilQEHA=; b=cBjda1JD2+y6t2AzX+wfaclHVI
	e0Mo5WCAOg42ljf6kI8GCRgVPgoAEC8XFml19f1pfxvb/vWOJ7sOO3FUwjD++8Hc
	BJtcmFoOqwJYsyxlbsNH/KTeAupEwDeaQ46IJ54w6B2hNPE7fuaU196cpIY2Ci/j
	qBzWnka2oSinhOuXnlFS2NTE7i/2PW9q/KSk8yZozPNiKJiUGSkqpUiW/cmilI2z
	9VFl37P44HUk8HV4VZMVM4p6wkrFqkHXW1dHmRYnGkL9C7nbqz18PKanxNYMYMYY
	9tFBnBD/pyptEPSyec5ZV6T32lroKpoclAJaH0BzesTTbnpVUTQK+13m7q+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708773863; x=1708860263; bh=L3G2QYTU9L8h8IhhKruxfW6eljwc
	8LJWadajPilQEHA=; b=YHzr0rC1oksc6Rax++hEx6+x7mghyKhm3xxwNGk/ttCd
	2MglVwYzS77iQmjsuyGxbF8SkENAgLNCryBLZHHtPtpSowelw8C8EunFxxEPp3qp
	4uhGTeEHMRXOFUXV/JbNVnPzIjE8VjxJi0bhPNe1jnaTUipKUQcq1rXp6mspgZql
	Ixgi41i7SKT6hKhy/k79UJ1NZJbyR/tdrtft2WEqlkTdCTg0o9uuXK+D00RCgqTu
	+sNvvCMb9aueLu9J7P9r4zDyhmq1ohfzWfVFoci9nZS1n9Wsaqc/f4NMjecC0Bac
	cV5ix6J7AJRg09CfmgCQ+WhWl31sqiBSwDB2pRUDGA==
X-ME-Sender: <xms:5tHZZVkMEK316NyCYiUhh9wWtVsqMMcaV9I71bwzktbwQj7iTNLpTg>
    <xme:5tHZZQ1U7_JV10Hstu9D_4CwEk6T03FKjWzCMRoMX_oLzUepeQPdbMTpyPQOddvSN
    zqDnI3WcpsgIizrjHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeekgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:5tHZZbrPxi72NCu5cJ919d7B-G_883Oq8jsmPPmfqkHvLmDHy22E9Q>
    <xmx:5tHZZVn6opmH6rW31MYWrjUNG3WG0Wtw7bEfoj5OcTMw9MPJrYx3YQ>
    <xmx:5tHZZT1SoAs2dRThrvXg8JXc4nDR1bYllHkpadOZPxZfej5jore89g>
    <xmx:59HZZcIaEYbYF4Gl-xTgiE-IRA_95WNKlVvi2VeVRKVhLhmPrySX5A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C06C1B6008D; Sat, 24 Feb 2024 06:24:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <73d9824f-898a-48ea-b3a8-ea420e3be007@app.fastmail.com>
In-Reply-To: <alpine.DEB.2.21.2402240458100.61493@angie.orcam.me.uk>
References: 
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
 <20240223-sam-fix-sparc32-all-builds-v1-5-5c60fd5c9250@ravnborg.org>
 <alpine.DEB.2.21.2402240235570.61493@angie.orcam.me.uk>
 <alpine.DEB.2.21.2402240458100.61493@angie.orcam.me.uk>
Date: Sat, 24 Feb 2024 12:24:01 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, "Sam Ravnborg" <sam@ravnborg.org>
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>, sparclinux@vger.kernel.org,
 linux-parport@lists.infradead.org, "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Randy Dunlap" <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sparc32: Do not select GENERIC_ISA_DMA
Content-Type: text/plain

On Sat, Feb 24, 2024, at 06:29, Maciej W. Rozycki wrote:
> On Sat, 24 Feb 2024, Maciej W. Rozycki wrote:
>
> The GENERIC_ISA_DMA option itself was added to arch/sparc/config.in with 
> 2.5.31 as:
>
> define_bool CONFIG_GENERIC_ISA_DMA y
>
> despite of:
>
> define_bool CONFIG_ISA n

I think I've seen any combination of CONFIG_ISA (the 62/98 pin slots), CONFIG_GENERIC_ISA_DMA (the request_dma() interface) and
CONFIG_ISA_DMA_API (the set_dma_addr()/enable_dma() type interface),
but I agree that sparc should have none of the three as both
floppy and parport use some other interface.

> for a reason not clear to me (BLK_DEV_FD? -- but on SPARC that uses some 
> hacks to work in the absence of ISA DMA anyway).
>
>  Am I missing anything here?

I think it was part of the ISA DMA lookalike that got removed
in 334ae614772b ("sparc: Kill SBUS DVMA layer.") and should
have been changed back then.

     Arnd

