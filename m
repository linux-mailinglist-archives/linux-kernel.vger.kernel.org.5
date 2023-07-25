Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C0E7614DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjGYLXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbjGYLXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:23:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4D2A6;
        Tue, 25 Jul 2023 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690284192; x=1721820192;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z1vqkq/iqAf0skLD29Ge2B3k4J5l8STsWPuG916UbLw=;
  b=bDHJ76gQbYM1yi+zR464IkjWxs557c6mBv8xC6I065YfGrP56p3C8aQ3
   fGGLQyubYHUo64P12BA6X0DX1WRmkG99VzjL1VCUZ8sF1Q7i6MXyTwX4r
   RmPlhYhJT5wRLmi85q+wTZ76Aj7DEGC5JeZUCZI3NAYBbwfuovqYPG19L
   fmZSyvu5jGhmuKZP1wx46HpMJ0/uKqc4pq2XFZp8URxV75AJr4hM/wo0x
   1hab8KrAoGC+wvIZ7E/AyGd6s1wSWHxel3k2Xt/bLIPTeBmYB5ptzm8rT
   BT8pM5ofOQR7jXI8q1AMvmynhz/idDLaDtR25TPC+ENBN7NOTeh6B/+Ct
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="365153434"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="365153434"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 04:22:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="703245451"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="703245451"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.37.150])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 04:22:51 -0700
Message-ID: <ebb0a629-caa5-e038-341d-cc5f07683e7f@intel.com>
Date:   Tue, 25 Jul 2023 14:22:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 58/58] mmc: Convert to platform remove callback returning
 void
To:     Yangtao Li <frank.li@vivo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230713080807.69999-1-frank.li@vivo.com>
 <20230713080807.69999-58-frank.li@vivo.com>
 <5d120109-cbec-f086-c442-f3bd3fd1ebe7@intel.com>
 <9269d1ae-0dc4-e633-082e-ccd75efd103f@vivo.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <9269d1ae-0dc4-e633-082e-ccd75efd103f@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/23 11:13, Yangtao Li wrote:
> Hi Adria,
> 
> On 2023/7/14 15:49, Adrian Hunter wrote:
>> On 13/07/23 11:08, Yangtao Li wrote:
>>> The .remove() callback for a platform driver returns an int which makes
>>> many driver authors wrongly assume it's possible to do error handling by
>>> returning an error code. However the value returned is (mostly) ignored
>>> and this typically results in resource leaks. To improve here there is a
>>> quest to make the remove callback return void. In the first step of this
>>> quest all drivers are converted to .remove_new() which already returns
>>> void.
>>>
>>> Trivially convert this driver from always returning zero in the remove
>>> callback to the void returning variant.
>>>
>>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>   drivers/mmc/host/sdhci-bcm-kona.c  | 2 +-
>>>   drivers/mmc/host/sdhci-brcmstb.c   | 2 +-
>>>   drivers/mmc/host/sdhci-cadence.c   | 2 +-
>>>   drivers/mmc/host/sdhci-dove.c      | 2 +-
>>>   drivers/mmc/host/sdhci-iproc.c     | 2 +-
>>>   drivers/mmc/host/sdhci-of-esdhc.c  | 2 +-
>>>   drivers/mmc/host/sdhci-of-hlwd.c   | 2 +-
>>>   drivers/mmc/host/sdhci-of-sparx5.c | 2 +-
>>>   drivers/mmc/host/sdhci-pltfm.c     | 4 +---
>>>   drivers/mmc/host/sdhci-pltfm.h     | 2 +-
>>>   drivers/mmc/host/sdhci-pxav2.c     | 2 +-
>> Looks like drivers/mmc/host/sdhci-npcm.c was missed
> 
> 
> Neither [1] nor [2] can find this driver, what am I missing?

Sorry, it was some untracked rubbish left over in my tree.

