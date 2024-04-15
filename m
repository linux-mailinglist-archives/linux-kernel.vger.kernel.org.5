Return-Path: <linux-kernel+bounces-144556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEAE8A47BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9367E1C217F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6549963CF;
	Mon, 15 Apr 2024 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="S8AcIx9J"
Received: from mail.mainlining.org (mainlining.org [94.241.141.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4318220314;
	Mon, 15 Apr 2024 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.241.141.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713160701; cv=none; b=tHGNYwKLG6dE+oLZu2BFXwKiQXSy4ccE6/t0ipwmnEOFjZDTPJHj8egSU+RH8edhnZ+tnpHgDzaXIcX/4218Zr6XrjHq10hVcgCIGiEq66yhvRf7tgT/l8/1Dk4i1dz+0kr+YRHR+Qo8Z7TLk4dDs9UWkgntIClTccI1nBXznVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713160701; c=relaxed/simple;
	bh=qFq+xiH+Dh/rTRupN30pF7A17tq3vyhqYI1a5tzNoEE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JTa+zi0Aj9hI2dDM25SaWJ157fELCoHWWlu7S/2INVQwJT+whXmAHbp1nkIUpLUsNQOMbkWKoDHcqWiRSoGSm7Hu6L532ROW4xByl52DLssJBkZbM0MpqvEuCkZV/atg754mIUXo0sCoP0vlO/9Vd/XsMQsLul1DUwa9k8yQElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=S8AcIx9J; arc=none smtp.client-ip=94.241.141.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.18.0.7])
	by mail.mainlining.org (Postfix) with ESMTPSA id 83C1CE20FB;
	Mon, 15 Apr 2024 05:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1713160696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbYyFJcWs9NNH46uWR1Awlh3NTpss2q3f6I6HBAt+/E=;
	b=S8AcIx9JHyRrHWhLiBgyhuSdWm+UT7TtqDffqhIpXwFy1RwbNQsvADfjzGKyBPOTEOZWZG
	MGpI9sFxr0YEhmSobUccnddlfwkKORkby2dWV1GUPrkEWou+rzrvePJbbjVyhV0flLRo7G
	1jJa89LDm30PBu+B1KUmGrBKHWUdYaHOsXznSLJ7HcWRo8u/TbMlyF1MZW9SatttZRqPGn
	RQi94eAgyIVlr7I+4FqJBqdC2Dp/ivmUINZF/Ljth9/eCDROBKCTwfSfoG2QieOpoS30WA
	9WkTxE9eQ37EnJt+1ddy19uoopkxO0ApDFG9PmpPJy2WCPGFP/3U2LdkyAw49A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Apr 2024 07:58:16 +0200
From: David Wronek <david@mainlining.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] drm/panel: Add driver for EDO RM69380 OLED panel
In-Reply-To: <7k23umm7iuh5pquhv33cfq52ktgtuydo7p6ltc47ixwga5wi2q@oubs7blgditz>
References: <20240414-raydium-rm69380-driver-v1-0-5e86ba2490b5@mainlining.org>
 <20240414-raydium-rm69380-driver-v1-2-5e86ba2490b5@mainlining.org>
 <7k23umm7iuh5pquhv33cfq52ktgtuydo7p6ltc47ixwga5wi2q@oubs7blgditz>
Message-ID: <67f98fc2e155f87378aae16d413b7665@mainlining.org>
X-Sender: david@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

