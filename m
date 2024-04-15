Return-Path: <linux-kernel+bounces-145588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3B8A5826
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E631C221D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DF48248E;
	Mon, 15 Apr 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rbgn2uGE"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A6C82481
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199855; cv=none; b=HteTe+XbbehFs2B8BS+OmBJg5iIyqUEiLwOd/NQt/yEqJ5B9G3IA1yxIAvbwZg4RGd29/2yr9xMXSLzT49UquH583tqCbgmu/MBDbgXNs4xLwtgc1pVbzgmpkVwO4YTChVOcwlyMBNbFnAgLeomkc7QfleD9SvqHp0W4UCRi0Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199855; c=relaxed/simple;
	bh=uneBj15HcdtC02CZZBXyKX70iq4SoZi7QfZCmxoTLHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epJIX37vmc+9cG+l5s0JXyU7YK3n5U56PmVdJR2RaI2PYG8jnUXoprnEsVKz4J1HeAF4hzjkEp0Y4k+0n3rYZ0txICzAc/T6KUuKlrDblaAB9T0OTACI6jj1EkAnwCSXdYqQEHZchdcmXCY88kxSxbZ///aGla7TcYqn4ribuJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rbgn2uGE; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516cdb21b34so4387525e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713199851; x=1713804651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5XcThWMs6mWSUjgCvvr8NgRb/oJmLpUWiiTlWRZ6KY=;
        b=Rbgn2uGEAx+foWRcMQNQzxpaUCQqA0a3TwRZ+3QtWigPTzqP0jW8kl5BklMrTENTAK
         vi3ZmxJXQEzrVa2NRre4y+8FcB2pyCqCguKKFpVy0F1f4Er1tJRHMpoQpEtJYonwr1P4
         Jzput5a0K0TuPVF8x6xOa20EAJU/KvRFDuFO4julNVAKcJM3c01M9qmd3aUanPvs6dQt
         s5KaBVARr6LyssNKQ+zle3TR8zwXAS9pmWHKDHF+gzRp4QDYM0tDo6PJd5TZratZjY9u
         8e/arOuMuG1g2ZIGrfeNqrdpdoe8kwGaXdu80aTG3zcsCzMpXhaZSVs7nv2DwGK2pXHb
         nbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713199851; x=1713804651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5XcThWMs6mWSUjgCvvr8NgRb/oJmLpUWiiTlWRZ6KY=;
        b=dxQrvzM7ROz7RYHVxNV8u5OtkOdWsehe6yY+Pbdv0n/ifSIaKTWK7V9xeJLxD54UeI
         ojHV5f79qOG+FKQiNBW2GcJ3/38JLJ0XihoYQq5GbvIdbjowleA8/41rQoBByppeEI4e
         hZlrj7Xs4QWkmlbXWoEPSuB1aeAiC9fsOoRAnthFQB8/M2Ds+DbmzXE3oqY8g9yb6Vv6
         2beUhko0LCTB9jMBdTNj7gwKFEeN35LTetzlRgrhQLFSfIrhg7RbMGrr6b5/QB/BSBjm
         KOYnTQqPo0nVIdGGpY8UhZox/Kg3dujG1Ok83ytqDTpLGZL1GYCWhVjKuRk/H+7jxnc6
         hbGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzuK2VMPWPtHKXys5U3nkn/tmdQNzt7sDlYaOt41lVLjyp3aNrpnwvOkBiB90GratTCnNTYaV83vkEVhthMyd4vecdAOa1bn3d3/1U
X-Gm-Message-State: AOJu0YwlTrwMeh9KlaSTM8GmaSu4NwvTyP1A6AUEFiOZntT6KB013Doo
	SafvYlL6jAUZ8Q8ubCqJ/gOQeVhZfA0bS+r3oYIq3HxTrpNACRm7P9roNVtVPuXCXC6T5+SH1gI
	6
