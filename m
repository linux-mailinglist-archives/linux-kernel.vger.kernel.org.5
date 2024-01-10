Return-Path: <linux-kernel+bounces-22045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148BE82985F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618A6B25722
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2634547A45;
	Wed, 10 Jan 2024 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Zic2V0Wi"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAF247795
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28cfca3c45so101984466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1704885049; x=1705489849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QlF0rRTBRD1E5jWA0kISaH2vZgtmpP2AfnIty3q4TQ=;
        b=Zic2V0Wiuaq4gTl+N44n1XUP4UA1b65X7cROPZrdK7Gqx47g5fLdSzeGowGK2w0ltl
         uTESACfTbt+JNpPh9ddtNWuMI73YHi5io0MAfsmKunlxPRRwTNRSp2bYVyDrMF7fMGpL
         RoqKUlYthJIDIg9/RPtT8+1Qn54W2C18gvfU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704885049; x=1705489849;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QlF0rRTBRD1E5jWA0kISaH2vZgtmpP2AfnIty3q4TQ=;
        b=CtNNoOA4iUSuyP8wqVyQ8jcMUK+RsR0zRn3D5AmkJMjnNtt8oW7KPelJF3Sb+6hfxQ
         Abj2Gf7S3m7kf5nB4lSvUh6z+knHvDjw+YiLG/JRSXGbmVJ6u3qd6NAMllZ9zfwk/nEx
         l1DkGDJi6Oy8r/Q3eIzD20qmR0m7tN9r9FbERXU5bGSepFAk+NpCOv/Vr6NyNMqy3wD8
         L7D4FR5FXKiFQr7WETSx2+QJ2c7vwrzgOMRNPX7pr2FPmK2zfMChV32Ot5fWR7jMKWjI
         BD0jK58KRTcN0pqFjIUBZcGgkN9m1aQQeUZeYMAQbKASr8vcKV/e3sFjWDeYj/WGO90g
         2a2w==
X-Gm-Message-State: AOJu0YyBtrwxyPQUgoqiqlAUdHspZ+KA3aI6zORrbvZK91ANpTMtHqgU
	gu6VoFMQPnJNUAPkfNpeEynJBxQzKc9T0Q==
X-Google-Smtp-Source: AGHT+IH17mNNLFHB3A8wZSZTcWuwmMBTnERZR6Mu2RaoActQZZYYvzEUdcGN2VlFuia3B3Yo7xfaKw==
X-Received: by 2002:a17:907:9445:b0:a27:7701:f16 with SMTP id dl5-20020a170907944500b00a2777010f16mr1131131ejc.7.1704885048816;
        Wed, 10 Jan 2024 03:10:48 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m27-20020a1709062adb00b00a269f8e8869sm1976817eje.128.2024.01.10.03.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 03:10:48 -0800 (PST)
Date: Wed, 10 Jan 2024 12:10:46 +0100
From: Daniel Vetter <daniel@ffwll.ch>
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
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	Simon Ser <contact@emersion.fr>,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH 3/7] drm/amd/display: Add handling for new "active color
 format" property
Message-ID: <ZZ57Nl3CnRMPcfbj@phenom.ffwll.local>
Mail-Followup-To: Andri Yngvason <andri@yngvason.is>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	Simon Ser <contact@emersion.fr>,
	Werner Sembach <wse@tuxedocomputers.com>
References: <20240109181104.1670304-1-andri@yngvason.is>
 <20240109181104.1670304-4-andri@yngvason.is>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109181104.1670304-4-andri@yngvason.is>
X-Operating-System: Linux phenom 6.5.0-4-amd64 

On Tue, Jan 09, 2024 at 06:11:00PM +0000, Andri Yngvason wrote:
> From: Werner Sembach <wse@tuxedocomputers.com>
> 
> This commit implements the "active color format" drm property for the AMD
> GPU driver.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Andri Yngvason <andri@yngvason.is>
> Tested-by: Andri Yngvason <andri@yngvason.is>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 42 ++++++++++++++++++-
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 ++
>  2 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 10e041a3b2545..b44d06c3b1706 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6882,6 +6882,24 @@ int convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth)
>  	return 0;
>  }
>  
> +static int convert_dc_pixel_encoding_into_drm_color_format(
> +	enum dc_pixel_encoding display_pixel_encoding)
> +{
> +	switch (display_pixel_encoding) {
> +	case PIXEL_ENCODING_RGB:
> +		return DRM_COLOR_FORMAT_RGB444;
> +	case PIXEL_ENCODING_YCBCR422:
> +		return DRM_COLOR_FORMAT_YCBCR422;
> +	case PIXEL_ENCODING_YCBCR444:
> +		return DRM_COLOR_FORMAT_YCBCR444;
> +	case PIXEL_ENCODING_YCBCR420:
> +		return DRM_COLOR_FORMAT_YCBCR420;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
>  static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
>  					  struct drm_crtc_state *crtc_state,
>  					  struct drm_connector_state *conn_state)
> @@ -7436,8 +7454,10 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>  				adev->mode_info.underscan_vborder_property,
>  				0);
>  
> -	if (!aconnector->mst_root)
> +	if (!aconnector->mst_root) {
>  		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
> +		drm_connector_attach_active_color_format_property(&aconnector->base);
> +	}
>  
>  	aconnector->base.state->max_bpc = 16;
>  	aconnector->base.state->max_requested_bpc = aconnector->base.state->max_bpc;
> @@ -8969,6 +8989,26 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  		kfree(dummy_updates);
>  	}
>  
> +	/* Extract information from crtc to communicate it to userspace as connector properties */
> +	for_each_new_connector_in_state(state, connector, new_con_state, i) {
> +		struct drm_crtc *crtc = new_con_state->crtc;
> +		struct dc_stream_state *stream;
> +
> +		if (crtc) {
> +			new_crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +			dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
> +			stream = dm_new_crtc_state->stream;
> +
> +			if (stream) {
> +				drm_connector_set_active_color_format_property(connector,
> +					convert_dc_pixel_encoding_into_drm_color_format(
> +						dm_new_crtc_state->stream->timing.pixel_encoding));
> +			}
> +		} else {
> +			drm_connector_set_active_color_format_property(connector, 0);

Just realized an even bigger reason why your current design doesn't work:
You don't have locking here.

And you cannot grab the required lock, which is
drm_dev->mode_config.mutex, because that would result in deadlocks. So
this really needs to use the atomic state based design I've described.

A bit a tanget, but it would be really good to add a lockdep assert into
drm_object_property_set_value, that at least for atomic drivers and
connectors the above lock must be held for changing property values. But
it will be quite a bit of audit to make sure all current users obey that
rule.

Cheers, Sima
> +		}
> +	}
> +
>  	/**
>  	 * Enable interrupts for CRTCs that are newly enabled or went through
>  	 * a modeset. It was intentionally deferred until after the front end
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 11da0eebee6c4..a4d1b3ea8f81c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -600,6 +600,10 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
>  	if (connector->max_bpc_property)
>  		drm_connector_attach_max_bpc_property(connector, 8, 16);
>  
> +	connector->active_color_format_property = master->base.active_color_format_property;
> +	if (connector->active_color_format_property)
> +		drm_connector_attach_active_color_format_property(&aconnector->base);
> +
>  	connector->vrr_capable_property = master->base.vrr_capable_property;
>  	if (connector->vrr_capable_property)
>  		drm_connector_attach_vrr_capable_property(connector);
> -- 
> 2.43.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

