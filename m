Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992877BE67E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377242AbjJIQfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377235AbjJIQfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:35:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9709E;
        Mon,  9 Oct 2023 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696869319; x=1728405319;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+5aTGRPEMm+/zcuFb1ktUrXhpx+ZuGNHWibFsWuZRgI=;
  b=Cuy2HCSyxdVTRPPOE5RWTDeL+/EMRBcdwFRkvpSWpdD+Ug3HGvHFgSD3
   y9LGLjyRIk0dk9fkVwjJZFLdQWEmdi/AlpPlbYfh9MLiSxL+JJVOXZpAp
   V+F+ZmeO67C7sNdEsU8wkA6mcWz5mQTwm0Fas7wybnH6zl+eXxT8Ilp1w
   DIHm+uw+zOkgEMaQr5tEAvEatrzTKDIiUu3k16cqwnbEIw2cha0b+5BXh
   kAI8m2WsNhBUHEYglHTEdcfuG7HTTGhspa4ft4bS37pS3pGCHaj5+zQeG
   AhbuNGgkZR+bRMW4xBsT7tZHtLrXeY6VQW3x9kbGQRaLQEeoIprUWruaj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="384055074"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="384055074"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 09:35:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="896836713"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="896836713"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.36.27])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 09:33:32 -0700
Message-ID: <7443c574-7f1d-4ee5-b3f9-da42989af90e@intel.com>
Date:   Mon, 9 Oct 2023 19:35:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mmc: sdhci-pltfm: Drop unnecessary error messages
 in sdhci_pltfm_init()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231006105803.3374241-1-andriy.shevchenko@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231006105803.3374241-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/23 13:58, Andy Shevchenko wrote:
> The devm_platform_ioremap_resource() and platform_get_irq() print
> the error messages themselves and our "failed" one brings no value
> and just noise. Refactor code to avoid those noisy error messages.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pltfm.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index a72e123a585d..4d1a703a5bdb 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -115,26 +115,21 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>  {
>  	struct sdhci_host *host;
>  	void __iomem *ioaddr;
> -	int irq, ret;
> +	int irq;
>  
>  	ioaddr = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(ioaddr)) {
> -		ret = PTR_ERR(ioaddr);
> -		goto err;
> -	}
> +	if (IS_ERR(ioaddr))
> +		return ERR_CAST(ioaddr);
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		ret = irq;
> -		goto err;
> -	}
> +	if (irq < 0)
> +		return ERR_PTR(irq);
>  
>  	host = sdhci_alloc_host(&pdev->dev,
>  		sizeof(struct sdhci_pltfm_host) + priv_size);
> -
>  	if (IS_ERR(host)) {
> -		ret = PTR_ERR(host);
> -		goto err;
> +		dev_err(&pdev->dev, "%s failed %pe\n", __func__, host);
> +		return ERR_CAST(host);
>  	}
>  
>  	host->ioaddr = ioaddr;
> @@ -152,9 +147,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>  	platform_set_drvdata(pdev, host);
>  
>  	return host;
> -err:
> -	dev_err(&pdev->dev, "%s failed %d\n", __func__, ret);
> -	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_pltfm_init);
>  

