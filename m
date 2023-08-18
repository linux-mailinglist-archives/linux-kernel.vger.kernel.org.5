Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B6B780BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359582AbjHRMiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376953AbjHRMhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:37:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E914114;
        Fri, 18 Aug 2023 05:37:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so1221377e87.3;
        Fri, 18 Aug 2023 05:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692362265; x=1692967065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zpe4mOmTb687zCM47cy7N3vN6YylIKD9jMuykcS/hyE=;
        b=dyinlwQLugwKgsER8VTzPyXJrCpiOOkEfv4OG+JigiBKQ0/56aXP9xUgmMEPT1iIVc
         ulcubQ7BhReOqqFlffPF2Zmd0l3p/g8NIwyKwYyP8M6FDyMrQ2O8ZFZG5ueiBDh/z/SY
         nuRo5YiVdIl7ncBatv14njMSbnHX8xwprJsj3Wlat3xeJCbeJTRCo76SwdenS4nULprg
         uGcSvQylnlrAuJX8N801ckJIZX0WMNlNDTUlk4vQU0QIixvlO7D8iovqDNIL0hv5SZT3
         UmZ18V+qtF2yjZ/14vM1N9q+HPkZZu0UrXysJxm9DU3zodhxXlRK/45demoMEH0dMtY6
         JCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692362265; x=1692967065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zpe4mOmTb687zCM47cy7N3vN6YylIKD9jMuykcS/hyE=;
        b=BLa3poX8tJ95B/HZybeE24ewS0kx94T96OS1bzvV2Ea9o+xOfAZml+vZ1ym0PRJ/pS
         Vn2mDmwjzFIN0Sb8RbajlShHCIdewq31r9fcWIbAWQpHI9CQEdPbfm/VbBjPiW2H3UL3
         AyAdQgWKUEOlwwFskaac80yJK7jt/6O+/Ug60Nx5d7O5oi/SLNcOgEuekX0aTodw05TU
         ddOCAl8rOZ38oeiVFkMrm7ZOJtAen8ojFhW4Pp42wKpajw8pM/Pr+Mi00rdKdTws38YT
         Zfa2V0b6JauudeQ5Eav7i5UOvvjm4Z1tlxHBpdJCQwaseCPWRLGhyf3/+MDImkx9pVSY
         ON0w==
X-Gm-Message-State: AOJu0Yylo3yZLFg1wMoZkLvfEQzrjnnJqo3il9UUjAagTvSA587rgtMq
        pZixm1rXYQa2tDQTyTC1fas0X2bZyTLqKpHcN14=
X-Google-Smtp-Source: AGHT+IHoOrpUv1cCN2ovl0mdJaF0qjRPeGdI9PQqEcgj1Nv3uAyhLJXdbSoPjApBGcgNbc1FO+mXwe2CfDhEP8JrFIg=
X-Received: by 2002:a05:6512:a91:b0:4fc:4f3e:9cbf with SMTP id
 m17-20020a0565120a9100b004fc4f3e9cbfmr1890477lfu.50.1692362264240; Fri, 18
 Aug 2023 05:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
 <20230812151135.1028780-5-keguang.zhang@gmail.com> <spt2blizwad4tdp4cjf7bzffd3mr6456nlz4c4vgjrblx34gqj@bkwhyeqph4do>
In-Reply-To: <spt2blizwad4tdp4cjf7bzffd3mr6456nlz4c4vgjrblx34gqj@bkwhyeqph4do>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Fri, 18 Aug 2023 20:37:27 +0800
Message-ID: <CAJhJPsXHuMBAHqsg5rSVf5Ow_Rsgy2Zp-PNrLXWTeVSY3N08Aw@mail.gmail.com>
Subject: Re: [PATCH 4/5] net: stmmac: Add glue layer for Loongson-1 SoC
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

