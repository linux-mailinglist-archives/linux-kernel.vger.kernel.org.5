Return-Path: <linux-kernel+bounces-94258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F44873C13
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980D41F2333A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC88137763;
	Wed,  6 Mar 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SwDaX5z8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eslNcsda"
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F5135A4B;
	Wed,  6 Mar 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742171; cv=none; b=QWLZbtCmrPIpTdsitEPDNPxLu0okBGF6VycaYnHvXkLig8+kj9Sjd/tz10RFeQmq8lwsqpyY+LWXSX5n0PxHqA7Fl53di4Qmn5NfHwsFEE1Bv1gVcc1VeLS+h+eenvQvVZsiD9kQaxhMcRNnkLJlqP6Sma2htcXRYfX0VNPeBSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742171; c=relaxed/simple;
	bh=M9RLoKUf78mtmNWUmr/Q4R2rYL8ZPqcxbZWZInXujfA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=X05oATxd3xhCJ/fLAjJ7a47RA67WJ09Yv8p7fXnO69sDAQoMrcZ4cmyLv6Y/qZ9t2TeXlsr5TIEIKbTutAJ51ZMN8iPe2SxisdQwvFxREfWW0cb/Py0igFbtrzzE6BW4olvUlZFFLoLkCjXliZvIvlMgQMUnTV3dC/SXAnaFBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SwDaX5z8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eslNcsda; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 65E3F18000A6;
	Wed,  6 Mar 2024 11:22:47 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 11:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709742166; x=1709828566; bh=y7A79WQklI
	QfY4J0P/pXJ8877SJ7uzmXrpsOWbznmOo=; b=SwDaX5z85c8xMbp5u9Renmu+YO
	RVuOOxKKheLzugrl7ROAGe59GaIIuO5JP4UayAe3YaMwK1ZoP8ALm8omF1KnUsoX
	Nnu+VU4L5YiE/Dw/zPyJz4mx48gBMfUHVMpN87HOLuEaaG6A+LjIBBCEtBOn+5Dp
	mnY+eejMhHj/dhUagvKraE6WqJCrdO20bouKFtD617X1L39eQUFXFoCW3VUq1Srr
	NC+r633l+dHaA0hzFOzFtkgJNpaQXLuEc3mlLm1e9ETd7Df/v6cU2N+E+1gmnbAb
	aqRV4a82yGsDIcyUSpISOz6gnS8HhzaMEnpvpssV9ougfHbs3qByRX77iVLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709742166; x=1709828566; bh=y7A79WQklIQfY4J0P/pXJ8877SJ7
	uzmXrpsOWbznmOo=; b=eslNcsda+Mjzl4w1+yGxHJQWHFDwip7x+vekYREMIglf
	cHqg/jMkuXrepeDXqALR+SSBzK6chAryjU/fk8UELoyz623bXF5zsx+HmqsGWhzR
	iSA4I1zbfhsVwojL4GeI/uyXoqrhKMvOuEb4ZayrNM1rbe09B4QjMy221OqeBG8+
	+RIp8aLt/irITWBSwvToIxMa57oWaH2iI1jn8r0wSyfmxaKiD9+HjycnDQdc+nKJ
	PTU/rR8fsQJ+Ko5t0fXuWfxmsou+PL2qi5WBw4VNAAIdtHNCIiaBsGDIAq03D6Lu
	1hecS/s74zSSC3aMspKFyIifScSNr0NeJGbPJgQQfQ==
X-ME-Sender: <xms:VZjoZU7kkNCO2LuMzeJS7UotWCFW0bIIwpde-jvpYRfxs2Zj7-H5yQ>
    <xme:VZjoZV5lrV7Nxb6RKkBi__Nv1rGv8LYaJD-I6hhFVRnWJiDWedMdCl0jMyuNeC5Tl
    S81MANdUatz9moRyQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:VpjoZTf17gbaBsLZQ9s2Qrn5pqJOhyFT-FOGkLhkrDa98OUzXGGcIQ>
    <xmx:VpjoZZI-pakuZcGCZGrxeNSo4vbc1azWDe8j8e4gWsFRzELXuNLNjA>
    <xmx:VpjoZYKUbjjsx9foTFJhI0P3lpkSILb9DE_fBYWq5b85LZXLx440DQ>
    <xmx:VpjoZX-ZMZUFgLBJHWQVUK35jNINl3Ldm1o2D626T0lMxmpl-eFU_FFn-hQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E45FEB6008D; Wed,  6 Mar 2024 11:22:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <001ba36a-9d4c-45c4-b1f2-448824848afc@app.fastmail.com>
