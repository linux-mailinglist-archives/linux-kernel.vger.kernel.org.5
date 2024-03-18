Return-Path: <linux-kernel+bounces-106119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D1087E961
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D77283A32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F5A381B8;
	Mon, 18 Mar 2024 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="mRC9Q33Y"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4E33CF1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765390; cv=none; b=ifpQTl/cJ+8KAMzxdqQL48HpraUnqGfpPsOrC44afuWIT5qWpBxqdGBt5sfom5/CtGTWhzp+7JhprCTpIwn6ZTHT1f2OZEaTWu34HmM4UDaNtECCDAujRqxJLFk77/p7gmjtOzxfi+nLnGcDSd2OowopMM0oi7OXjH1M9qZj5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765390; c=relaxed/simple;
	bh=w6v+8z+YhOwW3f6JS0gPrb++ZcNRF8i4d5DT7bIRorI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpaQcdIbCq2TlLK/yj6BT28GO/NBCzI+56ymjDSqLvrmaN1rTXwhHMUfbQRMhczSVb+LvYTfrvayYK4lCEg3ZRu+W9ZrMHawXjsT/YDWf2o3Q0TK6iCb7iRI8tBA1ejodY++pJiNpNt4h2e63fK/zOrWYHn5E0oLcsiYJ+8IrJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=mRC9Q33Y; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id E2D3619B6DC;
	Mon, 18 Mar 2024 13:36:17 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1710765378; bh=uevz9Ld0ob550XOVVlPWlxDGkxF8wBH+ABeMrkoqJgQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mRC9Q33YkyeEmz7e5nDJkCWpWCKJ0sCZlHTRRhBh8CPDzz9sCbsz668wY9Cb0liir
	 TxwI9Z0P/8RTh5GJodg010TOHpWrhssZk5tcUzen61w6K7GDGHmGI8t4unVRH0/5BV
	 6qISg4lxfyiF/+nWU6L0aIYk4u2zPcdJEJ4LfXoz8DmqVhFvppQSQv5BIdo3udq9o0
	 Oth1BNGR0XoLV3WsE5Y25GfjMGnotN/R9ioN7ldYTfJAI41bad9QPz2gbokCSkWdXO
	 AvzDtyLuxrj95zQh/zUke88J0WoneTWRxD4FnFVH3GvDFovpju8ISh8Csv90p4foYD
	 wsWpjdQA5vAjQ==
Date: Mon, 18 Mar 2024 13:36:16 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kernel-team@android.com"
 <kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v6 1/6] swiotlb: Fix double-allocation of slots due to
 broken alignment handling
Message-ID: <20240318133616.18ec5e6e@meshulam.tesarici.cz>
In-Reply-To: <BN7PR02MB41483F5D16B655F5764D14EBD42D2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20240308152829.25754-1-will@kernel.org>
	<20240308152829.25754-2-will@kernel.org>
	<BN7PR02MB41483F5D16B655F5764D14EBD42D2@BN7PR02MB4148.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Mar 2024 03:39:07 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Will Deacon <will@kernel.org> Sent: Friday, March 8, 2024 7:28 AM
