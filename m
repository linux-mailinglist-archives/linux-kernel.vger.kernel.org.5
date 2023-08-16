Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139F377E29E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245561AbjHPNbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245555AbjHPNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:30:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC0E1BFB;
        Wed, 16 Aug 2023 06:30:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ff9121fd29so1023345e87.3;
        Wed, 16 Aug 2023 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692192651; x=1692797451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1La09uYnQwF+ELqGB0y6QxP4PF0DZTy5Vy26QkMl9BA=;
        b=ALxkeDw+Y87a5F/shZw4aJqTAc3jtVqFjA9Df5B6CQZao+LqtAjQFe7/W/d5LKzoiR
         MNpAi1bOLSjb4OyHsc5LSXETqFHKIXGTzj9M+rTP9z1s8iqYDbF0t8YXi83a1Paj9kbC
         i2oGuZezl9wyG7zrWDqtk8bOD5GCKyZOnwHozyOW90hqH4BcuucUyd9ZHcDTIcqPhop8
         M9Ga2RTMgZs858W6VARk5PdAioD2AelZQMDqwxx8fI0wzroe2BcjBGNktOdurHbe/REd
         qdkILszWgjBhDUoczFKhB2orbvdlOUqu8n1YCM0OC5wI0fJNdX1rZtZpydhqCFHhKSEW
         N0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692192651; x=1692797451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1La09uYnQwF+ELqGB0y6QxP4PF0DZTy5Vy26QkMl9BA=;
        b=NoE6uQa6shg8yLePVt0zIy/pO8y1qDHmyeDBXFvCPJjFeltioX7d4k2ZWYJMe+tpCA
         U6sJ+dnCWFU9B3KWLLPKxryZkUU2TbKOUtGNXaGlwYmG39DZLJ4btH9rhz3NGKtkula1
         I+OsphX6abSzmeBs7BMav3+xiqAx4SLbRfkDp15GTFyOMYIkLJMILT8x7Rvk35rzU0PR
         CHHye/5XFf+msvaOAhiMKJbFNqKJ0jABi8gNggh4mKtI/B4lKP2MN7ylfJ57liSXRejv
         rwxaPYQd8E9jPaYtiFRTfEKfIAoMKnGBW3W/9R+B2i25iKKEmkorc1PU5pJpfuiI6bBR
         wlQg==
X-Gm-Message-State: AOJu0Yzu936L4CQ8uhh774Tfx4DtR3PYDrAQ6cuC/PXy7IsYIk3LnBg2
        dT7gE8jqQ/FiSKGGxDYYRzg=
X-Google-Smtp-Source: AGHT+IFyGJN0/eJQGGcNn73G2qxKM72Oy0p2q1cP0Lij4A1TPrtFp6fUcieBnvXZOo/SjeuIeJE0hA==
X-Received: by 2002:ac2:5bdb:0:b0:4fb:9497:b2a5 with SMTP id u27-20020ac25bdb000000b004fb9497b2a5mr1382324lfn.21.1692192650310;
        Wed, 16 Aug 2023 06:30:50 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id p22-20020ac246d6000000b004fe1cd8201bsm2933285lfo.133.2023.08.16.06.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:30:49 -0700 (PDT)
Date:   Wed, 16 Aug 2023 16:30:46 +0300
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
Subject: Re: [PATCH 4/5] net: stmmac: Add glue layer for Loongson-1 SoC
Message-ID: <spt2blizwad4tdp4cjf7bzffd3mr6456nlz4c4vgjrblx34gqj@bkwhyeqph4do>
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
 <20230812151135.1028780-5-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812151135.1028780-5-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 11:11:34PM +0800, Keguang Zhang wrote:
