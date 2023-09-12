Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD379CD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjILKMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjILKMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:12:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B210E6;
        Tue, 12 Sep 2023 03:12:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-502b1bbe5c3so4054399e87.1;
        Tue, 12 Sep 2023 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694513523; x=1695118323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwR4S+bOEUasIfylPWTpEe9JF1kQkAvfhzdUk7480GQ=;
        b=F5OIB4B4hL8Yq+WwIHqDB4xxPLnXN20rJGwu+3ac8JvdV/2roDzNLxRMQWRGbiyfeB
         /KSa2PsSh6+GgpIeH6yp4RlR+fZy+Amu6LWomBjJZnjGtUxJNOSIr4acgHhnrpczNm5C
         xKgkA9XVFJonjmyY1OVz56F5lDG/C3mQR4Uw8M4tATkKTjH1aIzzsbAkRNH543KskYFb
         uiXBd7V1z03V7pjzu58ZxL4G3oZGxqsWmi262O+wN3ndqiP6/TiK7rH4RMzlZ9RqMdrl
         JhY6/Q2mqiT3N5AwGmcTp8DWArkGEbqjdNwZf6JZfHL5Fo+2B4TIQwGo0QmvU1Vgjo28
         ntBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513523; x=1695118323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwR4S+bOEUasIfylPWTpEe9JF1kQkAvfhzdUk7480GQ=;
        b=K+YaY/PMe/h2cMabtEs9TFCgkGM+6NNdu78ZH0WTFPsjqPtEtQ0fHTOIRiGOU8Lx2I
         dMd46E7i4MNeL61Hg86gSSvDEkOfxn+rRi4CIaiOUtYEbn/8d/Fh8scRUgzMdrfFRoQH
         5gjJyBpN2YjLI3YpRyAgGH78PoPeBtbWP/ALLAteJkCKtJoi+LIM1YTYNjxItFRjfgz6
         xmVepDAv7MaTU/hucWJsBvwoIOBDOroajLE/y1Ls8yL5lwn6NSZ1ZGphwXb81+achPwS
         3H2FW94wKQlddVNfQTjxEQ6hahEjPgn+BwuUjcNr7Oo1Q4N+fz+JBrvDG5IdEzDX9uCt
         cKGg==
X-Gm-Message-State: AOJu0YyjcJk76DYK0P71r8MKj09aV/zdr3yBA6M5ySVNhh9JYGFZc5VU
        QJSiGfxcv5nW19ms+R7+OBQ=
X-Google-Smtp-Source: AGHT+IH9ApmnuWjCpcJLgY472BPiImQX5oeai557Qb27uwiP6zkR7/VE+NGYg3d2jfDzlft5ZP7SMw==
X-Received: by 2002:a05:6512:3a87:b0:4fb:9712:a717 with SMTP id q7-20020a0565123a8700b004fb9712a717mr12327668lfu.13.1694513522368;
        Tue, 12 Sep 2023 03:12:02 -0700 (PDT)
Received: from mobilestation ([85.249.16.222])
        by smtp.gmail.com with ESMTPSA id y10-20020ac2446a000000b004fe951827easm1668672lfl.196.2023.09.12.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:12:01 -0700 (PDT)
Date:   Tue, 12 Sep 2023 13:11:58 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v4 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
Message-ID: <g3gm6ibq6skrxjp2dkf4xkz4urjnu43oqyqrtpe7r4e4vy6jfw@rppdi3dmumlj>
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
 <20230830134241.506464-4-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830134241.506464-4-keguang.zhang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 09:42:40PM +0800, Keguang Zhang wrote:
> This glue driver is created based on the arch-code
> implemented earlier with the platform-specific settings.
> 
> Use syscon for SYSCON register access.
> 
> Partially based on the previous work by Serge Semin.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V3 -> V4: Drop ls1x_dwmac_syscon definition and its instances
>           Drop three redundant fields from the ls1x_dwmac structure
>           Drop the ls1x_dwmac_init() method.
>           Some minor improvements
> V2 -> V3: Determine the device ID by physical
>           base address(suggested by Serge Semin)
>           Use regmap instead of regmap fields
>           Use syscon_regmap_lookup_by_phandle()
>           Some minor fixes
> V1 -> V2: Fix the build errors due to CONFIG_OF being unset
>           Change struct reg_field definitions to const
>           Rename the syscon property to "loongson,dwmac-syscon"
>           Add MII PHY mode for LS1C
> 
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 219 ++++++++++++++++++
>  3 files changed, 231 insertions(+)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 06c6871f8788..a2b9e289aa36 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -239,6 +239,17 @@ config DWMAC_INTEL_PLAT
>  	  the stmmac device driver. This driver is used for the Intel Keem Bay
>  	  SoC.
>  
> +config DWMAC_LOONGSON1
> +	tristate "Loongson1 GMAC support"
> +	default MACH_LOONGSON32
> +	depends on OF && (MACH_LOONGSON32 || COMPILE_TEST)
> +	help
> +	  Support for ethernet controller on Loongson1 SoC.
> +
> +	  This selects Loongson1 SoC glue layer support for the stmmac
> +	  device driver. This driver is used for Loongson1-based boards
> +	  like Loongson LS1B/LS1C.
> +
>  config DWMAC_TEGRA
>  	tristate "NVIDIA Tegra MGBE support"
>  	depends on ARCH_TEGRA || COMPILE_TEST
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index 5b57aee19267..80e598bd4255 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_DWMAC_SUNXI)	+= dwmac-sunxi.o
>  obj-$(CONFIG_DWMAC_SUN8I)	+= dwmac-sun8i.o
>  obj-$(CONFIG_DWMAC_DWC_QOS_ETH)	+= dwmac-dwc-qos-eth.o
>  obj-$(CONFIG_DWMAC_INTEL_PLAT)	+= dwmac-intel-plat.o
> +obj-$(CONFIG_DWMAC_LOONGSON1)	+= dwmac-loongson1.o
>  obj-$(CONFIG_DWMAC_GENERIC)	+= dwmac-generic.o
>  obj-$(CONFIG_DWMAC_IMX8)	+= dwmac-imx.o
>  obj-$(CONFIG_DWMAC_TEGRA)	+= dwmac-tegra.o
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> new file mode 100644
> index 000000000000..f1732f15ff87
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Loongson-1 DWMAC glue layer
> + *
> + * Copyright (C) 2011-2023 Keguang Zhang <keguang.zhang@gmail.com>
> + */
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "stmmac.h"
> +#include "stmmac_platform.h"
> +

> +#define LS1B_GMAC0_BASE		(0x1fe10000)

I was talking about the LS1B_GMAC1_BASE macro only. Since both LS1B
and LS1C have GMAC0 at the same base address I would preserve
LS1X_GMAC0_BASE name here. But seeing it's unused for the LS1C anyway
it's not that a big deal.