W dniu 2024-04-14 22:00, Dmitry Baryshkov napisał(a):
> On Sun, Apr 14, 2024 at 05:22:31PM +0200, David Wronek wrote:
>> Add support for the 2560x1600@90Hz OLED panel by EDO bundled with a
>> Raydium RM69380 controller, as found on the Lenovo Xiaoxin Pad Pro 
>> 2021.
>> 
>> Signed-off-by: David Wronek <david@mainlining.org>
>> ---
>>  drivers/gpu/drm/panel/Kconfig                 |  14 +
>>  drivers/gpu/drm/panel/Makefile                |   1 +
>>  drivers/gpu/drm/panel/panel-raydium-rm69380.c | 378 
>> ++++++++++++++++++++++++++
>>  3 files changed, 393 insertions(+)
>> 
>> diff --git a/drivers/gpu/drm/panel/Kconfig 
>> b/drivers/gpu/drm/panel/Kconfig
>> index 154f5bf82980..84cbd838f57e 100644
>> --- a/drivers/gpu/drm/panel/Kconfig
>> +++ b/drivers/gpu/drm/panel/Kconfig
>> @@ -542,6 +542,20 @@ config DRM_PANEL_RAYDIUM_RM692E5
>>  	  Say Y here if you want to enable support for Raydium RM692E5-based
>>  	  display panels, such as the one found in the Fairphone 5 
>> smartphone.
>> 
>> +config DRM_PANEL_RAYDIUM_RM69380
>> +	tristate "Raydium RM69380-based DSI panel"
>> +	depends on BACKLIGHT_CLASS_DEVICE
>> +	depends on DRM_DISPLAY_DP_HELPER
>> +	depends on DRM_DISPLAY_HELPER
>> +	depends on DRM_MIPI_DSI
>> +	depends on OF
>> +	help
>> +	  Say Y here if you want to enable support for Raydium RM69380-based
>> +	  display panels.
>> +
>> +	  This panel controller can be found in the Lenovo Xiaoxin Pad Pro 
>> 2021
>> +	  in combiantion with an EDO OLED panel.
>> +
>>  config DRM_PANEL_RONBO_RB070D30
>>  	tristate "Ronbo Electronics RB070D30 panel"
>>  	depends on OF
>> diff --git a/drivers/gpu/drm/panel/Makefile 
>> b/drivers/gpu/drm/panel/Makefile
>> index 24a02655d726..e2a2807d4ef0 100644
>> --- a/drivers/gpu/drm/panel/Makefile
>> +++ b/drivers/gpu/drm/panel/Makefile
>> @@ -55,6 +55,7 @@ obj-$(CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN) += 
>> panel-raspberrypi-touchscreen
>>  obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM67191) += panel-raydium-rm67191.o
>>  obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) += panel-raydium-rm68200.o
>>  obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM692E5) += panel-raydium-rm692e5.o
>> +obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM69380) += panel-raydium-rm69380.o
>>  obj-$(CONFIG_DRM_PANEL_RONBO_RB070D30) += panel-ronbo-rb070d30.o
>>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20) += 
>> panel-samsung-atna33xc20.o
>>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_DB7430) += panel-samsung-db7430.o
>> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm69380.c 
>> b/drivers/gpu/drm/panel/panel-raydium-rm69380.c
>> new file mode 100644
>> index 000000000000..0b2d576b051d
>> --- /dev/null
>> +++ b/drivers/gpu/drm/panel/panel-raydium-rm69380.c
>> @@ -0,0 +1,378 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Generated with linux-mdss-dsi-panel-driver-generator from vendor 
>> device tree.
>> + * Copyright (c) 2024 David Wronek <david@mainlining.org>
>> + */
>> +
>> +#include <linux/backlight.h>
>> +#include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_graph.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#include <drm/drm_mipi_dsi.h>
>> +#include <drm/drm_modes.h>
>> +#include <drm/drm_panel.h>
>> +
>> +struct rm69380_panel {
>> +	struct drm_panel panel;
>> +	struct mipi_dsi_device *dsi[2];
>> +	struct regulator_bulk_data supplies[2];
>> +	struct gpio_desc *reset_gpio;
>> +	bool prepared;
>> +};
>> +
>> +static inline
>> +struct rm69380_panel *to_rm69380_panel(struct drm_panel *panel)
>> +{
>> +	return container_of(panel, struct rm69380_panel, panel);
>> +}
>> +
>> +static void rm69380_reset(struct rm69380_panel *ctx)
>> +{
>> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>> +	usleep_range(15000, 16000);
>> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>> +	usleep_range(10000, 11000);
>> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>> +	msleep(30);
>> +}
>> +
>> +static int rm69380_on(struct rm69380_panel *ctx)
>> +{
>> +	struct mipi_dsi_device *dsi = ctx->dsi[0];
>> +	struct device *dev = &dsi->dev;
>> +	int ret;
>> +
>> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>> +	if (ctx->dsi[1])
>> +		ctx->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
>> +
>> +	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0xd4);
>> +	mipi_dsi_dcs_write_seq(dsi, 0x00, 0x80);
>> +	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0xd0);
>> +	mipi_dsi_dcs_write_seq(dsi, 0x48, 0x00);
>> +	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x26);
>> +	mipi_dsi_dcs_write_seq(dsi, 0x75, 0x3f);
>> +	mipi_dsi_dcs_write_seq(dsi, 0x1d, 0x1a);
>> +	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x00);
>> +	mipi_dsi_dcs_write_seq(dsi, 0x53, 0x28);
>> +	mipi_dsi_dcs_write_seq(dsi, 0xc2, 0x08);
>> +	mipi_dsi_dcs_write_seq(dsi, 0x35, 0x00);
>> +	mipi_dsi_dcs_write_seq(dsi, 0x51, 0x07, 0xff);
> 
> Does this assume that the host broadcasts commands to both DSI0 and 
> DSI1
> or is it enough to send commands on DSI0 only?
> 

