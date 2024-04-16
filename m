Return-Path: <linux-kernel+bounces-147517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B45D8A7589
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6611F241B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2418113A24D;
	Tue, 16 Apr 2024 20:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tyXNSo8B"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D82C6A3;
	Tue, 16 Apr 2024 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299297; cv=none; b=KaUv4Ob5grHN3jsoWsAnII5019Z8DhVKOBLaUM8YnDdNAJl4aDLWahnVENZNGWp3kZQZZgLTbGdtqkC8zmiUD5hXRiqxmzmvsgCfmeXsZUtVnT/60G6fGgQWni35atDW2yRplO0BmRISRWiQ0/635utEjVbNpjtOWDL9HObJjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299297; c=relaxed/simple;
	bh=uQYhJ7WhClFGzmNQMCJz75uJhcA7evQYHbGVmP+wBi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNqROhXw+NJ01wLmONxTDDvJQRZcepEllR5AMRt9bJOTiyKb2EdPmY/sE0jakrqAGEODLboRupzUq1ieExzTFpUMC4BE3WDWXW9A8K/6/V2ExMHsho496RRagwyFjaM0Wv9D3wkg3/Mh9ROug6HfA06CSGScP8ij1PyWoMYLl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tyXNSo8B; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id wpPIr4rKwJyTUwpPIrI9PX; Tue, 16 Apr 2024 22:28:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713299283;
	bh=6NAIXi4V2CyDIBGCO7IWkHyMEgnTzqCwkzfq/h/mMuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=tyXNSo8B7EnAUKS1e+KW+mkiLn1/6R8tzRJ+fpQg0WsbOpEndvwU4n181hvn30gsE
	 zg/UcWYOGd1CX2OgsUTbDn0DL3tlsj7MDwzWJ1v9l6YCNLldcoSvIaCGEP5QXnG9y5
	 GzqPA8/PUEjZUPb/5ZWAbSqLw2o00rXCXUFsPBL/IofzMo4pfWPcXBXF+q7q+pBhzH
	 q3eiduhBMxD1FBI+P8HCjlB85APKc22jSD7yf96Fj0Cd34/kxy2iE1ULtCrgWV/Uro
	 wkelgnH/oOmNEUqoOPyD9DIqGjQzOf1cNzabljZr+JgK/QOnsFLRUxSKhbHAvF4BTT
	 qlDwuzv6tDDlg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 16 Apr 2024 22:28:03 +0200
X-ME-IP: 86.243.17.157
Message-ID: <a92ea6be-d518-4e8a-86a3-1985ff54a24a@wanadoo.fr>
Date: Tue, 16 Apr 2024 22:27:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/panel: Add driver for EDO RM69380 OLED panel
To: david@mainlining.org
Cc: conor+dt@kernel.org, daniel@ffwll.ch, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, konradybcio@kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 marijn.suijten@somainline.org, mripard@kernel.org,
 neil.armstrong@linaro.org, phone-devel@vger.kernel.org,
 quic_jesszhan@quicinc.com, robh@kernel.org, sam@ravnborg.org,
 tzimmermann@suse.de, ~postmarketos/upstreaming@lists.sr.ht
References: <20240416-raydium-rm69380-driver-v3-0-21600ac4ce5f@mainlining.org>
 <20240416-raydium-rm69380-driver-v3-2-21600ac4ce5f@mainlining.org>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240416-raydium-rm69380-driver-v3-2-21600ac4ce5f@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/04/2024 à 20:30, David Wronek a écrit :
> Add support for the 2560x1600@90Hz OLED panel by EDO bundled with a
> Raydium RM69380 controller, as found on the Lenovo Xiaoxin Pad Pro 2021.
> 
> Signed-off-by: David Wronek <david-vu3DzTD92ROXwddmVfQv5g@public.gmane.org>
> ---
>   drivers/gpu/drm/panel/Kconfig                 |  14 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   drivers/gpu/drm/panel/panel-raydium-rm69380.c | 367 ++++++++++++++++++++++++++
>   3 files changed, 382 insertions(+)
> 

..

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
> +		const struct mipi_dsi_device_info info = { "RM69380", 0,
> +							   dsi_sec };
> +
> +		dev_dbg(dev, "Using Dual-DSI: found `%s`\n", dsi_sec->name);
> +
> +		dsi_sec_host = of_find_mipi_dsi_host_by_node(dsi_sec);
> +		of_node_put(dsi_sec);
> +		if (!dsi_sec_host)
> +			return dev_err_probe(dev, -EPROBE_DEFER,
> +					     "Cannot get secondary DSI host\n");
> +
> +		ctx->dsi[1] =
> +			devm_mipi_dsi_device_register_full(dev, dsi_sec_host, &info);
> +		if (IS_ERR(ctx->dsi[1]))
> +			return dev_err_probe(dev, PTR_ERR(ctx->dsi[1]),
> +					     "Cannot get secondary DSI node\n");
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
> +			mipi_dsi_detach(ctx->dsi[i]);

I don't think this works.
if 'i' fails, you have to detach 0...i-1

maybe something like below (complety untested).

> +			drm_panel_remove(&ctx->panel);
> +			return dev_err_probe(dev, ret,
> +					     "Failed to attach to DSI%d\n", i);
> +		}
> +	}
> +
> +	return 0;
> +}


	drm_panel_add(&ctx->panel);

	for (i = 0; i < ARRAY_SIZE(ctx->dsi); i++) {
		if (!ctx->dsi[i])
			continue;

		dev_dbg(&ctx->dsi[i]->dev, "Binding DSI %d\n", i);

		ctx->dsi[i]->lanes = 4;
		ctx->dsi[i]->format = MIPI_DSI_FMT_RGB888;
		ctx->dsi[i]->mode_flags = MIPI_DSI_MODE_VIDEO_BURST |
					  MIPI_DSI_CLOCK_NON_CONTINUOUS;

		ret = mipi_dsi_attach(ctx->dsi[i]);
		if (ret < 0) {
			dev_err_probe(dev, ret,
				      "Failed to attach to DSI%d\n", i);
			goto err_detach_dsi;
		}
	}

	return 0;

err_detach_dsi:
	while (--i >= 0)
		if (ctx->dsi[i])
			mipi_dsi_detach(ctx->dsi[i]);

	drm_panel_remove(&ctx->panel);

	return ret;
}



