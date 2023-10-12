Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4534A7C713F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378304AbjJLPR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjJLPR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:17:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338CC90;
        Thu, 12 Oct 2023 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697123876; x=1728659876;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RMPSQqVexqeHED3oyyvaeAW/AO8mRAYYchmY5OSbYOQ=;
  b=nvwOv0hBJlJQ5DeeJjVz2SiVyGekrp9OOQuvQU5dUYh9ByDndUauUoE4
   Ecef1x1+0dyxg/Dti+YlZqS8AhjkVaeN4qtDHI8ZcPvAEHwlIt/28NKoH
   3W7JALNEv1KCr5pNokpKPu1PxjEiW7ULfbo83SV9CJtOyG2HeypFuxo+I
   BiZsINRjgRbT9fXEivMfyX0WD1Y9OSbfiPNc1+hvOj/lQ8qkv7dkp+2mG
   lWJf/FTI7t2QvBPEXurzS2A0K9CYQ5pMPnWmprtS1cS7IWbFGxyGE8rCH
   V7/dtjn4SAa8wrcEQDjJ48P5gakqWrf1EQoZH5U56CFOhGYcsV1I+2T26
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="365215812"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="365215812"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 08:17:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="824644996"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="824644996"
Received: from asroczyn-mobl.ger.corp.intel.com ([10.249.36.107])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 08:17:54 -0700
Date:   Thu, 12 Oct 2023 18:17:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V3 11/16] platform/x86/intel/pmc: Find and register PMC
 telemetry entries
In-Reply-To: <20231012023840.3845703-12-david.e.box@linux.intel.com>
Message-ID: <72343163-f83e-1184-480-a565288bf21f@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com> <20231012023840.3845703-12-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-573358152-1697123875=:1692"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-573358152-1697123875=:1692
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 11 Oct 2023, David E. Box wrote:

> The PMC SSRAM device contains counters that are structured in Intel
> Platform Monitoring Technology (PMT) telemetry regions. Look for and
> register these telemetry regions from the driver so that they may be read
> using the Intel PMT ABI.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V3 - no change
> 
> V2 - no change
> 
>  drivers/platform/x86/intel/pmc/Kconfig      |  1 +
>  drivers/platform/x86/intel/pmc/core_ssram.c | 52 +++++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
> index b526597e4deb..d2f651fbec2c 100644
> --- a/drivers/platform/x86/intel/pmc/Kconfig
> +++ b/drivers/platform/x86/intel/pmc/Kconfig
> @@ -7,6 +7,7 @@ config INTEL_PMC_CORE
>  	tristate "Intel PMC Core driver"
>  	depends on PCI
>  	depends on ACPI
> +	depends on INTEL_PMT_TELEMETRY
>  	help
>  	  The Intel Platform Controller Hub for Intel Core SoCs provides access
>  	  to Power Management Controller registers via various interfaces. This
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
> index af405d11919f..1ecfa3804117 100644
> --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> @@ -13,6 +13,8 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  
>  #include "core.h"
> +#include "../vsec.h"
> +#include "../pmt/telemetry.h"
>  
>  #define SSRAM_HDR_SIZE		0x100
>  #define SSRAM_PWRM_OFFSET	0x14
> @@ -24,6 +26,49 @@
>  
>  DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
>  
> +static void
> +pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
> +{
> +	struct pci_dev *pcidev = pmcdev->ssram_pcidev;
> +	struct intel_vsec_platform_info info = {};
> +	struct intel_vsec_header *headers[2] = {};
> +	struct intel_vsec_header header;
> +	void __iomem *dvsec;
> +	u32 dvsec_offset;
> +	u32 table, hdr;
> +
> +	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
> +	if (!ssram)
> +		return;
> +
> +	dvsec_offset = readl(ssram + SSRAM_DVSEC_OFFSET);
> +	iounmap(ssram);
> +
> +	dvsec = ioremap(ssram_base + dvsec_offset, SSRAM_DVSEC_SIZE);
> +	if (!dvsec)
> +		return;
> +
> +	hdr = readl(dvsec + PCI_DVSEC_HEADER1);
> +	header.id = readw(dvsec + PCI_DVSEC_HEADER2);
> +	header.rev = PCI_DVSEC_HEADER1_REV(hdr);
> +	header.length = PCI_DVSEC_HEADER1_LEN(hdr);
> +	header.num_entries = readb(dvsec + INTEL_DVSEC_ENTRIES);
> +	header.entry_size = readb(dvsec + INTEL_DVSEC_SIZE);
> +
> +	table = readl(dvsec + INTEL_DVSEC_TABLE);
> +	header.tbir = INTEL_DVSEC_TABLE_BAR(table);
> +	header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
> +	iounmap(dvsec);
> +
> +	headers[0] = &header;
> +	info.caps = VSEC_CAP_TELEMETRY;
> +	info.headers = headers;
> +	info.base_addr = ssram_base;
> +	info.parent = &pmcdev->pdev->dev;
> +
> +	intel_vsec_register(pcidev, &info);
> +}
> +
>  static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
>  {
>  	for (; list->map; ++list)
> @@ -98,6 +143,9 @@ pmc_core_get_secondary_pmc(struct pmc_dev *pmcdev, int pmc_idx, u32 offset)
>  	pwrm_base = get_base(secondary_ssram, SSRAM_PWRM_OFFSET);
>  	devid = readw(secondary_ssram + SSRAM_DEVID_OFFSET);
>  
> +	/* Find and register and PMC telemetry entries */
> +	pmc_add_pmt(pmcdev, ssram_base, main_ssram);
> +
>  	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
>  	if (!map)
>  		return -ENODEV;
> @@ -126,6 +174,9 @@ pmc_core_get_primary_pmc(struct pmc_dev *pmcdev)
>  	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
>  	devid = readw(ssram + SSRAM_DEVID_OFFSET);
>  
> +	/* Find and register and PMC telemetry entries */
> +	pmc_add_pmt(pmcdev, ssram_base, ssram);
> +
>  	map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
>  	if (!map)
>  		return -ENODEV;
> @@ -165,3 +216,4 @@ int pmc_core_ssram_init(struct pmc_dev *pmcdev)
>  
>  	return ret;
>  }
> +MODULE_IMPORT_NS(INTEL_VSEC);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-573358152-1697123875=:1692--
