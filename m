Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BB578B67D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjH1Rbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjH1RbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:31:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DE31BC;
        Mon, 28 Aug 2023 10:30:56 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b962c226ceso52581901fa.3;
        Mon, 28 Aug 2023 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693243855; x=1693848655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IRfwoJDTu+2C3OAgG6kSzHRUwrazLgZNycEOXCkCd2I=;
        b=LrZ7d98CzxZIYp5HNIGN1gMcoJ0QnG1ShrbnDv+6RXNV0EuDIukO60xVKEMYZUCUnT
         SDodcdi9elitWMDOUS8XwMFqi9S6xfjes/0niuxbkc2Yl+dPhrfbuJey0vcYnlX5os3r
         008CDY+OTLDCdjbEN+i3WQtlufaCJ75ZvqGtfc0I8DocPItroB5ws3b/oRn+Wwst/aa6
         5WqT23G9HH6ZaCU4g2+eaNWHYUvm9V5XChq41OYQktgOhlR8kloE8IY+js25nzhlAh1d
         ADQp6lQCB3t3/bSKwD5yQOJ87VPMweCfxh99PRwJu/E/3KOCEMcnZWAFfEtl1cPRXaEv
         ttkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693243855; x=1693848655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRfwoJDTu+2C3OAgG6kSzHRUwrazLgZNycEOXCkCd2I=;
        b=R8yy4cYXuSO+RvIMYn2ZLld4NbqzDb4Re/DTniskYT0jglJkNjuSS9KLaS8jykB5jR
         TytfKDNrV7whW9hhOKF/tA2E6kstfVu0Ne878VJG0CXSuqm5TTOdKfZDaRiOWrvaUpFs
         XsMcAVaco77/dGshE3ONEax7EbnYWOu1mzd4oZ5eP2IL7F676+kidbflZTLhEVdJW8Jz
         cSdGC/UQ+zEICbJ1x4la8D2FUOw6dihS04KkVuLwiZpVU1Fp42u+2mteyc21l0RUZf+S
         7lN8OptCW520buCdTiJKNLeEXMOr4BKLxrZMjGWiSOCER7zRoEfkwcTVA+i2kPXtOA/t
         IVIw==
X-Gm-Message-State: AOJu0YyGSzemrkmlNKIJ3PR1cz4PkS9Uli+MEx9+Ps7l/wUvv8Hjwm7h
        1R8/RBJBfvDLyrYcvBaYCpc=
X-Google-Smtp-Source: AGHT+IFvMq6mkM90z4EUWRa/Q01QxN1AMxaIyzH1el+hb1oJBIqpXET1QT37VBfZJnnbF2qo5BCcnw==
X-Received: by 2002:a2e:6f1a:0:b0:2bc:fe17:693c with SMTP id k26-20020a2e6f1a000000b002bcfe17693cmr5010664ljc.30.1693243854427;
        Mon, 28 Aug 2023 10:30:54 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f14-20020a2ea0ce000000b002b6b7a98c4bsm1810980ljm.77.2023.08.28.10.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 10:30:53 -0700 (PDT)
Date:   Mon, 28 Aug 2023 20:30:50 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, Maxime@web.codeaurora.org,
        Coquelin@web.codeaurora.org,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: add glue layer for T-HEAD
 TH1520 SoC
Message-ID: <logkjnuiq2jgrphv4y7bqy523zsj6pskafwzpfdg6grvk5m7jk@hgucfu4e6azo>
References: <20230827091710.1483-1-jszhang@kernel.org>
 <20230827091710.1483-4-jszhang@kernel.org>
 <maj7mkdtkhp3z7xzcwvopnup3lhm5h5wyxz3j2ljryjbwpwilx@xdizgwctqukn>
 <ZOzAO5xhWdGcBXD1@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOzAO5xhWdGcBXD1@xhacker>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 11:41:47PM +0800, Jisheng Zhang wrote:
> On Mon, Aug 28, 2023 at 04:40:19PM +0300, Serge Semin wrote:
> > On Sun, Aug 27, 2023 at 05:17:10PM +0800, Jisheng Zhang wrote:
> > > Add dwmac glue driver to support the dwmac on the T-HEAD TH1520 SoC.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
> > >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> > >  .../net/ethernet/stmicro/stmmac/dwmac-thead.c | 302 ++++++++++++++++++
> > >  3 files changed, 314 insertions(+)
> > >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > index 06c6871f8788..1bf71804c270 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > @@ -216,6 +216,17 @@ config DWMAC_SUN8I
> > >  	  stmmac device driver. This driver is used for H3/A83T/A64
> > >  	  EMAC ethernet controller.
> > >  
> > > +config DWMAC_THEAD
> > > +	tristate "T-HEAD dwmac support"
> > > +	depends on OF && (ARCH_THEAD || COMPILE_TEST)
> > > +	select MFD_SYSCON
> > > +	help
> > > +	  Support for ethernet controllers on T-HEAD RISC-V SoCs
> > > +
> > > +	  This selects the T-HEAD platform specific glue layer support for
> > > +	  the stmmac device driver. This driver is used for T-HEAD TH1520
> > > +	  ethernet controller.
> > > +
> > >  config DWMAC_IMX8
> > >  	tristate "NXP IMX8 DWMAC support"
> > >  	default ARCH_MXC
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > > index 5b57aee19267..d73171ed6ad7 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > > @@ -27,6 +27,7 @@ obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
> > >  obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
> > >  obj-$(CONFIG_DWMAC_SUNXI)	+= dwmac-sunxi.o
> > >  obj-$(CONFIG_DWMAC_SUN8I)	+= dwmac-sun8i.o
> > > +obj-$(CONFIG_DWMAC_THEAD)	+= dwmac-thead.o
> > >  obj-$(CONFIG_DWMAC_DWC_QOS_ETH)	+= dwmac-dwc-qos-eth.o
> > >  obj-$(CONFIG_DWMAC_INTEL_PLAT)	+= dwmac-intel-plat.o
> > >  obj-$(CONFIG_DWMAC_GENERIC)	+= dwmac-generic.o
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > new file mode 100644
> > > index 000000000000..85135ef05906
> > > --- /dev/null
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > @@ -0,0 +1,302 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * T-HEAD DWMAC platform driver
> > > + *
> > > + * Copyright (C) 2021 Alibaba Group Holding Limited.
> > > + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > > + *
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/of_net.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#include "stmmac_platform.h"
> > > +
> > > +#define GMAC_CLK_EN			0x00
> > > +#define  GMAC_TX_CLK_EN			BIT(1)
> > > +#define  GMAC_TX_CLK_N_EN		BIT(2)
> > > +#define  GMAC_TX_CLK_OUT_EN		BIT(3)
> > > +#define  GMAC_RX_CLK_EN			BIT(4)
> > > +#define  GMAC_RX_CLK_N_EN		BIT(5)
> > > +#define  GMAC_EPHY_REF_CLK_EN		BIT(6)
> > > +#define GMAC_RXCLK_DELAY_CTRL		0x04
> > > +#define  GMAC_RXCLK_BYPASS		BIT(15)
> > > +#define  GMAC_RXCLK_INVERT		BIT(14)
> > > +#define  GMAC_RXCLK_DELAY_MASK		GENMASK(4, 0)
> > > +#define  GMAC_RXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
> > > +#define GMAC_TXCLK_DELAY_CTRL		0x08
> > > +#define  GMAC_TXCLK_BYPASS		BIT(15)
> > > +#define  GMAC_TXCLK_INVERT		BIT(14)
> > > +#define  GMAC_TXCLK_DELAY_MASK		GENMASK(4, 0)
> > > +#define  GMAC_TXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
> > > +#define GMAC_PLLCLK_DIV			0x0c
> > > +#define  GMAC_PLLCLK_DIV_EN		BIT(31)
> > > +#define  GMAC_PLLCLK_DIV_MASK		GENMASK(7, 0)
> > > +#define  GMAC_PLLCLK_DIV_NUM(x)		FIELD_PREP(GMAC_PLLCLK_DIV_MASK, (x))
> > > +#define GMAC_GTXCLK_SEL			0x18
> > > +#define  GMAC_GTXCLK_SEL_PLL		BIT(0)
> > > +#define GMAC_INTF_CTRL			0x1c
> > > +#define  PHY_INTF_MASK			BIT(0)
> > > +#define  PHY_INTF_RGMII			FIELD_PREP(PHY_INTF_MASK, 1)
> > > +#define  PHY_INTF_MII_GMII		FIELD_PREP(PHY_INTF_MASK, 0)
> > > +#define GMAC_TXCLK_OEN			0x20
> > > +#define  TXCLK_DIR_MASK			BIT(0)
> > > +#define  TXCLK_DIR_OUTPUT		FIELD_PREP(TXCLK_DIR_MASK, 0)
> > > +#define  TXCLK_DIR_INPUT		FIELD_PREP(TXCLK_DIR_MASK, 1)
> > > +
> > > +#define GMAC_GMII_RGMII_RATE	125000000
> > > +#define GMAC_MII_RATE		25000000
> > > +
> > > +struct thead_dwmac {
> > > +	struct plat_stmmacenet_data *plat;
> > > +	struct regmap *apb_regmap;
> > > +	struct device *dev;
> > > +	u32 rx_delay;
> > > +	u32 tx_delay;
> > > +};
> > > +
> > > +static int thead_dwmac_set_phy_if(struct plat_stmmacenet_data *plat)
> > > +{
> > > +	struct thead_dwmac *dwmac = plat->bsp_priv;
> > > +	u32 phyif;
> > > +
> > > +	switch (plat->interface) {
> > > +	case PHY_INTERFACE_MODE_MII:
> > > +		phyif = PHY_INTF_MII_GMII;
> > > +		break;
> > > +	case PHY_INTERFACE_MODE_RGMII:
> > > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > > +		phyif = PHY_INTF_RGMII;
> > > +		break;
> > > +	default:
> > > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > > +			plat->interface);
> > > +		return -EINVAL;
> > > +	};
> > > +
> > > +	regmap_write(dwmac->apb_regmap, GMAC_INTF_CTRL, phyif);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
> > > +{
> > > +	struct thead_dwmac *dwmac = plat->bsp_priv;
> > > +	u32 txclk_dir;
> > > +
> > > +	switch (plat->interface) {
> > > +	case PHY_INTERFACE_MODE_MII:
> > > +		txclk_dir = TXCLK_DIR_INPUT;
> > > +		break;
> > > +	case PHY_INTERFACE_MODE_RGMII:
> > > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > > +		txclk_dir = TXCLK_DIR_OUTPUT;
> > > +		break;
> > > +	default:
> > > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > > +			plat->interface);
> > > +		return -EINVAL;
> > > +	};
> > > +
> > > +	regmap_write(dwmac->apb_regmap, GMAC_TXCLK_OEN, txclk_dir);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> > > +{
> > > +	struct thead_dwmac *dwmac = priv;
> > > +	struct plat_stmmacenet_data *plat = dwmac->plat;
> > > +	unsigned long rate;
> > > +	u32 div;
> > > +
> > > +	switch (plat->interface) {
> > > +	/* For MII, rxc/txc is provided by phy */
> > > +	case PHY_INTERFACE_MODE_MII:
> > > +		return;
> > > +
> > > +	case PHY_INTERFACE_MODE_RGMII:
> > > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > 
> > > +		rate = clk_get_rate(plat->stmmac_clk);
> > > +		if (!rate || rate % GMAC_GMII_RGMII_RATE != 0 ||
> > > +		    rate % GMAC_MII_RATE != 0) {
> > > +			dev_err(dwmac->dev, "invalid gmac rate %ld\n", rate);
> > > +			return;
> > > +		}
> > > +
> > > +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV, GMAC_PLLCLK_DIV_EN, 0);
> > > +
> > > +		switch (speed) {
> > > +		case SPEED_1000:
> > > +			div = rate / GMAC_GMII_RGMII_RATE;
> > > +			break;
> > > +		case SPEED_100:
> > > +			div = rate / GMAC_MII_RATE;
> > > +			break;
> > > +		case SPEED_10:
> > > +			div = rate * 10 / GMAC_MII_RATE;
> > > +			break;
> > > +		default:
> > > +			dev_err(dwmac->dev, "invalid speed %u\n", speed);
> > > +			return;
> > > +		}
> > > +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> > > +				   GMAC_PLLCLK_DIV_MASK, GMAC_PLLCLK_DIV_NUM(div));
> > > +
> > > +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> > > +				   GMAC_PLLCLK_DIV_EN, GMAC_PLLCLK_DIV_EN);
> > 
> > This chunk looks like a hard-coded implementation of the
> > CLK_SET_RATE_GATE Tx-clocks rate setup which parental clock is the
> > "stmmaceth" clock. I suggest to move it to the respective driver, add
> > a "tx" clock to the bindings and use the common clock kernel API
> > methods here only.
> 
> I did consider your solution before writing the code, here are the
> reasons why I dropped it:
> 

