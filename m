Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9561E76CD37
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjHBMn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjHBMnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:43:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8785B2708;
        Wed,  2 Aug 2023 05:42:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so6351348e87.1;
        Wed, 02 Aug 2023 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690980169; x=1691584969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HWAZUGjqrMSateUY+lLcuDhMpVaeFJLvzjcgZLHCaZk=;
        b=m3aAhGB9lsBIYlUbYT0MBe4LfXoHwyND31/pZhXplq5t5vPE9CCq+LRWmesDVxxmqo
         /Mc1hSdZKlWAEO2j8SYdxvXb95hrbNJkVRzfve9L5Ax+gr+vslrrxuQcijt/1jobawHk
         GvOUOoglHGGnH2v2YQiqJV/Kc1lZoJ0kI6OLy6y8bbDSs36u2+8QUiYDbuZXK4WdbQz3
         fkvoBB0+BIuEGNnA6tT8bOTmdtqWs5+tRhgS+aruR7OIxezapMcRn2TnSV9p5a8OV+Xf
         Bi6jwUsZwGWg4LliYpWjHwidgDPdcLujbgzx7IpcdFImKzqZ/p1ryIgmvMAjE3iOI9UB
         PUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980169; x=1691584969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWAZUGjqrMSateUY+lLcuDhMpVaeFJLvzjcgZLHCaZk=;
        b=lPBy97N4j5qcBUqRlspa6aMwV7BlzUHsic5n1m0lSP8my1j/C+SSsvHUHPlQyiAJvD
         7nxV3Ojkubz+Py+eb7vD1sD4iF0DDS6MUGBKWSELfBl2sGbWo7H8QAeyE6x/1f5z016D
         mNzuDMmTQcbFP1ZDDppBFS4B7RmDJXGW4drSCO/JhVPdqEc7zU2btqdJ5dglMFcWD9+o
         IvjAwGhbx49AGcaWdeJYW++SxADp3gEUmToVBpiL4fD3ssUsIXIp5XyMIzUdVG5CUcQu
         DyKWWfbzXo7ZJcTfFSxC7eX7PoKtM+SanxTtcoG1pnlXiU6XHlE9nc4SpFCmMPhJMj1B
         Nshw==
X-Gm-Message-State: ABy/qLYRyKuxrxBqxpUeX/XjK99Z9c+8A+8iyQlMKIA5Oej28Go6mPtD
        bpzTGR/7C88xPY1tHUupXbU=
X-Google-Smtp-Source: APBJJlHGeJ8E0aIYPwyOq+TLeVXUGoo9eRnwxN5TQGtSesRuvox2zAzS6TjslVNwyhIntIt1HiTqng==
X-Received: by 2002:ac2:58e9:0:b0:4fa:f79f:85a with SMTP id v9-20020ac258e9000000b004faf79f085amr4007074lfo.69.1690980168732;
        Wed, 02 Aug 2023 05:42:48 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id a1-20020a19f801000000b004fb757bd429sm2772244lff.96.2023.08.02.05.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:42:48 -0700 (PDT)
Date:   Wed, 2 Aug 2023 15:42:45 +0300
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
Message-ID: <nklemt2d22hvk7jasy6gqtxgdwfm6rpdvwrqm556zivvjhsgt4@qeydknu35czx>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
 <20230729134318.1694467-9-keguang.zhang@gmail.com>
 <4qk22kycanwwbx6e7w4uuf7y5re7y4voi5vdurq3usa27py2zk@zms25h4hg2da>
 <CAJhJPsV9E5=GtsjiP8c3A6=4=Vh7cB1g=TaaJnVOjCf=VFiLUA@mail.gmail.com>
 <sxuwhp3jc7e5tma5sj5xfkbs43ax2p7oucgy5aoh66pnyr6x2m@logqlgthsy66>
 <CAJhJPsUVUZfMtwMniaAeA5wLm9TjCsiYJpU2=ZXY8J+4WT1Gzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhJPsUVUZfMtwMniaAeA5wLm9TjCsiYJpU2=ZXY8J+4WT1Gzw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 07:19:55PM +0800, Keguang Zhang wrote:
