Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5817B7908
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbjJDHtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbjJDHtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:49:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CD1AB;
        Wed,  4 Oct 2023 00:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696405739; x=1727941739;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KNKJlhTfnjzypdXBD0FYc94oX5a6U6Q4sktBqVSGseA=;
  b=SXp0J5o9v62WkGwwwGuBndEZhaicowkpNm1FbPWs8ZTxE5fuhEuF2r8p
   g1pHCodtgCb5IosXgrxc2rDG0Hzw0lr3QcNzdQHnFaE6nkS5MluZv2RTd
   8ODhPy6Ui80/Q9S8A5OF3FsyDTXXufaliqnZk+0FsBhfMIUQTzQqDIqRi
   uTvZaqybCj1MsBeuqeq1FITRVB8rLaXZ2n9X7agGN3CW4eLq0xKvGlLpS
   UMGug5r70mMmLXCXqXz5eqoGZYMzKPweC9E3EdGP88tbpaEvKd4pvFG2W
   gjMQ4SF2jfO24mqU1/BohACXjoAQPsjdiTHHgNf3D0IQCuFMo+zGu3o9F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="386958300"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="386958300"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 00:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="786404500"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="786404500"
Received: from cyrillet-mobl.ger.corp.intel.com ([10.252.55.203])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 00:48:56 -0700
Date:   Wed, 4 Oct 2023 10:48:54 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V2 12/13] platform/x86/intel/pmc: Read low power mode
 requirements for MTL-M and MTL-P
In-Reply-To: <20231004020222.193445-13-david.e.box@linux.intel.com>
Message-ID: <5da1361f-eb7-8f57-d096-882344ca43f@linux.intel.com>
References: <20231004020222.193445-1-david.e.box@linux.intel.com> <20231004020222.193445-13-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-202744246-1696405737=:1931"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-202744246-1696405737=:1931
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 3 Oct 2023, David E. Box wrote:

> From: Xi Pardee <xi.pardee@intel.com>
> 
> Add support to read the low power mode requirements for Meteor Lake M and
> Meteor Lake P.
> 
> Signed-off-by: Xi Pardee <xi.pardee@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V2 - fixed unused return value
> 
>  drivers/platform/x86/intel/pmc/mtl.c | 41 +++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index 780874142a90..78c9a80bd929 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -11,6 +11,13 @@
>  #include <linux/pci.h>
>  #include "core.h"
>  
> +/* PMC SSRAM PMT Telemetry GUIDS */
> +#define SOCP_LPM_REQ_GUID	0x2625030
> +#define IOEM_LPM_REQ_GUID	0x4357464
> +#define IOEP_LPM_REQ_GUID	0x5077612
> +
> +static const u8 MTL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
> +
>  /*
>   * Die Mapping to Product.
>   * Product SOCDie IOEDie PCHDie
> @@ -465,6 +472,7 @@ const struct pmc_reg_map mtl_socm_reg_map = {
>  	.lpm_sts = mtl_socm_lpm_maps,
>  	.lpm_status_offset = MTL_LPM_STATUS_OFFSET,
>  	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
> +	.lpm_reg_index = MTL_LPM_REG_INDEX,
>  };
>  
>  const struct pmc_bit_map mtl_ioep_pfear_map[] = {
> @@ -782,6 +790,13 @@ const struct pmc_reg_map mtl_ioep_reg_map = {
>  	.ltr_show_sts = mtl_ioep_ltr_show_map,
>  	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
>  	.ltr_ignore_max = ADL_NUM_IP_IGN_ALLOWED,
> +	.lpm_num_maps = ADL_LPM_NUM_MAPS,
> +	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
> +	.lpm_residency_offset = MTL_LPM_RESIDENCY_OFFSET,
> +	.lpm_priority_offset = MTL_LPM_PRI_OFFSET,
> +	.lpm_en_offset = MTL_LPM_EN_OFFSET,
> +	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
> +	.lpm_reg_index = MTL_LPM_REG_INDEX,
>  };
>  
>  const struct pmc_bit_map mtl_ioem_pfear_map[] = {
> @@ -922,6 +937,13 @@ const struct pmc_reg_map mtl_ioem_reg_map = {
>  	.ltr_show_sts = mtl_ioep_ltr_show_map,
>  	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
>  	.ltr_ignore_max = ADL_NUM_IP_IGN_ALLOWED,
> +	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
> +	.lpm_num_maps = ADL_LPM_NUM_MAPS,
> +	.lpm_priority_offset = MTL_LPM_PRI_OFFSET,
> +	.lpm_en_offset = MTL_LPM_EN_OFFSET,
> +	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
> +	.lpm_residency_offset = MTL_LPM_RESIDENCY_OFFSET,
> +	.lpm_reg_index = MTL_LPM_REG_INDEX,
>  };
>  
>  #define PMC_DEVID_SOCM	0x7e7f
> @@ -929,16 +951,19 @@ const struct pmc_reg_map mtl_ioem_reg_map = {
>  #define PMC_DEVID_IOEM	0x7ebf
>  static struct pmc_info mtl_pmc_info_list[] = {
>  	{
> -		.devid = PMC_DEVID_SOCM,
> -		.map = &mtl_socm_reg_map,
> +		.guid	= SOCP_LPM_REQ_GUID,
> +		.devid	= PMC_DEVID_SOCM,
> +		.map	= &mtl_socm_reg_map,
>  	},
>  	{
> -		.devid = PMC_DEVID_IOEP,
> -		.map = &mtl_ioep_reg_map,
> +		.guid	= IOEP_LPM_REQ_GUID,
> +		.devid	= PMC_DEVID_IOEP,
> +		.map	= &mtl_ioep_reg_map,
>  	},
>  	{
> -		.devid = PMC_DEVID_IOEM,
> -		.map = &mtl_ioem_reg_map
> +		.guid	= IOEM_LPM_REQ_GUID,
> +		.devid	= PMC_DEVID_IOEM,
> +		.map	= &mtl_ioem_reg_map
>  	},
>  	{}
>  };
> @@ -1012,5 +1037,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
>  	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
>  	pmc_core_send_ltr_ignore(pmcdev, 3);
>  
> -	return 0;
> +	ret = pmc_core_ssram_get_lpm_reqs(pmcdev);
> +
> +	return ret;

Just do it directly with:
	return pmc_core_ssram_get_lpm_reqs(pmcdev);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-202744246-1696405737=:1931--
