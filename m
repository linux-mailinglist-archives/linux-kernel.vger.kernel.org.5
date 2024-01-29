Return-Path: <linux-kernel+bounces-43481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC85C84146F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EF51F2286A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EB91534EB;
	Mon, 29 Jan 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="ww9/TFV5"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CAD604C5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560847; cv=none; b=XbvObtfu79Dd0Zmts0tR6w/Hld4rvgpe7Dz4n8JoV/dCf1H+mzufNFUElS6yOmeF8Ni1Bo7JGKnks9niWbdp0sLcHUvWHoT96jX8eUYbO0FytNsLBCL3kfOpUlj7CAFSTFbtxYFRwoyFtUyYBWcXA1lEo7/o6F0YuY73hGEMqOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560847; c=relaxed/simple;
	bh=X94dGa34Rf3Z09DyoMy9dmXSi/7nIr2uv+Gk9hHR6M4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duK0IrLo3T/Ns+vwfArGHGPIQ4QAQye2EHwZWqA4nnYROn+HIbeYSVGWZIUYjuSfAM/cEA76aA96/lCrpJ5b+C6E6UtE7iOXVo2D6lv7U1RPencxFxNzXqvbeLMvTkf/ArbF7GcRiMEX+kvJq0Odk7vl//mA11eFtz3GqkwRjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=ww9/TFV5; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id A903D19A95A;
	Mon, 29 Jan 2024 21:40:35 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706560835; bh=X94dGa34Rf3Z09DyoMy9dmXSi/7nIr2uv+Gk9hHR6M4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ww9/TFV5fUcxiukvGOoTG5n2TOqGizqBfmZsJscPACNQ3VmqHsfHectbJPlczMy/n
	 qdTYRpdC40n7vyb5lHp0ukcRWzLQMKuMJVydulUg3gWQZcRQ+FAk0HT4Z4fhBxT4en
	 0yGRMYq+s8rvW3rJexPk8Uacbxhl73hJ4qEtm+tAeu4EoGMV0/PRucGbUlSBkg/tlK
	 QKosgEi19mJiQ5u/+QiAh+qPqmchtsU68vwpZlivo0FEcqKhM3p/hrUkvY/Mj1DaXo
	 gYnu29dX60KEyBoEfIGRl1Xb15fIuPm4SQ421Mo/7OzuxGwnobXpD+DuNbPCRc078u
	 HW/3tCvd4AhHw==
Date: Mon, 29 Jan 2024 21:40:34 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>
Subject: Re: [PATCH 1/2] swiotlb: Fix allocation alignment requirement when
 searching slots
Message-ID: <20240129214034.4beb4258@meshulam.tesarici.cz>
In-Reply-To: <20240129193250.GB12631@willie-the-truck>
References: <20240126151956.10014-1-will@kernel.org>
	<20240126151956.10014-2-will@kernel.org>
	<20240126180127.1a3fc4e6@meshulam.tesarici.cz>
	<20240129193250.GB12631@willie-the-truck>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jan 2024 19:32:50 +0000
Will Deacon <will@kernel.org> wrote:

> On Fri, Jan 26, 2024 at 06:01:27PM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > On Fri, 26 Jan 2024 15:19:55 +0000
> > Will Deacon <will@kernel.org> wrote: =20
> > > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > > index b079a9a8e087..25febb9e670c 100644
> > > --- a/kernel/dma/swiotlb.c
> > > +++ b/kernel/dma/swiotlb.c
> > > @@ -982,7 +982,7 @@ static int swiotlb_search_pool_area(struct device=
 *dev, struct io_tlb_pool *pool
> > >  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
> > >  	unsigned long max_slots =3D get_max_slots(boundary_mask);
> > >  	unsigned int iotlb_align_mask =3D
> > > -		dma_get_min_align_mask(dev) | alloc_align_mask;
> > > +		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1); =20
> >=20
> > Good. So, iotlb_align_mask now specifies how many low bits of orig_addr
> > should be preserved in the bounce buffer address, ignoring the offset
> > within the TLB slot... =20
>=20
> Yup, this is basically restoring the old behaviour.
>=20
> > >  	unsigned int nslots =3D nr_slots(alloc_size), stride;
> > >  	unsigned int offset =3D swiotlb_align_offset(dev, orig_addr);
> > >  	unsigned int index, slots_checked, count =3D 0, i;
> > > @@ -998,14 +998,13 @@ static int swiotlb_search_pool_area(struct devi=
ce *dev, struct io_tlb_pool *pool
> > >  	 * allocations.
> > >  	 */
> > >  	if (alloc_size >=3D PAGE_SIZE)
> > > -		iotlb_align_mask |=3D ~PAGE_MASK;
> > > -	iotlb_align_mask &=3D ~(IO_TLB_SIZE - 1);
> > > +		alloc_align_mask |=3D ~PAGE_MASK; =20
> >=20
> > ...and alloc_align_mask specifies the desired TLB slot alignment. =20
>=20
> Yes, although actually I'm now wondering whether there's another bug here
> in that we don't return naturally aligned buffers for allocations bigger
> than a page. I think that was broken in 0eee5ae10256 ("swiotlb: fix slot
> alignment checks") because that stopped aligning the initial search index
> to the stride (which was in turn previously aligned to the allocation siz=
e).

The question is whether there is any NEED that allocations bigger than
a page are naturally aligned. For my part, I don't see why there should
be, but I might be missing something.

> > >  	/*
> > >  	 * For mappings with an alignment requirement don't bother looping =
to
> > >  	 * unaligned slots once we found an aligned one.
> > >  	 */
> > > -	stride =3D (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
> > > +	stride =3D (max(alloc_align_mask, iotlb_align_mask) >> IO_TLB_SHIFT=
) + 1; =20
> >=20
> > I'm not quite sure about this one.
> >=20
> > And I'm not even sure all combinations make sense!
> >=20
> > For example, take these values:
> >=20
> > *         TLB_SIZE =3D=3D              0x800  (2K)
> > * alloc_align_mask =3D=3D 0xffffffffffffc000  (16K alignment, could be =
page size)
> > * iotlb_align_mask =3D=3D 0xffffffffffff0000  (64K alignment)
> > *        orig_addr =3D=3D 0x0000000000001234
> >=20
> > Only the lowest 16 bits are relevant for the alignment check.
> > Device alignment requires 0x1000.
> > Alloc alignment requires one of 0x0000, 0x4000, 0x8000, or 0xc000.
> > Obviously, such allocation must always fail... =20
>=20
> Having an iotlb_align_mask with all those upper bits set looks wrong to m=
e.
> Is that the same "braino" as bbb73a103fbb?

I must always stop and think at least twice before I can be sure
whether a "mask" has the high bits set, or the low bits set...

On an x86, PAGE_SHIFT is 12, PAGE_SIZE is 1UL << PAGE_SHIFT or 0x1000,
PAGE_MASK is ~(PAGE_SIZE-1)) or 0xfffffffffffff000, and there's one
more bitwise negation, so you're right. Both masks above should be
inverted, and using max() to find the stride is correct.

Petr T

