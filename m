Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1787D0FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377274AbjJTMrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbjJTMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:47:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D7291;
        Fri, 20 Oct 2023 05:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697806050; x=1729342050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aXXmqAMTaJ9llNy54dgQduDOBZlBWnWwsrEn2k0KPf8=;
  b=eg5kLCVlCOr3dgpo9WjJh9IIJFJmumbk9VYowJyA9dkPsuUZFeFwEeYl
   2yk1xe4OkVjiZJSAN3AfRJ6dMc9p6Pi+iUC7wKlwx3Red9f4Hasc5K93G
   j7MOZ+btxuN3lc/2lZeSV0L+pVmb9K4N7EAcJpNSCGv49b1UZrkTwAs4j
   PjPbpqNepjcwsZi3u5p/SE5lVX5/ZVxafCIwW5I7m2gVWba8/MsBxmmjs
   wnJbZKGXdw324vzB6x+WtQMNfKuP6KHgR8nVXNJHRccs+e449RBMgMg0r
   83Sj/ieO7YiwULP+eSe3Drk630ECNK+9X3n9yR7aStY2G4VUvYNWMimrk
   w==;
X-CSE-ConnectionGUID: j5zftE2fQGeYR+MQxGrMGg==
X-CSE-MsgGUID: iEkiYNzOQ1W2SQf1bIdoew==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="10428489"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2023 05:47:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 20 Oct 2023 05:47:11 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 20 Oct 2023 05:47:10 -0700
Message-ID: <c339d334-5fe4-4c1a-81ee-42882d93f3e5@microchip.com>
Date:   Fri, 20 Oct 2023 14:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: at91rm9200: annotate at91_rtc_remove with __exit
 again
Content-Language: en-US, fr-FR
To:     <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC:     kernel test robot <lkp@intel.com>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231016041816.246426-1-alexandre.belloni@bootlin.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20231016041816.246426-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2023 at 06:18, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Without __exit, having the driver as a builtin after dropping the __exit
> annotation results in:
> 
>>> drivers/rtc/rtc-at91rm9200.c:561:13: warning: 'at91_rtc_remove' defined but not used [-Wunused-function]
>       561 | static void at91_rtc_remove(struct platform_device *pdev)
>           |             ^~~~~~~~~~~~~~~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310160705.vlElNOGb-lkp@intel.com/
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Thanks Alexandre, best regards,
   Nicolas

> ---
>   drivers/rtc/rtc-at91rm9200.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> index 3f5ff9867c02..c16fe711a0d9 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -558,7 +558,7 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
>   /*
>    * Disable and remove the RTC driver
>    */
> -static void at91_rtc_remove(struct platform_device *pdev)
> +static void __exit at91_rtc_remove(struct platform_device *pdev)
>   {
>          /* Disable all interrupts */
>          at91_rtc_write_idr(AT91_RTC_ACKUPD | AT91_RTC_ALARM |
> --
> 2.41.0
> 

