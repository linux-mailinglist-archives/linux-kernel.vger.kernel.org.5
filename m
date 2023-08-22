Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23B6783D67
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjHVJ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjHVJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885E11A1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692698146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JlPpdmOPNah22Y7KSbuXMrfVQtLyHU45KlxBrK0MuU0=;
        b=fEdwMdn8CUoDNz9QnwdKvfNdDA8eu0gm1fkUNoLmSop5LQgWR0M7oiAiHHlxBD5UzF15TI
        LyNmTuMpC6qE0StEdj92DBav7v1+c0KUKVAhbCONsbqaESRUXfHzo1U+67t79spJpHikEO
        BAkiu9CKSJfeX9TW7XdFnCl2di7Nf+I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-0PD6XVKTNTKE-fwCEavGag-1; Tue, 22 Aug 2023 05:55:45 -0400
X-MC-Unique: 0PD6XVKTNTKE-fwCEavGag-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe216798e9so28428895e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692698144; x=1693302944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JlPpdmOPNah22Y7KSbuXMrfVQtLyHU45KlxBrK0MuU0=;
        b=LlK/qCzX5Vtc4srdwW/J3qei48zorRT95AIqKLJaOxPpaP/lplDp8png7lwu0GocBs
         xx03CAMhDkyTq/1TSmzjJ70fAhxjfGYVDPzZK/wIrgW8VNy+9Wq+YPifjQ9zxRQu8G9y
         Zp/mhH5Kr1f/KBNvbx6pSMdD5+5s38MRHrCQKGuG4tISytv0LD7cGkKe7Kd01Np7i6Va
         8B9QAszryEYnKmoLa+bQL+Q/8V6q5McbO8fgQb50MeCkezW8EBRSPjI3MHyqs4MfAAvi
         UWnsE4jTznmNankU5Jg8IviXxICLn6cjej2njT68cB8HQgJUMitVSGWV55m81SdR2LQ1
         Hgiw==
X-Gm-Message-State: AOJu0YwzqZ5J/NUC3wYeCwh3mJOniJwPkeMgKW+sSvS2EmKVizuDSF1B
        dRUr06+glEiTF/Gfi15B+L6ZMxgzkkGmKd7OrDXmgWs98KhD3lFfireitezl0G6ivg7xM2Lhn2b
        Ke5Sxx0qauCTwUNEcJX6CKLbQ
X-Received: by 2002:adf:f405:0:b0:317:5eb8:b1c4 with SMTP id g5-20020adff405000000b003175eb8b1c4mr7768962wro.2.1692698144290;
        Tue, 22 Aug 2023 02:55:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgF/Yousk5x+50wI8hFuNqpLCpQeaVe39/29TiQhdgw9ZK1+z5je96xbrCiOhE74jmuvxFXg==
X-Received: by 2002:adf:f405:0:b0:317:5eb8:b1c4 with SMTP id g5-20020adff405000000b003175eb8b1c4mr7768951wro.2.1692698143902;
        Tue, 22 Aug 2023 02:55:43 -0700 (PDT)
Received: from toolbox ([2001:9e8:89b6:500:ebf6:f095:1c69:67b4])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d6749000000b003143867d2ebsm15492195wrw.63.2023.08.22.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 02:55:43 -0700 (PDT)
Date:   Tue, 22 Aug 2023 11:55:41 +0200
From:   Sebastian Wick <sebastian.wick@redhat.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wayland-devel@lists.freedesktop.org,
        pierre-eric.pelloux-prayer@amd.com,
        Daniel Vetter <daniel@ffwll.ch>,
        'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>, hwentlan@amd.com,
        Rob Clark <robdclark@gmail.com>, ville.syrjala@linux.intel.com,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        Dave Airlie <airlied@gmail.com>, christian.koenig@amd.com,
        joshua@froggi.es, Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH v6 5/6] drm: Refuse to async flip with atomic prop changes
Message-ID: <20230822095541.GA110557@toolbox>
References: <20230815185710.159779-1-andrealmeid@igalia.com>
 <20230815185710.159779-6-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230815185710.159779-6-andrealmeid@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 03:57:09PM -0300, André Almeida wrote:
> Given that prop changes may lead to modesetting, which would defeat the
> fast path of the async flip, refuse any atomic prop change for async
> flips in atomic API. The only exceptions are the framebuffer ID to flip
> to and the mode ID, that could be referring to an identical mode.

FYI, the solid fill series adds an enum drm_plane_pixel_source and and a
new solid fill pixel source. Changing the solid fill color would be
effectively the same as changing the FB_ID. On the other hand, changing
the FB_ID no longer necessarily results in an update when the pixel
source is set to solid fill.

> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> v5: no changes
> v4: new patch
> ---
>  drivers/gpu/drm/drm_atomic_helper.c |  5 +++
>  drivers/gpu/drm/drm_atomic_uapi.c   | 52 +++++++++++++++++++++++++++--
>  drivers/gpu/drm/drm_crtc_internal.h |  2 +-
>  drivers/gpu/drm/drm_mode_object.c   |  2 +-
>  4 files changed, 56 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 292e38eb6218..b34e3104afd1 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -629,6 +629,11 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
>  		WARN_ON(!drm_modeset_is_locked(&crtc->mutex));
>  
>  		if (!drm_mode_equal(&old_crtc_state->mode, &new_crtc_state->mode)) {
> +			if (new_crtc_state->async_flip) {
> +				drm_dbg_atomic(dev, "[CRTC:%d:%s] no mode changes allowed during async flip\n",
> +					       crtc->base.id, crtc->name);
> +				return -EINVAL;
> +			}
>  			drm_dbg_atomic(dev, "[CRTC:%d:%s] mode changed\n",
>  				       crtc->base.id, crtc->name);
>  			new_crtc_state->mode_changed = true;
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index a15121e75a0a..6c423a7e8c7b 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1006,13 +1006,28 @@ int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
>  	return ret;
>  }
>  
> +static int drm_atomic_check_prop_changes(int ret, uint64_t old_val, uint64_t prop_value,
> +					 struct drm_property *prop)
> +{
> +	if (ret != 0 || old_val != prop_value) {
> +		drm_dbg_atomic(prop->dev,
> +			       "[PROP:%d:%s] No prop can be changed during async flip\n",
> +			       prop->base.id, prop->name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  int drm_atomic_set_property(struct drm_atomic_state *state,
>  			    struct drm_file *file_priv,
>  			    struct drm_mode_object *obj,
>  			    struct drm_property *prop,
> -			    uint64_t prop_value)
> +			    uint64_t prop_value,
> +			    bool async_flip)
>  {
>  	struct drm_mode_object *ref;
> +	uint64_t old_val;
>  	int ret;
>  
>  	if (!drm_property_change_valid_get(prop, prop_value, &ref))
> @@ -1029,6 +1044,13 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  			break;
>  		}
>  
> +		if (async_flip) {
> +			ret = drm_atomic_connector_get_property(connector, connector_state,
> +								prop, &old_val);
> +			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
> +			break;
> +		}
> +
>  		ret = drm_atomic_connector_set_property(connector,
>  				connector_state, file_priv,
>  				prop, prop_value);
> @@ -1037,6 +1059,7 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  	case DRM_MODE_OBJECT_CRTC: {
>  		struct drm_crtc *crtc = obj_to_crtc(obj);
>  		struct drm_crtc_state *crtc_state;
> +		struct drm_mode_config *config = &crtc->dev->mode_config;
>  
>  		crtc_state = drm_atomic_get_crtc_state(state, crtc);
>  		if (IS_ERR(crtc_state)) {
> @@ -1044,6 +1067,18 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  			break;
>  		}
>  
> +		/*
> +		 * We allow mode_id changes here for async flips, because we
> +		 * check later on drm_atomic_helper_check_modeset() callers if
> +		 * there are modeset changes or they are equal
> +		 */
> +		if (async_flip && prop != config->prop_mode_id) {
> +			ret = drm_atomic_crtc_get_property(crtc, crtc_state,
> +							   prop, &old_val);
> +			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
> +			break;
> +		}
> +
>  		ret = drm_atomic_crtc_set_property(crtc,
>  				crtc_state, prop, prop_value);
>  		break;
> @@ -1051,6 +1086,7 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  	case DRM_MODE_OBJECT_PLANE: {
>  		struct drm_plane *plane = obj_to_plane(obj);
>  		struct drm_plane_state *plane_state;
> +		struct drm_mode_config *config = &plane->dev->mode_config;
>  
>  		plane_state = drm_atomic_get_plane_state(state, plane);
>  		if (IS_ERR(plane_state)) {
> @@ -1058,6 +1094,13 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  			break;
>  		}
>  
> +		if (async_flip && prop != config->prop_fb_id) {
> +			ret = drm_atomic_plane_get_property(plane, plane_state,
> +							    prop, &old_val);
> +			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
> +			break;
> +		}
> +
>  		ret = drm_atomic_plane_set_property(plane,
>  				plane_state, file_priv,
>  				prop, prop_value);
> @@ -1349,6 +1392,7 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  	struct drm_out_fence_state *fence_state;
>  	int ret = 0;
>  	unsigned int i, j, num_fences;
> +	bool async_flip = false;
>  
>  	/* disallow for drivers not supporting atomic: */
>  	if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
> @@ -1385,6 +1429,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  				       "commit failed: DRM_MODE_PAGE_FLIP_ASYNC not supported with atomic\n");
>  			return -EINVAL;
>  		}
> +
> +		async_flip = true;
>  	}
>  
>  	/* can't test and expect an event at the same time. */
> @@ -1469,8 +1515,8 @@ int drm_mode_atomic_ioctl(struct drm_device *dev,
>  				goto out;
>  			}
>  
> -			ret = drm_atomic_set_property(state, file_priv,
> -						      obj, prop, prop_value);
> +			ret = drm_atomic_set_property(state, file_priv, obj,
> +						      prop, prop_value, async_flip);
>  			if (ret) {
>  				drm_mode_object_put(obj);
>  				goto out;
> diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
> index 501a10edd0e1..381130cebe81 100644
> --- a/drivers/gpu/drm/drm_crtc_internal.h
> +++ b/drivers/gpu/drm/drm_crtc_internal.h
> @@ -251,7 +251,7 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  			    struct drm_file *file_priv,
>  			    struct drm_mode_object *obj,
>  			    struct drm_property *prop,
> -			    uint64_t prop_value);
> +			    uint64_t prop_value, bool async_flip);
>  int drm_atomic_get_property(struct drm_mode_object *obj,
>  			    struct drm_property *property, uint64_t *val);
>  
> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> index ac0d2ce3f870..0e8355063eee 100644
> --- a/drivers/gpu/drm/drm_mode_object.c
> +++ b/drivers/gpu/drm/drm_mode_object.c
> @@ -538,7 +538,7 @@ static int set_property_atomic(struct drm_mode_object *obj,
>  						       obj_to_connector(obj),
>  						       prop_value);
>  	} else {
> -		ret = drm_atomic_set_property(state, file_priv, obj, prop, prop_value);
> +		ret = drm_atomic_set_property(state, file_priv, obj, prop, prop_value, false);
>  		if (ret)
>  			goto out;
>  		ret = drm_atomic_commit(state);
> -- 
> 2.41.0
> 

