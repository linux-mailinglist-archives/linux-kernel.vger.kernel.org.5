Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F18C806CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377880AbjLFK6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377883AbjLFK6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:58:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40268D3;
        Wed,  6 Dec 2023 02:58:24 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1C20A660576A;
        Wed,  6 Dec 2023 10:58:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701860302;
        bh=+VSlk10/LdFmkMalHI3hr1OlICHle6U/dgMAM/Y+9IE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=N5JYuZ6IPxJYhpHqkHN5wwLK16lvOvFE/E3xaMlycsD9+6boYSeNDT6GcQxxu50mz
         gZ+iNioDdOL7EL/o3n79R7At5HE1v6RDj/VoaPv+lVsHvQj1T7QAYZRv5QoW9xSwsc
         XHfLW3PYc25Sw+rSxCyni+hqAFBPKSOfwY6ur9fnX7uCTcfWEQFtSpfDYBXwy0MP3g
         KTiG8L5CvnEvR4gT4NUHOK+7jlMwJr/y6NbIA5U+25B1dC4MkuWegHHxOg9TRLEVGs
         O7rsqQW+4RcEAN0lokK3u3DnT3xDg7JMJMvmKKZTNFCv8tQbttGGOyGd/tGY0/kDRQ
         1UfpxVkasuHxw==
Message-ID: <21d8bd42-ae90-4ab0-88af-31722f6d4886@collabora.com>
Date:   Wed, 6 Dec 2023 11:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] clk: mediatek: add drivers for MT7988 SoC
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Jianhui Zhao <zhaojh329@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
References: <23bc89d407e7797e97b703fa939b43bfe79296ce.1701823757.git.daniel@makrotopia.org>
 <af4c5a230cc65d72987cb531518ae32706d6d95e.1701823757.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <af4c5a230cc65d72987cb531518ae32706d6d95e.1701823757.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/12/23 01:57, Daniel Golle ha scritto:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> Add APMIXED, ETH, INFRACFG and TOPCKGEN clock drivers which are
> typical MediaTek designs.
> 
> Also add driver for XFIPLL clock generating the 156.25MHz clock for
> the XFI SerDes. It needs an undocumented software workaround and has
> an unknown internal design.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: use git --from ...
> v2: no changes
> 
>   drivers/clk/mediatek/Kconfig               |   9 +
>   drivers/clk/mediatek/Makefile              |   5 +
>   drivers/clk/mediatek/clk-mt7988-apmixed.c  | 113 ++++++
>   drivers/clk/mediatek/clk-mt7988-eth.c      | 141 +++++++
>   drivers/clk/mediatek/clk-mt7988-infracfg.c | 378 +++++++++++++++++
>   drivers/clk/mediatek/clk-mt7988-topckgen.c | 446 +++++++++++++++++++++
>   drivers/clk/mediatek/clk-mt7988-xfipll.c   |  79 ++++
>   7 files changed, 1171 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-mt7988-apmixed.c
>   create mode 100644 drivers/clk/mediatek/clk-mt7988-eth.c
>   create mode 100644 drivers/clk/mediatek/clk-mt7988-infracfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt7988-topckgen.c
>   create mode 100644 drivers/clk/mediatek/clk-mt7988-xfipll.c
> 
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 48b42d11111cd..70a005e7e1b18 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -423,6 +423,15 @@ config COMMON_CLK_MT7986_ETHSYS
>   	  This driver adds support for clocks for Ethernet and SGMII
>   	  required on MediaTek MT7986 SoC.
>   
> +config COMMON_CLK_MT7988
> +	tristate "Clock driver for MediaTek MT7988"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select COMMON_CLK_MEDIATEK
> +	default ARCH_MEDIATEK
> +	help
> +	  This driver supports MediaTek MT7988 basic clocks and clocks
> +	  required for various periperals found on this SoC.
> +
>   config COMMON_CLK_MT8135
>   	tristate "Clock driver for MediaTek MT8135"
>   	depends on (ARCH_MEDIATEK && ARM) || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index dbeaa5b41177d..eeccfa039896f 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -62,6 +62,11 @@ obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-apmixed.o
>   obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-topckgen.o
>   obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-infracfg.o
>   obj-$(CONFIG_COMMON_CLK_MT7986_ETHSYS) += clk-mt7986-eth.o
> +obj-$(CONFIG_COMMON_CLK_MT7988) += clk-mt7988-apmixed.o
> +obj-$(CONFIG_COMMON_CLK_MT7988) += clk-mt7988-topckgen.o
> +obj-$(CONFIG_COMMON_CLK_MT7988) += clk-mt7988-infracfg.o
> +obj-$(CONFIG_COMMON_CLK_MT7988) += clk-mt7988-eth.o
> +obj-$(CONFIG_COMMON_CLK_MT7988) += clk-mt7988-xfipll.o
>   obj-$(CONFIG_COMMON_CLK_MT8135) += clk-mt8135-apmixedsys.o clk-mt8135.o
>   obj-$(CONFIG_COMMON_CLK_MT8167) += clk-mt8167-apmixedsys.o clk-mt8167.o
>   obj-$(CONFIG_COMMON_CLK_MT8167_AUDSYS) += clk-mt8167-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt7988-apmixed.c b/drivers/clk/mediatek/clk-mt7988-apmixed.c
> new file mode 100644
> index 0000000000000..3f1edc231e37a
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt7988-apmixed.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Sam Shih <sam.shih@mediatek.com>
> + * Author: Xiufeng Li <Xiufeng.Li@mediatek.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +#include "clk-mux.h"
> +#include "clk-pll.h"
> +#include <dt-bindings/clock/mediatek,mt7988-clk.h>
> +
> +#define MT7988_PLL_FMAX (2500UL * MHZ)
> +#define MT7988_PCW_CHG_SHIFT 2
> +
> +#define PLL_xtal(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _rst_bar_mask, \

