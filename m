Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27A276C9BC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjHBJpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjHBJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:45:13 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4342115;
        Wed,  2 Aug 2023 02:44:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe11652b64so11074681e87.0;
        Wed, 02 Aug 2023 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690969487; x=1691574287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RtQzw0jzv4kHzibS6cN6GdSL90VICzPs0MdXIJlwfx0=;
        b=Z3HdXU5f6Io9fJ0FpRDAubgYJ5ytFoueY3ifMmOqgWU19MRIYq/KAVX3QPq+DCjXld
         tRmwdTE4AdE3y0R4p/hGaOW7MK90rYkOx42KWeNb+07xUq7YRorhZRBbJZBvMvoNFvq1
         EbdcLz3117vosb4Lx1dwhka//EE+4M/a+zB96PNXLZUP/aV6J2mOoyhftiwh9NpnRzar
         bHmaMOl6jtWQHULLXi701rtngO/6RO8veT7j+dFyJsqCGZ3yLxU7jzuKzawcMp4k0RJ4
         E2Uwe2HT7lVqzZCgpjN9Z1oW6YAyR+U8rOeyAE+dXbEd/DvAtr8zjpTE62yASl4G+sPE
         kovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690969487; x=1691574287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtQzw0jzv4kHzibS6cN6GdSL90VICzPs0MdXIJlwfx0=;
        b=AJEEc7LUR6fM85/TxHcoVwwbCXdNvWYxRgvBwKQv7J2qfduhg8R+r8ltvLgdLUBtVe
         PfH5Nfac6ltKpwd7FAsBCtz0NBxCERkTLuy7QkYUCeQzL+KH7K9B9Sms8oPOA8V64Td1
         hgaUj4Y3dyxdPnewbV1SkY6VBaIUnPnvZRu9LX2uX/MmlnIHeYoXLErBmikoLTQDzUSw
         SPJq39/9EBFQqb7KxVYRQMkticzQ2djSJ+CJuktWB+7Ob4Cs7eMw1MBuDw5etFNdCQuP
         UzbbhHoP3vBL5rt9PrmuaQGzsuVxv/fTeg/3gE6PwnUVLyIv0iI3zeSOQ69ei6cTqgW5
         ugkw==
X-Gm-Message-State: ABy/qLZaIkNCT4KrcxzxNs6k8PBh73fm4X+eQrcexcC2PdYOEm5PEbDP
        +Fh3IjRLDvN8ecF2Wngz418Ewqg5Sv8=
X-Google-Smtp-Source: APBJJlGOEMG3UvtGM/NgBy5VQeEe4/4y/JmlS7Bfq3UFb2A8qiKqrft4oTPGUzthplbJF5Y0eV5nlA==
X-Received: by 2002:a19:4f4e:0:b0:4fb:820a:f87f with SMTP id a14-20020a194f4e000000b004fb820af87fmr4409106lfk.10.1690969487215;
        Wed, 02 Aug 2023 02:44:47 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id o12-20020a05651238ac00b004fe0c3d8bb4sm2877682lft.84.2023.08.02.02.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 02:44:46 -0700 (PDT)
Date:   Wed, 2 Aug 2023 12:44:42 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 08/17] MIPS: loongson32: Convert Ethernet platform device
 to DT
Message-ID: <sxuwhp3jc7e5tma5sj5xfkbs43ax2p7oucgy5aoh66pnyr6x2m@logqlgthsy66>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
 <20230729134318.1694467-9-keguang.zhang@gmail.com>
 <4qk22kycanwwbx6e7w4uuf7y5re7y4voi5vdurq3usa27py2zk@zms25h4hg2da>
 <CAJhJPsV9E5=GtsjiP8c3A6=4=Vh7cB1g=TaaJnVOjCf=VFiLUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tecqq4v2edoarqvd"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhJPsV9E5=GtsjiP8c3A6=4=Vh7cB1g=TaaJnVOjCf=VFiLUA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tecqq4v2edoarqvd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Aug 02, 2023 at 11:10:10AM +0800, Keguang Zhang wrote:
> On Wed, Aug 2, 2023 at 2:21 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Sat, Jul 29, 2023 at 09:43:09PM +0800, Keguang Zhang wrote:
> > > Add Ethernet device nodes for Loongson-1 boards,
> > > and drop the legacy platform devices and data accordingly.
> >
> > It seems to me that your conversion breaks the RGMII mode support.
> > What you need to do is to make sure that the respective flags are set
> > in the MUX space.
> >
> > Regarding the MUX-space. It looks as a pinctrl-setting space. If so
> > adding the new pinctrl driver will be required. Otherwise it can be
> > defined as a syscon-node and then utilized in the Loongson-1 GMAC
> > low-level driver.
> >

