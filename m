Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D2B7AC76C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 12:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjIXKGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 06:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjIXKGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 06:06:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1308FF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 03:06:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso15729285e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 03:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695549997; x=1696154797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdXgmO19DH7e5dRbTGiu3VOEL1iMuBkvSpmxvkiGdt0=;
        b=US3de5sj7LD01kpc5ANpG7DZucSW5hbDkAMNrENx7Ioa9icoxaNiRCfQTMOOqvMSw0
         X1XIcMRdm3haedRelQwlIpcswyiZzrs++t+Lavkea2HF1kyTzpbBFdgF59R7iWdKPu3S
         1QQ+nbmBmMSy1Ax2OaVR1Mvqq7QS5K2qanSemzBL8bFE/ePszOTavBFwVzh1CiYIoe7f
         DkDEO5EaBLC5+899NVi42V9Miz+TgFV5jzyU26SOXGSkO6wUxAlB8jErGZEm+Epqr/hh
         DIbJi7f81koF3QUh0o6kgm/5EiFlmIUQGEbeiF+1ZNa6Uw7ZcxmodvSAwjwoNR6EVJns
         RbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695549997; x=1696154797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xdXgmO19DH7e5dRbTGiu3VOEL1iMuBkvSpmxvkiGdt0=;
        b=t9pxMzUKVSG4z5ObRkwnX0CaMwacalJjGY1b4RbX1wlEQ9lxQ03xXp5+bluzaZE/bI
         gl1AezFShfXmaZijUxikWvM0cQKuaCD+Au5NHsxkchZNOoiymjg2ZDRdfOfd5fvvZfrN
         citeicP1oreyqIA5m1NUScPDmy3wk4a2iyATR2cfljUTV1J7tlrL2VycaJf2JyEc7TSK
         NrZuxR42JQWFg/rPq8j93epOIGpOBi9BiDH6oHK6ooXnGx81bs9q53RZ0GAL0GLa7oog
         oTwK7KoupDaY4iDtCNuymmA/+X0+c/5odLWSL5xrNcc6RkFnwb6SXP9x4rxDmD8b/UKg
         abRA==
X-Gm-Message-State: AOJu0YzgMvvyxZFQmyGeQumsb+lDZG9Zrv5A24rHdymFZ2L5EM08fsMN
        weWrOLJvFKDX+i6I8nhdRsdHow==
X-Google-Smtp-Source: AGHT+IHkN6tPHKZjRCaXIPETeC/5H8wR0psAOYpkIn8zjSZF3Nm1SLjh9d0OHAiiuGw6MxMLLG9ffw==
X-Received: by 2002:a05:600c:2183:b0:3f9:b244:c294 with SMTP id e3-20020a05600c218300b003f9b244c294mr3345994wme.35.1695549997254;
        Sun, 24 Sep 2023 03:06:37 -0700 (PDT)
Received: from [10.73.151.44] ([188.111.42.10])
        by smtp.gmail.com with ESMTPSA id x1-20020a1c7c01000000b00402d34ea099sm11997483wmc.29.2023.09.24.03.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 03:06:36 -0700 (PDT)
Message-ID: <93a64016-0dca-4480-a178-9085c312c8e5@linaro.org>
Date:   Sun, 24 Sep 2023 13:06:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v6 01/10] drm: Introduce pixel_source DRM plane
 property
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        sebastian.wick@redhat.com, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
References: <20230828-solid-fill-v6-0-a820efcce852@quicinc.com>
 <20230828-solid-fill-v6-1-a820efcce852@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230828-solid-fill-v6-1-a820efcce852@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 03:05, Jessica Zhang wrote:
> Add support for pixel_source property to drm_plane and related
> documentation. In addition, force pixel_source to
> DRM_PLANE_PIXEL_SOURCE_FB in DRM_IOCTL_MODE_SETPLANE as to not break
> legacy userspace.
> 
> This enum property will allow user to specify a pixel source for the
> plane. Possible pixel sources will be defined in the
> drm_plane_pixel_source enum.
> 
> Currently, the only pixel sources are DRM_PLANE_PIXEL_SOURCE_FB (the
> default value) and DRM_PLANE_PIXEL_SOURCE_NONE.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor question below