> There's no any clk IP here, the HW just puts several
> gmac related control bits here, such as rx/tx delay, bypass, invert
> interface choice, clk direction. 

You omitted the essential part of your code which I pointed out.

> From this point of view, it looks more
> like a syscon rather than clk.

Toggling control bits is surely the syscon work. But gating a parental
clock, settings up the parental clock _divider_ and ungating the clock
back is the clock controller function. So it means your syscon is just
a normal multi-function device, which one of the function is the clock
controller.

It's not like your situation is unique. For instance in case of a SoC
I was working with recently Clock Control Unit (CCU) was actually a
multi-function device which had:
1. PLLs and Dividers supplying the clocks to the SoC components.
2. SoC components reset controller.
3. I2C-interface controller.
4. AXI-bus errors report registers.
5. PCIe-controller tunings (LTSSM, link up/down, etc)
6. SATA-controller tunings.
7. Full SoC reset controller (syscon reboot),
8. L2-cache tunings controller.
with the sub-functions CSRs joint in a single space. In that case the
PCIe-controller tunings and a lot of its reference clocks settings
were intermixed in a single chunk of the registers. So I had to create
a driver for the clocks anyway including all the PCIe reference
clock and refer to the syscon in the PCIe-controller device node for
the respective PCIe platform-specific tunings.

