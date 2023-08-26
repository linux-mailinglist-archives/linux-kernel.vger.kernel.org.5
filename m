Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D032D789919
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjHZUlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjHZUk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 16:40:59 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E04E50;
        Sat, 26 Aug 2023 13:40:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ffa94a7a47so3075766e87.1;
        Sat, 26 Aug 2023 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693082455; x=1693687255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EvG4wr4iVEOqhfUZzSb/rbAgbd3Kb/9kFhAnVt5rwHk=;
        b=dzcLr8lM4n5dq3VrJTw/OlM2ANfWWa/Tqs9YtwEqBY0yAtQ2dX8mSaTTiPo3v/oipD
         v3n8A6S9Zbld3Kj3dkKNheL+xFZY3/x6d7q66ZeCGvv0W+ukIIxHl0zY5hdAleYJOVTW
         k3xF7EULH1d8pFaUKZRnnGSlF7YRiBcrg+gflMz5o3axgEFDWk+ZnZzYuceE3OIfCD3w
         kZx/Hav14vM/NPWsPna5GOuI/ZWfrIiLVOeDNYiXe7BaoApKQUOTchplTCPuS2enJcix
         UoiqxxOm6fjE8pq3U2JKqlai5vVRbIxH7Mv7npFpeHa9616zgLJcmVOLjpXpvSVTQMbc
         q4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693082455; x=1693687255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvG4wr4iVEOqhfUZzSb/rbAgbd3Kb/9kFhAnVt5rwHk=;
        b=Pb2m1yWX29PizNA2V2oDF+fZXt68o8Z83HWDbaLH58sdVpKjKvO3cxDEVCZ5pae3uM
         Apir/rJLZgt2HRVZR/9jICuyC+rbDuoMfTPn/D2F2aJyklgojBiSGSmwhH9WOxazcCJV
         SM+UDuiAQM6uzUQuVyDQn+d3SS+lPQpvCm/C3czFyVT4PXSt18Zomk4mJLay7llST1w7
         tMuQO5EVNEwGWaLmQ05R2Waba2m5rbugJCZgiKNu3kAoJAQK2lO/ATxbtv1GUWEjWlq8
         lbQ1VEbi8c3TTj/EsYL2QQO2xrIfKFo3AogFDxUdwbPzSvLEg5qXYnwHMSeyAMLSyk9i
         5Eow==
X-Gm-Message-State: AOJu0Yx/3+zob1KU3tTx/X+5lAo5BxntrIOaHXDWWVDjGpAHkzkzsgef
        wnyxmcfknn7k+uldhbecVX8=
X-Google-Smtp-Source: AGHT+IHKnx/jrbpmi6HUdQjO6eVO23NAjYtT85NNpJDXainqmB71ji74epTI3vz2D8Quskw9Wca82g==
X-Received: by 2002:a05:6512:34c6:b0:4fe:1dc8:7ec with SMTP id w6-20020a05651234c600b004fe1dc807ecmr12777646lfr.37.1693082454161;
        Sat, 26 Aug 2023 13:40:54 -0700 (PDT)
Received: from mobilestation ([95.79.200.178])
        by smtp.gmail.com with ESMTPSA id i1-20020a056512006100b004ff9ee35739sm837500lfo.283.2023.08.26.13.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 13:40:53 -0700 (PDT)