It is enough to send the commands to DSI0 only.

>> +
>> +	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
>> +		return ret;
>> +	}
>> +	msleep(20);
>> +
>> +	ret = mipi_dsi_dcs_set_display_on(dsi);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to set display on: %d\n", ret);
>> +		return ret;
>> +	}
>> +	msleep(36);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rm69380_off(struct rm69380_panel *ctx)
>> +{
>> +	struct mipi_dsi_device *dsi = ctx->dsi[0];
>> +	struct device *dev = &dsi->dev;
>> +	int ret;
>> +
>> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>> +	if (ctx->dsi[1])
>> +		ctx->dsi[1]->mode_flags &= ~MIPI_DSI_MODE_LPM;
>> +
>> +	ret = mipi_dsi_dcs_set_display_off(dsi);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to set display off: %d\n", ret);
>> +		return ret;
>> +	}
>> +	msleep(35);
>> +
>> +	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
>> +		return ret;
>> +	}
>> +	msleep(20);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rm69380_prepare(struct drm_panel *panel)
>> +{
>> +	struct rm69380_panel *ctx = to_rm69380_panel(panel);
>> +	struct device *dev = &ctx->dsi[0]->dev;
>> +	int ret;
>> +
>> +	if (ctx->prepared)
>> +		return 0;
>> +
>> +	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), 
>> ctx->supplies);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	rm69380_reset(ctx);
>> +
>> +	ret = rm69380_on(ctx);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to initialize panel: %d\n", ret);
>> +		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>> +		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>> +		return ret;
>> +	}
>> +
>> +	ctx->prepared = true;
> 
> There is no needto count 'prepared', it's now being handled by the drm
> core.
> 

Ack.

