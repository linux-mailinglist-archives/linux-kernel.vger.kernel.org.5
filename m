Return-Path: <linux-kernel+bounces-85322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3B286B42D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5BC1C213E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D5515D5CE;
	Wed, 28 Feb 2024 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZMkwLiBR"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC615B98B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136467; cv=none; b=sVFBmRvrbEZ2pa6uMvkFKs71cjN4/XSSQqFCOeQQXM9p9Ek/T5OJ/8lZJ4jjspFARqPrNy8BcNuPhSCxf+1kB9p3Zoj222C8nIDehacJrAYs5nSIxs+QCMFsg/d4Yupxc4jJ0Y+PohtHgSQUyFrP1SnXiBbvRJKD7DyWb9OWr90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136467; c=relaxed/simple;
	bh=FiRbaHPXoxiQwJ+RgsN41gLXp55/XWSH1L297zhy21I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sponWykF/jVNf5gpD8dD8C62tdlnPqr2X8oU16CxlcO0XZ4zIxs303yA32rZphF43SjWCPPGoMPGwIzLF3++tK6vburCBkDWtsTu40KdvMXdlSpJu+LBmocs2RGcqVWBIs+nuAhffZ6qL9KIy9UNthd4oDy/PJoOUXKbKprLbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZMkwLiBR; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D1CCC6B3;
	Wed, 28 Feb 2024 17:07:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709136450;
	bh=FiRbaHPXoxiQwJ+RgsN41gLXp55/XWSH1L297zhy21I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMkwLiBReuJPjxjMz597P8K210ciiqrnyTs7gw+PRWo98Vzr/2yGaIWkzD9kNvNem
	 LCyVc39CGWjuO/PdhcSgYkZkAC8Zde6/XWAwKuYs7SbiY5y9BXXdIXreCxo5oV3MMC
	 /wLMi5gSzi4gc8anJW4kQXqVOAyLc8cxn54Hqm34=
Date: Wed, 28 Feb 2024 18:07:44 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] drm: xlnx: zynqmp_dpsub: Set input live format
Message-ID: <20240228160744.GD9863@pendragon.ideasonboard.com>
References: <20240226-dp-live-fmt-v1-0-b78c3f69c9d8@amd.com>
 <20240226-dp-live-fmt-v1-3-b78c3f69c9d8@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240226-dp-live-fmt-v1-3-b78c3f69c9d8@amd.com>

Hi Anatoliy,

Thank you for the patch.

On Mon, Feb 26, 2024 at 08:44:44PM -0800, Anatoliy Klymenko wrote:
> Program live video input format according to selected media bus format.
> 
> In the bridge mode of operation, DPSUB is connected to FPGA CRTC which
> almost certainly supports a single media bus format as its output. Expect
> this to be delivered via the new bridge atomic state. Program DPSUB
> registers accordingly.
> 
> Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c      | 52 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/xlnx/zynqmp_disp.h      |  2 ++
>  drivers/gpu/drm/xlnx/zynqmp_disp_regs.h |  8 ++---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c        | 13 ++++++---
>  4 files changed, 67 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index ee99aad915ba..1c3ffdee6b8e 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -416,6 +416,34 @@ static bool zynqmp_disp_layer_is_video(const struct zynqmp_disp_layer *layer)
>  	return layer->id == ZYNQMP_DPSUB_LAYER_VID;
>  }
>  
> +/**
> + * zynqmp_disp_avbuf_set_live_format - Set live input format for a layer
> + * @disp: Display controller
> + * @layer: The layer
> + * @fmt: The format information
> + *
> + * Set the live video input format for @layer to @fmt.
> + */
> +static void zynqmp_disp_avbuf_set_live_format(struct zynqmp_disp *disp,
> +					      struct zynqmp_disp_layer *layer,
> +					      const struct zynqmp_disp_format *fmt)
> +{
> +	u32 reg, i;
> +
> +	reg = zynqmp_disp_layer_is_video(layer)
> +	    ? ZYNQMP_DISP_AV_BUF_LIVE_VID_CONFIG
> +	    : ZYNQMP_DISP_AV_BUF_LIVE_GFX_CONFIG;
> +	zynqmp_disp_avbuf_write(disp, reg, fmt->buf_fmt);
> +
> +	for (i = 0; i < ZYNQMP_DISP_AV_BUF_NUM_SF; ++i) {
> +		reg = zynqmp_disp_layer_is_video(layer)
> +		    ? ZYNQMP_DISP_AV_BUF_LIVD_VID_COMP_SF(i)
> +		    : ZYNQMP_DISP_AV_BUF_LIVD_GFX_COMP_SF(i);
> +		zynqmp_disp_avbuf_write(disp, reg, fmt->sf[i]);
> +	}

This is identical to zynqmp_disp_avbuf_set_format(), you should avoid
duplicating code.

> +	layer->disp_fmt = fmt;
> +}
> +
>  /**
>   * zynqmp_disp_avbuf_set_format - Set the input format for a layer
>   * @disp: Display controller
> @@ -979,6 +1007,30 @@ void zynqmp_disp_layer_disable(struct zynqmp_disp_layer *layer)
>  	zynqmp_disp_blend_layer_disable(layer->disp, layer);
>  }
>  
> +/**
> + * zynqmp_disp_layer_set_live_format - Set live layer input format
> + * @layer: The layer
> + * @info: Input media bus format
> + *
> + * Set the live @layer input bus format. The layer must be disabled.
> + */
> +void zynqmp_disp_layer_set_live_format(struct zynqmp_disp_layer *layer,
> +				       u32 bus_format)