> ---
>   drivers/gpu/drm/drm_atomic_state_helper.c |  1 +
>   drivers/gpu/drm/drm_atomic_uapi.c         |  4 ++
>   drivers/gpu/drm/drm_blend.c               | 90 +++++++++++++++++++++++++++++++
>   drivers/gpu/drm/drm_plane.c               | 19 +++++--
>   include/drm/drm_blend.h                   |  2 +
>   include/drm/drm_plane.h                   | 21 ++++++++
>   6 files changed, 133 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 784e63d70a42..01638c51ce0a 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -252,6 +252,7 @@ void __drm_atomic_helper_plane_state_reset(struct drm_plane_state *plane_state,
>   
>   	plane_state->alpha = DRM_BLEND_ALPHA_OPAQUE;
>   	plane_state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
> +	plane_state->pixel_source = DRM_PLANE_PIXEL_SOURCE_FB;
>   
>   	if (plane->color_encoding_property) {
>   		if (!drm_object_property_get_default_value(&plane->base,
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index d867e7f9f2cd..454f980e16c9 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -544,6 +544,8 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>   		state->src_w = val;
>   	} else if (property == config->prop_src_h) {
>   		state->src_h = val;
> +	} else if (property == plane->pixel_source_property) {
> +		state->pixel_source = val;
>   	} else if (property == plane->alpha_property) {
>   		state->alpha = val;
>   	} else if (property == plane->blend_mode_property) {
> @@ -616,6 +618,8 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
>   		*val = state->src_w;
>   	} else if (property == config->prop_src_h) {
>   		*val = state->src_h;
> +	} else if (property == plane->pixel_source_property) {
> +		*val = state->pixel_source;
>   	} else if (property == plane->alpha_property) {
>   		*val = state->alpha;
>   	} else if (property == plane->blend_mode_property) {
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index 6e74de833466..c3c57bae06b7 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -185,6 +185,21 @@
>    *		 plane does not expose the "alpha" property, then this is
>    *		 assumed to be 1.0
>    *
> + * pixel_source:
> + *	pixel_source is set up with drm_plane_create_pixel_source_property().
> + *	It is used to toggle the active source of pixel data for the plane.
> + *	The plane will only display data from the set pixel_source -- any
> + *	data from other sources will be ignored.
> + *
> + *	Possible values:
> + *
> + *	"NONE":
> + *		No active pixel source.
> + *		Committing with a NONE pixel source will disable the plane.
> + *
> + *	"FB":
> + *		Framebuffer source set by the "FB_ID" property.
> + *
>    * Note that all the property extensions described here apply either to the
>    * plane or the CRTC (e.g. for the background color, which currently is not
>    * exposed and assumed to be black).
> @@ -615,3 +630,78 @@ int drm_plane_create_blend_mode_property(struct drm_plane *plane,
>   	return 0;
>   }
>   EXPORT_SYMBOL(drm_plane_create_blend_mode_property);
> +
> +static const struct drm_prop_enum_list drm_pixel_source_enum_list[] = {
> +	{ DRM_PLANE_PIXEL_SOURCE_NONE, "NONE" },
> +	{ DRM_PLANE_PIXEL_SOURCE_FB, "FB" },
> +};
> +
> +/**
> + * drm_plane_create_pixel_source_property - create a new pixel source property
> + * @plane: DRM plane
> + * @extra_sources: Bitmask of additional supported pixel_sources for the driver.
> + *		   DRM_PLANE_PIXEL_SOURCE_FB and DRM_PLANE_PIXEL_SOURCE_NONE will
> + *		   always be enabled as supported sources.
> + *
> + * This creates a new property describing the current source of pixel data for the
> + * plane. The pixel_source will be initialized as DRM_PLANE_PIXEL_SOURCE_FB by default.
> + *
> + * Drivers can set a custom default source by overriding the pixel_source value in
> + * drm_plane_funcs.reset()
> + *
> + * The property is exposed to userspace as an enumeration property called
> + * "pixel_source" and has the following enumeration values:
> + *
> + * "NONE":
> + *	 No active pixel source
> + *
> + * "FB":
> + *	Framebuffer pixel source
> + *
> + * Returns:
> + * Zero on success, negative errno on failure.
> + */
> +int drm_plane_create_pixel_source_property(struct drm_plane *plane,
> +					   unsigned long extra_sources)
> +{
> +	struct drm_device *dev = plane->dev;
> +	struct drm_property *prop;
> +	static const unsigned int valid_source_mask = BIT(DRM_PLANE_PIXEL_SOURCE_FB) |
> +						      BIT(DRM_PLANE_PIXEL_SOURCE_NONE);

Nit: if valid_source_mask and supported_sources are moved towards the 
top, it might look better. It doesn't warrant sending v7 just to fix 
this issue though.

> +	int i;
> +
> +	/* FB is supported by default */
> +	unsigned long supported_sources = extra_sources |
> +					  BIT(DRM_PLANE_PIXEL_SOURCE_FB) |
> +					  BIT(DRM_PLANE_PIXEL_SOURCE_NONE);

As you are going to extend planes to support non-FB sources, would it be 
logical to stop declaring FB as a default one as well? I think DIM layer 
planes will only support solid fill source.

> +
> +	if (WARN_ON(supported_sources & ~valid_source_mask))
> +		return -EINVAL;
> +
> +	prop = drm_property_create(dev, DRM_MODE_PROP_ENUM | DRM_MODE_PROP_ATOMIC, "pixel_source",
> +			hweight32(supported_sources));
> +
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ARRAY_SIZE(drm_pixel_source_enum_list); i++) {
> +		int ret;
> +
> +		if (!test_bit(drm_pixel_source_enum_list[i].type, &supported_sources))
> +			continue;
> +
> +		ret = drm_property_add_enum(prop, drm_pixel_source_enum_list[i].type,
> +				drm_pixel_source_enum_list[i].name);
> +		if (ret) {
> +			drm_property_destroy(dev, prop);
> +
> +			return ret;
> +		}
> +	}
> +
> +	drm_object_attach_property(&plane->base, prop, DRM_PLANE_PIXEL_SOURCE_FB);
> +	plane->pixel_source_property = prop;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_plane_create_pixel_source_property);
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 24e7998d1731..559d101162ba 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -839,6 +839,14 @@ bool drm_any_plane_has_format(struct drm_device *dev,
>   }
>   EXPORT_SYMBOL(drm_any_plane_has_format);
>   
> +static bool drm_plane_needs_disable(struct drm_plane_state *state, struct drm_framebuffer *fb)
> +{
> +	if (state->pixel_source == DRM_PLANE_PIXEL_SOURCE_NONE)
> +		return true;
> +
> +	return state->pixel_source == DRM_PLANE_PIXEL_SOURCE_FB && fb == NULL;
> +}
> +
>   /*
>    * __setplane_internal - setplane handler for internal callers
>    *
> @@ -861,8 +869,8 @@ static int __setplane_internal(struct drm_plane *plane,
>   
>   	WARN_ON(drm_drv_uses_atomic_modeset(plane->dev));
>   
> -	/* No fb means shut it down */
> -	if (!fb) {
> +	/* No visible data means shut it down */
> +	if (drm_plane_needs_disable(plane->state, fb)) {
>   		plane->old_fb = plane->fb;
>   		ret = plane->funcs->disable_plane(plane, ctx);
>   		if (!ret) {
> @@ -913,8 +921,8 @@ static int __setplane_atomic(struct drm_plane *plane,
>   
>   	WARN_ON(!drm_drv_uses_atomic_modeset(plane->dev));
>   
> -	/* No fb means shut it down */
> -	if (!fb)
> +	/* No visible data means shut it down */
> +	if (drm_plane_needs_disable(plane->state, fb))
>   		return plane->funcs->disable_plane(plane, ctx);
>   
>   	/*
> @@ -987,6 +995,9 @@ int drm_mode_setplane(struct drm_device *dev, void *data,
>   		return -ENOENT;
>   	}
>   
> +	if (plane->state)
> +		plane->state->pixel_source = DRM_PLANE_PIXEL_SOURCE_FB;
> +
>   	if (plane_req->fb_id) {
>   		fb = drm_framebuffer_lookup(dev, file_priv, plane_req->fb_id);
>   		if (!fb) {
> diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
> index 88bdfec3bd88..122bbfbaae33 100644
> --- a/include/drm/drm_blend.h
> +++ b/include/drm/drm_blend.h
> @@ -58,4 +58,6 @@ int drm_atomic_normalize_zpos(struct drm_device *dev,
>   			      struct drm_atomic_state *state);
>   int drm_plane_create_blend_mode_property(struct drm_plane *plane,
>   					 unsigned int supported_modes);
> +int drm_plane_create_pixel_source_property(struct drm_plane *plane,
> +					   unsigned long extra_sources);
>   #endif
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 51291983ea44..89508b4dea4a 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -40,6 +40,12 @@ enum drm_scaling_filter {
>   	DRM_SCALING_FILTER_NEAREST_NEIGHBOR,
>   };
>   
> +enum drm_plane_pixel_source {
> +	DRM_PLANE_PIXEL_SOURCE_NONE,
> +	DRM_PLANE_PIXEL_SOURCE_FB,
> +	DRM_PLANE_PIXEL_SOURCE_MAX
> +};
> +
>   /**
>    * struct drm_plane_state - mutable plane state
>    *
> @@ -116,6 +122,14 @@ struct drm_plane_state {
>   	/** @src_h: height of visible portion of plane (in 16.16) */
>   	uint32_t src_h, src_w;
>   
> +	/**
> +	 * @pixel_source:
> +	 *
> +	 * Source of pixel information for the plane. See
> +	 * drm_plane_create_pixel_source_property() for more details.
> +	 */
> +	enum drm_plane_pixel_source pixel_source;
> +
>   	/**
>   	 * @alpha:
>   	 * Opacity of the plane with 0 as completely transparent and 0xffff as
> @@ -699,6 +713,13 @@ struct drm_plane {
>   	 */
>   	struct drm_plane_state *state;
>   
> +	/*
> +	 * @pixel_source_property:
> +	 * Optional pixel_source property for this plane. See
> +	 * drm_plane_create_pixel_source_property().
> +	 */
> +	struct drm_property *pixel_source_property;
> +
>   	/**
>   	 * @alpha_property:
>   	 * Optional alpha property for this plane. See
> 

-- 
With best wishes
Dmitry

