Return-Path: <linux-kernel+bounces-104221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C1E87CAE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77ABAB210A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2438917C61;
	Fri, 15 Mar 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xCkVcLXV"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B417C6C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496429; cv=none; b=WBR1fhRgXmdXn0kcy/GfWTSbQ7vYkz0Kkbj9ygQi+b1TYilPqtbdYIHBxI95Xi4zgQhZbX77VBQwL1vSDOYFq2oMv45VZH+R3VWAdlvSP/7g4PXcs3yxkQz16rJLy1iM9QPVY+iMsHpX6GWsx421xJiNBTsztSlj1avl1mbj/fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496429; c=relaxed/simple;
	bh=4oRm1NK77+XXWYh95UQNjV19d6KgGloBL6ZXAb6QMBI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Xj4RRQU0ei73zPqsed0Z3KiQb/vdNJvk1ZHxxKeh8PDHHG37vODf51BSkMQwl/Ed7sXSxOfSaCLfjFVjJjpe8qffZF6qenyB6UBAeqZKxgUZHZesW4aDi4+9lgFGxF42PawwHBB7QWZimhdW1lAy/8Oy26F15cOGYXWJ1Hu2e5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xCkVcLXV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-414008713beso2677905e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710496424; x=1711101224; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=UasxFm+3vvEmRMycex5KNpohnD/ptKMaKoRL9njfE20=;
        b=xCkVcLXVaLKlKoH/e3AfJlycaJ2iOr288f1Ok3C3GHcafZFOZsS4P4AOWOP3B9r0ka
         ss78vgjPKy5Ssbs+ZXHEEsbhh674nioLtn5UTWYbTcU7ymCnix3Rol3fHwjPXxC/eOeO
         LNjSz1x5COpMS4HX2nD3m1xWCGWNnYT9rz7eZq3Khy/cmwr+ggfS8R3N7Ooy2CbVrbY7
         LvTtKDrnuqevBCoBV8rA6PHiko7z2jdVzd+RLD4h25QgeEnfvFwCEQjmlfk/2Dj58KET
         +xYtefwRNIcsIrP7DvNhEEUaxBNvXl9tX3ZEx4FVPTSx6h4CcrbcmUWuSLQK+GWPC4e5
         Ow/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710496424; x=1711101224;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UasxFm+3vvEmRMycex5KNpohnD/ptKMaKoRL9njfE20=;
        b=PQm9RnhoEP/k9+JssGq03AABvWrsTK9d6uf8HCEbFK0MvORFr+SDrOBqARrNReLhlz
         3+HeEyhRmppDl2Txgy8xa5krqZFfRCovW0Gzbo7bjWZSCnEUMypFGWbjKJ7XyB/G+uOO
         mk0K+h6dce9QI4sqfRgYUZeDSZ4W6dlJkFhTo2hs1eeX+JgdkETcw8SxAUJMpiLY+1SY
         uzsTBHNiosI5vKoIUUOrIAClVyqcT8nW5WAWfs0bjP0kkq8IMVCNcUTaUG8/tUbtQCNf
         ADxD5CnW5AjWgoPcDMbJZbHkARF9cPavZ9AAAWkgL5No7BCoZxZQaqWyDS5eH/9rdTp6
         11cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTz85X+eYYrL5TE01vVqKzUvW9ArDPNOulZbJNSubY+28qYMr0ZxKd3cn2wD7IPVqlCy3a6VQyVBS+ztbFZLy34S7s6rnQO+B3bBAP
X-Gm-Message-State: AOJu0YyCtIW3pQWg9wrORQfkDjUfMnncp+GmIQY39y4l2vcBPszyvy7X
	Otkao6BT6QGOCIm4inSkqaxXNVHsUEuBbX6XirI7C+pCx8lS760z118XdYlVjDU=
X-Google-Smtp-Source: AGHT+IG3LysFfMtD0839Stvh0mTDvk5r1iXJKMRwhhxo34IzmHDBmpNqkLATLKYny3nRDYcog6CIHg==
X-Received: by 2002:a05:600c:1994:b0:412:efc8:299b with SMTP id t20-20020a05600c199400b00412efc8299bmr3309777wmq.39.1710496424312;
        Fri, 15 Mar 2024 02:53:44 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:8151:4d0a:14d8:1124])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d4aca000000b0033e03d37685sm2786557wrs.55.2024.03.15.02.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:53:43 -0700 (PDT)
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-5-jan.dakinevich@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
 <jbrunet@baylibre.com>, Michael  Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob  Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kevin
 Hilman <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
 kernel@salutedevices.com
Subject: Re: [PATCH 04/25] clk: meson: a1: add the audio clock controller
 driver
Date: Fri, 15 Mar 2024 10:20:02 +0100
In-reply-to: <20240314232201.2102178-5-jan.dakinevich@salutedevices.com>
Message-ID: <1j4jd7izx4.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Fri 15 Mar 2024 at 02:21, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:

> This controller provides clocks and reset functionality for audio
> peripherals on Amlogic A1 SoC family.
>
> The driver is almost identical to 'axg-audio', however it would be better
> to keep it separate due to following reasons:
>
>  - significant amount of bits has another definition. I will bring there
>    a mess of new defines with A1_ suffixes.
>
>  - registers of this controller are located in two separate regions. It
>    will give a lot of complications for 'axg-audio' to support this.
>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  drivers/clk/meson/Kconfig    |  13 +
>  drivers/clk/meson/Makefile   |   1 +
>  drivers/clk/meson/a1-audio.c | 556 +++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/a1-audio.h |  58 ++++
>  4 files changed, 628 insertions(+)
>  create mode 100644 drivers/clk/meson/a1-audio.c
>  create mode 100644 drivers/clk/meson/a1-audio.h
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index d6a2fa5f7e88..80c4a18c83d2 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -133,6 +133,19 @@ config COMMON_CLK_A1_PERIPHERALS
>  	  device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>  	  controller to work.
>  
> +config COMMON_CLK_A1_AUDIO
> +	tristate "Amlogic A1 SoC Audio clock controller support"
> +	depends on ARM64
> +	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_CLKC_UTILS
> +	select COMMON_CLK_MESON_PHASE
> +	select COMMON_CLK_MESON_SCLK_DIV
> +	select COMMON_CLK_MESON_AUDIO_RSTC
> +	help
> +	  Support for the Audio clock controller on Amlogic A113L based
> +	  device, A1 SoC Family. Say Y if you want A1 Audio clock controller
> +	  to work.
> +
>  config COMMON_CLK_G12A
>  	tristate "G12 and SM1 SoC clock controllers support"
>  	depends on ARM64
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 88d94921a4dc..4968fc7ad555 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>  obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
> +obj-$(CONFIG_COMMON_CLK_A1_AUDIO) += a1-audio.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
> diff --git a/drivers/clk/meson/a1-audio.c b/drivers/clk/meson/a1-audio.c
> new file mode 100644
> index 000000000000..6039116c93ba
> --- /dev/null
> +++ b/drivers/clk/meson/a1-audio.c
> @@ -0,0 +1,556 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> + *
> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/init.h>
> +#include <linux/of_device.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +
> +#include "meson-clkc-utils.h"
> +#include "meson-audio-rstc.h"
> +#include "clk-regmap.h"
> +#include "clk-phase.h"
> +#include "sclk-div.h"
> +#include "a1-audio.h"
> +
> +#define AUDIO_PDATA(_name) \
> +	((const struct clk_parent_data[]) { { .hw = &(_name).hw } })

Not a fan - yet another level of macro.

> +
> +#define AUDIO_MUX(_name, _reg, _mask, _shift, _pdata)			\
> +static struct clk_regmap _name = {					\
> +	.map = AUDIO_REG_MAP(_reg),					\
> +	.data = &(struct clk_regmap_mux_data){				\
> +		.offset = AUDIO_REG_OFFSET(_reg),			\
> +		.mask = (_mask),					\
> +		.shift = (_shift),					\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = #_name,						\
> +		.ops = &clk_regmap_mux_ops,				\
> +		.parent_data = (_pdata),				\
> +		.num_parents = ARRAY_SIZE(_pdata),			\
> +		.flags = CLK_SET_RATE_PARENT,				\
> +	},								\
> +}
> +
> +#define AUDIO_DIV(_name, _reg, _shift, _width, _pdata)			\
> +static struct clk_regmap _name = {					\
> +	.map = AUDIO_REG_MAP(_reg),					\
> +	.data = &(struct clk_regmap_div_data){				\
> +		.offset = AUDIO_REG_OFFSET(_reg),			\
> +		.shift = (_shift),					\
> +		.width = (_width),					\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = #_name,						\
> +		.ops = &clk_regmap_divider_ops,				\
> +		.parent_data = (_pdata),				\
> +		.num_parents = 1,					\
> +		.flags = CLK_SET_RATE_PARENT,				\
> +	},								\
> +}
> +
> +#define AUDIO_GATE(_name, _reg, _bit, _pdata)				\
> +static struct clk_regmap _name = {					\
> +	.map = AUDIO_REG_MAP(_reg),					\
> +	.data = &(struct clk_regmap_gate_data){				\
> +		.offset = AUDIO_REG_OFFSET(_reg),			\
> +		.bit_idx = (_bit),					\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = #_name,						\
> +		.ops = &clk_regmap_gate_ops,				\
> +		.parent_data = (_pdata),				\
> +		.num_parents = 1,					\
> +		.flags = CLK_SET_RATE_PARENT,				\
> +	},								\
> +}
> +
> +#define AUDIO_SCLK_DIV(_name, _reg, _div_shift, _div_width,		\
> +	_hi_shift, _hi_width, _pdata, _set_rate_parent)			\
> +static struct clk_regmap _name = {					\
> +	.map = AUDIO_REG_MAP(_reg),					\
> +	.data = &(struct meson_sclk_div_data) {				\
> +		.div = {						\
> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
> +			.shift = (_div_shift),				\
> +			.width = (_div_width),				\
> +		},							\
> +		.hi = {							\
> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
> +			.shift = (_hi_shift),				\
> +			.width = (_hi_width),				\
> +		},							\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = #_name,						\
> +		.ops = &meson_sclk_div_ops,				\
> +		.parent_data = (_pdata),				\
> +		.num_parents = 1,					\
> +		.flags = (_set_rate_parent) ? CLK_SET_RATE_PARENT : 0,	\

Does not help readeability. Just pass the flag as axg-audio does.

> +	},								\
> +}
> +
> +#define AUDIO_TRIPHASE(_name, _reg, _width, _shift0, _shift1, _shift2,	\
> +	_pdata)								\
> +static struct clk_regmap _name = {					\
> +	.map = AUDIO_REG_MAP(_reg),					\
> +	.data = &(struct meson_clk_triphase_data) {			\
> +		.ph0 = {						\
> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
> +			.shift = (_shift0),				\
> +			.width = (_width),				\
> +		},							\
> +		.ph1 = {						\
> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
> +			.shift = (_shift1),				\
> +			.width = (_width),				\
> +		},							\
> +		.ph2 = {						\
> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
> +			.shift = (_shift2),				\
> +			.width = (_width),				\
> +		},							\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = #_name,						\
> +		.ops = &meson_clk_triphase_ops,				\
> +		.parent_data = (_pdata),				\
> +		.num_parents = 1,					\
> +		.flags = CLK_SET_RATE_PARENT | CLK_DUTY_CYCLE_PARENT,	\
> +	},								\
> +}
> +
> +#define AUDIO_SCLK_WS(_name, _reg, _width, _shift_ph, _shift_ws,	\
> +	_pdata)								\
> +static struct clk_regmap _name = {					\
> +	.map = AUDIO_REG_MAP(_reg),					\
> +	.data = &(struct meson_sclk_ws_inv_data) {			\
> +		.ph = {							\
> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
> +			.shift = (_shift_ph),				\
> +			.width = (_width),				\
> +		},							\
> +		.ws = {							\
> +			.reg_off = AUDIO_REG_OFFSET(_reg),		\
> +			.shift = (_shift_ws),				\
> +			.width = (_width),				\
> +		},							\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = #_name,						\
> +		.ops = &meson_sclk_ws_inv_ops,				\
> +		.parent_data = (_pdata),				\
> +		.num_parents = 1,					\
> +		.flags = CLK_SET_RATE_PARENT | CLK_DUTY_CYCLE_PARENT,	\
> +	},								\
> +}

