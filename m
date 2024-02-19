Return-Path: <linux-kernel+bounces-71335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06AB85A3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985422826B6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED7B2E84A;
	Mon, 19 Feb 2024 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="OVCIiY8y"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF07E2E644
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346456; cv=none; b=tuI4y+cXxQ2Ow4uNKtxm9UZk7/1kQqBkcMwUhjSiArTMGyFM5r+45Jc4PmQMKhFEAXQfHb25NdSRx/pfP/8K2HhcYtBR8SQ+5ZVJB95E2F0pb7RXp8d1oY6zzUKpsiBzt6fuewFxIrEdHKcZG4ircc824sUV1cXxeNCv+rDTwGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346456; c=relaxed/simple;
	bh=MgnsIAmWIvik9sb8MqiVIy0/Rv/O/Bg3/F+KvN/fMww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7P8/q+o2BNchCUZ7eW9+49eohe6KyLN7mF4uFbwibHozCMZ8/AKHeQzBNO3dOxUcnWUL7WwueahvFPB4LXDtYdNCbucWjOyPlTh555lti6Wfr7yvUIOUWH926UsS0e2CZpU1+8N6g3okT+yx6JxvTLBJLY1+F0YYiKZaB46BOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=OVCIiY8y; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 561A81ACB63;
	Mon, 19 Feb 2024 13:40:53 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1708346453; bh=hcFXKK9UEicR8lbLj5luyWW35H/Shii/gLNFqC84gEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OVCIiY8y8Hqgmgr0hTWkKYrwikovnAtC4p5dXmc2Hf6+Sd5xSFJP0DkJV8LxET6YC
	 8+/xWnCSu7REz3yOx9GufIuVbVShMTkWbnK0xKy9QM7rVi4HEfOLX6yreheK+MF7cb
	 Py/4Uex9ahfE3GcmSJf/jWFdRcIwF3JFdTAlzHwgKFcGSN6JraMF64D/8Fh+Mq3Zgv
	 T0taLKt6QgFfW3/tLoQpOppwe7vY864DOpT5bjat6JE78cgT/nkQVaFaS3C4rZ5SMl
	 T3KtOGmwYlzNEFl5r4muQ/D4Z/bfFvcRBW8ysn1gGHPljPbWMjLfnPMBX6fSFsKosj
	 waG9uNUn2b3Dg==
Date: Mon, 19 Feb 2024 13:40:52 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>
Subject: Re: [PATCH v3 1/3] swiotlb: Fix double-allocation of slots due to
 broken alignment handling
Message-ID: <20240219134052.6dd7e26d@meshulam.tesarici.cz>
In-Reply-To: <20240205190127.20685-2-will@kernel.org>
References: <20240205190127.20685-1-will@kernel.org>
	<20240205190127.20685-2-will@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 19:01:25 +0000
Will Deacon <will@kernel.org> wrote:

> Commit bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix"),
> which was a fix for commit 0eee5ae10256 ("swiotlb: fix slot alignment
> checks"), causes a functional regression with vsock in a virtual machine
> using bouncing via a restricted DMA SWIOTLB pool.
> 
> When virtio allocates the virtqueues for the vsock device using
> dma_alloc_coherent(), the SWIOTLB search can return page-unaligned
> allocations if 'area->index' was left unaligned by a previous allocation
> from the buffer:
> 
>  # Final address in brackets is the SWIOTLB address returned to the caller
>  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1645-1649/7168 (0x98326800)
>  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1649-1653/7168 (0x98328800)
>  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask 0x800 stride 0x2: got slot 1653-1657/7168 (0x9832a800)
> 
> This ends badly (typically buffer corruption and/or a hang) because
> swiotlb_alloc() is expecting a page-aligned allocation and so blindly
> returns a pointer to the 'struct page' corresponding to the allocation,
> therefore double-allocating the first half (2KiB slot) of the 4KiB page.
> 
> Fix the problem by treating the allocation alignment separately to any
> additional alignment requirements from the device, using the maximum
> of the two as the stride to search the buffer slots and taking care
> to ensure a minimum of page-alignment for buffers larger than a page.
> 
> Fixes: bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix")
> Fixes: 0eee5ae10256 ("swiotlb: fix slot alignment checks")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Petr T

> ---
>  kernel/dma/swiotlb.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b079a9a8e087..9ff909a0039a 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -982,7 +982,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
>  	unsigned long max_slots = get_max_slots(boundary_mask);
>  	unsigned int iotlb_align_mask =
> -		dma_get_min_align_mask(dev) | alloc_align_mask;
> +		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
>  	unsigned int nslots = nr_slots(alloc_size), stride;
>  	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>  	unsigned int index, slots_checked, count = 0, i;
> @@ -993,19 +993,18 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>  	BUG_ON(!nslots);
>  	BUG_ON(area_index >= pool->nareas);
>  
> +	/*
> +	 * For mappings with an alignment requirement don't bother looping to
> +	 * unaligned slots once we found an aligned one.
> +	 */
> +	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
> +
>  	/*
>  	 * For allocations of PAGE_SIZE or larger only look for page aligned
>  	 * allocations.
>  	 */
>  	if (alloc_size >= PAGE_SIZE)
> -		iotlb_align_mask |= ~PAGE_MASK;
> -	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
> -
> -	/*
> -	 * For mappings with an alignment requirement don't bother looping to
> -	 * unaligned slots once we found an aligned one.
> -	 */
> -	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> +		stride = max(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
>  
>  	spin_lock_irqsave(&area->lock, flags);
>  	if (unlikely(nslots > pool->area_nslabs - area->used))
> @@ -1015,11 +1014,14 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>  	index = area->index;
>  
>  	for (slots_checked = 0; slots_checked < pool->area_nslabs; ) {
> -		slot_index = slot_base + index;
> +		phys_addr_t tlb_addr;
>  
> -		if (orig_addr &&
> -		    (slot_addr(tbl_dma_addr, slot_index) &
> -		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
> +		slot_index = slot_base + index;
> +		tlb_addr = slot_addr(tbl_dma_addr, slot_index);
> +
> +		if ((tlb_addr & alloc_align_mask) ||
> +		    (orig_addr && (tlb_addr & iotlb_align_mask) !=
> +				  (orig_addr & iotlb_align_mask))) {
>  			index = wrap_area_index(pool, index + 1);
>  			slots_checked++;
>  			continue;


