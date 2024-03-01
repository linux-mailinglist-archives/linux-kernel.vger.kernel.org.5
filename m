Return-Path: <linux-kernel+bounces-88839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC7286E770
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BBBFB29AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700F91947E;
	Fri,  1 Mar 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="q8/zY7Ut"
Received: from bee.tesarici.cz (unknown [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497E0F9FF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314410; cv=none; b=QbvaG/9+8tCYCY8C1uFXTf45gBnFqXS7OTJRjfbKmgJZoIfTYdIwMTvFj1mb/DRLBUdi6HR9rHewhF+gjsAbO/DJuNxaGx/6DKevZeToEbqGvXv8SO0wlUVJUK+nBryY4akjO/Z0k1/p1iKqvERwVaPR1jKRyOsi1oxQ8pBvvsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314410; c=relaxed/simple;
	bh=kqFNymNhulpq3C9J15L9aRCKq+ZlvGBWEINffETSl9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEdGVXq5X6wTRdRfaRPRBAvFbzn7/JS0Kei+JCh/DAVNEL4SLX8jGlTV7L21miQs/IqgnZiTnHuekhzkvmh4Jrhaj1QzX1B8kHDTdwBfpl2Q866WZ6wAkzc7A477P2GbkYoLdfRsS+n7MfQAR3t0gW5On+5Z46eKY6z3VCBim8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=q8/zY7Ut; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id C6EDC1C163E;
	Fri,  1 Mar 2024 18:33:25 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709314406; bh=y5F9nq6Ty0/dF9UJva7lXz28jL0DsAwabnPmvR0UHIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q8/zY7UtxCWkrAUnWSom6lRc1oWwIcjPkd1EABwXDjtLeNLlAm/gioZB9DVWI32Q4
	 cqFsBTSoCbjJ5rAO7SE2TdjtDKLcJwFX7LQMFzMRm7/1ya2TeqZT11eqJcByM5werx
	 sipjchVa0oxNkwVdcEgIrHJ3dAa5ndy0VSYqptc4a+C6IbL6ZEDO7ZyL+IzGDACu5L
	 R2MafJFrtLRiCWSHezTBXeh8DNklH+cT6GrRYL5r+bL/HO5/C6lE7L0PliCOzE1wtk
	 dAuI5QfzE2I4F+kTmEf2TZX8iGr4QYKBJ5SXpdN75JJ0t6JQv1uC3HxGUknYq3vP+e
	 BPjRubOeuEDpg==
Date: Fri, 1 Mar 2024 18:33:24 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Michael Kelley <mhklinux@outlook.com>,
 Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>, "kernel-team@android.com"
 <kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Dexuan Cui
 <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Message-ID: <20240301183324.11e76df2@meshulam.tesarici.cz>
In-Reply-To: <4fbcdd49-cd93-4af8-83e2-f1cef0ea2eeb@arm.com>
References: <20240228133930.15400-1-will@kernel.org>
	<20240228133930.15400-7-will@kernel.org>
	<SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<SN6PR02MB41577D09E97B1D9645369D58D45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240229133346.GA7177@lst.de>
	<SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240229154756.GA10137@lst.de>
	<20240301163927.18358ee2@meshulam.tesarici.cz>
	<4fbcdd49-cd93-4af8-83e2-f1cef0ea2eeb@arm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Mar 2024 16:38:33 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2024-03-01 3:39 pm, Petr Tesa=C5=99=C3=ADk wrote:
> > On Thu, 29 Feb 2024 16:47:56 +0100
> > Christoph Hellwig <hch@lst.de> wrote:
> >  =20
> >> On Thu, Feb 29, 2024 at 03:44:11PM +0000, Michael Kelley wrote: =20
> >>> Any thoughts on how that historical behavior should apply if
> >>> the DMA min_align_mask is non-zero, or the alloc_align_mask
> >>> parameter to swiotbl_tbl_map_single() is non-zero? As currently
> >>> used, alloc_align_mask is page aligned if the IOMMU granule is =20
> >>>> =3D PAGE_SIZE. But a non-zero min_align_mask could mandate =20
> >>> returning a buffer that is not page aligned. Perhaps do the
> >>> historical behavior only if alloc_align_mask and min_align_mask
> >>> are both zero? =20
> >>
> >> I think the driver setting min_align_mask is a clear indicator
> >> that the driver requested a specific alignment and the defaults
> >> don't apply.  For swiotbl_tbl_map_single as used by dma-iommu
> >> I'd have to tak a closer look at how it is used. =20
> >=20
> > I'm not sure it helps in this discussion, but let me dive into a bit
> > of ancient history to understand how we ended up here.
> >=20
> > IIRC this behaviour was originally motivated by limitations of PC AT
> > hardware. Intel 8237 is a 16-bit DMA controller. To make it somehow
> > usable with addresses up to 16MB (yeah, the infamous DMA zone), IBM
> > added a page register, but it was on a separate chip and it did not
> > increment when the 8237 address rolled over back to zero. Effectively,
> > the page register selected a 64K-aligned window of 64K buffers.
> > Consequently, DMA buffers could not cross a 64K physical boundary.
> >=20
> > Thanks to how the buddy allocator works, the 64K-boundary constraint
> > was satisfied by allocation size, and drivers took advantage of it when
> > allocating device buffers. IMO software bounce buffers simply followed
> > the same logic that worked for buffers allocated by the buddy allocator.
> >=20
> > OTOH min_align_mask was motivated by NVME which prescribes the value of
> > a certain number of low bits in the DMA address (for simplicity assumed
> > to be identical with the same bits in the physical address).
> >=20
> > The only pre-existing user of alloc_align_mask is x86 IOMMU code, and
> > IIUC it is used to guarantee that unaligned transactions do not share
> > the IOMMU granule with another device. This whole thing is weird,
> > because swiotlb_tbl_map_single() is called like this:
> >=20
> >                  aligned_size =3D iova_align(iovad, size);
> >                  phys =3D swiotlb_tbl_map_single(dev, phys, size, align=
ed_size,
> >                                                iova_mask(iovad), dir, a=
ttrs);
> >=20
> > Here:
> >=20
> > * alloc_size =3D iova_align(iovad, size)
> > * alloc_align_mask =3D iova_mask(iovad)
> >=20
> > Now, iova_align() rounds up its argument to a multiple of iova granule
> > and iova_mask() is simply "granule - 1". This works, because granule
> > size must be a power of 2, and I assume it must also be >=3D PAGE_SIZE.=
 =20
>=20
> Not quite, the granule must *not* be larger than PAGE_SIZE (but can be=20
> smaller).

OK... I must rethink what is achieved with the alignment then.

> > In that case, the alloc_align_mask argument is not even needed if you
> > adjust the code to match documentation---the resulting buffer will be
> > aligned to a granule boundary by virtue of having a size that is a
> > multiple of the granule size. =20
>=20
> I think we've conflated two different notions of "allocation" here. The=20
> page-alignment which Christoph quoted applies for dma_alloc_coherent(),=20
> which nowadays *should* only be relevant to SWIOTLB code in the=20
> swiotlb_alloc() path for stealing coherent pages out of restricted DMA=20
> pools. Historically there was never any official alignment requirement=20
> for the DMA addresses returned by dma_map_{page,sg}(), until=20
> min_align_mask was introduced.
>=20
> > To sum it up:
> >=20
> > 1. min_align_mask is by far the most important constraint. Devices will
> >     simply stop working if it is not met.
> > 2. Alignment to the smallest PAGE_SIZE order which is greater than or
> >     equal to the requested size has been documented, and some drivers
> >     may rely on it. =20
>=20
> Strictly it stopped being necessary since fafadcd16595 when the=20
> historical swiotlb_alloc() was removed, but 602d9858f07c implies that=20
> indeed the assumption of it for streaming mappings had already set in.=20
> Of course NVMe is now using min_align_mask, but I'm not sure if it's=20
> worth taking the risk to find out who else should also be.
>=20
> > 3. alloc_align_mask is a misguided fix for a bug in the above. =20
>=20
> No, alloc_align_mask is about describing the explicit requirement rather=
=20
> than relying on any implicit behaviour, and thus being able to do the=20
> optimal thing for, say, a 9KB mapping given a 4KB IOVA granule and 64KB=20
> PAGE_SIZE.

It's getting confusing. Can we stay with the IOMMU use case for a
moment? Since you don't use IO_TLB_SIZE or IO_TLB_SHIFT, I assume the
code should work with any SWIOTLB slot size.

For granule sizes up to SWIOTLB slot size, you always get a buffer that
is not shared with any other granule.

For granule sizes between SWIOTLB slot size and page size, you want to
get as many slots as needed to cover the whole granule. Indeed, that
would not be achieved with size alone.

What if we change the size-based alignment constraint to:

   Aligned to the smallest IO_TLB_SIZE order which is greater than or
   equal to the requested size.

AFAICS this is stricter, i.e. it covers the already documented
PAGE_SIZE alignment, but it would also cover IOMMU needs.

I have the feeling that the slot search has too many parameters. This
alloc_align_mask has only one in-tree user, so it's a logical candidate
for reduction.

Petr T

>=20
> Thanks,
> Robin.
>=20
> >=20
> > Correct me if anything of the above is wrong.
> >=20
> > HTH
> > Petr T =20
>=20


