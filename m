Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737607826B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbjHUKB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjHUKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:01:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC07D8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:01:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fef2f05356so4322505e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692612082; x=1693216882;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmpCqNuwBY73OVYPi/BmCG3N0jxacFrq7im2IRCj57Q=;
        b=buHtt9R6p1UT0kFR+SZvrhqJc1VC7erDPw8zlc8waNmuc2h+o5FQ4vm6/4TJD1Jlne
         up2315BphlsJtnFWQ3c3nNiI7YPBEOgoVfNGS9eq5kPjme4d1G+XgAHds8pswK84Pn9x
         YX+QUtEqlZtZaJcGWlNoraFi9e1xzeeagTgFx/x9M26fjwvTvaOwKgyBT9af6osdWlCd
         OKbmMt3NY170Dz3rICNYPnfTULb7nEsgyQpyoxPQfO+zO6jJXhaXARN5H7t4bac1bA/m
         rw+bYtK3fR10xoyfrqUcjw+H5sWae2sZYKQDI5RHVqGCPpwxUq4gVrh2bIkeKRHEejxx
         rz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692612082; x=1693216882;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RmpCqNuwBY73OVYPi/BmCG3N0jxacFrq7im2IRCj57Q=;
        b=GVXsRp29HlgcNNsIHyJyTRs7e3MgQXgcP7E8VWa0IrnrNcRnaHCIvqGhP++3sReU6r
         2+7EGNDnaZuhlwG5PMwGpPPC3ciApC2YuFhPhEkLsezSp8kdWwsa58IprObUMRKhcnwC
         IMgJKQ+hHrEdKGyc4bCXD70Wr2k6yMOhqU+7YnukPZlSKJzWoj9wcmMbfPuGXL1tohjp
         a6sb3e/HFLjrsck7JlzrHWF6gRhDhDl/vkR4oldRl/RptIzyYo1LR6+giBZEuUvaOuXr
         zdpeanKeofNQTGSLPIozWI23c/8bbmokr1nRPSDUt9XJ2ZQtIFS1l4rDC4jCD+oMMY5z
         aswg==
X-Gm-Message-State: AOJu0YxevJMaXJqZZtuFGDqDVJ1sRs/3OarmZdo2Qq3VP2pM9zjfflq1
        +AHab1TSYCyxLou1oZQf/5U0zg==
X-Google-Smtp-Source: AGHT+IFeFxim5iwfMKEO2kJ5I14LCZUo8h/2g2Y7SpUdqfbUVwVaEgpWd2VeAyqr3B0v8aNlQsd5wQ==
X-Received: by 2002:a05:600c:2291:b0:3fe:2a98:a24c with SMTP id 17-20020a05600c229100b003fe2a98a24cmr4887407wmf.26.1692612082568;
        Mon, 21 Aug 2023 03:01:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:8418:651e:836e:2521? ([2a01:e0a:cad:2140:8418:651e:836e:2521])
        by smtp.gmail.com with ESMTPSA id x1-20020a05600c2a4100b003fe1630a8f0sm15569169wme.24.2023.08.21.03.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 03:01:21 -0700 (PDT)
Message-ID: <76e76728-974e-46ff-8046-c61c54d07c76@linaro.org>
Date:   Mon, 21 Aug 2023 12:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: Add prepare_prev_first flag to Visionox
 VTDR6130
Content-Language: en-US, fr
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        quic_parellan@quicinc.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230725-visionox-vtdr-prev-first-v1-1-3bc44cec7dc6@quicinc.com>
 <dde2774e-6f0b-21d0-e9c9-4a5bd1eac4e8@linaro.org>
 <2f9a9450-438b-257d-759c-22b273a7b35d@quicinc.com>
 <c183d823-81d4-6d7c-98d9-649fa4041262@quicinc.com>
 <6c0dd9fd-5d8e-537c-804f-7a03d5899a07@linaro.org>
 <548b0333-103b-ac66-0fc5-f29e7cc50596@quicinc.com>
 <6e1f6cb7-7f88-48dc-b494-1a5e990e1a33@linaro.org>
 <ff1b04c3-c852-4e28-9054-3cebb4ca5d6e@linaro.org>
 <c7c5c8f0-16e6-47bd-94e8-ce924163dfd3@linaro.org>
 <giimknikofbipipawfmrcjiar5qfyw3t7sqy3iewjahsm3ktkt@qcn4g23zfcnj>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <giimknikofbipipawfmrcjiar5qfyw3t7sqy3iewjahsm3ktkt@qcn4g23zfcnj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 21/08/2023 10:17, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Aug 18, 2023 at 10:25:48AM +0200, neil.armstrong@linaro.org wrote:
>> On 17/08/2023 20:35, Dmitry Baryshkov wrote:
>>> On 16/08/2023 10:51, neil.armstrong@linaro.org wrote:
>>>> Sending HS commands will always work on any controller, it's all
>>>> about LP commands. The Samsung panels you listed only send HS
>>>> commands so they can use prepare_prev_first and work on any
>>>> controllers.
>>>
>>> I think there is some misunderstanding there, supported by the
>>> description of the flag.
>>>
>>> If I remember correctly, some hosts (sunxi) can not send DCS
>>> commands after enabling video stream and switching to HS mode, see
>>> [1]. Thus, as you know, most of the drivers have all DSI panel setup
>>> commands in drm_panel_funcs::prepare() /
>>> drm_bridge_funcs::pre_enable() callbacks, not paying attention
>>> whether these commands are to be sent in LP or in HS mode.
>>>
>>> Previously DSI source drivers could power on the DSI link either in
>>> mode_set() or in pre_enable() callbacks, with mode_set() being the
>>> hack to make panel/bridge drivers to be able to send commands from
>>> their prepare() / pre_enable() callbacks.
>>>
>>> With the prev_first flags being introduced, we have established that
>>> DSI link should be enabled in DSI host's pre_enable() callback and
>>> switched to HS mode (be it command or video) in the enable()
>>> callback.
>>>
>>> So far so good.
>>
>> It seems coherent, I would like first to have a state of all DSI host
>> drivers and make this would actually work first before adding the
>> prev_first flag to all the required panels.
> 
> This is definitely what we should do in an ideal world, but at least for
> sunxi there's no easy way for it at the moment. There's no documentation
> for it and the driver provided doesn't allow this to happen.
> 
> Note that I'm not trying to discourage you or something here, I'm simply
> pointing out that this will be something that we will have to take into
> account. And it's possible that other drivers are in a similar
> situation.
> 
>>> Unfortunately this change is not fully backwards-compatible. This
>>> requires that all DSI panels sending commands from prepare() should
>>> have the prepare_prev_first flag. In some sense, all such patches
>>> might have Fixes: 5ea6b1702781 ("drm/panel: Add prepare_prev_first
>>> flag to drm_panel").
>>
>> This kind of migration should be done *before* any possible
>> regression, not the other way round.
>>
>> If all panels sending commands from prepare() should have the
>> prepare_prev_first flag, then it should be first, check for
>> regressions then continue.
>>
>> <snip>
>>
>>>>
>>>> I understand, but this patch doesn't qualify as a fix for
>>>> 9e15123eca79 and is too late to be merged in drm-misc-next for
>>>> v6.6, and since 9e15123eca79 actually breaks some support it
>>>> should be reverted (+ deps) since we are late in the rc cycles.
>>>
>>> If we go this way, we can never reapply these patches. There will be
>>> no guarantee that all panel drivers are completely converted. We
>>> already have a story without an observable end -
>>> DRM_BRIDGE_ATTACH_NO_CONNECTOR.
>>
>> I don't understand this point, who would block re-applying the patches ?
>>
>> The migration to DRM_BRIDGE_ATTACH_NO_CONNECTOR was done over multiple
>> Linux version and went smoothly because we reverted regressing patches
>> and restarted when needed, I don't understand why we can't do this
>> here aswell.
>>
>>> I'd consider that the DSI driver is correct here and it is about the
>>> panel drivers that require fixes patches. If you care about the
>>> particular Fixes tag, I have provided one several lines above.
>>
>> Unfortunately it should be done in the other way round, prepare for
>> migration, then migrate,
>>
>> I mean if it's a required migration, then it should be done and I'll
>> support it from both bridge and panel PoV.
>>
>> So, first this patch has the wrong Fixes tag, and I would like a
>> better explanation on the commit message in any case. Then I would
>> like to have an ack from some drm-misc maintainers before applying it
>> because it fixes a patch that was sent via the msm tree thus per the
>> drm-misc rules I cannot apply it via the drm-misc-next-fixes tree.
> 
> Sorry, it's not clear to me what you'd like our feedback on exactly?

So let me resume the situation:

- pre_enable_prev_first was introduced in [1]
- some panels made use of pre_enable_prev_first
- Visionox VTDR6130 was enabled on SM8550 systems and works on v6.5 kernels and before
- patch [2] was introduced on MSM DRM tree, breaking VTDR6130 on SM8550 systems (and probably other Video mode panels on Qcom platforms)
- this fix was sent late, and is now too late to be merged via drm-misc-next

I do not consider it's the right way to fix regression caused by [2]
I consider [2] should be reverted, panels migrated to pre_enable_prev_first when needed, tested and the [2] applied again

I have no objection about [2] and it should be done widely over the whole DSI controllers
and DSI Video panels.

I also object about the Fixes tag of this patch, which is wrong, and Dmitry considers [1]
should be used but it's even more wrong since [2] really caused the regression.

And if [2] was to correct one to use, it was pushed via the MSM tree so it couldn't be
applied via drm-misc-next-fixes, right ?

[1] 4fb912e5e190 ("drm/bridge: Introduce pre_enable_prev_first to alter bridge init order")
[2] 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI hosts at modeset")

Thanks,
Neil

> 
> Maxime

