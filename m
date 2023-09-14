Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8AE7A01B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjINKbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjINKb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:31:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F123DF;
        Thu, 14 Sep 2023 03:31:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52c88a03f99so847017a12.2;
        Thu, 14 Sep 2023 03:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694687484; x=1695292284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciHMb1B//dKYKVhvHN/ElUPQ1d4JFUIN8eqN3Lc9YR0=;
        b=pU3PggMd1AVbWIE6DhoBW2BpxI57yg4BXGOWpnwaH7z74FGGCJIqs1P9DSWHGmKaTR
         s2cApyA58LhHgbu9iXJGDJi7cARarXJKddz1H7yFuK4pafuRabBE+WGYaPnAqAeyJUuw
         K4JJmWl0HdyXQ/bX7YNT/AoKsMG+1X5CCRBDmTyFNRrid+OZ48T7XLJEaQuxfedgD9fW
         iG4NVwI9ybDFMeUhJFStKR+cI8bJUjqDs7b36GJm9X5BlkJWumVozYFxP6rv3uA71ZOm
         1IrpIVRq7j3Zho+fq1WTAfNT7v+nh4WzJ+MW/HCLCrKUwyGHYOhxA5PQxq4dx6eoVD8v
         Io4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694687484; x=1695292284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciHMb1B//dKYKVhvHN/ElUPQ1d4JFUIN8eqN3Lc9YR0=;
        b=HdHljK3jdwN4XAI88sn9k08sS3PK4RUizpoRFHfGP3x5yce5pQIhFWibd3DRpehidN
         QkRCz3vNaOYRL46h8z4E8CypGaMshdbWeNMZGvETJs7YII+VuEXe69c77Zu5Gqvc/+c1
         Ubr05NR29Qle/qKlfkFgGAWAIEbqIwgFYHjBQup3ya168ae0FF7VGQYzLIpValPLss9L
         ZHD8GtZYOISFn0hbpXeU6xLgyhHb4VhLu5E7vVnfgt/hTJbtloFWizHf3Lu8FpejGdSG
         ywQJ1lolUlHGoIxNcXNbxJ3yqNAe2yrMhc0+p8oHYeRXwoaZxAmH95zLF2iwKBXoP47i
         K/Og==
X-Gm-Message-State: AOJu0YwLFScXxuw/e8QqdJCOMGaGlJech1xSNFGqlllHUEDEpzJZ7vQF
        QEqb8GHGX77ySbJ9pGqAgFNco9WWxGfP7NUaqWs=
X-Google-Smtp-Source: AGHT+IGrSgcBUSsKZXg3KeCQquefRavJreqBbZsad7q2yK+inUfql5TYbLCCNiRdwxfmZ6SZ7yMUenBOjuDjO/cebNM=
X-Received: by 2002:a05:6402:1644:b0:522:6e3f:b65 with SMTP id
 s4-20020a056402164400b005226e3f0b65mr4271351edx.33.1694687483605; Thu, 14 Sep
 2023 03:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
 <20230830134241.506464-4-keguang.zhang@gmail.com> <g3gm6ibq6skrxjp2dkf4xkz4urjnu43oqyqrtpe7r4e4vy6jfw@rppdi3dmumlj>