All the above does essentially the same things as the macro of
axg-audio, to some minor differences. Yet it is another set to maintain.

I'd much prefer if you put the axg-audio macro in a header a re-used
those. There would a single set to maintain. You may then specialize the
 included in the driver C file, to avoid redundant parameters

Rework axg-audio to use clk_parent_data if you must, but not in the same
series please.

> +
> +static const struct clk_parent_data a1_pclk_pdata[] = {
> +	{ .fw_name = "pclk", },
> +};
> +
> +AUDIO_GATE(audio_ddr_arb, AUDIO_CLK_GATE_EN0, 0, a1_pclk_pdata);
> +AUDIO_GATE(audio_tdmin_a, AUDIO_CLK_GATE_EN0, 1, a1_pclk_pdata);
> +AUDIO_GATE(audio_tdmin_b, AUDIO_CLK_GATE_EN0, 2, a1_pclk_pdata);
> +AUDIO_GATE(audio_tdmin_lb, AUDIO_CLK_GATE_EN0, 3, a1_pclk_pdata);
> +AUDIO_GATE(audio_loopback, AUDIO_CLK_GATE_EN0, 4, a1_pclk_pdata);
> +AUDIO_GATE(audio_tdmout_a, AUDIO_CLK_GATE_EN0, 5, a1_pclk_pdata);
> +AUDIO_GATE(audio_tdmout_b, AUDIO_CLK_GATE_EN0, 6, a1_pclk_pdata);
> +AUDIO_GATE(audio_frddr_a, AUDIO_CLK_GATE_EN0, 7, a1_pclk_pdata);
> +AUDIO_GATE(audio_frddr_b, AUDIO_CLK_GATE_EN0, 8, a1_pclk_pdata);
> +AUDIO_GATE(audio_toddr_a, AUDIO_CLK_GATE_EN0, 9, a1_pclk_pdata);
> +AUDIO_GATE(audio_toddr_b, AUDIO_CLK_GATE_EN0, 10, a1_pclk_pdata);
> +AUDIO_GATE(audio_spdifin, AUDIO_CLK_GATE_EN0, 11, a1_pclk_pdata);
> +AUDIO_GATE(audio_resample, AUDIO_CLK_GATE_EN0, 12, a1_pclk_pdata);
> +AUDIO_GATE(audio_eqdrc, AUDIO_CLK_GATE_EN0, 13, a1_pclk_pdata);
> +AUDIO_GATE(audio_audiolocker, AUDIO_CLK_GATE_EN0, 14, a1_pclk_pdata);
              This is what I mean by redundant parameter ^

