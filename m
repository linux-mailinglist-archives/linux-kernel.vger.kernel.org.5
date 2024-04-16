Return-Path: <linux-kernel+bounces-146935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E01D8A6D36
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916451C21530
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3500A12CD9D;
	Tue, 16 Apr 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JKPzsNxv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51DB12C55D;
	Tue, 16 Apr 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276056; cv=none; b=G3+Y+mOIAySAOwkc72a59GqvYH2iHdmrVo+UGX+OL+pZmWnoNQ8r34gQpbGpKsX85Zvhd5T0nZr9qum2xYt7G3K37KUiA22zVcIAg/nB+wYriU8yV2G78ndljA6llUJR9GZ0AMi5Xh7irA5M/0/tIX7eXq1JrYEZHANgihBVJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276056; c=relaxed/simple;
	bh=tshG9UziJ9Q36ESv1OzvyrTcow7hpZts+Je0IlzMdLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rbhd3XQZXHlpNe5cwyzM8z8Jcys7UseNhVPgiR5IJSZlUH1rQS7BGnXpLVuXi1hbPyO/VdiH3/jMgCLHDkJpG/15jfTBBpzgg/1R0qqmLTOzKKEnsrFQdFBp6XBtHzqT5JDCFgIx5q05vpprTx8EC7S8sztssGXXEtpAxPwQADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JKPzsNxv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713276052; x=1744812052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tshG9UziJ9Q36ESv1OzvyrTcow7hpZts+Je0IlzMdLw=;
  b=JKPzsNxvWejemJTVHY/P+YPtEL1mqnYxq5+JrXZay2H5MrZ/YiMtD8Gg
   I8FYSQrb8doLq9ijrC7vm3SMSoPbdzLZaMFZa6JLsqTT3aft1AmOb+Yco
   a8ImnsOejInpn4KpcVgKGKwUM98jhigBzlEcFhtaaPch7P9MRJsWcMxjq
   cRX22b9F2PtZvC2bZBHWuQB4HSwnnT0Df3rH+p/yvqtXTj60hZyzJC5NF
   qEwQtKjJIygCQqhDkTbT5sSsH9CWnSGLlX+wap/7flT2WTlpJpZ04mJ9e
   RDyTUfL0sQ3BWJISS0w9zwLGPV4ileCPd/RZ1ezRnXq3P1QhfGf+eNOqj
   A==;
X-CSE-ConnectionGUID: JiHX1YspRwuT++vEIdEE4Q==
X-CSE-MsgGUID: f6chylt6QuCEY+sKc4Y+1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9266358"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="9266358"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 07:00:33 -0700
X-CSE-ConnectionGUID: CvuKKRs/TjWvmZ2+ZsDygA==
X-CSE-MsgGUID: wd2whXFxQBScxg4Vz2wRXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22332339"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 16 Apr 2024 07:00:27 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 16 Apr 2024 17:00:26 +0300
Date: Tue, 16 Apr 2024 17:00:26 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sebastian Wick <sebastian.wick@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v11 17/28] drm/connector: hdmi: Add Broadcast RGB property
Message-ID: <Zh6EevKDKt60E8e9@intel.com>
References: <20240326-kms-hdmi-connector-state-v11-0-c5680ffcf261@kernel.org>
 <20240326-kms-hdmi-connector-state-v11-17-c5680ffcf261@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326-kms-hdmi-connector-state-v11-17-c5680ffcf261@kernel.org>
X-Patchwork-Hint: comment

On Tue, Mar 26, 2024 at 04:40:21PM +0100, Maxime Ripard wrote:
> The i915 driver has a property to force the RGB range of an HDMI output.
> The vc4 driver then implemented the same property with the same
> semantics. KWin has support for it, and a PR for mutter is also there to
> support it.

Is there a i915 patch to switch over to hdmi.broadcast_rgb? Though
the "hdmi" name is perhaps not the best idea given this is also a
thing for DP.