> 
> Secondly, I see other SoCs did similar for this case, such as
> dwmac-visconti, dwmac-meson8b, dwmac-ipq806x, dwmac-socfpga and so on.
> They met similar issue as the above.

First I failed to find any clock-related things in the dwmac-socfpga
driver looking in anyway as yours. Second the dwmac-meson8b driver
creates a generic clock handler right in the driver. I don't think
it's a great solution but at the very least it registers the clock
handler in the kernel. But seeing the PROG_ETHERNET CSR is of 8 bytes
long there (0xc8834540 0x8) and defined at looking random base address
it's definitely a part of a Meson system controller which just
directly passed to the device driver. It's not correct. That part
should have been at least specified as a syscon too. Third the
dwmac-visconti driver is not a good example seeing it defines some
specific registers way away from the NIC CSR space. It's most likely a
separate device like syscon. Fourth dwmac-ipq806x driver
implementation looks indeed like yours.

In anyway I don't say your solution is fully wrong. At the very least
you have a syscon node defined. But it just makes you adding
incomplete device/platform bindings. Your network device do have the
Tx reference clock as a part of the separate system controller, but
you have to omit it because of the syscon property. You do have a
syscon node, but don't have its clock function exported. So AFAICS in
your case things can be implemented in a more canonical way than they
are now.

-Serge(y)

