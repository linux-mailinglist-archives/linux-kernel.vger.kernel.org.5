Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EA477AA3F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 19:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjHMRLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 13:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjHMRLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 13:11:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E369E6C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 10:11:24 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5231410ab27so4590435a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691946683; x=1692551483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHFutzp1lkuAzp7C6TTKwSkYcO+SBglGJ1K/L7mw4gw=;
        b=o9TMb4SReKOwfWxMKfrwB4/vTZpeZWyGQXeJvOg1s3T8zbm0Mj7XugiSuKLvm7YcCn
         bHkcXbHYqBxyZKFXLDeBqXziCr/7lIy8vOUGa0lYcLn83Dx9Ml/tDd45F17rLmibwCKe
         qKsT4r1PtIeSmh3/hGATZ7x2m3e5PFh1E3Bz7pekqeRSyKNfxpNGp7lpzsCXMyKkrY8q
         jcfiGKLNAQasKSGccz5J32Uq/rVwOVf9Sc2Fhzy72F0vHp2ngcjn2iA4b3HV6lD20Kny
         Nz6TH0AN7nepq/A5zQU6ojwz2cL6WvTAO3xEie8JpnCYco6NfnT08emquEBe+DMmhqDR
         vOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691946683; x=1692551483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHFutzp1lkuAzp7C6TTKwSkYcO+SBglGJ1K/L7mw4gw=;
        b=BhYPJRMuDNP4L/cQ+LLwiqWgC9blr9b/lG1nQgo3d9XALo7VepXZi86+TO8fhu8gCO
         tgFia5+ljrKchPalOmZNr0GT4qux5W47owbIslvdTZpvpbUz43H0i0AC0X8JAWrN3d5F
         hsLmJWVexCghUw6kG8pYd9PzmebpebbNvJGi7yXMP/jNBJmExOg1RqHLzN119N50NTzH
         SzaZvK78kFYTsGqj164k1YZ1pS64U3GfM4RpNdhDOGxP/PFz+rliYNpE6nxbsGjuljm9
         hqp4lgFeDQGtEVDVzHHLO+CZqXb35o128C598QUPtu0/mLrtqqJLv35V+KLZjo9Cz2tk
         OUbw==
X-Gm-Message-State: AOJu0YxBfYsuPQ2mXMGMbDV00VHjR6UUJ1aSyulLwjRlASrdBkEDtaGv
        n1net3T5tx9iVv/jXISUEL4=
X-Google-Smtp-Source: AGHT+IGxwE25b4Q85fMHwh7v/00Z2AwRFjnXpuBM11awbLV6j98vP7NGBjbS9S3CEQtOh3deTspiKQ==
X-Received: by 2002:a17:906:5357:b0:99b:5574:7d0f with SMTP id j23-20020a170906535700b0099b55747d0fmr6403239ejo.23.1691946682482;
        Sun, 13 Aug 2023 10:11:22 -0700 (PDT)
Received: from ?IPV6:2a02:908:8b3:1840:ff34:2f15:5fe7:679d? ([2a02:908:8b3:1840:ff34:2f15:5fe7:679d])
        by smtp.gmail.com with ESMTPSA id k10-20020a170906970a00b0099bc5e5742asm4809698ejx.70.2023.08.13.10.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 10:11:21 -0700 (PDT)
Message-ID: <e857d383-2287-a985-24c5-fa1fff1da199@gmail.com>
Date:   Sun, 13 Aug 2023 19:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/11] drm/bridge: tc358768: Add
 DRM_BRIDGE_ATTACH_NO_CONNECTOR support
Content-Language: en-US
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
 <20230804-tc358768-v1-11-1afd44b7826b@ideasonboard.com>
