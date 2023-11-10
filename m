Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93067E8183
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbjKJS3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346547AbjKJS06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:26:58 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35926F80;
        Thu,  9 Nov 2023 22:23:41 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5b99bfca064so1298246a12.3;
        Thu, 09 Nov 2023 22:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699597421; x=1700202221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mCKfbSvlYu8MIDRjj/6bXZIu0Ksy5ItSqRuSmrChwQw=;
        b=IpaP8P48bzQuLHCz72lnjnrIhQhNYuiPeo9rPIHbiROcm9WJ2rYjB9qPnsGQ5djFno
         6Rr+ad3tRbrLq874MILkL7lyjQw1b3gxkmiD82aU0qMstom2kryfkuboeqOHEVlpnvCG
         Y5qMC92kMccDInSk2oYlIfc70yDqe6loZY5BgncRBmQPLqW0AZ/tYPu/an1yIcXsIl+B
         Jt0Pqm5gsIxOPIH2lWRTv2mGFsaJVkqLDqtCyNk8JXU7gUDfeUPQOcpwLGNy6emoEJ9A
         Sj+lpURIBS06ZY2NwYcsszhpvk8H+V/GyEePd6/NBs/y5tSHplouiEZhtPQfhejsfpSo
         9cCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597421; x=1700202221;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCKfbSvlYu8MIDRjj/6bXZIu0Ksy5ItSqRuSmrChwQw=;
        b=kKTfgP26iKeHyW4t8lA+iwsWK9FfoopqCTyLtgAmNJEFaxNj4ZQ1KFlAAP8h8NTsFx
         kwtE4D7i3zBJLS+wSlZrRLLsMpFiFXeDMIJqhAdmqAlJPa5yb1uWcfqx5WtL9X4KgvGS
         kNeqkwpMBiVDjH5uzyeq8YHJOTxeF5CY4yAXt4L4ZtTyPerc0a44qqUqPkQQnvu4C3Mh
         Wx/G7+iDi9FYfQGy+joxAdhK4vIVzG2c3VfKuHidwzlzLmxxMRpWD/sM8JJdqFtx3DdH
         2BOXmrTPfRApaU4c8n+4eCb8UdzjsarGOvMKHtTKXZZsOgmI7x0Ql0OnztncIll0uIBQ
         bqXg==
X-Gm-Message-State: AOJu0YxECkjdCP637IwHkaYqUru+/BOAoUfSaI1Y5fXdWKAWX25k73ov
        73JKF8tFXvyn04I821QZsGhVqIx2r7g=
X-Google-Smtp-Source: AGHT+IFauVgDiouRipgVdWoz98bMXytBbMr+34vLbJN5sYPYwzFWR3WMGJIa6HZ5yiYJxhxs+Dj/UA==
X-Received: by 2002:a17:902:cec1:b0:1cc:345b:c7e1 with SMTP id d1-20020a170902cec100b001cc345bc7e1mr7175223plg.60.1699593875207;
        Thu, 09 Nov 2023 21:24:35 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001c735421215sm4424645plb.216.2023.11.09.21.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 21:24:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c516412b-01bc-4a38-8045-94188aedd543@roeck-us.net>
Date:   Thu, 9 Nov 2023 21:24:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] watchdog: mediatek: mt7988: add wdt support
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <6912f6f406bc45674020681184f3eeca2f2cb63f.1699576174.git.daniel@makrotopia.org>
 <ddb5b6ca88165aa69f73fe2804eedd0231d8d9e7.1699576174.git.daniel@makrotopia.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ddb5b6ca88165aa69f73fe2804eedd0231d8d9e7.1699576174.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/23 16:30, Daniel Golle wrote:
> Add support for watchdog and reset generator unit of the MediaTek
> MT7988 SoC.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   drivers/watchdog/mtk_wdt.c | 56 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index b2330b16b497a..b98b8c29735aa 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -12,6 +12,7 @@
>   #include <dt-bindings/reset/mt2712-resets.h>
>   #include <dt-bindings/reset/mediatek,mt6795-resets.h>
>   #include <dt-bindings/reset/mt7986-resets.h>
> +#include <dt-bindings/reset/mediatek,mt7988-resets.h>
>   #include <dt-bindings/reset/mt8183-resets.h>
>   #include <dt-bindings/reset/mt8186-resets.h>
>   #include <dt-bindings/reset/mt8188-resets.h>
> @@ -58,6 +59,8 @@
>   #define WDT_SWSYSRST		0x18U
>   #define WDT_SWSYS_RST_KEY	0x88000000
>   
> +#define WDT_SWSYSRST_EN		0xfc
> +
>   #define DRV_NAME		"mtk-wdt"
>   #define DRV_VERSION		"1.0"
>   
> @@ -71,44 +74,85 @@ struct mtk_wdt_dev {
>   	struct reset_controller_dev rcdev;
>   	bool disable_wdt_extrst;
>   	bool reset_by_toprgu;
> +	bool has_swsysrst_en;
>   };
>   
>   struct mtk_wdt_data {
>   	int toprgu_sw_rst_num;
> +	bool has_swsysrst_en;
>   };
>   
>   static const struct mtk_wdt_data mt2712_data = {
>   	.toprgu_sw_rst_num = MT2712_TOPRGU_SW_RST_NUM,
> +	.has_swsysrst_en = false,

Those assignments to false, just like assignments to 0, are unnecessary
for static variables.

>   };
>   
>   static const struct mtk_wdt_data mt6795_data = {
>   	.toprgu_sw_rst_num = MT6795_TOPRGU_SW_RST_NUM,
> +	.has_swsysrst_en = false,
>   };
>   
>   static const struct mtk_wdt_data mt7986_data = {
>   	.toprgu_sw_rst_num = MT7986_TOPRGU_SW_RST_NUM,
> +	.has_swsysrst_en = false,
> +};
> +
> +static const struct mtk_wdt_data mt7988_data = {
> +	.toprgu_sw_rst_num = MT7988_TOPRGU_SW_RST_NUM,
> +	.has_swsysrst_en = true,
>   };
>   
>   static const struct mtk_wdt_data mt8183_data = {
>   	.toprgu_sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
> +	.has_swsysrst_en = false,
>   };
>   
>   static const struct mtk_wdt_data mt8186_data = {
>   	.toprgu_sw_rst_num = MT8186_TOPRGU_SW_RST_NUM,
> +	.has_swsysrst_en = false,
>   };
>   
>   static const struct mtk_wdt_data mt8188_data = {
>   	.toprgu_sw_rst_num = MT8188_TOPRGU_SW_RST_NUM,
> +	.has_swsysrst_en = false,
>   };
>   
>   static const struct mtk_wdt_data mt8192_data = {
>   	.toprgu_sw_rst_num = MT8192_TOPRGU_SW_RST_NUM,
> +	.has_swsysrst_en = false,
>   };
>   
>   static const struct mtk_wdt_data mt8195_data = {
>   	.toprgu_sw_rst_num = MT8195_TOPRGU_SW_RST_NUM,
> +	.has_swsysrst_en = false,
>   };
>   
> +static int toprgu_reset_sw_enable(struct reset_controller_dev *rcdev,
> +				  unsigned long id, bool enable)

This function name is a bit misleading. It doesn't always
_enable_ something, it updates it based on the enable parameter.

> +{
> +	unsigned int tmp;
> +	unsigned long flags;
> +	struct mtk_wdt_dev *data =
> +		 container_of(rcdev, struct mtk_wdt_dev, rcdev);
> +
> +	if (!data->has_swsysrst_en)
> +		return 0;
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +
> +	tmp = readl(data->wdt_base + WDT_SWSYSRST_EN);
> +	if (enable)
> +		tmp |= BIT(id);
> +	else
> +		tmp &= ~BIT(id);
> +
> +	writel(tmp, data->wdt_base + WDT_SWSYSRST_EN);
> +
> +	spin_unlock_irqrestore(&data->lock, flags);
> +

I find this code quite confusing. If it is really necessary to set both
WDT_SWSYSRST_EN and WDT_SWSYSRST together, what is the point of locking twice ?
Why not just handle this in toprgu_reset_update() while the lock is
alread held ? There is a lot of code duplication and inefficiency between
toprgu_reset_sw_enable() and toprgu_reset_update(), and I really don't
see the value of it if  WDT_SWSYSRST_EN and WDT_SWSYSRST have to be
written together anyway.

> +	return 0;

This function always returns 0. That does not add any value.

> +}
> +
>   static int toprgu_reset_update(struct reset_controller_dev *rcdev,
>   			       unsigned long id, bool assert)
>   {
> @@ -135,13 +179,20 @@ static int toprgu_reset_update(struct reset_controller_dev *rcdev,
>   static int toprgu_reset_assert(struct reset_controller_dev *rcdev,
>   			       unsigned long id)
>   {
> +	int ret;
> +
> +	ret = toprgu_reset_sw_enable(rcdev, id, true);
> +	if (ret)
> +		return ret;
> +

I am kind of missing the point of this return value check. I guess it is in line
with the other unnecessary return values / return value checks in this code,
but this really gets a bit out of control. It kind of creates the wrong
assumption or expectation that the called code _may_ return an error,
but in reality it doesn't.

>   	return toprgu_reset_update(rcdev, id, true);
>   }
>   
>   static int toprgu_reset_deassert(struct reset_controller_dev *rcdev,
>   				 unsigned long id)
>   {
> -	return toprgu_reset_update(rcdev, id, false);
> +	toprgu_reset_update(rcdev, id, false);

In a way it is commendable that the unnecessary return value handling was dropped,
but that makes the code inconsistent with the reset_assert() function. Also, it is
inconsistent to have the unnecessary return value check in toprgu_reset_assert()
but not here.

> +	return toprgu_reset_sw_enable(rcdev, id, false);
>   }
>   
>   static int toprgu_reset(struct reset_controller_dev *rcdev,
> @@ -406,6 +457,8 @@ static int mtk_wdt_probe(struct platform_device *pdev)
>   						       wdt_data->toprgu_sw_rst_num);
>   		if (err)
>   			return err;
> +
> +		mtk_wdt->has_swsysrst_en = wdt_data->has_swsysrst_en;

This is too late. The reset controller is already registered here,
and the reset controller functions may already have been called.

>   	}
>   
>   	mtk_wdt->disable_wdt_extrst =

Oh well, this and the next property are also called too late because they
affect watchdog operation and the watchdog device has already been registered,
but that is a different bug and not a reason to add even more race conditions
to the driver.


> @@ -444,6 +497,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
>   	{ .compatible = "mediatek,mt6589-wdt" },
>   	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
>   	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
> +	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },
>   	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
>   	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
>   	{ .compatible = "mediatek,mt8188-wdt", .data = &mt8188_data },

