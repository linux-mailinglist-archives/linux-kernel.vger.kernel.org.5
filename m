Return-Path: <linux-kernel+bounces-97380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E278769C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649DD282CC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8727228DA5;
	Fri,  8 Mar 2024 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="pam1G0Z+"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8D28DA4
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918557; cv=none; b=uRrcSTq/u9kOIBjZBEnbpjXqXGQE68rWNIofRyrzyFkkGI2cyuweVtk/gP4SwgMjLa65v8NGlAnCKJBvp13A3ei2R5i6zzMyiuaicNP5uyufANMuMZb6rcxxRwB9hZSeZTjQmiegyhfk4vy6W90wmeloQiVfbqR6J2bjufYypzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918557; c=relaxed/simple;
	bh=GkDhdbaweBxHBVnSFe/4jZfuGtdvnP5xJfMMoRIrsbo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xj+Ueg+LBTdTcHC0K8RBmf5jhFjHqIOcZ11OOvKBJ5Ijb62Se8NBjd1LxO3tfT40YPESIBLxYgH/tOsdWHwlxo04haC+WCgYtEuNKhnxqR3PIVm++PpID3Aa3MDMpEZagarebj9/nk9htCt+i6+uV7JBqIudQnF2ki1vtrM4L8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=pam1G0Z+; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 0D8421CD637;
	Fri,  8 Mar 2024 18:22:34 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709918554; bh=IIjocy0slfVtwd++6GcQ24vjrbD1TY3TGPMpZvNOIEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pam1G0Z+1K+Gxm7SaqFhf8CCIXCd11ATi8Dma6oxnzxC4A+LFMnsckIEgyqkgYhRb
	 A9s2lvSYxSpy/n/7Gf2Q77F5+x9Du6lAMfyqbYImOcUqA410H6IBN638O8cObTTp2s
	 E61RbagsAOBBjf6LpZe+uZ2fZPCoodw5vSExUjyeXR9HUDwoknBBs89PhvicLPs5mb
	 diyaLp00dUceopAen3TSdmBXDeGZdOtVbKBSM4P40Qdn4q37LPyKZEw6JUcWvn1yEz
	 pFLo7hmYMZkSbBQn0dL0gA3Fp2s6s1MsQ9/K2GFxnQK/yjiXoKyDpmsAG60EvY8FoY
	 nnJF2bV9RZ6gA==
Date: Fri, 8 Mar 2024 18:22:32 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH v6 6/6] swiotlb: Reinstate page-alignment for mappings
 >= PAGE_SIZE
Message-ID: <20240308182232.2480a1f3@meshulam.tesarici.cz>
In-Reply-To: <20240308165025.GA18550@lst.de>
References: <20240308152829.25754-1-will@kernel.org>
	<20240308152829.25754-7-will@kernel.org>
	<5c7c7407-5356-4e12-a648-ae695fe0d1cb@arm.com>
	<20240308173816.5351ea58@meshulam.tesarici.cz>
	<20240308165025.GA18550@lst.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Mar 2024 17:50:25 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Mar 08, 2024 at 05:38:16PM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > I thought we agreed that this stricter alignment is unnecessary:
> >=20
> >   https://lore.kernel.org/linux-iommu/20240305140833.GC3659@lst.de/
> >=20
> > But if everybody else wants to have it... =20
>=20
> Let's get the fixes in with the existing documented alignment, and
> then lift it in the next merge window with enough soaking time in
> linux-next.

I agree. It make sense.

Petr T

