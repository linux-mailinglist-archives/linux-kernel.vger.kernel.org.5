Return-Path: <linux-kernel+bounces-131099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0811898317
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC961F29AC5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9EC5B208;
	Thu,  4 Apr 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wfMQVTtQ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4D60ED0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218905; cv=none; b=Q+kvoTi9aHEUD5/4xQbB2Y40YH4zZahCjV9W3F+ZhFblrOREksB/ag48el56T3Gqvj4arY6PoWxwArxatrwNnq+oOj2qYKLWKQi5g91hzVxg1UBtkbauq9jbPgDImuPa4CUdUdWmbhL1+uhnAKl/o1X5Z8xyKh00cAv3iXN36kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218905; c=relaxed/simple;
	bh=j9RezVx6nnypGN229oDS3Eh0bBZFvsKL4o/ko5wjG2U=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=KyZ2RYDRjgZbKEQPZtgvjpV8PYhpdOTCJxJ32XIuM2ZDRpIIFz4up8USqhMEV7SNrRzH1qkL3klzWRJwEgAfzM6cCb9VM7T1O6KZT7oC5HfRoETcyix+e8dg7s6Ks0+LsgEXqgB33qIdbK2kEJwDM1GIGn+xMgfnzgkn2GsuT0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wfMQVTtQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516c7716c1fso657673e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712218900; x=1712823700; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=CPwL4Hhi6eMHXODzuzMBAv39xZC80TOzZvNrDXAf1dg=;
        b=wfMQVTtQC9eyktjGDzvcd+66BuD6RKKIsRwvCwF6RF2IIW29jH+bqMu8GoXGUoCjqa
         qC8RTnKstaFiF2iHgvp9ooAgYJGct2HnqJKWu4W1UZAexzKTzGLolNPfjEOoW6YBoLhF
         anaOdY1E7hBPtSOmRy7P67+TRYYskz5x9TCvy4Ufove7kZqrzZkCMljpk5AltouO7Q/U
         tGYm1Zp38np9EbNj2m31oQCcA1CyX0l1bzhA+LxiVRGlmaY8MK/EvIhkFHirBD1Tj+5R
         4hMCFIfeINqXu832s7LxC0kN8sZ8Vtn14cEhH/xExPNT1SoXsyFN9PgsMCsMusuJPnFk
         Ohxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712218900; x=1712823700;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPwL4Hhi6eMHXODzuzMBAv39xZC80TOzZvNrDXAf1dg=;
        b=e3TFTNkQpbuhYGWkcw/qcPuyaBE9AZR7YMYcCNsi1F51r3ufmoefxxMZgxWr+BGIGx
         /eNfTTxQ9mV+4xT1lMcXQQqU3mLBDAGqLcXqwhBoUpufKF8xXkqUe4KYxrEeKzYNTxN1
         Z9l6iKppL6KHdyhTyta4qDe18dW7pfUXidv9Hai2Z84+gy9jbgRE+W4rF36swKkIgvri
         Cslg1z9EJyuiOjuGGZPQg0A5WQ/WMcj2nbuCjDV6VlCJ/6AgNuZNdM6VTAEjQBmORZVN
         DtiYUax/ALORSW+tltZDhCXSETb7Krx8KIPrGdr2SidjW4GkLtWYKZruOXdc/xC0qMoE
         eJAg==
X-Forwarded-Encrypted: i=1; AJvYcCV2fJY+Bt9aGPmDOvkcJ1sn1WeJgoDPcpt1p/r2ijjJJJ/v52XENXBSXZ7SsUCYnfL5wi9tbggqki5XRg0py6vN11vieEwRAET7RX/u
X-Gm-Message-State: AOJu0YzoyArHqKDwThbSRxw66iuDc4nf5T0B2SL5+VCW7h3SV2bezGBz
	xaTFeq3hN8TKVmf0vUgF6tPdh7EZI/rGrOLKI3gBP7/KGbh6p3RXGtYgroRguNk=
