Return-Path: <linux-kernel+bounces-104396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDF687CD39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7488D282456
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64141C68D;
	Fri, 15 Mar 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="P1X2/M3w"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915221C2A6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505586; cv=none; b=bABv7ezFLdEuHp6cdHDbRv6r+sqy+NtQS5O9RM1knVf2RRz2/KrQKUyqrvtXyUX0Fm0heYZlsPUNxRr7whb4E8vJDxx0+Vo0ECp3t/nwJU3jRX2+ufT649YUrnnnYyiMh0XzXMbJ57Fk10RdoQWKZ/o4BuC6Nblb8cGPSgSHIpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505586; c=relaxed/simple;
	bh=1fxlJ4/KRUqR2rfFCvZ/fuQqvMdOyXlK+0xVU09W/1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSulxPTpcmKXAgBbr+Jse/+UZY0CditqTtN8jondmAUrXEEg3TYvJ1TlE/+9gHRNuO8F1ZR83r6WgD9poM2z5TTJUL/S/+r9Wsj1km5HL9/kRUv7qWDf7+VnCeU/m9qdm/8Z6mPPzhljfRjme0g+ZfpC4wkBgsEs6Kuwp6CylKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=P1X2/M3w; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 4425C196C4E;
	Fri, 15 Mar 2024 13:26:15 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1710505575; bh=nUQ+GlUQvTJOM20SXQiuZ/zMFi5PaDtLiTcb8MpIbKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P1X2/M3w/cFa5ZWrYRWbi+AORGgfhywL1MiX1Ivqdrlrb6Albg/PqGmjN3rnEZ9eq
	 WR5jizmeLzcbY4L8Ianlqv++SctAoQpksW7QNS6/B5IPHHpvK/xeIKx8VoSmpqExXn
	 uWuBMcQjTDWMGQD4EdFDhEgeb/y4BkgWvGpWe9zdnbrHGL/lp5dhFZpJlNtNf8NVSK
	 VbUOxNK90+qKdE3ptpGTLKEjcKuJHk3dgb7u7L+ZtGgTyuv9VGrJKeXWKv8grrYpj7
	 GaV0Hpqsnr2qLYN91dZHaQhOll2AM4KIMVKN8nRtIH6Y9NrUnbcE0aERv1E5RwORU6
	 nFOE0rVCioF5A==
Date: Fri, 15 Mar 2024 13:26:13 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Nicolin Chen
 <nicolinc@nvidia.com>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, Roberto
 Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH 1/1] swiotlb: extend buffer pre-padding to
 alloc_align_mask if necessary
Message-ID: <20240315132613.5a340a69@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB4157FB27CD890E9F29408926D4282@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240312134149.497-1-petrtesarik@huaweicloud.com>
	<SN6PR02MB4157FB27CD890E9F29408926D4282@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Mar 2024 02:53:10 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesarik <petrtesarik@huaweicloud.com> Sent: Tuesday, March 12, 2024 6:42 AM
