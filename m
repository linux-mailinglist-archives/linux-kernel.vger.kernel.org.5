Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1267F76E2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345407AbjKXOvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjKXOvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:51:42 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E20F1720
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:51:47 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso2971749e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700837505; x=1701442305; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=YLH3RabXw2c69V6TB3Sm7NE+ZfpHa9RR2X+4P7QIY2A=;
        b=fmNrT6CjYe0/QPf6DOOK/pcKU5xR68Jt9cCNFf2G/JPnbLx2xnBlHbzjbF04UL+KFE
         dd9ALbbdzAJ/U+LGEyXY/p7cs6UPb/wSCiUjEwTUv5KA1ZD7Ed4J57zsfBO2OfaQKjXv
         58CLeBRUnTQG+jV5hVzXgmovuiso2YmGeCmfXgxTx+1Ft0nX529qHbRLyC5PhMPuhUYT
         TaVqJk8xuXrsBsgMyQiQOTxcu1ApOuxwHn0c31mvoFb9wDMn4BKDnIfgQj89qsEXMu9I
         2Vkth4nh8rQNpdv8SeVnbfzz09Ace2AMpkSzVX82cRy00CVC/A3k5ZDcZs+JOnHvlfU+
         v8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700837505; x=1701442305;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLH3RabXw2c69V6TB3Sm7NE+ZfpHa9RR2X+4P7QIY2A=;
        b=IlKW+8XU9oSzBWD2RKBc8xRuMI5vj9eE/Q9A/cxVfCLUpxq1dnOJAydwESTmMCGieq
         5U38SqdKAqNMchWl+xSe5DWHiT/cbkJQuDiyhYgaUenqEuLPyAKca6LaOAqPOpsIwEGk
         N06M20MXQeh44ryKZleurqh70q6DI9T7kMhAT3/+HtSo6MkW1sdy1BA2KRkUuIO4DsLY
         Rrlkz4nNRzjQcYne+ihh6e9nwv37rZUiMQZ1CSSDIYFfqnYH9CQieHNJq9y0NGUk/Tju
         hmAs3Tq1HRnWQ1/SEJseAFRGOdnQ9MMtHKmwFCzLtMIEq77PCUGHRAoL+RRz1hGHf3L/
         rLNA==
X-Gm-Message-State: AOJu0Yy3TKn/aUqf3qxbYeL9Wqh/fmthh1tn3pWSWHNev5sk/RyqKTEC
        ea1SdA1d1KSy9UHk5jfAjSpxkw==
X-Google-Smtp-Source: AGHT+IGzobmk4kXmgVRxM0ztfMfkVi2LmDBDF+KmM4imIGL1YRZKbMZP9UCqrrMDhFVbSXHkvt4CQQ==
X-Received: by 2002:a05:6512:70:b0:508:1470:6168 with SMTP id i16-20020a056512007000b0050814706168mr2071629lfo.57.1700837505349;
        Fri, 24 Nov 2023 06:51:45 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:1243:6910:fe68:2de5])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4d0b000000b00332cb23ccbdsm4421287wrt.81.2023.11.24.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 06:51:44 -0800 (PST)
References: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
 <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-7-95256ed139e6@linaro.org>
