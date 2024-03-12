Return-Path: <linux-kernel+bounces-100075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D1987916E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37DC1F21546
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427FF7828F;
	Tue, 12 Mar 2024 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="O0LZcLdz"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511E78281
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237071; cv=none; b=sys34XwlkNrB/o+Me+29jEkPw+9sEqVaO6kFfPjCOkd9j/BS8nQ2sG+4p9ntQvfZl8YePfYLH63LAOFsK1wAlujYfpLuzGjX66GxjcKAjTMCPKfEL7Lcae6C0qBMNHju7muMAcUiyK71COB/iYTFnCNqsnU8yDCXcJuY8Pt+s5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237071; c=relaxed/simple;
	bh=q9cF3W4HhfUtM6qiP3Fjdf8cOQZLluH7mCeYVfInB5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRy/yq0OpKrMzlV7k2OOWve713BoxNazQRkR5QeJC06WViye2qrWY87o6y/s5wmaU6ehY/1CPnRLoaDfk2Cdn6/Rsf/kcHeeQV6aO4KsBuayL01hVnCqKXedDglquKaf3b1dN0O72zcdEm5QLjH/vMVY8Q6K0Ah/AUvNyl1hg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=O0LZcLdz; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id D4CC4191C53;
	Tue, 12 Mar 2024 10:51:05 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1710237066; bh=+L8nqHiSmkSw9X72yYOeoYMK8MNIe/PP6kCWRdsEYzA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O0LZcLdzMl4KHzyTiI0pAppXiVFIDvs4JG2fV3dhwiE5IJn/29g9lysGmMX0rd/sG
	 Fkm3v87HTY5YjY1mwSySq1i3oYVXS+pRYD7xyg1VKO+D6xCJXScy4ld+kirsrGcXR2
	 cuO7LK3I/8xwimT7A2OPOUGFGiackbdhaNzKJz0l27cgIde7y2vQf67hOvcQb9yqZX
	 RcLnqDqUv6W1xlxeOiUrzlFrJWkVn6kxzezfjdPNCWgpe1B3w1K9XA5Lsh0FO+YBpn
	 k/4jLDB5RgupTO2a2ZD1Ku5Yta8/u3h0VN/CmPNoy/V+8wCGoYpsftE/KYOjszSbMd
	 qOwrI7iUAI2WA==
Date: Tue, 12 Mar 2024 10:51:03 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kernel-team@android.com"
 <kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v6 4/6] swiotlb: Fix alignment checks when both
 allocation and DMA masks are present
Message-ID: <20240312105103.0f3b6a80@meshulam.tesarici.cz>
In-Reply-To: <2612acb1-48f9-4117-ae06-9b8f430034ca@arm.com>
References: <20240308152829.25754-1-will@kernel.org>
	<20240308152829.25754-5-will@kernel.org>
	<20240311210507.217daf8b@meshulam.tesarici.cz>
	<SN6PR02MB41576E58DDF5A56FC6FC1EB6D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240311224910.GA28426@willie-the-truck>
	<20240312095223.7a05d5b8@meshulam.tesarici.cz>
	<2612acb1-48f9-4117-ae06-9b8f430034ca@arm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Mar 2024 09:38:36 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2024-03-12 8:52 am, Petr Tesa=C5=99=C3=ADk wrote:
> > On Mon, 11 Mar 2024 22:49:11 +0000
> > Will Deacon <will@kernel.org> wrote:
> >  =20
> >> On Mon, Mar 11, 2024 at 09:36:10PM +0000, Michael Kelley wrote: =20
> >>> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> =20
> >>>> On Fri,  8 Mar 2024 15:28:27 +0000
> >>>> Will Deacon <will@kernel.org> wrote: =20
> >>>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> >>>>> index c20324fba814..c381a7ed718f 100644
> >>>>> --- a/kernel/dma/swiotlb.c
> >>>>> +++ b/kernel/dma/swiotlb.c
> >>>>> @@ -981,8 +981,7 @@ static int swiotlb_search_pool_area(struct devi=
ce *dev, struct io_tlb_pool *pool
> >>>>>   	dma_addr_t tbl_dma_addr =3D
> >>>>>   		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
> >>>>>   	unsigned long max_slots =3D get_max_slots(boundary_mask);
> >>>>> -	unsigned int iotlb_align_mask =3D
> >>>>> -		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> >>>>> +	unsigned int iotlb_align_mask =3D dma_get_min_align_mask(dev);
> >>>>>   	unsigned int nslots =3D nr_slots(alloc_size), stride;
> >>>>>   	unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
> >>>>>   	unsigned int index, slots_checked, count =3D 0, i;
> >>>>> @@ -993,6 +992,14 @@ static int swiotlb_search_pool_area(struct dev=
ice *dev, struct io_tlb_pool *pool
> >>>>>   	BUG_ON(!nslots);
> >>>>>   	BUG_ON(area_index >=3D pool->nareas);
> >>>>>
> >>>>> +	/*
> >>>>> +	 * Ensure that the allocation is at least slot-aligned and update
> >>>>> +	 * 'iotlb_align_mask' to ignore bits that will be preserved when
> >>>>> +	 * offsetting into the allocation.
> >>>>> +	 */
> >>>>> +	alloc_align_mask |=3D (IO_TLB_SIZE - 1);
> >>>>> +	iotlb_align_mask &=3D ~alloc_align_mask;
> >>>>> + =20
> >>>>
> >>>> I have started writing the KUnit test suite, and the results look
> >>>> incorrect to me for this case.
> >>>>
> >>>> I'm calling swiotlb_tbl_map_single() with:
> >>>>
> >>>> * alloc_align_mask =3D 0xfff
> >>>> * a device with min_align_mask =3D 0xfff
> >>>> * the 12 lowest bits of orig_addr are 0xfa0
> >>>>
> >>>> The min_align_mask becomes zero after the masking added by this patc=
h,
> >>>> and the 12 lowest bits of the returned address are 0x7a0, i.e. not
> >>>> equal to 0xfa0. =20
> >>>
> >>> The address returned by swiotlb_tbl_map_single() is the slot index
> >>> converted to an address, plus the offset modulo the min_align_mask for
> >>> the device.  The local variable "offset" in swiotlb_tbl_map_single()
> >>> should be 0xfa0.  The slot index should be an even number to meet
> >>> the alloc_align_mask requirement.  And the pool->start address should
> >>> be at least page aligned, producing a page-aligned address *before* t=
he
> >>> offset is added. Can you debug which of these isn't true for the case
> >>> you are seeing? =20
> >>
> >> I was just looking into this, and I think the problem starts because
> >> swiotlb_align_offset() doesn't return the offset modulo the min_align_=
mask,
> >> but instead returns the offset *into the slot*:
> >>
> >> 	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
> >>
> >> so this presumably lops off bit 11 without adjusting the slot number. =
=20
> >=20
> > Yes. You will never see an offset bigger than IO_TLB_SIZE.
> >  =20
> >> I don't think swiotlb_find_slots() should be handling this though; it's
> >> more about how swiotlb_tbl_map_single() puts the address back together
> >> again. =20
> >>>> In other words, the min_align_mask constraint is not honored. Of cou=
rse,
> >>>> given the above values, it is not possible to honor both min_align_m=
ask
> >>>> and alloc_align_mask. =20
> >>>
> >>> When orig_addr is specified and min_align_mask is set, alloc_align_ma=
sk
> >>> governs the address of the _allocated_ space, which is not necessaril=
y the
> >>> returned physical address.  The min_align_mask may dictate some
> >>> pre-padding of size "offset" within the allocated space, and the retu=
rned
> >>> address is *after* that pre-padding.  In this way, both can be honore=
d. =20
> >>
> >> I agree, modulo the issue with the offset calculation. =20
> >=20
> > *sigh*
> >=20
> > This is exactly what I tried to suggest here:
> >=20
> >    https://lore.kernel.org/linux-iommu/20240301180853.5ac20b27@meshulam=
tesarici.cz/
> >=20
> > To which Robin Murphy replied:
> >  =20
> >> That doesn't make sense - a caller asks to map some range of kernel
> >> addresses and they get back a corresponding range of DMA addresses; th=
ey
> >> cannot make any reasonable assumptions about DMA addresses *outside*
> >> that range. =20
> >=20
> > It sounded like a misunderstanding back then already, but in light of
> > the present findings, should I send the corresponding patch after all? =
=20
>=20
> No, that comment was in reference to the idea of effectively forcing=20
> alloc_align_mask in order to honour min_align_mask - specifically that=20
> the reasoning given for it was spurious, but it's clear now it would=20
> also simply exacerbate this problem.
>=20
> Simply put, if min_align_mask is specified alone, SWIOTLB can allocate a=
=20
> roughly-aligned range of slots such that the bounce offset is always=20
> less than IO_TLB_SIZE from the start of the allocation; if both=20
> min_align_mask and alloc_align_mask are specified, then the bounce=20
> offset may be larger than IO_TLB_SIZE, and SWIOTLB needs to be able to=20
> handle that correctly. There is still no benefit in forcing the latter=20
> case to happen more often than it needs to.

So yes, it was a misunderstanding. Here's what I wrote:

I thought about it some more, and I believe I know what should happen
if the first two constraints appear to be mutually exclusive.

I thought it was clear that the two constraints "appear mutually
exclusive" only if both are specified. Admittedly, I also tried to
combine the historic page alignment with the explicit alloc_align_mask
somehow, so that could have caused confusion.

Anyway, let me send the patch and discuss it in a new thread.

Petr T