Date:   Sat, 26 Aug 2023 23:40:51 +0300
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
Subject: Re: [PATCH v3 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
Message-ID: <c3k77fijjiq6osz53jbryulm77f2hmmk6jpiptzthokuzg4tpt@d7h6x7a3dbdg>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-4-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824125012.1040288-4-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:50:11PM +0800, Keguang Zhang wrote:
> This glue driver is created based on the arch-code
> implemented earlier with the platform-specific settings.
> 
> Use syscon for SYSCON register access.
> 
> Partially based on the previous work by Serge Semin.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
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
>  .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 240 ++++++++++++++++++
>  3 files changed, 252 insertions(+)
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
> index 000000000000..347d842141e4
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> @@ -0,0 +1,240 @@
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
> +#define LS1X_GMAC0_BASE		(0xe10000)

> +#define LS1X_GMAC1_BASE		(0xe20000)

If LS1C doesn't have the second GMAC then what about changing the
macros name to LS1B_GMAC1_BASE?

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

IMO having the SoC-specific prefixes (LS1B_ and LS1C_) in these names
would make the driver a bit more readable. But it's up to you to
decide.

> +#define PHY_INTF_SELI_SHIFT	28

Use FIELD_PREP():
#define PHY_INTF_MII			FIELD_PREP(PHY_INTF_SELI, 0)
#define PHY_INTF_RMII			FIELD_PREP(PHY_INTF_SELI, 4)

> +
> +struct ls1x_dwmac_syscon {
> +	int (*syscon_init)(struct plat_stmmacenet_data *plat);
> +};

This struct is redundant. See further for details.

> +
> +struct ls1x_dwmac {

> +	unsigned long reg_base;

this field

> +	struct device *dev;

> +	struct plat_stmmacenet_data *plat_dat;
> +	const struct ls1x_dwmac_syscon *syscon;

and these fields are also redundant. See further for details.

> +	struct regmap *regmap;
> +};
> +
> +static int ls1b_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
> +{
> +	struct ls1x_dwmac *dwmac = plat->bsp_priv;
> +	struct regmap *regmap = dwmac->regmap;
> +

> +	if ((dwmac->reg_base & LS1X_GMAC0_BASE) == LS1X_GMAC0_BASE) {

Is it necessary to bitwise-and-ing? What if LS1X_GMAC0_BASE would be
just a full physical base address? Then you'll be able to just compare
the base addresses.

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
> +			dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
> +				plat->phy_interface);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		regmap_update_bits(regmap, LS1X_SYSCON0, GMAC0_SHUT, 0);

> +	}
> +
> +	if ((dwmac->reg_base & LS1X_GMAC1_BASE) == LS1X_GMAC1_BASE) {

else if?

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
> +			dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
> +				plat->phy_interface);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		regmap_update_bits(regmap, LS1X_SYSCON1, GMAC1_SHUT, 0);

> +	}

else {
	dev_err(...)
	return -EINVAL;
}
?

* unless you have some more DW GMACs on the SoC which don't require the
syscon setups.

> +
> +	return 0;
> +}
> +
> +static int ls1c_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
> +{
> +	struct ls1x_dwmac *dwmac = plat->bsp_priv;
> +	struct regmap *regmap = dwmac->regmap;
> +
> +	switch (plat->phy_interface) {
> +	case PHY_INTERFACE_MODE_MII:

> +		regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI, 0);


		regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI,
				   PHY_INTF_MII);

> +		break;
> +	case PHY_INTERFACE_MODE_RMII:

> +		regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI,
> +				   4 << PHY_INTF_SELI_SHIFT);

		regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI,
				   PHY_INTF_RMII);

> +		break;
> +	default:
> +		dev_err(dwmac->dev, "Unsupported PHY-mode %u\n",
> +			plat->phy_interface);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	regmap_update_bits(regmap, LS1X_SYSCON0, GMAC0_SHUT, 0);
> +
> +	return 0;
> +}
> +

> +static const struct ls1x_dwmac_syscon ls1b_dwmac_syscon = {
> +	.syscon_init = ls1b_dwmac_syscon_init,
> +};
> +
> +static const struct ls1x_dwmac_syscon ls1c_dwmac_syscon = {
> +	.syscon_init = ls1c_dwmac_syscon_init,
> +};

This can be dropped. See the next comment for details.

> +
> +static int ls1x_dwmac_init(struct platform_device *pdev, void *priv)
> +{
> +	struct ls1x_dwmac *dwmac = priv;
> +	struct resource *res;
> +	int ret;
> +

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Could not get IO_MEM resources\n");
> +		return -EINVAL;
> +	}
> +	dwmac->reg_base = (unsigned long)res->start;

