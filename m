Return-Path: <linux-kernel+bounces-97439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007F1876A7B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B612821D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F985102A;
	Fri,  8 Mar 2024 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="F3AtGLuO"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F423A282EB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921292; cv=none; b=KYsFZ6EeIdXjmyDHRplHTxGNMwcMJqtqd/EANm2W1s7TR6XGjqIYsqeSKdAZ9mXho734k5B6TiP0ad/0hhQ/x8L5CDv1b+qqDjFFOiOThAptrc8wbVbqqYBcPaSY2Ji8l+d/CBu6AKUJotle7i8YiXkleDa5Tub4yKSjLhuW0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921292; c=relaxed/simple;
	bh=llig45hej0d2HciGt7hMF4l08MvpOtnxKAgR61xjClI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVkigiE6TAZvGQBctQA+26HOY8c6sVQP3BoQaXMCJYc8DHbHMqOapfvJ/EpRZl/7eG0AbkMkV7hwYx9L4Wr5KABbYjt/Zdrs/WrQ3f3Q/CbQRyMbLoFFpBf7QfWejPwVYrO1O2ojuK44RO4vDaRg9sudYiBnoeJyFfAZPF66Ov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=F3AtGLuO; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id CC2E01CC3EA;
	Fri,  8 Mar 2024 19:08:07 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709921288; bh=/Ywz2SvhfWP7fD0h2M7iW5nTRwOnfNV4nPJrd8EunkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F3AtGLuOs9vhJoAWtUwNG8iK63GnZi1kWput0MZSWylkNoypBga/iY0OhNynwFxKI
	 zOIIRjAD0SvlcLe+JJZJlClGyiHmTDf+B43OpkogWJTmlvA87f9T22//oN9v0FwgTY
	 1lhf8RrV2IkcsRumf/sSXXTgFPuwPjuCjFUUiO4siF+iPED1/lAPtb1sIeVtXq6FQ8
	 p7ywLKUD8ROMQWcOnwJU6rWTRjn2VSEXkVdpG2HlC05xI0NHi9cPOWC57uryjUtIeq
	 V83SfX/gxn8cx+wzMfCrqKdmiH+sRQd1jCeybYUxw/m1ppddSpAMzQ0oFERWG5pJnq
	 6dRFv68tPlZcQ==
Date: Fri, 8 Mar 2024 19:08:06 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-team@android.com, iommu@lists.linux.dev, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>, Dexuan Cui <decui@microsoft.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 6/6] swiotlb: Reinstate page-alignment for mappings
 >= PAGE_SIZE
Message-ID: <20240308190806.06507e25@meshulam.tesarici.cz>
In-Reply-To: <9597a3ea-b71f-46bd-bc72-1d19e81dcfb5@arm.com>
References: <20240308152829.25754-1-will@kernel.org>
	<20240308152829.25754-7-will@kernel.org>
	<5c7c7407-5356-4e12-a648-ae695fe0d1cb@arm.com>
	<20240308173816.5351ea58@meshulam.tesarici.cz>
	<9597a3ea-b71f-46bd-bc72-1d19e81dcfb5@arm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Mar 2024 17:17:51 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2024-03-08 4:38 pm, Petr Tesa=C5=99=C3=ADk wrote:
> > On Fri, 8 Mar 2024 16:08:01 +0000
> > Robin Murphy <robin.murphy@arm.com> wrote:
> >  =20
> >> On 2024-03-08 3:28 pm, Will Deacon wrote: =20
> >>> For swiotlb allocations >=3D PAGE_SIZE, the slab search historically
> >>> adjusted the stride to avoid checking unaligned slots. This had the
> >>> side-effect of aligning large mapping requests to PAGE_SIZE, but that
> >>> was broken by 0eee5ae10256 ("swiotlb: fix slot alignment checks").
> >>>
> >>> Since this alignment could be relied upon drivers, reinstate PAGE_SIZE
> >>> alignment for swiotlb mappings >=3D PAGE_SIZE. =20
> >>
> >> This seems clear enough to keep me happy now, thanks! And apologies th=
at
> >> I managed to confuse even myself in the previous thread...
> >>
> >> Reviewed-by: Robin Murphy <robin.murphy@arm.com> =20
> >=20
> > I thought we agreed that this stricter alignment is unnecessary:
> >=20
> >    https://lore.kernel.org/linux-iommu/20240305140833.GC3659@lst.de/ =20
>=20
> No, that was about dma_alloc_coherent() again (and TBH I'm not sure we=20
> should actually relax it anyway, since there definitely are callers who=20
> rely on size-alignment beyond PAGE_SIZE, however they're typically going=
=20
> to be using the common implementations which end up in alloc_pages() or=20
> CMA and so do offer that, rather than the oddball ones which don't -=20
> e.g. we're never going to be allocating SMMUv3 Stream Tables out of some=
=20
> restricted pool via the emergency swiotlb_alloc() path). If anywhere,=20
> the place to argue that point would be patch #3 (which as mentioned I'd=20
> managed to forget about before...)

