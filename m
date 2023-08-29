Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C919A78BD42
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjH2D3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjH2D3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:29:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB60123;
        Mon, 28 Aug 2023 20:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E7B2635A1;
        Tue, 29 Aug 2023 03:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BF4C433C8;
        Tue, 29 Aug 2023 03:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693279776;
        bh=pkLE9UcEziJW1NdrYNC30jdjpO3GI5kYG+hces0qcNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pg05PWKDkQU1rzdHaeMgkutxYZF3R8rwD8yZdKRaoP0Obvz01ojB6mi0zXiTq4lgA
         q/aBVHF3vRhKJ/GFPuvKEUCrmTgrncXnOJ8xstjPtPjCsvYlf/NWUgeO6NE7wl1qIo
         r9XKY/VqZ6qb/2tOtNWR0sbRzxJLlnO3WIvA0dw10nDz7TCkw4km5HqDwQQSvs1yq8
         p8SUM+/BkfBOkLQ/ZhEmOLWswylB/tBqet/fk5QPw24zaVA4Mr9p4HueiG7mAw9uBw
         NaHroWJyfQtG77dt9qOdNUpKb3caZus6okrPx3WVC/f131Jbnk1oHO3rm/1zTnEHwQ
         J07qy5sK/PZew==
Date:   Tue, 29 Aug 2023 11:17:45 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>
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
Message-ID: <ZO1jWUa7xgZuHdRH@xhacker>
References: <20230827091710.1483-1-jszhang@kernel.org>
 <20230827091710.1483-4-jszhang@kernel.org>
 <maj7mkdtkhp3z7xzcwvopnup3lhm5h5wyxz3j2ljryjbwpwilx@xdizgwctqukn>
 <ZOzAO5xhWdGcBXD1@xhacker>
 <logkjnuiq2jgrphv4y7bqy523zsj6pskafwzpfdg6grvk5m7jk@hgucfu4e6azo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <logkjnuiq2jgrphv4y7bqy523zsj6pskafwzpfdg6grvk5m7jk@hgucfu4e6azo>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 08:30:50PM +0300, Serge Semin wrote:
> On Mon, Aug 28, 2023 at 11:41:47PM +0800, Jisheng Zhang wrote:
> > On Mon, Aug 28, 2023 at 04:40:19PM +0300, Serge Semin wrote:
> > > On Sun, Aug 27, 2023 at 05:17:10PM +0800, Jisheng Zhang wrote:
> > > > Add dwmac glue driver to support the dwmac on the T-HEAD TH1520 SoC.
> > > > 
> > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
> > > >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
> > > >  .../net/ethernet/stmicro/stmmac/dwmac-thead.c | 302 ++++++++++++++++++
> > > >  3 files changed, 314 insertions(+)
> > > >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > > index 06c6871f8788..1bf71804c270 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > > > @@ -216,6 +216,17 @@ config DWMAC_SUN8I
> > > >  	  stmmac device driver. This driver is used for H3/A83T/A64
> > > >  	  EMAC ethernet controller.
> > > >  
> > > > +config DWMAC_THEAD
> > > > +	tristate "T-HEAD dwmac support"
> > > > +	depends on OF && (ARCH_THEAD || COMPILE_TEST)
> > > > +	select MFD_SYSCON
> > > > +	help
> > > > +	  Support for ethernet controllers on T-HEAD RISC-V SoCs
> > > > +
> > > > +	  This selects the T-HEAD platform specific glue layer support for
> > > > +	  the stmmac device driver. This driver is used for T-HEAD TH1520
> > > > +	  ethernet controller.
> > > > +
> > > >  config DWMAC_IMX8
> > > >  	tristate "NXP IMX8 DWMAC support"
> > > >  	default ARCH_MXC
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > > > index 5b57aee19267..d73171ed6ad7 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > > > @@ -27,6 +27,7 @@ obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
> > > >  obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
> > > >  obj-$(CONFIG_DWMAC_SUNXI)	+= dwmac-sunxi.o
> > > >  obj-$(CONFIG_DWMAC_SUN8I)	+= dwmac-sun8i.o
> > > > +obj-$(CONFIG_DWMAC_THEAD)	+= dwmac-thead.o
> > > >  obj-$(CONFIG_DWMAC_DWC_QOS_ETH)	+= dwmac-dwc-qos-eth.o
> > > >  obj-$(CONFIG_DWMAC_INTEL_PLAT)	+= dwmac-intel-plat.o
> > > >  obj-$(CONFIG_DWMAC_GENERIC)	+= dwmac-generic.o
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > > new file mode 100644
> > > > index 000000000000..85135ef05906
> > > > --- /dev/null
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > > > @@ -0,0 +1,302 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * T-HEAD DWMAC platform driver
> > > > + *
> > > > + * Copyright (C) 2021 Alibaba Group Holding Limited.
> > > > + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > > > + *
> > > > + */
> > > > +
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/mfd/syscon.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/of_device.h>
> > > > +#include <linux/of_net.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/regmap.h>
> > > > +
> > > > +#include "stmmac_platform.h"
> > > > +
> > > > +#define GMAC_CLK_EN			0x00
> > > > +#define  GMAC_TX_CLK_EN			BIT(1)
> > > > +#define  GMAC_TX_CLK_N_EN		BIT(2)
> > > > +#define  GMAC_TX_CLK_OUT_EN		BIT(3)
> > > > +#define  GMAC_RX_CLK_EN			BIT(4)
> > > > +#define  GMAC_RX_CLK_N_EN		BIT(5)
> > > > +#define  GMAC_EPHY_REF_CLK_EN		BIT(6)
> > > > +#define GMAC_RXCLK_DELAY_CTRL		0x04
> > > > +#define  GMAC_RXCLK_BYPASS		BIT(15)
> > > > +#define  GMAC_RXCLK_INVERT		BIT(14)
> > > > +#define  GMAC_RXCLK_DELAY_MASK		GENMASK(4, 0)
> > > > +#define  GMAC_RXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
> > > > +#define GMAC_TXCLK_DELAY_CTRL		0x08
> > > > +#define  GMAC_TXCLK_BYPASS		BIT(15)
> > > > +#define  GMAC_TXCLK_INVERT		BIT(14)
> > > > +#define  GMAC_TXCLK_DELAY_MASK		GENMASK(4, 0)
> > > > +#define  GMAC_TXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
> > > > +#define GMAC_PLLCLK_DIV			0x0c
> > > > +#define  GMAC_PLLCLK_DIV_EN		BIT(31)
> > > > +#define  GMAC_PLLCLK_DIV_MASK		GENMASK(7, 0)
> > > > +#define  GMAC_PLLCLK_DIV_NUM(x)		FIELD_PREP(GMAC_PLLCLK_DIV_MASK, (x))
> > > > +#define GMAC_GTXCLK_SEL			0x18
> > > > +#define  GMAC_GTXCLK_SEL_PLL		BIT(0)
> > > > +#define GMAC_INTF_CTRL			0x1c
> > > > +#define  PHY_INTF_MASK			BIT(0)
> > > > +#define  PHY_INTF_RGMII			FIELD_PREP(PHY_INTF_MASK, 1)
> > > > +#define  PHY_INTF_MII_GMII		FIELD_PREP(PHY_INTF_MASK, 0)
> > > > +#define GMAC_TXCLK_OEN			0x20
> > > > +#define  TXCLK_DIR_MASK			BIT(0)
> > > > +#define  TXCLK_DIR_OUTPUT		FIELD_PREP(TXCLK_DIR_MASK, 0)
> > > > +#define  TXCLK_DIR_INPUT		FIELD_PREP(TXCLK_DIR_MASK, 1)
> > > > +
> > > > +#define GMAC_GMII_RGMII_RATE	125000000
> > > > +#define GMAC_MII_RATE		25000000
> > > > +
> > > > +struct thead_dwmac {
> > > > +	struct plat_stmmacenet_data *plat;
> > > > +	struct regmap *apb_regmap;
> > > > +	struct device *dev;
> > > > +	u32 rx_delay;
> > > > +	u32 tx_delay;
> > > > +};
> > > > +
> > > > +static int thead_dwmac_set_phy_if(struct plat_stmmacenet_data *plat)
> > > > +{
> > > > +	struct thead_dwmac *dwmac = plat->bsp_priv;
> > > > +	u32 phyif;
> > > > +
> > > > +	switch (plat->interface) {
> > > > +	case PHY_INTERFACE_MODE_MII:
> > > > +		phyif = PHY_INTF_MII_GMII;
> > > > +		break;
> > > > +	case PHY_INTERFACE_MODE_RGMII:
> > > > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > > > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > > > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > > > +		phyif = PHY_INTF_RGMII;
> > > > +		break;
> > > > +	default:
> > > > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > > > +			plat->interface);
> > > > +		return -EINVAL;
> > > > +	};
> > > > +
> > > > +	regmap_write(dwmac->apb_regmap, GMAC_INTF_CTRL, phyif);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
> > > > +{
> > > > +	struct thead_dwmac *dwmac = plat->bsp_priv;
> > > > +	u32 txclk_dir;
> > > > +
> > > > +	switch (plat->interface) {
> > > > +	case PHY_INTERFACE_MODE_MII:
> > > > +		txclk_dir = TXCLK_DIR_INPUT;
> > > > +		break;
> > > > +	case PHY_INTERFACE_MODE_RGMII:
> > > > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > > > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > > > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > > > +		txclk_dir = TXCLK_DIR_OUTPUT;
> > > > +		break;
> > > > +	default:
> > > > +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> > > > +			plat->interface);
> > > > +		return -EINVAL;
> > > > +	};
> > > > +
> > > > +	regmap_write(dwmac->apb_regmap, GMAC_TXCLK_OEN, txclk_dir);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> > > > +{
> > > > +	struct thead_dwmac *dwmac = priv;
> > > > +	struct plat_stmmacenet_data *plat = dwmac->plat;
> > > > +	unsigned long rate;
> > > > +	u32 div;
> > > > +
> > > > +	switch (plat->interface) {
> > > > +	/* For MII, rxc/txc is provided by phy */
> > > > +	case PHY_INTERFACE_MODE_MII:
> > > > +		return;
> > > > +
> > > > +	case PHY_INTERFACE_MODE_RGMII:
> > > > +	case PHY_INTERFACE_MODE_RGMII_ID:
> > > > +	case PHY_INTERFACE_MODE_RGMII_RXID:
> > > > +	case PHY_INTERFACE_MODE_RGMII_TXID:
> > > 
> > > > +		rate = clk_get_rate(plat->stmmac_clk);
> > > > +		if (!rate || rate % GMAC_GMII_RGMII_RATE != 0 ||
> > > > +		    rate % GMAC_MII_RATE != 0) {
> > > > +			dev_err(dwmac->dev, "invalid gmac rate %ld\n", rate);
> > > > +			return;
> > > > +		}
> > > > +
> > > > +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV, GMAC_PLLCLK_DIV_EN, 0);
> > > > +
> > > > +		switch (speed) {
> > > > +		case SPEED_1000:
> > > > +			div = rate / GMAC_GMII_RGMII_RATE;
> > > > +			break;
> > > > +		case SPEED_100:
> > > > +			div = rate / GMAC_MII_RATE;
> > > > +			break;
> > > > +		case SPEED_10:
> > > > +			div = rate * 10 / GMAC_MII_RATE;
> > > > +			break;
> > > > +		default:
> > > > +			dev_err(dwmac->dev, "invalid speed %u\n", speed);
> > > > +			return;
> > > > +		}
> > > > +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> > > > +				   GMAC_PLLCLK_DIV_MASK, GMAC_PLLCLK_DIV_NUM(div));
> > > > +
> > > > +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> > > > +				   GMAC_PLLCLK_DIV_EN, GMAC_PLLCLK_DIV_EN);
> > > 
> > > This chunk looks like a hard-coded implementation of the
> > > CLK_SET_RATE_GATE Tx-clocks rate setup which parental clock is the
> > > "stmmaceth" clock. I suggest to move it to the respective driver, add
> > > a "tx" clock to the bindings and use the common clock kernel API
> > > methods here only.
> > 
> > I did consider your solution before writing the code, here are the
> > reasons why I dropped it:
> > 
> 
> > There's no any clk IP here, the HW just puts several
> > gmac related control bits here, such as rx/tx delay, bypass, invert
> > interface choice, clk direction. 
> 
> You omitted the essential part of your code which I pointed out.
> 
> > From this point of view, it looks more
> > like a syscon rather than clk.
> 
> Toggling control bits is surely the syscon work. But gating a parental
> clock, settings up the parental clock _divider_ and ungating the clock
> back is the clock controller function. So it means your syscon is just
> a normal multi-function device, which one of the function is the clock
> controller.
> 
> It's not like your situation is unique. For instance in case of a SoC
> I was working with recently Clock Control Unit (CCU) was actually a
> multi-function device which had:
> 1. PLLs and Dividers supplying the clocks to the SoC components.