> 
> PS: here is the initial th1520 clk driver, as is seen, the clk IP is
> different from the control logic here.
> 
> https://lore.kernel.org/linux-riscv/20230515054402.27633-1-frank.li@vivo.com/
> 
> Thanks
> 
> > 
> > > +		break;
> > > +	default:
> > > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > > +			plat->interface);
> > > +		return;
> > > +	}
> > > +}
> > > +
> > > +static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
> > > +{
> > > +	struct thead_dwmac *dwmac = plat->bsp_priv;
> > > +	u32 reg;
> > > +
> > > +	switch (plat->interface) {
> > > +	case PHY_INTERFACE_MODE_MII:
> > > +		reg = GMAC_RX_CLK_EN | GMAC_TX_CLK_EN;
> > > +		break;
> > > +
> > > +	case PHY_INTERFACE_MODE_RGMII:
> > > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > > +		/* use pll */
> > > +		regmap_write(dwmac->apb_regmap, GMAC_GTXCLK_SEL, GMAC_GTXCLK_SEL_PLL);
> > > +
> > 
> > > +		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
> > > +		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;
> > 
> > Similarly settings these flags looks like just clock gates which can
> > also be moved to the clock driver.
> > 
> > > +		break;
> > > +
> > > +	default:
> > > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > > +			plat->interface);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	regmap_write(dwmac->apb_regmap, GMAC_CLK_EN, reg);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int thead_dwmac_init(struct platform_device *pdev,
> > > +			    struct plat_stmmacenet_data *plat)
> > > +{
> > > +	struct thead_dwmac *dwmac = plat->bsp_priv;
> > > +	int ret;
> > > +
> > > +	ret = thead_dwmac_set_phy_if(plat);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = thead_dwmac_set_txclk_dir(plat);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	regmap_write(dwmac->apb_regmap, GMAC_RXCLK_DELAY_CTRL,
> > > +		     GMAC_RXCLK_DELAY_VAL(dwmac->rx_delay));
> > > +	regmap_write(dwmac->apb_regmap, GMAC_TXCLK_DELAY_CTRL,
> > > +		     GMAC_TXCLK_DELAY_VAL(dwmac->tx_delay));
> > > +
> > > +	thead_dwmac_fix_speed(dwmac, SPEED_1000, 0);
> > > +
> > > +	return thead_dwmac_enable_clk(plat);
> > > +}
> > > +
> > > +static int thead_dwmac_probe(struct platform_device *pdev)
> > > +{
> > > +	struct plat_stmmacenet_data *plat;
> > > +	struct stmmac_resources stmmac_res;
> > > +	struct thead_dwmac *dwmac;
> > > +	struct device_node *np = pdev->dev.of_node;
> > > +	u32 delay_ps;
> > > +	int ret;
> > > +
> > > +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> > > +	if (ret)
> > > +		return dev_err_probe(&pdev->dev, ret,
> > > +				     "failed to get resources\n");
> > > +
> > 
> > > +	plat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
> > 
> > This can be replaced with devm_stmmac_probe_config_dt() so the
> > stmmac_remove_config_dt() invocation would be dropped.
> > 
> > > +	if (IS_ERR(plat))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
> > > +				     "dt configuration failed\n");
> > > +
> > > +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> > > +	if (!dwmac) {
> > > +		ret = -ENOMEM;
> > > +		goto err_remove_config_dt;
> > > +	}
> > > +
> > > +	if (!of_property_read_u32(np, "rx-internal-delay-ps", &delay_ps))
> > > +		dwmac->rx_delay = delay_ps;
> > > +	if (!of_property_read_u32(np, "tx-internal-delay-ps", &delay_ps))
> > > +		dwmac->tx_delay = delay_ps;
> > > +
> > > +	dwmac->apb_regmap = syscon_regmap_lookup_by_phandle(np, "thead,gmacapb");
> > > +	if (IS_ERR(dwmac->apb_regmap)) {
> > > +		ret = dev_err_probe(&pdev->dev, PTR_ERR(dwmac->apb_regmap),
> > > +				    "Failed to get gmac apb syscon\n");
> > > +		goto err_remove_config_dt;
> > > +	}
> > > +
> > > +	dwmac->dev = &pdev->dev;
> > > +	dwmac->plat = plat;
> > > +	plat->bsp_priv = dwmac;
> > > +	plat->fix_mac_speed = thead_dwmac_fix_speed;
> > > +
> > 
> > > +	ret = thead_dwmac_init(pdev, plat);
> > > +	if (ret)
> > > +		goto err_remove_config_dt;
> > > +
> > > +	ret = stmmac_dvr_probe(&pdev->dev, plat, &stmmac_res);
> > 
> > This can be replaced with:
> > plat->init = thead_dwmac_init;
> > ret = devm_stmmac_pltfr_probe();
> > 
> > > +	if (ret)
> > > +		goto err_remove_config_dt;
> > > +
> > > +	return 0;
> > > +
> > 
> > > +err_remove_config_dt:
> > > +	stmmac_remove_config_dt(pdev, plat);
> > > +
> > > +	return ret;
> > 
> > This can be dropped if devm_stmmac_probe_config_dt() is utilized.
> > 
> > > +}
> > > +
> > > +static const struct of_device_id thead_dwmac_match[] = {
> > 
> > > +	{ .compatible = "thead,th1520-dwmac" },
> > 
> > See my comment to the bindings about the compatible string suffix.
> > 
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, thead_dwmac_match);
> > > +
> > > +static struct platform_driver thead_dwmac_driver = {
> > > +	.probe = thead_dwmac_probe,
> > 
> > > +	.remove_new = stmmac_pltfr_remove,
> > 
> > This can be dropped if devm_stmmac_probe_config_dt() and
> > devm_stmmac_pltfr_probe() are utilized.
> > 
> > > +	.driver = {
> > > +		.name = "thead-dwmac",
> > > +		.pm = &stmmac_pltfr_pm_ops,
> > > +		.of_match_table = thead_dwmac_match,
> > > +	},
> > > +};
> > > +module_platform_driver(thead_dwmac_driver);
> > > +
> > > +MODULE_AUTHOR("T-HEAD");
> > > +MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
> > 
> > > +MODULE_DESCRIPTION("T-HEAD dwmac platform driver");
> >                               ^
> >                               |
> > Capitalize? ------------------+
> > 
> > -Serge(y)
> > 
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.40.1
> > > 
> > > 
