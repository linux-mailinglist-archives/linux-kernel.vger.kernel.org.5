Return-Path: <linux-kernel+bounces-57457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D9C84D950
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 05:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236911C21BDD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30AF2D04F;
	Thu,  8 Feb 2024 04:01:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D52E400;
	Thu,  8 Feb 2024 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364880; cv=none; b=AoeCuTn5spZ2HZdVbt5F835wOpQiEoU0NDU3WEYbO7KcXc8truvaQZWMy5TcCxGt+cACEPkZGSS5nZLLEyz5i8pRIVLGMfDPER19znqbwA6TtOIFjoxT4hjN68TI0MGaJVewycMmCqPBsCVPwomtDavOJnu4XBYPRf15J38lE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364880; c=relaxed/simple;
	bh=qssGJbK0ESJ7STyLMPwWaFGvgaAgAgGZ/WWghYc5FsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTp8V/Tjeu8TG7ntZtzUKQQ+GlqAUg69WvK39dezvDziqHUSQAtmEK0vApUR+8sJpRIiYjnZd4ha5LABLe4cpGyEPUvA1++zuudnjjXJ4JchjolYQFPR3ZwxVHSkvLkbD8q7WwvK2hScTwxykg3VWcRmZe0HLVtIsb4TSDCXPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9F6D1FB;
	Wed,  7 Feb 2024 20:01:58 -0800 (PST)
Received: from [10.163.44.57] (unknown [10.163.44.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F3EC3F5A1;
	Wed,  7 Feb 2024 20:01:13 -0800 (PST)
Message-ID: <180491ea-d4b4-4d70-a615-595492175efd@arm.com>
Date: Thu, 8 Feb 2024 09:31:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-contiguous: remove debug code to removed
 CONFIG_CMA_DEBUG
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240207143825.986-1-lukas.bulwahn@gmail.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240207143825.986-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/24 20:08, Lukas Bulwahn wrote:
> Commit acc2f3e42d4a ("mm/cma: drop CONFIG_CMA_DEBUG") removes the config
> CMA_DEBUG and the debug code in cma.c, but misses debug code in
> kernel/dma/contiguous.c.
> 
> Remove this dead code from this removed config option.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Andrew, please pick this minor clean-up patch of top of the commit above.
> 
>  kernel/dma/contiguous.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index f005c66f378c..055da410ac71 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -37,12 +37,6 @@
>  
>  #define pr_fmt(fmt) "cma: " fmt
>  
> -#ifdef CONFIG_CMA_DEBUG
> -#ifndef DEBUG
> -#  define DEBUG
> -#endif
> -#endif
> -
>  #include <asm/page.h>
>  
>  #include <linux/memblock.h>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

