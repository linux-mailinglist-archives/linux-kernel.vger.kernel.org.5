Return-Path: <linux-kernel+bounces-36290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E55D839E74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A90289C28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E0F17CD;
	Wed, 24 Jan 2024 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVEon8VO"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE7B17CB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706061271; cv=none; b=rannfolPWdoWH1tl6z/tK7X/kKIISZwtV+eRj3Bf/T5p1oJHLxy4N+N1TIuH/dPatI8VNRuA+1jU7ZER7A/wOjVuFozDk0M/XxwyqehlL3V9PePvlYVJiyiwMVAjOcoq+ZkyerSDY5YEejeGeMkifToRrZaXYJkIeOC/7wAMdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706061271; c=relaxed/simple;
	bh=eiM4mywXrll5mJoj0O4xpJ1lMETnCmaU7cPCWYyH2rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMBEvzYQy/YQUF7TS9jPs+2i770A6XHSCPrdHs1fuFgYNpNTza4/d2VFZRN/cAPFg1Gaj6NbuBHqeNKf8SQNlArBW0wNUPXb/fmIArY3a3JK0th4d6DUWP73R7wbeDWquw0hLGN6mHwBR92gOkJgro4LljpOOdebTc9i7bPI4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HVEon8VO; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f0629e67f4so52589867b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706061269; x=1706666069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=axQcPoFgnrWsWHyAHUWWqJosABRNubj4CKilRx5HmIo=;
        b=HVEon8VOWOy92EpXWDfsNouwTtCjwiYiab0inEXWD7rIdJRmHeXLyPmUg1clpG6PdU
         maYqjxhK9NTsxANsqhYWyq5Cas5m028feNYXJJpb42pvDNTm8d1I0Jmnj0y5WEUy33tw
         XybNlujG754NzaNq49v2cMkm9u/LDOC+7+PPWheqoje/xsQrXznj/NBeXyUL5Otyq2gs
         sbMoHRzxLVhMTt65nTGz7Ez3EA1Vrj2YX7eOqPmwv+v/rb9flqVendN547Y7JwwVHS+k
         OPcUDLE+w6rMPAmOc3Vpc2uXrXbb9Bl1vfrY+Ni9Oqt1QlIFCP1Vj4ZJBYl2oOZH13IU
         ZOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706061269; x=1706666069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axQcPoFgnrWsWHyAHUWWqJosABRNubj4CKilRx5HmIo=;
        b=FYCuyShTXbLaDbJBPsWJ2ybjQkRiE0h5ZRGKc9Q74cvYTP6Lq1rHLURPptU37tTNhF
         vTAwvlr9iaKaMBioQ1yG5eHTPeHS6aR00g0FKLWBcDNwPE47SbKaoPeMwP48M4krRFCx
         2YX87JwyhS14cMT12FhXVKMrrwSXhiQGGZclABrxsg+1zDSFTtsqcNAej2re33axt7Ec
         SdbLtu5NK1mkYqERoXHuk/xBzNhdbUBbgmjbNLA5Cx3pauDTI49VDuvofCuUhk5u4Utv
         jsfjtCCI1e8ofpAbTWB6/0Nrd8ES0Lmjlr0TiHyH/tSjFtouUbJA8ItA9wSKGovFtq0e
         IRIA==
X-Gm-Message-State: AOJu0Yx/xTeiZQuNhkNbgo+z/mBUYz5U0xo0dXVdaEpeZ2+etoa9CWH2
	DT/56OT7Lhbf3EK0vPXVsOrGv+Ys0Z1/821F02Pprz1Qs+ktJGiRBmrWjoGVO/qrDwBxUygEc10
	kyaog1tZuzwJuFsVYLX51m2QVSbJhtpreEJ82Dw==