What about moving this to ls1b_dwmac_syscon_init() seeing it's used
for LS1B only? Thus you won't need to have the reg_base defined in the
private data and can get rid from the ls1x_dwmac_init() method setting
the ls1b_dwmac_syscon_init() and ls1c_dwmac_syscon_init() pointers
directly to the device match data.

> +
> +	if (dwmac->syscon->syscon_init) {
> +		ret = dwmac->syscon->syscon_init(dwmac->plat_dat);
> +		if (ret)
> +			return ret;
> +	}
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

> +	const struct ls1x_dwmac_syscon *syscon;

This can be replaced with just
int (*init)(struct platform_device *pdev, void *priv);

> +	int ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return ret;
> +
> +	/* Probe syscon */
> +	regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +						 "loongson,ls1-syscon");
> +	if (IS_ERR(regmap)) {

> +		ret = PTR_ERR(regmap);
> +		dev_err(&pdev->dev, "Unable to map syscon: %d\n", ret);
> +		return ret;

return dev_err_probe(&pdev->dev, PTR_ERR(regmap), "Unable to find syscon\n");

> +	}
> +

> +	syscon = of_device_get_match_data(&pdev->dev);

init = of_device_get_match_data(&pdev->dev);

> +	if (!syscon) {
> +		dev_err(&pdev->dev, "No of match data provided\n");
> +		return -EINVAL;
> +	}
> +
> +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> +	if (!dwmac)
> +		return -ENOMEM;
> +
> +	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat_dat)) {
> +		dev_err(&pdev->dev, "dt configuration failed\n");
> +		return PTR_ERR(plat_dat);
> +	}
> +
> +	plat_dat->bsp_priv = dwmac;

> +	plat_dat->init = ls1x_dwmac_init;

plat_dat->init = init;

> +	dwmac->dev = &pdev->dev;
> +	dwmac->plat_dat = plat_dat;
> +	dwmac->syscon = syscon;
> +	dwmac->regmap = regmap;
> +
> +	ret = stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
> +	if (ret)
> +		goto err_remove_config_dt;
> +
> +	return 0;
> +
> +err_remove_config_dt:
> +	stmmac_remove_config_dt(pdev, plat_dat);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id ls1x_dwmac_match[] = {

> +	{ .compatible = "loongson,ls1b-gmac", .data = &ls1b_dwmac_syscon, },
> +	{ .compatible = "loongson,ls1c-emac", .data = &ls1c_dwmac_syscon, },

{ .compatible = "loongson,ls1b-gmac", .data = &ls1b_dwmac_syscon_init, },
{ .compatible = "loongson,ls1c-emac", .data = &ls1c_dwmac_syscon_init, },

Thus you can simplify the driver by:
1. dropping ls1x_dwmac_syscon definition and its instances.
2. dropping three redundant fields from the ls1x_dwmac structure.
3. dropping the ls1x_dwmac_init() method.
Sounds like worth it.)

Note if no further driver update is planned then you can drop the
ls1x_dwmac->dev field too. Otherwise you can keep it seeing some of
the plat_stmmacenet_data data callbacks do have any device instance
passed.

-Serge(y)

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ls1x_dwmac_match);
> +
> +static struct platform_driver ls1x_dwmac_driver = {
> +	.probe = ls1x_dwmac_probe,
> +	.remove_new = stmmac_pltfr_remove,
> +	.driver = {
> +		.name = "loongson1-dwmac",
> +		.of_match_table = ls1x_dwmac_match,
> +	},
> +};
> +module_platform_driver(ls1x_dwmac_driver);
> +
> +MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
> +MODULE_DESCRIPTION("Loongson1 DWMAC glue layer");
> +MODULE_LICENSE("GPL");
> -- 
> 2.39.2
> 
> 