I'd prefer reusing zynqmp_disp_layer_set_format(), and handling the
differences between live and non-live input there. There's already a
dma_enabled check in that function.

> +{
> +	int i;
> +	const struct zynqmp_disp_format *fmt;
> +
> +	for (i = 0; i < ARRAY_SIZE(avbuf_live_fmts); ++i) {
> +		fmt = &avbuf_live_fmts[i];
> +		if (fmt->bus_fmt == bus_format) {
> +			layer->disp_fmt = fmt;
> +			layer->drm_fmt = drm_format_info(fmt->drm_fmt);
> +			zynqmp_disp_avbuf_set_live_format(layer->disp, layer, fmt);
> +			return;
> +		}
> +	}
> +}
> +
>  /**
>   * zynqmp_disp_layer_set_format - Set the layer format
>   * @layer: The layer
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.h b/drivers/gpu/drm/xlnx/zynqmp_disp.h
> index c2c8dd4896ba..f244b7d2346a 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.h
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.h
> @@ -66,6 +66,8 @@ void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer);
>  void zynqmp_disp_layer_disable(struct zynqmp_disp_layer *layer);
>  void zynqmp_disp_layer_set_format(struct zynqmp_disp_layer *layer,
>  				  const struct drm_format_info *info);
> +void zynqmp_disp_layer_set_live_format(struct zynqmp_disp_layer *layer,
> +				       u32 bus_format);
>  int zynqmp_disp_layer_update(struct zynqmp_disp_layer *layer,
>  			     struct drm_plane_state *state);
>  
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h b/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
> index f92a006d5070..fa3935384834 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
> @@ -165,10 +165,10 @@
>  #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_BPC_10		0x2
>  #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_BPC_12		0x3
>  #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_BPC_MASK		GENMASK(2, 0)
> -#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_RGB		0x0
> -#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV444	0x1
> -#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV422	0x2
> -#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YONLY	0x3
> +#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_RGB		(0x0 << 4)
> +#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV444	(0x1 << 4)
> +#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV422	(0x2 << 4)
> +#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YONLY	(0x3 << 4)

This change isn't even mentioned in the commit message. It should be
split to a separate patch.

>  #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_MASK		GENMASK(5, 4)
>  #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_CB_FIRST		BIT(8)
>  #define ZYNQMP_DISP_AV_BUF_PALETTE_MEMORY		0x400
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 9cb7ac9f3097..0d5dffd20ad1 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1281,7 +1281,8 @@ static void zynqmp_dp_disp_enable(struct zynqmp_dp *dp,
>  {
>  	enum zynqmp_dpsub_layer_id layer_id;
>  	struct zynqmp_disp_layer *layer;
> -	const struct drm_format_info *info;
> +	struct drm_bridge_state *bridge_state;
> +	u32 bus_fmt;
>  
>  	if (dp->dpsub->connected_ports & BIT(ZYNQMP_DPSUB_PORT_LIVE_VIDEO))
>  		layer_id = ZYNQMP_DPSUB_LAYER_VID;
> @@ -1291,10 +1292,14 @@ static void zynqmp_dp_disp_enable(struct zynqmp_dp *dp,
>  		return;
>  
>  	layer = dp->dpsub->layers[layer_id];
> +	bridge_state = drm_atomic_get_new_bridge_state(old_bridge_state->base.state,
> +						       old_bridge_state->bridge);
> +	if (bridge_state) {
> +		bus_fmt = bridge_state->input_bus_cfg.format;
> +		zynqmp_disp_layer_set_live_format(layer, bus_fmt);
> +	} else
> +		return;

	if (!bridge_state)
		return;

	bus_fmt = bridge_state->input_bus_cfg.format;
	zynqmp_disp_layer_set_live_format(layer, bus_fmt);

But more importantly, why would this fail ? If it does something is
seriously wrong and the display won't be working. I'd expect at least a
warning, but you should instead ensure it never fails.

>  
> -	/* TODO: Make the format configurable. */
> -	info = drm_format_info(DRM_FORMAT_YUV422);
> -	zynqmp_disp_layer_set_format(layer, info);
>  	zynqmp_disp_layer_enable(layer);
>  
>  	if (layer_id == ZYNQMP_DPSUB_LAYER_GFX)
> 

-- 
Regards,

Laurent Pinchart

