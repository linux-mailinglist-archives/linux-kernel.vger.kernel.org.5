Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B3976D731
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjHBSvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjHBSvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:51:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1A219BF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:51:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so81804a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691002277; x=1691607077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RCZLkToae8HL/gFbPITWXu017CVf8yll8/Ph2yV1gks=;
        b=LLaJKHTScW1OzORT7eJ90XsCAveSMO3hgLq4BhDjo5rFyd+zY48YP54sl+LgglI2T2
         DIPcYmbsIsfIPktFOeJWDTXhpVMK8leXyQa1JOuxC+SAZkcLoUb35Vi4qGa0MRY13iBb
         KMBUOznC5Lr9+iRZsSy/Ur41pIlA2nXd7Q5978Z9TVMKq6+Fb5bQf9iThsS19Oe9b1y3
         NCzFUPKDd+2v/YzTuleIsCczy/Px2mIV0I0fIYRhjPVPGrSBInasEbtjT339c8zq6619
         WCBupX6moTa54Odj9Qu6H1ucnExqf4bYgtBbpeqpgL5xuiIl2qQANNVbx2W1Ug52sIKa
         OIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691002277; x=1691607077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCZLkToae8HL/gFbPITWXu017CVf8yll8/Ph2yV1gks=;
        b=Xqfluv2zsQE7itCmJMqlPbEROiRaQZZBXAv00k6Ix6j7/dM8SrTfamMmb0hXy5W7Gj
         oYskfa85x89x4C9XuUGU80MB16Eo1qD83xydmcmOBGZ0iGCUbmO+pxbYDpj7ghXBWbwi
         r1VMc3OXvTDubWJtBSB8NRQytmGfPVASLk1cHhga4qKQNbwjZM2Am8K66+dIhRWq1Kae
         FtxZP1nuuns+2CVNbBPL+QlSgeQMwQRBAIwcjGlQoSh+pQZ3cRtWkZdZjJnC+J9v5BQF
         RbZlXv1Jx23Ia3lMYtocp4NhOEHwiqLUW90F95AqeZrbbSDStn0ir0r24zG3Q8LpyZtf
         0bBw==
X-Gm-Message-State: ABy/qLbAs4QydSuiVRJMFHV7utW4E8kV8lC13YKuirAqTNDrEi4uFPvz
        TOJMjMNWhFCf3R6dn4xQ9vPLzw==
X-Google-Smtp-Source: APBJJlFjCx8kfwFZvnJkNHp2O2anUpJ/yeTbP3psosO7PM0zLVpeLW1pMmnOeSIkXwO7X4DYFdRRfQ==
X-Received: by 2002:aa7:dad2:0:b0:522:1fd1:1035 with SMTP id x18-20020aa7dad2000000b005221fd11035mr5209756eds.6.1691002277001;
        Wed, 02 Aug 2023 11:51:17 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id bo9-20020a0564020b2900b0052284228e3bsm9004448edb.8.2023.08.02.11.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 11:51:16 -0700 (PDT)
Message-ID: <5464f068-d157-36b3-a1f1-a92ca993511a@linaro.org>
Date:   Wed, 2 Aug 2023 21:51:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] drm/bridge-connector: handle subconnector types
Content-Language: en-GB
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     neil.armstrong@linaro.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Simon Ser <contact@emersion.fr>, Janne Grunau <j@jannau.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
 <20230729004913.215872-3-dmitry.baryshkov@linaro.org>
 <0cc04d99-d7aa-68ff-b304-7d42ae7f0dde@linaro.org>
 <CAA8EJpoMC-YbWvyfCsdAHOL9aw3nfQ=g8BgLp2mb9iozeRgBpg@mail.gmail.com>
 <20230802184622.GA32500@pendragon.ideasonboard.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230802184622.GA32500@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 21:46, Laurent Pinchart wrote:
> On Wed, Aug 02, 2023 at 12:05:50PM +0300, Dmitry Baryshkov wrote:
>> On Wed, 2 Aug 2023 at 11:35, Neil Armstrong wrote:
>>> On 29/07/2023 02:49, Dmitry Baryshkov wrote:
>>>> If the created connector type supports subconnector type property,
>>>> create and attach corresponding it. The default subtype value is 0,
>>>> which maps to the DRM_MODE_SUBCONNECTOR_Unknown type.
>>>>
>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> ---
>>>>    drivers/gpu/drm/drm_bridge_connector.c | 33 +++++++++++++++++++++++++-
>>>>    include/drm/drm_bridge.h               |  4 ++++
>>>>    2 files changed, 36 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
>>>> index 07b5930b1282..a7b92f0d2430 100644
>>>> --- a/drivers/gpu/drm/drm_bridge_connector.c
>>>> +++ b/drivers/gpu/drm/drm_bridge_connector.c
>>>> @@ -329,7 +329,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>>>>        struct drm_connector *connector;
>>>>        struct i2c_adapter *ddc = NULL;
>>>>        struct drm_bridge *bridge, *panel_bridge = NULL;
>>>> +     enum drm_mode_subconnector subconnector;
>>>>        int connector_type;
>>>> +     int ret;
>>>>
>>>>        bridge_connector = kzalloc(sizeof(*bridge_connector), GFP_KERNEL);
>>>>        if (!bridge_connector)
>>>> @@ -365,8 +367,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>>>>                if (bridge->ops & DRM_BRIDGE_OP_MODES)
>>>>                        bridge_connector->bridge_modes = bridge;
>>>>
>>>> -             if (!drm_bridge_get_next_bridge(bridge))
>>>> +             if (!drm_bridge_get_next_bridge(bridge)) {
>>>>                        connector_type = bridge->type;
>>>> +                     subconnector = bridge->subtype;
>>>> +             }
>>>>
>>>>    #ifdef CONFIG_OF
>>>>                if (!drm_bridge_get_next_bridge(bridge) &&
>>>> @@ -399,6 +403,33 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>>>>        if (panel_bridge)
>>>>                drm_panel_bridge_set_orientation(connector, panel_bridge);
>>>>
>>>> +     if (connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
>>>> +             drm_connector_attach_dp_subconnector_property(connector, subconnector);
>>>> +     } else if (connector_type == DRM_MODE_CONNECTOR_DVII) {
>>>> +             ret = drm_mode_create_dvi_i_properties(drm);
>>>> +             if (ret)
>>>> +                     return ERR_PTR(ret);
>>>> +
>>>> +             drm_object_attach_property(&connector->base,
>>>> +                                        drm->mode_config.dvi_i_subconnector_property,
>>>> +                                        subconnector);
>>>> +     } else if (connector_type == DRM_MODE_CONNECTOR_TV) {
>>>> +             ret = drm_mode_create_tv_properties(drm,
>>>> +                                                 BIT(DRM_MODE_TV_MODE_NTSC) |
>>>> +                                                 BIT(DRM_MODE_TV_MODE_NTSC_443) |
>>>> +                                                 BIT(DRM_MODE_TV_MODE_NTSC_J) |
>>>> +                                                 BIT(DRM_MODE_TV_MODE_PAL) |
>>>> +                                                 BIT(DRM_MODE_TV_MODE_PAL_M) |
>>>> +                                                 BIT(DRM_MODE_TV_MODE_PAL_N) |
>>>> +                                                 BIT(DRM_MODE_TV_MODE_SECAM));
>>>> +             if (ret)
>>>> +                     return ERR_PTR(ret);
>>>
>>> I don't think this is right, this should be called from the appropriate encoder
>>> device depending on the analog tv mode capabilities.
>>
>> Good question. My logic was the following: the DRM device can have
>> different TV out ports with different capabilities (yeah, pure
>> theoretical construct). In this case it might be impossible to create
>> a single subset of values. Thus it is more correct to create the
>> property listing all possible values. The property is immutable anyway
>> (and so the user doesn't have control over the value).
> 
> Those ports would correspond to different connectors, so I agree with
> Neil, I don't think it's right to create a single property with all
> modes and attach it to all analog output connectors.

I agree that this case is mishandled currently (as current design 
assumes a single property that fits for the complete device).

> 
> If you want to support multiple analog outputs that have different
> capabilities, this will need changes to drm_mode_create_tv_properties()
> to allow creating multiple properties. If you don't want to do so now,
> and prefer limiting support to devices where all ports support the same
> modes (which includes devices with a single analog output), then the
> modes should reflect what the device supports.

Ack, I'll drop the create call and check for the property existence 
before attaching it.

> 
>>>> +
>>>> +             drm_object_attach_property(&connector->base,
>>>> +                                        drm->mode_config.tv_subconnector_property,
>>>> +                                        subconnector);
>>>
>>> Here, only add the property if drm->mode_config.tv_subconnector_property exists,
>>> and perhaps add a warning if not.
>>
>> This property is created in the previous call,
>> drm_mode_create_tv_properties() ->
>> drm_mode_create_tv_properties_legacy().
>>
>>> AFAIK same for DRM_MODE_CONNECTOR_DVII.
>>>
>>>> +     }
>>>> +
>>>>        return connector;
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(drm_bridge_connector_init);
>>>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>>>> index bf964cdfb330..68b14ac5ac0d 100644
>>>> --- a/include/drm/drm_bridge.h
>>>> +++ b/include/drm/drm_bridge.h
>>>> @@ -739,6 +739,10 @@ struct drm_bridge {
>>>>         * identifies the type of connected display.
>>>>         */
>>>>        int type;
>>>> +     /**
>>>> +      * @subtype: the subtype of the connector for the DP/TV/DVI-I cases.
>>>> +      */
>>>> +     enum drm_mode_subconnector subtype;
>>>>        /**
>>>>         * @interlace_allowed: Indicate that the bridge can handle interlaced
>>>>         * modes.
> 

-- 
With best wishes
Dmitry

