Return-Path: <linux-kernel+bounces-71337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B023685A3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28D21C21D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744D12E847;
	Mon, 19 Feb 2024 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="uYEAFSWW"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F4A2D61A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346505; cv=none; b=EfPNhDJ5/DfVst5P9cjGqxYUONwRQnu6jjmL+E7lHuRHwPxl9RPWwttHabpVvGoEMFgZCPslguhuzGY8NhlPp+voXIXzrV/SBXUK1hP83DnmTy5J43wBSyxsYwOT1JQehc1YiWtiSBckQIBi+h61fR0u24YT/5D83m7b41NhIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346505; c=relaxed/simple;
	bh=LDMBEKTq6cyiopOllYtwKJ3tdATJ2fx3/t+JvAifnx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nW17BrPsDDPnfxi7s5cZvdcbfqhaqq6OPlSaRPPg7WwiOFTnQtC8Y2102H917UgYQ8gii+WlRGkF8Y1VWmDF/cLGsEvvPRfdycq5xGmM7D5XyGNcjAA1wKL8XrG6G7KT2epwGRtWJN6gQyuc6Mrjf0mbvBGRaKVtXTGEdDSGwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=uYEAFSWW; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 725341ADF1D;
	Mon, 19 Feb 2024 13:41:42 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1708346502; bh=p13KCQ80RQpKs8qewoVyD1wVP4wEkOu3YdWAsGC9pK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uYEAFSWWTuCNR9YSbsv/mUXWxJNNeKNiZs84kg3+Muol+J0XAYDG1Ob1AVH9XtlVF
	 Gcfwxkdm/qajwvWblaII4/oesOY5hinHLQaHsav3Xi/HoXktkFbDzIXpqB4bFagd05
	 Z3IHDqsVuVCc2MkJcgUaqEffCtNb7ziBfB4Rlp/RgiMqoX0DaWKazwl6LlmQAaXKMq
	 Z8VJj7F5cpT55/SrV0WO4Z0Qc1tPdou9S4IV4ovkWti3rHRczkCitvPBjspu5BzvK0
	 EJXvV7b5Vr8kV5sJiWXi02Jg/G+itM0hqqh8PEtqSj2lrHiOHNgsjUH3DeMPprrRqz
	 f9ckb89cNn8cQ==
Date: Mon, 19 Feb 2024 13:41:41 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>
Subject: Re: [PATCH v3 3/3] swiotlb: Honour dma_alloc_coherent() alignment
 in swiotlb_alloc()
Message-ID: <20240219134141.381dea51@meshulam.tesarici.cz>
In-Reply-To: <20240205190127.20685-4-will@kernel.org>
References: <20240205190127.20685-1-will@kernel.org>
	<20240205190127.20685-4-will@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 19:01:27 +0000
Will Deacon <will@kernel.org> wrote:

> core-api/dma-api-howto.rst states the following properties of
> dma_alloc_coherent():
> 
>   | The CPU virtual address and the DMA address are both guaranteed to
>   | be aligned to the smallest PAGE_SIZE order which is greater than or
>   | equal to the requested size.
> 
> However, swiotlb_alloc() passes zero for the 'alloc_align_mask'
> parameter of swiotlb_find_slots() and so this property is not upheld.
> Instead, allocations larger than a page are aligned to PAGE_SIZE,
> 
> Calculate the mask corresponding to the page order suitable for holding
> the allocation and pass that to swiotlb_find_slots().
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Fixes: e81e99bacc9f ("swiotlb: Support aligned swiotlb buffers")
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Petr T

> ---
>  kernel/dma/swiotlb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index adbb3143238b..283eea33dd22 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1633,12 +1633,14 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
>  	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>  	struct io_tlb_pool *pool;
>  	phys_addr_t tlb_addr;
> +	unsigned int align;
>  	int index;
>  
>  	if (!mem)
>  		return NULL;
>  
> -	index = swiotlb_find_slots(dev, 0, size, 0, &pool);
> +	align = (1 << (get_order(size) + PAGE_SHIFT)) - 1;
> +	index = swiotlb_find_slots(dev, 0, size, align, &pool);
>  	if (index == -1)
>  		return NULL;
>  


