Return-Path: <linux-kernel+bounces-90750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A84870466
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6391C23551
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E1E41775;
	Mon,  4 Mar 2024 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="jmj4UvLe"
Received: from bee.tesarici.cz (unknown [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C2F4087F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563184; cv=none; b=fk6SPbZUfjgOQT2+IDxjQOj3fbWKdZ/QF8c/zvJJTeC8yhhZ3p7LatVXyCQBffJTz8Q+Y3RA7GT+Lbe64jKhx1WB0J4sGTjHULUrZQcfmpNhAySAqptAeimLut2jXeZeX8tQv8xEtVpqjpWtPBnru6DVU9S6Jp76toOapL9t0JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563184; c=relaxed/simple;
	bh=OuH4ARsy4uMSskFQxM4nVWSg6cNRuQIZsejNWP30OlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIK/vk11AECQlF3kGNEXNavRy23hEfOdFJiFI33fXdovcJ31rM8e3rJdaBTnpGnG9+9akW6OuRAhC9g8aalNPan+OzD8ZZ5YC0UhidVTSte1noS8n4DchnQBRPcNJ/GjY2nduLO9ONlMRBluQnjYr3UevqzE94w6w0V5W6/pZ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=jmj4UvLe; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id C409E1C4BDD;
	Mon,  4 Mar 2024 15:39:39 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709563179; bh=DNUUA0JgeJlN4yw9N1RggkXAebOO04FxH/opiGgSGMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jmj4UvLeXwlP5cI6zhn4rcHfzcQAW0evTccxhBZD/Rejx23Y2+HJzE9WUhT6lr8El
	 5nTLAo3t1GsEzptAULYUw07tCVnr+vY+8MG6mKH25vHoI/kKYEmM34ilqZf/RuhxiV
	 7D9RvZqtWveVlbvv4nbEzYGJIiDDDkHnhCJk3GoyGVc40hgng9IViTN3B8W6ydJtkI
	 bgyuJr73NzhCByCwv4GcGuORGEp+CJ8ctycpn3rn0jZTyRKOo2ipaKGYCV7ktaMII4
	 c/fuYmkgoOHfQ0gwtSBeADekmE3fSDye2AHONrNjG6dzumsdWPphxplxN1+JaWV/v2
	 l4/EYlFeg6p7g==
Date: Mon, 4 Mar 2024 15:39:38 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 will@kernel.org, mhklinux@outlook.com, hch@lst.de
Subject: Re: [PATCH] iommu/dma: Document min_align_mask assumption
Message-ID: <20240304153938.1fa984b7@meshulam.tesarici.cz>
In-Reply-To: <dbb4d2d8e5d1691ac9a6c67e9758904e6c447ba5.1709553942.git.robin.murphy@arm.com>
References: <dbb4d2d8e5d1691ac9a6c67e9758904e6c447ba5.1709553942.git.robin.murphy@arm.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 12:05:42 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> iommu-dma does not explicitly reference min_align_mask since we already
> assume that that will be less than or equal to any typical IOVA granule.
> We wouldn't realistically expect to see the case where it is larger, and
> that would be non-trivial to support, however for the sake of reasoning
> (particularly around the interaction with SWIOTLB), let's clearly
> enforce the assumption.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks good to me.

Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Thank you!

Petr T

> ---
>  drivers/iommu/dma-iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 50ccc4f1ef81..b58f5a3311c3 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -859,6 +859,11 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>  	    iommu_deferred_attach(dev, domain))
>  		return DMA_MAPPING_ERROR;
>  
> +	/* If anyone ever wants this we'd need support in the IOVA allocator */
> +	if (dev_WARN_ONCE(dev, dma_get_min_align_mask(dev) > iova_mask(iovad),
> +	    "Unsupported alignment constraint\n"))
> +		return DMA_MAPPING_ERROR;
> +
>  	size = iova_align(iovad, size + iova_off);
>  
>  	iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);