> +#define LS1B_GMAC1_BASE		(0x1fe20000)
> +
> +/* Loongson-1 SYSCON Registers */
> +#define LS1X_SYSCON0		(0x0)
> +#define LS1X_SYSCON1		(0x4)
> +
> +/* Loongson-1B SYSCON Register Bits */
> +#define GMAC1_USE_UART1		BIT(4)
> +#define GMAC1_USE_UART0		BIT(3)
> +
> +#define GMAC1_SHUT		BIT(13)
> +#define GMAC0_SHUT		BIT(12)
> +
> +#define GMAC1_USE_TXCLK		BIT(3)
> +#define GMAC0_USE_TXCLK		BIT(2)
> +#define GMAC1_USE_PWM23		BIT(1)
> +#define GMAC0_USE_PWM01		BIT(0)
> +
> +/* Loongson-1C SYSCON Register Bits */
> +#define GMAC_SHUT		BIT(6)
> +
> +#define PHY_INTF_SELI		GENMASK(30, 28)
> +#define PHY_INTF_MII		FIELD_PREP(PHY_INTF_SELI, 0)
> +#define PHY_INTF_RMII		FIELD_PREP(PHY_INTF_SELI, 4)
> +
> +struct ls1x_dwmac {
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct regmap *regmap;
> +};
> +
> +static int ls1b_dwmac_syscon_init(struct platform_device *pdev, void *priv)
> +{
> +	struct ls1x_dwmac *dwmac = priv;
> +	struct plat_stmmacenet_data *plat = dwmac->plat_dat;
> +	struct regmap *regmap = dwmac->regmap;
> +	struct resource *res;
> +	unsigned long reg_base;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Could not get IO_MEM resources\n");
> +		return -EINVAL;
> +	}
> +	reg_base = (unsigned long)res->start;
> +
> +	if (reg_base == LS1B_GMAC0_BASE) {
> +		switch (plat->phy_interface) {
> +		case PHY_INTERFACE_MODE_RGMII_ID:
> +			regmap_update_bits(regmap, LS1X_SYSCON0,
> +					   GMAC0_USE_TXCLK | GMAC0_USE_PWM01,
> +					   0);
> +			break;
> +		case PHY_INTERFACE_MODE_MII:
> +			regmap_update_bits(regmap, LS1X_SYSCON0,
> +					   GMAC0_USE_TXCLK | GMAC0_USE_PWM01,
> +					   GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
> +			break;
> +		default:
> +			dev_err(&pdev->dev, "Unsupported PHY mode %u\n",
> +				plat->phy_interface);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		regmap_update_bits(regmap, LS1X_SYSCON0, GMAC0_SHUT, 0);
> +	} else if (reg_base == LS1B_GMAC1_BASE) {
> +		regmap_update_bits(regmap, LS1X_SYSCON0,
> +				   GMAC1_USE_UART1 | GMAC1_USE_UART0,
> +				   GMAC1_USE_UART1 | GMAC1_USE_UART0);
> +
> +		switch (plat->phy_interface) {
> +		case PHY_INTERFACE_MODE_RGMII_ID:
> +			regmap_update_bits(regmap, LS1X_SYSCON1,
> +					   GMAC1_USE_TXCLK | GMAC1_USE_PWM23,
> +					   0);
> +
> +			break;
> +		case PHY_INTERFACE_MODE_MII:
> +			regmap_update_bits(regmap, LS1X_SYSCON1,
> +					   GMAC1_USE_TXCLK | GMAC1_USE_PWM23,
> +					   GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
> +			break;
> +		default:
> +			dev_err(&pdev->dev, "Unsupported PHY mode %u\n",
> +				plat->phy_interface);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		regmap_update_bits(regmap, LS1X_SYSCON1, GMAC1_SHUT, 0);
> +	} else {
> +		dev_err(&pdev->dev, "Invalid Ethernet MAC base address %lx",
> +			reg_base);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ls1c_dwmac_syscon_init(struct platform_device *pdev, void *priv)
> +{
> +	struct ls1x_dwmac *dwmac = priv;
> +	struct plat_stmmacenet_data *plat = dwmac->plat_dat;
> +	struct regmap *regmap = dwmac->regmap;
> +
> +	switch (plat->phy_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI,
> +				   PHY_INTF_MII);
> +		break;
> +	case PHY_INTERFACE_MODE_RMII:
> +		regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI,
> +				   PHY_INTF_RMII);
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "Unsupported PHY-mode %u\n",
> +			plat->phy_interface);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	regmap_update_bits(regmap, LS1X_SYSCON0, GMAC0_SHUT, 0);
> +
> +	return 0;
> +}
> +
> +static int ls1x_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct stmmac_resources stmmac_res;
> +	struct regmap *regmap;
> +	struct ls1x_dwmac *dwmac;
> +	int (*init)(struct platform_device *pdev, void *priv);
> +	int ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return ret;
> +
> +	/* Probe syscon */
> +	regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +						 "loongson,ls1-syscon");
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(regmap),
> +				     "Unable to find syscon\n");
> +
> +	init = of_device_get_match_data(&pdev->dev);
> +	if (!init) {
> +		dev_err(&pdev->dev, "No of match data provided\n");
> +		return -EINVAL;
> +	}
> +
> +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> +	if (!dwmac)
> +		return -ENOMEM;
> +

> +	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);

This can be replaced with devm_stmmac_probe_config_dt() and ...

> +	if (IS_ERR(plat_dat))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
> +				     "dt configuration failed\n");
> +
> +	plat_dat->bsp_priv = dwmac;
> +	plat_dat->init = init;
> +	dwmac->plat_dat = plat_dat;
> +	dwmac->regmap = regmap;
> +

> +	ret = stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);

... this can be replaced with devm_stmmac_pltfr_probe() thus ...

> +	if (ret)
> +		goto err_remove_config_dt;
> +
> +	return 0;
> +

> +err_remove_config_dt:
> +	stmmac_remove_config_dt(pdev, plat_dat);
> +
> +	return ret;

... this could have been omitted and ...

> +}
> +
> +static const struct of_device_id ls1x_dwmac_match[] = {
> +	{
> +		.compatible = "loongson,ls1b-gmac",
> +		.data = &ls1b_dwmac_syscon_init,
> +	},
> +	{
> +		.compatible = "loongson,ls1c-emac",
> +		.data = &ls1c_dwmac_syscon_init,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ls1x_dwmac_match);
> +
> +static struct platform_driver ls1x_dwmac_driver = {
> +	.probe = ls1x_dwmac_probe,

> +	.remove_new = stmmac_pltfr_remove,

... this could have been dropped.

-Serge(y)

> +	.driver = {
> +		.name = "loongson1-dwmac",
> +		.of_match_table = ls1x_dwmac_match,
> +	},
> +};
> +module_platform_driver(ls1x_dwmac_driver);
> +
> +MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
> +MODULE_DESCRIPTION("Loongson-1 DWMAC glue layer");
> +MODULE_LICENSE("GPL");
> -- 
> 2.39.2
> 
> 