In that case:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> 
> [1]
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/tree/drivers/mmc/host?h=next
> 
> [2]
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host
> 
> 
> Thx,
> 
> Yangtao
> 
> 
>>
>>>   11 files changed, 11 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
>>> index 6a93a54fe067..2e3736603853 100644
>>> --- a/drivers/mmc/host/sdhci-bcm-kona.c
>>> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
>>> @@ -319,7 +319,7 @@ static struct platform_driver sdhci_bcm_kona_driver = {
>>>           .of_match_table = sdhci_bcm_kona_of_match,
>>>       },
>>>       .probe        = sdhci_bcm_kona_probe,
>>> -    .remove        = sdhci_pltfm_unregister,
>>> +    .remove_new    = sdhci_pltfm_unregister,
>>>   };
>>>   module_platform_driver(sdhci_bcm_kona_driver);
>>>   diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
>>> index 4c22337199cf..a2b6d8f2eeb6 100644
>>> --- a/drivers/mmc/host/sdhci-brcmstb.c
>>> +++ b/drivers/mmc/host/sdhci-brcmstb.c
>>> @@ -430,7 +430,7 @@ static struct platform_driver sdhci_brcmstb_driver = {
>>>           .of_match_table = of_match_ptr(sdhci_brcm_of_match),
>>>       },
>>>       .probe        = sdhci_brcmstb_probe,
>>> -    .remove        = sdhci_pltfm_unregister,
>>> +    .remove_new    = sdhci_pltfm_unregister,
>>>       .shutdown    = sdhci_brcmstb_shutdown,
>>>   };
>>>   diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
>>> index d2f625054689..1702a499b36a 100644
>>> --- a/drivers/mmc/host/sdhci-cadence.c
>>> +++ b/drivers/mmc/host/sdhci-cadence.c
>>> @@ -617,7 +617,7 @@ static struct platform_driver sdhci_cdns_driver = {
>>>           .of_match_table = sdhci_cdns_match,
>>>       },
>>>       .probe = sdhci_cdns_probe,
>>> -    .remove = sdhci_pltfm_unregister,
>>> +    .remove_new = sdhci_pltfm_unregister,
>>>   };
>>>   module_platform_driver(sdhci_cdns_driver);
>>>   diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
>>> index 5e5bf82e5976..75335dbf223c 100644
>>> --- a/drivers/mmc/host/sdhci-dove.c
>>> +++ b/drivers/mmc/host/sdhci-dove.c
>>> @@ -110,7 +110,7 @@ static struct platform_driver sdhci_dove_driver = {
>>>           .of_match_table = sdhci_dove_of_match_table,
>>>       },
>>>       .probe        = sdhci_dove_probe,
>>> -    .remove        = sdhci_pltfm_unregister,
>>> +    .remove_new    = sdhci_pltfm_unregister,
>>>   };
>>>     module_platform_driver(sdhci_dove_driver);
>>> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
>>> index 86eb0045515e..0dbebcecd8fc 100644
>>> --- a/drivers/mmc/host/sdhci-iproc.c
>>> +++ b/drivers/mmc/host/sdhci-iproc.c
>>> @@ -432,7 +432,7 @@ static struct platform_driver sdhci_iproc_driver = {
>>>           .pm = &sdhci_pltfm_pmops,
>>>       },
>>>       .probe = sdhci_iproc_probe,
>>> -    .remove = sdhci_pltfm_unregister,
>>> +    .remove_new = sdhci_pltfm_unregister,
>>>       .shutdown = sdhci_iproc_shutdown,
>>>   };
>>>   module_platform_driver(sdhci_iproc_driver);
>>> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
>>> index 48ca1cf15b19..5072b59f6165 100644
>>> --- a/drivers/mmc/host/sdhci-of-esdhc.c
>>> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>>> @@ -1521,7 +1521,7 @@ static struct platform_driver sdhci_esdhc_driver = {
>>>           .pm = &esdhc_of_dev_pm_ops,
>>>       },
>>>       .probe = sdhci_esdhc_probe,
>>> -    .remove = sdhci_pltfm_unregister,
>>> +    .remove_new = sdhci_pltfm_unregister,
>>>   };
>>>     module_platform_driver(sdhci_esdhc_driver);
>>> diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
>>> index 12675797b296..cba3ba48e9dc 100644
>>> --- a/drivers/mmc/host/sdhci-of-hlwd.c
>>> +++ b/drivers/mmc/host/sdhci-of-hlwd.c
>>> @@ -85,7 +85,7 @@ static struct platform_driver sdhci_hlwd_driver = {
>>>           .pm = &sdhci_pltfm_pmops,
>>>       },
>>>       .probe = sdhci_hlwd_probe,
>>> -    .remove = sdhci_pltfm_unregister,
>>> +    .remove_new = sdhci_pltfm_unregister,
>>>   };
>>>     module_platform_driver(sdhci_hlwd_driver);
>>> diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-of-sparx5.c
>>> index 28e4ee69e100..26aaab068e00 100644
>>> --- a/drivers/mmc/host/sdhci-of-sparx5.c
>>> +++ b/drivers/mmc/host/sdhci-of-sparx5.c
>>> @@ -260,7 +260,7 @@ static struct platform_driver sdhci_sparx5_driver = {
>>>           .pm = &sdhci_pltfm_pmops,
>>>       },
>>>       .probe = sdhci_sparx5_probe,
>>> -    .remove = sdhci_pltfm_unregister,
>>> +    .remove_new = sdhci_pltfm_unregister,
>>>   };
>>>     module_platform_driver(sdhci_sparx5_driver);
>>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
>>> index 673e750a8490..72d07b49b0a3 100644
>>> --- a/drivers/mmc/host/sdhci-pltfm.c
>>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>>> @@ -187,7 +187,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
>>>   }
>>>   EXPORT_SYMBOL_GPL(sdhci_pltfm_register);
>>>   -int sdhci_pltfm_unregister(struct platform_device *pdev)
>>> +void sdhci_pltfm_unregister(struct platform_device *pdev)
>>>   {
>>>       struct sdhci_host *host = platform_get_drvdata(pdev);
>>>       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> @@ -196,8 +196,6 @@ int sdhci_pltfm_unregister(struct platform_device *pdev)
>>>       sdhci_remove_host(host, dead);
>>>       clk_disable_unprepare(pltfm_host->clk);
>>>       sdhci_pltfm_free(pdev);
>>> -
>>> -    return 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
>>>   diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
>>> index 9bd717ff784b..6e6a443dafd9 100644
>>> --- a/drivers/mmc/host/sdhci-pltfm.h
>>> +++ b/drivers/mmc/host/sdhci-pltfm.h
>>> @@ -102,7 +102,7 @@ extern void sdhci_pltfm_free(struct platform_device *pdev);
>>>   extern int sdhci_pltfm_register(struct platform_device *pdev,
>>>                   const struct sdhci_pltfm_data *pdata,
>>>                   size_t priv_size);
>>> -extern int sdhci_pltfm_unregister(struct platform_device *pdev);
>>> +extern void sdhci_pltfm_unregister(struct platform_device *pdev);
>>>     extern unsigned int sdhci_pltfm_clk_get_max_clock(struct sdhci_host *host);
>>>   diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
>>> index 91aca8f8d6ef..1c1e763ce209 100644
>>> --- a/drivers/mmc/host/sdhci-pxav2.c
>>> +++ b/drivers/mmc/host/sdhci-pxav2.c
>>> @@ -359,7 +359,7 @@ static struct platform_driver sdhci_pxav2_driver = {
>>>           .pm    = &sdhci_pltfm_pmops,
>>>       },
>>>       .probe        = sdhci_pxav2_probe,
>>> -    .remove        = sdhci_pltfm_unregister,
>>> +    .remove_new    = sdhci_pltfm_unregister,
>>>   };
>>>     module_platform_driver(sdhci_pxav2_driver);