X-Google-Smtp-Source: AGHT+IFUEwVuNlanR1q98I8Zl8lkNJ31ayYDfyh+WNpgcvSLagazbm4WrPf/D1u5iJDSqbZMTQL5rA==
X-Received: by 2002:a19:a416:0:b0:516:d0c2:755 with SMTP id q22-20020a19a416000000b00516d0c20755mr81615lfc.63.1712218899806;
        Thu, 04 Apr 2024 01:21:39 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b7ad:8118:73f1:92e5])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c1c1000b004156e3c0149sm1848043wms.0.2024.04.04.01.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 01:21:39 -0700 (PDT)
References: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-0-99ecdfdc87fc@linaro.org>
 <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-2-99ecdfdc87fc@linaro.org>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jerome Brunet
 <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Jagan Teki
 <jagan@amarulasolutions.com>, Nicolas Belin <nbelin@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v12 2/7] clk: meson: add vclk driver
Date: Thu, 04 Apr 2024 10:13:19 +0200
In-reply-to: <20240403-amlogic-v6-4-upstream-dsi-ccf-vim3-v12-2-99ecdfdc87fc@linaro.org>
Message-ID: <1jmsq9pmgd.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Wed 03 Apr 2024 at 09:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The VCLK and VCLK_DIV clocks have supplementary bits.
>
> The VCLK gate has a "SOFT RESET" bit to toggle after the whole
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

The checkpatch warning is still there. Is it a choice or a mistake ?

Documentation says "GPL v2" exists for historic reason which seems to
hint "GPL" is preferred, and I suppose this is why checkpatch warns for
it.

