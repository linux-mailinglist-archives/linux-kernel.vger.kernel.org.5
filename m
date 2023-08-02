Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3376D742
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjHBSzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjHBSyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:54:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C18268F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:54:51 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 467FB9CA;
        Wed,  2 Aug 2023 20:53:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691002425;
        bh=OVx5FkMIa2iYuBp8dPtECHSysjxm0CBaTXkjsc66ca4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ia06q6hZqpsDbC7xY5h03GLveFErvSz+YGlpka6bOhVBWSytIKSianDo9rbuGtVFO
         AtR4+gipnPbuQyThXfDCWuLsxcAn9ZSZBXoRNQFqyMlhVLCgtzMc/9g6hEH478HAp9
         T2oLY+ccUPNgwPmrItONuIocN625D9dFjLXX4RBY=
Date:   Wed, 2 Aug 2023 21:54:54 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Simon Ser <contact@emersion.fr>, Janne Grunau <j@jannau.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/4] drm: allow specifying default subtype for the DP
 subconnector property
Message-ID: <20230802185454.GA29718@pendragon.ideasonboard.com>
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
 <20230729004913.215872-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230729004913.215872-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for the patch.

On Sat, Jul 29, 2023 at 03:49:10AM +0300, Dmitry Baryshkov wrote:
> In the embedded usecases the default subtype depends on the bridge
> chain, so it is easier to specify the subtype at the proprety attachment

s/proprety/property/

> type rather than specifying it later.

Did you mean s/type/time/ ?

I think I understand why you need this, looking at patch 2/4, but the
commit message isn't very clear. It would benefit from being reworded.

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c              | 3 ++-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ++-
>  drivers/gpu/drm/drm_connector.c                             | 6 ++++--
>  drivers/gpu/drm/i915/display/intel_dp.c                     | 3 ++-
>  include/drm/drm_connector.h                                 | 3 ++-
>  5 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> index d34037b85cf8..c18459ecd4be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -2022,7 +2022,8 @@ amdgpu_connector_add(struct amdgpu_device *adev,
>  
>  	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
>  	    connector_type == DRM_MODE_CONNECTOR_eDP) {
> -		drm_connector_attach_dp_subconnector_property(&amdgpu_connector->base);
> +		drm_connector_attach_dp_subconnector_property(&amdgpu_connector->base,
> +							      DRM_MODE_SUBCONNECTOR_Unknown);
>  	}
>  
>  	return;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 943959012d04..297321f0199e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -759,7 +759,8 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
>  	drm_dp_mst_topology_mgr_init(&aconnector->mst_mgr, adev_to_drm(dm->adev),
>  				     &aconnector->dm_dp_aux.aux, 16, 4, aconnector->connector_id);
>  
> -	drm_connector_attach_dp_subconnector_property(&aconnector->base);
> +	drm_connector_attach_dp_subconnector_property(&aconnector->base,
> +						      DRM_MODE_SUBCONNECTOR_Unknown);
>  }
>  
>  int dm_mst_get_pbn_divider(struct dc_link *link)
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index a3d3e7dc08b2..a6066e4a5e9a 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1577,10 +1577,12 @@ EXPORT_SYMBOL(drm_mode_create_dvi_i_properties);
>  /**
>   * drm_connector_attach_dp_subconnector_property - create subconnector property for DP
>   * @connector: drm_connector to attach property
> + * @subtype: initial value for the subconnector type
>   *
>   * Called by a driver when DP connector is created.
>   */
> -void drm_connector_attach_dp_subconnector_property(struct drm_connector *connector)
> +void drm_connector_attach_dp_subconnector_property(struct drm_connector *connector,
> +						   enum drm_mode_subconnector subtype)
>  {
>  	struct drm_mode_config *mode_config = &connector->dev->mode_config;
>  
> @@ -1594,7 +1596,7 @@ void drm_connector_attach_dp_subconnector_property(struct drm_connector *connect
>  
>  	drm_object_attach_property(&connector->base,
>  				   mode_config->dp_subconnector_property,
> -				   DRM_MODE_SUBCONNECTOR_Unknown);
> +				   subtype);
>  }
>  EXPORT_SYMBOL(drm_connector_attach_dp_subconnector_property);
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 474785110662..5819105187f6 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -5391,7 +5391,8 @@ intel_dp_add_properties(struct intel_dp *intel_dp, struct drm_connector *connect
>  	enum port port = dp_to_dig_port(intel_dp)->base.port;
>  
>  	if (!intel_dp_is_edp(intel_dp))
> -		drm_connector_attach_dp_subconnector_property(connector);
> +		drm_connector_attach_dp_subconnector_property(connector,
> +							      DRM_MODE_SUBCONNECTOR_Unknown);
>  
>  	if (!IS_G4X(dev_priv) && port != PORT_A)
>  		intel_attach_force_audio_property(connector);
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 5a8115dca359..a130a78f6e0f 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1990,7 +1990,8 @@ const char *drm_get_hdcp_content_type_name(int val);
>  int drm_get_tv_mode_from_name(const char *name, size_t len);
>  
>  int drm_mode_create_dvi_i_properties(struct drm_device *dev);
> -void drm_connector_attach_dp_subconnector_property(struct drm_connector *connector);
> +void drm_connector_attach_dp_subconnector_property(struct drm_connector *connector,
> +						   enum drm_mode_subconnector subtype);
>  
>  int drm_mode_create_tv_margin_properties(struct drm_device *dev);
>  int drm_mode_create_tv_properties_legacy(struct drm_device *dev,

-- 
Regards,

Laurent Pinchart
