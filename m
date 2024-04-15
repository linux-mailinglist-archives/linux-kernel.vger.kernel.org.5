Return-Path: <linux-kernel+bounces-145143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 336198A5017
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6420B22F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912E4757EB;
	Mon, 15 Apr 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="c8k06kIO"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EC212C479
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185429; cv=none; b=jFnvtPigGJURkHmylPCdTOhJbIp4y/x7XT6LKrauR3Uq0njW3Pn86vGFcVNNNwgBiQBO6ww+gucpgL6MWzv+PK5UIDi08596TZ3kKAz1giqlbRLkUHVQqauHKcxLHV5NWVzcoYJp/VeB2iCgM8EozyoBq++aVG9C1+33wHnutsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185429; c=relaxed/simple;
	bh=xHFLg5fqlc+HOQ0Z21oGzxf3qkjSRXcoOQn++v9/0TE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zes6RfvKzFZ0sSX3HXMy/q9AwNd2QmjbHN8IJQem/tOkBqHMCJr9TtZlIXG52UKxZ7dYjLVKu/uQf4ThlP608cNmgArnpKV1LDtNrnFnGbZLlKMyHM8RkJV9yJUResuyehPCr/8CmJ7SADSzkUHtdlz0rFQm6r9qhyqdZ0x4/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=c8k06kIO; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 9439E1BF928;
	Mon, 15 Apr 2024 14:50:24 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1713185424; bh=M2HaBAuTKrviowlzyI5h8oMxT5Sg+xhz7eOEBl7jJB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c8k06kIOXmMJv7e2ISjtiEV6tNW/S+yPRdzSor2v9Ruz3mcCQpiNe24AiI1zjWSko
	 MqS/+pJZVWvHolsHemuBN7L2IifbIPIQlS1hAn3mEEoYHiMKEUQyG0UZq1O/FcUlEO
	 45fdUvgFPHC9mwNNPMarBaLqlbtpAsgga/rVRGdXEWqBpIFLXuWCWI3zwCCKRPD3Vc
	 XEopKqj+lIjr5amlK43aRwFu+zO95cwkxZaXrklAnO7RVMzUDaodKHArz0nxXer6h7
	 YEVLNNwFVU99aeGT/khpEWzFh9IPgCptc4SEhlTqI6ISRsUsLBAItVnPmeN/bB3LFO
	 lCIGSEtpA+baA==
Date: Mon, 15 Apr 2024 14:50:23 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "mhkelley58@gmail.com" <mhkelley58@gmail.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>, "jgross@suse.com" <jgross@suse.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
 "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "roberto.sassu@huaweicloud.com"
 <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH 1/2] swiotlb: Remove alloc_size argument to
 swiotlb_tbl_map_single()
Message-ID: <20240415145023.78e7ce97@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB4157C8206FE193B2C5B2A93FD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240408041142.665563-1-mhklinux@outlook.com>
	<20240415134624.22092bb0@meshulam.tesarici.cz>
	<SN6PR02MB4157C8206FE193B2C5B2A93FD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2024 12:23:22 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Monday, April 15, 2=
024 4:46 AM
> >=20
> > Hi Michael,
> >=20
> > sorry for taking so long to answer. Yes, there was no agreement on the
> > removal of the "dir" parameter, but I'm not sure it's because of
> > symmetry with swiotlb_sync_*(), because the topic was not really
> > discussed.
> >=20
> > The discussion was about the KUnit test suite and whether direction is
> > a property of the bounce buffer or of each sync operation. Since DMA API
> > defines associates each DMA buffer with a direction, the direction
> > parameter passed to swiotlb_sync_*() should match what was passed to
> > swiotlb_tbl_map_single(), because that's how it is used by the generic
> > DMA code. In other words, if the parameter is kept, it should be kept
> > to match dma_map_*().
> >=20
> > However, there is also symmetry with swiotlb_tbl_unmap_single(). This
> > function does use the parameter for the final sync. I believe there
> > should be a matching initial sync in swiotlb_tbl_map_single(). In
> > short, the buffer sync for DMA non-coherent devices should be moved from
> > swiotlb_map() to swiotlb_tbl_map_single(). If this sync is not needed,
> > then the caller can (and should) include DMA_ATTR_SKIP_CPU_SYNC in
> > the flags parameter.
> >=20
> > To sum it up:
> >=20
> > * Do *NOT* remove the "dir" parameter.
> > * Let me send a patch which moves the initial buffer sync.
> >  =20
>=20
> I'm not seeing the need to move the initial buffer sync.  All
> callers of swiotlb_tbl_map_single() already have a subsequent
> check for a non-coherent device, and a call to=20
> arch_sync_dma_for_device().  And the Xen code has some=20
> special handling that probably shouldn't go in
> swiotlb_tbl_map_single().  Or am I missing something?

Oh, sure, there's nothing broken ATM. It's merely a cleanup. The API is
asymmetric and thus confusing. You get a final sync by default if you
call swiotlb_tbl_unmap_single(), but you don't get an initial sync by
default if you call swiotlb_tbl_map_single(). This is difficult to
remember, so potential new users of the API may incorrectly assume that
an initial sync is done, or that a final sync is not done.

And yes, when moving the code, all current users of
swiotlb_tbl_map_single() should specify DMA_ATTR_SKIP_CPU_SYNC.

Petr T

