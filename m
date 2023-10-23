Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F787D3CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjJWQga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjJWQg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:36:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8077810C;
        Mon, 23 Oct 2023 09:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698078986; x=1729614986;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i/u7kftTWyTjIcq5vo8cCREYxCwW/oDTjuLPZTrW3UA=;
  b=mC+BMTxQjSQ0TRwWJWn0SiwnZm2I5yUj1ntgikECOR9/DJtGRFrPOZej
   ux0dd/nwBeENuCElMpLSzTUlvR/iUOfuuXwz4Iu9LJsT2Vjo4tb30dlNR
   Jyn1xaCcNc+WmedkfST7jEHfYPW4ijB7I6uXT7zvPecQhjBi+ygk1JpwH
   wCqnTtj6hqVZ79dxomm+ApdnaDZnIwbRfY2TdOvnGNg0LUaC6zYTEd2w4
   szg4zs2o02lEpROP+71yNKAqN8cLdIrKbeN05UEgcXmSDFVK7CjFDQ18B
   uygBZ9F215L9v/loxGdelMkfJrCTPxt0ZwbGScjGiV1wbX7c/uu70WEAQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="371947430"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="371947430"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 09:33:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5875975"
Received: from foliveix-mobl5.amr.corp.intel.com ([10.251.211.194])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 09:32:35 -0700
Date:   Mon, 23 Oct 2023 19:33:48 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V4 17/17] platform/x86/intel/pmc: Show Die C6 counter on
 Meteor Lake
In-Reply-To: <20231018231624.1044633-18-david.e.box@linux.intel.com>
Message-ID: <6a9af1f1-f6a7-511-8b7f-4955f5df6cf4@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com> <20231018231624.1044633-18-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-667986227-1698078832=:1721"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-667986227-1698078832=:1721
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 18 Oct 2023, David E. Box wrote:

> Expose the Die C6 counter on Meteor Lake.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V4 - no change
> 
> V3 - Split PATCH V2 13. Separates implementation (previous patch)
>      from platform specific use (this patch)
> 
>  drivers/platform/x86/intel/pmc/mtl.c | 32 ++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
> index 7ceeae507f4c..38c2f946ec23 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -10,12 +10,17 @@
>  
>  #include <linux/pci.h>
>  #include "core.h"
> +#include "../pmt/telemetry.h"
>  
>  /* PMC SSRAM PMT Telemetry GUIDS */
>  #define SOCP_LPM_REQ_GUID	0x2625030
>  #define IOEM_LPM_REQ_GUID	0x4357464
>  #define IOEP_LPM_REQ_GUID	0x5077612
>  
> +/* Die C6 from PUNIT telemetry */
> +#define MTL_PMT_DMU_DIE_C6_OFFSET	15
> +#define MTL_PMT_DMU_GUID		0x1A067102
> +
>  static const u8 MTL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
>  
>  /*
> @@ -968,6 +973,32 @@ static struct pmc_info mtl_pmc_info_list[] = {
>  	{}
>  };
>  
> +static void mtl_punit_pmt_init(struct pmc_dev *pmcdev)
> +{
> +	struct telem_endpoint *ep;
> +	struct pci_dev *pcidev;
> +
> +	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(10, 0));
> +	if (!pcidev) {
> +		dev_err(&pmcdev->pdev->dev, "PUNIT PMT device not found.\n");
> +		return;
> +	}
> +
> +	ep = pmt_telem_find_and_register_endpoint(pcidev, MTL_PMT_DMU_GUID, 0);
> +	if (IS_ERR(ep)) {
> +		dev_err(&pmcdev->pdev->dev,
> +			"pmc_core: couldn't get DMU telem endpoint, %ld\n",
> +			PTR_ERR(ep));
> +		return;
> +	}
> +
> +	pci_dev_put(pcidev);
> +	pmcdev->punit_ep = ep;
> +
> +	pmcdev->has_die_c6 = true;
> +	pmcdev->die_c6_offset = MTL_PMT_DMU_DIE_C6_OFFSET;
> +}
> +
>  #define MTL_GNA_PCI_DEV	0x7e4c
>  #define MTL_IPU_PCI_DEV	0x7d19
>  #define MTL_VPU_PCI_DEV	0x7d1d
> @@ -1032,6 +1063,7 @@ int mtl_core_init(struct pmc_dev *pmcdev)
>  	}
>  
>  	pmc_core_get_low_power_modes(pmcdev);
> +	mtl_punit_pmt_init(pmcdev);
>  
>  	/* Due to a hardware limitation, the GBE LTR blocks PC10
>  	 * when a cable is attached. Tell the PMC to ignore it.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-667986227-1698078832=:1721--
