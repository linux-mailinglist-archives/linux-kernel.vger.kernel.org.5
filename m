Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB9876650E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjG1HQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjG1HQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:16:10 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34073582;
        Fri, 28 Jul 2023 00:15:59 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 8DE6010000F;
        Fri, 28 Jul 2023 10:15:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8DE6010000F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1690528558;
        bh=yT09/6EmtFPsU3TkGmMnRNa30vOtfQ3a70zyB/EZyWQ=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=SLTMFY/CK3BUhDNbg7TBGGqKFyAHJpzdofatlQqwNJdbBUIVFtpnuVe32Wlp9XiSX
         +0WvRTvZRRRFf+HogUi3D/0TLf+goI2Rfs+L+o8KtaR7P4LrQejkSFg3oMB9fU5pUx
         y/0nnh2xyk6oeb+1baAbhxCWzWPb3a+mdjHWDwOmjtzTgnqwZSkGH8CPPwijDV88HJ
         saalu0JZTGKIGKheMfPsEEygBT+Do2QPatG8gbEyTiumYqDj7Pn9m9hl2W2jy7Vej4
         /gT1XRp2DmwnEVH1XYXs9wWbiDRawRZPAch5b7XbY1B7RK+DrPff72RuUS9AZmuA9i
         U7z/X7gnUSLYQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 28 Jul 2023 10:15:58 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 28 Jul
 2023 10:15:35 +0300
Date:   Fri, 28 Jul 2023 10:15:58 +0300
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
Subject: Re: [PATCH 2/4] watchdog: Add a new struct for Amlogic-GXBB driver
Message-ID: <20230728071558.xoa3sdku3zkuhtug@CAB-WSD-L081021>
References: <20230726112146.1127145-1-huqiang.qin@amlogic.com>
 <20230726112146.1127145-3-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230726112146.1127145-3-huqiang.qin@amlogic.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Huqiang,

Thank you for the patch series!

Please include a cover letter in future patch submissions if possible.
It will help to better understand the theme of the patch series and
group all patch sets together in one email thread.

On Wed, Jul 26, 2023 at 07:21:44PM +0800, Huqiang Qin wrote:
> Add a new structure wdt_params to describe the watchdog difference
> of different chips.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> ---
>  drivers/watchdog/meson_gxbb_wdt.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
> index 35d80cb39856..a6c0d743b607 100644
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
> +	u8 rst_shift;
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
> +	.rst_shift = 21,

Maybe it's better to declare rst with the BIT() macro already applied,
and use it in wdt_probe() as is. And name 'rst' without 'shift' is
looking more brief.

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
> +			BIT(params->rst_shift) |
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
