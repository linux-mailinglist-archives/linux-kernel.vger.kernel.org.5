Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C343A78DAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbjH3ShQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244701AbjH3NqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:46:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C1EA3;
        Wed, 30 Aug 2023 06:46:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso8229795e87.0;
        Wed, 30 Aug 2023 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693403177; x=1694007977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuDbNuThVjyYyG8SOd+p3FdA7BGQ0yYBzKne/5GehDY=;
        b=A9QIFQNkn/9NTjuk03QWbHWz1GzTQ7/ukdHQc3c87vpJkJ/vLiWvp5IVYZxJtbj7hk
         1s/JHCcsr/ONz/57xwoH1wvNyrbEu2/U4c/KMd/v8AtFeHr3tuO+fmebAtdMZP9ycLC4
         7dmju1ZP7wFgS9g4JYxWLud6QxgQhxu70US+HEq1oxYK/8b60TEnKRFhAYetj9N3pQwS
         /Nw7pmCpJv/rpTZ5PKfRsfGbbadqui7SiWSM2ZBlBwVU26azDOaEhn+olquY6UdK9agY
         V1EO+Mne20N8ZmmWceaQ5rOQNRbkDImytG1aUd/9kRnnsObdkWOA+wBo5TLgdTYgMmqp
         AYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403177; x=1694007977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuDbNuThVjyYyG8SOd+p3FdA7BGQ0yYBzKne/5GehDY=;
        b=XtFRzB9gAtKX02Qlq+b6hywqmc9OI308Pkyu4QdfeK0mho8M0rw04iWDibGR/GOx4r
         t4uMho3OVe8m0Zc1KG2tpQWMbCT6Xbp2EVYABv7Ofy2fKv9JHrCFjso7jbTTqwJ1c4U4
         ezdBo+i0luw+wBcSlP37WJ7eRF94Y9Ct9yA4zxUrpnC14T+BIzLV1kpgrbmCFpxtfG+f
         LUL3s0dQC7IOdmG3AyNbFTHpSnZpomZPjqrgkYuxzzoN0b9zNoSGSVGJWLYWUKoK7kpI
         Lci/CkugmtLXztsXyeMc2E4fsVFGxqdKpJOglqEyFnk25djOZG+ScIh0x/2VmIQsO7Fa
         4D4Q==
X-Gm-Message-State: AOJu0YxcQVPgAEJK+OskDX0HewyIUjvLeSfks1VaDLc/NbhHUOmyOqMt
        7XAzFEGpxyoDa2PMM26E/e4cqsJ2YcCm4OsYx8g=
X-Google-Smtp-Source: AGHT+IEZAAsca9PWYYBEnHGO8eA/kNKmQBise/B7S/TkDQ3pMr9wjWAHRBlPLntqPU9mUrcOzObwrbDvHs8qOYBiKXY=
X-Received: by 2002:a05:6512:118e:b0:4fd:d64f:c0a6 with SMTP id
 g14-20020a056512118e00b004fdd64fc0a6mr1869313lfr.48.1693403176842; Wed, 30
 Aug 2023 06:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-4-keguang.zhang@gmail.com> <c3k77fijjiq6osz53jbryulm77f2hmmk6jpiptzthokuzg4tpt@d7h6x7a3dbdg>