In-Reply-To: <g3gm6ibq6skrxjp2dkf4xkz4urjnu43oqyqrtpe7r4e4vy6jfw@rppdi3dmumlj>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Thu, 14 Sep 2023 18:30:47 +0800
Message-ID: <CAJhJPsV8ts62Dmy0mOUkQC+qYYrd9ji9TX+DF+CiuaoWJ=kMsw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
To:     Serge Semin <fancer.lancer@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 6:12=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Wed, Aug 30, 2023 at 09:42:40PM +0800, Keguang Zhang wrote:
> > This glue driver is created based on the arch-code
> > implemented earlier with the platform-specific settings.
> >
> > Use syscon for SYSCON register access.
> >
> > Partially based on the previous work by Serge Semin.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V3 -> V4: Drop ls1x_dwmac_syscon definition and its instances
> >           Drop three redundant fields from the ls1x_dwmac structure
> >           Drop the ls1x_dwmac_init() method.
> >           Some minor improvements
> > V2 -> V3: Determine the device ID by physical
> >           base address(suggested by Serge Semin)
> >           Use regmap instead of regmap fields
> >           Use syscon_regmap_lookup_by_phandle()
> >           Some minor fixes
> > V1 -> V2: Fix the build errors due to CONFIG_OF being unset
> >           Change struct reg_field definitions to const
> >           Rename the syscon property to "loongson,dwmac-syscon"
> >           Add MII PHY mode for LS1C
> >
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
> >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> >  .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 219 ++++++++++++++++++
> >  3 files changed, 231 insertions(+)
> >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1=
.c
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/=
ethernet/stmicro/stmmac/Kconfig
> > index 06c6871f8788..a2b9e289aa36 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > @@ -239,6 +239,17 @@ config DWMAC_INTEL_PLAT
> >         the stmmac device driver. This driver is used for the Intel Kee=
m Bay
> >         SoC.
> >
> > +config DWMAC_LOONGSON1
> > +     tristate "Loongson1 GMAC support"
> > +     default MACH_LOONGSON32
> > +     depends on OF && (MACH_LOONGSON32 || COMPILE_TEST)
> > +     help
> > +       Support for ethernet controller on Loongson1 SoC.
> > +
> > +       This selects Loongson1 SoC glue layer support for the stmmac
> > +       device driver. This driver is used for Loongson1-based boards
> > +       like Loongson LS1B/LS1C.
> > +
> >  config DWMAC_TEGRA
> >       tristate "NVIDIA Tegra MGBE support"
> >       depends on ARCH_TEGRA || COMPILE_TEST
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net=
/ethernet/stmicro/stmmac/Makefile
> > index 5b57aee19267..80e598bd4255 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > @@ -29,6 +29,7 @@ obj-$(CONFIG_DWMAC_SUNXI)   +=3D dwmac-sunxi.o
> >  obj-$(CONFIG_DWMAC_SUN8I)    +=3D dwmac-sun8i.o
> >  obj-$(CONFIG_DWMAC_DWC_QOS_ETH)      +=3D dwmac-dwc-qos-eth.o
> >  obj-$(CONFIG_DWMAC_INTEL_PLAT)       +=3D dwmac-intel-plat.o
> > +obj-$(CONFIG_DWMAC_LOONGSON1)        +=3D dwmac-loongson1.o
> >  obj-$(CONFIG_DWMAC_GENERIC)  +=3D dwmac-generic.o
> >  obj-$(CONFIG_DWMAC_IMX8)     +=3D dwmac-imx.o
> >  obj-$(CONFIG_DWMAC_TEGRA)    +=3D dwmac-tegra.o
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c b/dr=
ivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> > new file mode 100644
> > index 000000000000..f1732f15ff87
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> > @@ -0,0 +1,219 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Loongson-1 DWMAC glue layer
> > + *
> > + * Copyright (C) 2011-2023 Keguang Zhang <keguang.zhang@gmail.com>
> > + */
> > +
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "stmmac.h"
> > +#include "stmmac_platform.h"
> > +
>
> > +#define LS1B_GMAC0_BASE              (0x1fe10000)
>
> I was talking about the LS1B_GMAC1_BASE macro only. Since both LS1B
> and LS1C have GMAC0 at the same base address I would preserve
> LS1X_GMAC0_BASE name here. But seeing it's unused for the LS1C anyway
> it's not that a big deal.
>
> > +#define LS1B_GMAC1_BASE              (0x1fe20000)
> > +
> > +/* Loongson-1 SYSCON Registers */
> > +#define LS1X_SYSCON0         (0x0)
> > +#define LS1X_SYSCON1         (0x4)
> > +
> > +/* Loongson-1B SYSCON Register Bits */
> > +#define GMAC1_USE_UART1              BIT(4)
> > +#define GMAC1_USE_UART0              BIT(3)
> > +
> > +#define GMAC1_SHUT           BIT(13)
> > +#define GMAC0_SHUT           BIT(12)
> > +
> > +#define GMAC1_USE_TXCLK              BIT(3)
> > +#define GMAC0_USE_TXCLK              BIT(2)
> > +#define GMAC1_USE_PWM23              BIT(1)
> > +#define GMAC0_USE_PWM01              BIT(0)
> > +
> > +/* Loongson-1C SYSCON Register Bits */
> > +#define GMAC_SHUT            BIT(6)
> > +
> > +#define PHY_INTF_SELI                GENMASK(30, 28)
> > +#define PHY_INTF_MII         FIELD_PREP(PHY_INTF_SELI, 0)
> > +#define PHY_INTF_RMII                FIELD_PREP(PHY_INTF_SELI, 4)
> > +
> > +struct ls1x_dwmac {
> > +     struct plat_stmmacenet_data *plat_dat;
> > +     struct regmap *regmap;
> > +};
> > +
> > +static int ls1b_dwmac_syscon_init(struct platform_device *pdev, void *=
priv)
> > +{
> > +     struct ls1x_dwmac *dwmac =3D priv;
> > +     struct plat_stmmacenet_data *plat =3D dwmac->plat_dat;
> > +     struct regmap *regmap =3D dwmac->regmap;
> > +     struct resource *res;
> > +     unsigned long reg_base;
> > +
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res) {
> > +             dev_err(&pdev->dev, "Could not get IO_MEM resources\n");
> > +             return -EINVAL;
> > +     }
> > +     reg_base =3D (unsigned long)res->start;
> > +
> > +     if (reg_base =3D=3D LS1B_GMAC0_BASE) {
> > +             switch (plat->phy_interface) {
> > +             case PHY_INTERFACE_MODE_RGMII_ID:
> > +                     regmap_update_bits(regmap, LS1X_SYSCON0,
> > +                                        GMAC0_USE_TXCLK | GMAC0_USE_PW=
M01,
> > +                                        0);
> > +                     break;
> > +             case PHY_INTERFACE_MODE_MII:
> > +                     regmap_update_bits(regmap, LS1X_SYSCON0,
> > +                                        GMAC0_USE_TXCLK | GMAC0_USE_PW=
M01,
> > +                                        GMAC0_USE_TXCLK | GMAC0_USE_PW=
M01);
> > +                     break;
> > +             default:
> > +                     dev_err(&pdev->dev, "Unsupported PHY mode %u\n",
> > +                             plat->phy_interface);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +             regmap_update_bits(regmap, LS1X_SYSCON0, GMAC0_SHUT, 0);
> > +     } else if (reg_base =3D=3D LS1B_GMAC1_BASE) {
> > +             regmap_update_bits(regmap, LS1X_SYSCON0,
> > +                                GMAC1_USE_UART1 | GMAC1_USE_UART0,
> > +                                GMAC1_USE_UART1 | GMAC1_USE_UART0);
> > +
> > +             switch (plat->phy_interface) {
> > +             case PHY_INTERFACE_MODE_RGMII_ID:
> > +                     regmap_update_bits(regmap, LS1X_SYSCON1,
> > +                                        GMAC1_USE_TXCLK | GMAC1_USE_PW=
M23,
> > +                                        0);
> > +
> > +                     break;
> > +             case PHY_INTERFACE_MODE_MII:
> > +                     regmap_update_bits(regmap, LS1X_SYSCON1,
> > +                                        GMAC1_USE_TXCLK | GMAC1_USE_PW=
M23,
> > +                                        GMAC1_USE_TXCLK | GMAC1_USE_PW=
M23);
> > +                     break;
> > +             default:
> > +                     dev_err(&pdev->dev, "Unsupported PHY mode %u\n",
> > +                             plat->phy_interface);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +             regmap_update_bits(regmap, LS1X_SYSCON1, GMAC1_SHUT, 0);
> > +     } else {
> > +             dev_err(&pdev->dev, "Invalid Ethernet MAC base address %l=
x",
> > +                     reg_base);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ls1c_dwmac_syscon_init(struct platform_device *pdev, void *=
priv)
> > +{
> > +     struct ls1x_dwmac *dwmac =3D priv;
> > +     struct plat_stmmacenet_data *plat =3D dwmac->plat_dat;
> > +     struct regmap *regmap =3D dwmac->regmap;
> > +
> > +     switch (plat->phy_interface) {
> > +     case PHY_INTERFACE_MODE_MII:
> > +             regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI,
> > +                                PHY_INTF_MII);
> > +             break;
> > +     case PHY_INTERFACE_MODE_RMII:
> > +             regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI,
> > +                                PHY_INTF_RMII);
> > +             break;
> > +     default:
> > +             dev_err(&pdev->dev, "Unsupported PHY-mode %u\n",
> > +                     plat->phy_interface);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     regmap_update_bits(regmap, LS1X_SYSCON0, GMAC0_SHUT, 0);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ls1x_dwmac_probe(struct platform_device *pdev)
> > +{
> > +     struct plat_stmmacenet_data *plat_dat;
> > +     struct stmmac_resources stmmac_res;
> > +     struct regmap *regmap;
> > +     struct ls1x_dwmac *dwmac;
> > +     int (*init)(struct platform_device *pdev, void *priv);
> > +     int ret;
> > +
> > +     ret =3D stmmac_get_platform_resources(pdev, &stmmac_res);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Probe syscon */
> > +     regmap =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> > +                                              "loongson,ls1-syscon");
> > +     if (IS_ERR(regmap))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(regmap),
> > +                                  "Unable to find syscon\n");
> > +
> > +     init =3D of_device_get_match_data(&pdev->dev);
> > +     if (!init) {
> > +             dev_err(&pdev->dev, "No of match data provided\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     dwmac =3D devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> > +     if (!dwmac)
> > +             return -ENOMEM;
> > +
>
> > +     plat_dat =3D stmmac_probe_config_dt(pdev, stmmac_res.mac);
>
> This can be replaced with devm_stmmac_probe_config_dt() and ...
>
> > +     if (IS_ERR(plat_dat))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat),
> > +                                  "dt configuration failed\n");
> > +
> > +     plat_dat->bsp_priv =3D dwmac;
> > +     plat_dat->init =3D init;
> > +     dwmac->plat_dat =3D plat_dat;
> > +     dwmac->regmap =3D regmap;
> > +
>
> > +     ret =3D stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
>
> ... this can be replaced with devm_stmmac_pltfr_probe() thus ...
>
> > +     if (ret)
> > +             goto err_remove_config_dt;
> > +
> > +     return 0;
> > +
>
> > +err_remove_config_dt:
> > +     stmmac_remove_config_dt(pdev, plat_dat);
> > +
> > +     return ret;
>
> ... this could have been omitted and ...
>
> > +}
> > +
> > +static const struct of_device_id ls1x_dwmac_match[] =3D {
> > +     {
> > +             .compatible =3D "loongson,ls1b-gmac",
> > +             .data =3D &ls1b_dwmac_syscon_init,
> > +     },
> > +     {
> > +             .compatible =3D "loongson,ls1c-emac",
> > +             .data =3D &ls1c_dwmac_syscon_init,
> > +     },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, ls1x_dwmac_match);
> > +
> > +static struct platform_driver ls1x_dwmac_driver =3D {
> > +     .probe =3D ls1x_dwmac_probe,
>
> > +     .remove_new =3D stmmac_pltfr_remove,
>
> ... this could have been dropped.
>
Will do all the above changes.
Thanks!

> -Serge(y)
>
> > +     .driver =3D {
> > +             .name =3D "loongson1-dwmac",
> > +             .of_match_table =3D ls1x_dwmac_match,
> > +     },
> > +};
> > +module_platform_driver(ls1x_dwmac_driver);
> > +
> > +MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
> > +MODULE_DESCRIPTION("Loongson-1 DWMAC glue layer");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.39.2
> >
> >



--=20
Best regards,

Keguang Zhang
