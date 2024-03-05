Return-Path: <linux-kernel+bounces-92586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFBA872281
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFD11C21B2E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DA61272B2;
	Tue,  5 Mar 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="tbaTYFD4"
Received: from bee.tesarici.cz (unknown [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4E126F38
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651768; cv=none; b=IaVauuounAfBH3V7QVaivANCsqV7cp8IS0zu5Dy5hQWCGWISchAt216RUI2AUnsEbmnSL8pp8buB/KnSQBPoLs48InD7yokwkLaYvK9SOFvNuix2RdlgHhvzzygtl1+yOIjTpNhuffLnUcQykCdbwx0eiLRwtFfn5WDetBd4rNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651768; c=relaxed/simple;
	bh=gcLuym4tORjlH5EIM/roVTuZMRa/La7PuANUj3Vlrdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgRGrEfm1cROtNtqn0/NJYvYxLNMNsMKUjM/4qqqdVBsIXTkyWUpjo3I4/tzPYwDOYUKJ8X+oRtW/smUdg09Ue9wQgka/eSYSNVHILk5mMUs/dspMjwYnM8FoAxTdO4tt3rVnTNYA93xBDVKEMyO1y+kvEE+SF+Xap+BGMIDR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=tbaTYFD4; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (unknown [213.235.133.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 4351F1C8F14;
	Tue,  5 Mar 2024 16:15:50 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709651755; bh=y/6VHNYbM2dXn3PZSaRABe1IKBrYRIArcEvPm87Sib0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tbaTYFD4/j/2AsvvEEy0V7hmQraCBh0oPW8S3bg9ao+U0sxxiUVzx2qROocYHuEll
	 MUtixg6f/o4+5552CX0vF4BXq08ZxDF9np97Cp96vhm5XT9/+Eg8xBlZGLEkSkQwCb
	 C9P59wKcFnPcNRdum+Jp9h3/Pp7u8FFVSoaHmOGOYCQePv8cn//7twrNZnbpTOAh1f
	 20n37jIrYUWkmwQn+Z+gkPMwpNks00ryWscUju6o0wZ+gNy50wYxIgDMQUhQ5IASYf
	 qyKp4nyjGA1TE4bFoJKV6N9NljCp6Z01AqNXFQuEPvvd52WtJ75jegLNbgrFpsOcuR
	 cOEwoTek0Csjg==
Date: Tue, 5 Mar 2024 16:15:41 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Michael Kelley <mhklinux@outlook.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>, "kernel-team@android.com"
 <kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Dexuan Cui
 <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Message-ID: <20240305161541.5cb83203@meshulam.tesarici.cz>
In-Reply-To: <555d0e55-a8f8-446d-ab1a-f05e50b33477@arm.com>
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
	<b63d4332-b659-4897-83c7-04e5ad397a69@arm.com>
	<SN6PR02MB41574A920D7511D4E5DCE813D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
	<555d0e55-a8f8-446d-ab1a-f05e50b33477@arm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Mar 2024 11:20:13 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2024-03-04 6:22 pm, Michael Kelley wrote:
> > From: Robin Murphy <robin.murphy@arm.com> Sent: Monday, March 4, 2024 8=
:54 AM =20
> >>
> >> On 04/03/2024 4:10 pm, Michael Kelley wrote: =20
> >>> From: Will Deacon <will@kernel.org> Sent: Monday, March 4, 2024 8:02 =
AM =20
> >>>>
> >>>> Hi folks,
> >>>>
> >>>> On Mon, Mar 04, 2024 at 04:55:06PM +0100, Petr Tesa=C5=99=C3=ADk wro=
te: =20
> >>>>> On Mon, 4 Mar 2024 13:37:56 +0000
> >>>>> Robin Murphy <robin.murphy@arm.com> wrote: =20
> >>>>>> On 04/03/2024 11:00 am, Petr Tesa=C5=99=C3=ADk wrote:
> >>>>>> [...] =20
> >>>>>>>> Here's my take on tying all the threads together. There are
> >>>>>>>> four alignment combinations:
> >>>>>>>>
> >>>>>>>> 1. alloc_align_mask: zero; min_align_mask: zero =20
> >>>>
> >>>> Based on this ^^^ ...
> >>>> =20
> >>>>>>>> xen_swiotlb_map_page() and dma_direct_map_page() are #1 or #2
> >>>>>>>> via swiotlb_map() and swiotlb_tbl_map_single()
> >>>>>>>>
> >>>>>>>> iommu_dma_map_page() is #3 and #4 via swiotlb_tbl_map_single()
> >>>>>>>>
> >>>>>>>> swiotlb_alloc() is #3, directly to swiotlb_find_slots()
> >>>>>>>>
> >>>>>>>> For #1, the returned physical address has no constraints if
> >>>>>>>> the requested size is less than a page. For page size or
> >>>>>>>> greater, the discussed historical requirement for page
> >>>>>>>> alignment applies. =20
> >>>>
> >>>> ... and this ^^^ ...
> >>>>
> >>>> =20
> >>>>> I believe this patch series is now good as is, except the commit
> >>>>> message should make it clear that alloc_align_mask and min_align_ma=
sk
> >>>>> can both be zero, but that simply means no alignment constraints. =
=20
> >>>>
> >>>> ... my (possibly incorrect!) reading of the thread so far is that we
> >>>> should preserve page-aligned allocation in this case if the allocati=
on
> >>>> size is >=3D PAGE_SIZE.
> >>>>
> >>>> Something like the diff below, to replace this final patch?
> >>>>
> >>>> Will
> >>>> =20
> >>>> --->8 =20
> >>>>
> >>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> >>>> index c381a7ed718f..67eac05728c0 100644
> >>>> --- a/kernel/dma/swiotlb.c
> >>>> +++ b/kernel/dma/swiotlb.c
> >>>> @@ -992,6 +992,14 @@ static int swiotlb_search_pool_area(struct devi=
ce
> >>>> *dev, struct io_tlb_pool *pool
> >>>>           BUG_ON(!nslots);
> >>>>           BUG_ON(area_index >=3D pool->nareas);
> >>>>
> >>>> +       /*
> >>>> +        * Historically, allocations >=3D PAGE_SIZE were guaranteed =
to be
> >>>> +        * page-aligned in the absence of any other alignment requir=
ements.
> >>>> +        * Since drivers may be relying on this, preserve the old be=
haviour.
> >>>> +        */
> >>>> +       if (!alloc_align_mask && !iotlb_align_mask && alloc_size >=
=3D PAGE_SIZE)
> >>>> +               alloc_align_mask =3D PAGE_SIZE - 1;
> >>>> + =20
> >>>
> >>> Yes, I think that should do it. =20
> >>
> >> In principle it might be more logical to fudge this into
> >> iotlb_align_mask rather than alloc_align_mask =20
> >=20
> > I'm not understanding what you are getting at, but maybe we are
> > interpreting the historical page alignment requirement differently.
> > I think of the page alignment requirement as independent of the
> > orig_addr -- the returned physical address should always be exactly
> > page aligned, and not offset to match bits in orig_addr.  If that's
> > the case, then implementing the page alignment via
> > alloc_align_mask is logically the right place. Fudging into
> > iotlb_align_mask would do matching of bits in orig_addr.
> >=20
> > Or is there something else I'm not considering? =20
>=20
> In short, it's that alloc_align_mask is concerned with how slots are=20
> allocated, while min_align_mask is concerned with where the data itself=20
> is bounced (which may also place certain constraints on allocation).
>=20
> The reason this page-alignment was here in the first place was seemingly=
=20
> to serve the original swiotlb_alloc() path, and thus it could be=20
> considered functionally equivalent to what is now alloc_align_mask.=20
> However the side-effect it happened to also have for streaming mappings=20
> was to prevent sufficiently large page-aligned buffers being bounced to=20
> a non-page-aligned address, which apparently managed to work well enough=
=20
> for NVMe until 64K pages became more common and ruined things by being=20
> too big, and we formalised *that* desired effect into min_align_mask.
>=20
> I get that forcing io_tlb_align mask here would introduce a stronger=20
> constraint which affects non-page-aligned buffers as well, and wanting=20
> to avoid that is perhaps a reasonable concern, so once again I'm really=20
> just arguing semantics. Given the head-scratching we've been through=20
> over this already, I think it would be valuable to at least be clearer=20
> that a significant part of the "old behaviour" is to do the right thing=20
> for swiotlb_alloc(), which is very much still current and necessary, but=
=20
> the reason we're not setting alloc_align_mask there is because doing it=20
> here also preserves this legacy side-effect which acts as a limited=20
> version of min_align_mask to preserve page alignment when bouncing.

I'm confused. Doesn't PATCH 3/6 of this series change swiotlb_alloc()
to use alloc_align_mask (and finally do it properly for sizes greater
than page size)?

Anyway, the placement of streaming DMA buffers is not under control of
the device driver IIUC. These buffers may have been allocated without
even knowing that they would be once used for I/O. I cannot imagine how
a device driver could rely on its physical address beyond offfset
within a page. And even then it's subtly broken, because the size of
the mapping may be less than PAGE_SIZE (e.g. 512 bytes as traditional
sector size under direct I/O). Even if we keep the alignment based on
mapping size for now, it should probably be deprecated in favour of
min_align_mask.

Petr T