> > 
> > Allow a buffer pre-padding of up to alloc_align_mask. If the allocation
> > alignment is bigger than IO_TLB_SIZE and min_align_mask covers any non-zero
> > bits in the original address between IO_TLB_SIZE and alloc_align_mask,
> > these bits are not preserved in the swiotlb buffer address.
> > 
> > To fix this case, increase the allocation size and use a larger offset
> > within the allocated buffer. As a result, extra padding slots may be
> > allocated before the mapping start address.
> > 
> > Set the orig_addr in these padding slots to INVALID_PHYS_ADDR, because they
> > do not correspond to any CPU buffer and the data must never be synced.
> > 
> > The padding slots should be automatically released when the buffer is
> > unmapped. However, swiotlb_tbl_unmap_single() takes only the address of the
> > DMA buffer slot, not the first padding slot. Save the number of padding
> > slots in struct io_tlb_slot and use it to adjust the slot index in
> > swiotlb_release_slots(), so all allocated slots are properly freed.
> >   
> 
> I've been staring at this the past two days, and have run tests with
> various min_align_masks and alloc_masks against orig_addr's with
> various alignments and mapping sizes.  I'm planning to run additional
> tests over the weekend, but I think it's solid.  See a few comments
> below.
> 
> > Fixes: 2fd4fa5d3fb5 ("swiotlb: Fix alignment checks when both allocation and DMA masks are present")
> > Link: https://lore.kernel.org/linux-iommu/20240311210507.217daf8b@meshulam.tesarici.cz/
> > Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > ---
> >  kernel/dma/swiotlb.c | 34 +++++++++++++++++++++++++++++-----
> >  1 file changed, 29 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 86fe172b5958..8ce11abc691f 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -69,11 +69,13 @@
> >   * @alloc_size:	Size of the allocated buffer.
> >   * @list:	The free list describing the number of free entries available
> >   *		from each index.
> > + * @padding:    Number of preceding padding slots.
> >   */
> >  struct io_tlb_slot {
> >  	phys_addr_t orig_addr;
> >  	size_t alloc_size;
> >  	unsigned int list;
> > +	unsigned int padding;  
> 
> Even without the padding field, I presume that in
> 64-bit builds this struct is already 24 bytes in size so as
> to maintain 64-bit alignment for the orig_addr and
> alloc_size fields. If that's the case, then adding the
> padding field doesn't change the amount of memory
> required for the slot array.  Is that correct? Both the
> "list" and "padding" fields contain only small integers,
> but presumably reducing their size from "int" to "short"
> wouldn't help except in 32-bit builds.

That's correct. In 64-bit builds, this is the layout before my patch:

/* offset      |    size */  type = struct io_tlb_slot {
/*      0      |       8 */    phys_addr_t orig_addr;
/*      8      |       8 */    size_t alloc_size;
/*     16      |       4 */    unsigned int list;
/* XXX  4-byte padding   */

                               /* total size (bytes):   24 */
                             }

And this is the layout after my patch:

/* offset      |    size */  type = struct io_tlb_slot {
/*      0      |       8 */    phys_addr_t orig_addr;
/*      8      |       8 */    size_t alloc_size;
/*     16      |       4 */    unsigned int list;
/*     20      |       4 */    unsigned int padding;

                               /* total size (bytes):   24 */
                             }

Admittedly, I haven't really considered 32-bit builds. The layout
depends on the size of phys_addr_t. For example, on 32-bit Arm with
32-bit physical addresses, the struct grows from 12 bytes to 16 bytes. 
With 32-bit physical addresses, it grows from 16 bytes to 24 bytes
(with a 4-byte padding at the end, due to a stricter Arm ABI alignment
requirements). On other platforms, it would be only 20 bytes.

The default SWIOTLB size is 64M, divided into 32K slots of 2K each.
If each slot grows by 8 bytes, runtime memory consumption increases by
256K. That's not much, but I agree that it can be zero if the type is
changed to unsigned short. And there is no downside AFAICS.

FTR the maximum value that can be stored in these two fields is
IO_TLB_SEGSIZE. This constant has never ever changed, but I can add a
BUILD_BUG_ON() to swiotlb_init_io_tlb_pool(), just to make sure.

> >  };
> > 
> >  static bool swiotlb_force_bounce;
> > @@ -287,6 +289,7 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
> >  					 mem->nslabs - i);
> >  		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> >  		mem->slots[i].alloc_size = 0;
> > +		mem->slots[i].padding = 0;
> >  	}
> > 
> >  	memset(vaddr, 0, bytes);
> > @@ -1328,11 +1331,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> >  		unsigned long attrs)
> >  {
> >  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> > -	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
> > +	unsigned int offset;
> >  	struct io_tlb_pool *pool;
> >  	unsigned int i;
> >  	int index;
> >  	phys_addr_t tlb_addr;
> > +	unsigned int padding;
> > 
> >  	if (!mem || !mem->nslabs) {
> >  		dev_warn_ratelimited(dev,
> > @@ -1349,6 +1353,15 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> >  		return (phys_addr_t)DMA_MAPPING_ERROR;
> >  	}
> > 
> > +	/*
> > +	 * Calculate buffer pre-padding within the allocated space. Use it to
> > +	 * preserve the low bits of the original address according to device's
> > +	 * min_align_mask. Limit the padding to alloc_align_mask or slot size
> > +	 * (whichever is bigger); higher bits of the original address are
> > +	 * preserved by selecting a suitable IO TLB slot.
> > +	 */
> > +	offset = orig_addr & dma_get_min_align_mask(dev) &
> > +		(alloc_align_mask | (IO_TLB_SIZE - 1));
> >  	index = swiotlb_find_slots(dev, orig_addr,
> >  				   alloc_size + offset, alloc_align_mask, &pool);
> >  	if (index == -1) {
> > @@ -1364,6 +1377,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
> >  	 * This is needed when we sync the memory.  Then we sync the buffer if
> >  	 * needed.
> >  	 */
> > +	padding = 0;
> > +	while (offset >= IO_TLB_SIZE) {
> > +		pool->slots[index++].orig_addr = INVALID_PHYS_ADDR;
> > +		pool->slots[index].padding = ++padding;
> > +		offset -= IO_TLB_SIZE;
> > +	}  
> 
> Looping to fill in the padding slots seems unnecessary.
> The orig_addr field should already be initialized to
> INVALID_PHYS_ADDR, and the padding field should already
> be initialized to zero.

Ack.

> The value of "padding" should be just
> (offset / IO_TLB_SIZE), and it only needs to be stored in the
> first non-padding slot where swiotlb_release_slots() will
> find it.

This is also right. I asked myself the question what should happen if
somebody passes a padding slot's address to swiotlb_tbl_unmap_single().
Of course, it's an invalid address, but as a proponent of defensive
programming, I still asked what would be the best response? If I store
padding in each slot, the whole block is released. If I store it only
in the first non-padding slot, some slots may leak.

On a second thought, the resulting SWIOTLB state is consistent either
way, and we don't to care about leaking some slots if a driver is
buggy. Maybe it's even better, because the leak will be noticed.

In short, I agree, let's keep the code simple.

Thank you for your review!

Petr T

> FWIW, your while loop above feels a bit weird in that it
> updates two different slots each time through the loop,
> and the padding field of the first padding slot isn't
> updated. It took me a little while to figure that out. :-)
> 
> >  	for (i = 0; i < nr_slots(alloc_size + offset); i++)
> >  		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
> >  	tlb_addr = slot_addr(pool->start, index) + offset;
> > @@ -1385,12 +1404,16 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
> >  	struct io_tlb_pool *mem = swiotlb_find_pool(dev, tlb_addr);
> >  	unsigned long flags;
> >  	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
> > -	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> > -	int nslots = nr_slots(mem->slots[index].alloc_size + offset);
> > -	int aindex = index / mem->area_nslabs;
> > -	struct io_tlb_area *area = &mem->areas[aindex];
> > +	int index, nslots, aindex;
> > +	struct io_tlb_area *area;
> >  	int count, i;
> > 
> > +	index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> > +	index -= mem->slots[index].padding;
> > +	nslots = nr_slots(mem->slots[index].alloc_size + offset);
> > +	aindex = index / mem->area_nslabs;
> > +	area = &mem->areas[aindex];
> > +
> >  	/*
> >  	 * Return the buffer to the free list by setting the corresponding
> >  	 * entries to indicate the number of contiguous entries available.
> > @@ -1413,6 +1436,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
> >  		mem->slots[i].list = ++count;
> >  		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> >  		mem->slots[i].alloc_size = 0;
> > +		mem->slots[i].padding = 0;
> >  	}
> > 
> >  	/*
> > --
> > 2.34.1  
> 
> 


