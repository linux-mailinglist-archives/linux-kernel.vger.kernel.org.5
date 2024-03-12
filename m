Return-Path: <linux-kernel+bounces-99977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD7387901A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D080B21737
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1B679B61;
	Tue, 12 Mar 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="lPwTuhuE"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ADB77F08
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233552; cv=none; b=AsG4lEfEIknQGvJuTRNLIanEUAk0oaCrDLw+rhmkjFgL9HmNQWCGisei46CVJbhZxTsEYSRk1P04sPOEw3eldVIuB2LglRXGuKO2apZVmq+S8sa/hzRf4emlaiHbCGNaMrnhoBFrwKMx6YZojf4X8ltN+Yms1W7fe4n9gfVqo5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233552; c=relaxed/simple;
	bh=liEg0VlHYQEiCJFBhq1fhNzu+OH4K3HVGJRT0OXS+mc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dsvta7Pbb+8co6gTif8MEX7dOUPzL3vYz5jFsB3JMJF1AiL01HvWu0jzsSnP7gudMMEkJ2UhWfVtTyJaiPOLzrVr2S7UqfwJqP/+uV8UOG304cGwYf+4q1ba6CvwAivqOYm2l2Z1bJf+nxbgk1pWKsra14DIpvOVAg9LUyAxL3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=lPwTuhuE; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 36378190ED2;
	Tue, 12 Mar 2024 09:52:25 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1710233545; bh=KaQesOMo7Ot2NB/psa/g57OWMeyShuFU5y/avfSsZHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lPwTuhuEyyihwpH9Bu0VNNBpPSzKSfJGXx4xA56/5S3lYUmFvK7yd0xyXLtPeoqoT
	 k+/yQOFlX/tPaerm0ZWk8FVBME7hN29jHDx+Qmk/94mDbUF6pNjaJ4qALWltqDcQZY
	 8cFotjGFCSvG8PUFk7vXWzJLxEmfFMiTHtk6AHaEr9OSK+uuaSyXGDcwgc9+7qygP2
	 qaW80qg7uQJS5lX8T/kWtNiLpN+fC97Ez9fM6aU76/Fzu63HhobMn+ceNmzL38i4nd
	 HZ28pDhps4kf7JhyBOtpG5m8vGrwtdnbQfGSFSRvX+/9B8Xf8QMUMsOFknVQtN6tVK
	 CrrGM+w2Guz5w==
Date: Tue, 12 Mar 2024 09:52:23 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kernel-team@android.com"
 <kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>
Subject: Re: [PATCH v6 4/6] swiotlb: Fix alignment checks when both
 allocation and DMA masks are present
Message-ID: <20240312095223.7a05d5b8@meshulam.tesarici.cz>
In-Reply-To: <20240311224910.GA28426@willie-the-truck>
References: <20240308152829.25754-1-will@kernel.org>
	<20240308152829.25754-5-will@kernel.org>
	<20240311210507.217daf8b@meshulam.tesarici.cz>
	<SN6PR02MB41576E58DDF5A56FC6FC1EB6D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240311224910.GA28426@willie-the-truck>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Mar 2024 22:49:11 +0000
Will Deacon <will@kernel.org> wrote:

> On Mon, Mar 11, 2024 at 09:36:10PM +0000, Michael Kelley wrote:
> > From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> =20
> > > On Fri,  8 Mar 2024 15:28:27 +0000
> > > Will Deacon <will@kernel.org> wrote: =20
> > > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > > index c20324fba814..c381a7ed718f 100644
> > > > --- a/kernel/dma/swiotlb.c
> > > > +++ b/kernel/dma/swiotlb.c
> > > > @@ -981,8 +981,7 @@ static int swiotlb_search_pool_area(struct devi=
ce *dev, struct io_tlb_pool *pool
> > > >  	dma_addr_t tbl_dma_addr =3D
> > > >  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
> > > >  	unsigned long max_slots =3D get_max_slots(boundary_mask);
> > > > -	unsigned int iotlb_align_mask =3D
> > > > -		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> > > > +	unsigned int iotlb_align_mask =3D dma_get_min_align_mask(dev);
> > > >  	unsigned int nslots =3D nr_slots(alloc_size), stride;
> > > >  	unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
> > > >  	unsigned int index, slots_checked, count =3D 0, i;
> > > > @@ -993,6 +992,14 @@ static int swiotlb_search_pool_area(struct dev=
ice *dev, struct io_tlb_pool *pool
> > > >  	BUG_ON(!nslots);
> > > >  	BUG_ON(area_index >=3D pool->nareas);
> > > >
> > > > +	/*
> > > > +	 * Ensure that the allocation is at least slot-aligned and update
> > > > +	 * 'iotlb_align_mask' to ignore bits that will be preserved when
> > > > +	 * offsetting into the allocation.
> > > > +	 */
> > > > +	alloc_align_mask |=3D (IO_TLB_SIZE - 1);
> > > > +	iotlb_align_mask &=3D ~alloc_align_mask;
> > > > + =20
> > >=20
> > > I have started writing the KUnit test suite, and the results look
> > > incorrect to me for this case.
> > >=20
> > > I'm calling swiotlb_tbl_map_single() with:
> > >=20
> > > * alloc_align_mask =3D 0xfff
> > > * a device with min_align_mask =3D 0xfff
> > > * the 12 lowest bits of orig_addr are 0xfa0
> > >=20
> > > The min_align_mask becomes zero after the masking added by this patch,
> > > and the 12 lowest bits of the returned address are 0x7a0, i.e. not
> > > equal to 0xfa0. =20
> >=20
> > The address returned by swiotlb_tbl_map_single() is the slot index
> > converted to an address, plus the offset modulo the min_align_mask for
> > the device.  The local variable "offset" in swiotlb_tbl_map_single()
> > should be 0xfa0.  The slot index should be an even number to meet
> > the alloc_align_mask requirement.  And the pool->start address should
> > be at least page aligned, producing a page-aligned address *before* the
> > offset is added. Can you debug which of these isn't true for the case
> > you are seeing? =20
>=20
> I was just looking into this, and I think the problem starts because
> swiotlb_align_offset() doesn't return the offset modulo the min_align_mas=
k,
> but instead returns the offset *into the slot*:
>=20
> 	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
>=20
> so this presumably lops off bit 11 without adjusting the slot number.

Yes. You will never see an offset bigger than IO_TLB_SIZE.

> I don't think swiotlb_find_slots() should be handling this though; it's
> more about how swiotlb_tbl_map_single() puts the address back together
> again.
> > > In other words, the min_align_mask constraint is not honored. Of cour=
se,
> > > given the above values, it is not possible to honor both min_align_ma=
sk
> > > and alloc_align_mask.  =20
> >=20
> > When orig_addr is specified and min_align_mask is set, alloc_align_mask
> > governs the address of the _allocated_ space, which is not necessarily =
the
> > returned physical address.  The min_align_mask may dictate some
> > pre-padding of size "offset" within the allocated space, and the return=
ed
> > address is *after* that pre-padding.  In this way, both can be honored.=
 =20
>=20
> I agree, modulo the issue with the offset calculation.

*sigh*

This is exactly what I tried to suggest here:

  https://lore.kernel.org/linux-iommu/20240301180853.5ac20b27@meshulam.tesa=
rici.cz/

To which Robin Murphy replied:

> That doesn't make sense - a caller asks to map some range of kernel=20
> addresses and they get back a corresponding range of DMA addresses; they=
=20
> cannot make any reasonable assumptions about DMA addresses *outside*=20
> that range.=20

It sounded like a misunderstanding back then already, but in light of
the present findings, should I send the corresponding patch after all?

Petr T

