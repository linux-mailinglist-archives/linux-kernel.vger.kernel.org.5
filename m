Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF1876C729
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjHBHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjHBHkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:40:17 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA3C4C0E;
        Wed,  2 Aug 2023 00:38:19 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 8F4CB100020;
        Wed,  2 Aug 2023 10:38:09 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8F4CB100020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1690961889;
        bh=2YBD3HHCpBblCigCemMGFithywGJOmmTUaqFXjxfdm8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=VKlloV2M5Qg1ORESM9UJVizuOXCx2LfG+VMrBS7kBzWZ+7e/8gBKaHEGZyrBwzR7u
         0ENIbJ40Fs11rwhAXIy5Ko1GFkbCy1lBT30uk5BS4afBI/3VvEykCk0BqwsudwSMCN
         KaLugvIWGoTMl+7wqq0baA2AdwT9KmkZNIvJB4EO2pQwYg7G8wHbf/5Yxvl2482+tL
         37wcpv1ongXLCrTbIoy7JZUTZu6oP+MfUUTZLynlAUMbV1EQ7FZup9GHvZVYrBg/md
         bciFfbiPXdPmkIDimtW+fJ9owUDFf6aQWjWSI9iGSqApLL9p1cvLIMeN/nU8p1PX8R
         AG+APObH51o5w==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  2 Aug 2023 10:38:09 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 10:38:08 +0300
Date:   Wed, 2 Aug 2023 10:38:04 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
CC:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/4] watchdog: Add a new struct for Amlogic-GXBB driver
Message-ID: <20230802073804.7r4uofuutgwj6zmw@CAB-WSD-L081021>
References: <20230802033222.4024946-1-huqiang.qin@amlogic.com>
 <20230802033222.4024946-3-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230802033222.4024946-3-huqiang.qin@amlogic.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178796 [Jul 22 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 525 525 723604743bfbdb7e16728748c3fa45e9eba05f7d, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/23 10:45:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/23 10:46:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/23 08:49:00 #21663637
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 11:32:20AM +0800, Huqiang Qin wrote:
> Add a new structure wdt_params to describe the watchdog difference
> of different chips.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

> ---
> 
> V1 -> V2: Rename rst_shift to rst and use the BIT() macro to build
>           its initial value.
> 
>  drivers/watchdog/meson_gxbb_wdt.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 35d80cb39856..18180d91543e 100644
> --- a/drivers/watchdog/meson_gxbb_wdt.c
> +++ b/drivers/watchdog/meson_gxbb_wdt.c
> @@ -22,7 +22,6 @@
>  
>  #define GXBB_WDT_CTRL_CLKDIV_EN			BIT(25)
>  #define GXBB_WDT_CTRL_CLK_EN			BIT(24)
> -#define GXBB_WDT_CTRL_EE_RESET			BIT(21)
>  #define GXBB_WDT_CTRL_EN			BIT(18)
>  #define GXBB_WDT_CTRL_DIV_MASK			(BIT(18) - 1)
>  
> @@ -45,6 +44,10 @@ struct meson_gxbb_wdt {
>  	struct clk *clk;
>  };
>  
> +struct wdt_params {
> +	u32 rst;
> +};
> +
>  static int meson_gxbb_wdt_start(struct watchdog_device *wdt_dev)
>  {
>  	struct meson_gxbb_wdt *data = watchdog_get_drvdata(wdt_dev);
> @@ -140,8 +143,12 @@ static const struct dev_pm_ops meson_gxbb_wdt_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(meson_gxbb_wdt_suspend, meson_gxbb_wdt_resume)
>  };
>  
> +static const struct wdt_params gxbb_params = {
> +	.rst = BIT(21),
> +};
> +
>  static const struct of_device_id meson_gxbb_wdt_dt_ids[] = {
> -	 { .compatible = "amlogic,meson-gxbb-wdt", },
> +	 { .compatible = "amlogic,meson-gxbb-wdt", .data = &gxbb_params, },
>  	 { /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, meson_gxbb_wdt_dt_ids);
> @@ -150,6 +157,7 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct meson_gxbb_wdt *data;
> +	struct wdt_params *params;
>  	u32 ctrl_reg;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> @@ -164,6 +172,8 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->clk))
>  		return PTR_ERR(data->clk);
>  
> +	params = (struct wdt_params *)of_device_get_match_data(dev);
> +
>  	platform_set_drvdata(pdev, data);
>  
>  	data->wdt_dev.parent = dev;
> @@ -191,7 +201,7 @@ static int meson_gxbb_wdt_probe(struct platform_device *pdev)
>  	/* Setup with 1ms timebase */
>  	ctrl_reg |= ((clk_get_rate(data->clk) / 1000) &
>  			GXBB_WDT_CTRL_DIV_MASK) |
> -			GXBB_WDT_CTRL_EE_RESET |
> +			params->rst |
>  			GXBB_WDT_CTRL_CLK_EN |
>  			GXBB_WDT_CTRL_CLKDIV_EN;
>  
> -- 
> 2.37.1
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
