Return-Path: <linux-kernel+bounces-27341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776D982EE02
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10A61F2350B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0D71B949;
	Tue, 16 Jan 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VuqY3lqu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B1E1B944
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705405360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bo6gf18SH2bL+TPE+r/3plO3SeDnpw86MGw5k0EPWSY=;
	b=VuqY3lquW9QNj7ceA9cOEduZNrxzyk02SvaUQ4T3LN/1/0/qsyXgH0QPcpKzkPQ0NUdKTz
	zESRdsts9+QhB8eaz5KYARjypOAqkUxeS2UZ3sIyj7czoSYi+pK6GNeQPJYk+Pm6xUKFFR
	+D19gQfEI6byqBCibj6Czr/UG1GX1kw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-9_hfxhHHN_imkmamcJg1nw-1; Tue, 16 Jan 2024 06:42:39 -0500
X-MC-Unique: 9_hfxhHHN_imkmamcJg1nw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e419b52d5so73640395e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 03:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705405358; x=1706010158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bo6gf18SH2bL+TPE+r/3plO3SeDnpw86MGw5k0EPWSY=;
        b=FCtwMJsqrS/PfjziuRSM1UWn9j4hNQNsVDmanEeHK5wK958iYLTNweCe9lAKrFUdcM
         GqzK8Jdvc/ckCUB9Yfcg0WcISJeHdjDOGr0blyYl5cd0RhCl02vLAk9avpSyjnfBHxs+
         IYx9sY710ad7ZjXjAZJYPNyVZ8Mtn/8lRtbOuzTIIR/VRdKY3I3l5HzF8EKlc3b1q9E8
         FjFCtDmXtI5LCZGi94L4z1awFz17xqRRMdtybnRp2ethxF1YSBLuTb5DjoGM8X3v0d6x
         mf6+bCntEr827HDroYo3/pFXkDdJOpY+16I/M+lWXxhXgsC+Zt401XQnlGafi2NzoCxo
         CJ4A==
X-Gm-Message-State: AOJu0YzOt59hNsK5lUyaWO+RL+I6lskjTXKdvu9GNKMPtVgAixr3RcYX
	wP8rlsGNG2qMuMkpK6Fi0rkMIq68fB6hullQO0QfkDt0v30nmtkvJdsXgwyOUBYMmOPVFtU3/Fb
	gELsORLJbx4Ab45uPZ3Gi95uaMBWR50bp
X-Received: by 2002:a05:600c:474f:b0:40e:6ea5:cee5 with SMTP id w15-20020a05600c474f00b0040e6ea5cee5mr2442051wmo.29.1705405358333;
        Tue, 16 Jan 2024 03:42:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH76WWyVg2QBb+mBb5+P7gGuQHXsDv4635EvKWqzGC4Q5n1eMvxyc+SOOLkzznXOirB3N1WpA==
X-Received: by 2002:a05:600c:474f:b0:40e:6ea5:cee5 with SMTP id w15-20020a05600c474f00b0040e6ea5cee5mr2442039wmo.29.1705405357958;
        Tue, 16 Jan 2024 03:42:37 -0800 (PST)
Received: from toolbox ([2001:9e8:89b3:b200:db6a:6268:cfcb:644d])
        by smtp.gmail.com with ESMTPSA id i17-20020a05600c355100b0040d5f466deesm18926543wmq.38.2024.01.16.03.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 03:42:37 -0800 (PST)
Date: Tue, 16 Jan 2024 12:42:35 +0100
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Andri Yngvason <andri@yngvason.is>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Werner Sembach <wse@tuxedocomputers.com>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/4] drm/uAPI: Add "force color format" drm property
 as setting for userspace
Message-ID: <20240116114235.GA311990@toolbox>
References: <20240115160554.720247-1-andri@yngvason.is>
 <20240115160554.720247-3-andri@yngvason.is>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115160554.720247-3-andri@yngvason.is>

On Mon, Jan 15, 2024 at 04:05:52PM +0000, Andri Yngvason wrote:
> From: Werner Sembach <wse@tuxedocomputers.com>
> 
> Add a new general drm property "force color format" which can be used
> by userspace to tell the graphics driver which color format to use.

