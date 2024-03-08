Return-Path: <linux-kernel+bounces-97315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C268768AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A39A2878CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA113D304;
	Fri,  8 Mar 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="X8APzAw4"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3326DDDD7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916077; cv=none; b=QGVJ6N2L+fjMhhE9nv7f7qEhoM83r/D0RmYQuf/oHu2bIKKG+0Tzxw8mZiS5zmklTyVW24UVq+5OAr69D7uDQdA+i+kslr8x8la90CR+C87H0+aCc6s+ZGW+Gi47bo39rZn/IyIA8wHZG4I02gv8/U8ghttVtWl2+PeIeqTAS7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916077; c=relaxed/simple;
	bh=E7xjUr7XFDIgxAuAR5skBYnGfcngAPHjHTPg0v/bj90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7mmg+qBWH9+4L+yiYwTMcoKqygT2Kj8LtZLZC0Zkll3dX2hu+csn8bE5SouGlSw4VPn2GcnMgU5c0gISQ8X3PegO5q7fR2SnafmKPSJQum2EAicS9CQ5aECm/HLe9TIGD0F5KCNPW/7aVUWnmBpgvZK/+cLShXSsMRQrLlbrYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=X8APzAw4; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 2658B1CD4D4;
	Fri,  8 Mar 2024 17:38:17 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709915897; bh=wYkGaMnNecZ484j/sTojyqfZAtdlr73D93VzoZo94XQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X8APzAw4QGRrwmr7uU8EBQQaxdnUXixKcfd9Vy2bIaRqtOf5kFsoTuZNJJRCBwH76
	 Y5OT/bsLx439Bwnr1nMTq85VUAx4SnXhTHkdwUrxfK88Z31Brx7MY9S3FaE5zt6r6+
	 AOGk+0T7l3E6rahfyR3sNlMs/wdv+TiAY60PxgF8U8gRgPfHia7QiKS6CrAgtVabyP
	 tCdn12xxZfn3/X/R9vQ8GMkbSRpgaimKOppaQQ71aNKjD1GK55ZrbJ2fRF13BNgHqs
	 y6WrvJZxu57KnchJ5ah5QANXRSwEN0nHF2HGs0v50/yiEUaeuw2VDN7g+BQMy9D8rK
	 JJGs1fkc6A0Iw==
Date: Fri, 8 Mar 2024 17:38:16 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-team@android.com, iommu@lists.linux.dev, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>, Dexuan Cui <decui@microsoft.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 6/6] swiotlb: Reinstate page-alignment for mappings
 >= PAGE_SIZE
Message-ID: <20240308173816.5351ea58@meshulam.tesarici.cz>
In-Reply-To: <5c7c7407-5356-4e12-a648-ae695fe0d1cb@arm.com>
References: <20240308152829.25754-1-will@kernel.org>
	<20240308152829.25754-7-will@kernel.org>
	<5c7c7407-5356-4e12-a648-ae695fe0d1cb@arm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 16:08:01 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2024-03-08 3:28 pm, Will Deacon wrote:
> > For swiotlb allocations >= PAGE_SIZE, the slab search historically
> > adjusted the stride to avoid checking unaligned slots. This had the
> > side-effect of aligning large mapping requests to PAGE_SIZE, but that
> > was broken by 0eee5ae10256 ("swiotlb: fix slot alignment checks").
> > 
> > Since this alignment could be relied upon drivers, reinstate PAGE_SIZE
> > alignment for swiotlb mappings >= PAGE_SIZE.  
> 
> This seems clear enough to keep me happy now, thanks! And apologies that 
> I managed to confuse even myself in the previous thread...
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I thought we agreed that this stricter alignment is unnecessary:

  https://lore.kernel.org/linux-iommu/20240305140833.GC3659@lst.de/

But if everybody else wants to have it...

Petr T

> > Reported-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >   kernel/dma/swiotlb.c | 18 +++++++++++-------
> >   1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index c381a7ed718f..c5851034523f 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -992,6 +992,17 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> >   	BUG_ON(!nslots);
> >   	BUG_ON(area_index >= pool->nareas);
> >   
> > +	/*
> > +	 * Historically, swiotlb allocations >= PAGE_SIZE were guaranteed to be
> > +	 * page-aligned in the absence of any other alignment requirements.
> > +	 * 'alloc_align_mask' was later introduced to specify the alignment
> > +	 * explicitly, however this is passed as zero for streaming mappings
> > +	 * and so we preserve the old behaviour there in case any drivers are
> > +	 * relying on it.
> > +	 */
> > +	if (!alloc_align_mask && !iotlb_align_mask && alloc_size >= PAGE_SIZE)
> > +		alloc_align_mask = PAGE_SIZE - 1;
> > +
> >   	/*
> >   	 * Ensure that the allocation is at least slot-aligned and update
> >   	 * 'iotlb_align_mask' to ignore bits that will be preserved when
> > @@ -1006,13 +1017,6 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> >   	 */
> >   	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
> >   
> > -	/*
> > -	 * For allocations of PAGE_SIZE or larger only look for page aligned
> > -	 * allocations.
> > -	 */
> > -	if (alloc_size >= PAGE_SIZE)
> > -		stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> > -
> >   	spin_lock_irqsave(&area->lock, flags);
> >   	if (unlikely(nslots > pool->area_nslabs - area->used))
> >   		goto not_found;  
> 


