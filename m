Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55DD7D7D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344190AbjJZHAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjJZHA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:00:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD07195;
        Thu, 26 Oct 2023 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698303626; x=1729839626;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pabscxDh3+k+vXfOWBPcczqxA4HyNYCb+3z61Dqq4NM=;
  b=hF3fKrsZTjw6OYEXgnOzTUDY4UcL/hV2yT6tfOmExbOdug0nW868BpVg
   r5VHWtcYDnn0LrX3dIcikehx0Sf1rdw71J7nRc6RGghDWzDvYJafqYLCF
   dNYBuO+U6J8pIPF/XG666G6VcdHel+d0mvLJG0sgQXo9T+1+h+yy3Mw2u
   JpN+IPajwa52hdCOWMtYezxX0x1LgW6UqRNBJOzBs9PRJcRsPfrBnomWW
   6vRdSkqon4pLQtisWGMxMA4G1Qg9WeEBiDIHexJQmxB2/d/5eIlYEokHy
   3TO7Wpzd04Ttuvm5hx5p8h2mdXNOXIAPTAB5Zhha0/fVt8Os/m1iyus5K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="453942829"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="453942829"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 00:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="882721828"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="882721828"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.211.218])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 00:00:19 -0700
Message-ID: <8b7f948d-316c-4135-875a-de455ff4849c@intel.com>
Date:   Thu, 26 Oct 2023 10:00:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci_am654: fix start loop index for TAP value
 parsing
Content-Language: en-US
To:     Nitin Yadav <n-yadav@ti.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231026061458.1116276-1-n-yadav@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231026061458.1116276-1-n-yadav@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/23 09:14, Nitin Yadav wrote:
> ti,otap-del-sel-legacy/ti,itap-del-sel-legacy passed from DT
> are currently ignored for all SD/MMC and eMMC modes. Fix this
> by making start loop index to MMC_TIMING_LEGACY.
> 
> Fixes: 8ee5fc0e0b3be ("mmc: sdhci_am654: Update OTAPDLY writes")
> 

There isn't usually a blank line here

Perhaps a Cc: stable@vger.kernel.org tag?

> Signed-off-by: Nitin Yadav <n-yadav@ti.com>

Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  drivers/mmc/host/sdhci_am654.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 544aaaf5cb0f..aae9d255c6a1 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -606,7 +606,7 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
>  		return 0;
>  	}
>  
> -	for (i = MMC_TIMING_MMC_HS; i <= MMC_TIMING_MMC_HS400; i++) {
> +	for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
>  
>  		ret = device_property_read_u32(dev, td[i].otap_binding,
>  					       &sdhci_am654->otap_del_sel[i]);