User-agent: mu4e 1.10.7; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 07/12] clk: meson: add vclk driver
Date:   Fri, 24 Nov 2023 15:41:07 +0100
In-reply-to: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-7-95256ed139e6@linaro.org>
Message-ID: <1j7cm7dx1b.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 24 Nov 2023 at 09:41, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The VCLK and VCLK_DIV clocks have supplementary bits.
>
> The VCLK has a "SOFT RESET" bit to toggle after the whole
> VCLK sub-tree rate has been set, this is implemented in
> the gate enable callback.
>
> The VCLK_DIV clocks as enable and reset bits used to disable
> and reset the divider, associated with CLK_SET_RATE_GATE it ensures
> the rate is set while the divider is disabled and in reset mode.
>
> The VCLK_DIV enable bit isn't implemented as a gate since it's part
> of the divider logic and vendor does this exact sequence to ensure
> the divider is correctly set.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/meson/Kconfig  |   5 ++
>  drivers/clk/meson/Makefile |   1 +
>  drivers/clk/meson/vclk.c   | 141 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/vclk.h   |  51 ++++++++++++++++
>  4 files changed, 198 insertions(+)
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 29ffd14d267b..59a40a49f8e1 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -30,6 +30,10 @@ config COMMON_CLK_MESON_VID_PLL_DIV
>  	tristate
>  	select COMMON_CLK_MESON_REGMAP
>  
> +config COMMON_CLK_MESON_VCLK
> +	tristate
> +	select COMMON_CLK_MESON_REGMAP
> +
>  config COMMON_CLK_MESON_CLKC_UTILS
>  	tristate
>  
> @@ -140,6 +144,7 @@ config COMMON_CLK_G12A
>  	select COMMON_CLK_MESON_EE_CLKC
>  	select COMMON_CLK_MESON_CPU_DYNDIV
>  	select COMMON_CLK_MESON_VID_PLL_DIV
> +	select COMMON_CLK_MESON_VCLK

This particular line belong in the next patch

