Return-Path: <linux-kernel+bounces-165182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DED8B892A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704571F23197
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FF360BBE;
	Wed,  1 May 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="x7YnD+NQ"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373F51012;
	Wed,  1 May 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714562502; cv=none; b=Vl82qkRtLq4uH/lMVgVPZsGugvu/T+a3BXPqMio9W5t+a2GQaH1vWF7WiVOXpMN7rwh9YbNDp0zg55fjxrrj8CGoqCgv6xj4oGLw2A7kGk3qijAZZN6wirjBFVI49X1mGgoe9O/DRKk0UZi1IWstlL7BVrvwwGQu0IzJJtfY9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714562502; c=relaxed/simple;
	bh=aukg8XygoU/tHZmfHQJiWI5+qkxsLkxS+JlmBKyJbLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8KGjPcF6u0OoJ3MWmDMREX+TC+zp7e40lyrZz0ytN/CB72Mi2M5Km95Xh+m3AueN3J+EwqybbhG0xeHfWEaeZSBjvwlbXhHzru7vSbOjFL5MYHy/mLDX6ERmDmkJ/YBdv5cvmGIFLUwXIdUMHpNjfhVdxs/g/QV4HK8g2pySxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=x7YnD+NQ; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id DD01D1B3EAE;
	Wed,  1 May 2024 13:21:35 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1714562496; bh=yX5KcB4S/Oqw9I+Le8+2EvUssgBuoEZIsBVsDa++6bQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=x7YnD+NQizeLFfIPEfS6HPJcDPqVH2aC1DcJ08dc1CY9Q4vyP9qAmhSFnSQd994ML
	 ZpfhnGzUJIkWXb3k4B1WaUXanOYriGkWp/fZvYGDJBOeBdfMRlyAqbw/1RXs9UqwQ1
	 5HlZ8qIEwXz/E7i9EX9QFmQsgg+uosJoFlQAbK7VYH5t/FH5O9+JG2UwuMUyAlxjgn
	 j2ZVCOftiRUCMuYaYfnhg30eoJ0QgKQBWkQH+E7z+G8DbwCohOJm8XVnMEVmtkRpuX
	 wY7PPUd5SRtX20Oo6mg/UMQR4RJ8HgNILrjHZU1pwyGudT72UOffIFrqULRqLV5teZ
	 QyGfXSi9db70A==
Date: Wed, 1 May 2024 13:21:34 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: mhkelley58@gmail.com, mhklinux@outlook.com, robin.murphy@arm.com,
 joro@8bytes.org, will@kernel.org, m.szyprowski@samsung.com, corbet@lwn.net,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v3 1/1] Documentation/core-api: Add swiotlb
 documentation
Message-ID: <20240501132134.24d3d5d8@meshulam.tesarici.cz>
In-Reply-To: <20240501044910.GD31252@lst.de>
References: <20240429151337.1069470-1-mhklinux@outlook.com>
	<20240430132413.69797af1@mordecai>
	<20240501044910.GD31252@lst.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 1 May 2024 06:49:10 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Apr 30, 2024 at 01:24:13PM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > > +swiotlb was originally created to handle DMA for devices with addres=
sing
> > > +limitations. As physical memory sizes grew beyond 4 GiB, some device=
s could
> > > +only provide 32-bit DMA addresses. By allocating bounce buffer memor=
y below
> > > +the 4 GiB line, these devices with addressing limitations could stil=
l work and
> > > +do DMA. =20
> >=20
> > IIRC the origins are even older and bounce buffers were used to
> > overcome the design flaws inherited all the way from the original IBM
> > PC. =20
>=20
> [correct, but for swiotlb largely irrelevant PC addressing bits snipped]
>=20
> swiotlb was added with the merge of the ia64 port to address 32-bit
> addressing limitations.  The 1MB addressing limitations of the PC did
> and still do of course exist, but weren't dealt with in any coherent
> fashion, and still aren't.  Swiotlb isn't related to them.

Thanks for correcting me. Oh, and this is probably why some drivers did
their own bounce buffering. I was mistaken that swiotlb was supposed to
clean up the existing mess...

> > > +data to/from the original target memory buffer. The CPU copying brid=
ges between
> > > +the unencrypted and the encrypted memory. This use of bounce buffers=
 allows
> > > +existing device drivers to "just work" in a CoCo VM, with no modific=
ations
> > > +needed to handle the memory encryption complexity. =20
> >=20
> > This part might be misleading. It sounds as if SWIOTLB would not be
> > needed if drivers were smarter. But IIUC that's not the case. SWIOTLB
> > is used for streaming DMA, where device drivers have little control
> > over the physical placement of a DMA buffer. For example, when a
> > process allocates some memory, the kernel cannot know that this memory
> > will be later passed to a write(2) syscall to do direct I/O of a
> > properly aligned buffer that can go all the way down to the NVMe driver
> > with zero copy. =20
>=20
> I think the statement in the text is fine and easy to understand.  CoCo
> drivers could instead always map the memory unencrypted (which would have
> no so nice security and performance properties) or use fixed ringbuffers
> in shared unencrypted memory (which would require a different driver
> architecture).
>=20
> > > +block. Hence the default memory pool for swiotlb allocations must be
> > > +pre-allocated at boot time (but see Dynamic swiotlb below). Because =
swiotlb
> > > +allocations must be physically contiguous, the entire default memory=
 pool is
> > > +allocated as a single contiguous block. =20
> >=20
> > Allocations must be contiguous in target device's DMA address space. In
> > practice this is achieved by being contiguous in CPU physical address
> > space (aka "physically contiguous"), but there might be subtle
> > differences, e.g. in a virtualized environment.
> >=20
> > Now that I'm thinking about it, leave the paragraph as is, and I'll
> > update it if I write the code for it. =20
>=20
> Heh.  The only think making cpu non-contiguous address space contiguous
> for a device is an iommu.  And when we have that we only use swiotlb
> for unaligned iommu pages, so I'm not sure how we'd ever get there.

Yes, there's no way to make CPU non-contiguous addresses contiguous for
a device (except with IOMMU), but there are some real-world bus bridges
that make a CPU contiguous address range non-contiguous for a target
device, most often by limiting the address width and overflowing at the
correspondign boundary.

This is moot anyway, because I suggest to leave the paragraph as is.

Petr T

