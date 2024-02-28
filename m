Return-Path: <linux-kernel+bounces-85310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E480486B3E8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B344288509
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5B615D5C2;
	Wed, 28 Feb 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UF7UvFrx"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D815D5AE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135886; cv=none; b=u9u42XDKhF8PaSdVCLCAOxcOgFxXng3ZK9E5H+5Q07bb62b5NR3cPT7nE11ISxekPpCgYxWsC9Ij2FHuGuZsns3vKeHN9vUwapRjJsrLg9MZaFu6hSbQRTHwrOVondOIxoauM6hNrAXjfXjSUKx07+4alpN69ag/DG/u1rX86Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135886; c=relaxed/simple;
	bh=SRubJFHQOytdTSbyaFMIxMPHS15HDeDucEiwQ0OgxMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKgR7rviIxMBph3KpFPx3Y1r/bK4E5i8WeHG9sXNurEDSEaz3cR49Db2q9AAWQv7rBLI9PolA555pt7KExHr0jvlstRFetlt2JS5pjlvQR0Ctizz4V3XVoOp4ptLWMrWX6PoEz9nqqF0y1llGAutIBtFKH2FlJ5+NrynV2tQlTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=UF7UvFrx; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 915352B3;
	Wed, 28 Feb 2024 16:57:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709135869;
	bh=SRubJFHQOytdTSbyaFMIxMPHS15HDeDucEiwQ0OgxMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UF7UvFrxtYQtU2yrfbTWPNSBywHTGlZaz0D+XwjOv3MvseL/2MhW3hNANkO/kzHc/
	 B5GCkPjbBIqm423DoMFNR8+DotwT++C2Uug17Vqa40QpjUYxWM/kRqYJ14aIX9zGcx
	 77G/0U1fv1MCJqeOIlDvsTxM+TqnXQtLgWgQY4h8=
Date: Wed, 28 Feb 2024 17:58:03 +0200
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
Subject: Re: [PATCH 2/4] drm: xlnx: zynqmp_dpsub: Anounce supported input
 formats
Message-ID: <20240228155803.GC9863@pendragon.ideasonboard.com>
References: <20240226-dp-live-fmt-v1-0-b78c3f69c9d8@amd.com>
 <20240226-dp-live-fmt-v1-2-b78c3f69c9d8@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240226-dp-live-fmt-v1-2-b78c3f69c9d8@amd.com>

Hi Anatoliy,

Thank you for the patch.

