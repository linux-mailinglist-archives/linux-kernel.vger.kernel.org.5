Return-Path: <linux-kernel+bounces-152920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 198FC8AC623
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8366E1F2128B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017114D131;
	Mon, 22 Apr 2024 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jaeaFkw+"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E74D599
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772645; cv=none; b=D+GJXzCcTbB3yRA9ZOYX+W6VsbEP9jbeq76Oh0haK9him9QHknLIcyTiHII2VAAZSUo70NQsfKuAPtJecmWeqCJ++aF7iwYz1pm81217AP07nUccWM4qiHQhRrQ+RBeH60ytAV/P07QY2OX6Pi+qEvai3Ow376egbqN79+Pzrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772645; c=relaxed/simple;
	bh=oHCB12dXKzWzMi6a8J/Dt2OFm9f0Ke20rrjGLs3vDNo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=WekOfwTWzhl4QNCeUWJIWuH7k62yla+az08Q0SC7sJsqFyKWQ/ZmlsrFL6pMcSN++OKCq6ysW/XwfadfOCslfoHDeXRiqPP1i5MIkjxhHi/9uwZKx1vQa3jteP7s7SuPXBeq/cCXlBZGlSy5L26/zoRBZ2z0cMFgbVNZFvFxR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jaeaFkw+; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3455ff1339dso3072452f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713772641; x=1714377441; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=sFYfGCZs1Pp7YeOGZn2C8BdGAZNNcbKzv09+peDZTuQ=;
        b=jaeaFkw+KUlUeIlAqdcXZYiHNOVO8F5tOUCHM/9rdkTGqPJrRTn+B8DO3LtSTwoyuE
         4cqZivuMpHv1o6jG0MmSkgmFGffzhCfEfQ7zF+s2Nn9yN4Qh2J3JLQChm8aw5BB+fSSu
         69xCtl3el6QIiEu07TqSfr1DvLm0WREnPXmtpz9LoDcKqxOYBk5eY+VV9HMrsCpL6VcW
         68w+sjuZjF7yKLeDAGxkiAXRi4wFjLG4jSZcn2YjerBhD/aMmnY/eR5Upx7DSiWglZ6I
         3GVWGkwvLr4nsY7+CZ6lMRCW81zmhu0YKms69H2LIsoz150G7dBCn8Pv6+GGcHbKoNEg
         /zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713772641; x=1714377441;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFYfGCZs1Pp7YeOGZn2C8BdGAZNNcbKzv09+peDZTuQ=;
        b=LnUp8cibFdR7rqxkdG5wTbRhF0bsQE9tpHGV6rDeQ4YByMvfMaMRYFLrXdkKrd88lz
         UbVq1KzdNjPHeaUffWNemTCmnUuxa/7i024CQUMhN1vqNpqAY02mhwtUyvbdLT9Jx73l
         baw0ss2mTghA4Sa7z5eychzGq6bTssReYDJ8vtLSTaSn5Jwqk77jgkCWJAx0x1lK8AJm
         jI7cRz8SLY8HhLTRS575L8K0692/8AfwIQeowDAFCjrOTRgwzMbWtWcn3Rt2IKstyfUh
         eZs5UVw615YaiVvE4rcCGHDsPBudSY7f+75Vtccb5+PjHS+wRJ/zy81s8o9mNgytzA0V
         Wqzg==
X-Forwarded-Encrypted: i=1; AJvYcCWmKtEfEGwKom8mG52cmm6scnfTFGEVwbYK8LG9YBa5olChSnVuqVLFl6D2FloqicQ0ulKw/W3LrOD+qAVTrS/m9NfGUG9qzx53inE4
X-Gm-Message-State: AOJu0YxaO8QUsLPjyAO4TwTaxGtWvG6x4yHTBfFV4lyI2yHJYDMaBu/D
	rRcWU4GOih9R1HO8PGlrWuK8AEjeOcw+ZaLJLqgUK5g0F7cZlTcxeDRLUpQh+RM=
X-Google-Smtp-Source: AGHT+IF6A+X2EjE6WUazWlrjUjmkxV0IJZrQbB5QH3YW2peQuaN4LE+bfZ+Y8XMw88VXuePMAd/+MA==
X-Received: by 2002:adf:e307:0:b0:341:89da:540c with SMTP id b7-20020adfe307000000b0034189da540cmr7307901wrj.26.1713772640495;
        Mon, 22 Apr 2024 00:57:20 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:a619:ccb0:5f40:262c])
        by smtp.gmail.com with ESMTPSA id q2-20020adff942000000b00346bda84bf9sm11401588wrr.78.2024.04.22.00.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:57:20 -0700 (PDT)
References: <20240419125812.983409-1-jan.dakinevich@salutedevices.com>
 <20240419125812.983409-6-jan.dakinevich@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
 <jbrunet@baylibre.com>, Michael  Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob  Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor  Dooley <conor+dt@kernel.org>, Kevin
 Hilman <khilman@baylibre.com>, Martin  Blumenstingl
 <martin.blumenstingl@googlemail.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jiucheng Xu <jiucheng.xu@amlogic.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v3 5/6] clk: meson: a1: add the audio clock
 controller driver
