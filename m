Return-Path: <linux-kernel+bounces-59531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A63F484F87F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9A61C23613
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D8674E0D;
	Fri,  9 Feb 2024 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZMdRkXun";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="NHdfTeyb"
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C677973174;
	Fri,  9 Feb 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492439; cv=pass; b=nJV0/s0o75uyv8M/ve4Ue3wbJpgpquD77IFFoiP2IhsPBlS40iKXvBBDNMFWytoafikzDLQrovl3pmHPstrF+D3iPPen4HmRkbJH8JBHuxDX3yCXP2WUK2viOI6OmJCxT9W0lGgRmYLyGg7WWSS4pjPEW8AQKXTTTLEVkHWpQOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492439; c=relaxed/simple;
	bh=5vF8TP1VdhNMnw/i+6np2B5Xn1tcBWZb1cdWNMNfe8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5s8oSWpAsG78WErniNDxErqknVXemJs25F04UYYk5fDs9JD0IwJphy8SQypuahTkBOvmJK1SmleycvxJkqd/hUYRhbNSKjhhYnbeO52EWCFkgafy6vAvlkxNY5wsyIM3vP7ZmsG5uMCYs0Po63254fuLBXgj78LujN+7ehDi+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZMdRkXun; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=NHdfTeyb; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4TWd4w1sn8z49PyQ;
	Fri,  9 Feb 2024 17:27:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1707492432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2Y2JN3RgbFm8F615uDqcaEOP9QdKs1NC0mYOwdz9kA=;
	b=ZMdRkXunyOsvN7orz24ii2RWqjSf2gHyAZYbZX9bAIoFsIBl4oZtAUxQQnHGHqqwasLMA5
	xpuAcVCHwAsYbBCfQBxJXPtwdt/wmOR7yEl83LlH74kPOSJ5Nh5Go1IxFkc1/wOJPbTOzO
	p6du8YJjEYBdURtaFKOgQeONvwfZQlGt5kWde8d0Rfx5f94uAg9xAf861bIQkvNdm94wev
	ungM8Xh0XryJtF3q1g2tJ0I0I5NAA3o+tHgErlUMVmUOLrui/5N1UZXfo2XIznDutcggNP
	4cd+fD6Q7WNYcr5Vids/SkPXelhTFl330n49G+Z+4qL9s9QvezYxJJP1DBz3RQ==
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TWd4j4D1HzyQB;
	Fri,  9 Feb 2024 17:27:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1707492423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2Y2JN3RgbFm8F615uDqcaEOP9QdKs1NC0mYOwdz9kA=;
	b=NHdfTeybeUzcxuhxw0tIPX5iSJaZNZnrDTjKs0zK6tao5sI99hrvW7NjAvrLq+9SfeSFeu
	O5GgLrp7lKKgD2f7iKR8R/POk+fi9lwB5XIAei4V4e7qSNr38MSjD7Z1/RJK/3J3qWQPdZ
	DAQQ+Up1Nc4gApbt0wh19C6a9OPCulw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1707492423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L2Y2JN3RgbFm8F615uDqcaEOP9QdKs1NC0mYOwdz9kA=;
	b=JZtFSfLZJpvXH7jM3ts6f9kOMyJ+L/F4qq+zTbNczzCYW0hh5c6Dy/rtlSiNIAMCIU16y6
	Wp6SYJcK/c5DgCUxthO5/yrhzVPCrBAvh4h/+3Rwq6OnseBPkhUE4Noi5VvesFFSIRyxvW
	IQbAuv/8fOBR6rIrCRg0gIXOzYNecPI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1707492423; a=rsa-sha256; cv=none;
	b=xTwjVTXA3FDb9vFFWE7qsLpt3aqStyINUlXvQotIzq0Gmn6xua6WCl30VpHUl4A6Vs/3EQ
	Wscf0qS/r4hvRfNmnT2Iz93VilqzKIzUj/M1JRQ2kfzgmGWgDq28uyRMqHONMMpCt9NrsG
	kYnLEp85iDQBiNjBvrjJUQQ8VcamGJg=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id F362A634C94;
	Fri,  9 Feb 2024 17:26:59 +0200 (EET)
Date: Fri, 9 Feb 2024 15:26:59 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 3/4] media: i2c: add MAX96717 driver
Message-ID: <ZcZEQyCb2FBsmbsK@valkosipuli.retiisi.eu>
References: <20240111130349.2776699-1-julien.massot@collabora.com>
 <20240111130349.2776699-4-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111130349.2776699-4-julien.massot@collabora.com>

Hi Julien,

On Thu, Jan 11, 2024 at 02:03:48PM +0100, Julien Massot wrote:
> This driver handle the MAX96717 serializer in tunnel mode.
> All incoming CSI traffic will be tunneled through the GMSL2
> link.
> 
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> ---
> Change since v2:
>  - Use CCI helpers instead of recoding register access
>  - add missing bitfield header
> ---
>  MAINTAINERS                  |   7 +
>  drivers/media/i2c/Kconfig    |  13 +
>  drivers/media/i2c/Makefile   |   1 +
>  drivers/media/i2c/max96717.c | 956 +++++++++++++++++++++++++++++++++++
>  4 files changed, 977 insertions(+)
>  create mode 100644 drivers/media/i2c/max96717.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 675e5d63a25b..a64a7932fe76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13039,6 +13039,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/i2c/maxim,max96712.yaml
>  F:	drivers/staging/media/max96712/max96712.c
>  
> +MAX96717 GMSL2 SERIALIZER DRIVER
> +M:	Julien Massot <julien.massot@collabora.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/media/i2c/maxim,max96717f.yaml

