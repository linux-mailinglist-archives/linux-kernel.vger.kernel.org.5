Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5039A782A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjHUNYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjHUNYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:24:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2DBFF;
        Mon, 21 Aug 2023 06:24:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5007f3d3235so1642182e87.2;
        Mon, 21 Aug 2023 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692624275; x=1693229075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PeU0zIhC1zHzmlibwOf6LwjfjSbq0+Ddnw5LlHnrbk=;
        b=Hu4zXh19nsH3bua+rWbELaICXda5XLGDT5fftAgUqgLeVTlUxX1aKFFHweiH+40Z2D
         3Lko+pWVtDOoyYDC+E18mO9Q/5PiSHexoN+ajVnEUeGv/+6t8vSxFay2XxwaffyTZqiO
         eCWpCkg/jVSBWLYDiFMcY3NkPCZU2lx4VBnbc3/EheNeqyST5YG+BzRPRQ4KQDGeNyQE
         Zaok3Qsp06zzWKx3QT23oRboiRGvAurCdiiUSCMrYvqIY1qVa2lFO9oW9bCrjp5py4qp
         QkDJIEMdYmjSze29UDmWleTBS7AicqQ8mesmp6vzRm2GJ3KmRjQHHbn3RR5q94e8FpLu
         Xkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692624275; x=1693229075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PeU0zIhC1zHzmlibwOf6LwjfjSbq0+Ddnw5LlHnrbk=;
        b=H3l9VatA2UtPbuW7cG+nu8iNprevh2rFed4zAzv+vKTNUBoY/vkQox1UqKg81OLwkO
         MYadqcU8ytlgJ1rPkWAGjZXlXbWFcQoKO7UlX/pgEKtl0RlY7EOFxjfpI/GYJXqO6td4
         H0a8hk7hqsvpxoY6NFIgMeWKzhHeYrzJUCfx+GKK0LE/U541PEs0y/LdvfLQMd6Q8loZ
         cHQw+F8koiNYC8yT350aVDxoi4JkMlQMVPIKzQgVvJlvi0MMNaiizRieB+0GO6ObBscl
         Ztnx/uVaJTnX0M0lcg5aBR87ZvG2L+LfpN/zAIpYkSt0jX5VjbXVIepW3zG8aEt9MCW/
         LW/Q==
X-Gm-Message-State: AOJu0Yxemy+l+GygiYmB17I+fCdduVs7zinNZTyb5G5vvegmAR5mFNHc
        tbHttRJv4uQ9lSusHYN2one2wdQp9UZfvSot4aA=
X-Google-Smtp-Source: AGHT+IGhWvPnseh9WPv86RALh2qt48h/ZupwMFNaQjMBBMv0FRtWbNmmL+UwctHFmaXZkrFUJS7tMcr9UVpZbE7Uamk=
X-Received: by 2002:a05:6512:108a:b0:4fd:d016:c2e8 with SMTP id
 j10-20020a056512108a00b004fdd016c2e8mr5155864lfg.43.1692624274409; Mon, 21
 Aug 2023 06:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
 <20230812151135.1028780-5-keguang.zhang@gmail.com> <spt2blizwad4tdp4cjf7bzffd3mr6456nlz4c4vgjrblx34gqj@bkwhyeqph4do>
 <CAJhJPsXHuMBAHqsg5rSVf5Ow_Rsgy2Zp-PNrLXWTeVSY3N08Aw@mail.gmail.com> <l6dr3cvnldmljhafmu5wdal7yr4mkr4mmplt3nivjhejohmlro@blfa2ntsq6uv>
In-Reply-To: <l6dr3cvnldmljhafmu5wdal7yr4mkr4mmplt3nivjhejohmlro@blfa2ntsq6uv>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 21 Aug 2023 21:24:17 +0800
Message-ID: <CAJhJPsV4+WozxVb1=xQ6SGm5SVuKyk94Ns0nRz+kwB6Xh4C_WQ@mail.gmail.com>
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

