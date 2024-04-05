Return-Path: <linux-kernel+bounces-133027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535BF899DAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE29F1F23E3F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D703B16D327;
	Fri,  5 Apr 2024 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nahZn9pQ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1035716ABFA;
	Fri,  5 Apr 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321804; cv=none; b=JanqzgDWPCYEfWykdmiXq8k5iD2mXgfl/cuIoEDimVwPoL0B0LNIks7FQaz5BiNo97N4Cr6wFTrRsUQ6Q+iKtYK2+BsrGO0dDHM//aGmAHAY80L1NWGjBr5DxWspVJ97QBRRZEpKzCd30CxSN9O46EBrQFoZbgRtMlep/F3BNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321804; c=relaxed/simple;
	bh=E94Vm2YqIHWCP3Ytx38QK62FpLjk4a891f9RaR8YcQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkY0MbfuTxD9RUSB9Gv9zOIBItM40bPtafkHqLdSWxNNZvlpoQt/6x6cBFxTzAmuSX+CSnDxs/xYO6gDDSRKnpyQ9jN/aFZ+zIu8fOhX2bWRn6mEffsFRsEtXr8FzkZN/UOhz5WOOZRScdTSlBGC6oDc42OV5psRU1eMKMYsddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nahZn9pQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E35C98E1;
	Fri,  5 Apr 2024 14:56:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712321762;
	bh=E94Vm2YqIHWCP3Ytx38QK62FpLjk4a891f9RaR8YcQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nahZn9pQcSG2rMxbKmzi8excYLWCq9MQ0YVNbGg2kiuPENPJ2ASvkfvcQTVlCzeH5
	 ZIpCY/U9uDZ53+opAPQ+2RVznnNzqhfULY6huwoJxL+RyZeLeJj6BAqNpXkdokebDW
	 LMWubw4NfMuRmE9JLufVDcQ0CYFBzA2vxhkTbzFM=
Message-ID: <47947c68-8f1d-46a2-acb4-4ac008e5cb74@ideasonboard.com>
Date: Fri, 5 Apr 2024 15:56:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] drm: xlnx: zynqmp_dpsub: Set input live format
To: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-media@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20240321-dp-live-fmt-v3-0-d5090d796b7e@amd.com>
 <20240321-dp-live-fmt-v3-6-d5090d796b7e@amd.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20240321-dp-live-fmt-v3-6-d5090d796b7e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/03/2024 22:43, Anatoliy Klymenko wrote:
> Program live video input format according to selected media bus format.
> 
> In the bridge mode of operation, DPSUB is connected to FPGA CRTC which
> almost certainly supports a single media bus format as its output. Expect
> this to be delivered via the new bridge atomic state. Program DPSUB
> registers accordingly. Update zynqmp_disp_layer_set_format() API to fit
> both live and non-live layer types.
> 
> Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
> ---
>   drivers/gpu/drm/xlnx/zynqmp_disp.c | 66 +++++++++++++++++++++++++-------------
>   drivers/gpu/drm/xlnx/zynqmp_disp.h |  2 +-
>   drivers/gpu/drm/xlnx/zynqmp_dp.c   | 13 +++++---
>   drivers/gpu/drm/xlnx/zynqmp_kms.c  |  2 +-
>   4 files changed, 55 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index 0c2b3f4bffa6..a385d22d428e 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -436,19 +436,28 @@ static void zynqmp_disp_avbuf_set_format(struct zynqmp_disp *disp,
>   					 const struct zynqmp_disp_format *fmt)
>   {
>   	unsigned int i;
> -	u32 val;
> +	u32 val, reg;
>   
> -	val = zynqmp_disp_avbuf_read(disp, ZYNQMP_DISP_AV_BUF_FMT);
> -	val &= zynqmp_disp_layer_is_video(layer)
> -	    ? ~ZYNQMP_DISP_AV_BUF_FMT_NL_VID_MASK
> -	    : ~ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_MASK;
> -	val |= fmt->buf_fmt;
> -	zynqmp_disp_avbuf_write(disp, ZYNQMP_DISP_AV_BUF_FMT, val);
> +	layer->disp_fmt = fmt;
> +	if (layer->mode == ZYNQMP_DPSUB_LAYER_NONLIVE) {
> +		reg = ZYNQMP_DISP_AV_BUF_FMT;
> +		val = zynqmp_disp_avbuf_read(disp, ZYNQMP_DISP_AV_BUF_FMT);
> +		val &= zynqmp_disp_layer_is_video(layer)
> +		    ? ~ZYNQMP_DISP_AV_BUF_FMT_NL_VID_MASK
> +		    : ~ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_MASK;
> +		val |= fmt->buf_fmt;
> +	} else {
> +		reg = zynqmp_disp_layer_is_video(layer)
> +		    ? ZYNQMP_DISP_AV_BUF_LIVE_VID_CONFIG
> +		    : ZYNQMP_DISP_AV_BUF_LIVE_GFX_CONFIG;
> +		val = fmt->buf_fmt;
> +	}
> +	zynqmp_disp_avbuf_write(disp, reg, val);

Just write the registers inside the above if-else blocks.

>   
>   	for (i = 0; i < ZYNQMP_DISP_AV_BUF_NUM_SF; i++) {
> -		unsigned int reg = zynqmp_disp_layer_is_video(layer)
> -				 ? ZYNQMP_DISP_AV_BUF_VID_COMP_SF(i)
> -				 : ZYNQMP_DISP_AV_BUF_GFX_COMP_SF(i);
> +		reg = zynqmp_disp_layer_is_video(layer)
> +		    ? ZYNQMP_DISP_AV_BUF_VID_COMP_SF(i)
> +		    : ZYNQMP_DISP_AV_BUF_GFX_COMP_SF(i);
>   
>   		zynqmp_disp_avbuf_write(disp, reg, fmt->sf[i]);
>   	}
> @@ -902,25 +911,33 @@ static void zynqmp_disp_audio_disable(struct zynqmp_disp *disp)
>    */
>   
>   /**
> - * zynqmp_disp_layer_find_format - Find format information for a DRM format
> + * zynqmp_disp_layer_find_format - Find format information for a DRM or media
> + * bus format
>    * @layer: The layer
> - * @drm_fmt: DRM format to search
> + * @drm_or_bus_format: DRM or media bus format
>    *
>    * Search display subsystem format information corresponding to the given DRM
> - * format @drm_fmt for the @layer, and return a pointer to the format
> - * descriptor.
> + * or media bus format @drm_or_bus_format for the @layer, and return a pointer
> + * to the format descriptor. Search key choice depends on @layer mode, for live
> + * layers search is done by zynqmp_disp_format.bus_fmt, and for non-live layers
> + * zynqmp_disp_format.drm_fmt is used.

Here also I recommend creating separate funcs for the fourcc and mbus 
versions. They are different types, even if they happen to fit into u32.

>    *
>    * Return: A pointer to the format descriptor if found, NULL otherwise
>    */
>   static const struct zynqmp_disp_format *
>   zynqmp_disp_layer_find_format(struct zynqmp_disp_layer *layer,
> -			      u32 drm_fmt)
> +			      u32 drm_or_bus_format)
>   {
>   	unsigned int i;
> +	const struct zynqmp_disp_format *disp_format;
>   
>   	for (i = 0; i < layer->info->num_formats; i++) {
> -		if (layer->info->formats[i].drm_fmt == drm_fmt)
> -			return &layer->info->formats[i];
> +		disp_format = &layer->info->formats[i];
> +		if ((layer->mode == ZYNQMP_DPSUB_LAYER_LIVE &&
> +		     disp_format->bus_fmt == drm_or_bus_format) ||
> +		    (layer->mode == ZYNQMP_DPSUB_LAYER_NONLIVE &&
> +		     disp_format->drm_fmt == drm_or_bus_format))
> +			return disp_format;
>   	}
>   
>   	return NULL;
> @@ -992,20 +1009,25 @@ void zynqmp_disp_layer_disable(struct zynqmp_disp_layer *layer)
>   /**
>    * zynqmp_disp_layer_set_format - Set the layer format
>    * @layer: The layer
> - * @info: The format info
> + * @drm_or_bus_format: DRM or media bus format
>    *
>    * Set the format for @layer to @info. The layer must be disabled.
>    */
>   void zynqmp_disp_layer_set_format(struct zynqmp_disp_layer *layer,
> -				  const struct drm_format_info *info)
> +				  u32 drm_or_bus_format)