> 
> Both drivers implementing the same property with the same semantics,
> plus the userspace having support for it, is proof enough that it's
> pretty much a de-facto standard now and we can provide helpers for it.
> 
> Let's plumb it into the newly created HDMI connector.
> 
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Reviewed-by: Sebastian Wick <sebastian.wick@redhat.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  Documentation/gpu/kms-properties.csv            |  1 -
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c |  4 +-
>  drivers/gpu/drm/drm_atomic.c                    |  2 +
>  drivers/gpu/drm/drm_atomic_uapi.c               |  4 ++
>  drivers/gpu/drm/drm_connector.c                 | 88 +++++++++++++++++++++++++
>  include/drm/drm_connector.h                     | 36 ++++++++++
>  6 files changed, 133 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/gpu/kms-properties.csv b/Documentation/gpu/kms-properties.csv
> index 0f9590834829..caef14c532d4 100644
> --- a/Documentation/gpu/kms-properties.csv
> +++ b/Documentation/gpu/kms-properties.csv
> @@ -15,11 +15,10 @@ Owner Module/Drivers,Group,Property Name,Type,Property Values,Object attached,De
>  ,,“saturation”,RANGE,"Min=0, Max=100",Connector,TBD
>  ,,“hue”,RANGE,"Min=0, Max=100",Connector,TBD
>  ,Virtual GPU,“suggested X”,RANGE,"Min=0, Max=0xffffffff",Connector,property to suggest an X offset for a connector
>  ,,“suggested Y”,RANGE,"Min=0, Max=0xffffffff",Connector,property to suggest an Y offset for a connector
>  ,Optional,"""aspect ratio""",ENUM,"{ ""None"", ""4:3"", ""16:9"" }",Connector,TDB
> -i915,Generic,"""Broadcast RGB""",ENUM,"{ ""Automatic"", ""Full"", ""Limited 16:235"" }",Connector,"When this property is set to Limited 16:235 and CTM is set, the hardware will be programmed with the result of the multiplication of CTM by the limited range matrix to ensure the pixels normally in the range 0..1.0 are remapped to the range 16/255..235/255."
>  ,,“audio”,ENUM,"{ ""force-dvi"", ""off"", ""auto"", ""on"" }",Connector,TBD
>  ,SDVO-TV,“mode”,ENUM,"{ ""NTSC_M"", ""NTSC_J"", ""NTSC_443"", ""PAL_B"" } etc.",Connector,TBD
>  ,,"""left_margin""",RANGE,"Min=0, Max= SDVO dependent",Connector,TBD
>  ,,"""right_margin""",RANGE,"Min=0, Max= SDVO dependent",Connector,TBD
>  ,,"""top_margin""",RANGE,"Min=0, Max= SDVO dependent",Connector,TBD
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> index b9bc0fb027ea..c844cbeb675b 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -23,10 +23,11 @@ void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
>  {
>  	unsigned int max_bpc = connector->max_bpc;
>  
>  	new_conn_state->max_bpc = max_bpc;
>  	new_conn_state->max_requested_bpc = max_bpc;
> +	new_conn_state->hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_connector_hdmi_reset);
>  
>  static const struct drm_display_mode *
>  connector_state_get_mode(const struct drm_connector_state *conn_state)
> @@ -310,11 +311,12 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
>  
>  	ret = hdmi_compute_config(connector, new_conn_state, mode);
>  	if (ret)
>  		return ret;
>  
> -	if (old_conn_state->hdmi.output_bpc != new_conn_state->hdmi.output_bpc ||
> +	if (old_conn_state->hdmi.broadcast_rgb != new_conn_state->hdmi.broadcast_rgb ||
> +	    old_conn_state->hdmi.output_bpc != new_conn_state->hdmi.output_bpc ||
>  	    old_conn_state->hdmi.output_format != new_conn_state->hdmi.output_format) {
>  		struct drm_crtc *crtc = new_conn_state->crtc;
>  		struct drm_crtc_state *crtc_state;
>  
>  		crtc_state = drm_atomic_get_crtc_state(state, crtc);
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 26f9e525c0a0..3e57d98d8418 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1143,10 +1143,12 @@ static void drm_atomic_connector_print_state(struct drm_printer *p,
>  	drm_printf(p, "\tmax_requested_bpc=%d\n", state->max_requested_bpc);
>  	drm_printf(p, "\tcolorspace=%s\n", drm_get_colorspace_name(state->colorspace));
>  
>  	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
>  	    connector->connector_type == DRM_MODE_CONNECTOR_HDMIB) {
> +		drm_printf(p, "\tbroadcast_rgb=%s\n",
> +			   drm_hdmi_connector_get_broadcast_rgb_name(state->hdmi.broadcast_rgb));
>  		drm_printf(p, "\toutput_bpc=%u\n", state->hdmi.output_bpc);
>  		drm_printf(p, "\toutput_format=%s\n",
>  			   drm_hdmi_connector_get_output_format_name(state->hdmi.output_format));
>  		drm_printf(p, "\ttmds_char_rate=%llu\n", state->hdmi.tmds_char_rate);
>  	}
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 29d4940188d4..2b415b4ed506 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -774,10 +774,12 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
>  						   fence_ptr);
>  	} else if (property == connector->max_bpc_property) {
>  		state->max_requested_bpc = val;
>  	} else if (property == connector->privacy_screen_sw_state_property) {
>  		state->privacy_screen_sw_state = val;
> +	} else if (property == connector->broadcast_rgb_property) {
> +		state->hdmi.broadcast_rgb = val;
>  	} else if (connector->funcs->atomic_set_property) {
>  		return connector->funcs->atomic_set_property(connector,
>  				state, property, val);
>  	} else {
>  		drm_dbg_atomic(connector->dev,
> @@ -857,10 +859,12 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>  		*val = 0;
>  	} else if (property == connector->max_bpc_property) {
>  		*val = state->max_requested_bpc;
>  	} else if (property == connector->privacy_screen_sw_state_property) {
>  		*val = state->privacy_screen_sw_state;
> +	} else if (property == connector->broadcast_rgb_property) {
> +		*val = state->hdmi.broadcast_rgb;
>  	} else if (connector->funcs->atomic_get_property) {
>  		return connector->funcs->atomic_get_property(connector,
>  				state, property, val);
>  	} else {
>  		drm_dbg_atomic(dev,
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 555eac20e5a4..bdd3361ccc73 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1210,10 +1210,33 @@ static const u32 dp_colorspaces =
>  	BIT(DRM_MODE_COLORIMETRY_SYCC_601) |
>  	BIT(DRM_MODE_COLORIMETRY_OPYCC_601) |
>  	BIT(DRM_MODE_COLORIMETRY_BT2020_CYCC) |
>  	BIT(DRM_MODE_COLORIMETRY_BT2020_YCC);
>  
> +static const struct drm_prop_enum_list broadcast_rgb_names[] = {
> +	{ DRM_HDMI_BROADCAST_RGB_AUTO, "Automatic" },
> +	{ DRM_HDMI_BROADCAST_RGB_FULL, "Full" },
> +	{ DRM_HDMI_BROADCAST_RGB_LIMITED, "Limited 16:235" },
> +};
> +
> +/*
> + * drm_hdmi_connector_get_broadcast_rgb_name - Return a string for HDMI connector RGB broadcast selection
> + * @broadcast_rgb: Broadcast RGB selection to compute name of
> + *
> + * Returns: the name of the Broadcast RGB selection, or NULL if the type
> + * is not valid.
> + */
> +const char *
> +drm_hdmi_connector_get_broadcast_rgb_name(enum drm_hdmi_broadcast_rgb broadcast_rgb)
> +{
> +	if (broadcast_rgb >= ARRAY_SIZE(broadcast_rgb_names))
> +		return NULL;
> +
> +	return broadcast_rgb_names[broadcast_rgb].name;
> +}
> +EXPORT_SYMBOL(drm_hdmi_connector_get_broadcast_rgb_name);
> +
>  static const char * const output_format_str[] = {
>  	[HDMI_COLORSPACE_RGB]		= "RGB",
>  	[HDMI_COLORSPACE_YUV420]	= "YUV 4:2:0",
>  	[HDMI_COLORSPACE_YUV422]	= "YUV 4:2:2",
>  	[HDMI_COLORSPACE_YUV444]	= "YUV 4:4:4",
> @@ -1706,10 +1729,42 @@ void drm_connector_attach_dp_subconnector_property(struct drm_connector *connect
>  EXPORT_SYMBOL(drm_connector_attach_dp_subconnector_property);
>  
>  /**
>   * DOC: HDMI connector properties
>   *
> + * Broadcast RGB (HDMI specific)
> + *      Indicates the Quantization Range (Full vs Limited) used. The color
> + *      processing pipeline will be adjusted to match the value of the
> + *      property, and the Infoframes will be generated and sent accordingly.
> + *
> + *      This property is only relevant if the HDMI output format is RGB. If
> + *      it's one of the YCbCr variant, it will be ignored.
> + *
> + *      The CRTC attached to the connector must be configured by user-space to
> + *      always produce full-range pixels.
> + *
> + *      The value of this property can be one of the following:
> + *
> + *      Automatic:
> + *              The quantization range is selected automatically based on the
> + *              mode according to the HDMI specifications (HDMI 1.4b - Section
> + *              6.6 - Video Quantization Ranges).
> + *
> + *      Full:
> + *              Full quantization range is forced.
> + *
> + *      Limited 16:235:
> + *              Limited quantization range is forced. Unlike the name suggests,
> + *              this works for any number of bits-per-component.
> + *
> + *      Property values other than Automatic can result in colors being off (if
> + *      limited is selected but the display expects full), or a black screen
> + *      (if full is selected but the display expects limited).
> + *
> + *      Drivers can set up this property by calling
> + *      drm_connector_attach_broadcast_rgb_property().
> + *
>   * content type (HDMI specific):
>   *	Indicates content type setting to be used in HDMI infoframes to indicate
>   *	content type for the external device, so that it adjusts its display
>   *	settings accordingly.
>   *
> @@ -2568,10 +2623,43 @@ int drm_connector_attach_hdr_output_metadata_property(struct drm_connector *conn
>  
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_connector_attach_hdr_output_metadata_property);
>  
> +/**
> + * drm_connector_attach_broadcast_rgb_property - attach "Broadcast RGB" property
> + * @connector: connector to attach the property on.
> + *
> + * This is used to add support for forcing the RGB range on a connector
> + *
> + * Returns:
> + * Zero on success, negative errno on failure.
> + */
> +int drm_connector_attach_broadcast_rgb_property(struct drm_connector *connector)
> +{
> +	struct drm_device *dev = connector->dev;
> +	struct drm_property *prop;
> +
> +	prop = connector->broadcast_rgb_property;
> +	if (!prop) {
> +		prop = drm_property_create_enum(dev, DRM_MODE_PROP_ENUM,
> +						"Broadcast RGB",
> +						broadcast_rgb_names,
> +						ARRAY_SIZE(broadcast_rgb_names));
> +		if (!prop)
> +			return -EINVAL;
> +
> +		connector->broadcast_rgb_property = prop;
> +	}
> +
> +	drm_object_attach_property(&connector->base, prop,
> +				   DRM_HDMI_BROADCAST_RGB_AUTO);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_connector_attach_broadcast_rgb_property);
> +
>  /**
>   * drm_connector_attach_colorspace_property - attach "Colorspace" property
>   * @connector: connector to attach the property on.
>   *
>   * This is used to allow the userspace to signal the output colorspace
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 3c0b6694074f..a40eaf3a8ce4 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -367,10 +367,33 @@ enum drm_panel_orientation {
>  	DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP,
>  	DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
>  	DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
>  };
>  
> +/**
> + * enum drm_hdmi_broadcast_rgb - Broadcast RGB Selection for an HDMI @drm_connector
> + */
> +enum drm_hdmi_broadcast_rgb {
> +	/**
> +	 * @DRM_HDMI_BROADCAST_RGB_AUTO: The RGB range is selected
> +	 * automatically based on the mode.
> +	 */
> +	DRM_HDMI_BROADCAST_RGB_AUTO,
> +
> +	/**
> +	 * @DRM_HDMI_BROADCAST_RGB_FULL: Full range RGB is forced.
> +	 */
> +	DRM_HDMI_BROADCAST_RGB_FULL,
> +
> +	/**
> +	 * @DRM_HDMI_BROADCAST_RGB_LIMITED: Limited range RGB is forced.
> +	 */
> +	DRM_HDMI_BROADCAST_RGB_LIMITED,
> +};
> +
> +const char *
> +drm_hdmi_connector_get_broadcast_rgb_name(enum drm_hdmi_broadcast_rgb broadcast_rgb);
>  const char *
>  drm_hdmi_connector_get_output_format_name(enum hdmi_colorspace fmt);
>  
>  /**
>   * struct drm_monitor_range_info - Panel's Monitor range in EDID for
> @@ -1039,10 +1062,16 @@ struct drm_connector_state {
>  	/**
>  	 * @hdmi: HDMI-related variable and properties. Filled by
>  	 * @drm_atomic_helper_connector_hdmi_check().
>  	 */
>  	struct {
> +		/**
> +		 * @broadcast_rgb: Connector property to pass the
> +		 * Broadcast RGB selection value.
> +		 */
> +		enum drm_hdmi_broadcast_rgb broadcast_rgb;
> +
>  		/**
>  		 * @output_bpc: Bits per color channel to output.
>  		 */
>  		unsigned int output_bpc;
>  
> @@ -1751,10 +1780,16 @@ struct drm_connector {
>  	 * @privacy_screen_hw_state_property: Optional atomic property for the
>  	 * connector to report the actual integrated privacy screen state.
>  	 */
>  	struct drm_property *privacy_screen_hw_state_property;
>  
> +	/**
> +	 * @broadcast_rgb_property: Connector property to set the
> +	 * Broadcast RGB selection to output with.
> +	 */
> +	struct drm_property *broadcast_rgb_property;
> +
>  #define DRM_CONNECTOR_POLL_HPD (1 << 0)
>  #define DRM_CONNECTOR_POLL_CONNECT (1 << 1)
>  #define DRM_CONNECTOR_POLL_DISCONNECT (1 << 2)
>  
>  	/**
> @@ -2090,10 +2125,11 @@ int drm_mode_create_scaling_mode_property(struct drm_device *dev);
>  int drm_connector_attach_content_type_property(struct drm_connector *dev);
>  int drm_connector_attach_scaling_mode_property(struct drm_connector *connector,
>  					       u32 scaling_mode_mask);
>  int drm_connector_attach_vrr_capable_property(
>  		struct drm_connector *connector);
> +int drm_connector_attach_broadcast_rgb_property(struct drm_connector *connector);
>  int drm_connector_attach_colorspace_property(struct drm_connector *connector);
>  int drm_connector_attach_hdr_output_metadata_property(struct drm_connector *connector);
>  bool drm_connector_atomic_hdr_metadata_equal(struct drm_connector_state *old_state,
>  					     struct drm_connector_state *new_state);
>  int drm_mode_create_aspect_ratio_property(struct drm_device *dev);
> 
> -- 
> 2.44.0

-- 
Ville Syrjälä
Intel

