Return-Path: <linux-kernel+bounces-78386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BCA8612CB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C121C21A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B0C7EF13;
	Fri, 23 Feb 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="JuVdXM2r"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B9A6FBF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695386; cv=none; b=U8dJQtZ7/DiSIUk4YDPMNS2SBDNhRzXv/t+zX5lGPefPJPe2n38lkWVmbhVnqYPkHeL6I10M7RPXvt23Msx9ZMkkPwwMH4r0oEovrG4wbRWDm/S8/2e7blBufinve/Y+xdxKM9W+kY0Xwzji7Py9ORGxkNul+a7o/rkLsjQdUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695386; c=relaxed/simple;
	bh=HgH0IgIyBLYiKnjpnfHSa1MktbhzM/lsh6rot6QCc6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVQ2WqpJ/0pMyER7rumZ5PlCMm+vSjHZddinAwQYMN4pP3HbxZTdFE9iXTpwoQ/y+OXrczRTrvfdbDXl9dRL6ARhwRMIHA8eIC1S1XqhnV4g19dydi8O467+PG7aGMC/ErfAiO24g85e81oQguT55hqyXfQaLtrYXpB+vHT10Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=JuVdXM2r; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 19D521B5D37;
	Fri, 23 Feb 2024 14:36:15 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1708695375; bh=8R0Jgz35RwiAAuPami73BFK87BNYyN4zzZhF/zwN98Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JuVdXM2rP5U0wYlf1/U2Jshc36ExEwcNg9WkG0cbUHdzTtTWPRI+Qu8Qh/6pouKEr
	 feiVXzKLmAbeTuDIXkyPZ69NLBozMDhhAAMYDYdHAy/fnpwmez1dfy4nbohhqWxhMk
	 4P6XlenjmkXU+c6KQ/69yruXi0wLDsMUCcAyYd4QqHMKxl3Q+aGYytqD665Xq7Fuse
	 itqMnoWuahtXoK3+y5Vry9LpWNYyiy9bHvIkp9yN3Qq/Bd2Q9SRjAEEjPwoNEMD/Ee
	 Kkb9XjGyYpn4gnP+2wH1WbS9G4WsSN/iW4Dzo6rawwRrhrRw+1wQqiQzFw8i9WNkHt
	 /dfE2c7+ilT/g==
Date: Fri, 23 Feb 2024 14:36:13 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kernel-team@android.com"
 <kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v4 1/5] swiotlb: Fix double-allocation of slots due to
 broken alignment handling
Message-ID: <20240223143613.1878beb6@meshulam.tesarici.cz>
In-Reply-To: <20240223124742.GB10641@willie-the-truck>
References: <20240221113504.7161-1-will@kernel.org>
	<20240221113504.7161-2-will@kernel.org>
	<SN6PR02MB4157089980E6FC58D5557BCED4572@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240223124742.GB10641@willie-the-truck>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 12:47:43 +0000
Will Deacon <will@kernel.org> wrote:

> On Wed, Feb 21, 2024 at 11:35:44PM +0000, Michael Kelley wrote:
> > From: Will Deacon <will@kernel.org> Sent: Wednesday, February 21, 2024 3:35 AM  
> > > 
> > > Commit bbb73a103fbb ("swiotlb: fix a braino in the alignment check fix"),
> > > which was a fix for commit 0eee5ae10256 ("swiotlb: fix slot alignment
> > > checks"), causes a functional regression with vsock in a virtual machine
> > > using bouncing via a restricted DMA SWIOTLB pool.
> > > 
> > > When virtio allocates the virtqueues for the vsock device using
> > > dma_alloc_coherent(), the SWIOTLB search can return page-unaligned
> > > allocations if 'area->index' was left unaligned by a previous allocation
> > > from the buffer:
> > > 
> > >  # Final address in brackets is the SWIOTLB address returned to the caller
> > >  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask
> > > 0x800 stride 0x2: got slot 1645-1649/7168 (0x98326800)
> > >  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask
> > > 0x800 stride 0x2: got slot 1649-1653/7168 (0x98328800)
> > >  | virtio-pci 0000:00:07.0: orig_addr 0x0 alloc_size 0x2000, iotlb_align_mask
> > > 0x800 stride 0x2: got slot 1653-1657/7168 (0x9832a800)
> > > 
> > > This ends badly (typically buffer corruption and/or a hang) because
> > > swiotlb_alloc() is expecting a page-aligned allocation and so blindly
> > > returns a pointer to the 'struct page' corresponding to the allocation,
> > > therefore double-allocating the first half (2KiB slot) of the 4KiB page.
> > > 
> > > Fix the problem by treating the allocation alignment separately to any
> > > additional alignment requirements from the device, using the maximum
> > > of the two as the stride to search the buffer slots and taking care
> > > to ensure a minimum of page-alignment for buffers larger than a page.  
> > 
> > Could you also add some text that this patch fixes the scenario I
> > described in the other email thread?  Something like:
> > 
> > The changes to page alignment handling also fix a problem when
> > the alloc_align_mask is zero.  The page alignment handling added
> > in the two mentioned commits could force alignment to more bits
> > in orig_addr than specified by the device's DMA min_align_mask,
> > resulting in a larger offset.   Since swiotlb_max_mapping_size()
> > is based only on the DMA min_align_mask, that larger offset
> > plus the requested size could exceed IO_TLB_SEGSIZE slots, and
> > the mapping could fail when it shouldn't.  
> 
> Thanks, Michael. I can add that in.
> 
> > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > index b079a9a8e087..2ec2cc81f1a2 100644
> > > --- a/kernel/dma/swiotlb.c
> > > +++ b/kernel/dma/swiotlb.c
> > > @@ -982,7 +982,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> > >  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
> > >  	unsigned long max_slots = get_max_slots(boundary_mask);
> > >  	unsigned int iotlb_align_mask =
> > > -		dma_get_min_align_mask(dev) | alloc_align_mask;
> > > +		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> > >  	unsigned int nslots = nr_slots(alloc_size), stride;
> > >  	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
> > >  	unsigned int index, slots_checked, count = 0, i;
> > > @@ -993,19 +993,18 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> > >  	BUG_ON(!nslots);
> > >  	BUG_ON(area_index >= pool->nareas);
> > > 
> > > +	/*
> > > +	 * For mappings with an alignment requirement don't bother looping to
> > > +	 * unaligned slots once we found an aligned one.
> > > +	 */
> > > +	stride = get_max_slots(max(alloc_align_mask, iotlb_align_mask));
> > > +
> > >  	/*
> > >  	 * For allocations of PAGE_SIZE or larger only look for page aligned
> > >  	 * allocations.
> > >  	 */
> > >  	if (alloc_size >= PAGE_SIZE)
> > > -		iotlb_align_mask |= ~PAGE_MASK;
> > > -	iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
> > > -
> > > -	/*
> > > -	 * For mappings with an alignment requirement don't bother looping to
> > > -	 * unaligned slots once we found an aligned one.
> > > -	 */
> > > -	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> > > +		stride = umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);  
> > 
> > Is this special handling of alloc_size >= PAGE_SIZE really needed?  
> 
> I've been wondering that as well, but please note that this code (and the
> comment) are in the upstream code, so I was erring in favour of keeping
> that while fixing the bugs. We could have an extra patch dropping it if
> we can convince ourselves that it's not adding anything, though.
> 
> > I think the comment is somewhat inaccurate. If orig_addr is non-zero, and
> > alloc_align_mask is zero, the requirement is for the alignment to match
> > the DMA min_align_mask bits in orig_addr, even if the allocation is
> > larger than a page.   And with Patch 3 of this series, the swiotlb_alloc()
> > case passes in alloc_align_mask to handle page size and larger requests.
> > So it seems like this doesn't do anything useful unless orig_addr and
> > alloc_align_mask are both zero, and there aren't any cases of that
> > after this patch series.  If the caller wants alignment, specify
> > it with alloc_align_mask.  
> 
> It's an interesting observation. Presumably the intention here is to
> reduce the cost of the linear search, but the code originates from a
> time when we didn't have iotlb_align_mask or alloc_align_mask and so I
> tend to agree that it should probably just be dropped. I'm also not even
> convinced that it works properly if the initial search index ends up
> being 2KiB (i.e. slot) aligned -- we'll end up jumping over the
> page-aligned addresses!

Originally, SWIOTLB was not used for allocations, so orig_addr was
never zero. The assumption was that if the bounce buffer should be
page-aligned, then the original buffer was also page-aligned, and the
check against iotlb_align_mask was sufficient.

> I'll add another patch to v5 which removes this check (and you've basically
> written the commit message for me, so thanks).
> 
> > >  	spin_lock_irqsave(&area->lock, flags);
> > >  	if (unlikely(nslots > pool->area_nslabs - area->used))
> > > @@ -1015,11 +1014,14 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
> > >  	index = area->index;
> > > 
> > >  	for (slots_checked = 0; slots_checked < pool->area_nslabs; ) {
> > > -		slot_index = slot_base + index;
> > > +		phys_addr_t tlb_addr;
> > > 
> > > -		if (orig_addr &&
> > > -		    (slot_addr(tbl_dma_addr, slot_index) &
> > > -		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
> > > +		slot_index = slot_base + index;
> > > +		tlb_addr = slot_addr(tbl_dma_addr, slot_index);
> > > +
> > > +		if ((tlb_addr & alloc_align_mask) ||
> > > +		    (orig_addr && (tlb_addr & iotlb_align_mask) !=
> > > +				  (orig_addr & iotlb_align_mask))) {  
> > 
> > It looks like these changes will cause a mapping failure in some
> > iommu_dma_map_page() cases that previously didn't fail.  
> 
> Hmm, it's really hard to tell. This code has been quite badly broken for
> some time, so I'm not sure how far back you have to go to find a kernel
> that would work properly (e.g. for Nicolin's case with 64KiB pages).

I believe it fails exactly in the cases that previously found an
incorrectly aligned bounce buffer.

In any case, the "middle" bits (low bits but ignoring offset inside a
slot) of tlb_addr should indeed correspond to the middle bits of
orig_addr.

> 
> > Everything is made right by Patch 4 of your series, but from a
> > bisect standpoint, there will be a gap where things are worse.
> > In [1], I think Nicolin reported a crash with just this patch applied.  
> 
> In Nicolin's case, I think it didn't work without the patch either, this
> just triggered the failure earlier.
> 
> > While the iommu_dma_map_page() case can already fail due to
> > "too large" requests because of not setting a max mapping size,
> > this patch can cause smaller requests to fail as well until Patch 4
> > gets applied.  That might be problem to avoid, perhaps by
> > merging the Patch 4 changes into this patch.  
> 
> I'll leave this up to Christoph. Personally, I'm keen to avoid having
> a giant patch trying to fix all the SWIOTLB allocation issues in one go,
> as it will inevitably get reverted due to a corner case that we weren't
> able to test properly, breaking the common cases at the same time.

I tend to think that more patches are better, even though this patch
alone does introduce some regressions.

Petr T