> Thanks for your reminder.
> I planned to add the pinctrl driver later.
> Now I'm working on it.

I have been having a patch moving the Loongson32 MAC driver to the
STMMAC driver directory for quite a while in my tree. You can use it
in your series (completely, as a reference or template, whatever). The
only thing you'll need to do is to add the pinctrl-based version of
the ls1b_eth_mux_init()/ls1c_eth_mux_init() methods in there and
test/debug it of course.

Note 1. It seems to me that it would work better if you defined the
plat_stmmacenet_data.fix_mac_speed() callback instead of
plat_stmmacenet_data.init() for LS1B which supports MII and RGMII aka
100Mbps and 1000Mbps speeds.

Note 2. The patch I've sent was only built-tested. I don't have any
Loongson hardware.

Note 3. After the suggested patch is applied you can also completely
move the include/linux/stmmac.h header file to the STMMAC-driver
directory as a following up cleanup update (it should be renamed to
stmmac_platform.h since stmmac.h is already available in there).
It can be done since there won't any users of that file outside the
STMMAC-driver directory. So there is no point in keeping it in the
common headers directory anymore.

-Serge(y)

> 
> > -Serge(y)
> >
> > >
> > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > ---
> > >  arch/mips/boot/dts/loongson/loongson1.dtsi    |  16 ++
> > >  arch/mips/boot/dts/loongson/loongson1b.dtsi   |  53 +++++++
> > >  arch/mips/boot/dts/loongson/loongson1c.dtsi   |  17 ++
> > >  arch/mips/boot/dts/loongson/lsgz_1b_dev.dts   |   8 +
> > >  arch/mips/boot/dts/loongson/smartloong_1c.dts |   4 +
> > >  arch/mips/loongson32/common/platform.c        | 146 +-----------------
> > >  arch/mips/loongson32/ls1b/board.c             |   2 -
> > >  arch/mips/loongson32/ls1c/board.c             |   1 -
> > >  8 files changed, 99 insertions(+), 148 deletions(-)
> > >
> > > diff --git a/arch/mips/boot/dts/loongson/loongson1.dtsi b/arch/mips/boot/dts/loongson/loongson1.dtsi
> > > index c77aa2d0f66c..48bb786bbf10 100644
> > > --- a/arch/mips/boot/dts/loongson/loongson1.dtsi
> > > +++ b/arch/mips/boot/dts/loongson/loongson1.dtsi
> > > @@ -71,6 +71,22 @@ intc3: interrupt-controller@1fd01088 {
> > >                       interrupt-parent = <&cpu_intc>;
> > >                       interrupts = <5>;
> > >               };
> > > +
> > > +             gmac0: ethernet@1fe10000 {
> > > +                     compatible = "snps,dwmac-3.70a";
> > > +                     reg = <0x1fe10000 0x10000>;
> > > +
> > > +                     interrupt-parent = <&intc1>;
> > > +                     interrupt-names = "macirq";
> > > +
> > > +                     clocks = <&clkc LS1X_CLKID_AHB>;
> > > +                     clock-names = "stmmaceth";
> > > +
> > > +                     snps,pbl = <1>;
> > > +
> > > +                     status = "disabled";
> > > +             };
> > > +
> > >       };
> > >
> > >       apb: bus@1fe40000 {
> > > diff --git a/arch/mips/boot/dts/loongson/loongson1b.dtsi b/arch/mips/boot/dts/loongson/loongson1b.dtsi
> > > index 437a77cee163..42b96c557660 100644
> > > --- a/arch/mips/boot/dts/loongson/loongson1b.dtsi
> > > +++ b/arch/mips/boot/dts/loongson/loongson1b.dtsi
> > > @@ -7,6 +7,11 @@
> > >  #include "loongson1.dtsi"
> > >
> > >  / {
> > > +     aliases {
> > > +             ethernet0 = &gmac0;
> > > +             ethernet1 = &gmac1;
> > > +     };
> > > +
> > >       cpus {
> > >               #address-cells = <1>;
> > >               #size-cells = <0>;
> > > @@ -74,6 +79,54 @@ clkc: clock-controller@1fe78030 {
> > >       };
> > >  };
> > >
> > > +&ahb {
> > > +     gmac1: ethernet@1fe20000 {
> > > +             compatible = "snps,dwmac-3.70a";
> > > +             reg = <0x1fe20000 0x10000>;
> > > +
> > > +             interrupt-parent = <&intc1>;
> > > +             interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> > > +             interrupt-names = "macirq";
> > > +
> > > +             clocks = <&clkc LS1X_CLKID_AHB>;
> > > +             clock-names = "stmmaceth";
> > > +
> > > +             phy-handle = <&phy1>;
> > > +             phy-mode = "mii";
> > > +
> > > +             snps,pbl = <1>;
> > > +
> > > +             status = "disabled";
> > > +
> > > +             mdio1 {
> > > +                     #address-cells = <1>;
> > > +                     #size-cells = <0>;
> > > +                     compatible = "snps,dwmac-mdio";
> > > +
> > > +                     phy1: ethernet-phy@0 {
> > > +                             reg = <0x0>;
> > > +                     };
> > > +             };
> > > +     };
> > > +};
> > > +
> > > +&gmac0 {
> > > +     interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +     phy-handle = <&phy0>;
> > > +     phy-mode = "mii";
> > > +
> > > +     mdio0 {
> > > +             #address-cells = <1>;
> > > +             #size-cells = <0>;
> > > +             compatible = "snps,dwmac-mdio";
> > > +
> > > +             phy0: ethernet-phy@0 {
> > > +                     reg = <0x0>;
> > > +             };
> > > +     };
> > > +};
> > > +
> > >  &uart1 {
> > >       interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> > >  };
> > > diff --git a/arch/mips/boot/dts/loongson/loongson1c.dtsi b/arch/mips/boot/dts/loongson/loongson1c.dtsi
> > > index 1dd575b7b2f9..5b3e0f9280f6 100644
> > > --- a/arch/mips/boot/dts/loongson/loongson1c.dtsi
> > > +++ b/arch/mips/boot/dts/loongson/loongson1c.dtsi
> > > @@ -41,6 +41,23 @@ intc4: interrupt-controller@1fd010a0 {
> > >       };
> > >  };
> > >
> > > +&gmac0 {
> > > +     interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +     phy-handle = <&phy0>;
> > > +     phy-mode = "rmii";
> > > +
> > > +     mdio0 {
> > > +             #address-cells = <1>;
> > > +             #size-cells = <0>;
> > > +             compatible = "snps,dwmac-mdio";
> > > +
> > > +             phy0: ethernet-phy@13 {
> > > +                     reg = <0x13>;
> > > +             };
> > > +     };
> > > +};
> > > +
> > >  &uart1 {
> > >       interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> > >  };
> > > diff --git a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
> > > index 89c3dfa574f7..a43df21f2904 100644
> > > --- a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
> > > +++ b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
> > > @@ -28,6 +28,14 @@ xtal: xtal {
> > >       };
> > >  };
> > >
> > > +&gmac0 {
> > > +     status = "okay";
> > > +};
> > > +
> > > +&gmac1 {
> > > +     status = "okay";
> > > +};
> > > +
> > >  &uart0 {
> > >       status = "okay";
> > >  };
> > > diff --git a/arch/mips/boot/dts/loongson/smartloong_1c.dts b/arch/mips/boot/dts/loongson/smartloong_1c.dts
> > > index 188aab9e3685..2d8f304aa2c4 100644
> > > --- a/arch/mips/boot/dts/loongson/smartloong_1c.dts
> > > +++ b/arch/mips/boot/dts/loongson/smartloong_1c.dts
> > > @@ -28,6 +28,10 @@ xtal: xtal {
> > >       };
> > >  };
> > >
> > > +&gmac0 {
> > > +     status = "okay";
> > > +};
> > > +
> > >  &uart0 {
> > >       status = "okay";
> > >  };
> > > diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
> > > index 8272b4133e25..817518531b9b 100644
> > > --- a/arch/mips/loongson32/common/platform.c
> > > +++ b/arch/mips/loongson32/common/platform.c
> > > @@ -8,157 +8,13 @@
> > >  #include <linux/err.h>
> > >  #include <linux/mtd/partitions.h>
> > >  #include <linux/sizes.h>
> > > -#include <linux/phy.h>
> > > -#include <linux/stmmac.h>
> > >  #include <linux/usb/ehci_pdriver.h>
> > >
> > >  #include <platform.h>
> > >  #include <loongson1.h>
> > >  #include <dma.h>
> > >  #include <nand.h>
> > > -
> > > -/* Synopsys Ethernet GMAC */
> > > -static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
> > > -     .phy_mask       = 0,
> > > -};
> > > -
> > > -static struct stmmac_dma_cfg ls1x_eth_dma_cfg = {
> > > -     .pbl            = 1,
> > > -};
> > > -
> > > -int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
> > > -{
> > > -     struct plat_stmmacenet_data *plat_dat = NULL;
> > > -     u32 val;
> > > -
> > > -     val = __raw_readl(LS1X_MUX_CTRL1);
> > > -
> > > -#if defined(CONFIG_LOONGSON1_LS1B)
> > > -     plat_dat = dev_get_platdata(&pdev->dev);
> > > -     if (plat_dat->bus_id) {
> > > -             __raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART1 |
> > > -                          GMAC1_USE_UART0, LS1X_MUX_CTRL0);
> > > -             switch (plat_dat->phy_interface) {
> > > -             case PHY_INTERFACE_MODE_RGMII:
> > > -                     val &= ~(GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
> > > -                     break;
> > > -             case PHY_INTERFACE_MODE_MII:
> > > -                     val |= (GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
> > > -                     break;
> > > -             default:
> > > -                     pr_err("unsupported mii mode %d\n",
> > > -                            plat_dat->phy_interface);
> > > -                     return -ENOTSUPP;
> > > -             }
> > > -             val &= ~GMAC1_SHUT;
> > > -     } else {
> > > -             switch (plat_dat->phy_interface) {
> > > -             case PHY_INTERFACE_MODE_RGMII:
> > > -                     val &= ~(GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
> > > -                     break;
> > > -             case PHY_INTERFACE_MODE_MII:
> > > -                     val |= (GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
> > > -                     break;
> > > -             default:
> > > -                     pr_err("unsupported mii mode %d\n",
> > > -                            plat_dat->phy_interface);
> > > -                     return -ENOTSUPP;
> > > -             }
> > > -             val &= ~GMAC0_SHUT;
> > > -     }
> > > -     __raw_writel(val, LS1X_MUX_CTRL1);
> > > -#elif defined(CONFIG_LOONGSON1_LS1C)
> > > -     plat_dat = dev_get_platdata(&pdev->dev);
> > > -
> > > -     val &= ~PHY_INTF_SELI;
> > > -     if (plat_dat->phy_interface == PHY_INTERFACE_MODE_RMII)
> > > -             val |= 0x4 << PHY_INTF_SELI_SHIFT;
> > > -     __raw_writel(val, LS1X_MUX_CTRL1);
> > > -
> > > -     val = __raw_readl(LS1X_MUX_CTRL0);
> > > -     __raw_writel(val & (~GMAC_SHUT), LS1X_MUX_CTRL0);
> > > -#endif
> > > -
> > > -     return 0;
> > > -}
> > > -
> > > -static struct plat_stmmacenet_data ls1x_eth0_pdata = {
> > > -     .bus_id                 = 0,
> > > -     .phy_addr               = -1,
> > > -#if defined(CONFIG_LOONGSON1_LS1B)
> > > -     .phy_interface          = PHY_INTERFACE_MODE_MII,
> > > -#elif defined(CONFIG_LOONGSON1_LS1C)
> > > -     .phy_interface          = PHY_INTERFACE_MODE_RMII,
> > > -#endif
> > > -     .mdio_bus_data          = &ls1x_mdio_bus_data,
> > > -     .dma_cfg                = &ls1x_eth_dma_cfg,
> > > -     .has_gmac               = 1,
> > > -     .tx_coe                 = 1,
> > > -     .rx_queues_to_use       = 1,
> > > -     .tx_queues_to_use       = 1,
> > > -     .init                   = ls1x_eth_mux_init,
> > > -};
> > > -
> > > -static struct resource ls1x_eth0_resources[] = {
> > > -     [0] = {
> > > -             .start  = LS1X_GMAC0_BASE,
> > > -             .end    = LS1X_GMAC0_BASE + SZ_64K - 1,
> > > -             .flags  = IORESOURCE_MEM,
> > > -     },
> > > -     [1] = {
> > > -             .name   = "macirq",
> > > -             .start  = LS1X_GMAC0_IRQ,
> > > -             .flags  = IORESOURCE_IRQ,
> > > -     },
> > > -};
> > > -
> > > -struct platform_device ls1x_eth0_pdev = {
> > > -     .name           = "stmmaceth",
> > > -     .id             = 0,
> > > -     .num_resources  = ARRAY_SIZE(ls1x_eth0_resources),
> > > -     .resource       = ls1x_eth0_resources,
> > > -     .dev            = {
> > > -             .platform_data = &ls1x_eth0_pdata,
> > > -     },
> > > -};
> > > -
> > > -#ifdef CONFIG_LOONGSON1_LS1B
> > > -static struct plat_stmmacenet_data ls1x_eth1_pdata = {
> > > -     .bus_id                 = 1,
> > > -     .phy_addr               = -1,
> > > -     .phy_interface          = PHY_INTERFACE_MODE_MII,
> > > -     .mdio_bus_data          = &ls1x_mdio_bus_data,
> > > -     .dma_cfg                = &ls1x_eth_dma_cfg,
> > > -     .has_gmac               = 1,
> > > -     .tx_coe                 = 1,
> > > -     .rx_queues_to_use       = 1,
> > > -     .tx_queues_to_use       = 1,
> > > -     .init                   = ls1x_eth_mux_init,
> > > -};
> > > -
> > > -static struct resource ls1x_eth1_resources[] = {
> > > -     [0] = {
> > > -             .start  = LS1X_GMAC1_BASE,
> > > -             .end    = LS1X_GMAC1_BASE + SZ_64K - 1,
> > > -             .flags  = IORESOURCE_MEM,
> > > -     },
> > > -     [1] = {
> > > -             .name   = "macirq",
> > > -             .start  = LS1X_GMAC1_IRQ,
> > > -             .flags  = IORESOURCE_IRQ,
> > > -     },
> > > -};
> > > -
> > > -struct platform_device ls1x_eth1_pdev = {
> > > -     .name           = "stmmaceth",
> > > -     .id             = 1,
> > > -     .num_resources  = ARRAY_SIZE(ls1x_eth1_resources),
> > > -     .resource       = ls1x_eth1_resources,
> > > -     .dev            = {
> > > -             .platform_data = &ls1x_eth1_pdata,
> > > -     },
> > > -};
> > > -#endif       /* CONFIG_LOONGSON1_LS1B */
> > > +#include <irq.h>
> > >
> > >  /* GPIO */
> > >  static struct resource ls1x_gpio0_resources[] = {
> > > diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
> > > index e8290f200096..f23e4e5c96ee 100644
> > > --- a/arch/mips/loongson32/ls1b/board.c
> > > +++ b/arch/mips/loongson32/ls1b/board.c
> > > @@ -34,8 +34,6 @@ static const struct gpio_led_platform_data ls1x_led_pdata __initconst = {
> > >  };
> > >
> > >  static struct platform_device *ls1b_platform_devices[] __initdata = {
> > > -     &ls1x_eth0_pdev,
> > > -     &ls1x_eth1_pdev,
> > >       &ls1x_ehci_pdev,
> > >       &ls1x_gpio0_pdev,
> > >       &ls1x_gpio1_pdev,
> > > diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
> > > index a7096964fb30..29bc467fd149 100644
> > > --- a/arch/mips/loongson32/ls1c/board.c
> > > +++ b/arch/mips/loongson32/ls1c/board.c
> > > @@ -6,7 +6,6 @@
> > >  #include <platform.h>
> > >
> > >  static struct platform_device *ls1c_platform_devices[] __initdata = {
> > > -     &ls1x_eth0_pdev,
> > >       &ls1x_rtc_pdev,
> > >       &ls1x_wdt_pdev,
> > >  };
> > > --
> > > 2.39.2
> > >
> 
> 
> 
> -- 
> Best regards,
> 
> Keguang Zhang

--tecqq4v2edoarqvd
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-stmmac-Move-Loongson1-MAC-arch-code-to-the-drive.patch"

From e63db52f7a2ac7288946a14f725c4547855f951f Mon Sep 17 00:00:00 2001
From: Serge Semin <fancer.lancer@gmail.com>
Date: Sun, 26 Sep 2021 23:41:51 +0300
Subject: [PATCH] net: stmmac: Move Loongson1 MAC arch-code to the driver dir

Loongson1 SoC is equipped with two GMAC interfaces based on the DW GMAC
v3.x. Both of them are exposed on Loongson 1B boards, and just one of them
- on Loongson 1C boards. The glue driver has been created purely based on
the arch-code implemented earlier with the platform-specific settings.
That's why the sloppy mux-switching has been left as is until someone
dares to create a driver for the embedded mux.

Note after this commit is merged in there won't be any platform_data-based
code left using the STMMAC-platform interface. Thus the STMMAC
platform_data declarations can be freely moved away from the generic
kernel headers set into the driver directory.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note I don't have a Loongson32 hardware at hand to test it out. I've
built-test the change though. So should you have the hardware any tests
and bug-reports would be very welcome.
---
 MAINTAINERS                                   |   1 +
 arch/mips/loongson32/common/platform.c        | 111 +----------
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-loongson1.c | 173 ++++++++++++++++++
 5 files changed, 193 insertions(+), 104 deletions(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f0ee1d6d8918..a90d5b3de82e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14097,6 +14097,7 @@ L:	linux-mips@vger.kernel.org
 S:	Maintained
 F:	arch/mips/include/asm/mach-loongson32/
 F:	arch/mips/loongson32/
+F:	drivers/*/*/*/*/*loongson1*
 F:	drivers/*/*loongson1*
 
 MIPS/LOONGSON2EF ARCHITECTURE
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 64d7979394e6..85603f531148 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -10,7 +10,6 @@
 #include <linux/sizes.h>
 #include <linux/phy.h>
 #include <linux/serial_8250.h>
-#include <linux/stmmac.h>
 #include <linux/usb/ehci_pdriver.h>
 
 #include <platform.h>
@@ -61,88 +60,7 @@ void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
 		p->uartclk = clk_get_rate(clk);
 }
 
-/* Synopsys Ethernet GMAC */
-static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
-	.phy_mask	= 0,
-};
-
-static struct stmmac_dma_cfg ls1x_eth_dma_cfg = {
-	.pbl		= 1,
-};
-
-int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
-{
-	struct plat_stmmacenet_data *plat_dat = NULL;
-	u32 val;
-
-	val = __raw_readl(LS1X_MUX_CTRL1);
-
-#if defined(CONFIG_LOONGSON1_LS1B)
-	plat_dat = dev_get_platdata(&pdev->dev);
-	if (plat_dat->bus_id) {
-		__raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART1 |
-			     GMAC1_USE_UART0, LS1X_MUX_CTRL0);
-		switch (plat_dat->phy_interface) {
-		case PHY_INTERFACE_MODE_RGMII:
-			val &= ~(GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
-			break;
-		case PHY_INTERFACE_MODE_MII:
-			val |= (GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
-			break;
-		default:
-			pr_err("unsupported mii mode %d\n",
-			       plat_dat->phy_interface);
-			return -ENOTSUPP;
-		}
-		val &= ~GMAC1_SHUT;
-	} else {
-		switch (plat_dat->phy_interface) {
-		case PHY_INTERFACE_MODE_RGMII:
-			val &= ~(GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
-			break;
-		case PHY_INTERFACE_MODE_MII:
-			val |= (GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
-			break;
-		default:
-			pr_err("unsupported mii mode %d\n",
-			       plat_dat->phy_interface);
-			return -ENOTSUPP;
-		}
-		val &= ~GMAC0_SHUT;
-	}
-	__raw_writel(val, LS1X_MUX_CTRL1);
-#elif defined(CONFIG_LOONGSON1_LS1C)
-	plat_dat = dev_get_platdata(&pdev->dev);
-
-	val &= ~PHY_INTF_SELI;
-	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_RMII)
-		val |= 0x4 << PHY_INTF_SELI_SHIFT;
-	__raw_writel(val, LS1X_MUX_CTRL1);
-
-	val = __raw_readl(LS1X_MUX_CTRL0);
-	__raw_writel(val & (~GMAC_SHUT), LS1X_MUX_CTRL0);
-#endif
-
-	return 0;
-}
-
-static struct plat_stmmacenet_data ls1x_eth0_pdata = {
-	.bus_id			= 0,
-	.phy_addr		= -1,
-#if defined(CONFIG_LOONGSON1_LS1B)
-	.phy_interface		= PHY_INTERFACE_MODE_MII,
-#elif defined(CONFIG_LOONGSON1_LS1C)
-	.phy_interface		= PHY_INTERFACE_MODE_RMII,
-#endif
-	.mdio_bus_data		= &ls1x_mdio_bus_data,
-	.dma_cfg		= &ls1x_eth_dma_cfg,
-	.has_gmac		= 1,
-	.tx_coe			= 1,
-	.rx_queues_to_use	= 1,
-	.tx_queues_to_use	= 1,
-	.init			= ls1x_eth_mux_init,
-};
-
+/* Ethernet (Synopsys DW GMAC) */
 static struct resource ls1x_eth0_resources[] = {
 	[0] = {
 		.start	= LS1X_GMAC0_BASE,
@@ -157,29 +75,17 @@ static struct resource ls1x_eth0_resources[] = {
 };
 
 struct platform_device ls1x_eth0_pdev = {
-	.name		= "stmmaceth",
+#if defined(CONFIG_LOONGSON1_LS1B)
+	.name		= "ls1b-eth",
+#elif defined(CONFIG_LOONGSON1_LS1C)
+	.name		= "ls1c-eth",
+#endif
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(ls1x_eth0_resources),
 	.resource	= ls1x_eth0_resources,
-	.dev		= {
-		.platform_data = &ls1x_eth0_pdata,
-	},
 };
 
 #ifdef CONFIG_LOONGSON1_LS1B
-static struct plat_stmmacenet_data ls1x_eth1_pdata = {
-	.bus_id			= 1,
-	.phy_addr		= -1,
-	.phy_interface		= PHY_INTERFACE_MODE_MII,
-	.mdio_bus_data		= &ls1x_mdio_bus_data,
-	.dma_cfg		= &ls1x_eth_dma_cfg,
-	.has_gmac		= 1,
-	.tx_coe			= 1,
-	.rx_queues_to_use	= 1,
-	.tx_queues_to_use	= 1,
-	.init			= ls1x_eth_mux_init,
-};
-
 static struct resource ls1x_eth1_resources[] = {
 	[0] = {
 		.start	= LS1X_GMAC1_BASE,
@@ -194,13 +100,10 @@ static struct resource ls1x_eth1_resources[] = {
 };
 
 struct platform_device ls1x_eth1_pdev = {
-	.name		= "stmmaceth",
+	.name		= "ls1b-eth",
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(ls1x_eth1_resources),
 	.resource	= ls1x_eth1_resources,
-	.dev		= {
-		.platform_data = &ls1x_eth1_pdata,
-	},
 };
 #endif	/* CONFIG_LOONGSON1_LS1B */
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index 5f5a997f21f3..a89ecbd67f21 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -263,6 +263,17 @@ config DWMAC_VISCONTI
 	help
 	  Support for ethernet controller on Visconti SoCs.
 
+config DWMAC_LOONGSON1
+	tristate "Loongson1 GMAC support"
+	default LOONGSON1_LS1B || LOONGSON1_LS1C
+	depends on MACH_LOONGSON32
+	help
+	  Support for ethernet controller on Loongson1 SoC.
+
+	  This selects Loongson1 SoC glue layer support for the stmmac
+	  device driver. This driver is used for Loongson1-based boards
+	  like Loongson LS1B/LS1C.
+
 endif
 
 config DWMAC_INTEL
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 8738fdbb4b2d..a6fb0f773575 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_DWMAC_GENERIC)	+= dwmac-generic.o
 obj-$(CONFIG_DWMAC_IMX8)	+= dwmac-imx.o
 obj-$(CONFIG_DWMAC_TEGRA)	+= dwmac-tegra.o
 obj-$(CONFIG_DWMAC_VISCONTI)	+= dwmac-visconti.o
+obj-$(CONFIG_DWMAC_LOONGSON1)	+= dwmac-loongson1.o
 stmmac-platform-objs:= stmmac_platform.o
 dwmac-altr-socfpga-objs := altr_tse_pcs.o dwmac-socfpga.o
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
new file mode 100644
index 000000000000..4cf6e763ac41
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2011-2023 Zhang, Keguang <keguang.zhang@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/phy.h>
+#include <linux/io.h>
+
+#include <asm/mach-loongson32/loongson1.h>
+
+#include "stmmac.h"
+#include "stmmac_platform.h"
+
+struct ls1x_eth_info {
+	phy_interface_t interface;
+	int (*init)(struct platform_device *pdev, void *priv);
+};
+
+/* Note the mux-switching is supposed to be implemented via a dedicated
+ * driver. Until it's done there is no other choice but live with such
+ * a sloppy implementation.
+ */
+static int ls1b_eth_mux_init(struct platform_device *pdev, void *priv)
+{
+	struct plat_stmmacenet_data *plat = priv;
+	u32 val;
+
+	val = __raw_readl(LS1X_MUX_CTRL1);
+
+	if (plat->bus_id) {
+		__raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART1 |
+			     GMAC1_USE_UART0, LS1X_MUX_CTRL0);
+		switch (plat->phy_interface) {
+		case PHY_INTERFACE_MODE_RGMII:
+			val &= ~(GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
+			break;
+		case PHY_INTERFACE_MODE_MII:
+			val |= (GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
+			break;
+		default:
+			dev_err(&pdev->dev, "Unsupported PHY-mode %u\n",
+				plat->phy_interface);
+			return -ENOTSUPP;
+		}
+		val &= ~GMAC1_SHUT;
+	} else {
+		switch (plat->phy_interface) {
+		case PHY_INTERFACE_MODE_RGMII:
+			val &= ~(GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
+			break;
+		case PHY_INTERFACE_MODE_MII:
+			val |= (GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
+			break;
+		default:
+			dev_err(&pdev->dev, "Unsupported PHY-mode %u\n",
+				plat->phy_interface);
+			return -ENOTSUPP;
+		}
+		val &= ~GMAC0_SHUT;
+	}
+
+	__raw_writel(val, LS1X_MUX_CTRL1);
+
+	return 0;
+}
+
+static int ls1c_eth_mux_init(struct platform_device *pdev, void *priv)
+{
+	struct plat_stmmacenet_data *plat = priv;
+	u32 val;
+
+	val = __raw_readl(LS1X_MUX_CTRL1) & ~PHY_INTF_SELI;
+	if (plat->phy_interface == PHY_INTERFACE_MODE_RMII) {
+		val |= 0x4 << PHY_INTF_SELI_SHIFT;
+	} else {
+		dev_err(&pdev->dev, "Unsupported PHY-mode %u\n",
+			plat->phy_interface);
+		return -ENOTSUPP;
+	}
+	__raw_writel(val, LS1X_MUX_CTRL1);
+
+	val = __raw_readl(LS1X_MUX_CTRL0);
+	__raw_writel(val & (~GMAC_SHUT), LS1X_MUX_CTRL0);
+
+	return 0;
+}
+
+static int ls1x_eth_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	const struct ls1x_eth_info *info = (struct ls1x_eth_info *)id->driver_data;
+	struct stmmac_resources stmmac_res;
+	struct plat_stmmacenet_data *plat;
+	int ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return ret;
+
+	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
+	if (!plat)
+		return -ENOMEM;
+
+	plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
+					   sizeof(*plat->mdio_bus_data),
+					   GFP_KERNEL);
+	if (!plat->mdio_bus_data)
+		return -ENOMEM;
+
+	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg),
+				     GFP_KERNEL);
+	if (!plat->dma_cfg)
+		return -ENOMEM;
+
+	plat->bus_id = pdev->id;
+	plat->phy_addr = -1;
+	plat->phy_interface = info->phy_interface;
+	plat->mdio_bus_data->phy_mask = 0;
+	plat->dma_cfg->pbl = 1;
+	plat->has_gmac = 1;
+	plat->tx_coe = 1;
+	plat->multicast_filter_bins = 64;
+	plat->unicast_filter_entries = 1;
+	plat->rx_queues_to_use = 1;
+	plat->tx_queues_to_use = 1;
+	plat->bsp_priv = plat;
+	plat->init = info->init;
+
+	ret = plat->init(pdev, plat->bsp_priv);
+	if (ret)
+		return ret;
+
+	ret = stmmac_dvr_probe(&pdev->dev, plat, &stmmac_res);
+	if (ret)
+		goto err_exit;
+
+	return 0;
+}
+
+static const struct ls1x_eth_info ls1b_eth_info = {
+	.phy_interface = PHY_INTERFACE_MODE_MII,
+	.init = ls1b_eth_mux_init,
+};
+
+static const struct ls1x_eth_info ls1c_eth_info = {
+	.phy_interface = PHY_INTERFACE_MODE_RMII,
+	.init = ls1c_eth_mux_init,
+};
+
+static const struct platform_device_id ls1x_eth_id_table[] = {
+	{ "ls1b-eth", (kernel_ulong_t)&ls1b_eth_info },
+	{ "ls1c-eth", (kernel_ulong_t)&ls1c_eth_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, ls1x_eth_id_table);
+
+static struct platform_driver ls1x_eth_driver = {
+	.probe = ls1x_eth_probe,
+	.remove = stmmac_pltfr_remove,
+	.id_table = ls1x_eth_id_table,
+	.driver = {
+		   .name = "ls1x-eth",
+	},
+};
+module_platform_driver(ls1x_eth_driver);
+
+MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
+MODULE_DESCRIPTION("Loongson1 GMAC driver");
+MODULE_LICENSE("GPL");
-- 
2.41.0


--tecqq4v2edoarqvd--
