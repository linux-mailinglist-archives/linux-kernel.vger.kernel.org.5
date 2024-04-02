Return-Path: <linux-kernel+bounces-128215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B39E8957AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF2B1F23963
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E2512BF2E;
	Tue,  2 Apr 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B8qQwwaI"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B512BF1F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070183; cv=none; b=ZSKmglN4tYKHLWU95IcySMNHAzIrkoxMiqapfgq+RGjIj4929SKpy0ZTxp0vogI3bu9fIzdcL8vZK8ObrCrAMUTWVh4nBUPcbepB2o6562/yF/gBAG0SLG203wOlr5YmvrS40dC+va8LpmYfekCvI+9ikytrfI9U4DmNg93mC14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070183; c=relaxed/simple;
	bh=t33HnetIuTMNA6mvt1KzZej+sMFrQFQtO1K8CBZPrSc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=cFJ08NV/2U+mEZS88iAg7cIl+87kIESz389shBdKo2ays7rIMIJj3WQRUyZRYi9MjbJFWCWiZzLdsvjBHC8H06YlY5lgaK/Lvd2uFfVmNgoJR3uy66jPhWlfgFTB1iw3v112EptmaXq63vtNs3fJ9wJi98D1TYV9j1Vk5bcX77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B8qQwwaI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ddd1624beso3300045f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712070179; x=1712674979; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=QLh7C2qJ6VxpYlStd0L/XMk/c8rcOEZSbOF06Wx5dco=;
        b=B8qQwwaIXrxiO+aAI7DmotONMA1oK5ZQZFsevgnBuZPPyGYfdSjN41kd2mqQ+cy5Vj
         M8Rad7pIHmcntURHsFVGggmvfGO3+vIywIVnvYJ5uvPJjQ7YT46XXKyWwz+u0lGudEdq
         hCf1zG1XPcCHAfDNr0MvJrV0y0BYA0mfRNyERVIcQ1tyjgXqYNyqWglBELsqypt2jbdm
         qnEV9G9GfH6iWuQb+aFfdHY9fJUV7UOjMvYDr4G6ZJs3/H0dPk2pz5+i8+a59SunpwA2
         GbiDrnXgiNScfok8rFBhmazlHwteIKHQNkXJrv6sA3q4r9XlozQkRtqxvJkox7d7wybK
         uVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712070179; x=1712674979;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLh7C2qJ6VxpYlStd0L/XMk/c8rcOEZSbOF06Wx5dco=;
        b=iYejNQQL8oXtYd/two/LgJJ6jdBUy4feIL+lchQsGhlgKJe/aV9WRKIfQlPKAva21L
         bxmatkSXck+9d84hXfRTc8ejH5gDxCWdiPLBWIBv28Bfc/Ihrh24d6zN/oYBGCgHbtRW
         /N1i9yCmakbJ/96poQFLL/KSCgZmKSDcWn+Bem1s7BIjkngC/tmNGea8R+1kSk+sNt+e
         XOcgaDdt7VNghaQFKxrsyj9BgfkWPYvBpgeTZNslFxlZElyZ5n9X+418ItebziqC0jG9
         7JvH5uFRiK9YDl3W0USshh7p+5QhhtG6pCRxTj1l+mryuo+SeHiDBV45vgpSD7K5hHCJ
         ybMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIDMf8Uqtl72rW+w9j+GVbC9T8jL1LDe8TFW0h8dhZEqrkW5b7oq2ka3rcUtUltTtxnQ2EEPB7ruAfjocbKTFp0O7ayWmUDU6N9RJS
X-Gm-Message-State: AOJu0Yy3VrLD8J1BmwNmaYvOJe3RdbVE2r1RxcDTrPPUnOE16Bjye3Z+
	CpPSud915DnrQAZr4Cvjqh1yX43FQGrPdcfkz0ff00rxC5kuknKIdaK0zl2OB4M=
