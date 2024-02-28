Return-Path: <linux-kernel+bounces-85226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0804386B27F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749121F27523
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2455E15B966;
	Wed, 28 Feb 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Aqg6B7Cg"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474CA159580
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132217; cv=none; b=YKXKmik+q0jEBCni/OaiJ1dJLVHH3TyXGeX147NLL2TcV5C2+xZ3rWkUJyQtezCkkVuk5kQisZuAC7Odzi7C7WP8L9YGVyHqQ4R2LdR9lP66/qmRs9nxC7sXh1M+bNEZO4CMIglNei+EACPAfr95roP2CWLvslOD0owbv+A0sFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132217; c=relaxed/simple;
	bh=O55w29tKHLUKo0RdPfcAcVhOTj9ZoMGpw9KOsAN3BPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGDdaMof80knzgWjZoESfJN9v5pBSIFxeneTjLvXnuxuDmZgijjjyQseVq5YxVQBKr1tF4wzY6Lx6wQLmD8lv44NlzUU9mbqmtiLItib6tREc1XCzw4mT0BoXHk3CjQSMqCT3X2MG0vKnJ15rpL9rvKyKMt/opQGS0eqBxg5FBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Aqg6B7Cg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3684B672;
	Wed, 28 Feb 2024 15:56:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709132200;
	bh=O55w29tKHLUKo0RdPfcAcVhOTj9ZoMGpw9KOsAN3BPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aqg6B7CggdTM8Q820pmR6Ab0PjOe+pqw8hg3TXjZwAf6jjcX0841oypoyISexdDF0
	 vdvUmgBEZfP8DuHpdRXwnkuhe6TAwAaaRcKMNqNFwcRtSxlGR5lqJ2ys86Q6XZf8Cl
	 U781Zhx3050iS9/dwfNNjCVdV97DUZ/TfYEDXp+8=
Date: Wed, 28 Feb 2024 16:56:54 +0200
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
Subject: Re: [PATCH 1/4] drm: xlnx: zynqmp_dpsub: Set layer mode during
 creation
Message-ID: <20240228145654.GB9863@pendragon.ideasonboard.com>
References: <20240226-dp-live-fmt-v1-0-b78c3f69c9d8@amd.com>
 <20240226-dp-live-fmt-v1-1-b78c3f69c9d8@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240226-dp-live-fmt-v1-1-b78c3f69c9d8@amd.com>

Hi Anatoliy,

Thank you for the patch.

On Mon, Feb 26, 2024 at 08:44:42PM -0800, Anatoliy Klymenko wrote:
> Set layer mode of operation (live or dma-based) during layer creation.
> 
> Each DPSUB layer mode of operation is defined by corresponding DT node port
> connection, so it is possible to assign it during layer object creation.
> Previously it was set in layer enable functions, although it is too late
> as setting layer format depends on layer mode, and should be done before
> given layer enabled.
> 
> Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 20 ++++++++++++++++----
>  drivers/gpu/drm/xlnx/zynqmp_disp.h | 13 +------------
>  drivers/gpu/drm/xlnx/zynqmp_dp.c   |  2 +-
>  drivers/gpu/drm/xlnx/zynqmp_kms.c  |  2 +-
>  4 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index 8a39b3accce5..e6d26ef60e89 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -64,6 +64,16 @@
>  
>  #define ZYNQMP_DISP_MAX_NUM_SUB_PLANES			3
>  
> +/**
> + * enum zynqmp_dpsub_layer_mode - Layer mode
> + * @ZYNQMP_DPSUB_LAYER_NONLIVE: non-live (memory) mode
> + * @ZYNQMP_DPSUB_LAYER_LIVE: live (stream) mode
> + */
> +enum zynqmp_dpsub_layer_mode {
> +	ZYNQMP_DPSUB_LAYER_NONLIVE,
> +	ZYNQMP_DPSUB_LAYER_LIVE,
> +};
> +
>  /**
>   * struct zynqmp_disp_format - Display subsystem format information
>   * @drm_fmt: DRM format (4CC)
> @@ -902,15 +912,12 @@ u32 *zynqmp_disp_layer_drm_formats(struct zynqmp_disp_layer *layer,
>  /**
>   * zynqmp_disp_layer_enable - Enable a layer
>   * @layer: The layer
> - * @mode: Operating mode of layer
>   *
>   * Enable the @layer in the audio/video buffer manager and the blender. DMA
>   * channels are started separately by zynqmp_disp_layer_update().
>   */
> -void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer,
> -			      enum zynqmp_dpsub_layer_mode mode)
> +void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer)
>  {
> -	layer->mode = mode;
>  	zynqmp_disp_avbuf_enable_video(layer->disp, layer);
>  	zynqmp_disp_blend_layer_enable(layer->disp, layer);
>  }
> @@ -1134,6 +1141,11 @@ static int zynqmp_disp_create_layers(struct zynqmp_disp *disp)
>  		layer->id = i;
>  		layer->disp = disp;
>  		layer->info = &layer_info[i];
> +		/* For now assume dpsub works in either live or non-live mode for both layers.
> +		 * Hybrid mode is not supported yet.
> +		 */

		/*
		 * For now assume dpsub works in either live or non-live mode
		 * for both layers. Hybrid mode is not supported yet.
		 */

