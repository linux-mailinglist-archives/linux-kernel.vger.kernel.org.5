Return-Path: <linux-kernel+bounces-90882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A2870643
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAD11C210C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422C247F73;
	Mon,  4 Mar 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="b7aEd7Nh"
Received: from bee.tesarici.cz (unknown [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C5047793
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567713; cv=none; b=CoKfffoAqyX+ybkpe0wFIQf7ZiVEo+rrE2jKsfFVUREPYU2uBp3bs2CM2EVHqNXeRyGPwBmny42t2jqAZIpywC65sd/ABQCxqNx04Nc25MUbYH0fdzkhDqYcdz7hJqkpp9Nq5lhRmtBDFlr0BwhdhoXh7iUdQ2M8VePTVS25IHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567713; c=relaxed/simple;
	bh=14NU+b/G2CLpm7U/zRcQLn0OYUYn1BUTkK4Y5ZGum3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oW9/nr+pd7pdqrc/hRzyAAThxoVXOLFmq3o4isIr0qGlvQxXPNwKdIrZTxN48hvxprXVQjn5WYSVcGoWBa9T2wgfChm/371mZ85SN4V+3WWAURC4EeMNdCyzpnZuRCqoQh8qRV4SX/YVPYxCRCVrLyQmu3LVgtFekj33i9kuRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=b7aEd7Nh; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 6DC291C5E72;
	Mon,  4 Mar 2024 16:55:08 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709567708; bh=57QGGoKd9Kgf+T1PLgNgi4sMYyCwAZGXPhkPQm8GOlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b7aEd7Nh6j6ZOw4vBBFzUWAd2aRQ4LGI4Eu4YDkyCSyGUcJGA7DyE/MGMXotqJzDi
	 vviVQCNBDuoSWbru5W+nFcPs8mWItrb3zbRqf3h/5aiTgMCOKBrR5AtBsbiElyO9k9
	 RGkQrdW2AKgT/qdQleJc/DRI5qMMf/Q5gGdX/Wl5WrvTwjJv9c/eJ+6MbLKouxcGly
	 4tVkZEg5QVxMi8vwbyhJ9c4m4rOFdUaVxO7N1ZtT0fOidQC7BLfKEdD49kG/q+1lMA
	 XWl/VNN5cnPEVKmc4W+sQp406bQRAsd3ZdQly5NpQwnaS4IqJGvg1hX7UUzHCUIFCt
	 wje6Uw6+uuYxw==
Date: Mon, 4 Mar 2024 16:55:06 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Michael Kelley <mhklinux@outlook.com>, Christoph Hellwig <hch@lst.de>,
 Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>, "kernel-team@android.com"
 <kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Dexuan Cui
 <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Message-ID: <20240304165506.49e3b2d3@meshulam.tesarici.cz>
In-Reply-To: <ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com>
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
	<20240304120055.56035c21@meshulam.tesarici.cz>
	<ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Mar 2024 13:37:56 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 04/03/2024 11:00 am, Petr Tesa=C5=99=C3=ADk wrote:
> [...]
> >> Here's my take on tying all the threads together. There are
> >> four alignment combinations:
> >>
> >> 1. alloc_align_mask: zero; min_align_mask: zero
> >> 2. alloc_align_mask: zero; min_align_mask: non-zero
> >> 3. alloc_align_mask: non-zero; min_align_mask: zero/ignored
> >> 4. alloc_align_mask: non-zero; min_align_mask: non-zero =20
> >=20
> > What does "min_align_mask: zero/ignored" mean? Under which
> > circumstances should be a non-zero min_align_mask ignored?
> >  =20
> >> xen_swiotlb_map_page() and dma_direct_map_page() are #1 or #2
> >> via swiotlb_map() and swiotlb_tbl_map_single()
> >>
> >> iommu_dma_map_page() is #3 and #4 via swiotlb_tbl_map_single()
> >>
> >> swiotlb_alloc() is #3, directly to swiotlb_find_slots()
> >>
> >> For #1, the returned physical address has no constraints if
> >> the requested size is less than a page. For page size or
> >> greater, the discussed historical requirement for page
> >> alignment applies.
> >>
> >> For #2, min_align_mask governs the bits of the returned
> >> physical address that must match the original address. When
> >> needed, swiotlb must also allocate pre-padding aligned to
> >> IO_TLB_SIZE that precedes the returned physical address.  A
> >> request size <=3D swiotlb_max_mapping_size() will not exceed
> >> IO_TLB_SEGSIZE even with the padding. The historical
> >> requirement for page alignment does not apply because the
> >> driver has explicitly used the newer min_align_mask feature. =20
> >=20
> > What is the idea here? Is it the assumption that only old drivers rely
> > on page alignment, so if they use min_align_mask, it proves that they
> > are new and must not rely on page alignment? =20
>=20
> Yes, if a driver goes out of its way to set a min_align_mask which is=20
> smaller than its actual alignment constraint, that is clearly the=20
> driver's own bug. Strictly we only need to be sympathetic to drivers=20
> which predate min_align_mask, when implicitly relying on page alignment=20
> was all they had.
>=20
> >> For #3, alloc_align_mask specifies the required alignment. No
> >> pre-padding is needed. Per earlier comments from Robin[1],
> >> it's reasonable to assume alloc_align_mask (i.e., the granule)
> >> is >=3D IO_TLB_SIZE. The original address is not relevant in
> >> determining the alignment, and the historical page alignment
> >> requirement does not apply since alloc_align_mask explicitly
> >> states the alignment. =20
>=20
> FWIW I'm also starting to wonder about getting rid of the alloc_size=20
> argument and just have SWIOTLB round the end address up to=20
> alloc_align_mask itself as part of all these calculations. Seems like it=
=20
> could potentially end up a little simpler, maybe?
>=20
> >> For #4, the returned physical address must match the bits
> >> in the original address specified by min_align_mask.  swiotlb
> >> swiotlb must also allocate pre-padding aligned to
> >> alloc_align_mask that precedes the returned physical address.
> >> Also per Robin[1], assume alloc_align_mask is >=3D
> >> min_align_mask, which solves the conflicting alignment
> >> problem pointed out by Petr[2]. Perhaps we should add a
> >> "WARN_ON(alloc_align_mask < min_align_mask)" rather than
> >> failing depending on which bits of the original address are
> >> set. Again, the historical requirement for page alignment does
> >> not apply. =20
> >=20
> > AFAICS the only reason this works in practice is that there are only
> > two in-tree users of min_align_mask: NVMe and Hyper-V. Both use a mask
> > of 12 bits, and the IOVA granule size is never smaller than 4K. =20
>=20
> If we assume a nonzero alloc_align_mask exclusively signifies iommu-dma,=
=20
> then for this situation SWIOTLB should only need to worry about the=20
> intersection of alloc_align_mask & min_align_mask, since any=20
> min_align_mask bits larger than the IOVA granule would need to be=20
> accounted for in the IOVA allocation regardless of SWIOTLB.

Ah, right, it's not limited to bounce buffers.

> > If we want to rely on this, then I propose to make a BUG_ON() rather
> > than WARN_ON(). =20
>=20
> I've just proposed a patch to make it not matter for now - the nature of=
=20
> iommu-dma makes it slightly more awkward to prevent SWIOTLB from ever=20
> seeing this condition at all, so I chose not to do that, but as long as=20
> swiotlb_tbl_map_single() does *something* for conflicting constraints=20
> without completely falling over, which swiotlb_tbl_unmap_single can then=
=20
> undo again, then it should be fine.

Yes. It may allocate an unsuitably aligned bounce buffer, or it may
fail, but your IOMMU patch will continue to work (and also cover the
non-SWIOTLB case).

I believe this patch series is now good as is, except the commit
message should make it clear that alloc_align_mask and min_align_mask
can both be zero, but that simply means no alignment constraints.

Thanks,
Petr T