Date: Mon, 22 Apr 2024 09:53:29 +0200
In-reply-to: <20240419125812.983409-6-jan.dakinevich@salutedevices.com>
Message-ID: <1j4jbtbzj4.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Fri 19 Apr 2024 at 15:58, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:

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
>  drivers/clk/meson/Kconfig         |  14 +
>  drivers/clk/meson/Makefile        |   1 +
>  drivers/clk/meson/a1-audio.c      | 651 ++++++++++++++++++++++++++++++
>  drivers/reset/reset-meson-audio.c |  10 +
>  4 files changed, 676 insertions(+)
>  create mode 100644 drivers/clk/meson/a1-audio.c
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 33614f8b8cf7..8aa2b38914fc 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -130,6 +130,20 @@ config COMMON_CLK_A1_PERIPHERALS
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
> +	select RESET_CONTROLLER
> +	select RESET_MESON_AUDIO
> +	help
> +	  Support for the Audio clock controller on Amlogic A113L based
> +	  device, A1 SoC Family. Say Y if you want A1 Audio clock controller
> +	  to work.
> +
>  config COMMON_CLK_G12A
>  	tristate "G12 and SM1 SoC clock controllers support"
>  	depends on ARM64
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 9ee4b954c896..5e0260cef111 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>  obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
> +obj-$(CONFIG_COMMON_CLK_A1_AUDIO) += a1-audio.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
> diff --git a/drivers/clk/meson/a1-audio.c b/drivers/clk/meson/a1-audio.c
> new file mode 100644
> index 000000000000..bf08e354f32d
> --- /dev/null
> +++ b/drivers/clk/meson/a1-audio.c
> @@ -0,0 +1,651 @@
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
> +#include <soc/amlogic/meson-audio-reset.h>
> +#include <dt-bindings/clock/amlogic,a1-audio-clkc.h>
> +
> +#include "meson-clkc-utils.h"
> +#include "meson-audio.h"
> +#include "clk-regmap.h"
> +#include "clk-phase.h"
> +#include "sclk-div.h"
> +
> +#define AUDIO_CLK_GATE_EN0		0x000
> +#define AUDIO_MCLK_A_CTRL		0x008
> +#define AUDIO_MCLK_B_CTRL		0x00c
> +#define AUDIO_MCLK_C_CTRL		0x010
> +#define AUDIO_MCLK_D_CTRL		0x014
> +#define AUDIO_SW_RESET0			0x028
> +#define AUDIO_MST_A_SCLK_CTRL0		0x040
> +#define AUDIO_MST_A_SCLK_CTRL1		0x044
> +#define AUDIO_MST_B_SCLK_CTRL0		0x048
> +#define AUDIO_MST_B_SCLK_CTRL1		0x04c
> +#define AUDIO_MST_C_SCLK_CTRL0		0x050
> +#define AUDIO_MST_C_SCLK_CTRL1		0x054
> +#define AUDIO_MST_D_SCLK_CTRL0		0x058
> +#define AUDIO_MST_D_SCLK_CTRL1		0x05c
> +#define AUDIO_CLK_TDMIN_A_CTRL		0x080
> +#define AUDIO_CLK_TDMIN_B_CTRL		0x084
> +#define AUDIO_CLK_TDMIN_LB_CTRL		0x08c
> +#define AUDIO_CLK_TDMOUT_A_CTRL		0x090
> +#define AUDIO_CLK_TDMOUT_B_CTRL		0x094
> +#define AUDIO_CLK_SPDIFIN_CTRL		0x09c
> +#define AUDIO_CLK_RESAMPLEA_CTRL	0x0a4
> +#define AUDIO_CLK_LOCKER_CTRL		0x0a8
> +#define AUDIO_CLK_EQDRC_CTRL		0x0c0
> +
> +#define AUDIO2_CLK_GATE_EN0		0x00c
> +#define AUDIO2_MCLK_VAD_CTRL		0x040
> +#define AUDIO2_CLK_VAD_CTRL		0x044
> +#define AUDIO2_CLK_PDMIN_CTRL0		0x058
> +#define AUDIO2_CLK_PDMIN_CTRL1		0x05c
> +
> +static const struct clk_parent_data a1_pclk_pdata[] = {
> +	{ .fw_name = "pclk" },
> +};
> +
> +#define AUD_PCLK_GATE(_name, _reg, _bit) {				\
> +	.data = &(struct clk_regmap_gate_data){				\
> +		.offset = (_reg),					\
> +		.bit_idx = (_bit),					\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = "aud_"#_name,					\
> +		.ops = &clk_regmap_gate_ops,				\
> +		.parent_data = a1_pclk_pdata,				\
> +		.num_parents = 1,					\
> +	},								\
> +}
> +
> +struct clk_regmap aud_ddr_arb =
> +	AUD_PCLK_GATE(ddr_arb, AUDIO_CLK_GATE_EN0, 0);
> +struct clk_regmap aud_tdmin_a =
> +	AUD_PCLK_GATE(tdmin_a, AUDIO_CLK_GATE_EN0, 1);
> +struct clk_regmap aud_tdmin_b =
> +	AUD_PCLK_GATE(tdmin_b, AUDIO_CLK_GATE_EN0, 2);
> +struct clk_regmap aud_tdmin_lb =
> +	AUD_PCLK_GATE(tdmin_lb, AUDIO_CLK_GATE_EN0, 3);
> +struct clk_regmap aud_loopback =
> +	AUD_PCLK_GATE(loopback, AUDIO_CLK_GATE_EN0, 4);
> +struct clk_regmap aud_tdmout_a =
> +	AUD_PCLK_GATE(tdmout_a, AUDIO_CLK_GATE_EN0, 5);
> +struct clk_regmap aud_tdmout_b =
> +	AUD_PCLK_GATE(tdmout_b, AUDIO_CLK_GATE_EN0, 6);
> +struct clk_regmap aud_frddr_a =
> +	AUD_PCLK_GATE(frddr_a, AUDIO_CLK_GATE_EN0, 7);
> +struct clk_regmap aud_frddr_b =
> +	AUD_PCLK_GATE(frddr_b, AUDIO_CLK_GATE_EN0, 8);
> +struct clk_regmap aud_toddr_a =
> +	AUD_PCLK_GATE(toddr_a, AUDIO_CLK_GATE_EN0, 9);
> +struct clk_regmap aud_toddr_b =
> +	AUD_PCLK_GATE(toddr_b, AUDIO_CLK_GATE_EN0, 10);
> +struct clk_regmap aud_spdifin =
> +	AUD_PCLK_GATE(spdifin, AUDIO_CLK_GATE_EN0, 11);
> +struct clk_regmap aud_resample =
> +	AUD_PCLK_GATE(resample, AUDIO_CLK_GATE_EN0, 12);
> +struct clk_regmap aud_eqdrc =
> +	AUD_PCLK_GATE(eqdrc, AUDIO_CLK_GATE_EN0, 13);
> +struct clk_regmap aud_audiolocker =
> +	AUD_PCLK_GATE(audiolocker, AUDIO_CLK_GATE_EN0, 14);
> +
> +struct clk_regmap aud_vad_ddr_arb =
> +	AUD_PCLK_GATE(vad_ddr_arb, AUDIO2_CLK_GATE_EN0, 0);
> +struct clk_regmap aud_vad_pdm =
> +	AUD_PCLK_GATE(vad_pdm, AUDIO2_CLK_GATE_EN0, 1);
> +struct clk_regmap aud_vad_tdmin_vad =
> +	AUD_PCLK_GATE(vad_tdmin_vad, AUDIO2_CLK_GATE_EN0, 2);
> +struct clk_regmap aud_vad_toddr_vad =
> +	AUD_PCLK_GATE(vad_toddr_vad, AUDIO2_CLK_GATE_EN0, 3);
> +struct clk_regmap aud_vad =
> +	AUD_PCLK_GATE(vad, AUDIO2_CLK_GATE_EN0, 4);
> +struct clk_regmap aud_vad_audiotop =
> +	AUD_PCLK_GATE(vad_audiotop, AUDIO2_CLK_GATE_EN0, 7);
> +
> +static const struct clk_parent_data a1_mst_pdata[] = {
> +	{ .fw_name = "dds_in" },
> +	{ .fw_name = "fclk_div2" },
> +	{ .fw_name = "fclk_div3" },
> +	{ .fw_name = "hifi_pll" },
> +	{ .fw_name = "xtal" },
> +};
> +
> +#define AUD_MST_MCLK_MUX(_name, _reg)					\
> +	AUD_MUX(_name##_sel, _reg, 0x7, 24, CLK_MUX_ROUND_CLOSEST,	\
> +		a1_mst_pdata, 0)
> +#define AUD_MST_MCLK_DIV(_name, _reg)					\
> +	AUD_DIV(_name##_div, _reg, 0, 16, CLK_DIVIDER_ROUND_CLOSEST,	\
> +		aud_##_name##_sel, CLK_SET_RATE_PARENT)
> +#define AUD_MST_MCLK_GATE(_name, _reg)					\
> +	AUD_GATE(_name, _reg, 31, aud_##_name##_div,			\
> +		 CLK_SET_RATE_PARENT)
> +
> +struct clk_regmap aud_mst_a_mclk_sel =
> +	AUD_MST_MCLK_MUX(mst_a_mclk, AUDIO_MCLK_A_CTRL);
> +struct clk_regmap aud_mst_a_mclk_div =
> +	AUD_MST_MCLK_DIV(mst_a_mclk, AUDIO_MCLK_A_CTRL);
> +struct clk_regmap aud_mst_a_mclk =
> +	AUD_MST_MCLK_GATE(mst_a_mclk, AUDIO_MCLK_A_CTRL);
> +
> +struct clk_regmap aud_mst_b_mclk_sel =
> +	AUD_MST_MCLK_MUX(mst_b_mclk, AUDIO_MCLK_B_CTRL);
> +struct clk_regmap aud_mst_b_mclk_div =
> +	AUD_MST_MCLK_DIV(mst_b_mclk, AUDIO_MCLK_B_CTRL);
> +struct clk_regmap aud_mst_b_mclk =
> +	AUD_MST_MCLK_GATE(mst_b_mclk, AUDIO_MCLK_B_CTRL);
> +
> +struct clk_regmap aud_mst_c_mclk_sel =
> +	AUD_MST_MCLK_MUX(mst_c_mclk, AUDIO_MCLK_C_CTRL);
> +struct clk_regmap aud_mst_c_mclk_div =
> +	AUD_MST_MCLK_DIV(mst_c_mclk, AUDIO_MCLK_C_CTRL);
> +struct clk_regmap aud_mst_c_mclk =
> +	AUD_MST_MCLK_GATE(mst_c_mclk, AUDIO_MCLK_C_CTRL);
> +
> +struct clk_regmap aud_mst_d_mclk_sel =
> +	AUD_MST_MCLK_MUX(mst_d_mclk, AUDIO_MCLK_D_CTRL);
> +struct clk_regmap aud_mst_d_mclk_div =
> +	AUD_MST_MCLK_DIV(mst_d_mclk, AUDIO_MCLK_D_CTRL);
> +struct clk_regmap aud_mst_d_mclk =
> +	AUD_MST_MCLK_GATE(mst_d_mclk, AUDIO_MCLK_D_CTRL);
> +
> +struct clk_regmap aud_spdifin_clk_sel =
> +	AUD_MST_MCLK_MUX(spdifin_clk, AUDIO_CLK_SPDIFIN_CTRL);
> +struct clk_regmap aud_spdifin_clk_div =
> +	AUD_MST_MCLK_DIV(spdifin_clk, AUDIO_CLK_SPDIFIN_CTRL);
> +struct clk_regmap aud_spdifin_clk =
> +	AUD_MST_MCLK_GATE(spdifin_clk, AUDIO_CLK_SPDIFIN_CTRL);
> +
> +struct clk_regmap aud_eqdrc_clk_sel =
> +	AUD_MST_MCLK_MUX(eqdrc_clk, AUDIO_CLK_EQDRC_CTRL);
> +struct clk_regmap aud_eqdrc_clk_div =
> +	AUD_MST_MCLK_DIV(eqdrc_clk, AUDIO_CLK_EQDRC_CTRL);
> +struct clk_regmap aud_eqdrc_clk =
> +	AUD_MST_MCLK_GATE(eqdrc_clk, AUDIO_CLK_EQDRC_CTRL);
> +
> +struct clk_regmap aud_resample_clk_sel =
> +	AUD_MUX(resample_clk_sel, AUDIO_CLK_RESAMPLEA_CTRL, 0xf, 24,
> +		CLK_MUX_ROUND_CLOSEST, a1_mst_pdata, 0);
> +struct clk_regmap aud_resample_clk_div =
> +	AUD_DIV(resample_clk_div, AUDIO_CLK_RESAMPLEA_CTRL, 0, 8,
> +		CLK_DIVIDER_ROUND_CLOSEST, aud_resample_clk_sel,
> +		CLK_SET_RATE_PARENT);
> +struct clk_regmap aud_resample_clk =
> +	AUD_GATE(resample_clk, AUDIO_CLK_RESAMPLEA_CTRL, 31,
> +		 aud_resample_clk_div, CLK_SET_RATE_PARENT);
> +
> +struct clk_regmap aud_locker_in_clk_sel =
> +	AUD_MUX(locker_in_clk_sel, AUDIO_CLK_LOCKER_CTRL, 0xf, 8,
> +		CLK_MUX_ROUND_CLOSEST, a1_mst_pdata, 0);
> +struct clk_regmap aud_locker_in_clk_div =
> +	AUD_DIV(locker_in_clk_div, AUDIO_CLK_LOCKER_CTRL, 0, 8,
> +		CLK_DIVIDER_ROUND_CLOSEST, aud_locker_in_clk_sel,
> +		CLK_SET_RATE_PARENT);
> +struct clk_regmap aud_locker_in_clk =
> +	AUD_GATE(locker_in_clk, AUDIO_CLK_LOCKER_CTRL, 15,
> +		 aud_locker_in_clk_div, CLK_SET_RATE_PARENT);
> +
> +struct clk_regmap aud_locker_out_clk_sel =
> +	AUD_MUX(locker_out_clk_sel, AUDIO_CLK_LOCKER_CTRL, 0xf, 24,
> +		CLK_MUX_ROUND_CLOSEST, a1_mst_pdata, 0);
> +struct clk_regmap aud_locker_out_clk_div =
> +	AUD_DIV(locker_out_clk_div, AUDIO_CLK_LOCKER_CTRL, 16, 8,
> +		CLK_DIVIDER_ROUND_CLOSEST, aud_locker_out_clk_sel,
> +		CLK_SET_RATE_PARENT);
> +struct clk_regmap aud_locker_out_clk =
> +	AUD_GATE(locker_out_clk, AUDIO_CLK_LOCKER_CTRL, 31,
> +		 aud_locker_out_clk_div, CLK_SET_RATE_PARENT);
> +
> +struct clk_regmap aud_vad_mclk_sel =
> +	AUD_MST_MCLK_MUX(vad_mclk, AUDIO2_MCLK_VAD_CTRL);
> +struct clk_regmap aud_vad_mclk_div =
> +	AUD_MST_MCLK_DIV(vad_mclk, AUDIO2_MCLK_VAD_CTRL);
> +struct clk_regmap aud_vad_mclk =
> +	AUD_MST_MCLK_GATE(vad_mclk, AUDIO2_MCLK_VAD_CTRL);
> +
> +struct clk_regmap aud_vad_clk_sel =
> +	AUD_MST_MCLK_MUX(vad_clk, AUDIO2_CLK_VAD_CTRL);
> +struct clk_regmap aud_vad_clk_div =
> +	AUD_MST_MCLK_DIV(vad_clk, AUDIO2_CLK_VAD_CTRL);
> +struct clk_regmap aud_vad_clk =
> +	AUD_MST_MCLK_GATE(vad_clk, AUDIO2_CLK_VAD_CTRL);
> +
> +struct clk_regmap aud_vad_pdm_dclk_sel =
> +	AUD_MST_MCLK_MUX(vad_pdm_dclk, AUDIO2_CLK_PDMIN_CTRL0);
> +struct clk_regmap aud_vad_pdm_dclk_div =
> +	AUD_MST_MCLK_DIV(vad_pdm_dclk, AUDIO2_CLK_PDMIN_CTRL0);
> +struct clk_regmap aud_vad_pdm_dclk =
> +	AUD_MST_MCLK_GATE(vad_pdm_dclk, AUDIO2_CLK_PDMIN_CTRL0);
> +
> +struct clk_regmap aud_vad_pdm_sysclk_sel =
> +	AUD_MST_MCLK_MUX(vad_pdm_sysclk, AUDIO2_CLK_PDMIN_CTRL1);
> +struct clk_regmap aud_vad_pdm_sysclk_div =
> +	AUD_MST_MCLK_DIV(vad_pdm_sysclk, AUDIO2_CLK_PDMIN_CTRL1);
> +struct clk_regmap aud_vad_pdm_sysclk =
> +	AUD_MST_MCLK_GATE(vad_pdm_sysclk, AUDIO2_CLK_PDMIN_CTRL1);
> +
> +#define AUD_MST_SCLK_PRE_EN(_name, _reg, _pname)			\
> +	AUD_GATE(_name##_pre_en, _reg, 31,				\
> +		 aud_##_pname, 0)
> +#define AUD_MST_SCLK_DIV(_name, _reg)					\
> +	AUD_SCLK_DIV(_name##_div, _reg, 20, 10, 0, 0,			\
> +		     aud_##_name##_pre_en, CLK_SET_RATE_PARENT)
> +#define AUD_MST_SCLK_POST_EN(_name, _reg)				\
> +	AUD_GATE(_name##_post_en, _reg, 30,				\
> +		 aud_##_name##_div, CLK_SET_RATE_PARENT)
> +#define AUD_MST_SCLK(_name, _reg)					\
> +	AUD_TRIPHASE(_name, _reg, 1, 0, 2, 4,				\
> +		     aud_##_name##_post_en, CLK_SET_RATE_PARENT)
> +
> +struct clk_regmap aud_mst_a_sclk_pre_en =
> +	AUD_MST_SCLK_PRE_EN(mst_a_sclk, AUDIO_MST_A_SCLK_CTRL0, mst_a_mclk);
> +struct clk_regmap aud_mst_a_sclk_div =
> +	AUD_MST_SCLK_DIV(mst_a_sclk, AUDIO_MST_A_SCLK_CTRL0);
> +struct clk_regmap aud_mst_a_sclk_post_en =
> +	AUD_MST_SCLK_POST_EN(mst_a_sclk, AUDIO_MST_A_SCLK_CTRL0);
> +struct clk_regmap aud_mst_a_sclk =
> +	AUD_MST_SCLK(mst_a_sclk, AUDIO_MST_A_SCLK_CTRL1);
> +
> +struct clk_regmap aud_mst_b_sclk_pre_en =
> +	AUD_MST_SCLK_PRE_EN(mst_b_sclk, AUDIO_MST_B_SCLK_CTRL0, mst_b_mclk);
> +struct clk_regmap aud_mst_b_sclk_div =
> +	AUD_MST_SCLK_DIV(mst_b_sclk, AUDIO_MST_B_SCLK_CTRL0);
> +struct clk_regmap aud_mst_b_sclk_post_en =
> +	AUD_MST_SCLK_POST_EN(mst_b_sclk, AUDIO_MST_B_SCLK_CTRL0);
> +struct clk_regmap aud_mst_b_sclk =
> +	AUD_MST_SCLK(mst_b_sclk, AUDIO_MST_B_SCLK_CTRL1);
> +
> +struct clk_regmap aud_mst_c_sclk_pre_en =
> +	AUD_MST_SCLK_PRE_EN(mst_c_sclk, AUDIO_MST_C_SCLK_CTRL0, mst_c_mclk);
> +struct clk_regmap aud_mst_c_sclk_div =
> +	AUD_MST_SCLK_DIV(mst_c_sclk, AUDIO_MST_C_SCLK_CTRL0);
> +struct clk_regmap aud_mst_c_sclk_post_en =
> +	AUD_MST_SCLK_POST_EN(mst_c_sclk, AUDIO_MST_C_SCLK_CTRL0);
> +struct clk_regmap aud_mst_c_sclk =
> +	AUD_MST_SCLK(mst_c_sclk, AUDIO_MST_C_SCLK_CTRL1);
> +
> +struct clk_regmap aud_mst_d_sclk_pre_en =
> +	AUD_MST_SCLK_PRE_EN(mst_d_sclk, AUDIO_MST_D_SCLK_CTRL0, mst_d_mclk);
> +struct clk_regmap aud_mst_d_sclk_div =
> +	AUD_MST_SCLK_DIV(mst_d_sclk, AUDIO_MST_D_SCLK_CTRL0);
> +struct clk_regmap aud_mst_d_sclk_post_en =
> +	AUD_MST_SCLK_POST_EN(mst_d_sclk, AUDIO_MST_D_SCLK_CTRL0);
> +struct clk_regmap aud_mst_d_sclk =
> +	AUD_MST_SCLK(mst_d_sclk, AUDIO_MST_D_SCLK_CTRL1);
> +
> +#define AUD_MST_LRCLK_DIV(_name, _reg, _pname)				\
> +	AUD_SCLK_DIV(_name##_div, _reg, 0, 10, 10, 10,			\
> +		     aud_##_pname, 0)
> +#define AUD_MST_LRCLK(_name, _reg)					\
> +	AUD_TRIPHASE(_name, _reg, 1, 1, 3, 5,				\
> +		     aud_##_name##_div, CLK_SET_RATE_PARENT)
> +
> +struct clk_regmap aud_mst_a_lrclk_div =
> +	AUD_MST_LRCLK_DIV(mst_a_lrclk, AUDIO_MST_A_SCLK_CTRL0,
> +			  mst_a_sclk_post_en);
> +struct clk_regmap aud_mst_a_lrclk =
> +	AUD_MST_LRCLK(mst_a_lrclk, AUDIO_MST_A_SCLK_CTRL1);
> +
> +struct clk_regmap aud_mst_b_lrclk_div =
> +	AUD_MST_LRCLK_DIV(mst_b_lrclk, AUDIO_MST_B_SCLK_CTRL0,
> +			  mst_b_sclk_post_en);
> +struct clk_regmap aud_mst_b_lrclk =
> +	AUD_MST_LRCLK(mst_b_lrclk, AUDIO_MST_B_SCLK_CTRL1);
> +
> +struct clk_regmap aud_mst_c_lrclk_div =
> +	AUD_MST_LRCLK_DIV(mst_c_lrclk, AUDIO_MST_C_SCLK_CTRL0,
> +			  mst_c_sclk_post_en);
> +struct clk_regmap aud_mst_c_lrclk =
> +	AUD_MST_LRCLK(mst_c_lrclk, AUDIO_MST_C_SCLK_CTRL1);
> +
> +struct clk_regmap aud_mst_d_lrclk_div =
> +	AUD_MST_LRCLK_DIV(mst_d_lrclk, AUDIO_MST_D_SCLK_CTRL0,
> +			  mst_d_sclk_post_en);
> +struct clk_regmap aud_mst_d_lrclk =
> +	AUD_MST_LRCLK(mst_d_lrclk, AUDIO_MST_D_SCLK_CTRL1);
> +
> +static const struct clk_parent_data a1_mst_sclk_pdata[] = {
> +	{ .hw = &aud_mst_a_sclk.hw, .index = -1 },
> +	{ .hw = &aud_mst_b_sclk.hw, .index = -1 },
> +	{ .hw = &aud_mst_c_sclk.hw, .index = -1 },
> +	{ .hw = &aud_mst_d_sclk.hw, .index = -1 },
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
> +static u32 a1_mst_sclk_table[] = {
> +	0, 1, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
> +};

This is a clear indication that the bindings of axg and a1 are indeed
the same. Master clocks are optional.

> +
> +static const struct clk_parent_data a1_mst_lrclk_pdata[] = {
> +	{ .hw = &aud_mst_a_lrclk.hw, .index = -1 },
> +	{ .hw = &aud_mst_b_lrclk.hw, .index = -1 },
> +	{ .hw = &aud_mst_c_lrclk.hw, .index = -1 },
> +	{ .hw = &aud_mst_d_lrclk.hw, .index = -1 },
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
> +static u32 a1_mst_lrclk_table[] = {
> +	0, 1, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
> +};
> +
> +#define AUD_TDM_SCLK_MUX(_name, _reg)					\
> +	AUD_MUX_TABLE(_name##_sel, _reg, a1_mst_sclk_table, 0xf, 24,	\
> +		      CLK_MUX_ROUND_CLOSEST, a1_mst_sclk_pdata, 0)
> +#define AUD_TDM_SCLK_PRE_EN(_name, _reg)				\
> +	AUD_GATE(_name##_pre_en, _reg, 31,				\
> +		 aud_##_name##_sel, CLK_SET_RATE_PARENT)
> +#define AUD_TDM_SCLK_POST_EN(_name, _reg)				\
> +	AUD_GATE(_name##_post_en, _reg, 30,				\
> +		 aud_##_name##_pre_en, CLK_SET_RATE_PARENT)
> +#define AUD_TDM_SCLK_WS(_name, _reg)					\
> +	AUD_SCLK_WS(_name, _reg, 1, 29, 28,				\
> +		    aud_##_name##_post_en,				\
> +		    CLK_DUTY_CYCLE_PARENT | CLK_SET_RATE_PARENT)
> +
> +#define AUD_TDM_LRLCK(_name, _reg)					\
> +	AUD_MUX_TABLE(_name, _reg, a1_mst_lrclk_table, 0xf, 20,		\
> +		      CLK_MUX_ROUND_CLOSEST, a1_mst_lrclk_pdata,	\
> +		      CLK_SET_RATE_PARENT)
> +
> +struct clk_regmap aud_tdmin_a_sclk_sel =
> +	AUD_TDM_SCLK_MUX(tdmin_a_sclk, AUDIO_CLK_TDMIN_A_CTRL);
> +struct clk_regmap aud_tdmin_a_sclk_pre_en =
> +	AUD_TDM_SCLK_PRE_EN(tdmin_a_sclk, AUDIO_CLK_TDMIN_A_CTRL);
> +struct clk_regmap aud_tdmin_a_sclk_post_en =
> +	AUD_TDM_SCLK_POST_EN(tdmin_a_sclk, AUDIO_CLK_TDMIN_A_CTRL);
> +struct clk_regmap aud_tdmin_a_sclk =
> +	AUD_TDM_SCLK_WS(tdmin_a_sclk, AUDIO_CLK_TDMIN_A_CTRL);
> +struct clk_regmap aud_tdmin_a_lrclk =
> +	AUD_TDM_LRLCK(tdmin_a_lrclk, AUDIO_CLK_TDMIN_A_CTRL);
> +
> +struct clk_regmap aud_tdmin_b_sclk_sel =
> +	AUD_TDM_SCLK_MUX(tdmin_b_sclk, AUDIO_CLK_TDMIN_B_CTRL);
> +struct clk_regmap aud_tdmin_b_sclk_pre_en =
> +	AUD_TDM_SCLK_PRE_EN(tdmin_b_sclk, AUDIO_CLK_TDMIN_B_CTRL);
> +struct clk_regmap aud_tdmin_b_sclk_post_en =
> +	AUD_TDM_SCLK_POST_EN(tdmin_b_sclk, AUDIO_CLK_TDMIN_B_CTRL);
> +struct clk_regmap aud_tdmin_b_sclk =
> +	AUD_TDM_SCLK_WS(tdmin_b_sclk, AUDIO_CLK_TDMIN_B_CTRL);
> +struct clk_regmap aud_tdmin_b_lrclk =
> +	AUD_TDM_LRLCK(tdmin_b_lrclk, AUDIO_CLK_TDMIN_B_CTRL);
> +
> +struct clk_regmap aud_tdmin_lb_sclk_sel =
> +	AUD_TDM_SCLK_MUX(tdmin_lb_sclk, AUDIO_CLK_TDMIN_LB_CTRL);
> +struct clk_regmap aud_tdmin_lb_sclk_pre_en =
> +	AUD_TDM_SCLK_PRE_EN(tdmin_lb_sclk, AUDIO_CLK_TDMIN_LB_CTRL);
> +struct clk_regmap aud_tdmin_lb_sclk_post_en =
> +	AUD_TDM_SCLK_POST_EN(tdmin_lb_sclk, AUDIO_CLK_TDMIN_LB_CTRL);
> +struct clk_regmap aud_tdmin_lb_sclk =
> +	AUD_TDM_SCLK_WS(tdmin_lb_sclk, AUDIO_CLK_TDMIN_LB_CTRL);
> +struct clk_regmap aud_tdmin_lb_lrclk =
> +	AUD_TDM_LRLCK(tdmin_lb_lrclk, AUDIO_CLK_TDMIN_LB_CTRL);
> +
> +struct clk_regmap aud_tdmout_a_sclk_sel =
> +	AUD_TDM_SCLK_MUX(tdmout_a_sclk, AUDIO_CLK_TDMOUT_A_CTRL);
> +struct clk_regmap aud_tdmout_a_sclk_pre_en =
> +	AUD_TDM_SCLK_PRE_EN(tdmout_a_sclk, AUDIO_CLK_TDMOUT_A_CTRL);
> +struct clk_regmap aud_tdmout_a_sclk_post_en =
> +	AUD_TDM_SCLK_POST_EN(tdmout_a_sclk, AUDIO_CLK_TDMOUT_A_CTRL);
> +struct clk_regmap aud_tdmout_a_sclk =
> +	AUD_TDM_SCLK_WS(tdmout_a_sclk, AUDIO_CLK_TDMOUT_A_CTRL);
> +struct clk_regmap aud_tdmout_a_lrclk =
> +	AUD_TDM_LRLCK(tdmout_a_lrclk, AUDIO_CLK_TDMOUT_A_CTRL);
> +
> +struct clk_regmap aud_tdmout_b_sclk_sel =
> +	AUD_TDM_SCLK_MUX(tdmout_b_sclk, AUDIO_CLK_TDMOUT_B_CTRL);
> +struct clk_regmap aud_tdmout_b_sclk_pre_en =
> +	AUD_TDM_SCLK_PRE_EN(tdmout_b_sclk, AUDIO_CLK_TDMOUT_B_CTRL);
> +struct clk_regmap aud_tdmout_b_sclk_post_en =
> +	AUD_TDM_SCLK_POST_EN(tdmout_b_sclk, AUDIO_CLK_TDMOUT_B_CTRL);
> +struct clk_regmap aud_tdmout_b_sclk =
> +	AUD_TDM_SCLK_WS(tdmout_b_sclk, AUDIO_CLK_TDMOUT_B_CTRL);
> +struct clk_regmap aud_tdmout_b_lrclk =
> +	AUD_TDM_LRLCK(tdmout_b_lrclk, AUDIO_CLK_TDMOUT_B_CTRL);
> +
> +static struct clk_hw *a1_audio_hw_clks[] = {
> +	[AUD_CLKID_DDR_ARB]		= &aud_ddr_arb.hw,
> +	[AUD_CLKID_TDMIN_A]		= &aud_tdmin_a.hw,
> +	[AUD_CLKID_TDMIN_B]		= &aud_tdmin_b.hw,
> +	[AUD_CLKID_TDMIN_LB]		= &aud_tdmin_lb.hw,
> +	[AUD_CLKID_LOOPBACK]		= &aud_loopback.hw,
> +	[AUD_CLKID_TDMOUT_A]		= &aud_tdmout_a.hw,
> +	[AUD_CLKID_TDMOUT_B]		= &aud_tdmout_b.hw,
> +	[AUD_CLKID_FRDDR_A]		= &aud_frddr_a.hw,
> +	[AUD_CLKID_FRDDR_B]		= &aud_frddr_b.hw,
> +	[AUD_CLKID_TODDR_A]		= &aud_toddr_a.hw,
> +	[AUD_CLKID_TODDR_B]		= &aud_toddr_b.hw,
> +	[AUD_CLKID_SPDIFIN]		= &aud_spdifin.hw,
> +	[AUD_CLKID_RESAMPLE]		= &aud_resample.hw,
> +	[AUD_CLKID_EQDRC]		= &aud_eqdrc.hw,
> +	[AUD_CLKID_LOCKER]		= &aud_audiolocker.hw,
> +	[AUD_CLKID_MST_A_MCLK_SEL]	= &aud_mst_a_mclk_sel.hw,
> +	[AUD_CLKID_MST_A_MCLK_DIV]	= &aud_mst_a_mclk_div.hw,
> +	[AUD_CLKID_MST_A_MCLK]		= &aud_mst_a_mclk.hw,
> +	[AUD_CLKID_MST_B_MCLK_SEL]	= &aud_mst_b_mclk_sel.hw,
> +	[AUD_CLKID_MST_B_MCLK_DIV]	= &aud_mst_b_mclk_div.hw,
> +	[AUD_CLKID_MST_B_MCLK]		= &aud_mst_b_mclk.hw,
> +	[AUD_CLKID_MST_C_MCLK_SEL]	= &aud_mst_c_mclk_sel.hw,
> +	[AUD_CLKID_MST_C_MCLK_DIV]	= &aud_mst_c_mclk_div.hw,
> +	[AUD_CLKID_MST_C_MCLK]		= &aud_mst_c_mclk.hw,
> +	[AUD_CLKID_MST_D_MCLK_SEL]	= &aud_mst_d_mclk_sel.hw,
> +	[AUD_CLKID_MST_D_MCLK_DIV]	= &aud_mst_d_mclk_div.hw,
> +	[AUD_CLKID_MST_D_MCLK]		= &aud_mst_d_mclk.hw,
> +	[AUD_CLKID_RESAMPLE_CLK_SEL]	= &aud_resample_clk_sel.hw,
> +	[AUD_CLKID_RESAMPLE_CLK_DIV]	= &aud_resample_clk_div.hw,
> +	[AUD_CLKID_RESAMPLE_CLK]	= &aud_resample_clk.hw,
> +	[AUD_CLKID_LOCKER_IN_CLK_SEL]	= &aud_locker_in_clk_sel.hw,
> +	[AUD_CLKID_LOCKER_IN_CLK_DIV]	= &aud_locker_in_clk_div.hw,
> +	[AUD_CLKID_LOCKER_IN_CLK]	= &aud_locker_in_clk.hw,
> +	[AUD_CLKID_LOCKER_OUT_CLK_SEL]	= &aud_locker_out_clk_sel.hw,
> +	[AUD_CLKID_LOCKER_OUT_CLK_DIV]	= &aud_locker_out_clk_div.hw,
> +	[AUD_CLKID_LOCKER_OUT_CLK]	= &aud_locker_out_clk.hw,
> +	[AUD_CLKID_SPDIFIN_CLK_SEL]	= &aud_spdifin_clk_sel.hw,
> +	[AUD_CLKID_SPDIFIN_CLK_DIV]	= &aud_spdifin_clk_div.hw,
> +	[AUD_CLKID_SPDIFIN_CLK]		= &aud_spdifin_clk.hw,
> +	[AUD_CLKID_EQDRC_CLK_SEL]	= &aud_eqdrc_clk_sel.hw,
> +	[AUD_CLKID_EQDRC_CLK_DIV]	= &aud_eqdrc_clk_div.hw,
> +	[AUD_CLKID_EQDRC_CLK]		= &aud_eqdrc_clk.hw,
> +	[AUD_CLKID_MST_A_SCLK_PRE_EN]	= &aud_mst_a_sclk_pre_en.hw,
> +	[AUD_CLKID_MST_A_SCLK_DIV]	= &aud_mst_a_sclk_div.hw,
> +	[AUD_CLKID_MST_A_SCLK_POST_EN]	= &aud_mst_a_sclk_post_en.hw,
> +	[AUD_CLKID_MST_A_SCLK]		= &aud_mst_a_sclk.hw,
> +	[AUD_CLKID_MST_B_SCLK_PRE_EN]	= &aud_mst_b_sclk_pre_en.hw,
> +	[AUD_CLKID_MST_B_SCLK_DIV]	= &aud_mst_b_sclk_div.hw,
> +	[AUD_CLKID_MST_B_SCLK_POST_EN]	= &aud_mst_b_sclk_post_en.hw,
> +	[AUD_CLKID_MST_B_SCLK]		= &aud_mst_b_sclk.hw,
> +	[AUD_CLKID_MST_C_SCLK_PRE_EN]	= &aud_mst_c_sclk_pre_en.hw,
> +	[AUD_CLKID_MST_C_SCLK_DIV]	= &aud_mst_c_sclk_div.hw,
> +	[AUD_CLKID_MST_C_SCLK_POST_EN]	= &aud_mst_c_sclk_post_en.hw,
> +	[AUD_CLKID_MST_C_SCLK]		= &aud_mst_c_sclk.hw,
> +	[AUD_CLKID_MST_D_SCLK_PRE_EN]	= &aud_mst_d_sclk_pre_en.hw,
> +	[AUD_CLKID_MST_D_SCLK_DIV]	= &aud_mst_d_sclk_div.hw,
> +	[AUD_CLKID_MST_D_SCLK_POST_EN]	= &aud_mst_d_sclk_post_en.hw,
> +	[AUD_CLKID_MST_D_SCLK]		= &aud_mst_d_sclk.hw,
> +	[AUD_CLKID_MST_A_LRCLK_DIV]	= &aud_mst_a_lrclk_div.hw,
> +	[AUD_CLKID_MST_A_LRCLK]		= &aud_mst_a_lrclk.hw,
> +	[AUD_CLKID_MST_B_LRCLK_DIV]	= &aud_mst_b_lrclk_div.hw,
> +	[AUD_CLKID_MST_B_LRCLK]		= &aud_mst_b_lrclk.hw,
> +	[AUD_CLKID_MST_C_LRCLK_DIV]	= &aud_mst_c_lrclk_div.hw,
> +	[AUD_CLKID_MST_C_LRCLK]		= &aud_mst_c_lrclk.hw,
> +	[AUD_CLKID_MST_D_LRCLK_DIV]	= &aud_mst_d_lrclk_div.hw,
> +	[AUD_CLKID_MST_D_LRCLK]		= &aud_mst_d_lrclk.hw,
> +	[AUD_CLKID_TDMIN_A_SCLK_SEL]	= &aud_tdmin_a_sclk_sel.hw,
> +	[AUD_CLKID_TDMIN_A_SCLK_PRE_EN]	= &aud_tdmin_a_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMIN_A_SCLK_POST_EN] = &aud_tdmin_a_sclk_post_en.hw,
> +	[AUD_CLKID_TDMIN_A_SCLK]	= &aud_tdmin_a_sclk.hw,
> +	[AUD_CLKID_TDMIN_A_LRCLK]	= &aud_tdmin_a_lrclk.hw,
> +	[AUD_CLKID_TDMIN_B_SCLK_SEL]	= &aud_tdmin_b_sclk_sel.hw,
> +	[AUD_CLKID_TDMIN_B_SCLK_PRE_EN]	= &aud_tdmin_b_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMIN_B_SCLK_POST_EN] = &aud_tdmin_b_sclk_post_en.hw,
> +	[AUD_CLKID_TDMIN_B_SCLK]	= &aud_tdmin_b_sclk.hw,
> +	[AUD_CLKID_TDMIN_B_LRCLK]	= &aud_tdmin_b_lrclk.hw,
> +	[AUD_CLKID_TDMIN_LB_SCLK_SEL]	= &aud_tdmin_lb_sclk_sel.hw,
> +	[AUD_CLKID_TDMIN_LB_SCLK_PRE_EN] = &aud_tdmin_lb_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMIN_LB_SCLK_POST_EN] = &aud_tdmin_lb_sclk_post_en.hw,
> +	[AUD_CLKID_TDMIN_LB_SCLK]	= &aud_tdmin_lb_sclk.hw,
> +	[AUD_CLKID_TDMIN_LB_LRCLK]	= &aud_tdmin_lb_lrclk.hw,
> +	[AUD_CLKID_TDMOUT_A_SCLK_SEL]	= &aud_tdmout_a_sclk_sel.hw,
> +	[AUD_CLKID_TDMOUT_A_SCLK_PRE_EN] = &aud_tdmout_a_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMOUT_A_SCLK_POST_EN] = &aud_tdmout_a_sclk_post_en.hw,
> +	[AUD_CLKID_TDMOUT_A_SCLK]	= &aud_tdmout_a_sclk.hw,
> +	[AUD_CLKID_TDMOUT_A_LRCLK]	= &aud_tdmout_a_lrclk.hw,
> +	[AUD_CLKID_TDMOUT_B_SCLK_SEL]	= &aud_tdmout_b_sclk_sel.hw,
> +	[AUD_CLKID_TDMOUT_B_SCLK_PRE_EN] = &aud_tdmout_b_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMOUT_B_SCLK_POST_EN] = &aud_tdmout_b_sclk_post_en.hw,
> +	[AUD_CLKID_TDMOUT_B_SCLK]	= &aud_tdmout_b_sclk.hw,
> +	[AUD_CLKID_TDMOUT_B_LRCLK]	= &aud_tdmout_b_lrclk.hw,
> +};
> +
> +static struct clk_hw *a1_audio_vad_hw_clks[] = {
> +	[AUD_CLKID_VAD_DDR_ARB]		= &aud_vad_ddr_arb.hw,
> +	[AUD_CLKID_VAD_PDM]		= &aud_vad_pdm.hw,
> +	[AUD_CLKID_VAD_TDMIN]		= &aud_vad_tdmin_vad.hw,
> +	[AUD_CLKID_VAD_TODDR]		= &aud_vad_toddr_vad.hw,
> +	[AUD_CLKID_VAD]			= &aud_vad.hw,
> +	[AUD_CLKID_VAD_AUDIOTOP]	= &aud_vad_audiotop.hw,
> +	[AUD_CLKID_VAD_MCLK_SEL]	= &aud_vad_mclk_sel.hw,
> +	[AUD_CLKID_VAD_MCLK_DIV]	= &aud_vad_mclk_div.hw,
> +	[AUD_CLKID_VAD_MCLK]		= &aud_vad_mclk.hw,
> +	[AUD_CLKID_VAD_CLK_SEL]		= &aud_vad_clk_sel.hw,
> +	[AUD_CLKID_VAD_CLK_DIV]		= &aud_vad_clk_div.hw,
> +	[AUD_CLKID_VAD_CLK]		= &aud_vad_clk.hw,
> +	[AUD_CLKID_VAD_PDM_DCLK_SEL]	= &aud_vad_pdm_dclk_sel.hw,
> +	[AUD_CLKID_VAD_PDM_DCLK_DIV]	= &aud_vad_pdm_dclk_div.hw,
> +	[AUD_CLKID_VAD_PDM_DCLK]	= &aud_vad_pdm_dclk.hw,
> +	[AUD_CLKID_VAD_PDM_SYSCLK_SEL]	= &aud_vad_pdm_sysclk_sel.hw,
> +	[AUD_CLKID_VAD_PDM_SYSCLK_DIV]	= &aud_vad_pdm_sysclk_div.hw,
> +	[AUD_CLKID_VAD_PDM_SYSCLK]	= &aud_vad_pdm_sysclk.hw,
> +};

Again, I asked you to make separate driver for the a1 and a1-vad.

To be clear: different files for a1 and a1-vad.

> +
> +struct a1_audio_data {
> +	struct meson_clk_hw_data hw_clks;
> +	const char *reset_name;
> +};
> +
> +static const struct regmap_config a1_audio_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static int a1_audio_clkc_probe(struct platform_device *pdev)
> +{
> +	const struct a1_audio_data *data;
> +	struct regmap *map;
> +	void __iomem *base;
> +	struct clk *clk;
> +	unsigned int i;
> +	int ret;
> +
> +	data = of_device_get_match_data(&pdev->dev);
> +	if (!data)
> +		return -EINVAL;
> +
> +	clk = devm_clk_get_enabled(&pdev->dev, "pclk");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	map = devm_regmap_init_mmio(&pdev->dev, base, &a1_audio_regmap_cfg);
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	for (i = 0; i < data->hw_clks.num; i++) {
> +		struct clk_hw *hw = data->hw_clks.hws[i];
> +		struct clk_regmap *clk_regmap = to_clk_regmap(hw);
> +
> +		if (!hw)
> +			continue;
> +
> +		clk_regmap->map = map;
> +
> +		ret = devm_clk_hw_register(&pdev->dev, hw);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = devm_of_clk_add_hw_provider(&pdev->dev, meson_clk_hw_get,
> +					  (void *)&data->hw_clks);
> +	if (ret)
> +		return ret;
> +
> +	if (!data->reset_name)
> +		return 0;
> +
> +	return meson_audio_reset_register(&pdev->dev, data->reset_name);
> +}
> +
> +struct a1_audio_data a1_audio_data = {
> +	.hw_clks = {
> +		.hws = a1_audio_hw_clks,
> +		.num = ARRAY_SIZE(a1_audio_hw_clks),
> +	},
> +	.reset_name = "a1",
> +};
> +
> +struct a1_audio_data a1_audio_vad_data = {
> +	.hw_clks = {
> +		.hws = a1_audio_vad_hw_clks,
> +		.num = ARRAY_SIZE(a1_audio_vad_hw_clks),
> +	},
> +};
> +
> +static const struct of_device_id a1_audio_clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,a1-audio-clkc",
> +		.data = &a1_audio_data,
> +	},
> +	{
> +		.compatible = "amlogic,a1-audio-vad-clkc",
> +		.data = &a1_audio_vad_data,
> +	},
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
> diff --git a/drivers/reset/reset-meson-audio.c b/drivers/reset/reset-meson-audio.c
> index aaea9931cfe2..faf098012721 100644
> --- a/drivers/reset/reset-meson-audio.c
> +++ b/drivers/reset/reset-meson-audio.c
> @@ -145,6 +145,12 @@ static const struct meson_audio_reset_info meson_audio_reset_info_sm1 = {
>  	.reset_offset = 0x028,
>  	.reset_num = 39,
>  };
> +
> +static const struct meson_audio_reset_info meson_audio_reset_info_a1 = {
> +	.reset_offset = 0x028,
> +	.reset_num = 32,
> +};
> +
>  static const struct auxiliary_device_id meson_audio_reset_id[] = {
>  	{
>  		.name = "reset_meson_audio.g12a",
> @@ -154,6 +160,10 @@ static const struct auxiliary_device_id meson_audio_reset_id[] = {
>  		.name = "reset_meson_audio.sm1",
>  		.driver_data = (kernel_ulong_t)&meson_audio_reset_info_sm1,
>  	},
> +	{
> +		.name = "reset_meson_audio.a1",
> +		.driver_data = (kernel_ulong_t)&meson_audio_reset_info_a1,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(auxiliary, meson_audio_reset_id);


-- 
Jerome