Sounds like a reasonable restriction for now.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +		layer->mode = disp->dpsub->dma_enabled ? ZYNQMP_DPSUB_LAYER_NONLIVE
> +						       : ZYNQMP_DPSUB_LAYER_LIVE;
>  
>  		ret = zynqmp_disp_layer_request_dma(disp, layer);
>  		if (ret)
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.h b/drivers/gpu/drm/xlnx/zynqmp_disp.h
> index 123cffac08be..9b8b202224d9 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.h
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.h
> @@ -42,16 +42,6 @@ enum zynqmp_dpsub_layer_id {
>  	ZYNQMP_DPSUB_LAYER_GFX,
>  };
>  
> -/**
> - * enum zynqmp_dpsub_layer_mode - Layer mode
> - * @ZYNQMP_DPSUB_LAYER_NONLIVE: non-live (memory) mode
> - * @ZYNQMP_DPSUB_LAYER_LIVE: live (stream) mode
> - */
> -enum zynqmp_dpsub_layer_mode {
> -	ZYNQMP_DPSUB_LAYER_NONLIVE,
> -	ZYNQMP_DPSUB_LAYER_LIVE,
> -};
> -
>  void zynqmp_disp_enable(struct zynqmp_disp *disp);
>  void zynqmp_disp_disable(struct zynqmp_disp *disp);
>  int zynqmp_disp_setup_clock(struct zynqmp_disp *disp,
> @@ -62,8 +52,7 @@ void zynqmp_disp_blend_set_global_alpha(struct zynqmp_disp *disp,
>  
>  u32 *zynqmp_disp_layer_drm_formats(struct zynqmp_disp_layer *layer,
>  				   unsigned int *num_formats);
> -void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer,
> -			      enum zynqmp_dpsub_layer_mode mode);
> +void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer);
>  void zynqmp_disp_layer_disable(struct zynqmp_disp_layer *layer);
>  void zynqmp_disp_layer_set_format(struct zynqmp_disp_layer *layer,
>  				  const struct drm_format_info *info);
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 1846c4971fd8..04b6bcac3b07 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1295,7 +1295,7 @@ static void zynqmp_dp_disp_enable(struct zynqmp_dp *dp,
>  	/* TODO: Make the format configurable. */
>  	info = drm_format_info(DRM_FORMAT_YUV422);
>  	zynqmp_disp_layer_set_format(layer, info);
> -	zynqmp_disp_layer_enable(layer, ZYNQMP_DPSUB_LAYER_LIVE);
> +	zynqmp_disp_layer_enable(layer);
>  
>  	if (layer_id == ZYNQMP_DPSUB_LAYER_GFX)
>  		zynqmp_disp_blend_set_global_alpha(dp->dpsub->disp, true, 255);
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> index db3bb4afbfc4..43bf416b33d5 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> @@ -122,7 +122,7 @@ static void zynqmp_dpsub_plane_atomic_update(struct drm_plane *plane,
>  
>  	/* Enable or re-enable the plane if the format has changed. */
>  	if (format_changed)
> -		zynqmp_disp_layer_enable(layer, ZYNQMP_DPSUB_LAYER_NONLIVE);
> +		zynqmp_disp_layer_enable(layer);
>  }
>  
>  static const struct drm_plane_helper_funcs zynqmp_dpsub_plane_helper_funcs = {
> 

-- 
Regards,

Laurent Pinchart

