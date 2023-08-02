Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CCE76C35A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 05:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjHBDKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 23:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjHBDKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 23:10:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE138FB;
        Tue,  1 Aug 2023 20:10:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so971379a12.1;
        Tue, 01 Aug 2023 20:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690945827; x=1691550627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2a3Ssk8cTe+A9W+eVmPkSF4Nb+GwQDLGB6gwc+P+MSA=;
        b=NUEq9tKFNn7D8UFJKOrMIlf0hqzP8XiDGQOK+8CdfIoARwSPMMj/1T4t6/EP03e/Pt
         qBRQz1i1rWLpXZShAEq6jmZGTb0cjfo3etnv+Jo5ZGGz0+ekhYj9NLHC2Tn8BhVy29Mh
         MB8fKFF31Q6eQWhfXU2Ck1FvgpXuG8i4cd2gDoPZOGdwsJxHGJNbrxaqhjOLCbCArweo
         VUOPn9B4kKs+l4uj31muOMIFlVWPwn/RFDoUcs0viIYPz18yuB+wfmHjJiQ2QdjymXrP
         BQFya7H3kKw3a8Dd0Ka+JHMcQIWuGmKX1moY6p4AUYsjwQpxfyAtUTaSbNxske52D861
         KtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690945827; x=1691550627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2a3Ssk8cTe+A9W+eVmPkSF4Nb+GwQDLGB6gwc+P+MSA=;
        b=csFnWJVWIJhPFgatpyf9eqUbkDCTbEme0o6sgoSCzP9pObRK9E7Qj5UBFbLJFpXkUK
         EjbaTlt5XlPPX3UqxnGqk/cQN7aluMFEEtmXk4Tb6bGRZg1JF2ExrA6Jj4E/uAx/JFMA
         6k4kLJ2abVJm7UwLgADiMMbAQOJVGbpeSHYEVMZVCp3gacJWM3L8vmmQU1gE/y78weYc
         8E7c1ASjclocHkm45CXmK534HCsE6DuxszQEbMiI27TJqwmx6Tp0LhsBJVm2cRYI5ekH
         L23dO7WYgDCfFJOh4YJm/MUUWxikBnmK/+OUsn8+phYyOTtsQsB6m+NfxCjLBZib//3F
         GlfA==
X-Gm-Message-State: ABy/qLb9EDjcqj6V+ds3TRBCL4MJ4JQnzbcG7UgmwBeMFHYt8xaYmA35
        9HDP+Jel+pkbfwUuHcNNjrbxUcnCgDDfGUDo4Kc=
X-Google-Smtp-Source: APBJJlGjQHb7ld0fX4J6DpVlS+EGR8wcya/AW3vbMutHFfSPRDmkYVBjMMZ2BP97SgcgRGW4yD6xW2yeQJgx081DsYU=
X-Received: by 2002:a05:6402:2747:b0:522:b723:11bd with SMTP id
 z7-20020a056402274700b00522b72311bdmr5717109edd.4.1690945827210; Tue, 01 Aug
 2023 20:10:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
 <20230729134318.1694467-9-keguang.zhang@gmail.com> <4qk22kycanwwbx6e7w4uuf7y5re7y4voi5vdurq3usa27py2zk@zms25h4hg2da>
In-Reply-To: <4qk22kycanwwbx6e7w4uuf7y5re7y4voi5vdurq3usa27py2zk@zms25h4hg2da>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Wed, 2 Aug 2023 11:10:10 +0800
Message-ID: <CAJhJPsV9E5=GtsjiP8c3A6=4=Vh7cB1g=TaaJnVOjCf=VFiLUA@mail.gmail.com>
Subject: Re: [PATCH 08/17] MIPS: loongson32: Convert Ethernet platform device
 to DT
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 2:21=E2=80=AFAM Serge Semin <fancer.lancer@gmail.com=
> wrote:
>
> On Sat, Jul 29, 2023 at 09:43:09PM +0800, Keguang Zhang wrote:
> > Add Ethernet device nodes for Loongson-1 boards,
> > and drop the legacy platform devices and data accordingly.
>
> It seems to me that your conversion breaks the RGMII mode support.
> What you need to do is to make sure that the respective flags are set
> in the MUX space.
>
> Regarding the MUX-space. It looks as a pinctrl-setting space. If so
> adding the new pinctrl driver will be required. Otherwise it can be
> defined as a syscon-node and then utilized in the Loongson-1 GMAC
> low-level driver.
>
Thanks for your reminder.
I planned to add the pinctrl driver later.
Now I'm working on it.