> On Wed, Aug 2, 2023 at 5:44 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Wed, Aug 02, 2023 at 11:10:10AM +0800, Keguang Zhang wrote:
> > > On Wed, Aug 2, 2023 at 2:21 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > >
> > > > On Sat, Jul 29, 2023 at 09:43:09PM +0800, Keguang Zhang wrote:
> > > > > Add Ethernet device nodes for Loongson-1 boards,
> > > > > and drop the legacy platform devices and data accordingly.
> > > >
> > > > It seems to me that your conversion breaks the RGMII mode support.
> > > > What you need to do is to make sure that the respective flags are set
> > > > in the MUX space.
> > > >
> > > > Regarding the MUX-space. It looks as a pinctrl-setting space. If so
> > > > adding the new pinctrl driver will be required. Otherwise it can be
> > > > defined as a syscon-node and then utilized in the Loongson-1 GMAC
> > > > low-level driver.
> > > >
> >
> > > Thanks for your reminder.
> > > I planned to add the pinctrl driver later.
> > > Now I'm working on it.
> >
> > I have been having a patch moving the Loongson32 MAC driver to the
> > STMMAC driver directory for quite a while in my tree. You can use it
> > in your series (completely, as a reference or template, whatever). The
> > only thing you'll need to do is to add the pinctrl-based version of
> > the ls1b_eth_mux_init()/ls1c_eth_mux_init() methods in there and
> > test/debug it of course.
> >
> > Note 1. It seems to me that it would work better if you defined the
> > plat_stmmacenet_data.fix_mac_speed() callback instead of
> > plat_stmmacenet_data.init() for LS1B which supports MII and RGMII aka
> > 100Mbps and 1000Mbps speeds.
> >

> Thanks!
> I will look into it.
> However, I think ls1x_eth_mux_init() belongs to the scope of pinctrl or syscon.

Partly yes and partly no. The pins-mode setup functionality needs to
be implemented in pinctrl, but switching between RGMII and MII modes
must be done in the GMAC driver (selecting between different pinctrl
states).

Alternatively you can define the MUX1 and MUX2 registers as the
syscon-regmap space, have it referenced in the Loongson32 MAC DT-node
and then switch between the modes manually in a similar way as it done
in the current MAC platform code or in my patch. But IMO implementing
it by means of the pin-controller would be much better. Note it
doesn't prevent you from directly accessing the MUX-registers from the
drivers and using these registers as the regspace for a
syscon-controller driver: see syscon_node_to_regmap() method.

> IMHO it is not worth implementing a glue driver for Loongson1.

Generic DW GMAC driver won't fully work for LS1B which requires the
phy-mode (phy_interface) change. In order for that to work correctly
it needs to be done in the framework of the fix_mac_speed() callback
which is called on each interface open procedure. Note the network
phylink semantic implies that the phy-mode may change in runtime
between interface re-open cycle (for instance in order to be able to
switch between different network PHY-s connected to the same MAC
interface). That's why fix_mac_speed() is the best place for the PHY
modes change, not the init() callback. Due to all of that you won't
escape with just using a combination of the DT-properties.

-Serge(y)

