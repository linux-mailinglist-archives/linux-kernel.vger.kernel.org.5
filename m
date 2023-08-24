Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794C9786852
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240344AbjHXH3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240341AbjHXH3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:29:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C583410F3;
        Thu, 24 Aug 2023 00:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692862142; x=1724398142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T5+gLDFeDpKHHJjBk6Pc68AyrOLuoiZ/CnvfLypnNnM=;
  b=YO3JVT1lF+gZShn+62O3PuAcw1AnB0zsIfDQGp5RT/BcWETDEPJxgBQS
   ng9UWAOvNdpHPto8UrIoeTG09GCISWaaNow+PMNT3J1dbsMRCygVVjbuU
   NwqlTzhb23WN0003GznBHDuqH0YJ1ez8iSxH8bb5DaF5NNrZRr/wpD9E7
   DyxbXijsOIXcbgJ3QSDA4mDnvqjzYlO/HU6B7LwCu3QInEIJnyMqmAyHs
   9/hbJnbv6sq1XZIk5j6AFrOeZy8WL0cM/S+IIjTdyueZsJw+0C31pA6nc
   yeiLU/K0HQLyj1lLhqYvo/sAMzn+xMMWLrSYIE6TV1IvYS5YXYIlfCvVw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="364540973"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364540973"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 00:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="802443973"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="802443973"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.187])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 00:28:59 -0700
Message-ID: <32616176-f56e-c234-cebb-f4b1c6f92181@intel.com>
Date:   Thu, 24 Aug 2023 10:28:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v10 2/2] This commit implements the runtime PM operations
 to disable eMMC card clock when idle.
Content-Language: en-US
To:     Liming Sun <limings@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230822195929.168552-2-limings@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230822195929.168552-2-limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/23 22:59, Liming Sun wrote:
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Seem the subject line got lost (it was OK in v9), and the description
is in the subject line.

Apart from that:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v9->v10:
>     - Simplify the changes with pm_runtime_resume() in
>       dwcmshc_suspend().
> v8->v9:
>     - Address Adrian's comment to do the pm_runtime_put() in
>       dwcmshc_resume() instead; Error path changes not included yet.
> v7->v8:
>     - Address Ulf's comment (option-1);
>     - Updates for Adrian's comment to remove the force_suspend/resume
>       in dwcmshc_resume()/dwcmshc_suspend(); Add comments for
>       dwcmshc_resume()/dwcmshc_suspend();
> v6->v7:
>     - Address Ulf's comment;
> v5->v6:
>     - Address Adrian's more comments and add coordination between
>       runtime PM and system PM;
> v4->v5:
>     - Address Adrian's comment to move the pm_enable to the end to
>       avoid race;
> v3->v4:
>     - Fix compiling reported by 'kernel test robot';
> v2->v3:
>     - Revise the commit message;
> v1->v2:
>     Updates for comments from Ulf:
>     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
> v1: Initial version.
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 64 ++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index bc332a035032..3a3bae6948a8 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>  
> @@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  
>  	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>  
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
>  	err = sdhci_setup_host(host);
>  	if (err)
> -		goto err_clk;
> +		goto err_rpm;
>  
>  	if (rk_priv)
>  		dwcmshc_rk35xx_postinit(host, priv);
> @@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_setup_host;
>  
> +	pm_runtime_put(dev);
> +
>  	return 0;
>  
>  err_setup_host:
>  	sdhci_cleanup_host(host);
> +err_rpm:
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
>  err_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
> @@ -600,6 +610,8 @@ static int dwcmshc_suspend(struct device *dev)
>  	struct rk35xx_priv *rk_priv = priv->priv;
>  	int ret;
>  
> +	pm_runtime_resume(dev);
> +
>  	ret = sdhci_suspend_host(host);
>  	if (ret)
>  		return ret;
> @@ -659,7 +671,55 @@ static int dwcmshc_resume(struct device *dev)
>  }
>  #endif
>  
> -static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
> +#ifdef CONFIG_PM
> +
> +static void dwcmshc_enable_card_clk(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
> +		ctrl |= SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +	}
> +}
> +
> +static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	if (ctrl & SDHCI_CLOCK_CARD_EN) {
> +		ctrl &= ~SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +	}
> +}
> +
> +static int dwcmshc_runtime_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +
> +	dwcmshc_disable_card_clk(host);
> +
> +	return 0;
> +}
> +
> +static int dwcmshc_runtime_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +
> +	dwcmshc_enable_card_clk(host);
> +
> +	return 0;
> +}
> +
> +#endif
> +
> +static const struct dev_pm_ops dwcmshc_pmops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend, dwcmshc_resume)
> +	SET_RUNTIME_PM_OPS(dwcmshc_runtime_suspend,
> +			   dwcmshc_runtime_resume, NULL)
> +};
>  
>  static struct platform_driver sdhci_dwcmshc_driver = {
>  	.driver	= {

