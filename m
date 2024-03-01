Return-Path: <linux-kernel+bounces-88630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8A386E48B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9096B287397
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FB76F50F;
	Fri,  1 Mar 2024 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="H0mewWKV"
Received: from bee.tesarici.cz (unknown [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E563A8E3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307579; cv=none; b=JqI0jFwOsd3URErdCf8N+BJL1RqkVqqEXYo2prDetXcoC90tiASdSpkgrauvjW0W9kRRW/u63pU864+C8t6n9MPXT3LCLHn2TzZTK+dnv1UYV/VWSn6YHDvxGJZ8H0n4YPcrUabR3AGHEHZwgcsY4/HyQWdInXpf/HCml/4YmVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307579; c=relaxed/simple;
	bh=MgUqSXoPJkNv53osPWyAYHJspRzP4mbPdaDO/LJU97k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ursOcbwX5lRHcKFQeRPHIkZAtaRbyCp8uIBxHpi26gndqw2K7GX3y/NleyxpK0HqbJoOCcZRMx/fHWBCmtbvSaf6xGMvs1hLiJXBWUCrc6e+szs3VvDfA3254IUuGscIjOHDqcnmt9UDXdJQhp8Vc/8Wi4wT1gxsI4GMoQ2pO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=H0mewWKV; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id DE6C11C32B2;
	Fri,  1 Mar 2024 16:39:28 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709307569; bh=lhnMMcmJC5RrjEhIqhAv2s0zT/02tZlCTuNpbuEIU4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H0mewWKV/KjTw4gwzl7j6Xj1MKKMFO0f30vWMbt/+p0uWUvY16DbLVm5h4xi+yECX
	 4x+7iXVJ7YOlG4e528m8fNRjxJPHGj6a6tviz2KjvQzTYSG0WAF60Igs4Fsj0I1H1Q
	 82D6vIN7yZzi4bwNWqaYpSz1xqCULqNxnM2efF6n4/rUpRGjtrqrzjWECiwjhV4Y0U
	 mpn3nXzFZAivEdcEfZpss7cflspaBEaFT4YwzHamve4fInO4pccklB+xS/Kyh213SV
	 CHAgRwPlURdR6vLYHVq9icVNVAl34flRZDmuL9P7YtGExDCellm/r9s7WaYOkuxY4Y
	 JUvYmi0pNIHTA==
Date: Fri, 1 Mar 2024 16:39:27 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Michael Kelley <mhklinux@outlook.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>, "kernel-team@android.com"
 <kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, Dexuan Cui <decui@microsoft.com>, Nicolin Chen
 <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Message-ID: <20240301163927.18358ee2@meshulam.tesarici.cz>
In-Reply-To: <20240229154756.GA10137@lst.de>
References: <20240228133930.15400-1-will@kernel.org>
	<20240228133930.15400-7-will@kernel.org>
	<SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<SN6PR02MB41577D09E97B1D9645369D58D45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240229133346.GA7177@lst.de>
	<SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240229154756.GA10137@lst.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 16:47:56 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Feb 29, 2024 at 03:44:11PM +0000, Michael Kelley wrote:
> > Any thoughts on how that historical behavior should apply if
> > the DMA min_align_mask is non-zero, or the alloc_align_mask
> > parameter to swiotbl_tbl_map_single() is non-zero? As currently
> > used, alloc_align_mask is page aligned if the IOMMU granule is  
> > >= PAGE_SIZE. But a non-zero min_align_mask could mandate  
> > returning a buffer that is not page aligned. Perhaps do the
> > historical behavior only if alloc_align_mask and min_align_mask
> > are both zero?  
> 
> I think the driver setting min_align_mask is a clear indicator
> that the driver requested a specific alignment and the defaults
> don't apply.  For swiotbl_tbl_map_single as used by dma-iommu
> I'd have to tak a closer look at how it is used.

I'm not sure it helps in this discussion, but let me dive into a bit
of ancient history to understand how we ended up here.

IIRC this behaviour was originally motivated by limitations of PC AT
hardware. Intel 8237 is a 16-bit DMA controller. To make it somehow
usable with addresses up to 16MB (yeah, the infamous DMA zone), IBM
added a page register, but it was on a separate chip and it did not
increment when the 8237 address rolled over back to zero. Effectively,
the page register selected a 64K-aligned window of 64K buffers.
Consequently, DMA buffers could not cross a 64K physical boundary.

Thanks to how the buddy allocator works, the 64K-boundary constraint
was satisfied by allocation size, and drivers took advantage of it when
allocating device buffers. IMO software bounce buffers simply followed
the same logic that worked for buffers allocated by the buddy allocator.

OTOH min_align_mask was motivated by NVME which prescribes the value of
a certain number of low bits in the DMA address (for simplicity assumed
to be identical with the same bits in the physical address).

The only pre-existing user of alloc_align_mask is x86 IOMMU code, and
IIUC it is used to guarantee that unaligned transactions do not share
the IOMMU granule with another device. This whole thing is weird,
because swiotlb_tbl_map_single() is called like this:

                aligned_size = iova_align(iovad, size);
                phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
                                              iova_mask(iovad), dir, attrs);

Here:

* alloc_size = iova_align(iovad, size)
* alloc_align_mask = iova_mask(iovad)

Now, iova_align() rounds up its argument to a multiple of iova granule
and iova_mask() is simply "granule - 1". This works, because granule
size must be a power of 2, and I assume it must also be >= PAGE_SIZE.

In that case, the alloc_align_mask argument is not even needed if you
adjust the code to match documentation---the resulting buffer will be
aligned to a granule boundary by virtue of having a size that is a
multiple of the granule size.

To sum it up:

1. min_align_mask is by far the most important constraint. Devices will
   simply stop working if it is not met.
2. Alignment to the smallest PAGE_SIZE order which is greater than or
   equal to the requested size has been documented, and some drivers
   may rely on it.
3. alloc_align_mask is a misguided fix for a bug in the above.

Correct me if anything of the above is wrong.

HTH
Petr T