And here, with a quick look, a separate function would be fine.

  Tomi

>   {
>   	unsigned int i;
>   
> -	layer->disp_fmt = zynqmp_disp_layer_find_format(layer, info->format);
> -	layer->drm_fmt = info;
> +	layer->disp_fmt = zynqmp_disp_layer_find_format(layer, drm_or_bus_format);
> +	if (WARN_ON(!layer->disp_fmt))
> +		return;
>   
>   	zynqmp_disp_avbuf_set_format(layer->disp, layer, layer->disp_fmt);
>   
> +	layer->drm_fmt = drm_format_info(layer->disp_fmt->drm_fmt);
> +	if (!layer->drm_fmt)
> +		return;
> +
>   	if (layer->mode == ZYNQMP_DPSUB_LAYER_LIVE)
>   		return;
>   
> @@ -1013,7 +1035,7 @@ void zynqmp_disp_layer_set_format(struct zynqmp_disp_layer *layer,
>   	 * Set pconfig for each DMA channel to indicate they're part of a
>   	 * video group.
>   	 */
> -	for (i = 0; i < info->num_planes; i++) {
> +	for (i = 0; i < layer->drm_fmt->num_planes; i++) {
>   		struct zynqmp_disp_layer_dma *dma = &layer->dmas[i];
>   		struct xilinx_dpdma_peripheral_config pconfig = {
>   			.video_group = true,
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.h b/drivers/gpu/drm/xlnx/zynqmp_disp.h
> index 88c285a12e23..9f9a5f50ffbc 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.h
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.h
> @@ -55,7 +55,7 @@ u32 *zynqmp_disp_layer_formats(struct zynqmp_disp_layer *layer,
>   void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer);
>   void zynqmp_disp_layer_disable(struct zynqmp_disp_layer *layer);
>   void zynqmp_disp_layer_set_format(struct zynqmp_disp_layer *layer,
> -				  const struct drm_format_info *info);
> +				  u32 drm_or_bus_format);
>   int zynqmp_disp_layer_update(struct zynqmp_disp_layer *layer,
>   			     struct drm_plane_state *state);
>   
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index e3b9eb3d9273..200e63636006 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1299,15 +1299,20 @@ static void zynqmp_dp_disp_enable(struct zynqmp_dp *dp,
>   				  struct drm_bridge_state *old_bridge_state)
>   {
>   	struct zynqmp_disp_layer *layer;
> -	const struct drm_format_info *info;
> +	struct drm_bridge_state *bridge_state;
> +	u32 bus_fmt;
>   
>   	layer = zynqmp_dp_disp_connected_live_layer(dp);
>   	if (!layer)
>   		return;
>   
> -	/* TODO: Make the format configurable. */
> -	info = drm_format_info(DRM_FORMAT_YUV422);
> -	zynqmp_disp_layer_set_format(layer, info);
> +	bridge_state = drm_atomic_get_new_bridge_state(old_bridge_state->base.state,
> +						       old_bridge_state->bridge);
> +	if (WARN_ON(!bridge_state))
> +		return;
> +
> +	bus_fmt = bridge_state->input_bus_cfg.format;
> +	zynqmp_disp_layer_set_format(layer, bus_fmt);
>   	zynqmp_disp_layer_enable(layer);
>   
>   	if (layer == dp->dpsub->layers[ZYNQMP_DPSUB_LAYER_GFX])
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> index bf9fba01df0e..d96b3f3f2e3a 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> @@ -111,7 +111,7 @@ static void zynqmp_dpsub_plane_atomic_update(struct drm_plane *plane,
>   		if (old_state->fb)
>   			zynqmp_disp_layer_disable(layer);
>   
> -		zynqmp_disp_layer_set_format(layer, new_state->fb->format);
> +		zynqmp_disp_layer_set_format(layer, new_state->fb->format->format);
>   	}
>   
>   	zynqmp_disp_layer_update(layer, new_state);
> 


