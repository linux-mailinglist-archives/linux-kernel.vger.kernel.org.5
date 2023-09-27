Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F857B0D24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjI0UGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjI0UGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:06:07 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47061CC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:06:03 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77574dec71bso130670085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1695845162; x=1696449962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=40eq+oYmKp+ilulUb5AKkmUrv9jJ6ytF+Xz3YyFv3Ww=;
        b=m3QotSWL0LbTLGVCtR856Q9shkiILgEWli+B5VRuAYqgyOJwfBMqWKFnFTXwe7yxgj
         1GwQ38yQPbIHJKnoFl8HvSALMCSiUDA6yexEr/zC4lP1vRym+R4rcijgdW8lUBXwDcY+
         nebuA4sc2HIOam3lUGkWIU0L7QbPnXiKzlcsobVyQNNZnejVdoPV7MQS/4XbgJbWIeMd
         di7afvPwMcolWHFUvEb6PEYUClIASJIdHEQAR4qAU2iKu3uOX4FLrWeOYda/BH4VagBw
         uiPatDqOpabfToFTWIluyWUrCj86hEbg5LUZLsxppX40F+okSI92INrn7SbPy8ICdHK7
         KHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695845162; x=1696449962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40eq+oYmKp+ilulUb5AKkmUrv9jJ6ytF+Xz3YyFv3Ww=;
        b=oYH4C9Kwa+QfJphoIvtpvCaq20LDzf+Lm6+z5vhmUe80Ul/AfCV/WZOQHY6WGcHnaZ
         V0SU+SOSA06u2xhVzqrqmKdplUxfABrgiPDJelsTY073ViMazNVRVpiFa9fXmrZL6B0S
         jYNqB8HRK9KmbuQMJe7K7uuMHSTFhNrwd1PKiTYjlVsrgwsqftayHb5u4nMWkdXyVCuP
         qiFhcddSxOWOo+S8yjF4Ds/hnZPIlzrk68aBhyUEQ/J7n3y6RU09f81idBsHpdWe/rIh
         6t3uZXzNGlDcEowZf8GDPrZu80a4t2V0TvhcUwlcGv/Ls0qYHgT1zIj6GXdwWFJTwGEj
         30qg==
X-Gm-Message-State: AOJu0YyyiPNlN+5PzdpI7Q5+B+lX2ae5aD0R842CW2QVB4Q5837xWnO7
        UgGXqEXCyDZ5oM17W2GKiX6i6g==
X-Google-Smtp-Source: AGHT+IFMPOm8j34YhAJhK1SHuhjb4UEAdjponWhdyf6i2zFU73RSkmiApsy5guU+H6KCC9P8kOSl2A==
X-Received: by 2002:a0c:e54f:0:b0:655:dd4b:d077 with SMTP id n15-20020a0ce54f000000b00655dd4bd077mr2926340qvm.51.1695845162374;
        Wed, 27 Sep 2023 13:06:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:40d8:421c:60ef:36d5? ([2600:1700:2000:b002:40d8:421c:60ef:36d5])
        by smtp.gmail.com with ESMTPSA id l19-20020a0ce513000000b00655e2005350sm2650867qvm.9.2023.09.27.13.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 13:06:01 -0700 (PDT)
Message-ID: <71833cb5-1dfc-42d3-a2a2-6abe8520aee2@sifive.com>
Date:   Wed, 27 Sep 2023 15:06:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: dwc3: add T-HEAD TH1520 usb driver
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, linux-riscv@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <20230927164222.3505-1-jszhang@kernel.org>
 <20230927164222.3505-3-jszhang@kernel.org>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20230927164222.3505-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-27 11:42 AM, Jisheng Zhang wrote:
> Adds TH1520 Glue layer to support USB controller on T-HEAD TH1520 SoC.
> There is a DesignWare USB3 DRD core in TH1520 SoCs, the dwc3 core is
> the child of this USB wrapper module device.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  MAINTAINERS                   |   1 +
>  drivers/usb/dwc3/Kconfig      |   9 +++
>  drivers/usb/dwc3/Makefile     |   1 +
>  drivers/usb/dwc3/dwc3-thead.c | 119 ++++++++++++++++++++++++++++++++++
>  4 files changed, 130 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-thead.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..d55e40060c46 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18481,6 +18481,7 @@ M:	Fu Wei <wefu@redhat.com>
>  L:	linux-riscv@lists.infradead.org
>  S:	Maintained
>  F:	arch/riscv/boot/dts/thead/
> +F:	drivers/usb/dwc3/dwc3-thead.c
>  
>  RNBD BLOCK DRIVERS
>  M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 98efcbb76c88..1b02f4f55b47 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -178,4 +178,13 @@ config USB_DWC3_OCTEON
>  	  Only the host mode is currently supported.
>  	  Say 'Y' or 'M' here if you have one such device.
>  
> +config USB_DWC3_THEAD
> +	tristate "T-HEAD Platform"
> +	depends on ARCH_THEAD || COMPILE_TEST
> +	default USB_DWC3
> +	help
> +	  Support T-HEAD platform with DesignWare Core USB3 IP.
> +	  Only the host mode is currently supported.
> +	  Say 'Y' or 'M' here if you have one such device.
> +
>  endif
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index fe1493d4bbe5..9523a51dd279 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -55,3 +55,4 @@ obj-$(CONFIG_USB_DWC3_QCOM)		+= dwc3-qcom.o
>  obj-$(CONFIG_USB_DWC3_IMX8MP)		+= dwc3-imx8mp.o
>  obj-$(CONFIG_USB_DWC3_XILINX)		+= dwc3-xilinx.o
>  obj-$(CONFIG_USB_DWC3_OCTEON)		+= dwc3-octeon.o
> +obj-$(CONFIG_USB_DWC3_THEAD)		+= dwc3-thead.o
> diff --git a/drivers/usb/dwc3/dwc3-thead.c b/drivers/usb/dwc3/dwc3-thead.c
> new file mode 100644
> index 000000000000..999b1e319c72
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-thead.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dwc3-thead.c - T-HEAD platform specific glue layer
> + *
> + * Inspired by dwc3-of-simple.c
> + *
> + * Copyright (C) 2021 Alibaba Group Holding Limited.
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "core.h"
> +
> +#define USB_SSP_EN		0x34
> +#define  REF_SSP_EN		BIT(0)
> +#define USB_SYS			0x3c
> +#define  COMMONONN		BIT(0)
> +
> +#define USB3_DRD_SWRST		0x14
> +#define  USB3_DRD_PRST		BIT(0)
> +#define  USB3_DRD_PHYRST	BIT(1)
> +#define  USB3_DRD_VCCRST	BIT(2)
> +#define  USB3_DRD_RSTMASK	(USB3_DRD_PRST | USB3_DRD_PHYRST | USB3_DRD_VCCRST)
> +
> +struct dwc3_thead {
> +	void __iomem		*base;
> +	struct regmap		*misc_sysreg;
> +	struct regulator	*vbus;
> +};
> +
> +static void dwc3_thead_optimize_power(struct dwc3_thead *thead)
> +{
> +	u32 val;
> +
> +	/* config usb top within USB ctrl & PHY reset */
> +	regmap_update_bits(thead->misc_sysreg, USB3_DRD_SWRST,
> +			   USB3_DRD_RSTMASK, USB3_DRD_PRST);
> +
> +	/*
> +	 * dwc reg also need to be configed to save power
> +	 * 1. set USB_SYS[COMMONONN]
> +	 * 2. set DWC3_GCTL[SOFITPSYNC](done by core.c)
> +	 * 3. set GUSB3PIPECTL[SUSPENDEN] (done by core.c)
> +	 */
> +	val = readl(thead->base + USB_SYS);
> +	val |= COMMONONN;
> +	writel(val, thead->base + USB_SYS);
> +	val = readl(thead->base + USB_SSP_EN);
> +	val |= REF_SSP_EN;
> +	writel(val, thead->base + USB_SSP_EN);
> +
> +	regmap_update_bits(thead->misc_sysreg, USB3_DRD_SWRST,
> +			   USB3_DRD_RSTMASK, USB3_DRD_RSTMASK);
> +}
> +
> +static int dwc3_thead_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct dwc3_thead *thead;
> +	int ret;
> +
> +	thead = devm_kzalloc(&pdev->dev, sizeof(*thead), GFP_KERNEL);
> +	if (!thead)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, thead);

No need to set driver data, since you never access it.

> +
> +	ret = devm_regulator_get_enable_optional(dev, "vbus");
> +	if (ret < 0 && ret != -ENODEV)
> +		return ret;

If you want to ignore -ENODEV, use the non-_optional variant.

> +
> +	thead->misc_sysreg = syscon_regmap_lookup_by_phandle(np, "thead,misc-sysreg");
> +	if (IS_ERR(thead->misc_sysreg))
> +		return PTR_ERR(thead->misc_sysreg);
> +
> +	thead->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(thead->base))
> +		return PTR_ERR(thead->base);
> +
> +	dwc3_thead_optimize_power(thead);
> +
> +	return of_platform_populate(np, NULL, NULL, dev);

Using devm_of_platform_populate() will avoid the .remove_new hook.

Regards,
Samuel

> +}
> +
> +static void dwc3_thead_remove(struct platform_device *pdev)
> +{
> +	of_platform_depopulate(&pdev->dev);
> +}
> +
> +static const struct of_device_id dwc3_thead_of_match[] = {
> +	{ .compatible = "thead,th1520-usb" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, dwc3_thead_of_match);
> +
> +static struct platform_driver dwc3_thead_driver = {
> +	.probe		= dwc3_thead_probe,
> +	.remove_new	= dwc3_thead_remove,
> +	.driver		= {
> +		.name	= "dwc3-thead",
> +		.of_match_table	= dwc3_thead_of_match,
> +	},
> +};
> +module_platform_driver(dwc3_thead_driver);
> +
> +MODULE_ALIAS("platform:dwc3-thead");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("DesignWare DWC3 T-HEAD Glue Driver");
> +MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");

