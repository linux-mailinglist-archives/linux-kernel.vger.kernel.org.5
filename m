Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7CC80C552
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjLKJ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjLKJ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:56:59 -0500
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 01:57:04 PST
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDED9B7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702288623;
        bh=6CjA6ctA+aoJ56ri2JQzkYVkT8sdbfqFhgd6RJqEU/E=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=3oYITDvQJx1zk9TEUDxJKSR7CtnfJS8tOHjRIqY+CVN5nPLVi3axYYancoJclYNg6
         af1PASxwqNDLIXKoe8aaTmNcSgjxGm2gsT88etR5bn9HeRhezw7hNBYYN7kkiY7Xxe
         KK5VCCNJCtLV/9P0LOxNP6wnWD1yEAhsgJQfE+L1H5F2JvlgdmEcmXIAQv1EtfYUgB
         N50An+R4NgSH/EocAuTVa3Rm/ooQRqZnHOIkeM3w8d09bxkbgnjeaDzaA2JhiLT0XF
         zWsKtS8jmd3caZJ96JPdAE29+X5yA6hjayookgBLZjU6vEi+nGOlFxWupvdExVzb9h
         e4mwvDLSh3L/A==
Received: from [IPV6:fd00::2a:39ce] (cola.collaboradmins.com [IPv6:2a01:4f8:1c1c:5717::1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5C303378140F;
        Mon, 11 Dec 2023 09:57:01 +0000 (UTC)
Message-ID: <060c8068-0f9b-40b4-89ed-3b968e4b0071@collabora.com>
Date:   Mon, 11 Dec 2023 10:57:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] clk: mediatek: add drivers for MT7988 SoC
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
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
References: <097e82b0d66570763d64be1715517d8b032fcf95.1702158423.git.daniel@makrotopia.org>
 <879b5bbcb165aa3f059a41218142b27e5f64597f.1702158423.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <879b5bbcb165aa3f059a41218142b27e5f64597f.1702158423.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/12/23 22:56, Daniel Golle ha scritto:
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
> v4:
>   * make use of existing GATE_MTK_FLAGS macro
>   * reformat to max. 100 columns
>   * cosmetics
> 
> v3: use git --from ...
> v2: no changes
> 
> 
>   drivers/clk/mediatek/Kconfig               |   9 +
>   drivers/clk/mediatek/Makefile              |   5 +
>   drivers/clk/mediatek/clk-mt7988-apmixed.c  | 102 +++++++
>   drivers/clk/mediatek/clk-mt7988-eth.c      | 133 +++++++++
>   drivers/clk/mediatek/clk-mt7988-infracfg.c | 274 +++++++++++++++++
>   drivers/clk/mediatek/clk-mt7988-topckgen.c | 325 +++++++++++++++++++++
>   drivers/clk/mediatek/clk-mt7988-xfipll.c   |  78 +++++
>   7 files changed, 926 insertions(+)
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
> index 0000000000000..02eb6354b01a8
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt7988-apmixed.c
> @@ -0,0 +1,102 @@
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
> +#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _rst_bar_mask, _pcwbits, _pd_reg,      \
> +	    _pd_shift, _tuner_reg, _tuner_en_reg, _tuner_en_bit, _pcw_reg, _pcw_shift,           \
> +	    _pcw_chg_reg)                                                                        \
> +	{                                                                                        \
> +		.id = _id, .name = _name, .reg = _reg, .pwr_reg = _pwr_reg, .en_mask = _en_mask, \
> +		.flags = _flags, .rst_bar_mask = BIT(_rst_bar_mask), .fmax = MT7988_PLL_FMAX,    \
> +		.pcwbits = _pcwbits, .pd_reg = _pd_reg, .pd_shift = _pd_shift,                   \
> +		.tuner_reg = _tuner_reg, .tuner_en_reg = _tuner_en_reg,                          \
> +		.tuner_en_bit = _tuner_en_bit, .pcw_reg = _pcw_reg, .pcw_shift = _pcw_shift,     \
> +		.pcw_chg_reg = _pcw_chg_reg, .pcw_chg_shift = MT7988_PCW_CHG_SHIFT,              \
> +		.parent_name = "clkxtal",                                                        \
> +	}

I think that there was a bit of misunderstanding here: I said 100cols, and that's
fine, but I wanted you to do that with everything but the macros, following what
was done in all the other MediaTek clock drivers.

Can you please change the macros again?

Also, there's some discrepancy in the usage of tabulations vs spaces, please fix.

#define PLL(....)*TAB*\

....

	{										\
		.id = _id,							\
		.name = _name,							\
		.reg = _reg,							\
		.pwr_reg = _pwr_reg,						\
		.en_mask = _en_mask,						\
		...etc etc etc...						\
}

Thanks,
Angelo