X-Google-Smtp-Source: AGHT+IFSgmTd7GB48ZrNjEll1HvnPHtsZpacbfK6tP4nSa5dMUnTT0fGb12JJu2ZFMMjgqoK6U2wzw==
X-Received: by 2002:a5d:5886:0:b0:341:d316:3336 with SMTP id n6-20020a5d5886000000b00341d3163336mr15804446wrf.12.1712070178886;
        Tue, 02 Apr 2024 08:02:58 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:2b3:4f20:7b45:be58])
        by smtp.gmail.com with ESMTPSA id ay33-20020a05600c1e2100b004156a816048sm5381157wmb.35.2024.04.02.08.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 08:02:58 -0700 (PDT)
References: <20240328010831.884487-1-jan.dakinevich@salutedevices.com>
 <20240328010831.884487-2-jan.dakinevich@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
 <jbrunet@baylibre.com>, Michael  Turquette <mturquette@baylibre.com>, Rob
  Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 1/5] clk: meson: axg: move reset controller's
 code to separate module
Date: Tue, 02 Apr 2024 16:52:38 +0200
In-reply-to: <20240328010831.884487-2-jan.dakinevich@salutedevices.com>
Message-ID: <1j7chfiz8e.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Thu 28 Mar 2024 at 04:08, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:

> This code will by reused by A1 SoC.

Could expand a bit please ?

>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>

In general, I like the idea.

We do have a couple a reset registers lost in middle of clocks and this
change makes it possible to re-use the code instead duplicating it.

The exported function would be used by audio clock controllers, but the
module created would be purely about reset.

One may wonder how it ended up in the clock tree, especially since the
kernel as a reset tree too.

I'm not sure if this should move to the reset framework or if it would
be an unnecessary churn. Stephen, Philipp, do you have an opinion on
this ?

