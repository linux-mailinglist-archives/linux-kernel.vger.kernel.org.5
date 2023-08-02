Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C9276C8F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjHBJGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjHBJGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:06:03 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80292722
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:06:02 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-583a8596e2aso65349587b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690967162; x=1691571962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zJo1GDVdxjuEF3GZ0h8NCedqxxr4bUpTzfP363f04Q4=;
        b=xRGySJsX/O0+HhQkS9s1TftOkx+w+jubWByoUFUKefpw2nDpcBsHdp4/xIaD7QpT9W
         TiwMdHCvVtHdYongyJOBpuXq9XO/tcdXjHuZFW04WbnaXyUddsEFo4j6pnIcKkNUIE/3
         fKXlk2nD7GNIo/jtR9qQKQu6WBZdrsKXUHJDp7kQd2ObGjRwkn63H9quVg2vCFUd2RvC
         0+12chHxSUHVCM9NV0pIyZyEV6PgBAC3PZLtGCrweEf+xP1wmH2U4WsqScSnaLwx5sz1
         sVQ60Cud/S6wfOFT8336s4uRw25oh8Eu2f34Izfj+y+t35fWiGxgniykI0EU0+L76kGS
         Q7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690967162; x=1691571962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJo1GDVdxjuEF3GZ0h8NCedqxxr4bUpTzfP363f04Q4=;
        b=SUpjQguBrNHFiVym3P/JrzcLLIHwtyrPm4AyW0Bi6jxg4WSef3anMdMwG9rxpdmzn+
         AnNSaT1HmZ58C1fpApLzaZknjr5BGvXeLyU6C0xge6x5LJtxYQEgnfTc/9/sm+2qsDxi
         qf2ywTqqLVaLa0JxryHnrzGY0lXZHOwvxB4H7SEp8EbP/fa9dtG7q4dAxEb8FPo4AMQr
         ZoBGCx9abZ/1d79Hp37FDRMxllyEzObfMtcMeRyjT3v3T/od2azmhrHaRMm5enFhD/ZL
         Wq6OofoYqoWY4B8JAEthTkxPYEbE8AKo6L0icgvVF5ZpZubRxyEj95E5WRJIrr08lR37
         K8uA==
X-Gm-Message-State: ABy/qLaA/OWpXm0oh1iH1CKFy+vsq37cPQYjWS2paKdOyj3z9tgm8Bwy
        CS3OyCFPWGv/6pmKoDZusSSz7el9QHAsg/YS1fPGzw==
X-Google-Smtp-Source: APBJJlHe54V6RwR/aD4wxBit+WMtsfxJlYINs/ZT5LNjHwEGqkD1LUetUBnjUZ1FiOdGz7XZoUX8Xtdd8QI/8ZkfVZQ=
X-Received: by 2002:a81:6c52:0:b0:573:9e0a:b8bf with SMTP id
 h79-20020a816c52000000b005739e0ab8bfmr13033940ywc.9.1690967161816; Wed, 02
 Aug 2023 02:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
 <20230729004913.215872-3-dmitry.baryshkov@linaro.org> <0cc04d99-d7aa-68ff-b304-7d42ae7f0dde@linaro.org>
