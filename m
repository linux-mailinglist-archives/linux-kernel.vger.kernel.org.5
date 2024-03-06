Return-Path: <linux-kernel+bounces-94081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6087399D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F641F24CF6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271141339A6;
	Wed,  6 Mar 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Rk3SjKVa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rZu93xzo"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB7480605;
	Wed,  6 Mar 2024 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736357; cv=none; b=HlOxKEN0eU/6Gf4Rp10dKqXSJucY5RCmMnyCUZB6b6isuLbhRCw4AcPNjMZaUGwWlRVMMxElj+2JSl2ppIgF6FikSpHR2So43ccC9WoPEnknb3A12C329nsgCmwMzwgllkTmSQbud1sVvem3pgcBpp9rHoTaDKKe7FewXo9TRlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736357; c=relaxed/simple;
	bh=geOY66FgyKfJzY8mflAv3zxD6f5ML0nbM5/kw5N/7nY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=uRk0jhMSPAolCYCgsKiW21VEvQreWCCmVE9oj2bDWrRDZAgeMpJg1yDi62f4PwlUDXkocA546pmPsD4S0kV7LcVhyvlNGoFO6uuAofHnTHfYd6QgY4CrTIyeL0hN/K7y4KfzZ5cEdoeB5ho8O1s0HALe707e6mjv6OywdsWXNKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Rk3SjKVa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rZu93xzo; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 55DF9180007C;
	Wed,  6 Mar 2024 09:45:53 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 09:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709736352; x=1709822752; bh=pPFM5+mxd7
	HoHCokRuMNadQyImmiV1df1zVFdv+xb64=; b=Rk3SjKVaAoVV+4NeGsGHVwDGmt
	S/nAH3XtKCtg+5EU/Xz6XguarzNkx7/tLjXBs/Y/5D1iOVtG0MyrqgMkuSZmOJrv
	9MXfTfBuThrIAcX1zz0sxjb2Vta+jkQVHSN22HTAltzrdTvvXTR83dSib0BFMQRa
	dw0oIDN2VjPKlPlleKO0jpxVRCv1xF9ksRQgYBmDcrCm8eHmCSAzCcyPgzdgwIE7
	bVudav+cCpvwfj5MQpHy6ZpGtGMk5/uMQ7bdgyT1IYhRbK4beEgtn7gUM3+cwJc+
	iyqN7tH6DYzcPtUqdx9aNzKkXEDwrD6QroFum/NjRZHHL5/lIDpcMslXlMhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709736352; x=1709822752; bh=pPFM5+mxd7HoHCokRuMNadQyImmi
	V1df1zVFdv+xb64=; b=rZu93xzo78tWHKiNSPj4YYFtQWdBTgL6obbNuRPltAoK
	6CXtrPfyCSpehJSP806wFExBYnvn6CycVRGPZo14DPE5E+sgn5zzTcV+ym5LYoPj
	Qw1YuymJdKcbvsORb+mj+Vkb9452kxGABlHOFDbtHRmFVdjTxwHfCDWVhIVsRRb1
	tmv76HgkDQCbrCW6mpVV4GnfTKI7c49KECVD3LDFaV1L4LWMd375zYCLqecNTGgW
	BR7yI5JabCypX1GxkMdKB5YiVdQJ2GEi5aP5RTajx3emZhxl32z32j1EnpbZIcCh
	bw3mvfHxhFBS45t6oQuRNiYhHNv4GOJgFD1Rrs7jnA==
X-ME-Sender: <xms:oIHoZQMK1-c8I937qyMCMfaPpQkJQHkXTVcdVicG1diYONx--flz7g>
    <xme:oIHoZW8RSAaPixrBRLmh1pmluDp3zHfcxLbdg8gyGw5pRSiqXhgxFTK3nRM7cM13S
    PwOjw2ZC8X6-we0dlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:oIHoZXR-Dbg9WQOw6sFPbud-NSPSR-bnEpmvJWDD8LoxkubwEu7MIA>
    <xmx:oIHoZYt7Lu3dXPlgOP4cMXnEOsHcdvSqCgNcmA6W0f_0efgyVQAf1A>
    <xmx:oIHoZYdAMWosxmIwaeYJGbn_erT7Kz1bcOgTqmYFyLYV85Fertelyw>
    <xmx:oIHoZfzrqNqBxjPT_H0Spl-G5faI7hOp_cwkFdNuKTkGwgM20W3r_HXm7U0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 06153B6008D; Wed,  6 Mar 2024 09:45:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <75a4a08d-85c2-4a60-9cbd-90dd50f765a8@app.fastmail.com>
