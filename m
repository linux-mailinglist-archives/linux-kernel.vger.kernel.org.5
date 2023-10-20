Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896327D11DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377594AbjJTOvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377599AbjJTOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:51:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7CAD5D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697813478; x=1729349478;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZNx7aKNxR1JCdM0GYnzARAWZKmT7PvTlnU+feFxDyT4=;
  b=WFYQVW+9tPkOkY1gqtttrvBwgVulFXL2YT8LDj18Egc9lmRi852V7zcD
   WVfODf0rz1VUmeumJOpD2tdr+PF/peL8ju5jTF2aK6Xv0HmZwg0d6DbZL
   mEgp5EdN6LnoHGfZn8suNyjfc4kytjr+DiN3LWMeY4ikKf35X2wvxF4DF
   zRTeB7I69+PyWd9POLAy/y8wwAGLD9crPvKoBZqYGCjL5sxWLpKNX0QY6
   gS0V+/cyC+Iie+qFBweFj/6Z2i2nY1RSWy7unKrMbaWadKQMhuHrPHz9G
   u0BQtBTEFjfCY9UDK5IIgban4ruHA3L3hMxJ3rx92ybwcCnR3Drvztj0t
   w==;
X-CSE-ConnectionGUID: ocJDPVuyT8exT4se+Y40Zg==
X-CSE-MsgGUID: S1v/16qyQ5i12ueTSkBl9Q==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="241093098"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2023 07:51:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 20 Oct 2023 07:50:55 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 20 Oct 2023 07:50:54 -0700
Message-ID: <30ea0614-3384-46a7-9a0e-8a96b97c985d@microchip.com>
Date:   Fri, 20 Oct 2023 16:50:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: at91: pm: set soc_pm.data.mode in
 at91_pm_secure_init()
Content-Language: en-US, fr-FR
To:     <thomas.perrot@bootlin.com>, Russell King <linux@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <clement.leger@bootlin.com>
References: <20231020130219.1255937-1-thomas.perrot@bootlin.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20231020130219.1255937-1-thomas.perrot@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2023 at 15:02, thomas.perrot@bootlin.com wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> From: Thomas Perrot <thomas.perrot@bootlin.com>
> 
> In non secure mode, soc_pm.data.mode is set when entering pm in
> at91_pm_begin(). This value is used (not only) to determine if the system
> is going into slow clock mode (at91_suspend_entering_slow_clock()). This
> function is called from various drivers to check this and act accordingly.
> If not set, the driver might enter an incorrect suspend mode. When using
> secure suspend mode, at91_pm_begin() is not called and thus
> soc_pm.data.mode is not set. Since when using secure suspend, only one
> suspend mode is supported, set this value directly in
> at91_pm_secure_init().
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Thanks, best regards,
   Nicolas

> ---
>   arch/arm/mach-at91/pm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 1a26af0fabc7..345b91dc6627 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -1103,6 +1103,7 @@ static void __init at91_pm_secure_init(void)
>          if (res.a0 == 0) {
>                  pr_info("AT91: Secure PM: suspend mode set to %s\n",
>                          pm_modes[suspend_mode].pattern);
> +               soc_pm.data.mode = suspend_mode;
>                  return;
>          }
> 
> @@ -1112,6 +1113,7 @@ static void __init at91_pm_secure_init(void)
>          res = sam_smccc_call(SAMA5_SMC_SIP_GET_SUSPEND_MODE, 0, 0);
>          if (res.a0 == 0) {
>                  pr_warn("AT91: Secure PM: failed to get default mode\n");
> +               soc_pm.data.mode = -1;
>                  return;
>          }
> 
> @@ -1119,6 +1121,7 @@ static void __init at91_pm_secure_init(void)
>                  pm_modes[suspend_mode].pattern);
> 
>          soc_pm.data.suspend_mode = res.a1;
> +       soc_pm.data.mode = soc_pm.data.suspend_mode;
>   }
>   static const struct of_device_id atmel_shdwc_ids[] = {
>          { .compatible = "atmel,sama5d2-shdwc" },
> --
> 2.41.0
> 