>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/meson/Kconfig  |   4 ++
>  drivers/clk/meson/Makefile |   1 +
>  drivers/clk/meson/vclk.c   | 141 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/vclk.h   |  51 ++++++++++++++++
>  4 files changed, 197 insertions(+)
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 29ffd14d267b..8a9823789fa3 100644
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
> index 000000000000..45dc216941ea
> --- /dev/null
> +++ b/drivers/clk/meson/vclk.c
> @@ -0,0 +1,141 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Neil Armstrong <neil.armstrong@linaro.org>
> + */
> +
> +#include <linux/module.h>
> +#include "vclk.h"
> +
> +/* The VCLK gate has a supplementary reset bit to pulse after ungating */
> +
> +static inline struct meson_vclk_gate_data *
> +clk_get_meson_vclk_gate_data(struct clk_regmap *clk)
> +{
> +	return (struct meson_vclk_gate_data *)clk->data;
> +}
> +
> +static int meson_vclk_gate_enable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_vclk_gate_data *vclk = clk_get_meson_vclk_gate_data(clk);
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
> +static void meson_vclk_gate_disable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_vclk_gate_data *vclk = clk_get_meson_vclk_gate_data(clk);
> +
> +	meson_parm_write(clk->map, &vclk->enable, 0);
> +}
> +
> +static int meson_vclk_gate_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_vclk_gate_data *vclk = clk_get_meson_vclk_gate_data(clk);
> +
> +	return meson_parm_read(clk->map, &vclk->enable);
> +}
> +
> +const struct clk_ops meson_vclk_gate_ops = {
> +	.enable = meson_vclk_gate_enable,
> +	.disable = meson_vclk_gate_disable,
> +	.is_enabled = meson_vclk_gate_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(meson_vclk_gate_ops);
> +
> +/* The VCLK Divider has supplementary reset & enable bits */
> +
> +static inline struct meson_vclk_div_data *
> +clk_get_meson_vclk_div_data(struct clk_regmap *clk)
> +{
> +	return (struct meson_vclk_div_data *)clk->data;
> +}
> +
> +static unsigned long meson_vclk_div_recalc_rate(struct clk_hw *hw,
> +						unsigned long prate)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_vclk_div_data *vclk = clk_get_meson_vclk_div_data(clk);
> +
> +	return divider_recalc_rate(hw, prate, meson_parm_read(clk->map, &vclk->div),
> +				   vclk->table, vclk->flags, vclk->div.width);
> +}
> +
> +static int meson_vclk_div_determine_rate(struct clk_hw *hw,
> +					 struct clk_rate_request *req)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_vclk_div_data *vclk = clk_get_meson_vclk_div_data(clk);
> +
> +	return divider_determine_rate(hw, req, vclk->table, vclk->div.width,
> +				      vclk->flags);
> +}
> +
> +static int meson_vclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
> +				   unsigned long parent_rate)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_vclk_div_data *vclk = clk_get_meson_vclk_div_data(clk);
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
> +static int meson_vclk_div_enable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_vclk_div_data *vclk = clk_get_meson_vclk_div_data(clk);
> +
> +	/* Unreset the divider when ungating */
> +	meson_parm_write(clk->map, &vclk->reset, 0);
> +	meson_parm_write(clk->map, &vclk->enable, 1);
> +
> +	return 0;
> +}
> +
> +static void meson_vclk_div_disable(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_vclk_div_data *vclk = clk_get_meson_vclk_div_data(clk);
> +
> +	/* Reset the divider when gating */
> +	meson_parm_write(clk->map, &vclk->enable, 0);
> +	meson_parm_write(clk->map, &vclk->reset, 1);
> +}
> +
> +static int meson_vclk_div_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_vclk_div_data *vclk = clk_get_meson_vclk_div_data(clk);
> +
> +	return meson_parm_read(clk->map, &vclk->enable);
> +}
> +
> +const struct clk_ops meson_vclk_div_ops = {
> +	.recalc_rate = meson_vclk_div_recalc_rate,
> +	.determine_rate = meson_vclk_div_determine_rate,
> +	.set_rate = meson_vclk_div_set_rate,
> +	.enable = meson_vclk_div_enable,
> +	.disable = meson_vclk_div_disable,
> +	.is_enabled = meson_vclk_div_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(meson_vclk_div_ops);
> +
> +MODULE_DESCRIPTION("Amlogic vclk clock driver");
> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/meson/vclk.h b/drivers/clk/meson/vclk.h
> new file mode 100644
> index 000000000000..20b0b181db09
> --- /dev/null
> +++ b/drivers/clk/meson/vclk.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024 Neil Armstrong <neil.armstrong@linaro.org>
> + */
> +
> +#ifndef __VCLK_H
> +#define __VCLK_H
> +
> +#include "clk-regmap.h"
> +#include "parm.h"
> +
> +/**
> + * struct meson_vclk_gate_data - vclk_gate regmap backed specific data
> + *
> + * @enable:	vclk enable field
> + * @reset:	vclk reset field
> + * @flags:	hardware-specific flags
> + *
> + * Flags:
> + * Same as clk_gate except CLK_GATE_HIWORD_MASK which is ignored
> + */
> +struct meson_vclk_gate_data {
> +	struct parm enable;
> +	struct parm reset;
> +	u8 flags;
> +};
> +
> +extern const struct clk_ops meson_vclk_gate_ops;
> +
> +/**
> + * struct meson_vclk_div_data - vclk_div regmap back specific data
> + *
> + * @div:	divider field
> + * @enable:	vclk divider enable field
> + * @reset:	vclk divider reset field
> + * @table:	array of value/divider pairs, last entry should have div = 0
> + *
> + * Flags:
> + * Same as clk_divider except CLK_DIVIDER_HIWORD_MASK which is ignored
> + */
> +struct meson_vclk_div_data {
> +	struct parm div;
> +	struct parm enable;
> +	struct parm reset;
> +	const struct clk_div_table *table;
> +	u8 flags;
> +};
> +
> +extern const struct clk_ops meson_vclk_div_ops;
> +
> +#endif /* __VCLK_H */


-- 
Jerome

