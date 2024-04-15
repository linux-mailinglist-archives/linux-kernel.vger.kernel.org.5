Return-Path: <linux-kernel+bounces-145236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD808A513C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AE84B23BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C7B208B0;
	Mon, 15 Apr 2024 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="09GybjZJ"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B6B5D74E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187174; cv=none; b=HTkaf4A+y8OAIuWICKUSScoJSgDhX4oASV0250NaGzS+0v6XCffTr+Su3FgxkEtSibDz2p65H30Dpf3HGpREdzPwL+TNaWZ8U0IOB/fhOEIPZxTVcwGnWZLjhL2wfQlYX2yiVEakCgUlUv9nPRskw9j2nqdA5aejk5HRBg8wjno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187174; c=relaxed/simple;
	bh=V3w3lxBxdx1g2rbfU49MScfZLmbOgUTm9NFTMUes6po=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrilCuh7SiM1c45rtBYWKbtZpRbZdbCEb5y1KJQX7GYcwdcGKnJzUVC7UA4YVAgAtjvY+6h5z7li/0VOfjHgmJvRx0S4Ag4ifUMrU4y2M4EN/co0AE1GMF93ecT0PkQ1ebeb+4HEZLQR/UX8162jXxjQtYJFVJaWBnmcEzhL6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=09GybjZJ; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 171AF1BEEE3;
	Mon, 15 Apr 2024 15:19:29 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1713187170; bh=H7qkdyb/Y4bVUiPoNIOX6jPwjCN1aPjIKdG4tz+fkTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=09GybjZJ1pkgrpv8t2KOl3uKTKKOq3Mydc0g3n0IOtyEHDRPP38j3ntH7mdKsnlAO
	 6Hqcizz8+UeFHftXQg4reiQDgXnI3Lo5tTfhPMDjy2DPgjpME3XCggOTCFtRPmfU83
	 5xWyfvjSKaNrWlhcEBxmEc51bHRiOeWnoiySR7p+DA8hU9ksIvEokmv5ep0UBNkE1q
	 XvETXhkz88EpVJGcOFb5FwfLqXpnwF5ofgJYpSaAeXve2JZFyP04cGW/pC/uxbLIuy
	 6bMCzD0Dy/wm5IaVr5qHmb86wUL3hZVhs5KYU5uRTnTuHi301uT2VJjFYmHdcqH//1
	 sIs0YspVlj5xg==
Date: Mon, 15 Apr 2024 15:19:27 +0200
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
Message-ID: <20240415151927.0145f742@meshulam.tesarici.cz>
In-Reply-To: <SN6PR02MB415749D379BFCC0749B44900D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240408041142.665563-1-mhklinux@outlook.com>
	<20240415134624.22092bb0@meshulam.tesarici.cz>
	<SN6PR02MB4157C8206FE193B2C5B2A93FD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
	<20240415145023.78e7ce97@meshulam.tesarici.cz>
	<SN6PR02MB415749D379BFCC0749B44900D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2024 13:03:30 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Monday, April 15, 2=
024 5:50 AM
> >=20
> > On Mon, 15 Apr 2024 12:23:22 +0000
> > Michael Kelley <mhklinux@outlook.com> wrote:
> >  =20
> > > From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> Sent: Monday, April 1=
5, 2024 4:46 AM =20
> > > >
> > > > Hi Michael,
> > > >
> > > > sorry for taking so long to answer. Yes, there was no agreement on =
the
> > > > removal of the "dir" parameter, but I'm not sure it's because of
> > > > symmetry with swiotlb_sync_*(), because the topic was not really
> > > > discussed.
> > > >
> > > > The discussion was about the KUnit test suite and whether direction=
 is
> > > > a property of the bounce buffer or of each sync operation. Since DM=
A API
> > > > defines associates each DMA buffer with a direction, the direction
> > > > parameter passed to swiotlb_sync_*() should match what was passed to
> > > > swiotlb_tbl_map_single(), because that's how it is used by the gene=
ric
> > > > DMA code. In other words, if the parameter is kept, it should be ke=
pt
> > > > to match dma_map_*().
> > > >
> > > > However, there is also symmetry with swiotlb_tbl_unmap_single(). Th=
is
> > > > function does use the parameter for the final sync. I believe there
> > > > should be a matching initial sync in swiotlb_tbl_map_single(). In
> > > > short, the buffer sync for DMA non-coherent devices should be moved=
 from
> > > > swiotlb_map() to swiotlb_tbl_map_single(). If this sync is not need=
ed,
> > > > then the caller can (and should) include DMA_ATTR_SKIP_CPU_SYNC in
> > > > the flags parameter.
> > > >
> > > > To sum it up:
> > > >
> > > > * Do *NOT* remove the "dir" parameter.
> > > > * Let me send a patch which moves the initial buffer sync.
> > > > =20
> > >
> > > I'm not seeing the need to move the initial buffer sync.  All
> > > callers of swiotlb_tbl_map_single() already have a subsequent
> > > check for a non-coherent device, and a call to
> > > arch_sync_dma_for_device().  And the Xen code has some
> > > special handling that probably shouldn't go in
> > > swiotlb_tbl_map_single().  Or am I missing something? =20
> >=20
> > Oh, sure, there's nothing broken ATM. It's merely a cleanup. The API is
> > asymmetric and thus confusing. You get a final sync by default if you
> > call swiotlb_tbl_unmap_single(),  =20
>=20
> I don't see that final sync in swiotlb_tbl_unmap_single().  It calls
> swiotlb_bounce() to copy the data, but it doesn't deal with
> non-coherent devices or call arch_sync_dma_for_cpu().

Ouch. You're right! The buffer gets only bounced but not synced if
device DMA is non-coherent. So, how is this supposed to work?

Now I'm looking at the code in dma_direct_map_page(), and it calls
arch_sync_dma_for_device() explicitly, _except_ when using SWIOTLB. So,
maybe I should instead review all callers of swiotlb_map(), make sure
that they handle non-coherent devices, and then remove the sync from
swiotlb_map()?

I mean, the current situation seems somewhat disorganized to me.

Petr T