In-Reply-To: <bc33b608-e0b5-4dff-aa05-8513dce409b3@gaisler.com>
References: 
 <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
 <8d5780f5-1047-48d7-a9c9-09b95c7b5604@gaisler.com>
 <5648dca0-4853-4dfb-91cf-282a656beb1e@app.fastmail.com>
 <bc33b608-e0b5-4dff-aa05-8513dce409b3@gaisler.com>
Date: Wed, 06 Mar 2024 15:45:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andreas Larsson" <andreas@gaisler.com>,
 "Sam Ravnborg" <sam@ravnborg.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, "Randy Dunlap" <rdunlap@infradead.org>
Cc: "Miquel Raynal" <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
Content-Type: text/plain

On Wed, Mar 6, 2024, at 15:19, Andreas Larsson wrote:
> On 2024-03-05 16:26, Arnd Bergmann wrote:
>> On Tue, Mar 5, 2024, at 16:06, Andreas Larsson wrote:
>>> On 2024-02-24 18:42, Sam Ravnborg via B4 Relay wrote:
>> 
>>>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>>>> index 734f23daecca..bdbde506c01e 100644
>>>> --- a/arch/sparc/Kconfig
>>>> +++ b/arch/sparc/Kconfig
>>>> @@ -62,7 +62,6 @@ config SPARC32
>>>>  	select HAVE_UID16
>>>>  	select LOCK_MM_AND_FIND_VMA
>>>>  	select OLD_SIGACTION
>>>> -	select ZONE_DMA
>>>
>>> This however makes a number of PCI drivers that depend on
>>> ZONE_DMA unselectable.
>> 
>> I think that is the correct thing to do then: the only
>> drivers that I see with this dependency are PCI sound cards
>> that apparently rely on DMA to the 16MB ISA range, which is
>> not provided by sparc.
>
> The ZONE_DMA dependency does not seem related to ISA per se. Commit
> 80ab8eae70e5 ("ALSA: Enable CONFIG_ZONE_DMA for smaller PCI DMA masks")
> that started to introduce it did were about ensuring 32-bit masks.
>
> Some of those sound card drivers sets a 24 bit mask, i.e. a 0-16MB
> range, but some among those sets a 28, and 30 bit DMA mask with
> dma_set_mask_and_coherent.

Ah right, I see it now.

> Testing, in a different driver, setting and
> allocating under a 30-bit DMA mask (or even a 28-bit DMA mask depending
> on where the physical memory resides) is possible before removing
> ZONE_DMA, but not after. 

I still don't see how that changes anything if
max_zone_pfn[ZONE_DMA] and max_zone_pfn[ZONE_NORMAL] are set
to the same value. Did you test this on a mainline kernel, or
do you have any patches on top that might have set up
the zones differently?

More specifically, what do you see in the boot log for the
size of each zone? 

> I am also a bit concerned if removing ZONE_DMA will let DMA be allocated
> in highmem and what that could lead to.

It's not supposed to make a difference, but this is a bit
more complex:

- Any kernel allocation (kmalloc etc) by definition comes from
  lowmem, regardless of GFP_DMA/GFP_KERNEL.

- user pages that get mapped using dma_map_sg() or dma_map_page()
  can be in highmem, but this should not depend on the presence
  of ZONE_DMA

- If you have devices that can only access a subset of the RAM
  and there is no IOMMU, you really need to use swiotlb to
  make it use bounce buffers, at least for the streaming
  (dma_map_*) API. A driver using only the coherent (dma_alloc_*)
  API should use ZONE_DMA if ZONE_NORMAL goes beyond the
  dma mask.

      Arnd