On Mon, Feb 26, 2024 at 08:44:43PM -0800, Anatoliy Klymenko wrote:
> DPSUB in bridge mode supports multiple input media bus formats.
> 
> Announce the list of supported input media bus formats via
> drm_bridge.atomic_get_input_bus_fmts callback.
> 
> Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/xlnx/zynqmp_disp.h | 10 ++++++++++
>  drivers/gpu/drm/xlnx/zynqmp_dp.c   |  1 +
>  3 files changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index e6d26ef60e89..ee99aad915ba 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -18,6 +18,7 @@
>  #include <linux/dma/xilinx_dpdma.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
> +#include <linux/media-bus-format.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -77,12 +78,14 @@ enum zynqmp_dpsub_layer_mode {
>  /**
>   * struct zynqmp_disp_format - Display subsystem format information
>   * @drm_fmt: DRM format (4CC)
> + * @bus_fmt: Media bus format
>   * @buf_fmt: AV buffer format
>   * @swap: Flag to swap R & B for RGB formats, and U & V for YUV formats
>   * @sf: Scaling factors for color components
>   */
>  struct zynqmp_disp_format {
>  	u32 drm_fmt;
> +	u32 bus_fmt;
>  	u32 buf_fmt;
>  	bool swap;
>  	const u32 *sf;
> @@ -364,6 +367,40 @@ static const struct zynqmp_disp_format avbuf_gfx_fmts[] = {
>  	},
>  };
>  
> +/* List of live video layer formats */
> +static const struct zynqmp_disp_format avbuf_live_fmts[] = {
> +	{
> +		.drm_fmt	= DRM_FORMAT_VYUY,
> +		.bus_fmt	= MEDIA_BUS_FMT_VYUY8_1X16,
> +		.buf_fmt	= ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_BPC_8 |
> +				  ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV422,
> +		.sf		= scaling_factors_888,

Is there a reason to have a separate array, instead of populating
bus_fmt in the existing arrays for the formats that can be supported
with the live input, and only reporting those from
zynqmp_disp_get_input_bus_fmts() ?

> +	},
> +};
> +
> +u32 *zynqmp_disp_get_input_bus_fmts(struct drm_bridge *bridge,
> +				    struct drm_bridge_state *bridge_state,
> +				    struct drm_crtc_state *crtc_state,
> +				    struct drm_connector_state *conn_state,
> +				    u32 output_fmt,
> +				    unsigned int *num_input_fmts)
> +{
> +	int i;
> +	u32 *input_fmts;
> +
> +	input_fmts = kcalloc(ARRAY_SIZE(avbuf_live_fmts), sizeof(*input_fmts), GFP_KERNEL);
> +	if (!input_fmts) {
> +		*num_input_fmts = 0;
> +		return input_fmts;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(avbuf_live_fmts); ++i)
> +		input_fmts[i] =  avbuf_live_fmts[i].bus_fmt;

Extra space.

> +	*num_input_fmts = ARRAY_SIZE(avbuf_live_fmts);
> +
> +	return input_fmts;
> +}
> +
>  static u32 zynqmp_disp_avbuf_read(struct zynqmp_disp *disp, int reg)
>  {
>  	return readl(disp->avbuf.base + reg);
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.h b/drivers/gpu/drm/xlnx/zynqmp_disp.h
> index 9b8b202224d9..c2c8dd4896ba 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.h
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.h
> @@ -27,6 +27,10 @@
>  struct device;
>  struct drm_format_info;
>  struct drm_plane_state;
> +struct drm_bridge;
> +struct drm_bridge_state;
> +struct drm_connector_state;
> +struct drm_crtc_state;
>  struct platform_device;
>  struct zynqmp_disp;
>  struct zynqmp_disp_layer;
> @@ -52,6 +56,12 @@ void zynqmp_disp_blend_set_global_alpha(struct zynqmp_disp *disp,
>  
>  u32 *zynqmp_disp_layer_drm_formats(struct zynqmp_disp_layer *layer,
>  				   unsigned int *num_formats);
> +u32 *zynqmp_disp_get_input_bus_fmts(struct drm_bridge *bridge,
> +				    struct drm_bridge_state *bridge_state,
> +				    struct drm_crtc_state *crtc_state,
> +				    struct drm_connector_state *conn_state,
> +				    u32 output_fmt,
> +				    unsigned int *num_input_fmts);

As this is a bridge operation, I think it would be better located in
zynqmp_dp.c. You can possibly expose the avbuf_live_fmts array in
zynqmp_disp.h, but that's not really nice as you'll be missing the size.
Another option would be to split the function in two, with the part that
handles the bridge API implemented in zynqmp_dp.c, and the part that
accesses the formats array in zynqmp_disp.c.

>  void zynqmp_disp_layer_enable(struct zynqmp_disp_layer *layer);
>  void zynqmp_disp_layer_disable(struct zynqmp_disp_layer *layer);
>  void zynqmp_disp_layer_set_format(struct zynqmp_disp_layer *layer,
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 04b6bcac3b07..9cb7ac9f3097 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -1580,6 +1580,7 @@ static const struct drm_bridge_funcs zynqmp_dp_bridge_funcs = {
>  	.atomic_check = zynqmp_dp_bridge_atomic_check,
>  	.detect = zynqmp_dp_bridge_detect,
>  	.edid_read = zynqmp_dp_bridge_edid_read,
> +	.atomic_get_input_bus_fmts = zynqmp_disp_get_input_bus_fmts,
>  };
>  
>  /* -----------------------------------------------------------------------------

-- 
Regards,

Laurent Pinchart