I don't like the "force" in the name. This just selects the color
format, let's just call it "color format" then.

> Possible options are:
>     - auto (default/current behaviour)
>     - rgb
>     - ycbcr444
>     - ycbcr422 (supported by neither amdgpu or i915)
>     - ycbcr420
> 
> In theory the auto option should choose the best available option for the
> current setup, but because of bad internal conversion some monitors look
> better with rgb and some with ycbcr444.
> 
> Also, because of bad shielded connectors and/or cables, it might be
> preferable to use the less bandwidth heavy ycbcr422 and ycbcr420 formats
> for a signal that is less susceptible to interference.
> 
> In the future, automatic color calibration for screens might also depend on
> this option being available.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Andri Yngvason <andri@yngvason.is>
> Tested-by: Andri Yngvason <andri@yngvason.is>
> ---
> 
> Changes in v2:
>  - Renamed to "force color format" from "preferred color format"
>  - Removed Reported-by pointing to invalid email address
> 
> ---
>  drivers/gpu/drm/drm_atomic_helper.c |  4 +++
>  drivers/gpu/drm/drm_atomic_uapi.c   |  4 +++
>  drivers/gpu/drm/drm_connector.c     | 48 +++++++++++++++++++++++++++++
>  include/drm/drm_connector.h         | 16 ++++++++++
>  4 files changed, 72 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 39ef0a6addeba..1dabd164c4f09 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -707,6 +707,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
>  			if (old_connector_state->max_requested_bpc !=
>  			    new_connector_state->max_requested_bpc)
>  				new_crtc_state->connectors_changed = true;
> +
> +			if (old_connector_state->force_color_format !=
> +			    new_connector_state->force_color_format)
> +				new_crtc_state->connectors_changed = true;
>  		}
>  
>  		if (funcs->atomic_check)
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 29d4940188d49..e45949bf4615f 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -776,6 +776,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
>  		state->max_requested_bpc = val;
>  	} else if (property == connector->privacy_screen_sw_state_property) {
>  		state->privacy_screen_sw_state = val;
> +	} else if (property == connector->force_color_format_property) {
> +		state->force_color_format = val;
>  	} else if (connector->funcs->atomic_set_property) {
>  		return connector->funcs->atomic_set_property(connector,
>  				state, property, val);
> @@ -859,6 +861,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>  		*val = state->max_requested_bpc;
>  	} else if (property == connector->privacy_screen_sw_state_property) {
>  		*val = state->privacy_screen_sw_state;
> +	} else if (property == connector->force_color_format_property) {
> +		*val = state->force_color_format;
>  	} else if (connector->funcs->atomic_get_property) {
>  		return connector->funcs->atomic_get_property(connector,
>  				state, property, val);
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index b0516505f7ae9..e0535e58b4535 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1061,6 +1061,14 @@ static const struct drm_prop_enum_list drm_dp_subconnector_enum_list[] = {
>  	{ DRM_MODE_SUBCONNECTOR_Native,	     "Native"    }, /* DP */
>  };
>  
> +static const struct drm_prop_enum_list drm_force_color_format_enum_list[] = {
> +	{ 0, "auto" },
> +	{ DRM_COLOR_FORMAT_RGB444, "rgb" },
> +	{ DRM_COLOR_FORMAT_YCBCR444, "ycbcr444" },
> +	{ DRM_COLOR_FORMAT_YCBCR422, "ycbcr422" },
> +	{ DRM_COLOR_FORMAT_YCBCR420, "ycbcr420" },
> +};
> +
>  DRM_ENUM_NAME_FN(drm_get_dp_subconnector_name,
>  		 drm_dp_subconnector_enum_list)
>  
> @@ -1396,6 +1404,15 @@ static const u32 dp_colorspaces =
>   *	drm_connector_attach_max_bpc_property() to create and attach the
>   *	property to the connector during initialization.
>   *
> + * force color format:
> + *	This property is used by userspace to change the used color format. When
> + *	used the driver will use the selected format if valid for the hardware,

All properties are always "used", they just can have different values.
You probably want to talk about the auto mode here.

> + *	sink, and current resolution and refresh rate combination. Drivers to

If valid? So when a value is not actually supported user space can still
set it? What happens then? How should user space figure out if the
driver and the sink support the format?

For the Colorspace prop, the kernel just exposes all formats it supports
(independent of the sink) and then makes it the job of user space to
figure out if the sink supports it.

The same could be done here. Property value is exposed if the driver
supports it in general, commits can fail if the driver can't support it
for a specific commit because e.g. the resolution or refresh rate. User
space must look at the EDID/DisplayID/mode to figure out the supported
format for the sink.

> + *	use the function drm_connector_attach_force_color_format_property()
> + *	to create and attach the property to the connector during
> + *	initialization. Possible values are "auto", "rgb", "ycbcr444",
> + *	"ycbcr422", and "ycbcr420".
> + *
>   * Connectors also have one standardized atomic property:
>   *
>   * CRTC_ID:
> @@ -2457,6 +2474,37 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
>  
> +/**
> + * drm_connector_attach_force_color_format_property - attach "force color format" property
> + * @connector: connector to attach force color format property on.
> + *
> + * This is used to add support for selecting a color format on a connector.
> + *
> + * Returns:
> + * Zero on success, negative errno on failure.
> + */
> +int drm_connector_attach_force_color_format_property(struct drm_connector *connector)
> +{
> +	struct drm_device *dev = connector->dev;
> +	struct drm_property *prop;
> +
> +	if (!connector->force_color_format_property) {
> +		prop = drm_property_create_enum(dev, 0, "force color format",
> +						drm_force_color_format_enum_list,
> +						ARRAY_SIZE(drm_force_color_format_enum_list));
> +		if (!prop)
> +			return -ENOMEM;
> +
> +		connector->force_color_format_property = prop;
> +	}
> +
> +	drm_object_attach_property(&connector->base, prop, 0);
> +	connector->state->force_color_format = 0;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_connector_attach_force_color_format_property);
> +
>  /**
>   * drm_connector_attach_hdr_output_metadata_property - attach "HDR_OUTPUT_METADA" property
>   * @connector: connector to attach the property on.
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index fe88d7fc6b8f4..9830e7c09c0ba 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1026,6 +1026,14 @@ struct drm_connector_state {
>  	 */
>  	enum drm_privacy_screen_status privacy_screen_sw_state;
>  
> +	/**
> +	 * @force_color_format: Property set by userspace to tell the GPU
> +	 * driver which color format to use. It only gets applied if hardware,
> +	 * meaning both the computer and the monitor, and the driver support the
> +	 * given format at the current resolution and refresh rate.
> +	 */
> +	u32 force_color_format;
> +
>  	/**
>  	 * @hdr_output_metadata:
>  	 * DRM blob property for HDR output metadata
> @@ -1699,6 +1707,12 @@ struct drm_connector {
>  	 */
>  	struct drm_property *privacy_screen_hw_state_property;
>  
> +	/**
> +	 * @force_color_format_property: Default connector property for the
> +	 * force color format to be driven out of the connector.
> +	 */
> +	struct drm_property *force_color_format_property;
> +
>  #define DRM_CONNECTOR_POLL_HPD (1 << 0)
>  #define DRM_CONNECTOR_POLL_CONNECT (1 << 1)
>  #define DRM_CONNECTOR_POLL_DISCONNECT (1 << 2)
> @@ -2053,6 +2067,8 @@ void drm_connector_attach_privacy_screen_provider(
>  	struct drm_connector *connector, struct drm_privacy_screen *priv);
>  void drm_connector_update_privacy_screen(const struct drm_connector_state *connector_state);
>  
> +int drm_connector_attach_force_color_format_property(struct drm_connector *connector);
> +
>  /**
>   * struct drm_tile_group - Tile group metadata
>   * @refcount: reference count
> -- 
> 2.43.0
> 


