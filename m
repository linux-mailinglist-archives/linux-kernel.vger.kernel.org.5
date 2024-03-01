Return-Path: <linux-kernel+bounces-88805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C1E86E6D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC32FB2A572
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D25A5228;
	Fri,  1 Mar 2024 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="kKeq0RwH"
Received: from bee.tesarici.cz (unknown [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B271097B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312940; cv=none; b=ifx+J5xOrQq69NQ9WQanj3qds65N24CUpwscAYqGoZFiK5EUVf9SrRZMBr84aF9ft2OOJRNw38TXo5fgPWGtdzBUncE+5De8GtsR628n4RJZaWPusbAX71KiX6rEw/U/h2KnSReRRe4x7/rgeFUHH400Ij8lgOF4TG6r4e2wSIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312940; c=relaxed/simple;
	bh=Wfe9zGhPuffkvAN8I3WeLl9RfnM0vmZnVhlcI423hZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMIekXC2gZPbmoB455N6vK0oyLuCSzacP4+ql/nqx9hUJCRzCBG+qnsBo489nTKthGTj0B0F90oVqVXIq3JU6RZGw1ctHunbAy9L6sMUD1FAQr/lwOEBvFbEYLPbi8jEAr0VFxtmEUxrSXe+SqbNUpHIYLLrKJr+5JrZZvz2cvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=kKeq0RwH; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id B40601C3920;
	Fri,  1 Mar 2024 18:08:54 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709312934; bh=fKBJWgCSyxi8x9tBCvENvmDDLlpNob1Z0JntFTlnozA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kKeq0RwHgtDgyqbxhsaNIScOvBXOWNfdJNgSIifu8MgdBdQL3V6nRIe70/Zox+pqT
	 CBCDG9jr+eg/fPQZd0XxtrV/bJUWnv5HIcCs6mUBGrzD0sozJXJxJpPIuuHkuMLuDU
	 D1tmeJU1ngvBuC91/RhfUZ3yhFPHWs8pGw13b5PNu95Oysb3VuIE5gCfrAhfalIUHH
	 V7LwnXyZ+pJeYveqYZV3+BYwrAZdHqLunhiQasXanZm3/a5uIUQAILwHeks+BgLk17
	 vBrZ/6e9ogpWzPCX7ro1271HViBhzc9Oam0k1TKoWWx3UyDu4STLQ8UBwbYV2e6hnI
	 YGfOKMj5++t+A==
Date: Fri, 1 Mar 2024 18:08:53 +0100
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
Message-ID: <20240301180853.5ac20b27@meshulam.tesarici.cz>
In-Reply-To: <20240301163927.18358ee2@meshulam.tesarici.cz>
References: <20240228133930.15400-1-will@kernel.org>
	<20240228133930.15400-7-will@kernel.org>
	<SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<SN6PR02MB41577D09E97B1D9645369D58D45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240229133346.GA7177@lst.de>
	<SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240229154756.GA10137@lst.de>
	<20240301163927.18358ee2@meshulam.tesarici.cz>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Mar 2024 16:39:27 +0100
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:

> On Thu, 29 Feb 2024 16:47:56 +0100
> Christoph Hellwig <hch@lst.de> wrote:
>=20
> > On Thu, Feb 29, 2024 at 03:44:11PM +0000, Michael Kelley wrote: =20
> > > Any thoughts on how that historical behavior should apply if
> > > the DMA min_align_mask is non-zero, or the alloc_align_mask
> > > parameter to swiotbl_tbl_map_single() is non-zero? As currently
> > > used, alloc_align_mask is page aligned if the IOMMU granule is   =20
> > > >=3D PAGE_SIZE. But a non-zero min_align_mask could mandate   =20
> > > returning a buffer that is not page aligned. Perhaps do the
> > > historical behavior only if alloc_align_mask and min_align_mask
> > > are both zero?   =20
> >=20
> > I think the driver setting min_align_mask is a clear indicator
> > that the driver requested a specific alignment and the defaults
> > don't apply.  For swiotbl_tbl_map_single as used by dma-iommu
> > I'd have to tak a closer look at how it is used. =20
>=20
> I'm not sure it helps in this discussion, but let me dive into a bit
> of ancient history to understand how we ended up here.
>=20
> IIRC this behaviour was originally motivated by limitations of PC AT
> hardware. Intel 8237 is a 16-bit DMA controller. To make it somehow
> usable with addresses up to 16MB (yeah, the infamous DMA zone), IBM
> added a page register, but it was on a separate chip and it did not
> increment when the 8237 address rolled over back to zero. Effectively,
> the page register selected a 64K-aligned window of 64K buffers.
> Consequently, DMA buffers could not cross a 64K physical boundary.
>=20
> Thanks to how the buddy allocator works, the 64K-boundary constraint
> was satisfied by allocation size, and drivers took advantage of it when
> allocating device buffers. IMO software bounce buffers simply followed
> the same logic that worked for buffers allocated by the buddy allocator.
>=20
> OTOH min_align_mask was motivated by NVME which prescribes the value of
> a certain number of low bits in the DMA address (for simplicity assumed
> to be identical with the same bits in the physical address).
>=20
> The only pre-existing user of alloc_align_mask is x86 IOMMU code, and
> IIUC it is used to guarantee that unaligned transactions do not share
> the IOMMU granule with another device. This whole thing is weird,
> because swiotlb_tbl_map_single() is called like this:
>=20
>                 aligned_size =3D iova_align(iovad, size);
>                 phys =3D swiotlb_tbl_map_single(dev, phys, size, aligned_=
size,
>                                               iova_mask(iovad), dir, attr=
s);
>=20
> Here:
>=20
> * alloc_size =3D iova_align(iovad, size)
> * alloc_align_mask =3D iova_mask(iovad)
>=20
> Now, iova_align() rounds up its argument to a multiple of iova granule
> and iova_mask() is simply "granule - 1". This works, because granule
> size must be a power of 2, and I assume it must also be >=3D PAGE_SIZE.
>=20
> In that case, the alloc_align_mask argument is not even needed if you
> adjust the code to match documentation---the resulting buffer will be
> aligned to a granule boundary by virtue of having a size that is a
> multiple of the granule size.
>=20
> To sum it up:
>=20
> 1. min_align_mask is by far the most important constraint. Devices will
>    simply stop working if it is not met.
> 2. Alignment to the smallest PAGE_SIZE order which is greater than or
>    equal to the requested size has been documented, and some drivers
>    may rely on it.
> 3. alloc_align_mask is a misguided fix for a bug in the above.
>=20
> Correct me if anything of the above is wrong.

I thought about it some more, and I believe I know what should happen
if the first two constraints appear to be mutually exclusive.

First, the alignment based on size does not guarantee that the resulting
physical address is aligned. In fact, the lowest IO_TLB_SHIFT bits must
be always identical to the original buffer address.

Let's take an example request like this:

   TLB_SIZE       =3D 0x00000800
   min_align_mask =3D 0x0000ffff
   orig_addr      =3D 0x....1234
   alloc_size     =3D 0x00002800

Minimum alignment mask requires to keep the 1234 at the end. Allocation
size requires a buffer that is aligned to 16K. Of course, there is no
16K-aligned slot with slot_address & 0x7ff =3D=3D 0x200, but if IO_TLB_SHIFT
was 14, it would be slot_address & 0x3fff =3D=3D 0 (low IO_TLB_SHIFT are
masked off). Since the SWIOTLB API does not guarantee any specific
value of IO_TLB_SHIFT, callers cannot rely on it. That means 0x1234 is a
perfectly valid bounce buffer address for this example.

The caller may rightfully expect that the 16K granule containing the
bounce buffer is not shared with any other user. For the above case I
suggest to increase the allocation size to 0x4000 already in
swiotlb_tbl_map_single() and treat 0x1234 as the offset from the slot
address.

Will, do you want to incorporate it into your patch series, or should I
send the corresponding patch?

Petr T