On Wed, Aug 16, 2023 at 9:30=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Sat, Aug 12, 2023 at 11:11:34PM +0800, Keguang Zhang wrote:
> > This glue driver is created based on the arch-code
> > implemented earlier with the platform-specific settings.
> >
> > Use syscon for SYSCON register access.
> >
> > Partialy based on the previous work by Serge Semin.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
> >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> >  .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 257 ++++++++++++++++++
> >  3 files changed, 269 insertions(+)
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
> > index 000000000000..368d6cd2cb78
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> > @@ -0,0 +1,257 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Loongson-1 DWMAC glue layer
> > + *
> > + * Copyright (C) 2011-2023 Keguang Zhang <keguang.zhang@gmail.com>
> > + */
> > +
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/phy.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "stmmac.h"
> > +#include "stmmac_platform.h"
> > +
> > +/* Loongson-1 SYSCON Registers */
> > +#define LS1X_SYSCON0         (0x0)
> > +#define LS1X_SYSCON1         (0x4)
> > +
> > +struct ls1x_dwmac_syscon {
> > +     const struct reg_field *reg_fields;
> > +     unsigned int nr_reg_fields;
> > +     int (*syscon_init)(struct plat_stmmacenet_data *plat);
> > +};
> > +
> > +struct ls1x_dwmac {
> > +     struct device *dev;
> > +     struct plat_stmmacenet_data *plat_dat;
> > +     const struct ls1x_dwmac_syscon *syscon;
> > +     struct regmap *regmap;
> > +     struct regmap_field *regmap_fields[];
> > +};
> > +
> > +enum ls1b_dwmac_syscon_regfield {
> > +     GMAC1_USE_UART1,
> > +     GMAC1_USE_UART0,
> > +     GMAC1_SHUT,
> > +     GMAC0_SHUT,
> > +     GMAC1_USE_TXCLK,
> > +     GMAC0_USE_TXCLK,
> > +     GMAC1_USE_PWM23,
> > +     GMAC0_USE_PWM01,
> > +};
> > +
> > +enum ls1c_dwmac_syscon_regfield {
> > +     GMAC_SHUT,
> > +     PHY_INTF_SELI,
> > +};
> > +
> > +const struct reg_field ls1b_dwmac_syscon_regfields[] =3D {
> > +     [GMAC1_USE_UART1]       =3D REG_FIELD(LS1X_SYSCON0, 4, 4),
> > +     [GMAC1_USE_UART0]       =3D REG_FIELD(LS1X_SYSCON0, 3, 3),
> > +     [GMAC1_SHUT]            =3D REG_FIELD(LS1X_SYSCON1, 13, 13),
> > +     [GMAC0_SHUT]            =3D REG_FIELD(LS1X_SYSCON1, 12, 12),
> > +     [GMAC1_USE_TXCLK]       =3D REG_FIELD(LS1X_SYSCON1, 3, 3),
> > +     [GMAC0_USE_TXCLK]       =3D REG_FIELD(LS1X_SYSCON1, 2, 2),
> > +     [GMAC1_USE_PWM23]       =3D REG_FIELD(LS1X_SYSCON1, 1, 1),
> > +     [GMAC0_USE_PWM01]       =3D REG_FIELD(LS1X_SYSCON1, 0, 0)
> > +};
> > +
> > +const struct reg_field ls1c_dwmac_syscon_regfields[] =3D {
> > +     [GMAC_SHUT]             =3D REG_FIELD(LS1X_SYSCON0, 6, 6),
> > +     [PHY_INTF_SELI]         =3D REG_FIELD(LS1X_SYSCON1, 28, 30)
> > +};
>
> Emm, using regmap fields looks so over-complicated in this case seeing
> you only need to set/clear several bits in the syscon. What about
> defining macros with the particular flag as it's already done in the
> "asm/mach-loongson32/regs-mux.h" file and using regmap_update_bits()?
>
To use regmap_update_bits(), I have to store and pass reg_offset and
mask, which is similar to the definition of regmap fields.
In addition, the regmap fields are very clear and leave the trouble to
the internal implementation.