You're never assigning any div_table, so you don't need to have PLL and PLL_xtal.

Also, why is your crystal named "clkxtal" instead of "clk26m" like all the others?

If your clkxtal is 26MHz, please just change the name to "clk26m" as this is what
is used by most of the other MTK clock drivers, and because the clk26m name does
actually stand for practically the same as your clkxtal, granted that yours is
26M.

> +		 _pcwbits, _pd_reg, _pd_shift, _tuner_reg, _tuner_en_reg,     \
> +		 _tuner_en_bit, _pcw_reg, _pcw_shift, _pcw_chg_reg,           \
> +		 _div_table)                                                  \
> +	{                                                                     \
> +		.id = _id, .name = _name, .reg = _reg, .pwr_reg = _pwr_reg,   \
> +		.en_mask = _en_mask, .flags = _flags,                         \
> +		.rst_bar_mask = BIT(_rst_bar_mask), .fmax = MT7988_PLL_FMAX,  \
> +		.pcwbits = _pcwbits, .pd_reg = _pd_reg,                       \
> +		.pd_shift = _pd_shift, .tuner_reg = _tuner_reg,               \
> +		.tuner_en_reg = _tuner_en_reg, .tuner_en_bit = _tuner_en_bit, \
> +		.pcw_reg = _pcw_reg, .pcw_shift = _pcw_shift,                 \
> +		.pcw_chg_reg = _pcw_chg_reg,                                  \
> +		.pcw_chg_shift = MT7988_PCW_CHG_SHIFT,                        \
> +		.div_table = _div_table, .parent_name = "clkxtal",            \
> +	}
> +

..snip..

> +
> +static const struct of_device_id of_match_clk_mt7988_apmixed[] = {
> +	{ .compatible = "mediatek,mt7988-apmixedsys", },

{ .compatible = "mediatek,mt7988-apmixedsys" },

( there is an extra comma: `sys", }` => `sys" }` )

> +	{ /* sentinel */ }
> +};
> +
> +static int clk_mt7988_apmixed_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	int r;
> +
> +	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(plls));
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);

Error checking is missing for mtk_clk_register_plls().

> +
> +	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (r) {
> +		pr_err("%s(): could not register clock provider: %d\n",
> +		       __func__, r);
> +		goto free_apmixed_data;
> +	}
> +	return r;
> +
> +free_apmixed_data:
> +	mtk_free_clk_data(clk_data);
> +	return r;
> +}
> +
> +static struct platform_driver clk_mt7988_apmixed_drv = {
> +	.probe = clk_mt7988_apmixed_probe,
> +	.driver = {
> +		.name = "clk-mt7988-apmixed",
> +		.of_match_table = of_match_clk_mt7988_apmixed,
> +	},
> +};
> +builtin_platform_driver(clk_mt7988_apmixed_drv);
> +MODULE_LICENSE("GPL");

..snip..

> diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg.c b/drivers/clk/mediatek/clk-mt7988-infracfg.c
> new file mode 100644
> index 0000000000000..d23f7bdfafd9d
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt7988-infracfg.c
> @@ -0,0 +1,378 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Sam Shih <sam.shih@mediatek.com>
> + * Author: Xiufeng Li <Xiufeng.Li@mediatek.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +#include "clk-mux.h"
> +#include <dt-bindings/clock/mediatek,mt7988-clk.h>
> +
> +static DEFINE_SPINLOCK(mt7988_clk_lock);
> +
> +static const char *const infra_mux_uart0_parents[] __initconst = {

Are you sure that you need those __initconst annotations?

> +	"csw_infra_f26m_sel", "uart_sel"
> +};
> +

..snip..

> +
> +static const struct mtk_gate_regs infra0_cg_regs = {
> +	.set_ofs = 0x10,
> +	.clr_ofs = 0x14,
> +	.sta_ofs = 0x18,
> +};
> +
> +static const struct mtk_gate_regs infra1_cg_regs = {
> +	.set_ofs = 0x40,
> +	.clr_ofs = 0x44,
> +	.sta_ofs = 0x48,
> +};
> +
> +static const struct mtk_gate_regs infra2_cg_regs = {
> +	.set_ofs = 0x50,
> +	.clr_ofs = 0x54,
> +	.sta_ofs = 0x58,
> +};
> +
> +static const struct mtk_gate_regs infra3_cg_regs = {
> +	.set_ofs = 0x60,
> +	.clr_ofs = 0x64,
> +	.sta_ofs = 0x68,
> +};
> +
> +#define GATE_INFRA0_FLAGS(_id, _name, _parent, _shift, _flags)			\

This is exactly the definition of GATE_MTK_FLAGS.
Use that common definition instead.

> +	{									\
> +		.id = _id, .name = _name, .parent_name = _parent,		\
> +		.regs = &infra0_cg_regs, .shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr, .flags = _flags,		\
> +	}
> +
> +#define GATE_INFRA1_FLAGS(_id, _name, _parent, _shift, _flags)			\

same

> +	{									\
> +		.id = _id, .name = _name, .parent_name = _parent,		\
> +		.regs = &infra1_cg_regs, .shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr, .flags = _flags,		\
> +	}
> +
> +#define GATE_INFRA2_FLAGS(_id, _name, _parent, _shift, _flags)			\

same again

> +	{									\
> +		.id = _id, .name = _name, .parent_name = _parent,		\
> +		.regs = &infra2_cg_regs, .shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr, .flags = _flags,		\
> +	}
> +
> +#define GATE_INFRA3_FLAGS(_id, _name, _parent, _shift, _flags)			\

and again.

> +	{									\
> +		.id = _id, .name = _name, .parent_name = _parent,		\
> +		.regs = &infra3_cg_regs, .shift = _shift,			\
> +		.ops = &mtk_clk_gate_ops_setclr, .flags = _flags,		\
> +	}
> +

#define GATE_INFRA0(_id, _name, _parent, _shift)			\
	GATE_MTK_FLAGS(_id, _name, _parent, &infra0_cg_regs, _shift,	\
		&mtk_clk_gate_ops_setclr, 0)

#define GATE_INFRA1(_id, _name, _parent, _shift)			\
	GATE_MTK_FLAGS(_id, _name, _parent, &infra1_cg_regs, _shift,	\
		&mtk_clk_gate_ops_setclr, 0)

#define GATE_INFRA2_FLAGS(_id, _name, _parent, _shift, _flags)		\
	GATE_MTK_FLAGS(_id, _name, _parent, &infra2_cg_regs, _shift,	\
		&mtk_clk_gate_ops_setclr, _flags)

#define GATE_INFRA2(_id, _name, _parent, _shift)			\
	GATE_INFRA2_FLAGS(_id, _name, _parent, _shift, 0)

#define GATE_INFRA3(_id, _name, _parent, _shift)			\
	GATE_MTK_FLAGS(_id, _name, _parent, &infra0_cg_regs, _shift,	\
		&mtk_clk_gate_ops_setclr, 0)

> +#define GATE_INFRA0(_id, _name, _parent, _shift)				\
> +	GATE_INFRA0_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +#define GATE_INFRA1(_id, _name, _parent, _shift)				\
> +	GATE_INFRA1_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +#define GATE_INFRA2(_id, _name, _parent, _shift)				\
> +	GATE_INFRA2_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +#define GATE_INFRA3(_id, _name, _parent, _shift)				\
> +	GATE_INFRA3_FLAGS(_id, _name, _parent, _shift, 0)
> +
> +
> +#define GATE_CRITICAL(_id, _name, _parent, _regs, _shift)			\


You are using it like that:
GATE_CRITICAL(CLK_INFRA_RTC, "infra_f_frtc", "top_rtc_32k", &infra2_cg_regs, 19),