> > 
> > 
> > Fix the problem by treating the allocation alignment separately to any
> > additional alignment requirements from the device, using the maximum
> > of the two as the stride to search the buffer slots and taking care
> > to ensure a minimum of page-alignment for buffers larger than a page.
> > 
> > This also resolves swiotlb allocation failures occuring due to the
> > inclusion of ~PAGE_MASK in 'iotlb_align_mask' for large allocations and
> > resulting in alignment requirements exceeding swiotlb_max_mapping_size().
> > 
> > Fixes: bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix")
> > Fixes: 0eee5ae10256 ("swiotlb: fix slot alignment checks")
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Dexuan Cui <decui@microsoft.com>
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> > Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  kernel/dma/swiotlb.c | 28 +++++++++++++++-------------
> >  1 file changed, 15 insertions(+), 13 deletions(-)
> > 
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index b079a9a8e087..2ec2cc81f1a2 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -982,7 +982,7 @@ static int swiotlb_search_pool_area(struct device
> > *dev, struct io_tlb_pool *pool
> >  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
> >  	unsigned long max_slots = get_max_slots(boundary_mask);
> >  	unsigned int iotlb_align_mask =
> > -		dma_get_min_align_mask(dev) | alloc_align_mask;
> > +		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> >  	unsigned int nslots = nr_slots(alloc_size), stride;
> >  	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
> >  	unsigned int index, slots_checked, count = 0, i;
> > @@ -993,19 +993,18 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> >  	BUG_ON(!nslots);
> >  	BUG_ON(area_index >= pool->nareas);
> > 
> > +	/*
> > +	 * For mappings with an alignment requirement don't bother looping to
> > +	 * unaligned slots once we found an aligned one.
> > +	 */
> > +	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
> > +
> >  	/*
> >  	 * For allocations of PAGE_SIZE or larger only look for page aligned
> >  	 * allocations.
> >  	 */
> >  	if (alloc_size >= PAGE_SIZE)
> > -		iotlb_align_mask |= ~PAGE_MASK;
> > -	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
> > -
> > -	/*
> > -	 * For mappings with an alignment requirement don't bother looping to
> > -	 * unaligned slots once we found an aligned one.
> > -	 */
> > -	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> > +		stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> > 
> >  	spin_lock_irqsave(&area->lock, flags);
> >  	if (unlikely(nslots > pool->area_nslabs - area->used))
> > @@ -1015,11 +1014,14 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> >  	index = area->index;
> > 
> >  	for (slots_checked = 0; slots_checked < pool->area_nslabs; ) {
> > -		slot_index = slot_base + index;
> > +		phys_addr_t tlb_addr;
> > 
> > -		if (orig_addr &&
> > -		    (slot_addr(tbl_dma_addr, slot_index) &
> > -		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
> > +		slot_index = slot_base + index;
> > +		tlb_addr = slot_addr(tbl_dma_addr, slot_index);
> > +
> > +		if ((tlb_addr & alloc_align_mask) ||
> > +		    (orig_addr && (tlb_addr & iotlb_align_mask) !=
> > +				  (orig_addr & iotlb_align_mask))) {
> >  			index = wrap_area_index(pool, index + 1);
> >  			slots_checked++;
> >  			continue;
> > --  
> 
> Question for IOMMU folks:  alloc_align_mask is set only in
> iommu_dma_map_page(), using the IOMMU granule size.
> Can the granule ever be larger than PAGE_SIZE?

I don't feel as part of the IOMMU folks, but since I have spent one and
a half aeons looking around DMA-related code, let me answer anyway.

No, this is not possible, see here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/iova.c?h=v6.8#n61

HTH
Petr T

>  If so,
> swiotlb_search_pool_area() can fail to find slots even when
> the swiotlb is empty.
> 
> The failure happens when alloc_align_mask is larger than
> PAGE_SIZE and the alloc_size is the swiotlb max of 256 Kbytes
> (or even a bit smaller in some cases). The swiotlb memory
> pool is allocated in swiotlb_memblock_alloc() with PAGE_SIZE
> alignment.  On x86/x64, if alloc_align_mask is 8191 and the
> pool start address is something like XXXX1000, slot 0 won't
> satisfy alloc_align_mask.  Slot 1 satisfies alloc_align_mask,
> but has a size of 127 slots and can't fulfill a 256 Kbyte request.
> The problem repeats through the entire swiotlb and the
> allocation fails.
> 
> Updating swiotlb_memblock_alloc() to use an alignment of
> IO_TLB_SIZE * IO_TLB_SEGSIZE (i.e., 256 Kbytes) solves the
> problem for all viable configurations.
> 
> Michael
> 


