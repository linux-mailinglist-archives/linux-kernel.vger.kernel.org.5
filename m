Return-Path: <linux-kernel+bounces-71333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D89085A3A1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28D1B2296F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E1A2E652;
	Mon, 19 Feb 2024 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="L1RXsQSu"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E6A2E85B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346423; cv=none; b=SprqZ7u/0e0xHxcjHr5klvpenmi/3pDLOCKxgwE/Vmg6wlDPTFhqaizYtoJGd63dqH063rO9VqUtDSHXfEi3rCKBRuF/xbvC5Z1u6/EIHqEIV0cFn0LG1Slube7AHVT1LL1u606YvHKfzjavKp0s9a0N+CRIjiZwc10FJePgLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346423; c=relaxed/simple;
	bh=07ZMRt2iZQCVacurZog+A+8XvHvFt9qPaPQy0WtWnPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gu4orMl4ajh7a3Ob5ChNOg+pFU/VSY/xxAUFKovohdI5LOqvLmzZd3T6J9jPS7TXIbov/j8quH0k85Yhq70+e71JoWojuFZ50qr2HtFQi1v6iIvuD1GIElupdLI7EBbMPmIHdSx5tfaOcbjS3s3B4vcKozUjMWT0c4lJl8fRMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=L1RXsQSu; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 303E21AE418;
	Mon, 19 Feb 2024 13:40:12 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1708346412; bh=UJdhwMnrMlsSDhckid4cXjQK+fmYFZjzMfDxB1XFsVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L1RXsQSu2wC5yK4CdFKgeAELFMe3COQ6IK3BT7m96aA1QABI9o25oWMQDZ8EOwuPp
	 71BkClN6GqBUHj46AWrCXqPpkzdlewKxTWxoL6dJKoj+T8ZB36ggCn1IJloYtrjcEB
	 HH8dykVWpvPc1wIbEGqrXTm8kqL4WHkWdMm1pHz5WLDvHgE3FB1LwFrWgofWj1EBN/
	 w6kFYm03w0ShNPEwY1CuKiBJs80PazLdr/IRFHWFv+OJsx0qGvlJp2z5/wDYDrHzx8
	 qyE8afBe39MmIcJA35NZg+FY9TVAeEEDmcYbUqETrEM4rrojMa15xZPyruImJzfpRv
	 UMl4mryngVDoA==
Date: Mon, 19 Feb 2024 13:40:10 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
 kernel-team@android.com, iommu@lists.linux.dev, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>
Subject: Re: [PATCH v3 0/3] Fix double allocation in swiotlb_alloc()
Message-ID: <20240219134010.5b49b8f1@meshulam.tesarici.cz>
In-Reply-To: <20240219092438.GB4105@willie-the-truck>
References: <20240205190127.20685-1-will@kernel.org>
	<20240219063527.GA4580@lst.de>
	<20240219092438.GB4105@willie-the-truck>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 09:24:39 +0000
Will Deacon <will@kernel.org> wrote:

> Hey Christoph,
> 
> On Mon, Feb 19, 2024 at 07:35:27AM +0100, Christoph Hellwig wrote:
> > Robin and Petr, does this looks good to you now?  

It looks good to me for the boot-time swiotlb pool. Dynamic allocation
of transient swiotlb pools does not take these additional alignment
constraints into account, so when allocation may fail. OTOH the
underlying allocator(s) do not provide a suitable API, so I don't think
it's worth fixing.

In the worst case, a DMA buffer will fail to map, which may already
happen today.

> FWIW, I'm likely to send a v4 addressing another issue reported by
> Nicolin with NVME and 64k pages [1], so you may as well wait for that.

I'm interested. The code look quite OK to me as it is, but I assume it
again uncovers something when the difference between PAGE_SHIFT and
IOTLB_SHIFT is more than one (which was motivation for my initial fix,
which in the end broke more than it fixed).

Petr T

