Return-Path: <linux-kernel+bounces-40390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC4983DF62
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95701F21FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3CD1EA71;
	Fri, 26 Jan 2024 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="XOSly2Se"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA401DFD8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288492; cv=none; b=ogxaLIyv8yElxp3HIZNCAZ6y4jlhtO+QVtd8QC+n3XlMCRwlDIS1lo3yO5nmkMRQgL5jwvUz5kmjwvgIKM9yiaujvF/utKZaxLsikiPRQJ3Wvviqr5aWgaVitutFxCEcZqDFY4APg7pY3wzfLzh3UYEeMStofjG6YWBzI8orDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288492; c=relaxed/simple;
	bh=AfpD8W31ntVbkcSd2WyNvNUG7A1kSBtdZDZK3XBBVvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYf4oO+q3n5sA6Sgg5MqThmSGcd2vJgofDOsjVo2j/lKatK32NyQ81kD/0ZDtWSUOHkkPRHoW9mx1v8a+80U3AaEA3tFQlh+HR5q42ujB5uqLkuGJO3AulGa2WXqGFc/PnBmkNz4XrZeZG1R/qmW3l2Fh1Ccw6Irj1UH05t2/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=XOSly2Se; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 0C4ED18C9EF;
	Fri, 26 Jan 2024 18:01:28 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706288488; bh=AfpD8W31ntVbkcSd2WyNvNUG7A1kSBtdZDZK3XBBVvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XOSly2SeSlOIkx2KAwfekVkauQqx/MG+WLaSAMocbRMwkP2ORW0vW4iZLFrFtDgWx
	 uAkqwuNa3y7I+tZryFtUrKqcMPX0k/N2Mr8tRiHopefbs/77Ko3VCZ9rA9Qlo0gZJO
	 HsiTaI6xKt3qFMPFdfWGqtOam3u0vcleqWxTy1JG0nhOHfSzJVls5Pqpy5PPYSD2qn
	 Bcq1sF1uA4nRSkfsnQ2egE+LBb4Q+4lqih0mNuBpY5YbspTNR62mlrzlriVjNrIR7b
	 /fPPar6U8t56O/fZkBSBmbLDb36Q0nMJEKz/jVN2E6ezqp0pTLXOSPf39luPRJJjfe
	 hMdd6h96HHxiQ==
Date: Fri, 26 Jan 2024 18:01:27 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>
Subject: Re: [PATCH 1/2] swiotlb: Fix allocation alignment requirement when
 searching slots
Message-ID: <20240126180127.1a3fc4e6@meshulam.tesarici.cz>
In-Reply-To: <20240126151956.10014-2-will@kernel.org>
References: <20240126151956.10014-1-will@kernel.org>
	<20240126151956.10014-2-will@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 15:19:55 +0000
Will Deacon <will@kernel.org> wrote:

> Commit bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix"),
> which was a fix for commit 0eee5ae10256 ("swiotlb: fix slot alignment
> checks"), causes a functional regression with vsock in a virtual machine
> using bouncing via a restricted DMA SWIOTLB pool.
> 
> When virtio allocates the virtqueues for the vsock device using
> dma_alloc_coherent(), the SWIOTLB search fails to take into account the
> 8KiB buffer size and returns page-unaligned allocations if 'area->index'
> was left unaligned by a previous allocation from the buffer:
> 
>  # Final address in brackets is the SWIOTLB address returned to the caller
>  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1645-1649/7168 (0x98326800)
>  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1649-1653/7168 (0x98328800)
>  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1653-1657/7168 (0x9832a800)
> 
> This ends in tears (typically buffer corruption and/or a hang) because
> swiotlb_alloc() blindly returns the 'struct page' corresponding to the
> allocation and therefore the first half of the page ends up being
> allocated twice.
> 
> Fix the problem by treating the allocation alignment separately to any
> additional alignment requirements from the device, using the maximum
> of the two as the stride to search the buffer slots.
> 
> Fixes: bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix")
> Fixes: 0eee5ae10256 ("swiotlb: fix slot alignment checks")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b079a9a8e087..25febb9e670c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -982,7 +982,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
>  	unsigned long max_slots = get_max_slots(boundary_mask);
>  	unsigned int iotlb_align_mask =
> -		dma_get_min_align_mask(dev) | alloc_align_mask;
> +		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);

Good. So, iotlb_align_mask now specifies how many low bits of orig_addr
should be preserved in the bounce buffer address, ignoring the offset
within the TLB slot...

>  	unsigned int nslots = nr_slots(alloc_size), stride;
>  	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>  	unsigned int index, slots_checked, count = 0, i;
> @@ -998,14 +998,13 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>  	 * allocations.
>  	 */
>  	if (alloc_size >= PAGE_SIZE)
> -		iotlb_align_mask |= ~PAGE_MASK;
> -	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
> +		alloc_align_mask |= ~PAGE_MASK;

..and alloc_align_mask specifies the desired TLB slot alignment.

>  
>  	/*
>  	 * For mappings with an alignment requirement don't bother looping to
>  	 * unaligned slots once we found an aligned one.
>  	 */
> -	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> +	stride = (max(alloc_align_mask, iotlb_align_mask) >> IO_TLB_SHIFT) + 1;

I'm not quite sure about this one.

And I'm not even sure all combinations make sense!

For example, take these values:

*         TLB_SIZE ==              0x800  (2K)
* alloc_align_mask == 0xffffffffffffc000  (16K alignment, could be page size)
* iotlb_align_mask == 0xffffffffffff0000  (64K alignment)
*        orig_addr == 0x0000000000001234

Only the lowest 16 bits are relevant for the alignment check.
Device alignment requires 0x1000.
Alloc alignment requires one of 0x0000, 0x4000, 0x8000, or 0xc000.
Obviously, such allocation must always fail...

>  
>  	spin_lock_irqsave(&area->lock, flags);
>  	if (unlikely(nslots > pool->area_nslabs - area->used))
> @@ -1015,15 +1014,18 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>  	index = area->index;
>  
>  	for (slots_checked = 0; slots_checked < pool->area_nslabs; ) {
> +		phys_addr_t tlb_addr;
> +
>  		slot_index = slot_base + index;
> +		tlb_addr = slot_addr(tbl_dma_addr, slot_index);
> +
> +		if (tlb_addr & alloc_align_mask)
> +			goto next_slot;

Awww, come on. So your code jumps to a label and then inserts an
unconditional continue just before that label? I'm sure we'll find a
cleaner way to convey the loop logic. What about this:

		if ((tlb_addr & alloc_align_mask) != 0 ||
		    (orig_addr && (tlb_addr & io_tlb_align_mask !=
				   orig_addr & iotlb_align_mask))) {
			index = wrap_area_index(pool, index + 1);
			slots_checked++;
			continue;
		}

But yes, this patch looks like it should finally do the right thing.

Petr T

>  
>  		if (orig_addr &&
> -		    (slot_addr(tbl_dma_addr, slot_index) &
> -		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
> -			index = wrap_area_index(pool, index + 1);
> -			slots_checked++;
> -			continue;
> -		}
> +		    (tlb_addr & iotlb_align_mask) !=
> +		    (orig_addr & iotlb_align_mask))
> +			goto next_slot;
>  
>  		if (!iommu_is_span_boundary(slot_index, nslots,
>  					    nr_slots(tbl_dma_addr),
> @@ -1033,6 +1035,10 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>  		}
>  		index = wrap_area_index(pool, index + stride);
>  		slots_checked += stride;
> +		continue;
> +next_slot:
> +		index = wrap_area_index(pool, index + 1);
> +		slots_checked++;
>  	}
>  
>  not_found:


