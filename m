Return-Path: <linux-kernel+bounces-88933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E486E89F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F061C22841
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B6439ACB;
	Fri,  1 Mar 2024 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="Bmhi2mkZ"
Received: from bee.tesarici.cz (unknown [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2602575F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318538; cv=none; b=DW8kAYeMgJO+zUmvzkSCgoMhYn5A5bRI0q989Oi2s7VeaU4ENszmhkAUuu52oFtx2PDXJpd7lukdd9L1PDRgMILiWzdwyp68B524BBbyTaSuQuMqU0gPg/T0H8FgT2cquzpxtQDZl8Ghdubtx3F51Jo9gh8Hk7PWwd7lIRPuego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318538; c=relaxed/simple;
	bh=w+8tzDUNxC+0c2kk3d9ykcorijNJa53GYpsyK5+JaZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBILSm8RhskJs+Ftv5hbyR1lPccbzazQ0IZZCoHbYgUzLkndTGDLhqO4l7WEFyZ0lBUnkzQRgM4+3nF2doPmahM7LfIk/akZ6DdoMFUiz7KU5lEUkVmfyOU3IDRjVFPgrTuCMNzu4XAM3agXBqPZg6Ux8x818lARpWjxJ/Gke10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=Bmhi2mkZ; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 52C991C37C8;
	Fri,  1 Mar 2024 19:42:13 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709318533; bh=0BzVbEMUW+HOHqX604KISbar5ltvn6EhM64KI0u9ocU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bmhi2mkZ3so7nx3ERP2V7oB11mo9VdPjZVkhxOBotjJZP6CxSTk+Az+/ZH8rRDjUP
	 NGyu1a3lBsp2D3ADnmZrO31NQtF/tjXYTY1qN7qRur6ZZKqdxWHXmjBwQeJEqH/Qj5
	 Uc0lftk9fJR+LV3q1ZSReYPjTosYktuTyvI0cWVaQCuje7HjOXjt191XIMvyKYBFLV
	 LvXiyexLut5Oylz+NII5OEnRH1ICf0kX+tdEX5JVJ2xP0M/oykO9qzepMx7rvCTCSJ
	 dy5CmsHXKa4acTWPoBJ0yGqUcBSvcn5hqg99x6tYlZrHGL12uYJCTVM0QrgoRFx5oH
	 WvemhV6V89Jiw==
Date: Fri, 1 Mar 2024 19:42:12 +0100
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
Message-ID: <20240301194212.3c64c9b2@meshulam.tesarici.cz>
In-Reply-To: <8869c8b2-29c3-41e4-8f8a-5bcf9c0d22bb@arm.com>
References: <20240228133930.15400-1-will@kernel.org>
	<20240228133930.15400-7-will@kernel.org>
	<SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<SN6PR02MB41577D09E97B1D9645369D58D45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240229133346.GA7177@lst.de>
	<SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240229154756.GA10137@lst.de>
	<20240301163927.18358ee2@meshulam.tesarici.cz>
	<20240301180853.5ac20b27@meshulam.tesarici.cz>
	<8869c8b2-29c3-41e4-8f8a-5bcf9c0d22bb@arm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Mar 2024 17:54:06 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2024-03-01 5:08 pm, Petr Tesa=C5=99=C3=ADk wrote:
> > On Fri, 1 Mar 2024 16:39:27 +0100
> > Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:
> >  =20
> >> On Thu, 29 Feb 2024 16:47:56 +0100
> >> Christoph Hellwig <hch@lst.de> wrote:
> >> =20
> >>> On Thu, Feb 29, 2024 at 03:44:11PM +0000, Michael Kelley wrote: =20
> >>>> Any thoughts on how that historical behavior should apply if
> >>>> the DMA min_align_mask is non-zero, or the alloc_align_mask
> >>>> parameter to swiotbl_tbl_map_single() is non-zero? As currently
> >>>> used, alloc_align_mask is page aligned if the IOMMU granule is =20
> >>>>> =3D PAGE_SIZE. But a non-zero min_align_mask could mandate =20
> >>>> returning a buffer that is not page aligned. Perhaps do the
> >>>> historical behavior only if alloc_align_mask and min_align_mask
> >>>> are both zero? =20
> >>>
> >>> I think the driver setting min_align_mask is a clear indicator
> >>> that the driver requested a specific alignment and the defaults
> >>> don't apply.  For swiotbl_tbl_map_single as used by dma-iommu
> >>> I'd have to tak a closer look at how it is used. =20
> >>
> >> I'm not sure it helps in this discussion, but let me dive into a bit
> >> of ancient history to understand how we ended up here.
> >>
> >> IIRC this behaviour was originally motivated by limitations of PC AT
> >> hardware. Intel 8237 is a 16-bit DMA controller. To make it somehow
> >> usable with addresses up to 16MB (yeah, the infamous DMA zone), IBM
> >> added a page register, but it was on a separate chip and it did not
> >> increment when the 8237 address rolled over back to zero. Effectively,
> >> the page register selected a 64K-aligned window of 64K buffers.
> >> Consequently, DMA buffers could not cross a 64K physical boundary.
> >>
> >> Thanks to how the buddy allocator works, the 64K-boundary constraint
> >> was satisfied by allocation size, and drivers took advantage of it when
> >> allocating device buffers. IMO software bounce buffers simply followed
> >> the same logic that worked for buffers allocated by the buddy allocato=
r.
> >>
> >> OTOH min_align_mask was motivated by NVME which prescribes the value of
> >> a certain number of low bits in the DMA address (for simplicity assumed
> >> to be identical with the same bits in the physical address).
> >>
> >> The only pre-existing user of alloc_align_mask is x86 IOMMU code, and
> >> IIUC it is used to guarantee that unaligned transactions do not share
> >> the IOMMU granule with another device. This whole thing is weird,
> >> because swiotlb_tbl_map_single() is called like this:
> >>
> >>                  aligned_size =3D iova_align(iovad, size);
> >>                  phys =3D swiotlb_tbl_map_single(dev, phys, size, alig=
ned_size,
> >>                                                iova_mask(iovad), dir, =
attrs);
> >>
> >> Here:
> >>
> >> * alloc_size =3D iova_align(iovad, size)
> >> * alloc_align_mask =3D iova_mask(iovad)
> >>
> >> Now, iova_align() rounds up its argument to a multiple of iova granule
> >> and iova_mask() is simply "granule - 1". This works, because granule
> >> size must be a power of 2, and I assume it must also be >=3D PAGE_SIZE.
> >>
> >> In that case, the alloc_align_mask argument is not even needed if you
> >> adjust the code to match documentation---the resulting buffer will be
> >> aligned to a granule boundary by virtue of having a size that is a
> >> multiple of the granule size.
> >>
> >> To sum it up:
> >>
> >> 1. min_align_mask is by far the most important constraint. Devices will
> >>     simply stop working if it is not met.
> >> 2. Alignment to the smallest PAGE_SIZE order which is greater than or
> >>     equal to the requested size has been documented, and some drivers
> >>     may rely on it.
> >> 3. alloc_align_mask is a misguided fix for a bug in the above.
> >>
> >> Correct me if anything of the above is wrong. =20
> >=20
> > I thought about it some more, and I believe I know what should happen
> > if the first two constraints appear to be mutually exclusive.
> >=20
> > First, the alignment based on size does not guarantee that the resulting
> > physical address is aligned. In fact, the lowest IO_TLB_SHIFT bits must
> > be always identical to the original buffer address.
> >=20
> > Let's take an example request like this:
> >=20
> >     TLB_SIZE       =3D 0x00000800
> >     min_align_mask =3D 0x0000ffff
> >     orig_addr      =3D 0x....1234
> >     alloc_size     =3D 0x00002800
> >=20
> > Minimum alignment mask requires to keep the 1234 at the end. Allocation
> > size requires a buffer that is aligned to 16K. Of course, there is no
> > 16K-aligned slot with slot_address & 0x7ff =3D=3D 0x200, but if IO_TLB_=
SHIFT
> > was 14, it would be slot_address & 0x3fff =3D=3D 0 (low IO_TLB_SHIFT are
> > masked off). Since the SWIOTLB API does not guarantee any specific
> > value of IO_TLB_SHIFT, callers cannot rely on it. That means 0x1234 is a
> > perfectly valid bounce buffer address for this example.
> >=20
> > The caller may rightfully expect that the 16K granule containing the
> > bounce buffer is not shared with any other user. For the above case I
> > suggest to increase the allocation size to 0x4000 already in
> > swiotlb_tbl_map_single() and treat 0x1234 as the offset from the slot
> > address. =20
>=20
> That doesn't make sense - a caller asks to map some range of kernel=20
> addresses and they get back a corresponding range of DMA addresses; they=
=20
> cannot make any reasonable assumptions about DMA addresses *outside*=20
> that range. In the example above, the caller has explicitly chosen not=20
> to map the range xxx0000-xxx1234; if they expect the device to actually=20
> access bytes in the DMA range yyy0000-yyy1234, then they should have=20
> mapped the whole range starting from xxx0000 and it is their own error.

I agree that the range was not requested. But it is not wrong if
SWIOTLB overallocates. In fact, it usually does overallocate because it
works with slot granularity.

> SWIOTLB does not and cannot provide any memory protection itself, so=20
> there is no functional benefit to automatically over-allocating, all it=20
> will do is waste slots. iommu-dma *can* provide memory protection=20
> between individual mappings via additional layers that SWIOTLB doesn't=20
> know about, so in that case it's iommu-dma's responsibility to=20
> explicitly manage whatever over-allocation is necessary at the SWIOTLB=20
> level to match the IOMMU level.

I'm trying to understand what the caller expects to get if they request
both buffer alignment (either given implicitly through mapping size or
explicitly with an alloc_align_mask) with a min_align_mask and non-zero
low bits covered by the buffer alignment.

In other words, if iommu_dma_map_page() gets into this situation:

* granule size is 4k
* device specifies 64k min_align_mask
* bit 11 of the original buffer address is non-zero

Then you ask for a pair of slots where the first slot has bit 11 =3D=3D 0
(required by alignment to granule size) and also has bit 11 =3D=3D 1
(required to preserve the lowest 16 bits of the original address).

Sure, you can fail such a mapping, but is it what the caller expects?

Thanks
Petr T