> +
> +AUDIO_GATE(audio2_ddr_arb, AUDIO2_CLK_GATE_EN0, 0, a1_pclk_pdata);
> +AUDIO_GATE(audio2_pdm, AUDIO2_CLK_GATE_EN0, 1, a1_pclk_pdata);
> +AUDIO_GATE(audio2_tdmin_vad, AUDIO2_CLK_GATE_EN0, 2, a1_pclk_pdata);
> +AUDIO_GATE(audio2_toddr_vad, AUDIO2_CLK_GATE_EN0, 3, a1_pclk_pdata);
> +AUDIO_GATE(audio2_vad, AUDIO2_CLK_GATE_EN0, 4, a1_pclk_pdata);
> +AUDIO_GATE(audio2_audiotop, AUDIO2_CLK_GATE_EN0, 7, a1_pclk_pdata);
> +
> +static const struct clk_parent_data a1_mst_pdata[] = {
> +	{ .fw_name = "dds_in" },
> +	{ .fw_name = "fclk_div2" },
> +	{ .fw_name = "fclk_div3" },
> +	{ .fw_name = "hifi_pll" },
> +	{ .fw_name = "xtal" },
> +};
> +
> +#define AUDIO_MST_MCLK(_name, _reg)					\
> +	AUDIO_MUX(_name##_mux, (_reg), 0x7, 24, a1_mst_pdata);		\
> +	AUDIO_DIV(_name##_div, (_reg), 0, 16,				\
> +		AUDIO_PDATA(_name##_mux));				\
> +	AUDIO_GATE(_name, (_reg), 31, AUDIO_PDATA(_name##_div))
> +
> +AUDIO_MST_MCLK(audio_mst_a_mclk, AUDIO_MCLK_A_CTRL);
> +AUDIO_MST_MCLK(audio_mst_b_mclk, AUDIO_MCLK_B_CTRL);
> +AUDIO_MST_MCLK(audio_mst_c_mclk, AUDIO_MCLK_C_CTRL);
> +AUDIO_MST_MCLK(audio_mst_d_mclk, AUDIO_MCLK_D_CTRL);
> +AUDIO_MST_MCLK(audio_spdifin_clk, AUDIO_CLK_SPDIFIN_CTRL);
> +AUDIO_MST_MCLK(audio_eqdrc_clk, AUDIO_CLK_EQDRC_CTRL);
> +
> +AUDIO_MUX(audio_resample_clk_mux, AUDIO_CLK_RESAMPLE_CTRL, 0xf, 24,
> +	a1_mst_pdata);
> +AUDIO_DIV(audio_resample_clk_div, AUDIO_CLK_RESAMPLE_CTRL, 0, 8,
> +	AUDIO_PDATA(audio_resample_clk_mux));
> +AUDIO_GATE(audio_resample_clk, AUDIO_CLK_RESAMPLE_CTRL, 31,
> +	AUDIO_PDATA(audio_resample_clk_div));
> +
> +AUDIO_MUX(audio_locker_in_clk_mux, AUDIO_CLK_LOCKER_CTRL, 0xf, 8,
> +	a1_mst_pdata);
> +AUDIO_DIV(audio_locker_in_clk_div, AUDIO_CLK_LOCKER_CTRL, 0, 8,
> +	AUDIO_PDATA(audio_locker_in_clk_mux));
> +AUDIO_GATE(audio_locker_in_clk, AUDIO_CLK_LOCKER_CTRL, 15,
> +	AUDIO_PDATA(audio_locker_in_clk_div));
> +
> +AUDIO_MUX(audio_locker_out_clk_mux, AUDIO_CLK_LOCKER_CTRL, 0xf, 24,
> +	a1_mst_pdata);
> +AUDIO_DIV(audio_locker_out_clk_div, AUDIO_CLK_LOCKER_CTRL, 16, 8,
> +	AUDIO_PDATA(audio_locker_out_clk_mux));
> +AUDIO_GATE(audio_locker_out_clk, AUDIO_CLK_LOCKER_CTRL, 31,
> +	AUDIO_PDATA(audio_locker_out_clk_div));
> +
> +AUDIO_MST_MCLK(audio2_vad_mclk, AUDIO2_MCLK_VAD_CTRL);
> +AUDIO_MST_MCLK(audio2_vad_clk, AUDIO2_CLK_VAD_CTRL);
> +AUDIO_MST_MCLK(audio2_pdm_dclk, AUDIO2_CLK_PDMIN_CTRL0);
> +AUDIO_MST_MCLK(audio2_pdm_sysclk, AUDIO2_CLK_PDMIN_CTRL1);
> +
> +#define AUDIO_MST_SCLK(_name, _reg0, _reg1, _pdata)			\
> +	AUDIO_GATE(_name##_pre_en, (_reg0), 31, (_pdata));		\
> +	AUDIO_SCLK_DIV(_name##_div, (_reg0), 20, 10, 0, 0,		\
> +		AUDIO_PDATA(_name##_pre_en), true);			\
> +	AUDIO_GATE(_name##_post_en, (_reg0), 30,			\
> +		AUDIO_PDATA(_name##_div));				\
> +	AUDIO_TRIPHASE(_name, (_reg1), 1, 0, 2, 4,			\
> +		AUDIO_PDATA(_name##_post_en))
> +

Again, I'm not a fan of this many levels of macro. I can live with it
but certainly don't want the burden of reviewing and maintaining for
clock driver. AXG / G12 and A1 are obviously closely related, so make it common.

> +#define AUDIO_MST_LRCLK(_name, _reg0, _reg1, _pdata)			\
> +	AUDIO_SCLK_DIV(_name##_div, (_reg0), 0, 10, 10, 10,		\
> +		(_pdata), false);					\
> +	AUDIO_TRIPHASE(_name, (_reg1), 1, 1, 3, 5,			\
> +		AUDIO_PDATA(_name##_div))
> +
> +AUDIO_MST_SCLK(audio_mst_a_sclk, AUDIO_MST_A_SCLK_CTRL0, AUDIO_MST_A_SCLK_CTRL1,
> +	AUDIO_PDATA(audio_mst_a_mclk));
> +AUDIO_MST_SCLK(audio_mst_b_sclk, AUDIO_MST_B_SCLK_CTRL0, AUDIO_MST_B_SCLK_CTRL1,
> +	AUDIO_PDATA(audio_mst_b_mclk));
> +AUDIO_MST_SCLK(audio_mst_c_sclk, AUDIO_MST_C_SCLK_CTRL0, AUDIO_MST_C_SCLK_CTRL1,
> +	AUDIO_PDATA(audio_mst_c_mclk));
> +AUDIO_MST_SCLK(audio_mst_d_sclk, AUDIO_MST_D_SCLK_CTRL0, AUDIO_MST_D_SCLK_CTRL1,
> +	AUDIO_PDATA(audio_mst_d_mclk));
> +
> +AUDIO_MST_LRCLK(audio_mst_a_lrclk, AUDIO_MST_A_SCLK_CTRL0, AUDIO_MST_A_SCLK_CTRL1,
> +	AUDIO_PDATA(audio_mst_a_sclk_post_en));
> +AUDIO_MST_LRCLK(audio_mst_b_lrclk, AUDIO_MST_B_SCLK_CTRL0, AUDIO_MST_B_SCLK_CTRL1,
> +	AUDIO_PDATA(audio_mst_b_sclk_post_en));
> +AUDIO_MST_LRCLK(audio_mst_c_lrclk, AUDIO_MST_C_SCLK_CTRL0, AUDIO_MST_C_SCLK_CTRL1,
> +	AUDIO_PDATA(audio_mst_c_sclk_post_en));
> +AUDIO_MST_LRCLK(audio_mst_d_lrclk, AUDIO_MST_D_SCLK_CTRL0, AUDIO_MST_D_SCLK_CTRL1,
> +	AUDIO_PDATA(audio_mst_d_sclk_post_en));
> +
> +static const struct clk_parent_data a1_mst_sclk_pdata[] = {
> +	{ .hw = &audio_mst_a_sclk.hw },
> +	{ .hw = &audio_mst_b_sclk.hw },
> +	{ .hw = &audio_mst_c_sclk.hw },
> +	{ .hw = &audio_mst_d_sclk.hw },
> +	{ .fw_name = "slv_sclk0" },
> +	{ .fw_name = "slv_sclk1" },
> +	{ .fw_name = "slv_sclk2" },
> +	{ .fw_name = "slv_sclk3" },
> +	{ .fw_name = "slv_sclk4" },
> +	{ .fw_name = "slv_sclk5" },
> +	{ .fw_name = "slv_sclk6" },
> +	{ .fw_name = "slv_sclk7" },
> +	{ .fw_name = "slv_sclk8" },
> +	{ .fw_name = "slv_sclk9" },
> +};
> +
> +static const struct clk_parent_data a1_mst_lrclk_pdata[] = {
> +	{ .hw = &audio_mst_a_lrclk.hw },
> +	{ .hw = &audio_mst_b_lrclk.hw },
> +	{ .hw = &audio_mst_c_lrclk.hw },
> +	{ .hw = &audio_mst_d_lrclk.hw },
> +	{ .fw_name = "slv_lrclk0" },
> +	{ .fw_name = "slv_lrclk1" },
> +	{ .fw_name = "slv_lrclk2" },
> +	{ .fw_name = "slv_lrclk3" },
> +	{ .fw_name = "slv_lrclk4" },
> +	{ .fw_name = "slv_lrclk5" },
> +	{ .fw_name = "slv_lrclk6" },
> +	{ .fw_name = "slv_lrclk7" },
> +	{ .fw_name = "slv_lrclk8" },
> +	{ .fw_name = "slv_lrclk9" },
> +};
> +
> +#define AUDIO_TDM_SCLK(_name, _reg)					\
> +	AUDIO_MUX(_name##_mux, (_reg), 0xf, 24, a1_mst_sclk_pdata);	\
> +	AUDIO_GATE(_name##_pre_en, (_reg), 31,				\
> +		AUDIO_PDATA(_name##_mux));				\
> +	AUDIO_GATE(_name##_post_en, (_reg), 30,				\
> +		AUDIO_PDATA(_name##_pre_en));				\
> +	AUDIO_SCLK_WS(_name, (_reg), 1, 29, 28,				\
> +		AUDIO_PDATA(_name##_post_en))
> +
> +#define AUDIO_TDM_LRCLK(_name, _reg)					\
> +	AUDIO_MUX(_name, (_reg), 0xf, 20, a1_mst_lrclk_pdata)
> +
> +AUDIO_TDM_SCLK(audio_tdmin_a_sclk, AUDIO_CLK_TDMIN_A_CTRL);
> +AUDIO_TDM_SCLK(audio_tdmin_b_sclk, AUDIO_CLK_TDMIN_B_CTRL);
> +AUDIO_TDM_SCLK(audio_tdmin_lb_sclk, AUDIO_CLK_TDMIN_LB_CTRL);
> +AUDIO_TDM_SCLK(audio_tdmout_a_sclk, AUDIO_CLK_TDMOUT_A_CTRL);
> +AUDIO_TDM_SCLK(audio_tdmout_b_sclk, AUDIO_CLK_TDMOUT_B_CTRL);
> +
> +AUDIO_TDM_LRCLK(audio_tdmin_a_lrclk, AUDIO_CLK_TDMIN_A_CTRL);
> +AUDIO_TDM_LRCLK(audio_tdmin_b_lrclk, AUDIO_CLK_TDMIN_B_CTRL);
> +AUDIO_TDM_LRCLK(audio_tdmin_lb_lrclk, AUDIO_CLK_TDMIN_LB_CTRL);
> +AUDIO_TDM_LRCLK(audio_tdmout_a_lrclk, AUDIO_CLK_TDMOUT_A_CTRL);
> +AUDIO_TDM_LRCLK(audio_tdmout_b_lrclk, AUDIO_CLK_TDMOUT_B_CTRL);
> +
> +static struct clk_hw *a1_audio_hw_clks[] = {
> +	[AUD_CLKID_DDR_ARB]		= &audio_ddr_arb.hw,
> +	[AUD_CLKID_TDMIN_A]		= &audio_tdmin_a.hw,
> +	[AUD_CLKID_TDMIN_B]		= &audio_tdmin_b.hw,
> +	[AUD_CLKID_TDMIN_LB]		= &audio_tdmin_lb.hw,
> +	[AUD_CLKID_LOOPBACK]		= &audio_loopback.hw,
> +	[AUD_CLKID_TDMOUT_A]		= &audio_tdmout_a.hw,
> +	[AUD_CLKID_TDMOUT_B]		= &audio_tdmout_b.hw,
> +	[AUD_CLKID_FRDDR_A]		= &audio_frddr_a.hw,
> +	[AUD_CLKID_FRDDR_B]		= &audio_frddr_b.hw,
> +	[AUD_CLKID_TODDR_A]		= &audio_toddr_a.hw,
> +	[AUD_CLKID_TODDR_B]		= &audio_toddr_b.hw,
> +	[AUD_CLKID_SPDIFIN]		= &audio_spdifin.hw,
> +	[AUD_CLKID_RESAMPLE]		= &audio_resample.hw,
> +	[AUD_CLKID_EQDRC]		= &audio_eqdrc.hw,
> +	[AUD_CLKID_LOCKER]		= &audio_audiolocker.hw,
> +	[AUD_CLKID_MST_A_MCLK_SEL]	= &audio_mst_a_mclk_mux.hw,
> +	[AUD_CLKID_MST_A_MCLK_DIV]	= &audio_mst_a_mclk_div.hw,
> +	[AUD_CLKID_MST_A_MCLK]		= &audio_mst_a_mclk.hw,
> +	[AUD_CLKID_MST_B_MCLK_SEL]	= &audio_mst_b_mclk_mux.hw,
> +	[AUD_CLKID_MST_B_MCLK_DIV]	= &audio_mst_b_mclk_div.hw,
> +	[AUD_CLKID_MST_B_MCLK]		= &audio_mst_b_mclk.hw,
> +	[AUD_CLKID_MST_C_MCLK_SEL]	= &audio_mst_c_mclk_mux.hw,
> +	[AUD_CLKID_MST_C_MCLK_DIV]	= &audio_mst_c_mclk_div.hw,
> +	[AUD_CLKID_MST_C_MCLK]		= &audio_mst_c_mclk.hw,
> +	[AUD_CLKID_MST_D_MCLK_SEL]	= &audio_mst_d_mclk_mux.hw,
> +	[AUD_CLKID_MST_D_MCLK_DIV]	= &audio_mst_d_mclk_div.hw,
> +	[AUD_CLKID_MST_D_MCLK]		= &audio_mst_d_mclk.hw,
> +	[AUD_CLKID_RESAMPLE_CLK_SEL]	= &audio_resample_clk_mux.hw,
> +	[AUD_CLKID_RESAMPLE_CLK_DIV]	= &audio_resample_clk_div.hw,
> +	[AUD_CLKID_RESAMPLE_CLK]	= &audio_resample_clk.hw,
> +	[AUD_CLKID_LOCKER_IN_CLK_SEL]	= &audio_locker_in_clk_mux.hw,
> +	[AUD_CLKID_LOCKER_IN_CLK_DIV]	= &audio_locker_in_clk_div.hw,
> +	[AUD_CLKID_LOCKER_IN_CLK]	= &audio_locker_in_clk.hw,
> +	[AUD_CLKID_LOCKER_OUT_CLK_SEL]	= &audio_locker_out_clk_mux.hw,
> +	[AUD_CLKID_LOCKER_OUT_CLK_DIV]	= &audio_locker_out_clk_div.hw,
> +	[AUD_CLKID_LOCKER_OUT_CLK]	= &audio_locker_out_clk.hw,
> +	[AUD_CLKID_SPDIFIN_CLK_SEL]	= &audio_spdifin_clk_mux.hw,
> +	[AUD_CLKID_SPDIFIN_CLK_DIV]	= &audio_spdifin_clk_div.hw,
> +	[AUD_CLKID_SPDIFIN_CLK]		= &audio_spdifin_clk.hw,
> +	[AUD_CLKID_EQDRC_CLK_SEL]	= &audio_eqdrc_clk_mux.hw,
> +	[AUD_CLKID_EQDRC_CLK_DIV]	= &audio_eqdrc_clk_div.hw,
> +	[AUD_CLKID_EQDRC_CLK]		= &audio_eqdrc_clk.hw,
> +	[AUD_CLKID_MST_A_SCLK_PRE_EN]	= &audio_mst_a_sclk_pre_en.hw,
> +	[AUD_CLKID_MST_A_SCLK_DIV]	= &audio_mst_a_sclk_div.hw,
> +	[AUD_CLKID_MST_A_SCLK_POST_EN]	= &audio_mst_a_sclk_post_en.hw,
> +	[AUD_CLKID_MST_A_SCLK]		= &audio_mst_a_sclk.hw,
> +	[AUD_CLKID_MST_B_SCLK_PRE_EN]	= &audio_mst_b_sclk_pre_en.hw,
> +	[AUD_CLKID_MST_B_SCLK_DIV]	= &audio_mst_b_sclk_div.hw,
> +	[AUD_CLKID_MST_B_SCLK_POST_EN]	= &audio_mst_b_sclk_post_en.hw,
> +	[AUD_CLKID_MST_B_SCLK]		= &audio_mst_b_sclk.hw,
> +	[AUD_CLKID_MST_C_SCLK_PRE_EN]	= &audio_mst_c_sclk_pre_en.hw,
> +	[AUD_CLKID_MST_C_SCLK_DIV]	= &audio_mst_c_sclk_div.hw,
> +	[AUD_CLKID_MST_C_SCLK_POST_EN]	= &audio_mst_c_sclk_post_en.hw,
> +	[AUD_CLKID_MST_C_SCLK]		= &audio_mst_c_sclk.hw,
> +	[AUD_CLKID_MST_D_SCLK_PRE_EN]	= &audio_mst_d_sclk_pre_en.hw,
> +	[AUD_CLKID_MST_D_SCLK_DIV]	= &audio_mst_d_sclk_div.hw,
> +	[AUD_CLKID_MST_D_SCLK_POST_EN]	= &audio_mst_d_sclk_post_en.hw,
> +	[AUD_CLKID_MST_D_SCLK]		= &audio_mst_d_sclk.hw,
> +	[AUD_CLKID_MST_A_LRCLK_DIV]	= &audio_mst_a_lrclk_div.hw,
> +	[AUD_CLKID_MST_A_LRCLK]		= &audio_mst_a_lrclk.hw,
> +	[AUD_CLKID_MST_B_LRCLK_DIV]	= &audio_mst_b_lrclk_div.hw,
> +	[AUD_CLKID_MST_B_LRCLK]		= &audio_mst_b_lrclk.hw,
> +	[AUD_CLKID_MST_C_LRCLK_DIV]	= &audio_mst_c_lrclk_div.hw,
> +	[AUD_CLKID_MST_C_LRCLK]		= &audio_mst_c_lrclk.hw,
> +	[AUD_CLKID_MST_D_LRCLK_DIV]	= &audio_mst_d_lrclk_div.hw,
> +	[AUD_CLKID_MST_D_LRCLK]		= &audio_mst_d_lrclk.hw,
> +	[AUD_CLKID_TDMIN_A_SCLK_SEL]	= &audio_tdmin_a_sclk_mux.hw,
> +	[AUD_CLKID_TDMIN_A_SCLK_PRE_EN]	= &audio_tdmin_a_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMIN_A_SCLK_POST_EN] = &audio_tdmin_a_sclk_post_en.hw,
> +	[AUD_CLKID_TDMIN_A_SCLK]	= &audio_tdmin_a_sclk.hw,
> +	[AUD_CLKID_TDMIN_A_LRCLK]	= &audio_tdmin_a_lrclk.hw,
> +	[AUD_CLKID_TDMIN_B_SCLK_SEL]	= &audio_tdmin_b_sclk_mux.hw,
> +	[AUD_CLKID_TDMIN_B_SCLK_PRE_EN]	= &audio_tdmin_b_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMIN_B_SCLK_POST_EN] = &audio_tdmin_b_sclk_post_en.hw,
> +	[AUD_CLKID_TDMIN_B_SCLK]	= &audio_tdmin_b_sclk.hw,
> +	[AUD_CLKID_TDMIN_B_LRCLK]	= &audio_tdmin_b_lrclk.hw,
> +	[AUD_CLKID_TDMIN_LB_SCLK_SEL]	= &audio_tdmin_lb_sclk_mux.hw,
> +	[AUD_CLKID_TDMIN_LB_SCLK_PRE_EN] = &audio_tdmin_lb_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMIN_LB_SCLK_POST_EN] = &audio_tdmin_lb_sclk_post_en.hw,
> +	[AUD_CLKID_TDMIN_LB_SCLK]	= &audio_tdmin_lb_sclk.hw,
> +	[AUD_CLKID_TDMIN_LB_LRCLK]	= &audio_tdmin_lb_lrclk.hw,
> +	[AUD_CLKID_TDMOUT_A_SCLK_SEL]	= &audio_tdmout_a_sclk_mux.hw,
> +	[AUD_CLKID_TDMOUT_A_SCLK_PRE_EN] = &audio_tdmout_a_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMOUT_A_SCLK_POST_EN] = &audio_tdmout_a_sclk_post_en.hw,
> +	[AUD_CLKID_TDMOUT_A_SCLK]	= &audio_tdmout_a_sclk.hw,
> +	[AUD_CLKID_TDMOUT_A_LRCLK]	= &audio_tdmout_a_lrclk.hw,
> +	[AUD_CLKID_TDMOUT_B_SCLK_SEL]	= &audio_tdmout_b_sclk_mux.hw,
> +	[AUD_CLKID_TDMOUT_B_SCLK_PRE_EN] = &audio_tdmout_b_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMOUT_B_SCLK_POST_EN] = &audio_tdmout_b_sclk_post_en.hw,
> +	[AUD_CLKID_TDMOUT_B_SCLK]	= &audio_tdmout_b_sclk.hw,
> +	[AUD_CLKID_TDMOUT_B_LRCLK]	= &audio_tdmout_b_lrclk.hw,
> +
> +	[AUD2_CLKID_DDR_ARB]		= &audio2_ddr_arb.hw,
> +	[AUD2_CLKID_PDM]		= &audio2_pdm.hw,
> +	[AUD2_CLKID_TDMIN_VAD]		= &audio2_tdmin_vad.hw,
> +	[AUD2_CLKID_TODDR_VAD]		= &audio2_toddr_vad.hw,
> +	[AUD2_CLKID_VAD]		= &audio2_vad.hw,
> +	[AUD2_CLKID_AUDIOTOP]		= &audio2_audiotop.hw,
> +	[AUD2_CLKID_VAD_MCLK_SEL]	= &audio2_vad_mclk_mux.hw,
> +	[AUD2_CLKID_VAD_MCLK_DIV]	= &audio2_vad_mclk_div.hw,
> +	[AUD2_CLKID_VAD_MCLK]		= &audio2_vad_mclk.hw,
> +	[AUD2_CLKID_VAD_CLK_SEL]	= &audio2_vad_clk_mux.hw,
> +	[AUD2_CLKID_VAD_CLK_DIV]	= &audio2_vad_clk_div.hw,
> +	[AUD2_CLKID_VAD_CLK]		= &audio2_vad_clk.hw,
> +	[AUD2_CLKID_PDM_DCLK_SEL]	= &audio2_pdm_dclk_mux.hw,
> +	[AUD2_CLKID_PDM_DCLK_DIV]	= &audio2_pdm_dclk_div.hw,
> +	[AUD2_CLKID_PDM_DCLK]		= &audio2_pdm_dclk.hw,
> +	[AUD2_CLKID_PDM_SYSCLK_SEL]	= &audio2_pdm_sysclk_mux.hw,
> +	[AUD2_CLKID_PDM_SYSCLK_DIV]	= &audio2_pdm_sysclk_div.hw,
> +	[AUD2_CLKID_PDM_SYSCLK]		= &audio2_pdm_sysclk.hw,
> +};
> +
> +static struct meson_clk_hw_data a1_audio_clks = {
> +	.hws = a1_audio_hw_clks,
> +	.num = ARRAY_SIZE(a1_audio_hw_clks),
> +};
> +
> +static struct regmap *a1_audio_map(struct platform_device *pdev,
> +				   unsigned int index)
> +{
> +	char name[32];
> +	const struct regmap_config cfg = {
> +		.reg_bits = 32,
> +		.val_bits = 32,
> +		.reg_stride = 4,
> +		.name = name,

Not necessary

> +	};
> +	void __iomem *base;
> +
> +	base = devm_platform_ioremap_resource(pdev, index);
> +	if (IS_ERR(base))
> +		return base;
> +
> +	scnprintf(name, sizeof(name), "%d", index);
> +	return devm_regmap_init_mmio(&pdev->dev, base, &cfg);
> +}

That is overengineered. Please keep it simple. Declare the regmap_config
as static const global, and do it like axg-audio please.

> +
> +static int a1_register_clk(struct platform_device *pdev,
> +			   struct regmap *map0, struct regmap *map1,
> +			   struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = container_of(hw, struct clk_regmap, hw);
> +
> +	if (!hw)
> +		return 0;
> +
> +	switch ((unsigned long)clk->map) {
> +	case AUDIO_RANGE_0:
> +		clk->map = map0;
> +		break;
> +	case AUDIO_RANGE_1:
> +		clk->map = map1;
> +		break;

.. fishy

> +	default:
> +		WARN_ON(1);
> +		return -EINVAL;
> +	}
> +
> +	return devm_clk_hw_register(&pdev->dev, hw);
> +}
> +
> +static int a1_audio_clkc_probe(struct platform_device *pdev)
> +{
> +	struct regmap *map0, *map1;
> +	struct clk *clk;
> +	unsigned int i;
> +	int ret;
> +
> +	clk = devm_clk_get_enabled(&pdev->dev, "pclk");
> +	if (WARN_ON(IS_ERR(clk)))
> +		return PTR_ERR(clk);
> +
> +	map0 = a1_audio_map(pdev, 0);
> +	if (IS_ERR(map0))
> +		return PTR_ERR(map0);
> +
> +	map1 = a1_audio_map(pdev, 1);
> +	if (IS_ERR(map1))
> +		return PTR_ERR(map1);

No - Looks to me you just have two clock controllers you are trying
force into one.

> +
> +	/*
> +	 * Register and enable AUD2_CLKID_AUDIOTOP clock first. Unless
> +	 * it is enabled any read/write to 'map0' hangs the CPU.
> +	 */
> +
> +	ret = a1_register_clk(pdev, map0, map1,
> +			      a1_audio_clks.hws[AUD2_CLKID_AUDIOTOP]);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(a1_audio_clks.hws[AUD2_CLKID_AUDIOTOP]->clk);
> +	if (ret)
> +		return ret;

Again, this shows 2 devices. The one related to your 'map0' should
request AUD2_CLKID_AUDIOTOP as input and enable it right away.

> +
> +	for (i = 0; i < a1_audio_clks.num; i++) {
> +		if (i == AUD2_CLKID_AUDIOTOP)
> +			continue;
> +
> +		ret = a1_register_clk(pdev, map0, map1, a1_audio_clks.hws[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = devm_of_clk_add_hw_provider(&pdev->dev, meson_clk_hw_get,
> +					  &a1_audio_clks);
> +	if (ret)
> +		return ret;
> +
> +	BUILD_BUG_ON((unsigned long)AUDIO_REG_MAP(AUDIO_SW_RESET0) !=
> +		     AUDIO_RANGE_0);

Why is that necessary ?

> +	return meson_audio_rstc_register(&pdev->dev, map0,
> +					 AUDIO_REG_OFFSET(AUDIO_SW_RESET0), 32);
> +}
> +
> +static const struct of_device_id a1_audio_clkc_match_table[] = {
> +	{ .compatible = "amlogic,a1-audio-clkc", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, a1_audio_clkc_match_table);
> +
> +static struct platform_driver a1_audio_clkc_driver = {
> +	.probe = a1_audio_clkc_probe,
> +	.driver = {
> +		.name = "a1-audio-clkc",
> +		.of_match_table = a1_audio_clkc_match_table,
> +	},
> +};
> +module_platform_driver(a1_audio_clkc_driver);
> +
> +MODULE_DESCRIPTION("Amlogic A1 Audio Clock driver");
> +MODULE_AUTHOR("Jan Dakinevich <jan.dakinevich@salutedevices.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/meson/a1-audio.h b/drivers/clk/meson/a1-audio.h
> new file mode 100644
> index 000000000000..f994e87276cd
> --- /dev/null
> +++ b/drivers/clk/meson/a1-audio.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> + *
> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> + */
> +
> +#ifndef __A1_AUDIO_H
> +#define __A1_AUDIO_H
> +
> +#define AUDIO_RANGE_0		0xa
> +#define AUDIO_RANGE_1		0xb
> +#define AUDIO_RANGE_SHIFT	16
> +
> +#define AUDIO_REG(_range, _offset) \
> +	(((_range) << AUDIO_RANGE_SHIFT) + (_offset))
> +
> +#define AUDIO_REG_OFFSET(_reg) \
> +	((_reg) & ((1 << AUDIO_RANGE_SHIFT) - 1))
> +
> +#define AUDIO_REG_MAP(_reg) \
> +	((void *)((_reg) >> AUDIO_RANGE_SHIFT))

That is seriouly overengineered.
The following are offset. Just write what they are.

There is not reason to put that into a header. It is only going to be
used by a single driver.

> +
> +#define AUDIO_CLK_GATE_EN0	AUDIO_REG(AUDIO_RANGE_0, 0x000)
> +#define AUDIO_MCLK_A_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x008)
> +#define AUDIO_MCLK_B_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x00c)
> +#define AUDIO_MCLK_C_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x010)
> +#define AUDIO_MCLK_D_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x014)
> +#define AUDIO_MCLK_E_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x018)
> +#define AUDIO_MCLK_F_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x01c)
> +#define AUDIO_SW_RESET0		AUDIO_REG(AUDIO_RANGE_0, 0x028)
> +#define AUDIO_MST_A_SCLK_CTRL0	AUDIO_REG(AUDIO_RANGE_0, 0x040)
> +#define AUDIO_MST_A_SCLK_CTRL1	AUDIO_REG(AUDIO_RANGE_0, 0x044)
> +#define AUDIO_MST_B_SCLK_CTRL0	AUDIO_REG(AUDIO_RANGE_0, 0x048)
> +#define AUDIO_MST_B_SCLK_CTRL1	AUDIO_REG(AUDIO_RANGE_0, 0x04c)
> +#define AUDIO_MST_C_SCLK_CTRL0	AUDIO_REG(AUDIO_RANGE_0, 0x050)
> +#define AUDIO_MST_C_SCLK_CTRL1	AUDIO_REG(AUDIO_RANGE_0, 0x054)
> +#define AUDIO_MST_D_SCLK_CTRL0	AUDIO_REG(AUDIO_RANGE_0, 0x058)
> +#define AUDIO_MST_D_SCLK_CTRL1	AUDIO_REG(AUDIO_RANGE_0, 0x05c)
> +#define AUDIO_CLK_TDMIN_A_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x080)
> +#define AUDIO_CLK_TDMIN_B_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x084)
> +#define AUDIO_CLK_TDMIN_LB_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x08c)
> +#define AUDIO_CLK_TDMOUT_A_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x090)
> +#define AUDIO_CLK_TDMOUT_B_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x094)
> +#define AUDIO_CLK_SPDIFIN_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x09c)
> +#define AUDIO_CLK_RESAMPLE_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x0a4)
> +#define AUDIO_CLK_LOCKER_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x0a8)
> +#define AUDIO_CLK_EQDRC_CTRL	AUDIO_REG(AUDIO_RANGE_0, 0x0c0)
> +
> +#define AUDIO2_CLK_GATE_EN0	AUDIO_REG(AUDIO_RANGE_1, 0x00c)
> +#define AUDIO2_MCLK_VAD_CTRL	AUDIO_REG(AUDIO_RANGE_1, 0x040)
> +#define AUDIO2_CLK_VAD_CTRL	AUDIO_REG(AUDIO_RANGE_1, 0x044)
> +#define AUDIO2_CLK_PDMIN_CTRL0	AUDIO_REG(AUDIO_RANGE_1, 0x058)
> +#define AUDIO2_CLK_PDMIN_CTRL1	AUDIO_REG(AUDIO_RANGE_1, 0x05c)
> +
> +#include <dt-bindings/clock/amlogic,a1-audio-clkc.h>
> +
> +#endif /* __A1_AUDIO_H */


-- 
Jerome