What's that "f" for? It's in bindings but not in the name of the driver.
Not a typo I suppose? :-)

> +F:	drivers/media/i2c/max96717.c
> +
>  MAX9860 MONO AUDIO VOICE CODEC DRIVER
>  M:	Peter Rosin <peda@axentia.se>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index 78a87331686e..64f6a35f4481 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -1570,6 +1570,19 @@ config VIDEO_DS90UB960
>  	  Device driver for the Texas Instruments DS90UB960
>  	  FPD-Link III Deserializer and DS90UB9702 FPD-Link IV Deserializer.
>  
> +config VIDEO_MAX96717
> +	tristate "Maxim MAX96717 GMSL2 Serializer support"
> +	depends on OF && I2C && VIDEO_DEV && COMMON_CLK
> +	select I2C_MUX
> +	select GPIOLIB
> +	select V4L2_CCI_I2C
> +	help
> +	  Device driver for the Maxim MAX96717
> +	  GMSL2 Serializer.

Fits on the previous line.

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called max96717.
> +
>  endmenu
>  
>  endif # VIDEO_DEV
> diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
> index dfbe6448b549..9e007116f929 100644
> --- a/drivers/media/i2c/Makefile
> +++ b/drivers/media/i2c/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_VIDEO_LM3646) += lm3646.o
>  obj-$(CONFIG_VIDEO_M52790) += m52790.o
>  obj-$(CONFIG_VIDEO_MAX9271_LIB) += max9271.o
>  obj-$(CONFIG_VIDEO_MAX9286) += max9286.o
> +obj-$(CONFIG_VIDEO_MAX96717) += max96717.o
>  obj-$(CONFIG_VIDEO_ML86V7667) += ml86v7667.o
>  obj-$(CONFIG_VIDEO_MSP3400) += msp3400.o
>  obj-$(CONFIG_VIDEO_MT9M001) += mt9m001.o
> diff --git a/drivers/media/i2c/max96717.c b/drivers/media/i2c/max96717.c
> new file mode 100644
> index 000000000000..700e50894250
> --- /dev/null
> +++ b/drivers/media/i2c/max96717.c
> @@ -0,0 +1,956 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Maxim GMSL2 Serializer Driver
> + *
> + * Copyright (C) 2024 Collabora Ltd.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/fwnode.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/i2c-mux.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +#include <media/v4l2-cci.h>
> +#include <media/v4l2-fwnode.h>
> +#include <media/v4l2-subdev.h>
> +
> +#define MAX96717F_DEVICE_ID 0xc8
> +#define MAX96717_PORTS      2
> +#define MAX96717_PAD_SINK   0
> +#define MAX96717_PAD_SOURCE 1
> +
> +#define MAX96717_DEFAULT_CLKOUT_RATE	24000000UL
> +
> +/* DEV */
> +#define REG3             CCI_REG8(0x3)
> +#define MAX96717_RCLKSEL GENMASK(1, 0)
> +#define RCLKSEL_REF_PLL  CCI_REG8(0x3)
> +#define MAX96717_REG6    CCI_REG8(0x6)
> +#define RCLKEN           BIT(5)
> +#define MAX96717_DEV_ID  CCI_REG8(0xd)
> +#define MAX96717_DEV_REV CCI_REG8(0xe)
> +#define MAX96717_DEV_REV_MASK GENMASK(3, 0)
> +
> +/* VID_TX Z */
> +#define MAX96717_VIDEO_TX2 CCI_REG8(0x112)
> +#define MAX96717_VIDEO_PCLKDET BIT(7)
> +
> +/* GPIO */
> +#define MAX96717_NUM_GPIO         11
> +#define MAX96717_GPIO_REG_A(gpio) CCI_REG8(0x2be + (gpio) * 3)
> +#define MAX96717_GPIO_OUT         BIT(4)
> +#define MAX96717_GPIO_IN          BIT(3)
> +#define MAX96717_GPIO_RX_EN       BIT(2)
> +#define MAX96717_GPIO_TX_EN       BIT(1)
> +#define MAX96717_GPIO_OUT_DIS     BIT(0)
> +
> +/* FRONTTOP */
> +/* MAX96717 only have CSI port 'B' */
> +#define MAX96717_FRONTOP0     CCI_REG8(0x308)
> +#define MAX96717_START_PORT_B BIT(5)
> +
> +/* MIPI_RX */
> +#define MAX96717_MIPI_RX1       CCI_REG8(0x331)
> +#define MAX96717_MIPI_LANES_CNT GENMASK(5, 4)
> +#define MAX96717_MIPI_RX2       CCI_REG8(0x332) /* phy1 Lanes map */
> +#define MAX96717_PHY2_LANES_MAP GENMASK(7, 4)
> +#define MAX96717_MIPI_RX3       CCI_REG8(0x333) /* phy2 Lanes map */
> +#define MAX96717_PHY1_LANES_MAP GENMASK(3, 0)
> +#define MAX96717_MIPI_RX4       CCI_REG8(0x334) /* phy1 lane polarities */
> +#define MAX96717_PHY1_LANES_POL GENMASK(6, 4)
> +#define MAX96717_MIPI_RX5       CCI_REG8(0x335) /* phy2 lane polarities */
> +#define MAX96717_PHY2_LANES_POL GENMASK(2, 0)
> +
> +/* MIPI_RX_EXT */
> +#define MAX96717_MIPI_RX_EXT11 CCI_REG8(0x383)
> +#define MAX96717_TUN_MODE      BIT(7)
> +
> +/* REF_VTG */
> +#define REF_VTG0                CCI_REG8(0x3f0)
> +#define REFGEN_PREDEF_EN        BIT(6)
> +#define REFGEN_PREDEF_FREQ_MASK GENMASK(5, 4)
> +#define REFGEN_PREDEF_FREQ_ALT  BIT(3)
> +#define REFGEN_RST              BIT(1)
> +#define REFGEN_EN               BIT(0)
> +
> +/* MISC */
> +#define PIO_SLEW_1 CCI_REG8(0x570)
> +
> +struct max96717_hw_data {
> +	const char *model;
> +	u8 device_id;
> +};
> +
> +static const struct max96717_hw_data max96717f_data = {
> +	.model = "max96717f",
> +	.device_id = MAX96717F_DEVICE_ID,
> +};
> +
> +struct max96717_priv {
> +	const struct max96717_hw_data *data;
> +	struct i2c_client             *client;
> +	struct regmap                 *regmap;
> +	struct i2c_mux_core           *mux;
> +	struct v4l2_fwnode_endpoint   vep;
> +	struct v4l2_subdev            sd;
> +	struct media_pad              pads[MAX96717_PORTS];
> +	struct v4l2_async_notifier    notifier;
> +	struct v4l2_subdev            *source_sd;
> +	u16                           source_sd_pad;
> +	u64			      enabled_source_streams;
> +	u8                            pll_predef_index;
> +	struct clk_hw                 clk_hw;
> +	struct gpio_chip              gpio_chip;
> +};
> +
> +static inline struct max96717_priv *sd_to_max96717(struct v4l2_subdev *sd)
> +{
> +	return container_of(sd, struct max96717_priv, sd);
> +}
> +
> +static inline struct max96717_priv *clk_hw_to_max96717(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct max96717_priv, clk_hw);
> +}
> +
> +static int max96717_i2c_mux_select(struct i2c_mux_core *mux, u32 chan)
> +{
> +	return 0;
> +}
> +
> +static int max96717_i2c_mux_init(struct max96717_priv *priv)
> +{
> +	priv->mux = i2c_mux_alloc(priv->client->adapter, &priv->client->dev,
> +				  1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
> +				  max96717_i2c_mux_select, NULL);
> +	if (!priv->mux)
> +		return -ENOMEM;
> +
> +	return i2c_mux_add_adapter(priv->mux, 0, 0, 0);
> +}
> +
> +static inline int max96717_start_csi(struct max96717_priv *priv, bool start)
> +{
> +	return cci_update_bits(priv->regmap, MAX96717_FRONTOP0,
> +			       MAX96717_START_PORT_B,
> +			       start ? MAX96717_START_PORT_B : 0, NULL);
> +}
> +
> +static int max96717_gpiochip_get(struct gpio_chip *gpiochip,
> +				 unsigned int offset)
> +{
> +	struct max96717_priv *priv = gpiochip_get_data(gpiochip);
> +	u64 val;
> +	int ret;
> +
> +	ret = cci_read(priv->regmap, MAX96717_GPIO_REG_A(offset),
> +		       &val, NULL);
> +	if (ret)
> +		return ret;
> +
> +	if (val & MAX96717_GPIO_OUT_DIS)
> +		return !!(val & MAX96717_GPIO_IN);
> +	else
> +		return !!(val & MAX96717_GPIO_OUT);
> +}
> +
> +static void max96717_gpiochip_set(struct gpio_chip *gpiochip,
> +				  unsigned int offset, int value)
> +{
> +	struct max96717_priv *priv = gpiochip_get_data(gpiochip);
> +
> +	cci_update_bits(priv->regmap, MAX96717_GPIO_REG_A(offset),
> +			MAX96717_GPIO_OUT, MAX96717_GPIO_OUT, NULL);
> +}
> +
> +static int max96717_gpio_get_direction(struct gpio_chip *gpiochip,
> +				       unsigned int offset)
> +{
> +	struct max96717_priv *priv = gpiochip_get_data(gpiochip);
> +	u64 val;
> +	int ret;
> +
> +	ret = cci_read(priv->regmap, MAX96717_GPIO_REG_A(offset), &val, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	return !!(val & MAX96717_GPIO_OUT_DIS);
> +}
> +
> +static int max96717_gpio_direction_out(struct gpio_chip *gpiochip,
> +				       unsigned int offset, int value)
> +{
> +	struct max96717_priv *priv = gpiochip_get_data(gpiochip);
> +
> +	return cci_update_bits(priv->regmap, MAX96717_GPIO_REG_A(offset),
> +			       MAX96717_GPIO_OUT_DIS | MAX96717_GPIO_OUT,
> +			       value ? MAX96717_GPIO_OUT : 0, NULL);
> +}
> +
> +static int max96717_gpio_direction_in(struct gpio_chip *gpiochip,
> +				      unsigned int offset)
> +{
> +	struct max96717_priv *priv = gpiochip_get_data(gpiochip);
> +
> +	return cci_update_bits(priv->regmap, MAX96717_GPIO_REG_A(offset),
> +			       MAX96717_GPIO_OUT_DIS, MAX96717_GPIO_OUT_DIS,
> +			       NULL);
> +}
> +
> +static int max96717_gpiochip_probe(struct max96717_priv *priv)
> +{
> +	struct device *dev = &priv->client->dev;
> +	struct gpio_chip *gc = &priv->gpio_chip;
> +	int ret, i;
> +
> +	gc->label = dev_name(dev);
> +	gc->parent = dev;
> +	gc->owner = THIS_MODULE;
> +	gc->ngpio = MAX96717_NUM_GPIO;
> +	gc->base = -1;
> +	gc->can_sleep = true;
> +	gc->get_direction = max96717_gpio_get_direction;
> +	gc->direction_input = max96717_gpio_direction_in;
> +	gc->direction_output = max96717_gpio_direction_out;
> +	gc->set = max96717_gpiochip_set;
> +	gc->get = max96717_gpiochip_get;
> +	gc->of_gpio_n_cells = 2;
> +
> +	/* Disable GPIO forwarding */
> +	for (i = 0; i < gc->ngpio; i++)
> +		cci_update_bits(priv->regmap, MAX96717_GPIO_REG_A(i),
> +				MAX96717_GPIO_RX_EN | MAX96717_GPIO_TX_EN,
> +				0, &ret);
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_gpiochip_add_data(dev, gc, priv);
> +	if (ret) {
> +		dev_err(dev, "Unable to create gpio_chip\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int _max96717_set_routing(struct v4l2_subdev *sd,
> +				 struct v4l2_subdev_state *state,
> +				 struct v4l2_subdev_krouting *routing)
> +{
> +	static const struct v4l2_mbus_framefmt format = {
> +		.width = 1280,
> +		.height = 1080,
> +		.code = MEDIA_BUS_FMT_Y8_1X8,
> +		.field = V4L2_FIELD_NONE,
> +	};
> +	int ret;
> +
> +	ret = v4l2_subdev_routing_validate(sd, routing,
> +					   V4L2_SUBDEV_ROUTING_ONLY_1_TO_1);
> +	if (ret)
> +		return ret;
> +
> +	ret = v4l2_subdev_set_routing_with_fmt(sd, state, routing, &format);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int max96717_set_routing(struct v4l2_subdev *sd,
> +				struct v4l2_subdev_state *state,
> +				enum v4l2_subdev_format_whence which,
> +				struct v4l2_subdev_krouting *routing)
> +{
> +	struct max96717_priv *priv = sd_to_max96717(sd);
> +
> +	if (which == V4L2_SUBDEV_FORMAT_ACTIVE && priv->enabled_source_streams)
> +		return -EBUSY;
> +
> +	return _max96717_set_routing(sd, state, routing);
> +}
> +
> +static int max96717_set_fmt(struct v4l2_subdev *sd,
> +			    struct v4l2_subdev_state *state,
> +			    struct v4l2_subdev_format *format)
> +{
> +	struct max96717_priv *priv = sd_to_max96717(sd);
> +	struct v4l2_mbus_framefmt *fmt;
> +	u64 stream_source_mask;
> +
> +	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE &&
> +	    priv->enabled_source_streams)
> +		return -EBUSY;
> +
> +	/* No transcoding, source and sink formats must match. */
> +	if (format->pad == MAX96717_PAD_SOURCE)
> +		return v4l2_subdev_get_fmt(sd, state, format);
> +
> +	/* Set sink format */
> +	fmt = v4l2_subdev_state_get_format(state, format->pad, format->stream);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	*fmt = format->format;
> +
> +	/* Propagate to source format */
> +	fmt = v4l2_subdev_state_get_opposite_stream_format(state, format->pad,
> +							   format->stream);
> +	if (!fmt)
> +		return -EINVAL;
> +	*fmt = format->format;
> +
> +	stream_source_mask = BIT(format->stream);
> +
> +	return v4l2_subdev_state_xlate_streams(state, MAX96717_PAD_SOURCE,
> +					       MAX96717_PAD_SINK,
> +					       &stream_source_mask);
> +}
> +
> +static int max96717_init_state(struct v4l2_subdev *sd,
> +			       struct v4l2_subdev_state *state)
> +{
> +	struct v4l2_subdev_route routes[] = {
> +		{
> +			.sink_pad = MAX96717_PAD_SINK,
> +			.sink_stream = 0,
> +			.source_pad = MAX96717_PAD_SOURCE,
> +			.source_stream = 0,
> +			.flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE,
> +		},
> +	};
> +

Extra newline.

> +	struct v4l2_subdev_krouting routing = {
> +		.num_routes = ARRAY_SIZE(routes),
> +		.routes = routes,
> +	};
> +
> +	return _max96717_set_routing(sd, state, &routing);
> +}
> +
> +static bool max96717_pipe_pclkdet(struct max96717_priv *priv)
> +{
> +	u64 val = 0;
> +
> +	cci_read(priv->regmap, MAX96717_VIDEO_TX2, &val, NULL);
> +
> +	return val & MAX96717_VIDEO_PCLKDET;
> +}
> +
> +static int max96717_log_status(struct v4l2_subdev *sd)
> +{
> +	struct max96717_priv *priv = sd_to_max96717(sd);
> +	struct device *dev = &priv->client->dev;
> +
> +	dev_info(dev, "Serializer: %s\n", priv->data->model);
> +	dev_info(dev, "Pipe: pclkdet:%d\n", max96717_pipe_pclkdet(priv));
> +
> +	return 0;
> +}
> +
> +static int max96717_enable_streams(struct v4l2_subdev *sd,
> +				   struct v4l2_subdev_state *state, u32 pad,
> +				   u64 streams_mask)
> +{
> +	struct max96717_priv *priv = sd_to_max96717(sd);
> +	struct device *dev = &priv->client->dev;
> +	u64 sink_streams;
> +	int ret;
> +
> +	sink_streams = v4l2_subdev_state_xlate_streams(state,
> +						       MAX96717_PAD_SOURCE,
> +						       MAX96717_PAD_SINK,
> +						       &streams_mask);
> +
> +	if (!priv->enabled_source_streams)
> +		max96717_start_csi(priv, true);
> +
> +	ret = v4l2_subdev_enable_streams(priv->source_sd, priv->source_sd_pad,
> +					 sink_streams);
> +	if (ret) {
> +		dev_err(dev, "Fail to start streams:%llu on remote subdev\n",
> +			sink_streams);
> +		goto stop_csi;
> +	}
> +
> +	priv->enabled_source_streams |= streams_mask;
> +
> +	return 0;
> +
> +stop_csi:
> +	if (!priv->enabled_source_streams)
> +		max96717_start_csi(priv, false);
> +	return ret;
> +}
> +
> +static int max96717_disable_streams(struct v4l2_subdev *sd,
> +				    struct v4l2_subdev_state *state, u32 pad,
> +				    u64 streams_mask)
> +{
> +	struct max96717_priv *priv = sd_to_max96717(sd);
> +	u64 sink_streams;
> +	int ret;
> +
> +	sink_streams = v4l2_subdev_state_xlate_streams(state,
> +						       MAX96717_PAD_SOURCE,
> +						       MAX96717_PAD_SINK,
> +						       &streams_mask);
> +
> +	ret = v4l2_subdev_disable_streams(priv->source_sd, priv->source_sd_pad,
> +					  sink_streams);
> +	if (ret)
> +		return ret;
> +
> +	priv->enabled_source_streams &= ~streams_mask;
> +
> +	if (!priv->enabled_source_streams)
> +		max96717_start_csi(priv, false);
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_subdev_pad_ops max96717_pad_ops = {
> +	.enable_streams = max96717_enable_streams,
> +	.disable_streams = max96717_disable_streams,
> +	.set_routing = max96717_set_routing,
> +	.get_fmt = v4l2_subdev_get_fmt,
> +	.set_fmt = max96717_set_fmt,
> +};
> +
> +static const struct v4l2_subdev_core_ops max96717_subdev_core_ops = {
> +	.log_status = max96717_log_status,
> +};
> +
> +static const struct v4l2_subdev_internal_ops max96717_internal_ops = {
> +	.init_state = max96717_init_state,
> +};
> +
> +static const struct v4l2_subdev_ops max96717_subdev_ops = {
> +	.core = &max96717_subdev_core_ops,
> +	.pad = &max96717_pad_ops,
> +};
> +
> +static const struct media_entity_operations max96717_entity_ops = {
> +	.link_validate = v4l2_subdev_link_validate,
> +};
> +
> +static int max96717_notify_bound(struct v4l2_async_notifier *notifier,
> +				 struct v4l2_subdev *source_subdev,
> +				 struct v4l2_async_connection *asd)
> +{
> +	struct max96717_priv *priv = sd_to_max96717(notifier->sd);
> +	struct device *dev = &priv->client->dev;
> +	int ret;
> +
> +	ret = media_entity_get_fwnode_pad(&source_subdev->entity,
> +					  source_subdev->fwnode,
> +					  MEDIA_PAD_FL_SOURCE);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to find pad for %s\n",
> +			source_subdev->name);
> +		return ret;
> +	}
> +
> +	priv->source_sd = source_subdev;
> +	priv->source_sd_pad = ret;
> +
> +	ret = media_create_pad_link(&source_subdev->entity, priv->source_sd_pad,
> +				    &priv->sd.entity, 0,
> +				    MEDIA_LNK_FL_ENABLED |
> +				    MEDIA_LNK_FL_IMMUTABLE);
> +	if (ret) {
> +		dev_err(dev, "Unable to link %s:%u -> %s:0\n",
> +			source_subdev->name, priv->source_sd_pad,
> +			priv->sd.name);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_async_notifier_operations max96717_notify_ops = {
> +	.bound = max96717_notify_bound,
> +};
> +
> +static int max96717_v4l2_notifier_register(struct max96717_priv *priv)
> +{
> +	struct device *dev = &priv->client->dev;
> +	struct v4l2_async_connection *asd;
> +	struct fwnode_handle *ep_fwnode;
> +	int ret;
> +
> +	ep_fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
> +						    MAX96717_PAD_SINK, 0, 0);
> +	if (!ep_fwnode) {
> +		dev_err(dev, "No graph endpoint\n");
> +		return -ENODEV;
> +	}
> +
> +	v4l2_async_subdev_nf_init(&priv->notifier, &priv->sd);
> +
> +	asd = v4l2_async_nf_add_fwnode_remote(&priv->notifier, ep_fwnode,
> +					      struct v4l2_async_connection);
> +
> +	fwnode_handle_put(ep_fwnode);
> +
> +	if (IS_ERR(asd)) {
> +		dev_err(dev, "Failed to add subdev: %ld", PTR_ERR(asd));
> +		v4l2_async_nf_cleanup(&priv->notifier);
> +		return PTR_ERR(asd);
> +	}
> +
> +	priv->notifier.ops = &max96717_notify_ops;
> +
> +	ret = v4l2_async_nf_register(&priv->notifier);
> +	if (ret) {
> +		dev_err(dev, "Failed to register subdev_notifier");
> +		v4l2_async_nf_cleanup(&priv->notifier);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void max96717_v4l2_notifier_unregister(struct max96717_priv *priv)
> +{
> +	v4l2_async_nf_unregister(&priv->notifier);
> +	v4l2_async_nf_cleanup(&priv->notifier);
> +}
> +
> +static int max96717_subdev_init(struct max96717_priv *priv)
> +{
> +	struct device *dev = &priv->client->dev;
> +	int ret;
> +
> +	v4l2_i2c_subdev_init(&priv->sd, priv->client, &max96717_subdev_ops);
> +	priv->sd.internal_ops = &max96717_internal_ops;
> +
> +	priv->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_STREAMS;
> +	priv->sd.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
> +	priv->sd.entity.ops = &max96717_entity_ops;
> +
> +	priv->pads[0].flags = MEDIA_PAD_FL_SINK;
> +	priv->pads[1].flags = MEDIA_PAD_FL_SOURCE;

You have MAX96717_PAD_SINK and MAX96717_PAD_SOURCE as well.

> +
> +	ret = media_entity_pads_init(&priv->sd.entity, 2, priv->pads);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init pads\n");
> +
> +	ret = v4l2_subdev_init_finalize(&priv->sd);
> +	if (ret) {
> +		dev_err_probe(dev, ret,
> +			      "v4l2 subdev init finalized failed\n");
> +		goto err_fwnode_put;
> +	}
> +	ret = max96717_v4l2_notifier_register(priv);
> +	if (ret) {
> +		dev_err_probe(dev, ret,
> +			      "v4l2 subdev notifier register failed\n");
> +		goto err_free_state;
> +	}
> +
> +	ret = v4l2_async_register_subdev(&priv->sd);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "v4l2_async_register_subdev error\n");
> +		goto err_unreg_notif;
> +	}
> +
> +	return 0;
> +
> +err_unreg_notif:
> +	max96717_v4l2_notifier_unregister(priv);
> +err_free_state:
> +	v4l2_subdev_cleanup(&priv->sd);
> +err_fwnode_put:
> +	fwnode_handle_put(priv->sd.fwnode);

Hmm. Does this belong here? Or... should it be done at all?

> +	media_entity_cleanup(&priv->sd.entity);
> +
> +	return ret;
> +}
> +
> +static void max96717_subdev_uninit(struct max96717_priv *priv)
> +{
> +	v4l2_async_unregister_subdev(&priv->sd);
> +	max96717_v4l2_notifier_unregister(priv);
> +	v4l2_subdev_cleanup(&priv->sd);
> +	fwnode_handle_put(priv->sd.fwnode);

Same here.

> +	media_entity_cleanup(&priv->sd.entity);
> +}
> +
> +struct max96717_pll_predef_freq {
> +	unsigned long freq;
> +	bool is_alt;
> +	u8 val;
> +};
> +
> +static const struct max96717_pll_predef_freq max96717_predef_freqs[] = {
> +	{ 13500000, true,  0 }, { 19200000, false, 0 },
> +	{ 24000000, true,  1 }, { 27000000, false, 1 },
> +	{ 37125000, false, 2 }, { 74250000, false, 3 },
> +};
> +
> +static unsigned long
> +max96717_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct max96717_priv *priv = clk_hw_to_max96717(hw);
> +
> +	return max96717_predef_freqs[priv->pll_predef_index].freq;
> +}
> +
> +static unsigned int max96717_clk_find_best_index(struct max96717_priv *priv,
> +						 unsigned long rate)
> +{
> +	u8 i, idx;

unsigned int please, and declare these after the diff* below.

> +	unsigned long diff_new, diff_old;
> +
> +	diff_old = U32_MAX;
> +	idx = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(max96717_predef_freqs); i++) {
> +		diff_new = abs(rate - max96717_predef_freqs[i].freq);
> +		if (diff_new < diff_old) {
> +			diff_old = diff_new;
> +			idx = i;
> +		}
> +	}
> +
> +	return idx;
> +}
> +
> +static long max96717_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +				    unsigned long *parent_rate)
> +{
> +	struct max96717_priv *priv = clk_hw_to_max96717(hw);
> +	struct device *dev = &priv->client->dev;
> +	u8 idx;

unsigned int.

> +
> +	idx = max96717_clk_find_best_index(priv, rate);
> +
> +	if (rate != max96717_predef_freqs[idx].freq) {
> +		dev_warn(dev, "Request CLK freq:%lu, found CLK freq:%lu\n",
> +			 rate, max96717_predef_freqs[idx].freq);
> +	}
> +
> +	return max96717_predef_freqs[idx].freq;
> +}
> +
> +static int max96717_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +				 unsigned long parent_rate)
> +{
> +	struct max96717_priv *priv = clk_hw_to_max96717(hw);
> +	int ret = 0;
> +	u8 val, idx;

Ditto.

> +
> +	idx = max96717_clk_find_best_index(priv, rate);
> +
> +	val = FIELD_PREP(REFGEN_PREDEF_FREQ_MASK,
> +			 max96717_predef_freqs[idx].val);
> +
> +	if (max96717_predef_freqs[idx].is_alt)
> +		val |= REFGEN_PREDEF_FREQ_ALT;
> +
> +	val |= REFGEN_RST | REFGEN_PREDEF_EN;
> +
> +	cci_write(priv->regmap, REF_VTG0, val, &ret);
> +	cci_update_bits(priv->regmap, REF_VTG0, REFGEN_RST | REFGEN_EN,
> +			REFGEN_EN, &ret);
> +	if (ret)
> +		return ret;
> +
> +	priv->pll_predef_index = idx;
> +
> +	return 0;
> +}
> +
> +static int max96717_clk_prepare(struct clk_hw *hw)
> +{
> +	struct max96717_priv *priv = clk_hw_to_max96717(hw);
> +
> +	return cci_update_bits(priv->regmap, MAX96717_REG6, RCLKEN,
> +			       RCLKEN, NULL);
> +}
> +
> +static void max96717_clk_unprepare(struct clk_hw *hw)
> +{
> +	struct max96717_priv *priv = clk_hw_to_max96717(hw);
> +
> +	cci_update_bits(priv->regmap, MAX96717_REG6, RCLKEN, 0, NULL);
> +}
> +
> +static const struct clk_ops max96717_clk_ops = {
> +	.prepare     = max96717_clk_prepare,
> +	.unprepare   = max96717_clk_unprepare,
> +	.set_rate    = max96717_clk_set_rate,
> +	.recalc_rate = max96717_clk_recalc_rate,
> +	.round_rate  = max96717_clk_round_rate,
> +};
> +
> +static int max96717_register_clkout(struct max96717_priv *priv)
> +{
> +	struct device *dev = &priv->client->dev;
> +	int ret;
> +

Extra newline.

> +	const struct clk_init_data init = {
> +		.name = kasprintf(GFP_KERNEL, "%s.%s.clk_out",
> +				  priv->data->model,
> +				  dev_name(dev)),

Please move kasprintf() outside declaration. It's not nice to do things
there that can fail.

> +		.ops = &max96717_clk_ops,
> +	};

This would be nicer declared before rett.

> +
> +	if (!init.name)
> +		return -ENOMEM;
> +
> +	/* RCLKSEL Reference PLL output */
> +	ret = cci_update_bits(priv->regmap, REG3, MAX96717_RCLKSEL,
> +			      RCLKSEL_REF_PLL, NULL);
> +	/* MFP4 fastest slew rate */
> +	cci_update_bits(priv->regmap, PIO_SLEW_1, BIT(5) | BIT(4), 0, &ret);
> +	if (ret)
> +		goto free_init_name;
> +
> +	priv->clk_hw.init = &init;
> +
> +	/* Initialize to 24 MHz */
> +	ret = max96717_clk_set_rate(&priv->clk_hw,
> +				    MAX96717_DEFAULT_CLKOUT_RATE, 0);
> +	if (ret < 0)
> +		goto free_init_name;
> +
> +	ret = devm_clk_hw_register(dev, &priv->clk_hw);
> +	kfree(init.name);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot register clock HW\n");
> +
> +	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +					  &priv->clk_hw);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Cannot add OF clock provider\n");
> +
> +	return 0;
> +
> +free_init_name:
> +	kfree(init.name);
> +	return ret;
> +}
> +
> +static int max96717_init_csi_lanes(struct max96717_priv *priv)
> +{
> +	struct v4l2_mbus_config_mipi_csi2 *mipi = &priv->vep.bus.mipi_csi2;
> +	unsigned long lanes_used = 0;
> +	u8 nlanes, lane, val = 0;

unsigned int.

> +	int ret;
> +
> +	nlanes = mipi->num_data_lanes;
> +
> +	ret = cci_update_bits(priv->regmap, MAX96717_MIPI_RX1,
> +			      MAX96717_MIPI_LANES_CNT,
> +			      FIELD_PREP(MAX96717_MIPI_LANES_CNT,
> +					 nlanes - 1), NULL);
> +
> +	/* lanes polarity */
> +	for (lane = 0; lane < nlanes + 1; lane++) {
> +		if (!mipi->lane_polarities[lane])
> +			continue;
> +		/* Clock lane */
> +		if (lane == 0)
> +			val |= BIT(2);
> +		else if (lane < 3)
> +			val |= BIT(lane - 1);
> +		else
> +			val |= BIT(lane);
> +	}
> +
> +	cci_update_bits(priv->regmap, MAX96717_MIPI_RX5,
> +			MAX96717_PHY2_LANES_POL,
> +			FIELD_PREP(MAX96717_PHY2_LANES_POL, val), &ret);
> +
> +	cci_update_bits(priv->regmap, MAX96717_MIPI_RX4,
> +			MAX96717_PHY1_LANES_POL,
> +			FIELD_PREP(MAX96717_PHY1_LANES_POL,
> +				   val >> 3), &ret);
> +	/* lanes mapping */
> +	val = 0;
> +	for (lane = 0; lane < nlanes; lane++) {

You can initialise val in loop initialisation (i.e. lane = 0, val = 0).

> +		val |= (mipi->data_lanes[lane] - 1) << (lane * 2);
> +		lanes_used |= BIT(mipi->data_lanes[lane] - 1);
> +	}
> +
> +	/* Unused lanes need to be mapped as well to not have

/*
 * Multi-line
 * comment.
 */

> +	 * the same lanes mapped twice.
> +	 */
> +	for (; lane < 4; lane++) {
> +		unsigned int idx = find_first_zero_bit(&lanes_used, 4);
> +
> +		val |= idx << (lane * 2);
> +		lanes_used |= BIT(idx);
> +	}
> +
> +	cci_update_bits(priv->regmap, MAX96717_MIPI_RX3,
> +			MAX96717_PHY1_LANES_MAP,
> +			FIELD_PREP(MAX96717_PHY1_LANES_MAP, val), &ret);
> +
> +	return cci_update_bits(priv->regmap, MAX96717_MIPI_RX2,
> +			       MAX96717_PHY2_LANES_MAP,
> +			       FIELD_PREP(MAX96717_PHY2_LANES_MAP, val >> 4),
> +			       &ret);
> +}
> +
> +static int max96717_hw_init(struct max96717_priv *priv)
> +{
> +	struct device *dev = &priv->client->dev;
> +	u64 val;
> +	int ret;
> +
> +	ret = cci_read(priv->regmap, MAX96717_DEV_ID, &val, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Fail to read the device id\n");
> +
> +	if (val != priv->data->device_id)
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "Unsupported device id expected %x got %x\n",
> +				     priv->data->device_id, (u8)val);
> +
> +	ret = cci_read(priv->regmap, MAX96717_DEV_REV, &val, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Fail to read device revision");
> +
> +	dev_dbg(dev, "Found %x (rev %lx)\n", priv->data->device_id,
> +		(u8)val & MAX96717_DEV_REV_MASK);
> +
> +	ret = cci_read(priv->regmap, MAX96717_MIPI_RX_EXT11, &val, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Fail to read mipi rx extension");
> +
> +	if (!(val & MAX96717_TUN_MODE))
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "Only supporting tunnel mode");
> +
> +	return max96717_init_csi_lanes(priv);
> +}
> +
> +static int max96717_parse_dt(struct max96717_priv *priv)
> +{
> +	struct device *dev = &priv->client->dev;
> +	struct fwnode_handle *ep_fwnode;
> +	unsigned char num_data_lanes;
> +	int ret;
> +
> +	priv->vep.bus_type = V4L2_MBUS_CSI2_DPHY;
> +
> +	ep_fwnode = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev),
> +						    MAX96717_PAD_SINK, 0, 0);
> +	if (!ep_fwnode)
> +		return dev_err_probe(dev, -ENOENT, "no endpoint found\n");
> +
> +	ret = v4l2_fwnode_endpoint_parse(ep_fwnode, &priv->vep);
> +
> +	fwnode_handle_put(ep_fwnode);
> +
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to parse sink endpoint");
> +
> +	num_data_lanes = priv->vep.bus.mipi_csi2.num_data_lanes;

