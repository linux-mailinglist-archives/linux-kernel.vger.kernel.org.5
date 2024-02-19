Return-Path: <linux-kernel+bounces-71336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E01985A3A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7131B1C23C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0C22E82E;
	Mon, 19 Feb 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="R3Z54+BX"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC492D05D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346478; cv=none; b=DXk0GWLHSD72rU+lQuLji+hCF8XHQXnPvXFcTub7+PPbm32bs2q7SGXtNDBKFP77Dnomlt8kRmP1RtPHaw57FsTJkP90+WFF91LChQzg2bTvx6GYCJ5B65A0oWaTJjHPyr5lrEwh50+t1nNv/j6IaIJhumYtLqZ3MtNzOZqpN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346478; c=relaxed/simple;
	bh=e2xLVu+6ot5sg/6bm7jkOGA6ufHpcMGxIdDhHPg0WHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnW/ctGMm0WWZnk2Gx0Y8ksi/5wXShzh5A3JafVrWDmTJNt59pwRUCi26KWuNXB+9IAIX5tWQhaui/CaeKWXYyW2AR2s0LumJbHNYDPlI3bJLyWBBBb6PYPxsjsBoLKlkwhsXFqdxmaFN37QUKUkDtiu43nlCUHnCfLgwW8FTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=R3Z54+BX; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 43CA11AE035;
	Mon, 19 Feb 2024 13:41:15 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1708346475; bh=kcbZxawIF5pJIF3e6Fe0CSzj4Wcoglr3TFCIIff5vXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R3Z54+BXqzlS3OPPkzdjwGOCVJRRmQm2XfS7SDi44D1NjRiwciIalt7KU3NlYAGfE
	 nULPo6DRkwbiuZJHh+dS1qT7N3sNZj4chcFQt2HQAkv9nfBh1rH91txI0R9IEbYrHK
	 Lm+nIAqXY5GOX3MKDpNT5L0/p3HyLqMuz2B52GBC9dBYFiUltM/vrYNu5+05ez82lx
	 0qVPalhqT/63k1b8ZOED7rFlUNl49SScAKB6p/cQynuea0jKTOAxNN3Z2zbd8kztin
	 4P06m1lck+QpKTQA2KH4KAybPvi3HcHdQfJpxRa5XAIBHjMbUw0Wa1lKsNPNFqNKq8
	 MtJ3YzI2Ig6MA==
Date: Mon, 19 Feb 2024 13:41:13 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>
Subject: Re: [PATCH v3 2/3] swiotlb: Enforce page alignment in
 swiotlb_alloc()
Message-ID: <20240219134113.24396ad9@meshulam.tesarici.cz>
In-Reply-To: <20240205190127.20685-3-will@kernel.org>
References: <20240205190127.20685-1-will@kernel.org>
	<20240205190127.20685-3-will@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 19:01:26 +0000
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

Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Petr T

> ---
>  kernel/dma/swiotlb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 9ff909a0039a..adbb3143238b 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1643,6 +1643,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
>  		return NULL;
>  
>  	tlb_addr = slot_addr(pool->start, index);
> +	if (unlikely(!PAGE_ALIGNED(tlb_addr))) {
> +		dev_WARN_ONCE(dev, 1, "Cannot allocate pages from non page-aligned swiotlb addr 0x%pa.\n",
> +			      &tlb_addr);
> +		swiotlb_release_slots(dev, tlb_addr);
> +		return NULL;
> +	}
>  
>  	return pfn_to_page(PFN_DOWN(tlb_addr));
>  }


