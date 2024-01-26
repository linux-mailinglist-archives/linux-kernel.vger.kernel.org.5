Return-Path: <linux-kernel+bounces-40329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C32983DE97
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D2B1C234AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EECD1D551;
	Fri, 26 Jan 2024 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="gGq0G6Ro"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049D1DDF1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286240; cv=none; b=owDRfobW+pM6404r9zVmu80Ki5HzApInE0GejdAWtIsiCTlLmcpJ8Nea8AZ1G0hfr7ZRvPcyYIQaDITUr+U9WZYT54EEKTvrA0FeaQ3tjqJSAAsAQwEwdh42L4Vo2BuBYAMh0Gn5+g1nvweLQ66wdo8emk1GPUL5PVZU+AMRYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286240; c=relaxed/simple;
	bh=HWHECrUxEnAXknABC0345RvphuEoZt5S3gPRLijbfak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOwEcuCBFzOwODm9VBgcqWNZlE4WiCy5dJb2omwnK+qT6WVUl351GLducyPXdiq8Oc5HijZW1mpjkluwLvikUUokXHKhSshF6XbGp/ImOvAoQHMwnFQq2yBtKkMtTQWKpt7G50RQAyk+YB9p4lQ6K+3ok3X3WEaHYl5D4BULcyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=gGq0G6Ro; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 50C5B18D336;
	Fri, 26 Jan 2024 17:23:56 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706286236; bh=HWHECrUxEnAXknABC0345RvphuEoZt5S3gPRLijbfak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gGq0G6Roj85qDR2Ro+IDlZrvafFDPbSBEuSRgblf82c8pOMeu1VK+X/R1gX4F6x/Q
	 +rmjbEuZVB1F66+lttX2g6ywm24XFY0eIyvfZ101NBg6bPo5+zGbIKSoDTRgRwtcp3
	 dAr6+nKnEzKkH7G1Uoc1aJniogfkbcohQYT+BXgTpLDC0ZETGEDP29PLlkzvJERAPt
	 rgZt3AtlyLvdFCr/BmY2r+mCXcp2esmmwgs2G+qdU7snj06FTyPjnZI4SqxC/Bv5mH
	 WkSLugQdOpQ7LHZTfcwSz6GZ2dhHGgtSuSfn2Ij1nlaE/dnXK6NJcRYf4Y+9RScuS1
	 QTSMjard6I8IA==
Date: Fri, 26 Jan 2024 17:23:55 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>
Subject: Re: [PATCH 2/2] swiotlb: Enforce page alignment in swiotlb_alloc()
Message-ID: <20240126172355.22a03d13@meshulam.tesarici.cz>
In-Reply-To: <20240126151956.10014-3-will@kernel.org>
References: <20240126151956.10014-1-will@kernel.org>
	<20240126151956.10014-3-will@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 15:19:56 +0000
Will Deacon <will@kernel.org> wrote:

> When allocating pages from a restricted DMA pool in swiotlb_alloc(),
> the buffer address is blindly converted to a 'struct page *' that is
> returned to the caller. In the unlikely event of an allocation bug,
> page-unaligned addresses are not detected and slots can silently be
> double-allocated.
> 
> Add a simple check of the buffer alignment in swiotlb_alloc() to make
> debugging a little easier if something has gone wonky.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 25febb9e670c..92433ea9f2d2 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1647,6 +1647,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
>  		return NULL;
>  
>  	tlb_addr = slot_addr(pool->start, index);
> +	if (!PAGE_ALIGNED(tlb_addr)) {
> +		dev_WARN_ONCE(dev, 1, "Cannot return 'struct page *' for non page-aligned swiotlb addr 0x%pa.\n",
> +			      &tlb_addr);
> +		swiotlb_release_slots(dev, tlb_addr);
> +		return NULL;
> +	}

Is there a reason not to use BUG_ON()? If yes, I would at least go for:

+	if (unlikely(!PAGE_ALIGNED(tlb_addr))) {

Other than that, yes, such cheap sanity checking looks like a good idea.

Petr T