From:   Maxim Schwalm <maxim.schwalm@gmail.com>
In-Reply-To: <20230804-tc358768-v1-11-1afd44b7826b@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.23 12:44, Tomi Valkeinen wrote:
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 64 +++++++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index ea19de5509ed..a567f136ddc7 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -131,8 +131,17 @@ static const char * const tc358768_supplies[] = {
>  
>  struct tc358768_dsi_output {
>  	struct mipi_dsi_device *dev;
> +
> +	/* Legacy field if DRM_BRIDGE_ATTACH_NO_CONNECTOR is not used */
>  	struct drm_panel *panel;
> -	struct drm_bridge *bridge;
> +
> +	/*
> +	 * If DRM_BRIDGE_ATTACH_NO_CONNECTOR is not used and a panel is attached
> +	 * to tc358768, 'next_bridge' contains the bridge the driver created
> +	 * with drm_panel_bridge_add_typed(). Otherwise 'next_bridge' contains
> +	 * the next bridge the driver found.
> +	 */
> +	struct drm_bridge *next_bridge;
>  };
>  
>  struct tc358768_priv {
> @@ -391,8 +400,6 @@ static int tc358768_dsi_host_attach(struct mipi_dsi_host *host,
>  				    struct mipi_dsi_device *dev)
>  {
>  	struct tc358768_priv *priv = dsi_host_to_tc358768(host);
> -	struct drm_bridge *bridge;
> -	struct drm_panel *panel;
>  	struct device_node *ep;
>  	int ret;
>  
> @@ -420,21 +427,7 @@ static int tc358768_dsi_host_attach(struct mipi_dsi_host *host,
>  		return -ENOTSUPP;
>  	}
>  
> -	ret = drm_of_find_panel_or_bridge(host->dev->of_node, 1, 0, &panel,
> -					  &bridge);
> -	if (ret)
> -		return ret;
> -
> -	if (panel) {
> -		bridge = drm_panel_bridge_add_typed(panel,
> -						    DRM_MODE_CONNECTOR_DSI);
> -		if (IS_ERR(bridge))
> -			return PTR_ERR(bridge);
> -	}
> -
>  	priv->output.dev = dev;
> -	priv->output.bridge = bridge;
> -	priv->output.panel = panel;
>  
>  	priv->dsi_lanes = dev->lanes;
>  	priv->dsi_bpp = mipi_dsi_pixel_format_to_bpp(dev->format);
> @@ -463,7 +456,7 @@ static int tc358768_dsi_host_detach(struct mipi_dsi_host *host,
>  
>  	drm_bridge_remove(&priv->bridge);
>  	if (priv->output.panel)
> -		drm_panel_bridge_remove(priv->output.bridge);
> +		drm_panel_bridge_remove(priv->output.next_bridge);
>  
>  	return 0;
>  }
> @@ -544,7 +537,40 @@ static int tc358768_bridge_attach(struct drm_bridge *bridge,
>  		return -ENOTSUPP;
>  	}
>  
> -	return drm_bridge_attach(bridge->encoder, priv->output.bridge, bridge,
> +	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
> +		struct device_node *node;
> +
> +		/* Get the next bridge, connected to port@1. */
> +		node = of_graph_get_remote_node(priv->dev->of_node, 1, -1);
> +		if (!node)
> +			return -ENODEV;
> +
> +		priv->output.next_bridge = of_drm_find_bridge(node);
> +		of_node_put(node);
> +		if (!priv->output.next_bridge)
> +			return -EPROBE_DEFER;
> +	} else {
> +		struct drm_bridge *bridge;
> +		struct drm_panel *panel;
> +		int ret;
> +
> +		ret = drm_of_find_panel_or_bridge(priv->dev->of_node, 1, 0,
> +						  &panel, &bridge);
> +		if (ret)
> +			return ret;
> +
> +		if (panel) {
> +			bridge = drm_panel_bridge_add_typed(panel,
> +				DRM_MODE_CONNECTOR_DSI);
> +			if (IS_ERR(bridge))
> +				return PTR_ERR(bridge);
> +		}
> +
> +		priv->output.next_bridge = bridge;
> +		priv->output.panel = panel;
> +	}
> +
> +	return drm_bridge_attach(bridge->encoder, priv->output.next_bridge, bridge,
>  				 flags);
>  }
>  
>
This patch unfortunately breaks the display output on the Asus TF700T:

[drm:drm_bridge_attach] *ERROR* failed to attach bridge /i2c-mux/i2c@1/dsi@7 to encoder LVDS-59: -517
tegra-dc 54200000.dc: failed to initialize RGB output: -517
drm drm: failed to initialize 54200000.dc: -517
------------[ cut here ]------------
WARNING: CPU: 3 PID: 69 at lib/refcount.c:28 tegra_dc_init+0x24/0x5fc
refcount_t: underflow; use-after-free.
Modules linked in: elants_i2c panel_simple tc358768 atkbd vivaldi_fmap
CPU: 3 PID: 69 Comm: kworker/u8:6 Not tainted 6.5.0-rc2-postmarketos-grate #95
Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x40/0x4c
 dump_stack_lvl from __warn+0x94/0xc0
 __warn from warn_slowpath_fmt+0x118/0x16c
 warn_slowpath_fmt from tegra_dc_init+0x24/0x5fc
 tegra_dc_init from host1x_device_init+0x84/0x15c
 host1x_device_init from host1x_drm_probe+0xd8/0x3c4
 host1x_drm_probe from really_probe+0xc8/0x2dc
 really_probe from __driver_probe_device+0x88/0x19c
 __driver_probe_device from driver_probe_device+0x30/0x104
 driver_probe_device from __device_attach_driver+0x94/0x108
 __device_attach_driver from bus_for_each_drv+0x80/0xb8
 bus_for_each_drv from __device_attach+0xa0/0x190
 __device_attach from bus_probe_device+0x88/0x8c
 bus_probe_device from deferred_probe_work_func+0x78/0xa4
 deferred_probe_work_func from process_one_work+0x208/0x420
 process_one_work from worker_thread+0x54/0x550
 worker_thread from kthread+0xdc/0xf8
 kthread from ret_from_fork+0x14/0x2c
Exception stack(0xcf9c5fb0 to 0xcf9c5ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 0000000000000000 ]---

Best regards,
Maxim
