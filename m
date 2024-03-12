Return-Path: <linux-kernel+bounces-100134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B06879255
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443E11F229CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCE269D09;
	Tue, 12 Mar 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="kQh2ipPA"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0958ADB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710240252; cv=none; b=e7Y7x1aJNyqR3nM0PBj6HxeKBkeAkb6AWOQW746lZtW/I0pc4pd5YFztJHtrYiEQfvp1XxdpBcGuNkIwXJvZlgXSBBdgj5NkeyB4YvVKkHWFdMUcUiogj/Zql+hoOy6el0V3j6EQgFgneHd+A3j2xvlKZLxJoTwXWFNUy1pf4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710240252; c=relaxed/simple;
	bh=IvsQlHr33C+BlhA4MSbkk54Qsryx8yzEIHkCOnKNFjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZTbrcJdxo32g4usUvitgkbt9rSJuPY1HJSMsBlAXNKDWgIgTgGvDL6+/yzFQKiQcIlzdJcLrBM3xAcdbd1qizlOL9kHlynagxv5k+80tSfayNJeCclhAUzsgAWAoWs+G+IF9UvMlBD21VhWDkdSbArq0Ap/eNgK/GSrjS3TCR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=kQh2ipPA; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id D7F06192F81;
	Tue, 12 Mar 2024 11:44:06 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1710240247; bh=ITLwhGMEZ24CbUrHEJA7iFp8qXIC6P69efW9R3b30Xk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kQh2ipPAvoEV0qxucFcQ465bMg8jOaopCLq4e2wmGWwB4QWYe9e+DMbqBMVDHiLoM
	 dW3HTWBxWK2vjD+qkaKnEm7ahmnFbErOQ+39VIc15U3oENnQ0l60gBwbfXUE9JW9D9
	 47yrNmEuu8Ww0eaQPPQmy/IWk5hNFlpNeDjluB4gkRVmnVVZA0YQt0P6MHojKVo3oz
	 8kdQ+0Y31hObogc7F+n3dqGFzsvM40dCIROeG8nuLyYT6plQB1kZ9UJYIVH38SJKr0
	 evPv1kw4jbXccgLItIq3YSC8wZksR1Ww2D/MU+XfdOmUKJ4uy/ahp17MSmYc6KFzCO
	 kEBY88ej4Rtdw==
Date: Tue, 12 Mar 2024 11:44:06 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Michael Kelley <mhklinux@outlook.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-team@android.com" <kernel-team@android.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
 <robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v6 4/6] swiotlb: Fix alignment checks when both
 allocation and DMA masks are present
Message-ID: <20240312114406.792cc8f9@meshulam.tesarici.cz>
In-Reply-To: <Ze+nT+4Radnd/iyw@Asurada-Nvidia>
References: <20240308152829.25754-1-will@kernel.org>
	<20240308152829.25754-5-will@kernel.org>
	<20240311210507.217daf8b@meshulam.tesarici.cz>
	<SN6PR02MB41576E58DDF5A56FC6FC1EB6D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
	<Ze+nT+4Radnd/iyw@Asurada-Nvidia>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Mar 2024 17:52:31 -0700
Nicolin Chen <nicolinc@nvidia.com> wrote:

> On Mon, Mar 11, 2024 at 09:36:10PM +0000, Michael Kelley wrote:
> > From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> =20
> > > I find it somewhat surprising that NVMe does not
> > > in fact require that the NVME_CTRL_PAGE_SHIFT low bits are preserved,
> > > as suggested by Nicolin's successful testing.
> > >
> > > Why is that? =20
> >=20
> > I saw only one stack trace from Nicolin, and it was file system buffer
> > flushing code that initiated the I/O.  In such cases, it's very likely =
that the
> > original address is at least 4K aligned.  Hence the offset is zero and
> > the low bits will typically be correct. =20
>=20
> Though I didn't dig any deeper here, I do see some unaligned
> original addresses passed in at the top level:
>        fsck.ext4-286     [004] .....     2.594190: iommu_dma_map_page: ca=
lling swiotlb_tbl_map_single with phys: be750600
>        fsck.ext4-286     [004] .....     2.613032: iommu_dma_map_page: ca=
lling swiotlb_tbl_map_single with phys: be780400
>        fsck.ext4-286     [004] .....     2.614096: iommu_dma_map_page: ca=
lling swiotlb_tbl_map_single with phys: be7c0600
>        fsck.ext4-286     [004] .....     2.614103: iommu_dma_map_page: ca=
lling swiotlb_tbl_map_single with phys: be7e0400
>            mount-288     [005] .....     2.615157: iommu_dma_map_page: ca=
lling swiotlb_tbl_map_single with phys: be800400
>       multipathd-405     [003] .....     3.062878: iommu_dma_map_page: ca=
lling swiotlb_tbl_map_single with phys: bda40218
>       multipathd-502     [002] .....     3.231721: iommu_dma_map_page: ca=
lling swiotlb_tbl_map_single with phys: bd3107b8
>            mount-525     [002] .....     3.250281: iommu_dma_map_page: ca=
lling swiotlb_tbl_map_single with phys: bd340200
>       multipathd-529     [004] .....     3.259053: iommu_dma_map_page: ca=
lling swiotlb_tbl_map_single with phys: be620478
>       multipathd-571     [005] .....     3.292893: iommu_dma_map_page: ca=
lling swiotlb_tbl_map_single with phys: be900328
>       multipathd-580     [005] .....     3.318832: iommu_dma_map_page: ca=
lling swiotlb_tbl_map_single with phys: be9207c8

Thank you. Indeed, bit 11 of the physical address was zero in all the
above calls, and that's why it works.

Petr T