> This glue driver is created based on the arch-code
> implemented earlier with the platform-specific settings.
> 
> Use syscon for SYSCON register access.
> 
> Partialy based on the previous work by Serge Semin.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>  .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 257 ++++++++++++++++++
>  3 files changed, 269 insertions(+)
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
> index 000000000000..368d6cd2cb78
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> @@ -0,0 +1,257 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Loongson-1 DWMAC glue layer
> + *
> + * Copyright (C) 2011-2023 Keguang Zhang <keguang.zhang@gmail.com>
> + */
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "stmmac.h"
> +#include "stmmac_platform.h"
> +
> +/* Loongson-1 SYSCON Registers */
> +#define LS1X_SYSCON0		(0x0)
> +#define LS1X_SYSCON1		(0x4)
> +
> +struct ls1x_dwmac_syscon {
> +	const struct reg_field *reg_fields;
> +	unsigned int nr_reg_fields;
> +	int (*syscon_init)(struct plat_stmmacenet_data *plat);
> +};
> +
> +struct ls1x_dwmac {
> +	struct device *dev;
> +	struct plat_stmmacenet_data *plat_dat;
> +	const struct ls1x_dwmac_syscon *syscon;
> +	struct regmap *regmap;
> +	struct regmap_field *regmap_fields[];
> +};
> +
> +enum ls1b_dwmac_syscon_regfield {
> +	GMAC1_USE_UART1,
> +	GMAC1_USE_UART0,
> +	GMAC1_SHUT,
> +	GMAC0_SHUT,
> +	GMAC1_USE_TXCLK,
> +	GMAC0_USE_TXCLK,
> +	GMAC1_USE_PWM23,
> +	GMAC0_USE_PWM01,
> +};
> +
> +enum ls1c_dwmac_syscon_regfield {
> +	GMAC_SHUT,
> +	PHY_INTF_SELI,
> +};
> +
> +const struct reg_field ls1b_dwmac_syscon_regfields[] = {
> +	[GMAC1_USE_UART1]	= REG_FIELD(LS1X_SYSCON0, 4, 4),
> +	[GMAC1_USE_UART0]	= REG_FIELD(LS1X_SYSCON0, 3, 3),
> +	[GMAC1_SHUT]		= REG_FIELD(LS1X_SYSCON1, 13, 13),
> +	[GMAC0_SHUT]		= REG_FIELD(LS1X_SYSCON1, 12, 12),
> +	[GMAC1_USE_TXCLK]	= REG_FIELD(LS1X_SYSCON1, 3, 3),
> +	[GMAC0_USE_TXCLK]	= REG_FIELD(LS1X_SYSCON1, 2, 2),
> +	[GMAC1_USE_PWM23]	= REG_FIELD(LS1X_SYSCON1, 1, 1),
> +	[GMAC0_USE_PWM01]	= REG_FIELD(LS1X_SYSCON1, 0, 0)
> +};
> +
> +const struct reg_field ls1c_dwmac_syscon_regfields[] = {
> +	[GMAC_SHUT]		= REG_FIELD(LS1X_SYSCON0, 6, 6),
> +	[PHY_INTF_SELI]		= REG_FIELD(LS1X_SYSCON1, 28, 30)
> +};

Emm, using regmap fields looks so over-complicated in this case seeing
you only need to set/clear several bits in the syscon. What about
defining macros with the particular flag as it's already done in the
"asm/mach-loongson32/regs-mux.h" file and using regmap_update_bits()?

> +