> ---
>  drivers/clk/meson/Kconfig            |   5 ++
>  drivers/clk/meson/Makefile           |   1 +
>  drivers/clk/meson/axg-audio.c        |  95 +----------------------
>  drivers/clk/meson/meson-audio-rstc.c | 109 +++++++++++++++++++++++++++
>  drivers/clk/meson/meson-audio-rstc.h |  12 +++
>  5 files changed, 130 insertions(+), 92 deletions(-)
>  create mode 100644 drivers/clk/meson/meson-audio-rstc.c
>  create mode 100644 drivers/clk/meson/meson-audio-rstc.h
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 29ffd14d267b..d6a2fa5f7e88 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -48,6 +48,10 @@ config COMMON_CLK_MESON_CPU_DYNDIV
>  	tristate
>  	select COMMON_CLK_MESON_REGMAP
>  
> +config COMMON_CLK_MESON_AUDIO_RSTC
> +	tristate
> +	select RESET_CONTROLLER
> +
>  config COMMON_CLK_MESON8B
>  	bool "Meson8 SoC Clock controller support"
>  	depends on ARM
> @@ -101,6 +105,7 @@ config COMMON_CLK_AXG_AUDIO
>  	select COMMON_CLK_MESON_PHASE
>  	select COMMON_CLK_MESON_SCLK_DIV
>  	select COMMON_CLK_MESON_CLKC_UTILS
> +	select COMMON_CLK_MESON_AUDIO_RSTC
>  	select REGMAP_MMIO
>  	help
>  	  Support for the audio clock controller on AmLogic A113D devices,
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 9ee4b954c896..88d94921a4dc 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_PLL) += clk-pll.o
>  obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) += clk-regmap.o
>  obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) += sclk-div.o
>  obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) += vid-pll-div.o
> +obj-$(CONFIG_COMMON_CLK_MESON_AUDIO_RSTC) += meson-audio-rstc.o
>  
>  # Amlogic Clock controllers
>  
> diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
> index ac3482960903..990203a7ad5c 100644
> --- a/drivers/clk/meson/axg-audio.c
> +++ b/drivers/clk/meson/axg-audio.c
> @@ -12,10 +12,10 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> -#include <linux/reset-controller.h>
>  #include <linux/slab.h>
>  
>  #include "meson-clkc-utils.h"
> +#include "meson-audio-rstc.h"
>  #include "axg-audio.h"
>  #include "clk-regmap.h"
>  #include "clk-phase.h"
> @@ -1648,84 +1648,6 @@ static struct clk_regmap *const sm1_clk_regmaps[] = {
>  	&sm1_sysclk_b_en,
>  };
>  
> -struct axg_audio_reset_data {
> -	struct reset_controller_dev rstc;
> -	struct regmap *map;
> -	unsigned int offset;
> -};
> -
> -static void axg_audio_reset_reg_and_bit(struct axg_audio_reset_data *rst,
> -					unsigned long id,
> -					unsigned int *reg,
> -					unsigned int *bit)
> -{
> -	unsigned int stride = regmap_get_reg_stride(rst->map);
> -
> -	*reg = (id / (stride * BITS_PER_BYTE)) * stride;
> -	*reg += rst->offset;
> -	*bit = id % (stride * BITS_PER_BYTE);
> -}
> -
> -static int axg_audio_reset_update(struct reset_controller_dev *rcdev,
> -				unsigned long id, bool assert)
> -{
> -	struct axg_audio_reset_data *rst =
> -		container_of(rcdev, struct axg_audio_reset_data, rstc);
> -	unsigned int offset, bit;
> -
> -	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
> -
> -	regmap_update_bits(rst->map, offset, BIT(bit),
> -			assert ? BIT(bit) : 0);
> -
> -	return 0;
> -}
> -
> -static int axg_audio_reset_status(struct reset_controller_dev *rcdev,
> -				unsigned long id)
> -{
> -	struct axg_audio_reset_data *rst =
> -		container_of(rcdev, struct axg_audio_reset_data, rstc);
> -	unsigned int val, offset, bit;
> -
> -	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
> -
> -	regmap_read(rst->map, offset, &val);
> -
> -	return !!(val & BIT(bit));
> -}
> -
> -static int axg_audio_reset_assert(struct reset_controller_dev *rcdev,
> -				unsigned long id)
> -{
> -	return axg_audio_reset_update(rcdev, id, true);
> -}
> -
> -static int axg_audio_reset_deassert(struct reset_controller_dev *rcdev,
> -				unsigned long id)
> -{
> -	return axg_audio_reset_update(rcdev, id, false);
> -}
> -
> -static int axg_audio_reset_toggle(struct reset_controller_dev *rcdev,
> -				unsigned long id)
> -{
> -	int ret;
> -
> -	ret = axg_audio_reset_assert(rcdev, id);
> -	if (ret)
> -		return ret;
> -
> -	return axg_audio_reset_deassert(rcdev, id);
> -}
> -
> -static const struct reset_control_ops axg_audio_rstc_ops = {
> -	.assert = axg_audio_reset_assert,
> -	.deassert = axg_audio_reset_deassert,
> -	.reset = axg_audio_reset_toggle,
> -	.status = axg_audio_reset_status,
> -};
> -
>  static const struct regmap_config axg_audio_regmap_cfg = {
>  	.reg_bits	= 32,
>  	.val_bits	= 32,
> @@ -1745,7 +1667,6 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	const struct audioclk_data *data;
> -	struct axg_audio_reset_data *rst;
>  	struct regmap *map;
>  	void __iomem *regs;
>  	struct clk_hw *hw;
> @@ -1807,18 +1728,8 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>  	if (!data->reset_num)
>  		return 0;
>  
> -	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
> -	if (!rst)
> -		return -ENOMEM;
> -
> -	rst->map = map;
> -	rst->offset = data->reset_offset;
> -	rst->rstc.nr_resets = data->reset_num;
> -	rst->rstc.ops = &axg_audio_rstc_ops;
> -	rst->rstc.of_node = dev->of_node;
> -	rst->rstc.owner = THIS_MODULE;
> -
> -	return devm_reset_controller_register(dev, &rst->rstc);
> +	return meson_audio_rstc_register(dev, map, data->reset_offset,
> +					 data->reset_num);
>  }
>  
>  static const struct audioclk_data axg_audioclk_data = {
> diff --git a/drivers/clk/meson/meson-audio-rstc.c b/drivers/clk/meson/meson-audio-rstc.c
> new file mode 100644
> index 000000000000..2079d24c40f4
> --- /dev/null
> +++ b/drivers/clk/meson/meson-audio-rstc.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2018 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +#include <linux/reset-controller.h>
> +
> +#include "meson-audio-rstc.h"
> +
> +struct meson_audio_reset_data {
> +	struct reset_controller_dev rstc;
> +	struct regmap *map;
> +	unsigned int offset;
> +};
> +
> +static void meson_audio_reset_reg_and_bit(struct meson_audio_reset_data *rst,
> +					  unsigned long id,
> +					  unsigned int *reg,
> +					  unsigned int *bit)
> +{
> +	unsigned int stride = regmap_get_reg_stride(rst->map);
> +
> +	*reg = (id / (stride * BITS_PER_BYTE)) * stride;
> +	*reg += rst->offset;
> +	*bit = id % (stride * BITS_PER_BYTE);
> +}
> +
> +static int meson_audio_reset_update(struct reset_controller_dev *rcdev,
> +				    unsigned long id, bool assert)
> +{
> +	struct meson_audio_reset_data *rst =
> +		container_of(rcdev, struct meson_audio_reset_data, rstc);
> +	unsigned int offset, bit;
> +
> +	meson_audio_reset_reg_and_bit(rst, id, &offset, &bit);
> +
> +	regmap_update_bits(rst->map, offset, BIT(bit),
> +			assert ? BIT(bit) : 0);
> +
> +	return 0;
> +}
> +
> +static int meson_audio_reset_status(struct reset_controller_dev *rcdev,
> +				    unsigned long id)
> +{
> +	struct meson_audio_reset_data *rst =
> +		container_of(rcdev, struct meson_audio_reset_data, rstc);
> +	unsigned int val, offset, bit;
> +
> +	meson_audio_reset_reg_and_bit(rst, id, &offset, &bit);
> +
> +	regmap_read(rst->map, offset, &val);
> +
> +	return !!(val & BIT(bit));
> +}
> +
> +static int meson_audio_reset_assert(struct reset_controller_dev *rcdev,
> +				    unsigned long id)
> +{
> +	return meson_audio_reset_update(rcdev, id, true);
> +}
> +
> +static int meson_audio_reset_deassert(struct reset_controller_dev *rcdev,
> +				      unsigned long id)
> +{
> +	return meson_audio_reset_update(rcdev, id, false);
> +}
> +
> +static int meson_audio_reset_toggle(struct reset_controller_dev *rcdev,
> +				    unsigned long id)
> +{
> +	int ret;
> +
> +	ret = meson_audio_reset_assert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	return meson_audio_reset_deassert(rcdev, id);
> +}
> +
> +static const struct reset_control_ops meson_audio_rstc_ops = {
> +	.assert = meson_audio_reset_assert,
> +	.deassert = meson_audio_reset_deassert,
> +	.reset = meson_audio_reset_toggle,
> +	.status = meson_audio_reset_status,
> +};
> +
> +int meson_audio_rstc_register(struct device *dev, struct regmap *map,
> +			      unsigned int offset, unsigned int num)
> +{
> +	struct meson_audio_reset_data *rst;
> +
> +	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
> +	if (!rst)
> +		return -ENOMEM;
> +
> +	rst->map = map;
> +	rst->offset = offset;
> +	rst->rstc.nr_resets = num;
> +	rst->rstc.ops = &meson_audio_rstc_ops;
> +	rst->rstc.of_node = dev->of_node;
> +	rst->rstc.owner = THIS_MODULE;
> +
> +	return devm_reset_controller_register(dev, &rst->rstc);
> +}
> +EXPORT_SYMBOL_GPL(meson_audio_rstc_register);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/meson/meson-audio-rstc.h b/drivers/clk/meson/meson-audio-rstc.h
> new file mode 100644
> index 000000000000..6b441549de03
> --- /dev/null
> +++ b/drivers/clk/meson/meson-audio-rstc.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +
> +#ifndef __MESON_AUDIO_RSTC_H
> +#define __MESON_AUDIO_RSTC_H
> +
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +
> +int meson_audio_rstc_register(struct device *dev, struct regmap *map,
> +			      unsigned int offset, unsigned int num);
> +
> +#endif /* __MESON_AUDIO_RSTC_H */


-- 
Jerome

