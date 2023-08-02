Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0876D75A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjHBTB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjHBTBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:01:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE5FAC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 12:01:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c1f6f3884so22975166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691002883; x=1691607683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osatjqbzo6JXPILQNRf8QUtP7yGmhdrE/e+FRS4B8NY=;
        b=Q6qrnGQGmpFmn2tv1ponn9yGlDVg5Ek+b3lggx0DNPLeBggUAlhbvMr1jJ2Ka7dNhi
         EEO4CJJvjy4VIrpKL6pI/J2TUDtvSFOmlKswXNY7IoA6QeSKZGt9NJeazaCdp1PP7YXb
         mR8U5/2w+nMEXBSsJgfzBrMxnzD2Vbkwuuir6dp2XKYLGB1VmY+ekoThUGmjK26/illo
         JOGea7UmxK5ojg1+U/pPGCpk7DAO+JkK9NoPODmRXJQ9+je6mMqZYQFbxwtt4to8tEy7
         YmvuW/fuj0b81Z4nrzQ4beKqyq+cO9MEtE8gCh8O9KOU5jTN/+UglZ/BHznwjUGJiYVB
         iT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691002883; x=1691607683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osatjqbzo6JXPILQNRf8QUtP7yGmhdrE/e+FRS4B8NY=;
        b=OO2nY7NqR8vGRs9nJ50Nmu+BObSx+C0YA6YlPQP23dSiueb3suof5Cs2ByYdmxsA4t
         RGpzY+MOEg1HM5e3TRrQ2jhagLwvwDrDeKi/AvkoMOzLQE8FvXcfjrRPexvQB5f8mcch
         Wim3EuNfTLbopACFV1g8h481M9wrsSPQbL5WpgyVEV19MdX14ig7ZX1z3bdEDAGhpLhB
         xS5sml9NqEabOhs/L2n2g5YVWdB7UBq7RSvijbGC2aAsrMcc8VEho2slllYTRXnhmGtT
         Fq8xgQobrM/2ENf+eO2aLM4aePq1HeNE65J7NZjYaVluQbXm5WUtl21O/5ZCVunMIOXM
         yFrA==
X-Gm-Message-State: ABy/qLY1Q93N0dHlbktwuwHPh1Ql+4wEYwXDE0iTalqKib2kh5fjbbTZ
        F12w4HVSfSyByHZq5t39vrlzRw==
X-Google-Smtp-Source: APBJJlGQs27IGKD1hLzqWX1o2A+XRPg/fCz8VX60XxBKLLEPVEnAqXC7Ba2YEC7T9oK7L8iZwnYR8w==
X-Received: by 2002:a17:906:224b:b0:99b:d435:e994 with SMTP id 11-20020a170906224b00b0099bd435e994mr5895647ejr.32.1691002883015;
        Wed, 02 Aug 2023 12:01:23 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id jp21-20020a170906f75500b00988c0c175c6sm9441808ejb.189.2023.08.02.12.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 12:01:22 -0700 (PDT)
Message-ID: <a32ce695-038f-0ef8-3584-5bd1ba528131@linaro.org>
Date:   Wed, 2 Aug 2023 22:01:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] drm/uapi: document the USB subconnector type
Content-Language: en-GB
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
 <20230729004913.215872-4-dmitry.baryshkov@linaro.org>
 <20230802185547.GC32500@pendragon.ideasonboard.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230802185547.GC32500@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 21:55, Laurent Pinchart wrote:
> Hi Dmitry,
> 
> Thank you for the patch.
> 
> On Sat, Jul 29, 2023 at 03:49:12AM +0300, Dmitry Baryshkov wrote:
>> To properly define the USB-C DP altmode connectors, add the USB
>> subconnector type.
>>
>> Suggested-by: Simon Ser <contact@emersion.fr>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/gpu/drm/drm_connector.c | 1 +
>>   include/uapi/drm/drm_mode.h     | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
>> index a6066e4a5e9a..9e96b038f5d0 100644
>> --- a/drivers/gpu/drm/drm_connector.c
>> +++ b/drivers/gpu/drm/drm_connector.c
>> @@ -1050,6 +1050,7 @@ static const struct drm_prop_enum_list drm_dp_subconnector_enum_list[] = {
>>   	{ DRM_MODE_SUBCONNECTOR_DisplayPort, "DP"        }, /* DP */
>>   	{ DRM_MODE_SUBCONNECTOR_Wireless,    "Wireless"  }, /* DP */
>>   	{ DRM_MODE_SUBCONNECTOR_Native,	     "Native"    }, /* DP */
>> +	{ DRM_MODE_SUBCONNECTOR_USB,	     "USB"       }, /* DP */
> 
> Should this be DRM_MODE_SUBCONNECTOR_USB_C and "USB-C", in case we get
> another USB type later ?

Hmm, which id should I use for micro-USB then? (consider anx7808, 
SlimPort). I thought about using DRM_MODE_SUBCONNECTOR_USB for both of 
them. But maybe I should add another subtype for SlimPort.

> 
>>   };
>>   
>>   DRM_ENUM_NAME_FN(drm_get_dp_subconnector_name,
>> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
>> index 92d96a2b6763..0f74918b011c 100644
>> --- a/include/uapi/drm/drm_mode.h
>> +++ b/include/uapi/drm/drm_mode.h
>> @@ -398,6 +398,7 @@ enum drm_mode_subconnector {
>>   	DRM_MODE_SUBCONNECTOR_HDMIA       = 11, /*            DP */
>>   	DRM_MODE_SUBCONNECTOR_Native      = 15, /*            DP */
>>   	DRM_MODE_SUBCONNECTOR_Wireless    = 18, /*            DP */
>> +	DRM_MODE_SUBCONNECTOR_USB         = 20, /*            DP */
>>   };
>>   
>>   #define DRM_MODE_CONNECTOR_Unknown	0
> 

-- 
With best wishes
Dmitry