Sure, swiotlb_alloc() ensures that alloc_align_mask is non-zero, so the
condition in this patch cannot be met. In fact, that's why it could be
moved up to swiotlb_tbl_map_single().

> This one's just about preserving a SWIOTLB-specific behaviour which has=20
> the practical effect of making SWIOTLB a bit less visible to dma_map_*()=
=20
> callers. The impact of keeping this is fairly low, so seems preferable=20
> to the risk of facing issues 2 or 3 years down the line when someone=20
> finally upgrades their distro and their data gets eaten because it turns=
=20
> out some obscure driver should really have been updated to use=20
> min_align_mask.

The impact is indeed negligible with 4K pages. It may put a bit of
stress on the SWIOTLB with 64K pages, but if the mapping size somehow
correlates with page size, such drivers would need a larger SWIOTLB
anyway.

I had some doubts if there are any guarantees at all for dma_map_*().
Now I see that the email I linked dealt with dma_alloc_coherent().

OK, let's not open the other discussion now.

Petr T

> Thanks,
> Robin.
>=20
> > But if everybody else wants to have it...
> >=20
> > Petr T
> >  =20
> >>> Reported-by: Michael Kelley <mhklinux@outlook.com>
> >>> Signed-off-by: Will Deacon <will@kernel.org>
> >>> ---
> >>>    kernel/dma/swiotlb.c | 18 +++++++++++-------
> >>>    1 file changed, 11 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> >>> index c381a7ed718f..c5851034523f 100644
> >>> --- a/kernel/dma/swiotlb.c
> >>> +++ b/kernel/dma/swiotlb.c
> >>> @@ -992,6 +992,17 @@ static int swiotlb_search_pool_area(struct devic=
e *dev, struct io_tlb_pool *pool
> >>>    	BUG_ON(!nslots);
> >>>    	BUG_ON(area_index >=3D pool->nareas);
> >>>   =20
> >>> +	/*
> >>> +	 * Historically, swiotlb allocations >=3D PAGE_SIZE were guaranteed=
 to be
> >>> +	 * page-aligned in the absence of any other alignment requirements.
> >>> +	 * 'alloc_align_mask' was later introduced to specify the alignment
> >>> +	 * explicitly, however this is passed as zero for streaming mappings
> >>> +	 * and so we preserve the old behaviour there in case any drivers a=
re
> >>> +	 * relying on it.
> >>> +	 */
> >>> +	if (!alloc_align_mask && !iotlb_align_mask && alloc_size >=3D PAGE_=
SIZE)
> >>> +		alloc_align_mask =3D PAGE_SIZE - 1;
> >>> +
> >>>    	/*
> >>>    	 * Ensure that the allocation is at least slot-aligned and update
> >>>    	 * 'iotlb_align_mask' to ignore bits that will be preserved when
> >>> @@ -1006,13 +1017,6 @@ static int swiotlb_search_pool_area(struct dev=
ice *dev, struct io_tlb_pool *pool
> >>>    	 */
> >>>    	stride =3D get_max_slots(max(alloc_align_mask, iotlb_align_mask));
> >>>   =20
> >>> -	/*
> >>> -	 * For allocations of PAGE_SIZE or larger only look for page aligned
> >>> -	 * allocations.
> >>> -	 */
> >>> -	if (alloc_size >=3D PAGE_SIZE)
> >>> -		stride =3D umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> >>> -
> >>>    	spin_lock_irqsave(&area->lock, flags);
> >>>    	if (unlikely(nslots > pool->area_nslabs - area->used))
> >>>    		goto not_found; =20
> >> =20
> >  =20
>=20


