Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD9B786844
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbjHXH0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbjHXHZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:25:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF390E6F;
        Thu, 24 Aug 2023 00:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692861949; x=1724397949;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=juolVYIQ1gfOJHvCrPHmvtw4yBzTq6cZVINgyiQcExk=;
  b=ihh6+2qB+RiDG38xmxzhtSXCtaoTwq+a5zux7cajpI5PHNEWlxjFEjiZ
   DF5EFJMFa4hZ7ypNkpgcT37GYp9Wkmf6DPBe92SeqZy4Utmg+/zsw8n+o
   9VjAyvzGH71m6AsCIXQr9BwnNnHd+EsACucDId+zQGkTANhSL8/98i8zD
   snjf07CkO++LucP3/5P91HQAVN3wIExmgKOWto3xf7Qx7RutP9VdrQajj
   qO2+FdNpaF8Y+Cicv79E1uKrGAlcKIAskpn7oDwahNQexQHg7BsT+3QLJ
   bezeVxsTcmTbjy7MEXtoJu4Zp6wdaeJvTeRvz4YQORR6GC5dAV53WHSxI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="353909983"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="353909983"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 00:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="860603090"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="860603090"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.187])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 00:25:46 -0700
Message-ID: <c0bc5861-f78f-8d42-8ffe-7be7d827aad3@intel.com>
Date:   Thu, 24 Aug 2023 10:25:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v10 1/2] mmc : sdhci-of-dwcmshc : add error handling in
 dwcmshc_resume
Content-Language: en-US
To:     Liming Sun <limings@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230822195929.168552-1-limings@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230822195929.168552-1-limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/23 22:59, Liming Sun wrote:
> This commit adds handling in dwcmshc_resume() for different error
> cases.
> 
> Signed-off-by: Liming Sun <limings@nvidia.com>

We don't put a space before ":" in the subject line, and usually
capitalize after that i.e.

mmc: sdhci-of-dwcmshc: Add error handling in dwcmshc_resume()

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 31c1892f4ecd..bc332a035032 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -630,17 +630,32 @@ static int dwcmshc_resume(struct device *dev)
>  	if (!IS_ERR(priv->bus_clk)) {
>  		ret = clk_prepare_enable(priv->bus_clk);
>  		if (ret)
> -			return ret;
> +			goto disable_clk;
>  	}
>  
>  	if (rk_priv) {
>  		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
>  					      rk_priv->rockchip_clks);
>  		if (ret)
> -			return ret;
> +			goto disable_bus_clk;
>  	}
>  
> -	return sdhci_resume_host(host);
> +	ret = sdhci_resume_host(host);
> +	if (ret)
> +		goto disable_rockchip_clks;
> +
> +	return 0;
> +
> +disable_rockchip_clks:
> +	if (rk_priv)
> +		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
> +					   rk_priv->rockchip_clks);
> +disable_bus_clk:
> +	if (!IS_ERR(priv->bus_clk))
> +		clk_disable_unprepare(priv->bus_clk);
> +disable_clk:
> +	clk_disable_unprepare(pltfm_host->clk);
> +	return ret;
>  }
>  #endif
>  