X-Google-Smtp-Source: AGHT+IGoZ/YujaX9i4JSsrTh3yg3klZ/HUY9BI2ExPb7Qdgoj7zsbmOIQqYM7g+ZbUowgquXfQwaKX7wlxttC1fts5E=
X-Received: by 2002:a81:5485:0:b0:5ff:a9c2:36d2 with SMTP id
 i127-20020a815485000000b005ffa9c236d2mr86537ywb.98.1706061268630; Tue, 23 Jan
 2024 17:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116-jz-test-sim-panel-v1-0-f9511f46c9c7@quicinc.com> <20240116-jz-test-sim-panel-v1-1-f9511f46c9c7@quicinc.com>
In-Reply-To: <20240116-jz-test-sim-panel-v1-1-f9511f46c9c7@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Jan 2024 03:54:17 +0200
Message-ID: <CAA8EJprtY8qYUv8hOuG+eaih6bvc0+o-PGF4L9=UM95Hk3cFCg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] drm/panel: add driver for simulated panel
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	quic_abhinavk@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jan 2024 at 00:31, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
> Add a driver for simulating panels. This module also supports a mode
> parameter for users to specify a custom mode. If no custom mode is set,
> it will fall back to a custom, hard-coded mode.
>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/panel/Kconfig            |   9 ++
>  drivers/gpu/drm/panel/Makefile           |   1 +
>  drivers/gpu/drm/panel/panel-simulation.c | 147 +++++++++++++++++++++++++++++++
>  3 files changed, 157 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 99e14dc212ecb..d711ec170c586 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -107,6 +107,15 @@ config DRM_PANEL_SIMPLE
>           that it can be automatically turned off when the panel goes into a
>           low power state.
>
> +config DRM_PANEL_SIMULATION
> +       tristate "support for simulation panels"
> +       depends on DRM_MIPI_DSI
> +       help
> +         DRM panel driver for simulated DSI panels. Enabling this config will
> +         cause the physical panel driver to not be attached to the DT panel
> +         node. After the kernel boots, users can load the module and specify a
> +         custom mode using the driver modparams.
> +
>  config DRM_PANEL_EDP
>         tristate "support for simple Embedded DisplayPort panels"
>         depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> index d10c3de51c6db..5bc55357714ad 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_NL6) += panel-boe-tv101wum-nl6.o
>  obj-$(CONFIG_DRM_PANEL_DSI_CM) += panel-dsi-cm.o
>  obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
>  obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
> +obj-$(CONFIG_DRM_PANEL_SIMULATION) += panel-simulation.o
>  obj-$(CONFIG_DRM_PANEL_EDP) += panel-edp.o
>  obj-$(CONFIG_DRM_PANEL_EBBG_FT8719) += panel-ebbg-ft8719.o
>  obj-$(CONFIG_DRM_PANEL_ELIDA_KD35T133) += panel-elida-kd35t133.o
> diff --git a/drivers/gpu/drm/panel/panel-simulation.c b/drivers/gpu/drm/panel/panel-simulation.c
> new file mode 100644
> index 0000000000000..081c03bea188d
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-simulation.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_panel.h>
> +
> +static char sim_panel_mode[PATH_MAX];
> +
> +module_param_string(mode, sim_panel_mode, sizeof(sim_panel_mode), 0644);
> +MODULE_PARM_DESC(mode, "Sim panel mode");
> +
> +struct panel_simulation {
> +       struct drm_panel base;
> +       struct platform_device *platform;
> +} *sim_panel;
> +
> +static struct drm_display_mode panel_simulation_mode = {
> +       .clock = 345830,
> +       .hdisplay = 1080,
> +       .hsync_start = 1175,
> +       .hsync_end = 1176,
> +       .htotal = 1216,
> +       .vdisplay = 2340,
> +       .vsync_start = 2365,
> +       .vsync_end = 2366,
> +       .vtotal = 2370,
> +       .width_mm = 0,
> +       .height_mm = 0,
> +       .type = DRM_MODE_TYPE_DRIVER,
> +};
> +
> +static int panel_simulation_parse_mode(void)
> +{
> +       int count;
> +       struct drm_display_mode user_mode = { 0 };
> +       unsigned int vrefresh;
> +
> +       if (sim_panel_mode[0] == '\0')
> +               return 0;
> +
> +       count = sscanf(sim_panel_mode, "%hu,%hu,%hu,%hu,%hu,%hu,%hu,%hu-%u",
> +                            &user_mode.hdisplay, &user_mode.hsync_start,
> +                            &user_mode.hsync_end, &user_mode.htotal,
> +                            &user_mode.vdisplay, &user_mode.vsync_start,
> +                            &user_mode.vsync_end, &user_mode.vtotal, &vrefresh);
> +
> +       if (count != 9)
> +               return -EINVAL;
> +
> +       user_mode.clock = user_mode.htotal * user_mode.vtotal * vrefresh / 1000;

Does this compile / work on 32-bit platforms?

> +       memcpy(&panel_simulation_mode, &user_mode, sizeof(struct drm_display_mode));

We probably should set dpi through the modparam and calculate width_mm
/ height_mm here

> +
> +       return 0;
> +}
> +
> +static int panel_simulation_get_modes(struct drm_panel *panel,
> +                                   struct drm_connector *connector)
> +{
> +       struct drm_display_mode *mode;
> +       int ret;
> +
> +       ret = panel_simulation_parse_mode();
> +
> +       mode = drm_mode_duplicate(connector->dev, &panel_simulation_mode);
> +       if (!mode)
> +               return -ENOMEM;
> +
> +       drm_mode_set_name(mode);
> +       mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +       connector->display_info.width_mm = mode->width_mm;
> +       connector->display_info.height_mm = mode->height_mm;
> +       drm_mode_probed_add(connector, mode);


drm_connector_helper_get_modes_fixed() ?

> +
> +       return 1;
> +}
> +
> +static const struct drm_panel_funcs panel_simulation_funcs = {
> +       .get_modes = panel_simulation_get_modes,
> +};
> +
> +static int panel_simulation_probe(struct mipi_dsi_device *dsi)
> +{
> +       struct panel_simulation *panel;
> +       struct device *dev = &dsi->dev;
> +       int ret;
> +
> +       panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
> +       if (!panel)
> +               return -ENOMEM;
> +
> +       mipi_dsi_set_drvdata(dsi, panel);
> +
> +       dsi->lanes = 4;
> +       dsi->format = MIPI_DSI_FMT_RGB888;
> +       dsi->mode_flags = MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS;

I think these might need to be configurable too. Maybe in a follow up patch.

> +
> +       drm_panel_init(&panel->base, dev, &panel_simulation_funcs, DRM_MODE_CONNECTOR_DSI);
> +       drm_panel_add(&panel->base);
> +
> +       ret = mipi_dsi_attach(dsi);
> +       if (ret)
> +               drm_panel_remove(&panel->base);
> +
> +       return ret;
> +}
> +
> +static void panel_simulation_remove(struct mipi_dsi_device *dsi)
> +{
> +       struct panel_simulation *panel = mipi_dsi_get_drvdata(dsi);
> +       int err;
> +
> +       err = mipi_dsi_detach(dsi);
> +       if (err < 0)
> +               dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
> +
> +       drm_panel_remove(&panel->base);
> +       drm_panel_disable(&panel->base);
> +       drm_panel_unprepare(&panel->base);
> +}
> +
> +static void panel_simulation_shutdown(struct mipi_dsi_device *dsi)
> +{
> +       struct panel_simulation *panel = dev_get_drvdata(&dsi->dev);
> +
> +       drm_panel_disable(&panel->base);
> +       drm_panel_unprepare(&panel->base);
> +}
> +
> +static struct mipi_dsi_driver panel_simulation_driver = {
> +       .driver = {
> +               .name = "panel_simulation",
> +       },
> +       .probe = panel_simulation_probe,
> +       .remove = panel_simulation_remove,
> +       .shutdown = panel_simulation_shutdown,
> +};
> +module_mipi_dsi_driver(panel_simulation_driver);
> +
> +MODULE_AUTHOR("Jessica Zhang <quic_jesszhan@quicinc.com>");
> +MODULE_DESCRIPTION("DRM Driver for Simulated Panels");
> +MODULE_LICENSE("GPL");
>
> --
> 2.43.0
>


-- 
With best wishes
Dmitry