>  	select MFD_SYSCON
>  	help
>  	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 9ee4b954c896..9ba43fe7a07a 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
>  obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
>  obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
>  obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
> +obj-$(CONFIG_COMMON_CLK_MESON_VCLK) += vclk.o
>  
>  # Amlogic Clock controllers
>  
> diff --git a/drivers/clk/meson/vclk.c b/drivers/clk/meson/vclk.c
> new file mode 100644
> index 000000000000..47f08a52b49f
> --- /dev/null
> +++ b/drivers/clk/meson/vclk.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
> + */
> +
> +#include <linux/module.h>
> +#include "vclk.h"
> +
> +/* The VCLK gate has a supplementary reset bit to pulse after ungating */
> +
> +static inline struct clk_regmap_vclk_data *
> +clk_get_regmap_vclk_data(struct clk_regmap *clk)
> +{
> +	return (struct clk_regmap_vclk_data *)clk->data;
> +}
> +
> +static int clk_regmap_vclk_enable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_vclk_data *vclk = clk_get_regmap_vclk_data(clk);
> +
> +	meson_parm_write(clk->map, &vclk->enable, 1);
> +
> +	/* Do a reset pulse */
> +	meson_parm_write(clk->map, &vclk->reset, 1);
> +	meson_parm_write(clk->map, &vclk->reset, 0);
> +
> +	return 0;
> +}
> +
> +static void clk_regmap_vclk_disable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_vclk_data *vclk = clk_get_regmap_vclk_data(clk);
> +
> +	meson_parm_write(clk->map, &vclk->enable, 0);
> +}
> +
> +static int clk_regmap_vclk_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_vclk_data *vclk = clk_get_regmap_vclk_data(clk);
> +
> +	return meson_parm_read(clk->map, &vclk->enable);
> +}
> +
> +const struct clk_ops clk_regmap_vclk_ops = {
> +	.enable = clk_regmap_vclk_enable,
> +	.disable = clk_regmap_vclk_disable,
> +	.is_enabled = clk_regmap_vclk_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(clk_regmap_vclk_ops);

s/clk_regmap_vclk/meson_vclk at least for what is exported, ideally most
all the code.

I get clk_regmap_ comes from code copied from clk_regmap.c.
The reason the this part is different (and not using parm) if that when
I converted amlogic to regmap, I hope we could make this generic,
possibly converging between aml and qcom (which was the only other
platform using regmap for clock at the time). This is why clk_regmap.c
is a bit different from the other driver.

For the aml specific drivers, best to look at the mpll or cpu-dyndiv one.

> +
> +/* The VCLK Divider has supplementary reset & enable bits */
> +
> +static inline struct clk_regmap_vclk_div_data *
> +clk_get_regmap_vclk_div_data(struct clk_regmap *clk)
> +{
> +	return (struct clk_regmap_vclk_div_data *)clk->data;
> +}
> +
> +static unsigned long clk_regmap_vclk_div_recalc_rate(struct clk_hw *hw,
> +						     unsigned long prate)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
> +
> +	return divider_recalc_rate(hw, prate, meson_parm_read(clk->map, &vclk->div),
> +				   vclk->table, vclk->flags, vclk->div.width);
> +}
> +
> +static int clk_regmap_vclk_div_determine_rate(struct clk_hw *hw,
> +					      struct clk_rate_request *req)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
> +
> +	return divider_determine_rate(hw, req, vclk->table, vclk->div.width,
> +				      vclk->flags);
> +}
> +
> +static int clk_regmap_vclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
> +					unsigned long parent_rate)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
> +	int ret;
> +
> +	ret = divider_get_val(rate, parent_rate, vclk->table, vclk->div.width,
> +			      vclk->flags);
> +	if (ret < 0)
> +		return ret;
> +
> +	meson_parm_write(clk->map, &vclk->div, ret);
> +
> +	return 0;
> +};
> +
> +static int clk_regmap_vclk_div_enable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
> +
> +	/* Unreset the divider when ungating */
> +	meson_parm_write(clk->map, &vclk->reset, 0);
> +	meson_parm_write(clk->map, &vclk->enable, 1);
> +
> +	return 0;
> +}
> +
> +static void clk_regmap_vclk_div_disable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
> +
> +	/* Reset the divider when gating */
> +	meson_parm_write(clk->map, &vclk->enable, 0);
> +	meson_parm_write(clk->map, &vclk->reset, 1);
> +}
> +
> +static int clk_regmap_vclk_div_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct clk_regmap_vclk_div_data *vclk = clk_get_regmap_vclk_div_data(clk);
> +
> +	return meson_parm_read(clk->map, &vclk->enable);
> +}
> +
> +const struct clk_ops clk_regmap_vclk_div_ops = {
> +	.recalc_rate = clk_regmap_vclk_div_recalc_rate,
> +	.determine_rate = clk_regmap_vclk_div_determine_rate,
> +	.set_rate = clk_regmap_vclk_div_set_rate,
> +	.enable = clk_regmap_vclk_div_enable,
> +	.disable = clk_regmap_vclk_div_disable,
> +	.is_enabled = clk_regmap_vclk_div_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(clk_regmap_vclk_div_ops);
> +
> +MODULE_DESCRIPTION("Amlogic vclk clock driver");
> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/meson/vclk.h b/drivers/clk/meson/vclk.h
> new file mode 100644
> index 000000000000..4f25d7ad2717
> --- /dev/null
> +++ b/drivers/clk/meson/vclk.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 Neil Armstrong <neil.armstrong@linaro.org>
> + */
> +
> +#ifndef __VCLK_H
> +#define __VCLK_H

This is too generic.
Please add the MESON prefix like the other clock driver please.

> +
> +#include "clk-regmap.h"
> +#include "parm.h"
> +
> +/**
> + * struct clk_regmap_vclk_data - vclk regmap backed specific data
> + *
> + * @enable:	vclk enable field
> + * @reset:	vclk reset field
> + * @flags:	hardware-specific flags
> + *
> + * Flags:
> + * Same as clk_gate except CLK_GATE_HIWORD_MASK which is ignored
> + */
> +struct clk_regmap_vclk_data {
> +	struct parm enable;
> +	struct parm reset;
> +	u8 flags;
> +};
> +
> +extern const struct clk_ops clk_regmap_vclk_ops;
> +
> +/**
> + * struct clk_regmap_vclk_div_data - vclk_div regmap back specific data
> + *
> + * @div:	divider field
> + * @enable:	vclk divider enable field
> + * @reset:	vclk divider reset field
> + * @table:	array of value/divider pairs, last entry should have div = 0
> + *
> + * Flags:
> + * Same as clk_divider except CLK_DIVIDER_HIWORD_MASK which is ignored
> + */
> +struct clk_regmap_vclk_div_data {
> +	struct parm div;
> +	struct parm enable;
> +	struct parm reset;
> +	const struct clk_div_table *table;
> +	u8 flags;
> +};
> +
> +extern const struct clk_ops clk_regmap_vclk_div_ops;
> +
> +#endif /* __VCLK_H */

