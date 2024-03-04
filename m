Return-Path: <linux-kernel+bounces-91144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46558870A07
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C9A28135E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF1178B64;
	Mon,  4 Mar 2024 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="Fo3nHuCy"
Received: from bee.tesarici.cz (unknown [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE816216C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579074; cv=none; b=gk+UsW7muC3jqwLnX7+OkbFoAFZr0/e2vhoJHoJ5IVg2wZyk3oE25XigAZGhnNSpTTDfjlkrcPX6BA6vOWkkP3abl82D3BUw0mdoIYvzuF5fDr18gMTwzdaUBbVLb1R3DbTRSBTIkcAp0QLG9AjxNyD3cp5eWDkT7XLnEcDBnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579074; c=relaxed/simple;
	bh=OpcaKRhpxKs0wOB7QmV51ntNwwxhFrwNpqIrJcjmlXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2NGBZ4pHOHGpHAiQpHbnCS0kGsO/T+zMaACclN20nHcwnKDkahW9jiAmZsgl4ffbenXIdQYWJzHmnwfWPGzxy887zg1V0DqODFBJGlG2CpYo4Jg1YVYdKSkNbdvheihoPVHj8aYSIXkkSvEVLig60b5dJvK8vz7GROHmcAuBN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=Fo3nHuCy; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id AB1041C6459;
	Mon,  4 Mar 2024 20:04:29 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709579069; bh=ve+WTsjm8GalaYsBeUXZYJVXRvABnJYKupgzVA3x+6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fo3nHuCyzevUukPS4EApPbTFdWBknU7zj0Wabpd2eNjlJlFoV83SnSKiFwpwtSrS0
	 rcId2iacLg8Y7rGv3McpJhsyRw63rHb1IYhRLromNmZLXdL6zuDZUAK/ZOGBqXSBXC
	 kigxZ/qacEJwFUsydGy+uaPgFwxxkvhAkshDxC84NHS/FALvbIZnR5sTOI0s8Pdrsg
	 JayA3+6QeP+LcJ14meIxW4Ldl32elMakh3ehS4SxMRkCxss0Hy9ZI/lrhwxI/7K599
	 bGurMFB1Z6bda/tcUkA+/NGyehlcWB4F9FgBmGM3OAw1aROAdoTa1yxPIx+Qv+CYRZ
	 Q3sci9mc8SnXw==
Date: Mon, 4 Mar 2024 20:04:28 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>, "kernel-team@android.com"
 <kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Dexuan Cui
 <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Message-ID: <20240304200428.4111d78e@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB41571F68F8F9E003C4359948D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240229154756.GA10137@lst.de>
	<20240301163927.18358ee2@meshulam.tesarici.cz>
	<20240301180853.5ac20b27@meshulam.tesarici.cz>
	<8869c8b2-29c3-41e4-8f8a-5bcf9c0d22bb@arm.com>
	<20240301194212.3c64c9b2@meshulam.tesarici.cz>
	<SN6PR02MB41571DA1EE99BFAA65869024D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240304120055.56035c21@meshulam.tesarici.cz>
	<ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com>
	<20240304165506.49e3b2d3@meshulam.tesarici.cz>
	<20240304160210.GB21077@willie-the-truck>
	<SN6PR02MB41571F68F8F9E003C4359948D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Mar 2024 16:10:46 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Will Deacon <will@kernel.org> Sent: Monday, March 4, 2024 8:02 AM
> >=20
> > Hi folks,
> >=20
> > On Mon, Mar 04, 2024 at 04:55:06PM +0100, Petr Tesa=C5=99=C3=ADk wrote:=
 =20
> > > On Mon, 4 Mar 2024 13:37:56 +0000
> > > Robin Murphy <robin.murphy@arm.com> wrote: =20
> > > > On 04/03/2024 11:00 am, Petr Tesa=C5=99=C3=ADk wrote:
> > > > [...] =20
> > > > >> Here's my take on tying all the threads together. There are
> > > > >> four alignment combinations:
> > > > >>
> > > > >> 1. alloc_align_mask: zero; min_align_mask: zero =20
> >=20
> > Based on this ^^^ ...
> >  =20
> > > > >> xen_swiotlb_map_page() and dma_direct_map_page() are #1 or #2
> > > > >> via swiotlb_map() and swiotlb_tbl_map_single()
> > > > >>
> > > > >> iommu_dma_map_page() is #3 and #4 via swiotlb_tbl_map_single()
> > > > >>
> > > > >> swiotlb_alloc() is #3, directly to swiotlb_find_slots()
> > > > >>
> > > > >> For #1, the returned physical address has no constraints if
> > > > >> the requested size is less than a page. For page size or
> > > > >> greater, the discussed historical requirement for page
> > > > >> alignment applies. =20
> >=20
> > ... and this ^^^ ...
> >=20
> >  =20
> > > I believe this patch series is now good as is, except the commit
> > > message should make it clear that alloc_align_mask and min_align_mask
> > > can both be zero, but that simply means no alignment constraints. =20
> >=20
> > ... my (possibly incorrect!) reading of the thread so far is that we
> > should preserve page-aligned allocation in this case if the allocation
> > size is >=3D PAGE_SIZE.
> >=20
> > Something like the diff below, to replace this final patch?
> >=20
> > Will
> >  =20
> > --->8 =20
> >=20
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index c381a7ed718f..67eac05728c0 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -992,6 +992,14 @@ static int swiotlb_search_pool_area(struct device
> > *dev, struct io_tlb_pool *pool
> >         BUG_ON(!nslots);
> >         BUG_ON(area_index >=3D pool->nareas);
> >=20
> > +       /*
> > +        * Historically, allocations >=3D PAGE_SIZE were guaranteed to =
be
> > +        * page-aligned in the absence of any other alignment requireme=
nts.
> > +        * Since drivers may be relying on this, preserve the old behav=
iour.
> > +        */
> > +       if (!alloc_align_mask && !iotlb_align_mask && alloc_size >=3D P=
AGE_SIZE)
> > +               alloc_align_mask =3D PAGE_SIZE - 1;
> > + =20
>=20
> Yes, I think that should do it.

Sure, this will solve the allocations. But my understanding of this
same thread is that we don't need it here. The historical page order
alignment applies ONLY to allocations, NOT to mappings. It is
documented in Documentation/core-api/dma-api-howto.rst under Consistent
DMA mappings, for dma_alloc_coherent(). IIUC it does not apply to the
streaming DMA mappings. At least, it would explain why nobody
complained that the more strict guarantee for sizes greater than
PAGE_SIZE was not kept...

The SWIOTLB can be used for allocation if CONFIG_DMA_RESTRICTED_POOL=3Dy,
but this case is handled by patch 3/6 of this patch series.

Do I miss something again?

Petr T

> Michael
>=20
> >         /*
> >          * Ensure that the allocation is at least slot-aligned and upda=
te
> >          * 'iotlb_align_mask' to ignore bits that will be preserved when
> > @@ -1006,13 +1014,6 @@ static int swiotlb_search_pool_area(struct devic=
e *dev, struct io_tlb_pool *pool
> >          */
> >         stride =3D get_max_slots(max(alloc_align_mask, iotlb_align_mask=
));
> >=20
> > -       /*
> > -        * For allocations of PAGE_SIZE or larger only look for page al=
igned
> > -        * allocations.
> > -        */
> > -       if (alloc_size >=3D PAGE_SIZE)
> > -               stride =3D umax(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
> > -
> >         spin_lock_irqsave(&area->lock, flags);
> >         if (unlikely(nslots > pool->area_nslabs - area->used))
> >                 goto not_found; =20
>=20