In-Reply-To: <c3k77fijjiq6osz53jbryulm77f2hmmk6jpiptzthokuzg4tpt@d7h6x7a3dbdg>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Wed, 30 Aug 2023 21:45:40 +0800
Message-ID: <CAJhJPsVk9xkA5zp=x+NiFBMeyeLk7uLuUx_m6XQM2PZq10aVLA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] net: stmmac: Add glue layer for Loongson-1 SoC
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 4:40=E2=80=AFAM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Thu, Aug 24, 2023 at 08:50:11PM +0800, Keguang Zhang wrote:
> > This glue driver is created based on the arch-code
> > implemented earlier with the platform-specific settings.
> >
> > Use syscon for SYSCON register access.
> >
> > Partially based on the previous work by Serge Semin.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
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
> >  .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 240 ++++++++++++++++++
> >  3 files changed, 252 insertions(+)
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
> > index 000000000000..347d842141e4
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> > @@ -0,0 +1,240 @@
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
> > +#define LS1X_GMAC0_BASE              (0xe10000)
>
> > +#define LS1X_GMAC1_BASE              (0xe20000)
>
> If LS1C doesn't have the second GMAC then what about changing the
> macros name to LS1B_GMAC1_BASE?
>
> > +
> > +/* Loongson-1 SYSCON Registers */
> > +#define LS1X_SYSCON0         (0x0)
> > +#define LS1X_SYSCON1         (0x4)
> > +
> > +/* Loongson-1B SYSCON Register Bits */
>
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
>
> IMO having the SoC-specific prefixes (LS1B_ and LS1C_) in these names
> would make the driver a bit more readable. But it's up to you to
> decide.
>
> > +#define PHY_INTF_SELI_SHIFT  28
>
> Use FIELD_PREP():
> #define PHY_INTF_MII                    FIELD_PREP(PHY_INTF_SELI, 0)
> #define PHY_INTF_RMII                   FIELD_PREP(PHY_INTF_SELI, 4)
>
> > +
> > +struct ls1x_dwmac_syscon {
> > +     int (*syscon_init)(struct plat_stmmacenet_data *plat);
> > +};
>
> This struct is redundant. See further for details.
>
> > +
> > +struct ls1x_dwmac {
>
> > +     unsigned long reg_base;
>
> this field
>
> > +     struct device *dev;
>
> > +     struct plat_stmmacenet_data *plat_dat;
> > +     const struct ls1x_dwmac_syscon *syscon;
>
> and these fields are also redundant. See further for details.
>
> > +     struct regmap *regmap;
> > +};
> > +
> > +static int ls1b_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
> > +{
> > +     struct ls1x_dwmac *dwmac =3D plat->bsp_priv;
> > +     struct regmap *regmap =3D dwmac->regmap;
> > +
>
> > +     if ((dwmac->reg_base & LS1X_GMAC0_BASE) =3D=3D LS1X_GMAC0_BASE) {
>
> Is it necessary to bitwise-and-ing? What if LS1X_GMAC0_BASE would be
> just a full physical base address? Then you'll be able to just compare
> the base addresses.
>
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
> > +                     dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
> > +                             plat->phy_interface);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +             regmap_update_bits(regmap, LS1X_SYSCON0, GMAC0_SHUT, 0);
>
> > +     }
> > +
> > +     if ((dwmac->reg_base & LS1X_GMAC1_BASE) =3D=3D LS1X_GMAC1_BASE) {
>
> else if?
>
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
> > +                     dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
> > +                             plat->phy_interface);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +             regmap_update_bits(regmap, LS1X_SYSCON1, GMAC1_SHUT, 0);
>
> > +     }
>
> else {
>         dev_err(...)
>         return -EINVAL;
> }
> ?
>
> * unless you have some more DW GMACs on the SoC which don't require the
> syscon setups.
>
> > +
> > +     return 0;
> > +}
> > +
> > +static int ls1c_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
> > +{
> > +     struct ls1x_dwmac *dwmac =3D plat->bsp_priv;
> > +     struct regmap *regmap =3D dwmac->regmap;
> > +
> > +     switch (plat->phy_interface) {
> > +     case PHY_INTERFACE_MODE_MII:
>
> > +             regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI, 0=
);
>
>
>                 regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI,
>                                    PHY_INTF_MII);
>
> > +             break;
> > +     case PHY_INTERFACE_MODE_RMII:
>
> > +             regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI,
> > +                                4 << PHY_INTF_SELI_SHIFT);
>
>                 regmap_update_bits(regmap, LS1X_SYSCON1, PHY_INTF_SELI,
>                                    PHY_INTF_RMII);
>
> > +             break;
> > +     default:
> > +             dev_err(dwmac->dev, "Unsupported PHY-mode %u\n",
> > +                     plat->phy_interface);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     regmap_update_bits(regmap, LS1X_SYSCON0, GMAC0_SHUT, 0);
> > +
> > +     return 0;
> > +}
> > +
>
> > +static const struct ls1x_dwmac_syscon ls1b_dwmac_syscon =3D {
> > +     .syscon_init =3D ls1b_dwmac_syscon_init,
> > +};
> > +
> > +static const struct ls1x_dwmac_syscon ls1c_dwmac_syscon =3D {
> > +     .syscon_init =3D ls1c_dwmac_syscon_init,
> > +};
>
> This can be dropped. See the next comment for details.
>
> > +
> > +static int ls1x_dwmac_init(struct platform_device *pdev, void *priv)
> > +{
> > +     struct ls1x_dwmac *dwmac =3D priv;
> > +     struct resource *res;
> > +     int ret;
> > +
>
> > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res) {
> > +             dev_err(&pdev->dev, "Could not get IO_MEM resources\n");
> > +             return -EINVAL;
> > +     }
> > +     dwmac->reg_base =3D (unsigned long)res->start;
>
> What about moving this to ls1b_dwmac_syscon_init() seeing it's used
> for LS1B only? Thus you won't need to have the reg_base defined in the
> private data and can get rid from the ls1x_dwmac_init() method setting
> the ls1b_dwmac_syscon_init() and ls1c_dwmac_syscon_init() pointers
> directly to the device match data.
>
> > +
> > +     if (dwmac->syscon->syscon_init) {
> > +             ret =3D dwmac->syscon->syscon_init(dwmac->plat_dat);
> > +             if (ret)
> > +                     return ret;
> > +     }
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
>
> > +     const struct ls1x_dwmac_syscon *syscon;
>
> This can be replaced with just
> int (*init)(struct platform_device *pdev, void *priv);
>
> > +     int ret;
> > +
> > +     ret =3D stmmac_get_platform_resources(pdev, &stmmac_res);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Probe syscon */
> > +     regmap =3D syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> > +                                              "loongson,ls1-syscon");
> > +     if (IS_ERR(regmap)) {
>
> > +             ret =3D PTR_ERR(regmap);
> > +             dev_err(&pdev->dev, "Unable to map syscon: %d\n", ret);
> > +             return ret;
>
> return dev_err_probe(&pdev->dev, PTR_ERR(regmap), "Unable to find syscon\=
n");
>
> > +     }
> > +
>
> > +     syscon =3D of_device_get_match_data(&pdev->dev);
>
> init =3D of_device_get_match_data(&pdev->dev);
>
> > +     if (!syscon) {
> > +             dev_err(&pdev->dev, "No of match data provided\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     dwmac =3D devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> > +     if (!dwmac)
> > +             return -ENOMEM;
> > +
> > +     plat_dat =3D stmmac_probe_config_dt(pdev, stmmac_res.mac);
> > +     if (IS_ERR(plat_dat)) {
> > +             dev_err(&pdev->dev, "dt configuration failed\n");
> > +             return PTR_ERR(plat_dat);
> > +     }
> > +
> > +     plat_dat->bsp_priv =3D dwmac;
>
> > +     plat_dat->init =3D ls1x_dwmac_init;
>
> plat_dat->init =3D init;
>
> > +     dwmac->dev =3D &pdev->dev;
> > +     dwmac->plat_dat =3D plat_dat;
> > +     dwmac->syscon =3D syscon;
> > +     dwmac->regmap =3D regmap;
> > +
> > +     ret =3D stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
> > +     if (ret)
> > +             goto err_remove_config_dt;
> > +
> > +     return 0;
> > +
> > +err_remove_config_dt:
> > +     stmmac_remove_config_dt(pdev, plat_dat);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct of_device_id ls1x_dwmac_match[] =3D {
>
> > +     { .compatible =3D "loongson,ls1b-gmac", .data =3D &ls1b_dwmac_sys=
con, },
> > +     { .compatible =3D "loongson,ls1c-emac", .data =3D &ls1c_dwmac_sys=
con, },
>
> { .compatible =3D "loongson,ls1b-gmac", .data =3D &ls1b_dwmac_syscon_init=
, },
> { .compatible =3D "loongson,ls1c-emac", .data =3D &ls1c_dwmac_syscon_init=
, },
>
> Thus you can simplify the driver by:
> 1. dropping ls1x_dwmac_syscon definition and its instances.
> 2. dropping three redundant fields from the ls1x_dwmac structure.
> 3. dropping the ls1x_dwmac_init() method.
> Sounds like worth it.)
>
> Note if no further driver update is planned then you can drop the
> ls1x_dwmac->dev field too. Otherwise you can keep it seeing some of
> the plat_stmmacenet_data data callbacks do have any device instance
> passed.
>
All done in v4.
Thanks!

> -Serge(y)
>
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, ls1x_dwmac_match);
> > +
> > +static struct platform_driver ls1x_dwmac_driver =3D {
> > +     .probe =3D ls1x_dwmac_probe,
> > +     .remove_new =3D stmmac_pltfr_remove,
> > +     .driver =3D {
> > +             .name =3D "loongson1-dwmac",
> > +             .of_match_table =3D ls1x_dwmac_match,
> > +     },
> > +};
> > +module_platform_driver(ls1x_dwmac_driver);
> > +
> > +MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
> > +MODULE_DESCRIPTION("Loongson1 DWMAC glue layer");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.39.2
> >
> >



--=20
Best regards,

Keguang Zhang