In-Reply-To: <0cc04d99-d7aa-68ff-b304-7d42ae7f0dde@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 2 Aug 2023 12:05:50 +0300
Message-ID: <CAA8EJpoMC-YbWvyfCsdAHOL9aw3nfQ=g8BgLp2mb9iozeRgBpg@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/bridge-connector: handle subconnector types
To:     neil.armstrong@linaro.org
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Simon Ser <contact@emersion.fr>, Janne Grunau <j@jannau.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 at 11:35, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 29/07/2023 02:49, Dmitry Baryshkov wrote:
> > If the created connector type supports subconnector type property,
> > create and attach corresponding it. The default subtype value is 0,
> > which maps to the DRM_MODE_SUBCONNECTOR_Unknown type.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/drm_bridge_connector.c | 33 +++++++++++++++++++++++++-
> >   include/drm/drm_bridge.h               |  4 ++++
> >   2 files changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
> > index 07b5930b1282..a7b92f0d2430 100644
> > --- a/drivers/gpu/drm/drm_bridge_connector.c
> > +++ b/drivers/gpu/drm/drm_bridge_connector.c
> > @@ -329,7 +329,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> >       struct drm_connector *connector;
> >       struct i2c_adapter *ddc = NULL;
> >       struct drm_bridge *bridge, *panel_bridge = NULL;
> > +     enum drm_mode_subconnector subconnector;
> >       int connector_type;
> > +     int ret;
> >
> >       bridge_connector = kzalloc(sizeof(*bridge_connector), GFP_KERNEL);
> >       if (!bridge_connector)
> > @@ -365,8 +367,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> >               if (bridge->ops & DRM_BRIDGE_OP_MODES)
> >                       bridge_connector->bridge_modes = bridge;
> >
> > -             if (!drm_bridge_get_next_bridge(bridge))
> > +             if (!drm_bridge_get_next_bridge(bridge)) {
> >                       connector_type = bridge->type;
> > +                     subconnector = bridge->subtype;
> > +             }
> >
> >   #ifdef CONFIG_OF
> >               if (!drm_bridge_get_next_bridge(bridge) &&
> > @@ -399,6 +403,33 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> >       if (panel_bridge)
> >               drm_panel_bridge_set_orientation(connector, panel_bridge);
> >
> > +     if (connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
> > +             drm_connector_attach_dp_subconnector_property(connector, subconnector);
> > +     } else if (connector_type == DRM_MODE_CONNECTOR_DVII) {
> > +             ret = drm_mode_create_dvi_i_properties(drm);
> > +             if (ret)
> > +                     return ERR_PTR(ret);
> > +
> > +             drm_object_attach_property(&connector->base,
> > +                                        drm->mode_config.dvi_i_subconnector_property,
> > +                                        subconnector);
> > +     } else if (connector_type == DRM_MODE_CONNECTOR_TV) {
> > +             ret = drm_mode_create_tv_properties(drm,
> > +                                                 BIT(DRM_MODE_TV_MODE_NTSC) |
> > +                                                 BIT(DRM_MODE_TV_MODE_NTSC_443) |
> > +                                                 BIT(DRM_MODE_TV_MODE_NTSC_J) |
> > +                                                 BIT(DRM_MODE_TV_MODE_PAL) |
> > +                                                 BIT(DRM_MODE_TV_MODE_PAL_M) |
> > +                                                 BIT(DRM_MODE_TV_MODE_PAL_N) |
> > +                                                 BIT(DRM_MODE_TV_MODE_SECAM));
> > +             if (ret)
> > +                     return ERR_PTR(ret);
>
> I don't think this is right, this should be called from the appropriate encoder
> device depending on the analog tv mode capabilities.

Good question. My logic was the following: the DRM device can have
different TV out ports with different capabilities (yeah, pure
theoretical construct). In this case it might be impossible to create
a single subset of values. Thus it is more correct to create the
property listing all possible values. The property is immutable anyway
(and so the user doesn't have control over the value).


> > +
> > +             drm_object_attach_property(&connector->base,
> > +                                        drm->mode_config.tv_subconnector_property,
> > +                                        subconnector);
>
> Here, only add the property if drm->mode_config.tv_subconnector_property exists,
> and perhaps add a warning if not.

This property is created in the previous call,
drm_mode_create_tv_properties() ->
drm_mode_create_tv_properties_legacy().

>
> AFAIK same for DRM_MODE_CONNECTOR_DVII.
>
> > +     }
> > +
> >       return connector;
> >   }
> >   EXPORT_SYMBOL_GPL(drm_bridge_connector_init);
> > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > index bf964cdfb330..68b14ac5ac0d 100644
> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -739,6 +739,10 @@ struct drm_bridge {
> >        * identifies the type of connected display.
> >        */
> >       int type;
> > +     /**
> > +      * @subtype: the subtype of the connector for the DP/TV/DVI-I cases.
> > +      */
> > +     enum drm_mode_subconnector subtype;
> >       /**
> >        * @interlace_allowed: Indicate that the bridge can handle interlaced
> >        * modes.
>


-- 
With best wishes
Dmitry