Hi Serge,

This is the big difference between your case and TH1520 gmac.
(PS: @Emil, I read your comments in another reply. IIUC, jh7110 puts a
real clk IP for gmac tx clock purpose)

However, There's no real clk IP in the TH1520 gmac related syscon, yep, div
and enable are some what clock related bits, but that's all, no more, no less.
So even in this case, another abstraction layer via. clk subsystem is still
preferred? IOW, a seperate clk driver for the gmac?

Thanks
> 
> 2. SoC components reset controller.
> 3. I2C-interface controller.
> 4. AXI-bus errors report registers.
> 5. PCIe-controller tunings (LTSSM, link up/down, etc)
> 6. SATA-controller tunings.
> 7. Full SoC reset controller (syscon reboot),
> 8. L2-cache tunings controller.
> with the sub-functions CSRs joint in a single space. In that case the
> PCIe-controller tunings and a lot of its reference clocks settings
> were intermixed in a single chunk of the registers. So I had to create
> a driver for the clocks anyway including all the PCIe reference
> clock and refer to the syscon in the PCIe-controller device node for
> the respective PCIe platform-specific tunings.
> 
> > 
> > Secondly, I see other SoCs did similar for this case, such as
> > dwmac-visconti, dwmac-meson8b, dwmac-ipq806x, dwmac-socfpga and so on.
> > They met similar issue as the above.
> 
> First I failed to find any clock-related things in the dwmac-socfpga

I believe the ptp ref clk related is just to enable the clk by toggling
corresponding bit. Anyway that's not important part here.

> driver looking in anyway as yours. Second the dwmac-meson8b driver
> creates a generic clock handler right in the driver. I don't think
> it's a great solution but at the very least it registers the clock
> handler in the kernel. But seeing the PROG_ETHERNET CSR is of 8 bytes
> long there (0xc8834540 0x8) and defined at looking random base address
> it's definitely a part of a Meson system controller which just
> directly passed to the device driver. It's not correct. That part
> should have been at least specified as a syscon too. Third the
> dwmac-visconti driver is not a good example seeing it defines some
> specific registers way away from the NIC CSR space. It's most likely a
> separate device like syscon. Fourth dwmac-ipq806x driver
> implementation looks indeed like yours.

> In anyway I don't say your solution is fully wrong. At the very least
> you have a syscon node defined. But it just makes you adding
> incomplete device/platform bindings. Your network device do have the
> Tx reference clock as a part of the separate system controller, but
> you have to omit it because of the syscon property. You do have a
> syscon node, but don't have its clock function exported. So AFAICS in
> your case things can be implemented in a more canonical way than they
> are now.
> 