Change it to
GATE_INFRA2_FLAGS(CLK_INFRA_RTC, "infra_f_frtc", "top_rtc_32k", 19),

> +	{									\
> +		.id = _id, .name = _name, .parent_name = _parent,		\
> +		.regs = _regs, .shift = _shift,					\
> +		.flags = CLK_IS_CRITICAL,					\
> +		.ops = &mtk_clk_gate_ops_setclr,				\
> +	}
> +
> +static const struct mtk_gate infra_clks[] = {
> +	/* INFRA0 */
> +	GATE_INFRA0(CLK_INFRA_PCIE_PERI_26M_CK_P0,
> +		    "infra_pcie_peri_ck_26m_ck_p0", "csw_infra_f26m_sel", 7),
> +	GATE_INFRA0(CLK_INFRA_PCIE_PERI_26M_CK_P1,
> +		    "infra_pcie_peri_ck_26m_ck_p1", "csw_infra_f26m_sel", 8),
> +	GATE_INFRA0(CLK_INFRA_PCIE_PERI_26M_CK_P2,
> +		    "infra_pcie_peri_ck_26m_ck_p2", "csw_infra_f26m_sel", 9),
> +	GATE_INFRA0(CLK_INFRA_PCIE_PERI_26M_CK_P3,
> +		    "infra_pcie_peri_ck_26m_ck_p3", "csw_infra_f26m_sel", 10),
> +	/* INFRA1 */
> +	GATE_INFRA1(CLK_INFRA_66M_GPT_BCK, "infra_hf_66m_gpt_bck",
> +		    "sysaxi_sel", 0),

This one and multiple other entries do fit in one line.

Up to 100 columns is ok: please use one line where possible, here and in the other
drivers as well, where this comment applies.

> +	GATE_INFRA1(CLK_INFRA_66M_PWM_HCK, "infra_hf_66m_pwm_hck",
> +		    "sysaxi_sel", 1),

..snip..


> diff --git a/drivers/clk/mediatek/clk-mt7988-topckgen.c b/drivers/clk/mediatek/clk-mt7988-topckgen.c
> new file mode 100644
> index 0000000000000..7bed282e615f8
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt7988-topckgen.c
> @@ -0,0 +1,446 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + * Author: Sam Shih <sam.shih@mediatek.com>
> + * Author: Xiufeng Li <Xiufeng.Li@mediatek.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +#include "clk-mux.h"
> +#include <dt-bindings/clock/mediatek,mt7988-clk.h>
> +
> +static DEFINE_SPINLOCK(mt7988_clk_lock);
> +
> +static const struct mtk_fixed_clk top_fixed_clks[] = {
> +	FIXED_CLK(CLK_TOP_XTAL, "top_xtal", "clkxtal", 40000000),

Again, why clkxtal and not clk26m?

> +};
> +
> +static const struct mtk_fixed_factor top_divs[] = {
> +	FACTOR(CLK_TOP_XTAL_D2, "top_xtal_d2", "top_xtal", 1, 2),
> +	FACTOR(CLK_TOP_RTC_32K, "top_rtc_32k", "top_xtal", 1, 1250),
> +	FACTOR(CLK_TOP_RTC_32P7K, "top_rtc_32p7k", "top_xtal", 1, 1220),
> +	FACTOR(CLK_TOP_MPLL_D2, "mpll_d2", "mpll", 1, 2),
> +	FACTOR(CLK_TOP_MPLL_D3_D2, "mpll_d3_d2", "mpll", 1, 2),
> +	FACTOR(CLK_TOP_MPLL_D4, "mpll_d4", "mpll", 1, 4),
> +	FACTOR(CLK_TOP_MPLL_D8, "mpll_d8", "mpll", 1, 8),
> +	FACTOR(CLK_TOP_MPLL_D8_D2, "mpll_d8_d2", "mpll", 1, 16),
> +	FACTOR(CLK_TOP_MMPLL_D2, "mmpll_d2", "mmpll", 1, 2),
> +	FACTOR(CLK_TOP_MMPLL_D3_D5, "mmpll_d3_d5", "mmpll", 1, 15),
> +	FACTOR(CLK_TOP_MMPLL_D4, "mmpll_d4", "mmpll", 1, 4),
> +	FACTOR(CLK_TOP_MMPLL_D6_D2, "mmpll_d6_d2", "mmpll", 1, 12),
> +	FACTOR(CLK_TOP_MMPLL_D8, "mmpll_d8", "mmpll", 1, 8),
> +	FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", "apll2", 1, 4),
> +	FACTOR(CLK_TOP_NET1PLL_D4, "net1pll_d4", "net1pll", 1, 4),
> +	FACTOR(CLK_TOP_NET1PLL_D5, "net1pll_d5", "net1pll", 1, 5),
> +	FACTOR(CLK_TOP_NET1PLL_D5_D2, "net1pll_d5_d2", "net1pll", 1, 10),
> +	FACTOR(CLK_TOP_NET1PLL_D5_D4, "net1pll_d5_d4", "net1pll", 1, 20),
> +	FACTOR(CLK_TOP_NET1PLL_D8, "net1pll_d8", "net1pll", 1, 8),
> +	FACTOR(CLK_TOP_NET1PLL_D8_D2, "net1pll_d8_d2", "net1pll", 1, 16),
> +	FACTOR(CLK_TOP_NET1PLL_D8_D4, "net1pll_d8_d4", "net1pll", 1, 32),
> +	FACTOR(CLK_TOP_NET1PLL_D8_D8, "net1pll_d8_d8", "net1pll", 1, 64),
> +	FACTOR(CLK_TOP_NET1PLL_D8_D16, "net1pll_d8_d16", "net1pll", 1, 128),
> +	FACTOR(CLK_TOP_NET2PLL_D2, "net2pll_d2", "net2pll", 1, 2),
> +	FACTOR(CLK_TOP_NET2PLL_D4, "net2pll_d4", "net2pll", 1, 4),
> +	FACTOR(CLK_TOP_NET2PLL_D4_D4, "net2pll_d4_d4", "net2pll", 1, 16),
> +	FACTOR(CLK_TOP_NET2PLL_D4_D8, "net2pll_d4_d8", "net2pll", 1, 32),
> +	FACTOR(CLK_TOP_NET2PLL_D6, "net2pll_d6", "net2pll", 1, 6),
> +	FACTOR(CLK_TOP_NET2PLL_D8, "net2pll_d8", "net2pll", 1, 8),
> +};
> +
> +static const char *const netsys_parents[] = { "top_xtal", "net2pll_d2",
> +					      "mmpll_d2" };

Fits in one line as well: please fix, here and everywhere else.

> +
> +static const char *const netsys_500m_parents[] = { "top_xtal", "net1pll_d5",
> +						   "net1pll_d5_d2" };
> +

..snip..

> diff --git a/drivers/clk/mediatek/clk-mt7988-xfipll.c b/drivers/clk/mediatek/clk-mt7988-xfipll.c
> new file mode 100644
> index 0000000000000..5862818085a8c
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt7988-xfipll.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Daniel Golle <daniel@makrotopia.org>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include "clk-mtk.h"
> +#include "clk-gate.h"
> +#include <dt-bindings/clock/mediatek,mt7988-clk.h>
> +
> +/* Register to control USXGMII XFI PLL analog */
> +#define XFI_PLL_ANA_GLB8		0x108
> +#define RG_XFI_PLL_ANA_SWWA		0x02283248
> +
> +static const struct mtk_gate_regs xfipll_cg_regs = {
> +	.set_ofs = 0x8,
> +	.clr_ofs = 0x8,
> +	.sta_ofs = 0x8,
> +};
> +
> +#define GATE_XFIPLL(_id, _name, _parent, _shift)                              \
> +	{                                                                     \
> +		.id = _id, .name = _name, .parent_name = _parent,             \
> +		.regs = &xfipll_cg_regs, .shift = _shift,                     \
> +		.ops = &mtk_clk_gate_ops_no_setclr_inv,                       \
> +	}
> +
> +static const struct mtk_fixed_factor xfipll_divs[] = {
> +	FACTOR(CLK_XFIPLL_PLL, "xfipll_pll", "top_xtal", 125, 32),
> +};
> +
> +static const struct mtk_gate xfipll_clks[] = {
> +	GATE_XFIPLL(CLK_XFIPLL_PLL_EN, "xfipll_pll_en", "xfipll_pll", 31),
> +};
> +
> +static const struct mtk_clk_desc xfipll_desc = {
> +	.clks = xfipll_clks,
> +	.num_clks = ARRAY_SIZE(xfipll_clks),
> +	.factor_clks = xfipll_divs,
> +	.num_factor_clks = ARRAY_SIZE(xfipll_divs),
> +};
> +
> +static int clk_mt7988_xfipll_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	void __iomem *base = of_iomap(node, 0);
> +
> +	if (!base)
> +		return -ENOMEM;
> +
> +	/* Apply software workaround for USXGMII PLL TCL issue */ù

This hurts my heart... :-P
but it's ok :-)

Cheers,
Angelo
