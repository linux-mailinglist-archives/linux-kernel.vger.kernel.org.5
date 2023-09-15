Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CD57A1B92
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjIOKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbjIOKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:00:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E323C14;
        Fri, 15 Sep 2023 02:57:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-502defbb0c3so3309920e87.0;
        Fri, 15 Sep 2023 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771843; x=1695376643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rbpN2Ho6gZz+bg7rv1Ni5awvz2WgkEY58LCWW52O/G4=;
        b=LT87BZc9RW2Egvti9Tesi1ouNE6XecN6h/Acm8DJp8qLeZWVmjf+zoSriISz9nDmVc
         L/aDDOZmR7IGFnqxUI+NwRyAYrDvSg6P9ByKZ8i3hd+5rkPue3g+kxIzPjjHbL3TI5BB
         jYo+6iIAsgJubrZkINfsTWNno4y//9gHurtCe/WKzweYlDrrHMPTmzWuXjd/TByO242K
         8JiA2RVSBn3ABcg2YbGFSUnMgd586CfSW8r+e+tTcV1ObMqI+pghgkBfeD3KxW+JTBuL
         JzouqOgEz3BTSboP6QWN4PSXH0LZAVeGxSRRceqTLRifjAaafOOWsFnEqTHlaBhjxMfo
         jcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771843; x=1695376643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbpN2Ho6gZz+bg7rv1Ni5awvz2WgkEY58LCWW52O/G4=;
        b=oEoaiepiqHtb9dlQZM1D1sUDoofxsT6cUefixCyMjEE/RJati+uHE/4Bq85jTZrG4X
         wpSDRj8wyz8eSI2nRpqoW46PQVz6uBnIf1nSRjp8HfJsJ/6STnxCuxW5uD9gDulTMJB1
         FCAwcHSDLokPbA6ClqAPf7pJ5h+m266IvN7fOLo8d8B15+UuFwKgXARUE4crWHig3CaP
         pEijOJoXBYVMVVuqoDLhoqEiDGbVzn2hWx/H6l/W1HaI4Q8d3/nkm/j8uBOS5M2pzDA+
         4Az/7LU0Y2FcfxwH6/la0oTLCssFm019A2DWBMD7b+NGgUbyIn/LQ3sTOyzCEKhoie7+
         g9TA==
X-Gm-Message-State: AOJu0YyD5vGSv4GekHTyXQg7A4eGLPTCx64U5LOkaQwVbtBpmYjyJd2Q
        OPABVcZQZYOWB9F19ahJ2P4=
X-Google-Smtp-Source: AGHT+IH15RoWDqQKC7/XFJYf4pZr+2QRb6MA8O/Rr033sqFSZ+UoHtgT2rNuzO5Ej35UpOpFnIVetg==
X-Received: by 2002:a05:6512:3f11:b0:4ff:9bd9:f69a with SMTP id y17-20020a0565123f1100b004ff9bd9f69amr1214496lfa.65.1694771842514;
        Fri, 15 Sep 2023 02:57:22 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id n3-20020ac24903000000b005008f58228bsm579174lfi.190.2023.09.15.02.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:57:22 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:57:20 +0300
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
Subject: Re: [PATCH v5 3/3] net: stmmac: Add glue layer for Loongson-1 SoC
Message-ID: <ub3qzam3fyxghjcyxwwlmq6lbpqkohkjd2g6vlnovrtlwjovys@2n6iwa6ck2ms>
References: <20230914114435.481900-1-keguang.zhang@gmail.com>
 <20230914114435.481900-4-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914114435.481900-4-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 07:44:35PM +0800, Keguang Zhang wrote:
> This glue driver is created based on the arch-code
> implemented earlier with the platform-specific settings.
> 
> Use syscon for SYSCON register access.
> 
> And modify MAINTAINERS to add a new F: entry for this driver.
> 
> Partially based on the previous work by Serge Semin.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
> V4 -> V5: Replace stmmac_probe_config_dt() with devm_stmmac_probe_config_dt()
>           Replace stmmac_pltfr_probe() with devm_stmmac_pltfr_probe()
>           Add a new F: entry for this driver.
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
>  MAINTAINERS                                   |   1 +
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 209 ++++++++++++++++++
>  4 files changed, 222 insertions(+)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e514b53fb225..b71aff479a8c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14383,6 +14383,7 @@ F:	Documentation/devicetree/bindings/*/loongson,ls1*.yaml
>  F:	arch/mips/include/asm/mach-loongson32/
>  F:	arch/mips/loongson32/
>  F:	drivers/*/*loongson1*
> +F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
>  
>  MIPS/LOONGSON2EF ARCHITECTURE
>  M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
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
> index 000000000000..3e86810717d3
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> @@ -0,0 +1,209 @@
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
> +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat_dat))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
> +				     "dt configuration failed\n");
> +
> +	plat_dat->bsp_priv = dwmac;
> +	plat_dat->init = init;
> +	dwmac->plat_dat = plat_dat;
> +	dwmac->regmap = regmap;
> +
> +	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
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