In-Reply-To: <5d97d50a-9d40-4651-8071-073dee5f9aa8@gaisler.com>
References: 
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
 <8d5780f5-1047-48d7-a9c9-09b95c7b5604@gaisler.com>
 <5648dca0-4853-4dfb-91cf-282a656beb1e@app.fastmail.com>
 <bc33b608-e0b5-4dff-aa05-8513dce409b3@gaisler.com>
 <75a4a08d-85c2-4a60-9cbd-90dd50f765a8@app.fastmail.com>
 <5d97d50a-9d40-4651-8071-073dee5f9aa8@gaisler.com>
Date: Wed, 06 Mar 2024 17:22:25 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andreas Larsson" <andreas@gaisler.com>,
 "Sam Ravnborg" <sam@ravnborg.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, "Randy Dunlap" <rdunlap@infradead.org>
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
Content-Type: text/plain

On Wed, Mar 6, 2024, at 16:31, Andreas Larsson wrote:
> On 2024-03-06 15:45, Arnd Bergmann wrote:
>> More specifically, what do you see in the boot log for the
>> size of each zone? 
>
> dma_set_mask_and_coherent(dev, DMA_BIT_MASK(28)) fails with
> the ZONE_DMA removed, and no other differences. Boot log:
>
> 831MB HIGHMEM available.
> Zone ranges:
>   Normal   [mem 0x0000000000000000-0x000000000bffffff]
>   HighMem  [mem 0x000000000c000000-0x000000003fff7fff]


> dma_set_mask_and_coherent(dev, DMA_BIT_MASK(28)) succeeds with
> ZONE_DMA still in place (i.e. the above plus the ZONE_DMA patch
> reverted and no other differences). Boot log:
>
> 831MB HIGHMEM available.
> Zone ranges:
>   DMA      [mem 0x0000000000000000-0x000000000bffffff]
>   Normal   empty
>   HighMem  [mem 0x000000000c000000-0x000000003fff7fff]

That sounds like a bug somewhere else. As Sam explained in
the patch description, ZONE_NORMAL and ZONE_DMA always have
the same limit, which explains that without the patch you
only have DMA and highmem, but not normal.

What we expected to happen here is that anything that asks
for ZONE_DMA memory just uses ZONE_NORMAL instead and the
behavior never changes.

It looks like this is not how dma_direct_supported()
works though:

        u64 min_mask = (max_pfn - 1) << PAGE_SHIFT;
        [...]
        /*
         * This check needs to be against the actual bit mask value, so use
         * phys_to_dma_unencrypted() here so that the SME encryption mask isn't
         * part of the check.
         */     
        if (IS_ENABLED(CONFIG_ZONE_DMA))
                min_mask = min_t(u64, min_mask, DMA_BIT_MASK(zone_dma_bits));
        return mask >= phys_to_dma_unencrypted(dev, min_mask);

Without ZONE_DMA, it checks for the highest page of any
zone, but that is ZONE_HIGHMEM in your case, which apparently
is outside of the device's mask, while ZONE_NORMAL is inside
the mask.

Not sure if it's worth changing the generic code for this,
or if we want to just keep the existing version without
Sam's patch now that we understand the issue.

On a relate note, it does seem odd to have such a small
lowmem area, and I wonder if that could be extended.
The 192MB lowmem limit comes from 

#define SRMMU_MAXMEM            0x0c000000

but I don't understand if that is a hardware limitation
or a design choice that can be changed, and if it is
even valid on leon or only on the old sun machines.

There is a recurring discussion about eventually
killing off support for CONFIG_HIGHMEM in the kernel,
so if you have a hardware limit of 192MB of lowmem,
this would hit you particularly hard.

      Arnd