X-Google-Smtp-Source: AGHT+IEdwA/pMzyAMLFTn/8nW8+Oydx4hunuvhfJcxp0i8eRBXOMemOurfFPArRKEQUSEO+ngoJ6zA==
X-Received: by 2002:a05:6512:473:b0:516:9f1a:929d with SMTP id x19-20020a056512047300b005169f1a929dmr6353141lfd.1.1713199851184;
        Mon, 15 Apr 2024 09:50:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id p18-20020a05651238d200b00516d200cba9sm632735lft.58.2024.04.15.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:50:50 -0700 (PDT)
Date: Mon, 15 Apr 2024 19:50:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: David Wronek <david@mainlining.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/panel: Add driver for EDO RM69380 OLED panel
Message-ID: <yccnqb63gp5svx76rudfnphecpatkpwgp2wlfenojebulrigma@xfztf3ox6q7d>
References: <20240415-raydium-rm69380-driver-v2-0-524216461306@mainlining.org>
 <20240415-raydium-rm69380-driver-v2-2-524216461306@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415-raydium-rm69380-driver-v2-2-524216461306@mainlining.org>

On Mon, Apr 15, 2024 at 06:10:42PM +0200, David Wronek wrote:
> Add support for the 2560x1600@90Hz OLED panel by EDO bundled with a
> Raydium RM69380 controller, as found on the Lenovo Xiaoxin Pad Pro 2021.
> 
> Signed-off-by: David Wronek <david@mainlining.org>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |  14 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-raydium-rm69380.c | 366 ++++++++++++++++++++++++++
>  3 files changed, 381 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 154f5bf82980..5b3eeb93b1a2 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -542,6 +542,20 @@ config DRM_PANEL_RAYDIUM_RM692E5
>  	  Say Y here if you want to enable support for Raydium RM692E5-based
>  	  display panels, such as the one found in the Fairphone 5 smartphone.
>  
> +config DRM_PANEL_RAYDIUM_RM69380
> +	tristate "Raydium RM69380-based DSI panel"
> +	depends on BACKLIGHT_CLASS_DEVICE
> +	depends on DRM_DISPLAY_DP_HELPER
> +	depends on DRM_DISPLAY_HELPER
> +	depends on DRM_MIPI_DSI
> +	depends on OF
> +	help
> +	  Say Y here if you want to enable support for Raydium RM69380-based
> +	  display panels.
> +
> +	  This panel controller can be found in the Lenovo Xiaoxin Pad Pro 2021
> +	  in combination with an EDO OLED panel.
> +
>  config DRM_PANEL_RONBO_RB070D30
>  	tristate "Ronbo Electronics RB070D30 panel"
>  	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index 24a02655d726..e2a2807d4ef0 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN) += panel-raspberrypi-touchscreen
>  obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM67191) += panel-raydium-rm67191.o
>  obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) += panel-raydium-rm68200.o
>  obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM692E5) += panel-raydium-rm692e5.o
> +obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM69380) += panel-raydium-rm69380.o
>  obj-$(CONFIG_DRM_PANEL_RONBO_RB070D30) += panel-ronbo-rb070d30.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20) += panel-samsung-atna33xc20.o
>  obj-$(CONFIG_DRM_PANEL_SAMSUNG_DB7430) += panel-samsung-db7430.o
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm69380.c b/drivers/gpu/drm/panel/panel-raydium-rm69380.c
> new file mode 100644
> index 000000000000..253b9a1c2800
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm69380.c
> @@ -0,0 +1,366 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generated with linux-mdss-dsi-panel-driver-generator from vendor device tree.
> + * Copyright (c) 2024 David Wronek <david@mainlining.org>
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_graph.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
> +
> +struct rm69380_panel {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi[2];
> +	struct regulator_bulk_data supplies[2];
> +	struct gpio_desc *reset_gpio;
> +	bool prepared;
> +};
> +
> +static inline
> +struct rm69380_panel *to_rm69380_panel(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct rm69380_panel, panel);
> +}
> +
> +static void rm69380_reset(struct rm69380_panel *ctx)
> +{
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	usleep_range(15000, 16000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +	usleep_range(10000, 11000);
> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	msleep(30);
> +}
> +
> +static int rm69380_on(struct rm69380_panel *ctx)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi[0];
> +	struct device *dev = &dsi->dev;
> +	int ret;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +	if (ctx->dsi[1])
> +		ctx->dsi[1]->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0xd4);
> +	mipi_dsi_dcs_write_seq(dsi, 0x00, 0x80);
> +	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0xd0);
> +	mipi_dsi_dcs_write_seq(dsi, 0x48, 0x00);
> +	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x26);
> +	mipi_dsi_dcs_write_seq(dsi, 0x75, 0x3f);
> +	mipi_dsi_dcs_write_seq(dsi, 0x1d, 0x1a);
> +	mipi_dsi_dcs_write_seq(dsi, 0xfe, 0x00);
> +	mipi_dsi_dcs_write_seq(dsi, 0x53, 0x28);
> +	mipi_dsi_dcs_write_seq(dsi, 0xc2, 0x08);
> +	mipi_dsi_dcs_write_seq(dsi, 0x35, 0x00);

mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);

> +	mipi_dsi_dcs_write_seq(dsi, 0x51, 0x07, 0xff);

ret = mipi_dsi_dcs_set_display_brightness_large(dsi, 0x7ff);

> +
> +	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
> +		return ret;
> +	}
> +	msleep(20);
> +
> +	ret = mipi_dsi_dcs_set_display_on(dsi);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set display on: %d\n", ret);
> +		return ret;
> +	}
> +	msleep(36);
> +
> +	return 0;
> +}

[skipped]

> +
> +static const struct drm_display_mode rm69380_mode = {
> +	.clock = (2560 + 32 + 12 + 38) * (1600 + 20 + 4 + 8) * 90 / 1000,
> +	.hdisplay = 2560,
> +	.hsync_start = 2560 + 32,
> +	.hsync_end = 2560 + 32 + 12,
> +	.htotal = 2560 + 32 + 12 + 38,
> +	.vdisplay = 1600,
> +	.vsync_start = 1600 + 20,
> +	.vsync_end = 1600 + 20 + 4,
> +	.vtotal = 1600 + 20 + 4 + 8,
> +	.width_mm = 248,
> +	.height_mm = 155,
> +	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,

Nit: DRM_MODE_TYPE_PREFERRED will be set by
drm_connector_helper_get_modes_fixed(), so it can be dropped here.

> +};
> +
> +static int rm69380_get_modes(struct drm_panel *panel,
> +					struct drm_connector *connector)
> +{
> +	return drm_connector_helper_get_modes_fixed(connector, &rm69380_mode);
> +}
> +
> +static const struct drm_panel_funcs rm69380_panel_funcs = {
> +	.prepare = rm69380_prepare,
> +	.unprepare = rm69380_unprepare,
> +	.get_modes = rm69380_get_modes,
> +};
> +
> +static int rm69380_bl_update_status(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness = backlight_get_brightness(bl);
> +	int ret;
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	return 0;
> +}
> +
> +static int rm69380_bl_get_brightness(struct backlight_device *bl)
> +{
> +	struct mipi_dsi_device *dsi = bl_get_data(bl);
> +	u16 brightness;
> +	int ret;
> +
> +	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	ret = mipi_dsi_dcs_get_display_brightness_large(dsi, &brightness);
> +	if (ret < 0)
> +		return ret;
> +
> +	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> +
> +	return brightness;
> +}
> +
> +static const struct backlight_ops rm69380_bl_ops = {
> +	.update_status = rm69380_bl_update_status,
> +	.get_brightness = rm69380_bl_get_brightness,
> +};
> +
> +static struct backlight_device *
> +rm69380_create_backlight(struct mipi_dsi_device *dsi)
> +{
> +	struct device *dev = &dsi->dev;
> +	const struct backlight_properties props = {
> +		.type = BACKLIGHT_RAW,
> +		.brightness = 2047,
> +		.max_brightness = 2047,
> +	};
> +
> +	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
> +					      &rm69380_bl_ops, &props);
> +}
> +
> +static int rm69380_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct mipi_dsi_host *dsi_sec_host;
> +	struct rm69380_panel *ctx;
> +	struct device *dev = &dsi->dev;
> +	struct device_node *dsi_sec;
> +	int ret, i;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->supplies[0].supply = "vddio";
> +	ctx->supplies[1].supply = "avdd";
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies),
> +				      ctx->supplies);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ctx->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +				     "Failed to get reset-gpios\n");
> +
> +	dsi_sec = of_graph_get_remote_node(dsi->dev.of_node, 1, -1);
> +
> +	if (dsi_sec) {
> +		dev_dbg(dev, "Using Dual-DSI\n");
> +
> +		const struct mipi_dsi_device_info info = { "RM69380", 0,
> +							   dsi_sec };
> +
> +		dev_dbg(dev, "Found second DSI `%s`\n", dsi_sec->name);
> +
> +		dsi_sec_host = of_find_mipi_dsi_host_by_node(dsi_sec);
> +		of_node_put(dsi_sec);
> +		if (!dsi_sec_host) {
> +			return dev_err_probe(dev, -EPROBE_DEFER,
> +					     "Cannot get secondary DSI host\n");
> +		}
> +
> +		ctx->dsi[1] =
> +			mipi_dsi_device_register_full(dsi_sec_host, &info);

Either you should be using devm_mipi_dsi_device_register_full() here or
you should call mipi_dsi_device_unregister() in the error and remove
paths. I'd suggest the former.

> +		if (IS_ERR(ctx->dsi[1])) {
> +			return dev_err_probe(dev, PTR_ERR(ctx->dsi[1]),
> +					     "Cannot get secondary DSI node\n");
> +		}
> +
> +		dev_dbg(dev, "Second DSI name `%s`\n", ctx->dsi[1]->name);
> +		mipi_dsi_set_drvdata(ctx->dsi[1], ctx);
> +	} else {
> +		dev_dbg(dev, "Using Single-DSI\n");
> +	}
> +
> +	ctx->dsi[0] = dsi;
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +
> +	drm_panel_init(&ctx->panel, dev, &rm69380_panel_funcs,
> +		       DRM_MODE_CONNECTOR_DSI);
> +	ctx->panel.prepare_prev_first = true;
> +
> +	ctx->panel.backlight = rm69380_create_backlight(dsi);
> +	if (IS_ERR(ctx->panel.backlight))
> +		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
> +				     "Failed to create backlight\n");
> +
> +	drm_panel_add(&ctx->panel);
> +
> +	for (i = 0; i < ARRAY_SIZE(ctx->dsi); i++) {
> +		if (!ctx->dsi[i])
> +			continue;
> +
> +		dev_dbg(&ctx->dsi[i]->dev, "Binding DSI %d\n", i);
> +
> +		ctx->dsi[i]->lanes = 4;
> +		ctx->dsi[i]->format = MIPI_DSI_FMT_RGB888;
> +		ctx->dsi[i]->mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
> +					  MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +
> +		ret = mipi_dsi_attach(ctx->dsi[i]);
> +		if (ret < 0) {
> +			drm_panel_remove(&ctx->panel);
> +			return dev_err_probe(dev, ret,
> +					     "Failed to attach to DSI%d\n", i);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void rm69380_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct rm69380_panel *ctx = mipi_dsi_get_drvdata(dsi);
> +	int i;
> +	int ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(ctx->dsi); i++) {
> +		if (!ctx->dsi[i])
> +			continue;
> +
> +		ret = mipi_dsi_detach(ctx->dsi[i]);
> +		if (ret < 0)
> +			dev_err(&dsi->dev, "Failed to detach from DSI%d host: %d\n", i, ret);
> +	}
> +
> +	drm_panel_remove(&ctx->panel);
> +}
> +
> +static const struct of_device_id rm69380_of_match[] = {
> +	{ .compatible = "lenovo,j716f-edo-rm69380" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rm69380_of_match);
> +
> +static struct mipi_dsi_driver rm69380_panel_driver = {
> +	.probe = rm69380_probe,
> +	.remove = rm69380_remove,
> +	.driver = {
> +		.name = "panel-raydium-rm69380",
> +		.of_match_table = rm69380_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(rm69380_panel_driver);
> +
> +MODULE_AUTHOR("David Wronek <david@mainlining.org");
> +MODULE_DESCRIPTION("DRM driver for Raydium RM69380-equipped DSI panels");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.44.0
> 

-- 
With best wishes
Dmitry

