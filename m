Return-Path: <linux-kernel+bounces-90470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E83186FFAD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BAC1C22D86
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A0E38F8F;
	Mon,  4 Mar 2024 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="G+yDLBR+"
Received: from bee.tesarici.cz (unknown [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5CEB654
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550070; cv=none; b=ingye4ZNgMB/7TyzBFw1arBj+YjI5ZaiooF7ByoBGl8WngRwDq7oupYJ4JYNPi04czr4x6MlQzZI6PyAiHca+W1EE16sP04CFAx+yKy2wrTfni8nZNbTCCj9N4d5Y2+e6YYwFJlbjD8cOjj6Gc7ZqHxHl0EK+SjjbBNpoQM3uI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550070; c=relaxed/simple;
	bh=2UTWtXNz24rOfsWHy0tRJI4cilrUVGSVZsXVaMM9kQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwlMLzcLqFCyTQjpyK6nGYPWzOnUYggLfuj7PAcrltN/z1pI14DleTRHr+WaY+FXIKLa+3SABlOfSmqgwmSz73izOyKmMFerbF/lCVmET7kadqgALJiM+uhSbX0hwyUlyMO4xnKRu4nquCJv1/WbHDJqYNjiLAvhLaz2CGvE8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=G+yDLBR+; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id AFF561C5563;
	Mon,  4 Mar 2024 12:00:57 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709550058; bh=GkbQTNoWP+O71+8oP+N+b53JfIHvCbph5mOTRuQfr0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G+yDLBR+EcffwFMDOOIbxm9Xur/CZgIERhXAoalZHdd0eQfO68ZTs7sf8/ggZUTcW
	 O2BWW+Qxyd7/sXcTG5ZaknXUDEd54XvOQu0KG9sqK9s0305pu2DwXuNhEvntgco6Vo
	 z7LczJagcnXKhuLtKk4jJsk59k2yVwoRN+HacLALRTc11BVASexJbqPs09cYlEE3BK
	 GdTh+cN7NIzUm6xa0ZFF8mcPplsumnBgvLLX4yWWdlcTjjQKQGVtejZEofQF/jHkKW
	 9bZryzM0lG00KL3/p2jyxPgDPXlgK/7kYlFYC7ieBfyo/El1x/Jsruk/S7ltzB00G2
	 M1mhnnfxQuMMw==
Date: Mon, 4 Mar 2024 12:00:55 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>, "kernel-team@android.com"
 <kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Dexuan Cui
 <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Message-ID: <20240304120055.56035c21@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB41571DA1EE99BFAA65869024D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
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
	<20240301194212.3c64c9b2@meshulam.tesarici.cz>
	<SN6PR02MB41571DA1EE99BFAA65869024D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Mar 2024 03:31:34 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Friday, March 1, 20=
24 10:42 AM
> >=20
> > On Fri, 1 Mar 2024 17:54:06 +0000
> > Robin Murphy <robin.murphy@arm.com> wrote:
> >  =20
> > > On 2024-03-01 5:08 pm, Petr Tesa=C5=99=C3=ADk wrote: =20
> > > > On Fri, 1 Mar 2024 16:39:27 +0100
> > > > Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:
> > > > =20
> > > >> On Thu, 29 Feb 2024 16:47:56 +0100
> > > >> Christoph Hellwig <hch@lst.de> wrote:
> > > >> =20
> > > >>> On Thu, Feb 29, 2024 at 03:44:11PM +0000, Michael Kelley wrote: =
=20
> > > >>>> Any thoughts on how that historical behavior should apply if
> > > >>>> the DMA min_align_mask is non-zero, or the alloc_align_mask
> > > >>>> parameter to swiotbl_tbl_map_single() is non-zero? As currently
> > > >>>> used, alloc_align_mask is page aligned if the IOMMU granule is =
=20
> > > >>>>> =3D PAGE_SIZE. But a non-zero min_align_mask could mandate =20
> > > >>>> returning a buffer that is not page aligned. Perhaps do the
> > > >>>> historical behavior only if alloc_align_mask and min_align_mask
> > > >>>> are both zero? =20
> > > >>>
> > > >>> I think the driver setting min_align_mask is a clear indicator
> > > >>> that the driver requested a specific alignment and the defaults
> > > >>> don't apply.  For swiotbl_tbl_map_single as used by dma-iommu
> > > >>> I'd have to tak a closer look at how it is used. =20
> > > >>
> > > >> I'm not sure it helps in this discussion, but let me dive into a b=
it
> > > >> of ancient history to understand how we ended up here.
> > > >>
> > > >> IIRC this behaviour was originally motivated by limitations of PC =
AT
> > > >> hardware. Intel 8237 is a 16-bit DMA controller. To make it somehow
> > > >> usable with addresses up to 16MB (yeah, the infamous DMA zone), IBM
> > > >> added a page register, but it was on a separate chip and it did not
> > > >> increment when the 8237 address rolled over back to zero. Effectiv=
ely,
> > > >> the page register selected a 64K-aligned window of 64K buffers.
> > > >> Consequently, DMA buffers could not cross a 64K physical boundary.
> > > >>
> > > >> Thanks to how the buddy allocator works, the 64K-boundary constrai=
nt
> > > >> was satisfied by allocation size, and drivers took advantage of it=
 when
> > > >> allocating device buffers. IMO software bounce buffers simply foll=
owed
> > > >> the same logic that worked for buffers allocated by the buddy allo=
cator.
> > > >>
> > > >> OTOH min_align_mask was motivated by NVME which prescribes the val=
ue of
> > > >> a certain number of low bits in the DMA address (for simplicity as=
sumed
> > > >> to be identical with the same bits in the physical address).
> > > >>
> > > >> The only pre-existing user of alloc_align_mask is x86 IOMMU code, =
and
> > > >> IIUC it is used to guarantee that unaligned transactions do not sh=
are
> > > >> the IOMMU granule with another device. This whole thing is weird,
> > > >> because swiotlb_tbl_map_single() is called like this:
> > > >>
> > > >>                  aligned_size =3D iova_align(iovad, size);
> > > >>                  phys =3D swiotlb_tbl_map_single(dev, phys, size, =
aligned_size,
> > > >>                                                iova_mask(iovad), d=
ir, attrs);
> > > >>
> > > >> Here:
> > > >>
> > > >> * alloc_size =3D iova_align(iovad, size)
> > > >> * alloc_align_mask =3D iova_mask(iovad)
> > > >>
> > > >> Now, iova_align() rounds up its argument to a multiple of iova gra=
nule
> > > >> and iova_mask() is simply "granule - 1". This works, because granu=
le
> > > >> size must be a power of 2, and I assume it must also be >=3D PAGE_=
SIZE.
> > > >>
> > > >> In that case, the alloc_align_mask argument is not even needed if =
you
> > > >> adjust the code to match documentation---the resulting buffer will=
 be
> > > >> aligned to a granule boundary by virtue of having a size that is a
> > > >> multiple of the granule size.
> > > >>
> > > >> To sum it up:
> > > >>
> > > >> 1. min_align_mask is by far the most important constraint. Devices=
 will
> > > >>     simply stop working if it is not met.
> > > >> 2. Alignment to the smallest PAGE_SIZE order which is greater than=
 or
> > > >>     equal to the requested size has been documented, and some driv=
ers
> > > >>     may rely on it.
> > > >> 3. alloc_align_mask is a misguided fix for a bug in the above.
> > > >>
> > > >> Correct me if anything of the above is wrong. =20
> > > >
> > > > I thought about it some more, and I believe I know what should happ=
en
> > > > if the first two constraints appear to be mutually exclusive.
> > > >
> > > > First, the alignment based on size does not guarantee that the resu=
lting
> > > > physical address is aligned. In fact, the lowest IO_TLB_SHIFT bits =
must
> > > > be always identical to the original buffer address.
> > > >
> > > > Let's take an example request like this:
> > > >
> > > >     TLB_SIZE       =3D 0x00000800
> > > >     min_align_mask =3D 0x0000ffff
> > > >     orig_addr      =3D 0x....1234
> > > >     alloc_size     =3D 0x00002800
> > > >
> > > > Minimum alignment mask requires to keep the 1234 at the end. Alloca=
tion
> > > > size requires a buffer that is aligned to 16K. Of course, there is =
no
> > > > 16K-aligned slot with slot_address & 0x7ff =3D=3D 0x200, but if IO_=
TLB_SHIFT
> > > > was 14, it would be slot_address & 0x3fff =3D=3D 0 (low IO_TLB_SHIF=
T are
> > > > masked off). Since the SWIOTLB API does not guarantee any specific
> > > > value of IO_TLB_SHIFT, callers cannot rely on it. That means 0x1234=
 is a
> > > > perfectly valid bounce buffer address for this example.
> > > >
> > > > The caller may rightfully expect that the 16K granule containing the
> > > > bounce buffer is not shared with any other user. For the above case=
 I
> > > > suggest to increase the allocation size to 0x4000 already in
> > > > swiotlb_tbl_map_single() and treat 0x1234 as the offset from the sl=
ot
> > > > address. =20
> > >
> > > That doesn't make sense - a caller asks to map some range of kernel
> > > addresses and they get back a corresponding range of DMA addresses; t=
hey
> > > cannot make any reasonable assumptions about DMA addresses *outside*
> > > that range. In the example above, the caller has explicitly chosen not
> > > to map the range xxx0000-xxx1234; if they expect the device to actual=
ly
> > > access bytes in the DMA range yyy0000-yyy1234, then they should have
> > > mapped the whole range starting from xxx0000 and it is their own erro=
r. =20
> >=20
> > I agree that the range was not requested. But it is not wrong if
> > SWIOTLB overallocates. In fact, it usually does overallocate because it
> > works with slot granularity.
> >  =20
> > > SWIOTLB does not and cannot provide any memory protection itself, so
> > > there is no functional benefit to automatically over-allocating, all =
it
> > > will do is waste slots. iommu-dma *can* provide memory protection
> > > between individual mappings via additional layers that SWIOTLB doesn't
> > > know about, so in that case it's iommu-dma's responsibility to
> > > explicitly manage whatever over-allocation is necessary at the SWIOTLB
> > > level to match the IOMMU level. =20
> >=20
> > I'm trying to understand what the caller expects to get if they request
> > both buffer alignment (either given implicitly through mapping size or
> > explicitly with an alloc_align_mask) with a min_align_mask and non-zero
> > low bits covered by the buffer alignment.
> >=20
> > In other words, if iommu_dma_map_page() gets into this situation:
> >=20
> > * granule size is 4k
> > * device specifies 64k min_align_mask
> > * bit 11 of the original buffer address is non-zero
> >=20
> > Then you ask for a pair of slots where the first slot has bit 11 =3D=3D=
 0
> > (required by alignment to granule size) and also has bit 11 =3D=3D 1
> > (required to preserve the lowest 16 bits of the original address).
> >=20
> > Sure, you can fail such a mapping, but is it what the caller expects?
> >  =20

Upfront, thank you very much for the overview. Much appreciated!

> Here's my take on tying all the threads together. There are=20
> four alignment combinations:
>=20
> 1. alloc_align_mask: zero; min_align_mask: zero
> 2. alloc_align_mask: zero; min_align_mask: non-zero
> 3. alloc_align_mask: non-zero; min_align_mask: zero/ignored
> 4. alloc_align_mask: non-zero; min_align_mask: non-zero

What does "min_align_mask: zero/ignored" mean? Under which
circumstances should be a non-zero min_align_mask ignored?

> xen_swiotlb_map_page() and dma_direct_map_page() are #1 or #2
> via swiotlb_map() and swiotlb_tbl_map_single()
>=20
> iommu_dma_map_page() is #3 and #4 via swiotlb_tbl_map_single()
>=20
> swiotlb_alloc() is #3, directly to swiotlb_find_slots()
>=20
> For #1, the returned physical address has no constraints if=20
> the requested size is less than a page. For page size or=20
> greater, the discussed historical requirement for page=20
> alignment applies.
>=20
> For #2, min_align_mask governs the bits of the returned=20
> physical address that must match the original address. When=20
> needed, swiotlb must also allocate pre-padding aligned to=20
> IO_TLB_SIZE that precedes the returned physical address.  A=20
> request size <=3D swiotlb_max_mapping_size() will not exceed=20
> IO_TLB_SEGSIZE even with the padding. The historical=20
> requirement for page alignment does not apply because the=20
> driver has explicitly used the newer min_align_mask feature.

What is the idea here? Is it the assumption that only old drivers rely
on page alignment, so if they use min_align_mask, it proves that they
are new and must not rely on page alignment?

> For #3, alloc_align_mask specifies the required alignment. No=20
> pre-padding is needed. Per earlier comments from Robin[1],=20
> it's reasonable to assume alloc_align_mask (i.e., the granule)=20
> is >=3D IO_TLB_SIZE. The original address is not relevant in=20
> determining the alignment, and the historical page alignment=20
> requirement does not apply since alloc_align_mask explicitly=20
> states the alignment.
>
> For #4, the returned physical address must match the bits
> in the original address specified by min_align_mask.  swiotlb
> swiotlb must also allocate pre-padding aligned to
> alloc_align_mask that precedes the returned physical address.
> Also per Robin[1], assume alloc_align_mask is >=3D
> min_align_mask, which solves the conflicting alignment=20
> problem pointed out by Petr[2]. Perhaps we should add a=20
> "WARN_ON(alloc_align_mask < min_align_mask)" rather than=20
> failing depending on which bits of the original address are=20
> set. Again, the historical requirement for page alignment does=20
> not apply.

AFAICS the only reason this works in practice is that there are only
two in-tree users of min_align_mask: NVMe and Hyper-V. Both use a mask
of 12 bits, and the IOVA granule size is never smaller than 4K.

If we want to rely on this, then I propose to make a BUG_ON() rather
than WARN_ON().

> I believe Will's patch set implements everything in #2, #3,=20
> and #4, except my suggested WARN_ON in #4. The historical page=20
> alignment in #1 presumably needs to be added. Also, the current=20
> implementation of #4 has a bug in that IO_TLB_SEGSIZE could be=20
> exceeded as pointed out here[3], but Robin was OK with not=20
> fixing that now.

Agreed.

Thank you again, this helps a lot.

Petr T

>=20
> Michael
>=20
> [1] https://lore.kernel.org/linux-iommu/20240221113504.7161-1-will@kernel=
org/T/#mbd31cbfbdf841336e25f37758c8af1a0b6d8f3eb=20
> [2] https://lore.kernel.org/linux-iommu/20240228133930.15400-1-will@kerne=
l.org/T/#mf631679b302b1f5c7cacc82f4c15fb4b19f3dea1=20
> [3] https://lore.kernel.org/linux-iommu/20240221113504.7161-1-will@kernel=
org/T/#m4179a909777ec751f3dc15b515617477e6682600


