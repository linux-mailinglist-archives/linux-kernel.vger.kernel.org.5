Return-Path: <linux-kernel+bounces-154758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F26BE8AE098
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC4E2852B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C9C56444;
	Tue, 23 Apr 2024 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmVwHJDI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FAC5647B;
	Tue, 23 Apr 2024 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863233; cv=none; b=D1IgklT5CDEXFs1IAU5bb1YeSTq3YfQOQIwahT7HEd1Q14ooph11cojr2c9REMu42jL4Euwaj3P/R8NB+KWACriIKQeTKP5Cyzd3GOdIPw3nF6B0LX2MwKeP9dKiaFnu0BV6ZLF/MqaIDGz1Tma+yAbYm0GhQVJcubzINoNIa9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863233; c=relaxed/simple;
	bh=3sflhcA0hu5cpeDqgRxeLXG5DOKfuWBbLCsPck6cnnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsEDWyrTacOCSGidvIlcVKKWSktE6grmQxm3/n85dCqYMqSK8nmd0Y8Vre9pYZ3zkrYVK5QsKd2n+8SS/bj6jXgitWlNuSdKP10u93SJwpH2P72DLKjRsHYzggYbkeJnb6NvEyP0WIvViR+R0WMwBb1vLfWhhXQNK9D5m6sG4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmVwHJDI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713863232; x=1745399232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3sflhcA0hu5cpeDqgRxeLXG5DOKfuWBbLCsPck6cnnU=;
  b=FmVwHJDIe+FfyG/p/IVRVuEYGYh4jv3LdJ7vBAi4BLc7jYQ8X26CikuM
   +qhz9of2amAkwNgJN7BkXS5zMhdgSOyjfa1yYyOa6R/RHq2McAT6Zfj8h
   TFrDabbtK08haEnPEpDM3so/Kt15qVviNXeiW29X0GWY1JXhwsnQrSGCX
   D50YWQj2oZw7h+pRcox5+IjQ85cSg8HDd9HLmphc9tZEzSW87sQXGkveb
   1LjNp2NAZP22mNIQr98YCpshXzQ/nxVOn3Dw/WzuXUxMAu8vtwsXm65aZ
   SckKmBjna/i6ZlJMN6k28Rt3rz0YH19HM4brJYRtFEpFWn9gKU29ZJCwz
   w==;
X-CSE-ConnectionGUID: jYvaClv6ShKUd2LqUux2xA==
X-CSE-MsgGUID: 6aXRxPLkTiKVq9xDBTEguw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9302210"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9302210"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 02:07:12 -0700
X-CSE-ConnectionGUID: z/rQpEQZRQqgs+rjy2bg0g==
X-CSE-MsgGUID: 6D40TMoGTsadoQQyHbX4/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55247181"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 23 Apr 2024 02:07:08 -0700
Date: Tue, 23 Apr 2024 17:01:48 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [RFC PATCH v2 2/9] fpga: dfl: migrate AFU DMA region management
 driver to dfl_feature_dev_data
Message-ID: <Zid4/GH1hL5YRboH@yilunxu-OptiPlex-7050>
References: <20240409233942.828440-1-peter.colberg@intel.com>
 <20240409233942.828440-3-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409233942.828440-3-peter.colberg@intel.com>

On Tue, Apr 09, 2024 at 07:39:35PM -0400, Peter Colberg wrote:
> This change separates out most of the symbol name changes required by this
> patch series for the file: drivers/fpga/dfl-afu-dma-region.c. 

> This is done
> to split a single monolithic change into multiple, smaller patches at the
> request of the maintainer.

This sentence provides no useful info.

> 
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>
> ---
> v2:
> - Split monolithic patch into series at request of maintainer
> - Reorder local variables in afu_dma_unpin_pages() to reverse Christmas
>   tree order.
> ---
>  drivers/fpga/dfl-afu-dma-region.c | 119 +++++++++++++++---------------
>  1 file changed, 61 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> index 02b60fde0430..fb45e51b12af 100644
> --- a/drivers/fpga/dfl-afu-dma-region.c
> +++ b/drivers/fpga/dfl-afu-dma-region.c
> @@ -16,26 +16,26 @@
>  
>  #include "dfl-afu.h"
>  
> -void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
> +void afu_dma_region_init(struct dfl_feature_dev_data *fdata)
>  {
> -	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
> +	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
>  
>  	afu->dma_regions = RB_ROOT;
>  }
>  
>  /**
>   * afu_dma_pin_pages - pin pages of given dma memory region
> - * @pdata: feature device platform data
> + * @fdata: feature dev data
>   * @region: dma memory region to be pinned
>   *
>   * Pin all the pages of given dfl_afu_dma_region.
>   * Return 0 for success or negative error code.
>   */
> -static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
> +static int afu_dma_pin_pages(struct dfl_feature_dev_data *fdata,
>  			     struct dfl_afu_dma_region *region)
>  {
>  	int npages = region->length >> PAGE_SHIFT;
> -	struct device *dev = &pdata->dev->dev;
> +	struct device *dev = &fdata->dev->dev;
>  	int ret, pinned;
>  
>  	ret = account_locked_vm(current->mm, npages, true);
> @@ -73,17 +73,17 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
>  
>  /**
>   * afu_dma_unpin_pages - unpin pages of given dma memory region
> - * @pdata: feature device platform data
> + * @fdata: feature dev data
>   * @region: dma memory region to be unpinned
>   *
>   * Unpin all the pages of given dfl_afu_dma_region.
>   * Return 0 for success or negative error code.
>   */
> -static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
> +static void afu_dma_unpin_pages(struct dfl_feature_dev_data *fdata,
>  				struct dfl_afu_dma_region *region)
>  {
>  	long npages = region->length >> PAGE_SHIFT;
> -	struct device *dev = &pdata->dev->dev;
> +	struct device *dev = &fdata->dev->dev;
>  
>  	unpin_user_pages(region->pages, npages);
>  	kfree(region->pages);
> @@ -133,20 +133,21 @@ static bool dma_region_check_iova(struct dfl_afu_dma_region *region,
>  
>  /**
>   * afu_dma_region_add - add given dma region to rbtree
> - * @pdata: feature device platform data
> + * @fdata: feature dev data
>   * @region: dma region to be added
>   *
>   * Return 0 for success, -EEXIST if dma region has already been added.
>   *
> - * Needs to be called with pdata->lock heold.
> + * Needs to be called with fdata->lock held.
>   */
> -static int afu_dma_region_add(struct dfl_feature_platform_data *pdata,
> +static int afu_dma_region_add(struct dfl_feature_dev_data *fdata,
>  			      struct dfl_afu_dma_region *region)
>  {
> -	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
> +	struct dfl_afu *afu = dfl_fpga_fdata_get_private(fdata);
> +	struct device *dev = &fdata->dev->dev;

Don't introduce any other unnecessary changes in the big
symbol replacement patch.  People could read over all the same
replacements quickly, even if they are massive. But if there are
some other changes in between...

>  	struct rb_node **new, *parent = NULL;
>  
> -	dev_dbg(&pdata->dev->dev, "add region (iova = %llx)\n",
> +	dev_dbg(dev, "add region (iova = %llx)\n",
>  		(unsigned long long)region->iova);