If all you need from the endpoint is the number of lanes and their
polarities, then I'd store just that, not the entire endpoint.

> +	if (num_data_lanes < 1 || num_data_lanes > 4)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid data lanes should be 1 to 4\n");

s/should/must/
s/be \K/from /

> +
> +	return 0;
> +}
> +
> +static int max96717_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct max96717_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->client = client;
> +

Extra newline.

> +	priv->data = of_device_get_match_data(&client->dev);

We have device_get_match_data(), too. Up to you.

> +
> +	i2c_set_clientdata(client, priv);
> +
> +	priv->regmap = devm_cci_regmap_init_i2c(client, 16);
> +	if (IS_ERR(priv->regmap)) {
> +		ret = PTR_ERR(priv->regmap);
> +		return dev_err_probe(dev, ret, "Failed to init regmap\n");
> +	}
> +
> +	ret = max96717_parse_dt(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to parse the dt\n");
> +
> +	ret = max96717_hw_init(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to initialize the hardware\n");
> +
> +	ret = max96717_gpiochip_probe(priv);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to init gpiochip\n");
> +		return ret;
> +	}
> +
> +	ret = max96717_register_clkout(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register clkout\n");
> +
> +	ret = max96717_subdev_init(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to initialize v4l2 subdev\n");
> +
> +	ret = max96717_i2c_mux_init(priv);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to add remote i2c adapter\n");
> +		goto err_subdev_uninit;

No need for goto as you use the lable in a single location only. Move
max96717_subdev_uninit() here.

> +	}
> +
> +	return 0;
> +
> +err_subdev_uninit:
> +	max96717_subdev_uninit(priv);
> +	return ret;
> +}
> +
> +static void max96717_remove(struct i2c_client *client)
> +{
> +	struct max96717_priv *priv = i2c_get_clientdata(client);
> +
> +	max96717_subdev_uninit(priv);
> +	i2c_mux_del_adapters(priv->mux);
> +}
> +
> +static const struct of_device_id max96717_of_ids[] = {
> +	{ .compatible = "maxim,max96717f", .data = &max96717f_data },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max96717_of_ids);
> +
> +static struct i2c_driver max96717_i2c_driver = {
> +	.driver	= {
> +		.name		= "max96717",
> +		.of_match_table	= max96717_of_ids,
> +	},
> +	.probe		= max96717_probe,
> +	.remove		= max96717_remove,
> +};
> +
> +module_i2c_driver(max96717_i2c_driver);
> +
> +MODULE_DESCRIPTION("Maxim GMSL2 MAX96717 Serializer Driver");
> +MODULE_AUTHOR("Julien Massot <julien.massot@collabora.com>");
> +MODULE_LICENSE("GPL");

-- 
Kind regards,

Sakari Ailus