On Sat, Aug 19, 2023 at 12:19=E2=80=AFAM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
>
> On Fri, Aug 18, 2023 at 08:37:27PM +0800, Keguang Zhang wrote:
> > On Wed, Aug 16, 2023 at 9:30=E2=80=AFPM Serge Semin <fancer.lancer@gmai=
l.com> wrote:
> > >
> > > On Sat, Aug 12, 2023 at 11:11:34PM +0800, Keguang Zhang wrote:
> > > > This glue driver is created based on the arch-code
> > > > implemented earlier with the platform-specific settings.
> > > >
> > > > Use syscon for SYSCON register access.
> > > >
> > > > Partialy based on the previous work by Serge Semin.
> > > >
> > > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
> > > >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> > > >  .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 257 ++++++++++++++=
++++
> > > >  3 files changed, 269 insertions(+)
> > > >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loong=
son1.c
> > > >
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/=
net/ethernet/stmicro/stmmac/Kconfig
> > > > index 06c6871f8788..a2b9e289aa36 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > > @@ -239,6 +239,17 @@ config DWMAC_INTEL_PLAT
> > > >         the stmmac device driver. This driver is used for the Intel=
 Keem Bay
> > > >         SoC.
> > > >
> > > > +config DWMAC_LOONGSON1
> > > > +     tristate "Loongson1 GMAC support"
> > > > +     default MACH_LOONGSON32
> > > > +     depends on OF && (MACH_LOONGSON32 || COMPILE_TEST)
> > > > +     help
> > > > +       Support for ethernet controller on Loongson1 SoC.
> > > > +
> > > > +       This selects Loongson1 SoC glue layer support for the stmma=
c
> > > > +       device driver. This driver is used for Loongson1-based boar=
ds
> > > > +       like Loongson LS1B/LS1C.
> > > > +
> > > >  config DWMAC_TEGRA
> > > >       tristate "NVIDIA Tegra MGBE support"
> > > >       depends on ARCH_TEGRA || COMPILE_TEST
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers=
/net/ethernet/stmicro/stmmac/Makefile
> > > > index 5b57aee19267..80e598bd4255 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > > > @@ -29,6 +29,7 @@ obj-$(CONFIG_DWMAC_SUNXI)   +=3D dwmac-sunxi.o
> > > >  obj-$(CONFIG_DWMAC_SUN8I)    +=3D dwmac-sun8i.o
> > > >  obj-$(CONFIG_DWMAC_DWC_QOS_ETH)      +=3D dwmac-dwc-qos-eth.o
> > > >  obj-$(CONFIG_DWMAC_INTEL_PLAT)       +=3D dwmac-intel-plat.o
> > > > +obj-$(CONFIG_DWMAC_LOONGSON1)        +=3D dwmac-loongson1.o
> > > >  obj-$(CONFIG_DWMAC_GENERIC)  +=3D dwmac-generic.o
> > > >  obj-$(CONFIG_DWMAC_IMX8)     +=3D dwmac-imx.o
> > > >  obj-$(CONFIG_DWMAC_TEGRA)    +=3D dwmac-tegra.o
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c =
b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> > > > new file mode 100644
> > > > index 000000000000..368d6cd2cb78
> > > > --- /dev/null
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
> > > > @@ -0,0 +1,257 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * Loongson-1 DWMAC glue layer
> > > > + *
> > > > + * Copyright (C) 2011-2023 Keguang Zhang <keguang.zhang@gmail.com>
> > > > + */
> > > > +
> > > > +#include <linux/mfd/syscon.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/phy.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/regmap.h>
> > > > +
> > > > +#include "stmmac.h"
> > > > +#include "stmmac_platform.h"
> > > > +
> > > > +/* Loongson-1 SYSCON Registers */
> > > > +#define LS1X_SYSCON0         (0x0)
> > > > +#define LS1X_SYSCON1         (0x4)
> > > > +
> > > > +struct ls1x_dwmac_syscon {
> > > > +     const struct reg_field *reg_fields;
> > > > +     unsigned int nr_reg_fields;
> > > > +     int (*syscon_init)(struct plat_stmmacenet_data *plat);
> > > > +};
> > > > +
> > > > +struct ls1x_dwmac {
> > > > +     struct device *dev;
> > > > +     struct plat_stmmacenet_data *plat_dat;
> > > > +     const struct ls1x_dwmac_syscon *syscon;
> > > > +     struct regmap *regmap;
> > > > +     struct regmap_field *regmap_fields[];
> > > > +};
> > > > +
> > > > +enum ls1b_dwmac_syscon_regfield {
> > > > +     GMAC1_USE_UART1,
> > > > +     GMAC1_USE_UART0,
> > > > +     GMAC1_SHUT,
> > > > +     GMAC0_SHUT,
> > > > +     GMAC1_USE_TXCLK,
> > > > +     GMAC0_USE_TXCLK,
> > > > +     GMAC1_USE_PWM23,
> > > > +     GMAC0_USE_PWM01,
> > > > +};
> > > > +
> > > > +enum ls1c_dwmac_syscon_regfield {
> > > > +     GMAC_SHUT,
> > > > +     PHY_INTF_SELI,
> > > > +};
> > > > +
> > > > +const struct reg_field ls1b_dwmac_syscon_regfields[] =3D {
> > > > +     [GMAC1_USE_UART1]       =3D REG_FIELD(LS1X_SYSCON0, 4, 4),
> > > > +     [GMAC1_USE_UART0]       =3D REG_FIELD(LS1X_SYSCON0, 3, 3),
> > > > +     [GMAC1_SHUT]            =3D REG_FIELD(LS1X_SYSCON1, 13, 13),
> > > > +     [GMAC0_SHUT]            =3D REG_FIELD(LS1X_SYSCON1, 12, 12),
> > > > +     [GMAC1_USE_TXCLK]       =3D REG_FIELD(LS1X_SYSCON1, 3, 3),
> > > > +     [GMAC0_USE_TXCLK]       =3D REG_FIELD(LS1X_SYSCON1, 2, 2),
> > > > +     [GMAC1_USE_PWM23]       =3D REG_FIELD(LS1X_SYSCON1, 1, 1),
> > > > +     [GMAC0_USE_PWM01]       =3D REG_FIELD(LS1X_SYSCON1, 0, 0)
> > > > +};
> > > > +
> > > > +const struct reg_field ls1c_dwmac_syscon_regfields[] =3D {
> > > > +     [GMAC_SHUT]             =3D REG_FIELD(LS1X_SYSCON0, 6, 6),
> > > > +     [PHY_INTF_SELI]         =3D REG_FIELD(LS1X_SYSCON1, 28, 30)
> > > > +};
> > >
> > > Emm, using regmap fields looks so over-complicated in this case seein=
g
> > > you only need to set/clear several bits in the syscon. What about
> > > defining macros with the particular flag as it's already done in the
> > > "asm/mach-loongson32/regs-mux.h" file and using regmap_update_bits()?
> > >
>
> > To use regmap_update_bits(), I have to store and pass reg_offset and
> > mask, which is similar to the definition of regmap fields.
>
> Em, not really. And what offset are you talking about? Anyway you
> don't need one. Moreover you'll be able to reduce the number of IOs:
>
> +#define GMAC1_USE_UART1                 BIT(4)
> +#define GMAC1_USE_UART0                 BIT(3)
> ...
> +#define GMAC1_SHUT                      BIT(13)
> ...
> +#define GMAC1_USE_TXCLK                 BIT(3)
> +#define GMAC1_USE_PWM23                 BIT(1)
>
> +static int ls1b_dwmac_syscon_init(struct plat_stmmacenet_data *plat)
> +{
> +       struct ls1x_dwmac *dwmac =3D plat->bsp_priv;
> +       struct regmap *syscon =3D dwmac->regmap;
> +
> +       if (plat->bus_id) {
> +               regmap_update_bits(syscon, LS1X_SYSCON0,
> +                                  GMAC1_USE_UART1 | GMAC1_USE_UART0,
> +                                  GMAC1_USE_UART1 | GMAC1_USE_UART0);
> +
> +               switch (plat->phy_interface) {
> +               case PHY_INTERFACE_MODE_RGMII:
> +                       regmap_update_bits(syscon, LS1X_SYSCON1,
> +                                          GMAC1_USE_TXCLK | GMAC1_USE_TX=
CLK, 0);
> +                       break;
> +               case PHY_INTERFACE_MODE_MII:
> +                       regmap_update_bits(syscon, LS1X_SYSCON1,
> +                                          GMAC1_USE_TXCLK | GMAC1_USE_TX=
CLK
> +                                          GMAC1_USE_TXCLK | GMAC1_USE_TX=
CLK);
> +                       break;
> +               default:
> +                       dev_err(dwmac->dev, "Unsupported PHY mode %u\n",
> +                               plat->phy_interface);
> +                       return -EOPNOTSUPP;
> +               }
> +
> +               regmap_field_write(syscon, LS1X_SYSCON1, GMAC1_SHUT, 0);
> +       } //...
> +
> +       return 0;
> +}
>
> This doesn't look in anyway less readable then your implementation
> but in fact simpler.
>
> > In addition, the regmap fields are very clear and leave the trouble to
> > the internal implementation.
>
> In this case it brings much more troubles and no clarity. You need to cre=
ate
> an additional mainly redundant abstraction, waste memory for it,
> define additional const arrays. Using it won't improve the code
> readability seeing you need to set/clear a few flags only. So all of
> the troubles for nothing. See the code above. It's simple and clear.
> Just several regmap_update_bits()..
>
OK. I will use regmap instead of regmap fields.

