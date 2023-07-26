Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C07762BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGZGzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjGZGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:55:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B27273E;
        Tue, 25 Jul 2023 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690354506; x=1721890506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NGfMfU7QX/FvMvczs5lY6l7TlgmEQkvKreP+H495+9Q=;
  b=iIuJ29lLWTpBiC5chOdvRx90yMyRa/9zbR/fkHvLVTRxSTQ99b8QwV+4
   wBdYuXIvPXL84jOHs0OWXx1T3KVKCwDVhCVR4YjECcgi8Vtw2lPud4lWR
   LtSBRcPmYKacnmoiDvc6RAoNv5b7CrvDdMR+/kR7VAvtVAE7g69cMxwbp
   A2vcUSGAB5zd/pT+xro99Fc/cTfh4hx0tfxheqr8GuMjzB3sAd0xTgDc/
   kHy7o0IV0/Bg3OGeIUSEA8fLX/X7dZ1z3Ea9DvK2RZOgPG9jcCU/jBX3S
   Knz51onA1gB0M4Qd10R6cl1Q5VWtA1vSLj/26s/XzQQZPJdpDck3t1jpw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="357936992"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="357936992"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 23:55:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="676547119"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="676547119"
Received: from igosu-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.75])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 23:55:03 -0700
Message-ID: <6cd56798-dbdf-35d8-a381-a569cbbe00ee@intel.com>
Date:   Wed, 26 Jul 2023 09:54:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 34/61] mmc: sdhci-of-aspeed: Convert to platform remove
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230726040041.26267-1-frank.li@vivo.com>
 <20230726040041.26267-34-frank.li@vivo.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230726040041.26267-34-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/23 07:00, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index b4867bb4a564..42d54532cabe 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -450,7 +450,7 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int aspeed_sdhci_remove(struct platform_device *pdev)
> +static void aspeed_sdhci_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
> @@ -463,8 +463,6 @@ static int aspeed_sdhci_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(pltfm_host->clk);
>  
>  	sdhci_pltfm_free(pdev);
> -
> -	return 0;
>  }
>  
>  static const struct aspeed_sdhci_pdata ast2400_sdhci_pdata = {
> @@ -520,7 +518,7 @@ static struct platform_driver aspeed_sdhci_driver = {
>  		.of_match_table = aspeed_sdhci_of_match,
>  	},
>  	.probe		= aspeed_sdhci_probe,
> -	.remove		= aspeed_sdhci_remove,
> +	.remove_new	= aspeed_sdhci_remove,
>  };
>  
>  static int aspeed_sdc_probe(struct platform_device *pdev)
> @@ -573,13 +571,11 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int aspeed_sdc_remove(struct platform_device *pdev)
> +static void aspeed_sdc_remove(struct platform_device *pdev)
>  {
>  	struct aspeed_sdc *sdc = dev_get_drvdata(&pdev->dev);
>  
>  	clk_disable_unprepare(sdc->clk);
> -
> -	return 0;
>  }
>  
>  static const struct of_device_id aspeed_sdc_of_match[] = {
> @@ -599,7 +595,7 @@ static struct platform_driver aspeed_sdc_driver = {
>  		.of_match_table = aspeed_sdc_of_match,
>  	},
>  	.probe		= aspeed_sdc_probe,
> -	.remove		= aspeed_sdc_remove,
> +	.remove_new	= aspeed_sdc_remove,
>  };
>  
>  #if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)