> +static int ls1b_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
> +{

As I already told you this part is better to be called from the
plat_stmmacenet_data.fix_mac_speed() because PHY interface mode can
differ from one interface open cycle to another as per the phylink
design.

> +	struct ls1x_dwmac *dwmac = plat->bsp_priv;
> +	struct regmap_field **regmap_fields = dwmac->regmap_fields;
> +

> +	if (plat->bus_id) {

Using bus_id doesn't look correct to determine the CSRs responsible
for the interface mode selection because it's calculated based on the
DT ethernet-alias which doesn't guarantee to have a particular device
assigned with the alias. Alias node can be absent after all. What
could be better in this case is for instance to use the regs physical
address. Any better idea?

> +		regmap_field_write(regmap_fields[GMAC1_USE_UART1], 1);
> +		regmap_field_write(regmap_fields[GMAC1_USE_UART0], 1);
> +
> +		switch (plat->phy_interface) {
> +		case PHY_INTERFACE_MODE_RGMII:
> +			regmap_field_write(regmap_fields[GMAC1_USE_TXCLK], 0);
> +			regmap_field_write(regmap_fields[GMAC1_USE_PWM23], 0);
> +			break;
> +		case PHY_INTERFACE_MODE_MII:
> +			regmap_field_write(regmap_fields[GMAC1_USE_TXCLK], 1);
> +			regmap_field_write(regmap_fields[GMAC1_USE_PWM23], 1);
> +			break;
> +		default:
> +			dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
> +				plat->phy_interface);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		regmap_field_write(regmap_fields[GMAC1_SHUT], 0);
> +	} else {
> +		switch (plat->phy_interface) {
> +		case PHY_INTERFACE_MODE_RGMII:
> +			regmap_field_write(regmap_fields[GMAC0_USE_TXCLK], 0);
> +			regmap_field_write(regmap_fields[GMAC0_USE_PWM01], 0);
> +			break;
> +		case PHY_INTERFACE_MODE_MII:
> +			regmap_field_write(regmap_fields[GMAC0_USE_TXCLK], 1);
> +			regmap_field_write(regmap_fields[GMAC0_USE_PWM01], 1);
> +			break;
> +		default:
> +			dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
> +				plat->phy_interface);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		regmap_field_write(regmap_fields[GMAC0_SHUT], 0);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ls1c_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
> +{
> +	struct ls1x_dwmac *dwmac = plat->bsp_priv;
> +	struct regmap_field **regmap_fields = dwmac->regmap_fields;
> +
> +	if (plat->phy_interface == PHY_INTERFACE_MODE_RMII) {
> +		regmap_field_write(regmap_fields[PHY_INTF_SELI], 0x4);
> +	} else {
> +		dev_err(dwmac->dev, "Unsupported PHY-mode %u\n",
> +			plat->phy_interface);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	regmap_field_write(regmap_fields[GMAC_SHUT], 0);
> +
> +	return 0;
> +}
> +
> +static const struct ls1x_dwmac_syscon ls1b_dwmac_syscon = {
> +	.reg_fields = ls1b_dwmac_syscon_regfields,
> +	.nr_reg_fields = ARRAY_SIZE(ls1b_dwmac_syscon_regfields),
> +	.syscon_init = ls1b_dwmac_syscon_init,
> +};
> +
> +static const struct ls1x_dwmac_syscon ls1c_dwmac_syscon = {
> +	.reg_fields = ls1c_dwmac_syscon_regfields,
> +	.nr_reg_fields = ARRAY_SIZE(ls1c_dwmac_syscon_regfields),
> +	.syscon_init = ls1c_dwmac_syscon_init,
> +};
> +
> +static int ls1x_dwmac_init(struct platform_device *pdev, void *priv)
> +{
> +	struct ls1x_dwmac *dwmac = priv;
> +	int ret;
> +

> +	ret = devm_regmap_field_bulk_alloc(dwmac->dev, dwmac->regmap,
> +					   dwmac->regmap_fields,
> +					   dwmac->syscon->reg_fields,
> +					   dwmac->syscon->nr_reg_fields);

Please see my first comment about this.

> +	if (ret)
> +		return ret;
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
> +static const struct of_device_id ls1x_dwmac_syscon_match[] = {
> +	{ .compatible = "loongson,ls1b-syscon", .data = &ls1b_dwmac_syscon },
> +	{ .compatible = "loongson,ls1c-syscon", .data = &ls1c_dwmac_syscon },
> +	{ }
> +};
> +
> +static int ls1x_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct stmmac_resources stmmac_res;
> +	struct device_node *syscon_np;
> +	const struct of_device_id *match;
> +	struct regmap *regmap;
> +	struct ls1x_dwmac *dwmac;
> +	const struct ls1x_dwmac_syscon *syscon;
> +	size_t size;
> +	int ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return ret;
> +

> +	/* Probe syscon */
> +	syscon_np = of_parse_phandle(pdev->dev.of_node, "syscon", 0);

it's vendor-specific property so it is supposed to have a
vendor-specific prefix and possibly ls1-specific name.

> +	if (!syscon_np)
> +		return -ENODEV;
> +
> +	match = of_match_node(ls1x_dwmac_syscon_match, syscon_np);
> +	if (!match) {
> +		of_node_put(syscon_np);
> +		return -EINVAL;
> +	}
> +	syscon = (const struct ls1x_dwmac_syscon *)match->data;
> +
> +	regmap = syscon_node_to_regmap(syscon_np);
> +	of_node_put(syscon_np);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(&pdev->dev, "Unable to map syscon: %d\n", ret);
> +		return ret;
> +	}

or you can use syscon_regmap_lookup_by_phandle(). Using
of_match_node() doesn't seem necessary since it's unlikely to have
moee than one system controller available on the LS1b or LS1c chips.

> +
> +	size = syscon->nr_reg_fields * sizeof(struct regmap_field *);
> +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac) + size, GFP_KERNEL);
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

> +	if (pdev->dev.of_node)

Is this conditional statement necessary here?

-Serge

> +		stmmac_remove_config_dt(pdev, plat_dat);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id ls1x_dwmac_match[] = {
> +	{ .compatible = "loongson,ls1b-dwmac" },
> +	{ .compatible = "loongson,ls1c-dwmac" },
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
