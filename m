Return-Path: <linux-kernel+bounces-136144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C789D075
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815FC1F231A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF345465B;
	Tue,  9 Apr 2024 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTaX7mYd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFAF79DF;
	Tue,  9 Apr 2024 02:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712630624; cv=none; b=J3YoIWTkohl6mSrSXsJlPM8KQPI/WxyvDh5DyqPuMhtJrjt1XHbzNNj9vm+jtQFIGOAF2nOGF5fH4eoL3nRX/pWPatiDw5pO+WN0NaAQMAs1h3DbUJqi3fJ5PMcMvkaTIWQEk//+GvYO5pgeyMiaxQr9yYaga6B4+4hneCNUR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712630624; c=relaxed/simple;
	bh=oCdmaBKquHlDXJaYmN5qiPPs2PZNGRKv9+X6wyWuIT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPdrnGJhQzlZAbi8riqAvhOT5VHb4K7pH2EXgJbFgoyV8cC1BXT2E6a9IgDxXKYcslN8fo4HA8AI1efUf9s+xHJlKEYEFboa+dx0eXm71Sn8l0IViBGpBbC623x2Kn9M+h/K5a4LomyCUxoULork1hCyUssw/1daaSEi55quDnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTaX7mYd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712630624; x=1744166624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oCdmaBKquHlDXJaYmN5qiPPs2PZNGRKv9+X6wyWuIT8=;
  b=eTaX7mYdY7REpRyTpgViIspTkD2jzJG7I/eZdihLb2fTeKUgyAGNPVsK
   u+jt+LrnnnSIZtvDp4xWCLHRpfJgDdzNZStbZnp9lCG+mNfxjic2aAcAr
   1yvgtEwcC2xeHbG1+W5V1ona07BIrQlkkpIDzUrUsyUe9DGb9ZKcc5CbQ
   5wcKsXYheRUObd8QwtDAbh+XgRsTzKFIBwNTfapF6KxJgoO7jlvoggnob
   AqeL2wUJTovILWzpDQvvoxZusCb6ZpHNip+E5Oo67lRm/1SEiiv00vmbv
   5WX0i8oeKFJ8VNJguDwDIq3B9uu5rLm3tSP0HuHeUB0yu7EnE/s9V0KAh
   A==;
X-CSE-ConnectionGUID: 1SCRan1UTye1h/coyzEWLQ==
X-CSE-MsgGUID: ntxeEcc4Sqy9SaX2TTC+pQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11772836"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="11772836"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 19:43:43 -0700
X-CSE-ConnectionGUID: /dHfDBL9TYCnJVP1UEBn4Q==
X-CSE-MsgGUID: 9TqFKbGcQtehH8OGduKw3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20043004"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 08 Apr 2024 19:43:39 -0700
Date: Tue, 9 Apr 2024 10:38:39 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Lee Jones <lee@kernel.org>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v2] mfd: intel-m10-bmc: Change staging size to a variable
Message-ID: <ZhSqL6GhKwGc0ALv@yilunxu-OptiPlex-7050>
References: <20240402184925.1065932-1-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402184925.1065932-1-peter.colberg@intel.com>

On Tue, Apr 02, 2024 at 02:49:25PM -0400, Peter Colberg wrote:
> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> The secure update driver does a sanity-check of the image size in
> comparison to the size of the staging area in FLASH. Instead of
> hard-wiring M10BMC_STAGING_SIZE, move the staging size to the
> m10bmc_csr_map structure to make the size assignment more flexible.
> 
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Peter Colberg <peter.colberg@intel.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

> ---
> v2:
> - Revise commit message to remove reference to nonexistent larger FPGAs.
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
>  drivers/mfd/intel-m10-bmc-pmci.c        | 1 +
>  drivers/mfd/intel-m10-bmc-spi.c         | 1 +
>  include/linux/mfd/intel-m10-bmc.h       | 1 +
>  4 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 89851b133709..7ac9f9f5af12 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -529,11 +529,12 @@ static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
>  					     const u8 *data, u32 size)
>  {
>  	struct m10bmc_sec *sec = fwl->dd_handle;
> +	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
>  	u32 ret;
>  
>  	sec->cancel_request = false;
>  
> -	if (!size || size > M10BMC_STAGING_SIZE)
> +	if (!size || size > csr_map->staging_size)
>  		return FW_UPLOAD_ERR_INVALID_SIZE;
>  
>  	if (sec->m10bmc->flash_bulk_ops)
> diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
> index 0392ef8b57d8..698c5933938b 100644
> --- a/drivers/mfd/intel-m10-bmc-pmci.c
> +++ b/drivers/mfd/intel-m10-bmc-pmci.c
> @@ -370,6 +370,7 @@ static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
>  	.pr_reh_addr = M10BMC_N6000_PR_REH_ADDR,
>  	.pr_magic = M10BMC_N6000_PR_PROG_MAGIC,
>  	.rsu_update_counter = M10BMC_N6000_STAGING_FLASH_COUNT,
> +	.staging_size = M10BMC_STAGING_SIZE,
>  };
>  
>  static const struct intel_m10bmc_platform_info m10bmc_pmci_n6000 = {
> diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
> index cbeb7de9e041..d64d28199df6 100644
> --- a/drivers/mfd/intel-m10-bmc-spi.c
> +++ b/drivers/mfd/intel-m10-bmc-spi.c
> @@ -109,6 +109,7 @@ static const struct m10bmc_csr_map m10bmc_n3000_csr_map = {
>  	.pr_reh_addr = M10BMC_N3000_PR_REH_ADDR,
>  	.pr_magic = M10BMC_N3000_PR_PROG_MAGIC,
>  	.rsu_update_counter = M10BMC_N3000_STAGING_FLASH_COUNT,
> +	.staging_size = M10BMC_STAGING_SIZE,
>  };
>  
>  static struct mfd_cell m10bmc_d5005_subdevs[] = {
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index ee66c9751003..988f1cd90032 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -205,6 +205,7 @@ struct m10bmc_csr_map {
>  	unsigned int pr_reh_addr;
>  	unsigned int pr_magic;
>  	unsigned int rsu_update_counter;
> +	unsigned int staging_size;
>  };
>  
>  /**
> -- 
> 2.44.0
> 
> 