> 
> > Note 2. The patch I've sent was only built-tested. I don't have any
> > Loongson hardware.
> >
> > Note 3. After the suggested patch is applied you can also completely
> > move the include/linux/stmmac.h header file to the STMMAC-driver
> > directory as a following up cleanup update (it should be renamed to
> > stmmac_platform.h since stmmac.h is already available in there).
> > It can be done since there won't any users of that file outside the
> > STMMAC-driver directory. So there is no point in keeping it in the
> > common headers directory anymore.
> >
> > -Serge(y)
> >
> > >
> > > > -Serge(y)
> > > >
> > > > >
> > > > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > > > ---
> > > > >  arch/mips/boot/dts/loongson/loongson1.dtsi    |  16 ++
> > > > >  arch/mips/boot/dts/loongson/loongson1b.dtsi   |  53 +++++++
> > > > >  arch/mips/boot/dts/loongson/loongson1c.dtsi   |  17 ++
> > > > >  arch/mips/boot/dts/loongson/lsgz_1b_dev.dts   |   8 +
> > > > >  arch/mips/boot/dts/loongson/smartloong_1c.dts |   4 +
> > > > >  arch/mips/loongson32/common/platform.c        | 146 +-----------------
> > > > >  arch/mips/loongson32/ls1b/board.c             |   2 -
> > > > >  arch/mips/loongson32/ls1c/board.c             |   1 -
> > > > >  8 files changed, 99 insertions(+), 148 deletions(-)
> > > > >
> > > > > diff --git a/arch/mips/boot/dts/loongson/loongson1.dtsi b/arch/mips/boot/dts/loongson/loongson1.dtsi
> > > > > index c77aa2d0f66c..48bb786bbf10 100644
> > > > > --- a/arch/mips/boot/dts/loongson/loongson1.dtsi
> > > > > +++ b/arch/mips/boot/dts/loongson/loongson1.dtsi
> > > > > @@ -71,6 +71,22 @@ intc3: interrupt-controller@1fd01088 {
> > > > >                       interrupt-parent = <&cpu_intc>;
> > > > >                       interrupts = <5>;
> > > > >               };
> > > > > +
> > > > > +             gmac0: ethernet@1fe10000 {
> > > > > +                     compatible = "snps,dwmac-3.70a";
> > > > > +                     reg = <0x1fe10000 0x10000>;
> > > > > +
> > > > > +                     interrupt-parent = <&intc1>;
> > > > > +                     interrupt-names = "macirq";
> > > > > +
> > > > > +                     clocks = <&clkc LS1X_CLKID_AHB>;
> > > > > +                     clock-names = "stmmaceth";
> > > > > +
> > > > > +                     snps,pbl = <1>;
> > > > > +
> > > > > +                     status = "disabled";
> > > > > +             };
> > > > > +
> > > > >       };
> > > > >
> > > > >       apb: bus@1fe40000 {
> > > > > diff --git a/arch/mips/boot/dts/loongson/loongson1b.dtsi b/arch/mips/boot/dts/loongson/loongson1b.dtsi
> > > > > index 437a77cee163..42b96c557660 100644
> > > > > --- a/arch/mips/boot/dts/loongson/loongson1b.dtsi
> > > > > +++ b/arch/mips/boot/dts/loongson/loongson1b.dtsi
> > > > > @@ -7,6 +7,11 @@
> > > > >  #include "loongson1.dtsi"
> > > > >
> > > > >  / {
> > > > > +     aliases {
> > > > > +             ethernet0 = &gmac0;
> > > > > +             ethernet1 = &gmac1;
> > > > > +     };
> > > > > +
> > > > >       cpus {
> > > > >               #address-cells = <1>;
> > > > >               #size-cells = <0>;
> > > > > @@ -74,6 +79,54 @@ clkc: clock-controller@1fe78030 {
> > > > >       };
> > > > >  };
> > > > >
> > > > > +&ahb {
> > > > > +     gmac1: ethernet@1fe20000 {
> > > > > +             compatible = "snps,dwmac-3.70a";
> > > > > +             reg = <0x1fe20000 0x10000>;
> > > > > +
> > > > > +             interrupt-parent = <&intc1>;
> > > > > +             interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +             interrupt-names = "macirq";
> > > > > +
> > > > > +             clocks = <&clkc LS1X_CLKID_AHB>;
> > > > > +             clock-names = "stmmaceth";
> > > > > +
> > > > > +             phy-handle = <&phy1>;
> > > > > +             phy-mode = "mii";
> > > > > +
> > > > > +             snps,pbl = <1>;
> > > > > +
> > > > > +             status = "disabled";
> > > > > +
> > > > > +             mdio1 {
> > > > > +                     #address-cells = <1>;
> > > > > +                     #size-cells = <0>;
> > > > > +                     compatible = "snps,dwmac-mdio";
> > > > > +
> > > > > +                     phy1: ethernet-phy@0 {
> > > > > +                             reg = <0x0>;
> > > > > +                     };
> > > > > +             };
> > > > > +     };
> > > > > +};
> > > > > +
> > > > > +&gmac0 {
> > > > > +     interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +
> > > > > +     phy-handle = <&phy0>;
> > > > > +     phy-mode = "mii";
> > > > > +
> > > > > +     mdio0 {
> > > > > +             #address-cells = <1>;
> > > > > +             #size-cells = <0>;
> > > > > +             compatible = "snps,dwmac-mdio";
> > > > > +
> > > > > +             phy0: ethernet-phy@0 {
> > > > > +                     reg = <0x0>;
> > > > > +             };
> > > > > +     };
> > > > > +};
> > > > > +
> > > > >  &uart1 {
> > > > >       interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> > > > >  };
> > > > > diff --git a/arch/mips/boot/dts/loongson/loongson1c.dtsi b/arch/mips/boot/dts/loongson/loongson1c.dtsi
> > > > > index 1dd575b7b2f9..5b3e0f9280f6 100644
> > > > > --- a/arch/mips/boot/dts/loongson/loongson1c.dtsi
> > > > > +++ b/arch/mips/boot/dts/loongson/loongson1c.dtsi
> > > > > @@ -41,6 +41,23 @@ intc4: interrupt-controller@1fd010a0 {
> > > > >       };
> > > > >  };
> > > > >
> > > > > +&gmac0 {
> > > > > +     interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +
> > > > > +     phy-handle = <&phy0>;
> > > > > +     phy-mode = "rmii";
> > > > > +
> > > > > +     mdio0 {
> > > > > +             #address-cells = <1>;
> > > > > +             #size-cells = <0>;
> > > > > +             compatible = "snps,dwmac-mdio";
> > > > > +
> > > > > +             phy0: ethernet-phy@13 {
> > > > > +                     reg = <0x13>;
> > > > > +             };
> > > > > +     };
> > > > > +};
> > > > > +
> > > > >  &uart1 {
> > > > >       interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> > > > >  };
> > > > > diff --git a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
> > > > > index 89c3dfa574f7..a43df21f2904 100644
> > > > > --- a/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
> > > > > +++ b/arch/mips/boot/dts/loongson/lsgz_1b_dev.dts
> > > > > @@ -28,6 +28,14 @@ xtal: xtal {
> > > > >       };
> > > > >  };
> > > > >
> > > > > +&gmac0 {
> > > > > +     status = "okay";
> > > > > +};
> > > > > +
> > > > > +&gmac1 {
> > > > > +     status = "okay";
> > > > > +};
> > > > > +
> > > > >  &uart0 {
> > > > >       status = "okay";
> > > > >  };
> > > > > diff --git a/arch/mips/boot/dts/loongson/smartloong_1c.dts b/arch/mips/boot/dts/loongson/smartloong_1c.dts
> > > > > index 188aab9e3685..2d8f304aa2c4 100644
> > > > > --- a/arch/mips/boot/dts/loongson/smartloong_1c.dts
> > > > > +++ b/arch/mips/boot/dts/loongson/smartloong_1c.dts
> > > > > @@ -28,6 +28,10 @@ xtal: xtal {
> > > > >       };
> > > > >  };
> > > > >
> > > > > +&gmac0 {
> > > > > +     status = "okay";
> > > > > +};
> > > > > +
> > > > >  &uart0 {
> > > > >       status = "okay";
> > > > >  };
> > > > > diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
> > > > > index 8272b4133e25..817518531b9b 100644
> > > > > --- a/arch/mips/loongson32/common/platform.c
> > > > > +++ b/arch/mips/loongson32/common/platform.c
> > > > > @@ -8,157 +8,13 @@
> > > > >  #include <linux/err.h>
> > > > >  #include <linux/mtd/partitions.h>
> > > > >  #include <linux/sizes.h>
> > > > > -#include <linux/phy.h>
> > > > > -#include <linux/stmmac.h>
> > > > >  #include <linux/usb/ehci_pdriver.h>
> > > > >
> > > > >  #include <platform.h>
> > > > >  #include <loongson1.h>
> > > > >  #include <dma.h>
> > > > >  #include <nand.h>
> > > > > -
> > > > > -/* Synopsys Ethernet GMAC */
> > > > > -static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
> > > > > -     .phy_mask       = 0,
> > > > > -};
> > > > > -
> > > > > -static struct stmmac_dma_cfg ls1x_eth_dma_cfg = {
> > > > > -     .pbl            = 1,
> > > > > -};
> > > > > -
> > > > > -int ls1x_eth_mux_init(struct platform_device *pdev, void *priv)
> > > > > -{
> > > > > -     struct plat_stmmacenet_data *plat_dat = NULL;
> > > > > -     u32 val;
> > > > > -
> > > > > -     val = __raw_readl(LS1X_MUX_CTRL1);
> > > > > -
> > > > > -#if defined(CONFIG_LOONGSON1_LS1B)
> > > > > -     plat_dat = dev_get_platdata(&pdev->dev);
> > > > > -     if (plat_dat->bus_id) {
> > > > > -             __raw_writel(__raw_readl(LS1X_MUX_CTRL0) | GMAC1_USE_UART1 |
> > > > > -                          GMAC1_USE_UART0, LS1X_MUX_CTRL0);
> > > > > -             switch (plat_dat->phy_interface) {
> > > > > -             case PHY_INTERFACE_MODE_RGMII:
> > > > > -                     val &= ~(GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
> > > > > -                     break;
> > > > > -             case PHY_INTERFACE_MODE_MII:
> > > > > -                     val |= (GMAC1_USE_TXCLK | GMAC1_USE_PWM23);
> > > > > -                     break;
> > > > > -             default:
> > > > > -                     pr_err("unsupported mii mode %d\n",
> > > > > -                            plat_dat->phy_interface);
> > > > > -                     return -ENOTSUPP;
> > > > > -             }
> > > > > -             val &= ~GMAC1_SHUT;
> > > > > -     } else {
> > > > > -             switch (plat_dat->phy_interface) {
> > > > > -             case PHY_INTERFACE_MODE_RGMII:
> > > > > -                     val &= ~(GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
> > > > > -                     break;
> > > > > -             case PHY_INTERFACE_MODE_MII:
> > > > > -                     val |= (GMAC0_USE_TXCLK | GMAC0_USE_PWM01);
> > > > > -                     break;
> > > > > -             default:
> > > > > -                     pr_err("unsupported mii mode %d\n",
> > > > > -                            plat_dat->phy_interface);
> > > > > -                     return -ENOTSUPP;
> > > > > -             }
> > > > > -             val &= ~GMAC0_SHUT;
> > > > > -     }
> > > > > -     __raw_writel(val, LS1X_MUX_CTRL1);
> > > > > -#elif defined(CONFIG_LOONGSON1_LS1C)
> > > > > -     plat_dat = dev_get_platdata(&pdev->dev);
> > > > > -
> > > > > -     val &= ~PHY_INTF_SELI;
> > > > > -     if (plat_dat->phy_interface == PHY_INTERFACE_MODE_RMII)
> > > > > -             val |= 0x4 << PHY_INTF_SELI_SHIFT;
> > > > > -     __raw_writel(val, LS1X_MUX_CTRL1);
> > > > > -
> > > > > -     val = __raw_readl(LS1X_MUX_CTRL0);
> > > > > -     __raw_writel(val & (~GMAC_SHUT), LS1X_MUX_CTRL0);
> > > > > -#endif
> > > > > -
> > > > > -     return 0;
> > > > > -}
> > > > > -
> > > > > -static struct plat_stmmacenet_data ls1x_eth0_pdata = {
> > > > > -     .bus_id                 = 0,
> > > > > -     .phy_addr               = -1,
> > > > > -#if defined(CONFIG_LOONGSON1_LS1B)
> > > > > -     .phy_interface          = PHY_INTERFACE_MODE_MII,
> > > > > -#elif defined(CONFIG_LOONGSON1_LS1C)
> > > > > -     .phy_interface          = PHY_INTERFACE_MODE_RMII,
> > > > > -#endif
> > > > > -     .mdio_bus_data          = &ls1x_mdio_bus_data,
> > > > > -     .dma_cfg                = &ls1x_eth_dma_cfg,
> > > > > -     .has_gmac               = 1,
> > > > > -     .tx_coe                 = 1,
> > > > > -     .rx_queues_to_use       = 1,
> > > > > -     .tx_queues_to_use       = 1,
> > > > > -     .init                   = ls1x_eth_mux_init,
> > > > > -};
> > > > > -
> > > > > -static struct resource ls1x_eth0_resources[] = {
> > > > > -     [0] = {
> > > > > -             .start  = LS1X_GMAC0_BASE,
> > > > > -             .end    = LS1X_GMAC0_BASE + SZ_64K - 1,
> > > > > -             .flags  = IORESOURCE_MEM,
> > > > > -     },
> > > > > -     [1] = {
> > > > > -             .name   = "macirq",
> > > > > -             .start  = LS1X_GMAC0_IRQ,
> > > > > -             .flags  = IORESOURCE_IRQ,
> > > > > -     },
> > > > > -};
> > > > > -
> > > > > -struct platform_device ls1x_eth0_pdev = {
> > > > > -     .name           = "stmmaceth",
> > > > > -     .id             = 0,
> > > > > -     .num_resources  = ARRAY_SIZE(ls1x_eth0_resources),
> > > > > -     .resource       = ls1x_eth0_resources,
> > > > > -     .dev            = {
> > > > > -             .platform_data = &ls1x_eth0_pdata,
> > > > > -     },
> > > > > -};
> > > > > -
> > > > > -#ifdef CONFIG_LOONGSON1_LS1B
> > > > > -static struct plat_stmmacenet_data ls1x_eth1_pdata = {
> > > > > -     .bus_id                 = 1,
> > > > > -     .phy_addr               = -1,
> > > > > -     .phy_interface          = PHY_INTERFACE_MODE_MII,
> > > > > -     .mdio_bus_data          = &ls1x_mdio_bus_data,
> > > > > -     .dma_cfg                = &ls1x_eth_dma_cfg,
> > > > > -     .has_gmac               = 1,
> > > > > -     .tx_coe                 = 1,
> > > > > -     .rx_queues_to_use       = 1,
> > > > > -     .tx_queues_to_use       = 1,
> > > > > -     .init                   = ls1x_eth_mux_init,
> > > > > -};
> > > > > -
> > > > > -static struct resource ls1x_eth1_resources[] = {
> > > > > -     [0] = {
> > > > > -             .start  = LS1X_GMAC1_BASE,
> > > > > -             .end    = LS1X_GMAC1_BASE + SZ_64K - 1,
> > > > > -             .flags  = IORESOURCE_MEM,
> > > > > -     },
> > > > > -     [1] = {
> > > > > -             .name   = "macirq",
> > > > > -             .start  = LS1X_GMAC1_IRQ,
> > > > > -             .flags  = IORESOURCE_IRQ,
> > > > > -     },
> > > > > -};
> > > > > -
> > > > > -struct platform_device ls1x_eth1_pdev = {
> > > > > -     .name           = "stmmaceth",
> > > > > -     .id             = 1,
> > > > > -     .num_resources  = ARRAY_SIZE(ls1x_eth1_resources),
> > > > > -     .resource       = ls1x_eth1_resources,
> > > > > -     .dev            = {
> > > > > -             .platform_data = &ls1x_eth1_pdata,
> > > > > -     },
> > > > > -};
> > > > > -#endif       /* CONFIG_LOONGSON1_LS1B */
> > > > > +#include <irq.h>
> > > > >
> > > > >  /* GPIO */
> > > > >  static struct resource ls1x_gpio0_resources[] = {
> > > > > diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
> > > > > index e8290f200096..f23e4e5c96ee 100644
> > > > > --- a/arch/mips/loongson32/ls1b/board.c
> > > > > +++ b/arch/mips/loongson32/ls1b/board.c
> > > > > @@ -34,8 +34,6 @@ static const struct gpio_led_platform_data ls1x_led_pdata __initconst = {
> > > > >  };
> > > > >
> > > > >  static struct platform_device *ls1b_platform_devices[] __initdata = {
> > > > > -     &ls1x_eth0_pdev,
> > > > > -     &ls1x_eth1_pdev,
> > > > >       &ls1x_ehci_pdev,
> > > > >       &ls1x_gpio0_pdev,
> > > > >       &ls1x_gpio1_pdev,
> > > > > diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
> > > > > index a7096964fb30..29bc467fd149 100644
> > > > > --- a/arch/mips/loongson32/ls1c/board.c
> > > > > +++ b/arch/mips/loongson32/ls1c/board.c
> > > > > @@ -6,7 +6,6 @@
> > > > >  #include <platform.h>
> > > > >
> > > > >  static struct platform_device *ls1c_platform_devices[] __initdata = {
> > > > > -     &ls1x_eth0_pdev,
> > > > >       &ls1x_rtc_pdev,
> > > > >       &ls1x_wdt_pdev,
> > > > >  };
> > > > > --
> > > > > 2.39.2
> > > > >
> > >
> > >
> > >
> > > --
> > > Best regards,
> > >
> > > Keguang Zhang
> 
> 
> 
> -- 
> Best regards,
> 
> Keguang Zhang