> > +
>
> > +static int ls1b_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
> > +{
>
> As I already told you this part is better to be called from the
> plat_stmmacenet_data.fix_mac_speed() because PHY interface mode can
> differ from one interface open cycle to another as per the phylink
> design.
>
I have considered .fix_mac_speed(), which will be called every time
the link is up, and passes the current speed.
However, the PHY interface mode is determined by the hardware design -
the schematic.
In other words, once the schematic is done, the PHY interface mode is fixed=
.
Therefore, PHY interface mode should be configured one time at the
initialization.
And the plat_stmmacenet_data.init() is the proper place to do this.

> > +     struct ls1x_dwmac *dwmac =3D plat->bsp_priv;
> > +     struct regmap_field **regmap_fields =3D dwmac->regmap_fields;
> > +
>
> > +     if (plat->bus_id) {
>
> Using bus_id doesn't look correct to determine the CSRs responsible
> for the interface mode selection because it's calculated based on the
> DT ethernet-alias which doesn't guarantee to have a particular device
> assigned with the alias. Alias node can be absent after all. What
> could be better in this case is for instance to use the regs physical
> address. Any better idea?
>
The purpose of alias is to bind the a particular device with a
particular alias even some aliases are absent.
Because of_alias_get_id() gets the alias id.
For example, LS1B has two GMAC controllers, gmac0 and gmac1.
I have tried the Ethernet with only one alias as follows.
       aliases {
               ethernet1 =3D &gmac1;
       };
In this case, plat->bus_id is still 1.
And both gmac0 and gmac1 work.

> > +             regmap_field_write(regmap_fields[GMAC1_USE_UART1], 1);
> > +             regmap_field_write(regmap_fields[GMAC1_USE_UART0], 1);
> > +
> > +             switch (plat->phy_interface) {
> > +             case PHY_INTERFACE_MODE_RGMII:
> > +                     regmap_field_write(regmap_fields[GMAC1_USE_TXCLK]=
, 0);
> > +                     regmap_field_write(regmap_fields[GMAC1_USE_PWM23]=
, 0);
> > +                     break;
> > +             case PHY_INTERFACE_MODE_MII:
> > +                     regmap_field_write(regmap_fields[GMAC1_USE_TXCLK]=
, 1);
> > +                     regmap_field_write(regmap_fields[GMAC1_USE_PWM23]=
, 1);
> > +                     break;
> > +             default:
> > +                     dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
> > +                             plat->phy_interface);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +             regmap_field_write(regmap_fields[GMAC1_SHUT], 0);
> > +     } else {
> > +             switch (plat->phy_interface) {
> > +             case PHY_INTERFACE_MODE_RGMII:
> > +                     regmap_field_write(regmap_fields[GMAC0_USE_TXCLK]=
, 0);
> > +                     regmap_field_write(regmap_fields[GMAC0_USE_PWM01]=
, 0);
> > +                     break;
> > +             case PHY_INTERFACE_MODE_MII:
> > +                     regmap_field_write(regmap_fields[GMAC0_USE_TXCLK]=
, 1);
> > +                     regmap_field_write(regmap_fields[GMAC0_USE_PWM01]=
, 1);
> > +                     break;
> > +             default:
> > +                     dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
> > +                             plat->phy_interface);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +             regmap_field_write(regmap_fields[GMAC0_SHUT], 0);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ls1c_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
> > +{
> > +     struct ls1x_dwmac *dwmac =3D plat->bsp_priv;
> > +     struct regmap_field **regmap_fields =3D dwmac->regmap_fields;
> > +
> > +     if (plat->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII) {
> > +             regmap_field_write(regmap_fields[PHY_INTF_SELI], 0x4);
> > +     } else {
> > +             dev_err(dwmac->dev, "Unsupported PHY-mode %u\n",
> > +                     plat->phy_interface);
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +     regmap_field_write(regmap_fields[GMAC_SHUT], 0);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct ls1x_dwmac_syscon ls1b_dwmac_syscon =3D {
> > +     .reg_fields =3D ls1b_dwmac_syscon_regfields,
> > +     .nr_reg_fields =3D ARRAY_SIZE(ls1b_dwmac_syscon_regfields),
> > +     .syscon_init =3D ls1b_dwmac_syscon_init,
> > +};
> > +
> > +static const struct ls1x_dwmac_syscon ls1c_dwmac_syscon =3D {
> > +     .reg_fields =3D ls1c_dwmac_syscon_regfields,
> > +     .nr_reg_fields =3D ARRAY_SIZE(ls1c_dwmac_syscon_regfields),
> > +     .syscon_init =3D ls1c_dwmac_syscon_init,
> > +};
> > +
> > +static int ls1x_dwmac_init(struct platform_device *pdev, void *priv)
> > +{
> > +     struct ls1x_dwmac *dwmac =3D priv;
> > +     int ret;
> > +
>
> > +     ret =3D devm_regmap_field_bulk_alloc(dwmac->dev, dwmac->regmap,
> > +                                        dwmac->regmap_fields,
> > +                                        dwmac->syscon->reg_fields,
> > +                                        dwmac->syscon->nr_reg_fields);
>
> Please see my first comment about this.
>
> > +     if (ret)
> > +             return ret;
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
> > +static const struct of_device_id ls1x_dwmac_syscon_match[] =3D {
> > +     { .compatible =3D "loongson,ls1b-syscon", .data =3D &ls1b_dwmac_s=
yscon },
> > +     { .compatible =3D "loongson,ls1c-syscon", .data =3D &ls1c_dwmac_s=
yscon },
> > +     { }
> > +};
> > +
> > +static int ls1x_dwmac_probe(struct platform_device *pdev)
> > +{
> > +     struct plat_stmmacenet_data *plat_dat;
> > +     struct stmmac_resources stmmac_res;
> > +     struct device_node *syscon_np;
> > +     const struct of_device_id *match;
> > +     struct regmap *regmap;
> > +     struct ls1x_dwmac *dwmac;
> > +     const struct ls1x_dwmac_syscon *syscon;
> > +     size_t size;
> > +     int ret;
> > +
> > +     ret =3D stmmac_get_platform_resources(pdev, &stmmac_res);
> > +     if (ret)
> > +             return ret;
> > +
>
> > +     /* Probe syscon */
> > +     syscon_np =3D of_parse_phandle(pdev->dev.of_node, "syscon", 0);
>
> it's vendor-specific property so it is supposed to have a
> vendor-specific prefix and possibly ls1-specific name.
>
This has been fixed in v2.
Could you please review v2?
Thanks!

> > +     if (!syscon_np)
> > +             return -ENODEV;
> > +
> > +     match =3D of_match_node(ls1x_dwmac_syscon_match, syscon_np);
> > +     if (!match) {
> > +             of_node_put(syscon_np);
> > +             return -EINVAL;
> > +     }
> > +     syscon =3D (const struct ls1x_dwmac_syscon *)match->data;
> > +
> > +     regmap =3D syscon_node_to_regmap(syscon_np);
> > +     of_node_put(syscon_np);
> > +     if (IS_ERR(regmap)) {
> > +             ret =3D PTR_ERR(regmap);
> > +             dev_err(&pdev->dev, "Unable to map syscon: %d\n", ret);
> > +             return ret;
> > +     }
>
> or you can use syscon_regmap_lookup_by_phandle(). Using
> of_match_node() doesn't seem necessary since it's unlikely to have
> moee than one system controller available on the LS1b or LS1c chips.
>
I planned to use syscon_regmap_lookup_by_phandle().
Thus the compatible
"loongson,ls1b-dwmac-syscon"/"loongson,ls1c-dwmac-syscon" would become
useless.
I'm not sure about this.

> > +
> > +     size =3D syscon->nr_reg_fields * sizeof(struct regmap_field *);
> > +     dwmac =3D devm_kzalloc(&pdev->dev, sizeof(*dwmac) + size, GFP_KER=
NEL);
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
> > +     plat_dat->init =3D ls1x_dwmac_init;
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
>
> > +     if (pdev->dev.of_node)
>
> Is this conditional statement necessary here?
>
You're right.
Will remove this condition in next version.
Thanks!

> -Serge
>
> > +             stmmac_remove_config_dt(pdev, plat_dat);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct of_device_id ls1x_dwmac_match[] =3D {
> > +     { .compatible =3D "loongson,ls1b-dwmac" },
> > +     { .compatible =3D "loongson,ls1c-dwmac" },
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



--
Best regards,

Keguang Zhang