> BTW why have you chosen to define syscon instead of creating a pinctrl
> driver? What if Loongson1 is embedded into a platform with, for
> instance, UART0 and UART1 utilized instead of the GMAC1?
>
As you can see, the two registers contains miscellaneous settings.
Besides =E2=80=98USE=E2=80=99 bits, there are =E2=80=98RESET=E2=80=98 bits,=
 'EN' bits, 'SHUT' bits, ...
So they are not pinctrl registers.
Actually, there is a dedicated pin controller which controls the
multiplexing of pads.

> >
> > > > +
> > >
> > > > +static int ls1b_dwmac_syscon_init(struct plat_stmmacenet_data *pla=
t)
> > > > +{
> > >
> > > As I already told you this part is better to be called from the
> > > plat_stmmacenet_data.fix_mac_speed() because PHY interface mode can
> > > differ from one interface open cycle to another as per the phylink
> > > design.
> > >
> > I have considered .fix_mac_speed(), which will be called every time
> > the link is up, and passes the current speed.
> > However, the PHY interface mode is determined by the hardware design -
> > the schematic.
> > In other words, once the schematic is done, the PHY interface mode is f=
ixed.
> > Therefore, PHY interface mode should be configured one time at the
> > initialization.
> > And the plat_stmmacenet_data.init() is the proper place to do this.
>
> Ok. If no actual clock change is needed then indeed init() will be the
> proper place.
>
> >
> > > > +     struct ls1x_dwmac *dwmac =3D plat->bsp_priv;
> > > > +     struct regmap_field **regmap_fields =3D dwmac->regmap_fields;
> > > > +
> > >
> > > > +     if (plat->bus_id) {
> > >
> > > Using bus_id doesn't look correct to determine the CSRs responsible
> > > for the interface mode selection because it's calculated based on the
> > > DT ethernet-alias which doesn't guarantee to have a particular device
> > > assigned with the alias. Alias node can be absent after all. What
> > > could be better in this case is for instance to use the regs physical
> > > address. Any better idea?
> > >
>
> > The purpose of alias is to bind the a particular device with a
> > particular alias even some aliases are absent.
> > Because of_alias_get_id() gets the alias id.
> > For example, LS1B has two GMAC controllers, gmac0 and gmac1.
> > I have tried the Ethernet with only one alias as follows.
> >        aliases {
> >                ethernet1 =3D &gmac1;
> >        };
> > In this case, plat->bus_id is still 1.
> > And both gmac0 and gmac1 work.
>
> If no alias specified? If both aliases a non zero? If the IDs are
> confused? If any of these is true you are in trouble. Your code
> shouldn't rely on the aliases in this case. You need to come up with a
> way to certainly distinguish one MAC from another. A physical base
> address is one possible option.
>
I see.
But It seems unusual to determine device IDs by physical base address.
What about adding a new property? such as loongson,dwmac-id

> Note the /alias node is an informational node. It doesn't describe
> devices. Just recent Krzysztof comment in a similar situation:
> https://lore.kernel.org/netdev/20230814112539.70453-1-sriranjani.p@samsun=
g.com/T/#m3972e40bd2fa323a3bdb2fbf07bde47ba6752439
>
> Aliases are normally used by OS to for instance fix the device
> enumeration (see SPI, I2C, I3C, MTD, MMC, RTC, TTY/Serial, Watchdog,
> MDIO-GPIO, etc) - pre-define the device ID from the kernel or OS point
> of view. In your case the IDs can't be changed. GMAC0 must be assigned
> with ID0 and GMAC1 must be assigned with non-zero. Doing otherwise
> will be break the interfaces functionality which isn't acceptable.
>
> >
> > > > +             regmap_field_write(regmap_fields[GMAC1_USE_UART1], 1)=
;
> > > > +             regmap_field_write(regmap_fields[GMAC1_USE_UART0], 1)=
;
> > > > +
> > > > +             switch (plat->phy_interface) {
> > > > +             case PHY_INTERFACE_MODE_RGMII:
> > > > +                     regmap_field_write(regmap_fields[GMAC1_USE_TX=
CLK], 0);
> > > > +                     regmap_field_write(regmap_fields[GMAC1_USE_PW=
M23], 0);
> > > > +                     break;
> > > > +             case PHY_INTERFACE_MODE_MII:
> > > > +                     regmap_field_write(regmap_fields[GMAC1_USE_TX=
CLK], 1);
> > > > +                     regmap_field_write(regmap_fields[GMAC1_USE_PW=
M23], 1);
> > > > +                     break;
> > > > +             default:
> > > > +                     dev_err(dwmac->dev, "Unsupported PHY mode %u\=
n",
> > > > +                             plat->phy_interface);
> > > > +                     return -EOPNOTSUPP;
> > > > +             }
> > > > +
> > > > +             regmap_field_write(regmap_fields[GMAC1_SHUT], 0);
> > > > +     } else {
> > > > +             switch (plat->phy_interface) {
> > > > +             case PHY_INTERFACE_MODE_RGMII:
> > > > +                     regmap_field_write(regmap_fields[GMAC0_USE_TX=
CLK], 0);
> > > > +                     regmap_field_write(regmap_fields[GMAC0_USE_PW=
M01], 0);
> > > > +                     break;
> > > > +             case PHY_INTERFACE_MODE_MII:
> > > > +                     regmap_field_write(regmap_fields[GMAC0_USE_TX=
CLK], 1);
> > > > +                     regmap_field_write(regmap_fields[GMAC0_USE_PW=
M01], 1);
> > > > +                     break;
> > > > +             default:
> > > > +                     dev_err(dwmac->dev, "Unsupported PHY mode %u\=
n",
> > > > +                             plat->phy_interface);
> > > > +                     return -EOPNOTSUPP;
> > > > +             }
> > > > +
> > > > +             regmap_field_write(regmap_fields[GMAC0_SHUT], 0);
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int ls1c_dwmac_syscon_init(struct plat_stmmacenet_data *pla=
t)
> > > > +{
> > > > +     struct ls1x_dwmac *dwmac =3D plat->bsp_priv;
> > > > +     struct regmap_field **regmap_fields =3D dwmac->regmap_fields;
> > > > +
> > > > +     if (plat->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII) {
> > > > +             regmap_field_write(regmap_fields[PHY_INTF_SELI], 0x4)=
;
> > > > +     } else {
> > > > +             dev_err(dwmac->dev, "Unsupported PHY-mode %u\n",
> > > > +                     plat->phy_interface);
> > > > +             return -EOPNOTSUPP;
> > > > +     }
> > > > +
> > > > +     regmap_field_write(regmap_fields[GMAC_SHUT], 0);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static const struct ls1x_dwmac_syscon ls1b_dwmac_syscon =3D {
> > > > +     .reg_fields =3D ls1b_dwmac_syscon_regfields,
> > > > +     .nr_reg_fields =3D ARRAY_SIZE(ls1b_dwmac_syscon_regfields),
> > > > +     .syscon_init =3D ls1b_dwmac_syscon_init,
> > > > +};
> > > > +
> > > > +static const struct ls1x_dwmac_syscon ls1c_dwmac_syscon =3D {
> > > > +     .reg_fields =3D ls1c_dwmac_syscon_regfields,
> > > > +     .nr_reg_fields =3D ARRAY_SIZE(ls1c_dwmac_syscon_regfields),
> > > > +     .syscon_init =3D ls1c_dwmac_syscon_init,
> > > > +};
> > > > +
> > > > +static int ls1x_dwmac_init(struct platform_device *pdev, void *pri=
v)
> > > > +{
> > > > +     struct ls1x_dwmac *dwmac =3D priv;
> > > > +     int ret;
> > > > +
> > >
> > > > +     ret =3D devm_regmap_field_bulk_alloc(dwmac->dev, dwmac->regma=
p,
> > > > +                                        dwmac->regmap_fields,
> > > > +                                        dwmac->syscon->reg_fields,
> > > > +                                        dwmac->syscon->nr_reg_fiel=
ds);
> > >
> > > Please see my first comment about this.
> > >
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     if (dwmac->syscon->syscon_init) {
> > > > +             ret =3D dwmac->syscon->syscon_init(dwmac->plat_dat);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static const struct of_device_id ls1x_dwmac_syscon_match[] =3D {
> > > > +     { .compatible =3D "loongson,ls1b-syscon", .data =3D &ls1b_dwm=
ac_syscon },
> > > > +     { .compatible =3D "loongson,ls1c-syscon", .data =3D &ls1c_dwm=
ac_syscon },
> > > > +     { }
> > > > +};
> > > > +
> > > > +static int ls1x_dwmac_probe(struct platform_device *pdev)
> > > > +{
> > > > +     struct plat_stmmacenet_data *plat_dat;
> > > > +     struct stmmac_resources stmmac_res;
> > > > +     struct device_node *syscon_np;
> > > > +     const struct of_device_id *match;
> > > > +     struct regmap *regmap;
> > > > +     struct ls1x_dwmac *dwmac;
> > > > +     const struct ls1x_dwmac_syscon *syscon;
> > > > +     size_t size;
> > > > +     int ret;
> > > > +
> > > > +     ret =3D stmmac_get_platform_resources(pdev, &stmmac_res);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > >
> > > > +     /* Probe syscon */
> > > > +     syscon_np =3D of_parse_phandle(pdev->dev.of_node, "syscon", 0=
);
> > >
> > > it's vendor-specific property so it is supposed to have a
> > > vendor-specific prefix and possibly ls1-specific name.
> > >
> > This has been fixed in v2.
> > Could you please review v2?
> > Thanks!
> >
> > > > +     if (!syscon_np)
> > > > +             return -ENODEV;
> > > > +
> > > > +     match =3D of_match_node(ls1x_dwmac_syscon_match, syscon_np);
> > > > +     if (!match) {
> > > > +             of_node_put(syscon_np);
> > > > +             return -EINVAL;
> > > > +     }
> > > > +     syscon =3D (const struct ls1x_dwmac_syscon *)match->data;

Please note that of_match_node() is used for syscon matching.

> > > > +
> > > > +     regmap =3D syscon_node_to_regmap(syscon_np);
> > > > +     of_node_put(syscon_np);
> > > > +     if (IS_ERR(regmap)) {
> > > > +             ret =3D PTR_ERR(regmap);
> > > > +             dev_err(&pdev->dev, "Unable to map syscon: %d\n", ret=
);
> > > > +             return ret;
> > > > +     }
> > >
> > > or you can use syscon_regmap_lookup_by_phandle(). Using
> > > of_match_node() doesn't seem necessary since it's unlikely to have
> > > moee than one system controller available on the LS1b or LS1c chips.
> > >
>
> > I planned to use syscon_regmap_lookup_by_phandle().
> > Thus the compatible
> > "loongson,ls1b-dwmac-syscon"/"loongson,ls1c-dwmac-syscon" would become
> > useless.
> > I'm not sure about this.
>
> The compatible strings should be left despite of the
> syscon_regmap_lookup_by_phandle() usage. But again "dwmac" suffix is
> redundant. Based on the CSRs definition in regs-mux.h, selecting
> (G)MAC pins mode is only a small part of the Loongson1 SoC system
> controllers functionality.
> "loongson,ls1b-syscon"/"loongson,ls1c-syscon" looks more appropriate.
>
That's what I did in PATCH 2/5.
I've just explained this to Krzysztof.
And will change back to "loongson,ls1b-syscon"/"loongson,ls1c-syscon"
in next version.

In addition, syscon_regmap_lookup_by_phandle() returns regmap pointer direc=
tly.
Then, there wil be no way to do syscon matching without its device_node.
How will I know whether the syscon is loongson,ls1b-syscon or
loongson,ls1c-syscon?

Thanks for your review!





> -Serge(y)
>
> >
> > > > +
> > > > +     size =3D syscon->nr_reg_fields * sizeof(struct regmap_field *=
);
> > > > +     dwmac =3D devm_kzalloc(&pdev->dev, sizeof(*dwmac) + size, GFP=
_KERNEL);
> > > > +     if (!dwmac)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     plat_dat =3D stmmac_probe_config_dt(pdev, stmmac_res.mac);
> > > > +     if (IS_ERR(plat_dat)) {
> > > > +             dev_err(&pdev->dev, "dt configuration failed\n");
> > > > +             return PTR_ERR(plat_dat);
> > > > +     }
> > > > +
> > > > +     plat_dat->bsp_priv =3D dwmac;
> > > > +     plat_dat->init =3D ls1x_dwmac_init;
> > > > +     dwmac->dev =3D &pdev->dev;
> > > > +     dwmac->plat_dat =3D plat_dat;
> > > > +     dwmac->syscon =3D syscon;
> > > > +     dwmac->regmap =3D regmap;
> > > > +
> > > > +     ret =3D stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
> > > > +     if (ret)
> > > > +             goto err_remove_config_dt;
> > > > +
> > > > +     return 0;
> > > > +
> > > > +err_remove_config_dt:
> > >
> > > > +     if (pdev->dev.of_node)
> > >
> > > Is this conditional statement necessary here?
> > >
> > You're right.
> > Will remove this condition in next version.
> > Thanks!
> >
> > > -Serge
> > >
> > > > +             stmmac_remove_config_dt(pdev, plat_dat);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static const struct of_device_id ls1x_dwmac_match[] =3D {
> > > > +     { .compatible =3D "loongson,ls1b-dwmac" },
> > > > +     { .compatible =3D "loongson,ls1c-dwmac" },
> > > > +     { }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, ls1x_dwmac_match);
> > > > +
> > > > +static struct platform_driver ls1x_dwmac_driver =3D {
> > > > +     .probe =3D ls1x_dwmac_probe,
> > > > +     .remove_new =3D stmmac_pltfr_remove,
> > > > +     .driver =3D {
> > > > +             .name =3D "loongson1-dwmac",
> > > > +             .of_match_table =3D ls1x_dwmac_match,
> > > > +     },
> > > > +};
> > > > +module_platform_driver(ls1x_dwmac_driver);
> > > > +
> > > > +MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
> > > > +MODULE_DESCRIPTION("Loongson1 DWMAC glue layer");
> > > > +MODULE_LICENSE("GPL");
> > > > --
> > > > 2.39.2
> > > >
> >
> >
> >
> > --
> > Best regards,
> >
> > Keguang Zhang



--
Best regards,

Keguang Zhang
