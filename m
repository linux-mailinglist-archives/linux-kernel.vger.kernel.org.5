Return-Path: <linux-kernel+bounces-94155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A9E873AB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E5F9B20EBE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379D81350DE;
	Wed,  6 Mar 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="UySXwnwO"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD871339B1;
	Wed,  6 Mar 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739117; cv=none; b=U+/gql+2SLr7t5M2UpvtX1TggsLeME9NmVrNgplaqGn79SpESfqAP1rkAYfv6op+7VNNxc3JM4pWQ6Qul594bsYg+/7U5FWhFC0l85FW0BC/KOZ8DDW4cqC5YjvWnjqYu0bUickwRaj/GcEzGT+pEKToRyUUDgwnDY0zatplQ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739117; c=relaxed/simple;
	bh=Er8af+lGOgxUMzgP3Inja3okhV/X568racGzl39cuMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvR1jg6w/HAsHt1kJ4wC+fUDuMDvImo4uuIK9U8tX+D4gMETMobhxFUBRW37A+l8gTTniFau0JYFrDU1LCqJ2Z3n/PcqNlQCPpZ2bq95XpmYYMnc/MytpBqf5Ajc6J3a3aOa4D4JttxmAX3Ae0QHphHw/hkxTNvHCHSxfmn0Upk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=UySXwnwO; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Tqby86K5Pz67w5;
	Wed,  6 Mar 2024 16:31:44 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Tqby03gWFz682J;
	Wed,  6 Mar 2024 16:31:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709739104;
	bh=RsF6B/eQwmXOP8pTFuG0TBVvW6JiFTIq+o4WK6bOdPg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UySXwnwOsDGcj952f3Oo3beT2eS6E79FYqgsqUanIjCh1G93YHtsXgN9CDzNaGuKW
	 5k9gkKxZouTeKN+00KjNvuRob/yJWuBeslnxWS1a5PjUGz9PEDD7c5ic5sJOIGkp7r
	 Ay63yZLVq1P8MycG+sMNdfl8uf+PUa9UaZTagijk=
Message-ID: <5d97d50a-9d40-4651-8071-073dee5f9aa8@gaisler.com>
Date: Wed, 6 Mar 2024 16:31:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, sparclinux@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S . Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
 <8d5780f5-1047-48d7-a9c9-09b95c7b5604@gaisler.com>
 <5648dca0-4853-4dfb-91cf-282a656beb1e@app.fastmail.com>
 <bc33b608-e0b5-4dff-aa05-8513dce409b3@gaisler.com>
 <75a4a08d-85c2-4a60-9cbd-90dd50f765a8@app.fastmail.com>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <75a4a08d-85c2-4a60-9cbd-90dd50f765a8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-06 15:45, Arnd Bergmann wrote:
>> Testing, in a different driver, setting and
>> allocating under a 30-bit DMA mask (or even a 28-bit DMA mask depending
>> on where the physical memory resides) is possible before removing
>> ZONE_DMA, but not after. 
> 
> I still don't see how that changes anything if
> max_zone_pfn[ZONE_DMA] and max_zone_pfn[ZONE_NORMAL] are set
> to the same value. Did you test this on a mainline kernel, or
> do you have any patches on top that might have set up
> the zones differently?

This was tested on my for-next plus this patch series, i.e. v6.8-rc1
plus these ones:

(local)       sparc32: Fix section mismatch in leon_pci_grpci
(local)       sparc32: Fix parport build with sparc32
(local)       sparc32: Do not select GENERIC_ISA_DMA
(local)       sparc32: Do not select ZONE_DMA
(local)       mtd: maps: sun_uflash: Declare uflash_devinit static
(local)       sparc32: Fix build with trapbase
(local)       sparc32: Use generic cmpdi2/ucmpdi2 variants
626db6ee8ee1e sparc: select FRAME_POINTER instead of redefining it
5378f00c935be sparc: vDSO: fix return value of __setup handler
3ed7c61e49d65 sparc64: NMI watchdog: fix return value of __setup handler
079431ea9ed3e sparc: vio: make vio_bus_type const
3cc208ffa84a7 sparc: Fix typos
0f1991949d9bd sparc: Use shared font data
0955723ef9358 sparc: remove obsolete config ARCH_ATU

so nothing else that should affect zones.

> More specifically, what do you see in the boot log for the
> size of each zone? 

dma_set_mask_and_coherent(dev, DMA_BIT_MASK(28)) fails with
the ZONE_DMA removed, and no other differences. Boot log:

831MB HIGHMEM available.
Zone ranges:
  Normal   [mem 0x0000000000000000-0x000000000bffffff]
  HighMem  [mem 0x000000000c000000-0x000000003fff7fff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x000000003fff7fff]
Initmem setup node 0 [mem 0x0000000000000000-0x000000003fff7fff]


dma_set_mask_and_coherent(dev, DMA_BIT_MASK(28)) succeeds with
ZONE_DMA still in place (i.e. the above plus the ZONE_DMA patch
reverted and no other differences). Boot log:

831MB HIGHMEM available.
Zone ranges:
  DMA      [mem 0x0000000000000000-0x000000000bffffff]
  Normal   empty
  HighMem  [mem 0x000000000c000000-0x000000003fff7fff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x000000003fff7fff]
Initmem setup node 0 [mem 0x0000000000000000-0x000000003fff7fff]


> 
>> I am also a bit concerned if removing ZONE_DMA will let DMA be allocated
>> in highmem and what that could lead to.
> 
> It's not supposed to make a difference, but this is a bit
> more complex:
> 
> - Any kernel allocation (kmalloc etc) by definition comes from
>   lowmem, regardless of GFP_DMA/GFP_KERNEL.
> 
> - user pages that get mapped using dma_map_sg() or dma_map_page()
>   can be in highmem, but this should not depend on the presence
>   of ZONE_DMA
> 
> - If you have devices that can only access a subset of the RAM
>   and there is no IOMMU, you really need to use swiotlb to
>   make it use bounce buffers, at least for the streaming
>   (dma_map_*) API. A driver using only the coherent (dma_alloc_*)
>   API should use ZONE_DMA if ZONE_NORMAL goes beyond the
>   dma mask.
Thanks for the explanation!

Cheers,
Andreas