> -Serge(y)
>
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  arch/mips/boot/dts/loongson/loongson1.dtsi    |  16 ++
> >  arch/mips/boot/dts/loongson/loongson1b.dtsi   |  53 +++++++
> >  arch/mips/boot/dts/loongson/loongson1c.dtsi   |  17 ++
> >  arch/mips/boot/dts/loongson/lsgz_1b_dev.dts   |   8 +
> >  arch/mips/boot/dts/loongson/smartloong_1c.dts |   4 +
> >  arch/mips/loongson32/common/platform.c        | 146 +-----------------
> >  arch/mips/loongson32/ls1b/board.c             |   2 -
> >  arch/mips/loongson32/ls1c/board.c             |   1 -
> >  8 files changed, 99 insertions(+), 148 deletions(-)
> >
> > diff --git a/arch/mips/boot/dts/loongson/loongson1.dtsi b/arch/mips/boo=
t/dts/loongson/loongson1.dtsi
> > index c77aa2d0f66c..48bb786bbf10 100644
> > --- a/arch/mips/boot/dts/loongson/loongson1.dtsi
> > +++ b/arch/mips/boot/dts/loongson/loongson1.dtsi
> > @@ -71,6 +71,22 @@ intc3: interrupt-controller@1fd01088 {
> >                       interrupt-parent =3D <&cpu_intc>;
> >                       interrupts =3D <5>;
> >               };
> > +
> > +             gmac0: ethernet@1fe10000 {
> > +                     compatible =3D "snps,dwmac-3.70a";
> > +                     reg =3D <0x1fe10000 0x10000>;
> > +
> > +                     interrupt-parent =3D <&intc1>;
> > +                     interrupt-names =3D "macirq";
> > +
> > +                     clocks =3D <&clkc LS1X_CLKID_AHB>;
> > +                     clock-names =3D "stmmaceth";
> > +
> > +                     snps,pbl =3D <1>;
> > +
> > +                     status =3D "disabled";
> > +             };
> > +
> >       };
> >
> >       apb: bus@1fe40000 {
> > diff --git a/arch/mips/boot/dts/loongson/loongson1b.dtsi b/arch/mips/bo=
ot/dts/loongson/loongson1b.dtsi
> > index 437a77cee163..42b96c557660 100644
> > --- a/arch/mips/boot/dts/loongson/loongson1b.dtsi
> > +++ b/arch/mips/boot/dts/loongson/loongson1b.dtsi
> > @@ -7,6 +7,11 @@
> >  #include "loongson1.dtsi"
> >
> >  / {
> > +     aliases {
> > +             ethernet0 =3D &gmac0;
> > +             ethernet1 =3D &gmac1;
> > +     };
> > +
> >       cpus {
> >               #address-cells =3D <1>;
> >               #size-cells =3D <0>;
> > @@ -74,6 +79,54 @@ clkc: clock-controller@1fe78030 {
> >       };
> >  };
> >
> > +&ahb {
> > +     gmac1: ethernet@1fe20000 {
> > +             compatible =3D "snps,dwmac-3.70a";
> > +             reg =3D <0x1fe20000 0x10000>;
> > +
> > +             interrupt-parent =3D <&intc1>;
> > +             interrupts =3D <3 IRQ_TYPE_LEVEL_HIGH>;
> > +             interrupt-names =3D "macirq";
> > +
> > +             clocks =3D <&clkc LS1X_CLKID_AHB>;
> > +             clock-names =3D "stmmaceth";
> > +
> > +             phy-handle =3D <&phy1>;
> > +             phy-mode =3D "mii";
> > +
> > +             snps,pbl =3D <1>;
> > +
> > +             status =3D "disabled";
> > +
> > +             mdio1 {
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +                     compatible =3D "snps,dwmac-mdio";
> > +
> > +                     phy1: ethernet-phy@0 {
> > +                             reg =3D <0x0>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&gmac0 {
> > +     interrupts =3D <2 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +     phy-handle =3D <&phy0>;
> > +     phy-mode =3D "mii";
> > +
> > +     mdio0 {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             compatible =3D "snps,dwmac-mdio";
> > +
> > +             phy0: ethernet-phy@0 {
> > +                     reg =3D <0x0>;
> > +             };
> > +     };
> > +};
> > +
> >  &uart1 {
> >       interrupts =3D <3 IRQ_TYPE_LEVEL_HIGH>;
> >  };
> > diff --git a/arch/mips/boot/dts/loongson/loongson1c.dtsi b/arch/mips/bo=
ot/dts/loongson/loongson1c.dtsi
> > index 1dd575b7b2f9..5b3e0f9280f6 100644
> > --- a/arch/mips/boot/dts/loongson/loongson1c.dtsi
> > +++ b/arch/mips/boot/dts/loongson/loongson1c.dtsi
> > @@ -41,6 +41,23 @@ intc4: interrupt-controller@1fd010a0 {
> >       };
> >  };
> >
> > +&gmac0 {
> > +     interrupts =3D <3 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +     phy-handle =3D <&phy0>;
> > +     phy-mode =3D "rmii";
> > +
> > +     mdio0 {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +             compatible =3D "snps,dwmac-mdio";
> > +
> > +             phy0: ethernet-phy@13 {
> > +                     reg =3D <0x13>;
> > +             };
> > +     };
> > +};
> > +
> >  &uart1 {
> >       interrupts =3D <4 IRQ_TYPE_LEVEL_HIGH>;
> >  };
> > diff --git a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts b/arch/mips/bo=
ot/dts/loongson/lsgz_1b_dev.dts
> > index 89c3dfa574f7..a43df21f2904 100644
> > --- a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
> > +++ b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
> > @@ -28,6 +28,14 @@ xtal: xtal {
> >       };
> >  };
> >
> > +&gmac0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&gmac1 {
> > +     status =3D "okay";
> > +};
> > +
> >  &uart0 {
> >       status =3D "okay";
> >  };
> > diff --git a/arch/mips/boot/dts/loongson/smartloong_1c.dts b/arch/mips/=
boot/dts/loongson/smartloong_1c.dts
> > index 188aab9e3685..2d8f304aa2c4 100644
> > --- a/arch/mips/boot/dts/loongson/smartloong_1c.dts
> > +++ b/arch/mips/boot/dts/loongson/smartloong_1c.dts
> > @@ -28,6 +28,10 @@ xtal: xtal {
> >       };
> >  };
> >
> > +&gmac0 {
> > +     status =3D "okay";
> > +};
> > +
> >  &uart0 {
> >       status =3D "okay";
> >  };
> > diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongso=
n32/common/platform.c
> > index 8272b4133e25..817518531b9b 100644
> > --- a/arch/mips/loongson32/common/platform.c
> > +++ b/arch/mips/loongson32/common/platform.c
> > @@ -8,157 +8,13 @@
> >  #include <linux/err.h>
> >  #include <linux/mtd/partitions.h>
> >  #include <linux/sizes.h>
> > -#include <linux/phy.h>
> > -#include <linux/stmmac.h>
> >  #include <linux/usb/ehci_pdriver.h>
> >
> >  #include <platform.h>
> >  #include <loongson1.h>
> >  #include <dma.h>
> >  #include <nand.h>
> > -
> > -/* Synopsys Ethernet GMAC */
> > -static struct stmmac_mdio_bus_data ls1x_mdio_bus_data =3D {
> > -     .phy_mask       =3D 0,
> > -};
> > -
> > -static struct stmmac_dma_cfg ls1x_eth_dma_cfg =3D {
> > -     .pbl            =3D 1,
> > -};
> > -
> > -int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
> > -{
> > -     struct plat_stmmacenet_data *plat_dat =3D NULL;
> > -     u32 val;
> > -
> > -     val =3D __raw_readl(LS1X_MUX_CTRL1);
> > -
> > -#if defined(CONFIG_LOONGSON1_LS1B)
> > -     plat_dat =3D dev_get_platdata(&pdev->dev);
> > -     if (plat_dat->bus_id) {
> > -             __raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART=
1 |
> > -                          GMAC1_USE_UART0, LS1X_MUX_CTRL0);
> > -             switch (plat_dat->phy_interface) {
> > -             case PHY_INTERFACE_MODE_RGMII:
> > -                     val &=3D ~(GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
> > -                     break;
> > -             case PHY_INTERFACE_MODE_MII:
> > -                     val |=3D (GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
> > -                     break;
> > -             default:
> > -                     pr_err("unsupported mii mode %d\n",
> > -                            plat_dat->phy_interface);
> > -                     return -ENOTSUPP;
> > -             }
> > -             val &=3D ~GMAC1_SHUT;
> > -     } else {
> > -             switch (plat_dat->phy_interface) {
> > -             case PHY_INTERFACE_MODE_RGMII:
> > -                     val &=3D ~(GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
> > -                     break;
> > -             case PHY_INTERFACE_MODE_MII:
> > -                     val |=3D (GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
> > -                     break;
> > -             default:
> > -                     pr_err("unsupported mii mode %d\n",
> > -                            plat_dat->phy_interface);
> > -                     return -ENOTSUPP;
> > -             }
> > -             val &=3D ~GMAC0_SHUT;
> > -     }
> > -     __raw_writel(val, LS1X_MUX_CTRL1);
> > -#elif defined(CONFIG_LOONGSON1_LS1C)
> > -     plat_dat =3D dev_get_platdata(&pdev->dev);
> > -
> > -     val &=3D ~PHY_INTF_SELI;
> > -     if (plat_dat->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII)
> > -             val |=3D 0x4 << PHY_INTF_SELI_SHIFT;
> > -     __raw_writel(val, LS1X_MUX_CTRL1);
> > -
> > -     val =3D __raw_readl(LS1X_MUX_CTRL0);
> > -     __raw_writel(val & (~GMAC_SHUT), LS1X_MUX_CTRL0);
> > -#endif
> > -
> > -     return 0;
> > -}
> > -
> > -static struct plat_stmmacenet_data ls1x_eth0_pdata =3D {
> > -     .bus_id                 =3D 0,
> > -     .phy_addr               =3D -1,
> > -#if defined(CONFIG_LOONGSON1_LS1B)
> > -     .phy_interface          =3D PHY_INTERFACE_MODE_MII,
> > -#elif defined(CONFIG_LOONGSON1_LS1C)
> > -     .phy_interface          =3D PHY_INTERFACE_MODE_RMII,
> > -#endif
> > -     .mdio_bus_data          =3D &ls1x_mdio_bus_data,
> > -     .dma_cfg                =3D &ls1x_eth_dma_cfg,
> > -     .has_gmac               =3D 1,
> > -     .tx_coe                 =3D 1,
> > -     .rx_queues_to_use       =3D 1,
> > -     .tx_queues_to_use       =3D 1,
> > -     .init                   =3D ls1x_eth_mux_init,
> > -};
> > -
> > -static struct resource ls1x_eth0_resources[] =3D {
> > -     [0] =3D {
> > -             .start  =3D LS1X_GMAC0_BASE,
> > -             .end    =3D LS1X_GMAC0_BASE + SZ_64K - 1,
> > -             .flags  =3D IORESOURCE_MEM,
> > -     },
> > -     [1] =3D {
> > -             .name   =3D "macirq",
> > -             .start  =3D LS1X_GMAC0_IRQ,
> > -             .flags  =3D IORESOURCE_IRQ,
> > -     },
> > -};
> > -
> > -struct platform_device ls1x_eth0_pdev =3D {
> > -     .name           =3D "stmmaceth",
> > -     .id             =3D 0,
> > -     .num_resources  =3D ARRAY_SIZE(ls1x_eth0_resources),
> > -     .resource       =3D ls1x_eth0_resources,
> > -     .dev            =3D {
> > -             .platform_data =3D &ls1x_eth0_pdata,
> > -     },
> > -};
> > -
> > -#ifdef CONFIG_LOONGSON1_LS1B
> > -static struct plat_stmmacenet_data ls1x_eth1_pdata =3D {
> > -     .bus_id                 =3D 1,
> > -     .phy_addr               =3D -1,
> > -     .phy_interface          =3D PHY_INTERFACE_MODE_MII,
> > -     .mdio_bus_data          =3D &ls1x_mdio_bus_data,
> > -     .dma_cfg                =3D &ls1x_eth_dma_cfg,
> > -     .has_gmac               =3D 1,
> > -     .tx_coe                 =3D 1,
> > -     .rx_queues_to_use       =3D 1,
> > -     .tx_queues_to_use       =3D 1,
> > -     .init                   =3D ls1x_eth_mux_init,
> > -};
> > -
> > -static struct resource ls1x_eth1_resources[] =3D {
> > -     [0] =3D {
> > -             .start  =3D LS1X_GMAC1_BASE,
> > -             .end    =3D LS1X_GMAC1_BASE + SZ_64K - 1,
> > -             .flags  =3D IORESOURCE_MEM,
> > -     },
> > -     [1] =3D {
> > -             .name   =3D "macirq",
> > -             .start  =3D LS1X_GMAC1_IRQ,
> > -             .flags  =3D IORESOURCE_IRQ,
> > -     },
> > -};
> > -
> > -struct platform_device ls1x_eth1_pdev =3D {
> > -     .name           =3D "stmmaceth",
> > -     .id             =3D 1,
> > -     .num_resources  =3D ARRAY_SIZE(ls1x_eth1_resources),
> > -     .resource       =3D ls1x_eth1_resources,
> > -     .dev            =3D {
> > -             .platform_data =3D &ls1x_eth1_pdata,
> > -     },
> > -};
> > -#endif       /* CONFIG_LOONGSON1_LS1B */
> > +#include <irq.h>
> >
> >  /* GPIO */
> >  static struct resource ls1x_gpio0_resources[] =3D {
> > diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/l=
s1b/board.c
> > index e8290f200096..f23e4e5c96ee 100644
> > --- a/arch/mips/loongson32/ls1b/board.c
> > +++ b/arch/mips/loongson32/ls1b/board.c
> > @@ -34,8 +34,6 @@ static const struct gpio_led_platform_data ls1x_led_p=
data __initconst =3D {
> >  };
> >
> >  static struct platform_device *ls1b_platform_devices[] __initdata =3D =
{
> > -     &ls1x_eth0_pdev,
> > -     &ls1x_eth1_pdev,
> >       &ls1x_ehci_pdev,
> >       &ls1x_gpio0_pdev,
> >       &ls1x_gpio1_pdev,
> > diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/l=
s1c/board.c
> > index a7096964fb30..29bc467fd149 100644
> > --- a/arch/mips/loongson32/ls1c/board.c
> > +++ b/arch/mips/loongson32/ls1c/board.c
> > @@ -6,7 +6,6 @@
> >  #include <platform.h>
> >
> >  static struct platform_device *ls1c_platform_devices[] __initdata =3D =
{
> > -     &ls1x_eth0_pdev,
> >       &ls1x_rtc_pdev,
> >       &ls1x_wdt_pdev,
> >  };
> > --
> > 2.39.2
> >



--=20
Best regards,

Keguang Zhang
