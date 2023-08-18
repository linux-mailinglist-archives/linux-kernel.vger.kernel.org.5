Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653E7780AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376287AbjHRLDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359857AbjHRLDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:03:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5FB30C4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 04:03:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so12536281fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692356597; x=1692961397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Jh7ItFYHU5zNIGLCstW/Pzdq1xmgVbG9y2RMD0DjmE=;
        b=ImO4DuA79mgCfrF590YuamU/xZhUWnoTy+yVYcQtO1frAroKqxut6QZJI+LacYKq5F
         qHkJ6IdzqcPmHHD3s/d4XzYPkE6/pDOQD0CETUl/wXsQRGndehiVvEVj/z29vm3/Wm5+
         SndiY9n2iID5YlSCpzB2a/a5Ygvsg7c7bEG9ulm6lJR6sQdlU8bZkBy7i6oJG6AT3qUq
         jwGBqUlGvg9BolzBQ6Ptf/70OZajMpFQZtgXr/uM2pDCAfzQ1vzuwXcEgZBwFtyH8lbw
         uTrihK8I2mrAPyq4WSG4f28n3WHIctIqcaDlXa/5PiTOJgM/5J0+4CuRwE6Ak63iDjjw
         dI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692356597; x=1692961397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Jh7ItFYHU5zNIGLCstW/Pzdq1xmgVbG9y2RMD0DjmE=;
        b=eMjIlFB7dRr3x2Ul3VQTcyD5S8apgXBLvAjecwMpa/72vwJpiRdnS3xQ4fa7T/0bDR
         rRYO/g3FH/CW3SSCLL02ygkkG+emNa042FQWeTfd8HtEjA4f+TcGcaXT7KHTAkjwZvm6
         c6/DmaabaDv1x89Y1nkz41qw9Wn23w1PsKfw+iTgnA1blKulYJpfVfzGRY9amEMXim7I
         elBPAJwkuuD4iZGhTgarbozbnwKim0J5+FnRWsu9B1uCf0gEvxFEp7v2XktYdzGPtCmF
         19I+7J7WRCxQnTwrHjQrZXbxagwGC+sU946Lc/l90avoLO2F69l+9dZ5JMKXEOm0o0Wo
         0HzQ==
X-Gm-Message-State: AOJu0Yw3047S5s7xKCGt9J/u801PSDwYlrqM/oDmSj7RFblx/64cu5BF
        QfhD32IOqX+LJ1Qt3RkJdxbyiQ==
X-Google-Smtp-Source: AGHT+IHyLaj7lSH6UWei+LJ0Jvr8+Gydj89mLdky8jn0+n2TFP3T21x4hd6OTXGGBdOQVsHAwnNEsw==
X-Received: by 2002:a2e:9914:0:b0:2b9:bbf5:7c6 with SMTP id v20-20020a2e9914000000b002b9bbf507c6mr1623479lji.43.1692356596092;
        Fri, 18 Aug 2023 04:03:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y7-20020a2e9d47000000b002b9899d0f0bsm363898ljj.83.2023.08.18.04.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 04:03:15 -0700 (PDT)
Message-ID: <c4b7e9eb-fb5d-4b2f-8358-f41598d7d983@linaro.org>
Date:   Fri, 18 Aug 2023 14:03:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 02/10] drm: Introduce solid fill DRM plane property
Content-Language: en-GB
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Sebastian Wick <sebastian.wick@redhat.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        quic_abhinavk@quicinc.com, contact@emersion.fr,
        laurent.pinchart@ideasonboard.com, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
References: <20230728-solid-fill-v5-0-053dbefa909c@quicinc.com>
 <20230728-solid-fill-v5-2-053dbefa909c@quicinc.com>
 <CAA8EJpq=pbDoYc9wqKKrX+RahXp8zWTPFqVqA=S-0TkWXXJUjQ@mail.gmail.com>
 <CA+hFU4y38MTTUsbri1jy=n4Vyp7xx2CosD9Nmk97z_au6NHCdQ@mail.gmail.com>
 <CAA8EJpoFpUcQL_7pb0toDoLFsK=9GdBLQH+h_MMffrp9k7eCyw@mail.gmail.com>
 <20230818135133.3fdeddba@eldfell>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230818135133.3fdeddba@eldfell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 13:51, Pekka Paalanen wrote:
> On Fri, 4 Aug 2023 16:59:00 +0300
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> 
>> On Fri, 4 Aug 2023 at 16:44, Sebastian Wick <sebastian.wick@redhat.com> wrote:
>>>
>>> On Fri, Aug 4, 2023 at 3:27 PM Dmitry Baryshkov
>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>
>>>> On Fri, 28 Jul 2023 at 20:03, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>>>>>
>>>>> Document and add support for solid_fill property to drm_plane. In
>>>>> addition, add support for setting and getting the values for solid_fill.
>>>>>
>>>>> To enable solid fill planes, userspace must assign a property blob to
>>>>> the "solid_fill" plane property containing the following information:
>>>>>
>>>>> struct drm_mode_solid_fill {
>>>>>          u32 version;
>>>>>          u32 r, g, b;
>>>>> };
>>>>>
>>>>> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>>>>> ---
>>>>>   drivers/gpu/drm/drm_atomic_state_helper.c |  9 +++++
>>>>>   drivers/gpu/drm/drm_atomic_uapi.c         | 55 +++++++++++++++++++++++++++++++
>>>>>   drivers/gpu/drm/drm_blend.c               | 30 +++++++++++++++++
>>>>>   include/drm/drm_blend.h                   |  1 +
>>>>>   include/drm/drm_plane.h                   | 35 ++++++++++++++++++++
>>>>>   include/uapi/drm/drm_mode.h               | 24 ++++++++++++++
>>>>>   6 files changed, 154 insertions(+)
>>>>>   
>>>>
>>>> [skipped most of the patch]
>>>>   
>>>>> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
>>>>> index 43691058d28f..53c8efa5ad7f 100644
>>>>> --- a/include/uapi/drm/drm_mode.h
>>>>> +++ b/include/uapi/drm/drm_mode.h
>>>>> @@ -259,6 +259,30 @@ struct drm_mode_modeinfo {
>>>>>          char name[DRM_DISPLAY_MODE_LEN];
>>>>>   };
>>>>>
>>>>> +/**
>>>>> + * struct drm_mode_solid_fill - User info for solid fill planes
>>>>> + *
>>>>> + * This is the userspace API solid fill information structure.
>>>>> + *
>>>>> + * Userspace can enable solid fill planes by assigning the plane "solid_fill"
>>>>> + * property to a blob containing a single drm_mode_solid_fill struct populated with an RGB323232
>>>>> + * color and setting the pixel source to "SOLID_FILL".
>>>>> + *
>>>>> + * For information on the plane property, see drm_plane_create_solid_fill_property()
>>>>> + *
>>>>> + * @version: Version of the blob. Currently, there is only support for version == 1
>>>>> + * @r: Red color value of single pixel
>>>>> + * @g: Green color value of single pixel
>>>>> + * @b: Blue color value of single pixel
>>>>> + */
>>>>> +struct drm_mode_solid_fill {
>>>>> +       __u32 version;
>>>>> +       __u32 r;
>>>>> +       __u32 g;
>>>>> +       __u32 b;
>>>>
>>>> Another thought about the drm_mode_solid_fill uABI. I still think we
>>>> should add alpha here. The reason is the following:
>>>>
>>>> It is true that we have  drm_plane_state::alpha and the plane's
>>>> "alpha" property. However it is documented as "the plane-wide opacity
>>>> [...] It can be combined with pixel alpha. The pixel values in the
>>>> framebuffers are expected to not be pre-multiplied by the global alpha
>>>> associated to the plane.".
>>>>
>>>> I can imagine a use case, when a user might want to enable plane-wide
>>>> opacity, set "pixel blend mode" to "Coverage" and then switch between
>>>> partially opaque framebuffer and partially opaque solid-fill without
>>>> touching the plane's alpha value.
>>>
>>> The only reason I see against this is that there might be some
>>> hardware which supports only RGB but not alpha on planes and they
>>> could then not use this property.
>>
>> Fair enough.
>>
>>> Maybe another COLOR_FILL enum value
>>> with alpha might be better? Maybe just doing the alpha via the alpha
>>> property is good enough.
>>
>> One of our customers has a use case for setting the opaque solid fill,
>> while keeping the plane's alpha intact.
> 
> Could you explain more about why they must keep plane alpha intact
> instead of reprogramming everything with atomic? Is there some
> combination that just cannot reach the same end result via userspace
> manipulation of the solid fill values with plane alpha?
> 
> Or is it a matter of userspace architecture where you have independent
> components responsible for different KMS property values?
The latter one. The goal is to be able to switch between pixel sources 
without touching any additional properties (including plane's alpha value).

-- 
With best wishes
Dmitry

