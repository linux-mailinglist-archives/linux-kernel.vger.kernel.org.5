Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DA57BE73D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377892AbjJIQ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377909AbjJIQ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:59:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A408A12F;
        Mon,  9 Oct 2023 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696870738; x=1728406738;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Q29YeVJ6SEdzMCGQboPJ3/kbexbcCTC5iwptf8BQKWg=;
  b=Qb2IJc45kqbhj5mcCzQnvfBxBPreLMTp69x+l6vX2X7XB8PmIJBWfq4b
   00tbI8IXhmbUNKMjiRnDxX2F6wex3qVKPv+1AFVBsqkOnzaLF9iZqGP6e
   fsBnOLTP+vZS4kClXLzic/WorNc1Mfsjp1EHF5Tv9VqSbnuBVIj8fZr9b
   UfaMiM3Q7Qt/Fuvd2fAezH2OqYm414Nb6RTE2XhYC4u2eKYjwfdGptwu5
   D/9DZefNz31X9/lqSQ3AZq+YWQeqotp0VMtSODjTESX/cBo6Rymdct2Ib
   TK//Y/isorNLTMUk0+THTJiNC/wmCcOF3/TyHUjemj2SCb6B/pHJRt8hN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="2784858"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="2784858"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 09:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="788230421"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="788230421"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.36.27])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 09:58:54 -0700
Message-ID: <eeb70bd9-e347-4d19-a597-bd7857b96306@intel.com>
Date:   Mon, 9 Oct 2023 19:58:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mmc: sdhci-pltfm: Make driver OF independent
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231006105803.3374241-1-andriy.shevchenko@linux.intel.com>
 <20231006105803.3374241-2-andriy.shevchenko@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231006105803.3374241-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/23 13:58, Andy Shevchenko wrote:
> Since we have device_is_compatible() API, drop OF dependency
> in the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pltfm.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 4d1a703a5bdb..62753d72198a 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -19,7 +19,6 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
> -#include <linux/of.h>
>  #ifdef CONFIG_PPC
>  #include <asm/machdep.h>
>  #endif
> @@ -56,19 +55,16 @@ static bool sdhci_wp_inverted(struct device *dev)
>  
>  static void sdhci_get_compatibility(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
> -	struct device_node *np = pdev->dev.of_node;
>  
> -	if (!np)
> -		return;
> -
> -	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
> +	if (device_is_compatible(dev, "fsl,p2020-rev1-esdhc"))
>  		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>  
> -	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
> -	    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
> -	    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
> -	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
> +	if (device_is_compatible(dev, "fsl,p2020-esdhc") ||
> +	    device_is_compatible(dev, "fsl,p1010-esdhc") ||
> +	    device_is_compatible(dev, "fsl,t4240-esdhc") ||
> +	    device_is_compatible(dev, "fsl,mpc8536-esdhc"))
>  		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>  }
>  