>> +	return 0;
>> +}
>> +
>> +static int rm69380_unprepare(struct drm_panel *panel)
>> +{
>> +	struct rm69380_panel *ctx = to_rm69380_panel(panel);
>> +	struct device *dev = &ctx->dsi[0]->dev;
>> +	int ret;
>> +
>> +	if (!ctx->prepared)
>> +		return 0;
>> +
>> +	ret = rm69380_off(ctx);
>> +	if (ret < 0)
>> +		dev_err(dev, "Failed to un-initialize panel: %d\n", ret);
>> +
>> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>> +	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>> +
>> +	ctx->prepared = false;
>> +	return 0;
>> +}
>> +
>> +static const struct drm_display_mode rm69380_mode = {
>> +	.clock = (2560 + 32 + 12 + 38) * (1600 + 20 + 4 + 8) * 90 / 1000,
>> +	.hdisplay = 2560,
>> +	.hsync_start = 2560 + 32,
>> +	.hsync_end = 2560 + 32 + 12,
>> +	.htotal = 2560 + 32 + 12 + 38,
>> +	.vdisplay = 1600,
>> +	.vsync_start = 1600 + 20,
>> +	.vsync_end = 1600 + 20 + 4,
>> +	.vtotal = 1600 + 20 + 4 + 8,
>> +	.width_mm = 248,
>> +	.height_mm = 155,
>> +};
>> +
>> +static int rm69380_get_modes(struct drm_panel *panel,
>> +					struct drm_connector *connector)
>> +{
>> +	struct drm_display_mode *mode;
>> +
>> +	mode = drm_mode_duplicate(connector->dev, &rm69380_mode);
>> +	if (!mode)
>> +		return -ENOMEM;
>> +
>> +	drm_mode_set_name(mode);
>> +
>> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
>> +	connector->display_info.width_mm = mode->width_mm;
>> +	connector->display_info.height_mm = mode->height_mm;
>> +	drm_mode_probed_add(connector, mode);
> 
> Please use drm_connector_helper_get_modes_fixed()
> 

Ack.

>> +
>> +	return 1;
>> +}
>> +
>> +static const struct drm_panel_funcs rm69380_panel_funcs = {
>> +	.prepare = rm69380_prepare,
>> +	.unprepare = rm69380_unprepare,
>> +	.get_modes = rm69380_get_modes,
>> +};
>> +
>> +static int rm69380_bl_update_status(struct backlight_device *bl)
>> +{
>> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
>> +	u16 brightness = backlight_get_brightness(bl);
>> +	int ret;
>> +
>> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>> +
>> +	ret = mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>> +
>> +	return 0;
>> +}
>> +
>> +static int rm69380_bl_get_brightness(struct backlight_device *bl)
>> +{
>> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
>> +	u16 brightness;
>> +	int ret;
>> +
>> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>> +
>> +	ret = mipi_dsi_dcs_get_display_brightness_large(dsi, &brightness);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>> +
>> +	return brightness;
>> +}
>> +
>> +static const struct backlight_ops rm69380_bl_ops = {
>> +	.update_status = rm69380_bl_update_status,
>> +	.get_brightness = rm69380_bl_get_brightness,
>> +};
>> +
>> +static struct backlight_device *
>> +rm69380_create_backlight(struct mipi_dsi_device *dsi)
>> +{
>> +	struct device *dev = &dsi->dev;
>> +	const struct backlight_properties props = {
>> +		.type = BACKLIGHT_RAW,
>> +		.brightness = 2047,
>> +		.max_brightness = 2047,
>> +	};
>> +
>> +	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
>> +					      &rm69380_bl_ops, &props);
>> +}
>> +
>> +static int rm69380_probe(struct mipi_dsi_device *dsi)
>> +{
>> +	struct mipi_dsi_host *dsi_sec_host;
>> +	struct rm69380_panel *ctx;
>> +	struct device *dev = &dsi->dev;
>> +	struct device_node *dsi_sec;
>> +	int ret, i;
>> +
>> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>> +	if (!ctx)
>> +		return -ENOMEM;
>> +
>> +	ctx->supplies[0].supply = "vddio";
>> +	ctx->supplies[1].supply = "avdd";
>> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
>> +				      ctx->supplies);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
>> +
>> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>> +	if (IS_ERR(ctx->reset_gpio))
>> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
>> +				     "Failed to get reset-gpios\n");
>> +
>> +	dsi_sec = of_graph_get_remote_node(dsi->dev.of_node, 1, -1);
>> +
>> +	if (dsi_sec) {
>> +		dev_notice(dev, "Using Dual-DSI\n");
>> +
>> +		const struct mipi_dsi_device_info info = { "RM69380", 0,
>> +							   dsi_sec };
>> +
>> +		dev_notice(dev, "Found second DSI `%s`\n", dsi_sec->name);
> 
> Please switch to dev_dbg. By default the driver should be quiet.
> 

Ack.

>> +
>> +		dsi_sec_host = of_find_mipi_dsi_host_by_node(dsi_sec);
>> +		of_node_put(dsi_sec);
>> +		if (!dsi_sec_host) {
>> +			return dev_err_probe(dev, -EPROBE_DEFER,
>> +					     "Cannot get secondary DSI host\n");
>> +		}
>> +
>> +		ctx->dsi[1] =
>> +			mipi_dsi_device_register_full(dsi_sec_host, &info);
>> +		if (IS_ERR(ctx->dsi[1])) {
>> +			return dev_err_probe(dev, PTR_ERR(ctx->dsi[1]),
>> +					     "Cannot get secondary DSI node\n");
>> +		}
>> +
>> +		dev_notice(dev, "Second DSI name `%s`\n", ctx->dsi[1]->name);
>> +		mipi_dsi_set_drvdata(ctx->dsi[1], ctx);
>> +	} else {
>> +		dev_notice(dev, "Using Single-DSI\n");
>> +	}
>> +
>> +	ctx->dsi[0] = dsi;
>> +	mipi_dsi_set_drvdata(dsi, ctx);
>> +
>> +	drm_panel_init(&ctx->panel, dev, &rm69380_panel_funcs,
>> +		       DRM_MODE_CONNECTOR_DSI);
>> +	ctx->panel.prepare_prev_first = true;
>> +
>> +	ctx->panel.backlight = rm69380_create_backlight(dsi);
>> +	if (IS_ERR(ctx->panel.backlight))
>> +		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
>> +				     "Failed to create backlight\n");
>> +
>> +	drm_panel_add(&ctx->panel);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(ctx->dsi); i++) {
>> +		if (!ctx->dsi[i])
>> +			continue;
>> +
>> +		dev_notice(&ctx->dsi[i]->dev, "Binding DSI %d\n", i);
>> +
>> +		ctx->dsi[i]->lanes = 4;
>> +		ctx->dsi[i]->format = MIPI_DSI_FMT_RGB888;
>> +		ctx->dsi[i]->mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
>> +					  MIPI_DSI_CLOCK_NON_CONTINUOUS;
>> +
>> +		ret = mipi_dsi_attach(ctx->dsi[i]);
>> +		if (ret < 0) {
>> +			drm_panel_remove(&ctx->panel);
>> +			return dev_err_probe(dev, ret,
>> +					     "Failed to attach to DSI%d\n", i);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void rm69380_remove(struct mipi_dsi_device *dsi)
>> +{
>> +	struct rm69380_panel *ctx = mipi_dsi_get_drvdata(dsi);
>> +	int i;
>> +	int ret;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(ctx->dsi); i++) {
>> +		if (!ctx->dsi[i])
>> +			continue;
>> +
>> +		ret = mipi_dsi_detach(ctx->dsi[i]);
>> +		if (ret < 0)
>> +			dev_err(&dsi->dev, "Failed to detach from DSI%d host: %d\n", i, 
>> ret);
>> +	}
>> +
>> +	drm_panel_remove(&ctx->panel);
>> +}
>> +
>> +static const struct of_device_id rm69380_of_match[] = {
>> +	{ .compatible = "lenovo,j716f-edo-rm69380" },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, rm69380_of_match);
>> +
>> +static struct mipi_dsi_driver rm69380_panel_driver = {
>> +	.probe = rm69380_probe,
>> +	.remove = rm69380_remove,
>> +	.driver = {
>> +		.name = "panel-raydium-rm69380",
>> +		.of_match_table = rm69380_of_match,
>> +	},
>> +};
>> +module_mipi_dsi_driver(rm69380_panel_driver);
>> +
>> +MODULE_AUTHOR("David Wronek <david@mainlining.org");
>> +MODULE_DESCRIPTION("DRM driver for Raydium RM69380-equipped DSI 
>> panels");
>> +MODULE_LICENSE("GPL");
>> 
>> --
>> 2.44.0
>> 

-- 
Best regards,
David Wronek <david@mainlining.org>

