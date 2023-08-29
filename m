Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E97078C12E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjH2JWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjH2JW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:22:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27A51AC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:22:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so1253408f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693300941; x=1693905741;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZIEiCn3lSJ8inobas2my07Sq1lCtP+DSVCnXge1ovM=;
        b=fbeQMq9WyI2hWI8meFh2UymfKYTUUlYbD+/bSsYQpIslgQxDhv1DnQOdwdMsxcJ0u0
         iktMjJd2RxoCKhuFUmoz569CNSAx6PQFDugPai3abId9wWCzD6zrhD6w/QvzMqQKLAOG
         z2mA3dBDHv8UDmoV97/yxXNVLm2V/5zYerkbb9a96nsU93mwHeIsYm0GO84IbwdWI4lm
         Fakw9lrKP/gpw8k77lfBvkdE3+DgAWtLGkd4Qg6kSYe7k+3b7yY63H/6mSvDnt7/GERN
         ExbVzWcu33j2UpIOXOwKBdFNHz+P1h/VkzCJAPN0SIlVou6vNtA8d2/HuiR0gCwJ69Me
         CohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693300941; x=1693905741;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PZIEiCn3lSJ8inobas2my07Sq1lCtP+DSVCnXge1ovM=;
        b=XSwYLy+6svTvRqctPqLBGMMnFkwyIYFLdK4cAIdf5pF1aWMUCD1iVhxytz6s7T6Z8K
         x0al9NblaNv7TAZ43wC+dNNXqiEIZqLjEN/PftaLQGx7qC1QmJzR5uznTFy/jmrQVInh
         dPL1jtUIlHAgXqmF2EmYkIuKNRG3y7r1OO8QT2URLLBFjoSYRM1pkM3IM48AatKJFhmh
         iXgKHgDuPE7+3/oxqH6jbl0ZCa0fZS4RrruRaEiyI73BTQxbmhv2aHV8wnKXwLwa6ERh
         WgOIdXQWjxQAGoVBPY2NgO9LNb1jeGuU+1cIIICg6ZSSjt+zSqA8SVH87OT0//hwKoBI
         iNQw==
X-Gm-Message-State: AOJu0Yw3E9DtOoN4dA7l1KXh0ctVBSGeOP3pHZ5afCu1QM4TOgYSslUE
        juz7UgNLNouVEXC+yzpR+oqDJA==
X-Google-Smtp-Source: AGHT+IFQcFXLdabYVQMQ0bIQheST1IKdyNPDKRvsh+0tf8Yn+QS6F8NEhHG28+Exuh19yG7zhEsGMg==
X-Received: by 2002:adf:efc9:0:b0:313:f235:cd17 with SMTP id i9-20020adfefc9000000b00313f235cd17mr20707340wrp.40.1693300941194;
        Tue, 29 Aug 2023 02:22:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c8fd:3f8e:51f:e4f9? ([2a01:e0a:982:cbb0:c8fd:3f8e:51f:e4f9])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4c48000000b003140f47224csm13099775wrt.15.2023.08.29.02.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 02:22:20 -0700 (PDT)
Message-ID: <56c11316-57ce-45d5-927c-84f65a1c227e@linaro.org>
Date:   Tue, 29 Aug 2023 11:22:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: Add prepare_prev_first flag to Visionox
 VTDR6130
Content-Language: en-US, fr
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <76e76728-974e-46ff-8046-c61c54d07c76@linaro.org>
 <54b37d60-61b1-e939-c71d-30aecad65598@quicinc.com>
 <0cb96702-b396-4223-870f-b798d32991ee@linaro.org>
 <7571be78-5560-13bf-d754-cabc8ad6140d@quicinc.com>
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
In-Reply-To: <7571be78-5560-13bf-d754-cabc8ad6140d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 19:07, Abhinav Kumar wrote:
> Hi Neil
> 
> Sorry I didnt respond earlier on this thread.
> 
> On 8/28/2023 1:49 AM, neil.armstrong@linaro.org wrote:
>> Hi Jessica,
>>
>> On 25/08/2023 20:37, Jessica Zhang wrote:
>>>
>>>
>>> On 8/21/2023 3:01 AM, neil.armstrong@linaro.org wrote:
>>>> Hi Maxime,
>>>>
>>>> On 21/08/2023 10:17, Maxime Ripard wrote:
>>>>> Hi,
>>>>>
>>>>> On Fri, Aug 18, 2023 at 10:25:48AM +0200, neil.armstrong@linaro.org wrote:
>>>>>> On 17/08/2023 20:35, Dmitry Baryshkov wrote:
>>>>>>> On 16/08/2023 10:51, neil.armstrong@linaro.org wrote:
>>>>>>>> Sending HS commands will always work on any controller, it's all
>>>>>>>> about LP commands. The Samsung panels you listed only send HS
>>>>>>>> commands so they can use prepare_prev_first and work on any
>>>>>>>> controllers.
>>>>>>>
>>>>>>> I think there is some misunderstanding there, supported by the
>>>>>>> description of the flag.
>>>>>>>
>>>>>>> If I remember correctly, some hosts (sunxi) can not send DCS
>>>>>>> commands after enabling video stream and switching to HS mode, see
>>>>>>> [1]. Thus, as you know, most of the drivers have all DSI panel setup
>>>>>>> commands in drm_panel_funcs::prepare() /
>>>>>>> drm_bridge_funcs::pre_enable() callbacks, not paying attention
>>>>>>> whether these commands are to be sent in LP or in HS mode.
>>>>>>>
>>>>>>> Previously DSI source drivers could power on the DSI link either in
>>>>>>> mode_set() or in pre_enable() callbacks, with mode_set() being the
>>>>>>> hack to make panel/bridge drivers to be able to send commands from
>>>>>>> their prepare() / pre_enable() callbacks.
>>>>>>>
>>>>>>> With the prev_first flags being introduced, we have established that
>>>>>>> DSI link should be enabled in DSI host's pre_enable() callback and
>>>>>>> switched to HS mode (be it command or video) in the enable()
>>>>>>> callback.
>>>>>>>
>>>>>>> So far so good.
>>>>>>
>>>>>> It seems coherent, I would like first to have a state of all DSI host
>>>>>> drivers and make this would actually work first before adding the
>>>>>> prev_first flag to all the required panels.
>>>>>
>>>>> This is definitely what we should do in an ideal world, but at least for
>>>>> sunxi there's no easy way for it at the moment. There's no documentation
>>>>> for it and the driver provided doesn't allow this to happen.
>>>>>
>>>>> Note that I'm not trying to discourage you or something here, I'm simply
>>>>> pointing out that this will be something that we will have to take into
>>>>> account. And it's possible that other drivers are in a similar
>>>>> situation.
>>>>>
>>>>>>> Unfortunately this change is not fully backwards-compatible. This
>>>>>>> requires that all DSI panels sending commands from prepare() should
>>>>>>> have the prepare_prev_first flag. In some sense, all such patches
>>>>>>> might have Fixes: 5ea6b1702781 ("drm/panel: Add prepare_prev_first
>>>>>>> flag to drm_panel").
>>>>>>
>>>>>> This kind of migration should be done *before* any possible
>>>>>> regression, not the other way round.
>>>>>>
>>>>>> If all panels sending commands from prepare() should have the
>>>>>> prepare_prev_first flag, then it should be first, check for
>>>>>> regressions then continue.
>>>>>>
>>>>>> <snip>
>>>>>>
>>>>>>>>
>>>>>>>> I understand, but this patch doesn't qualify as a fix for
>>>>>>>> 9e15123eca79 and is too late to be merged in drm-misc-next for
>>>>>>>> v6.6, and since 9e15123eca79 actually breaks some support it
>>>>>>>> should be reverted (+ deps) since we are late in the rc cycles.
>>>>>>>
>>>>>>> If we go this way, we can never reapply these patches. There will be
>>>>>>> no guarantee that all panel drivers are completely converted. We
>>>>>>> already have a story without an observable end -
>>>>>>> DRM_BRIDGE_ATTACH_NO_CONNECTOR.
>>>>>>
>>>>>> I don't understand this point, who would block re-applying the patches ?
>>>>>>
>>>>>> The migration to DRM_BRIDGE_ATTACH_NO_CONNECTOR was done over multiple
>>>>>> Linux version and went smoothly because we reverted regressing patches
>>>>>> and restarted when needed, I don't understand why we can't do this
>>>>>> here aswell.
>>>>>>
>>>>>>> I'd consider that the DSI driver is correct here and it is about the
>>>>>>> panel drivers that require fixes patches. If you care about the
>>>>>>> particular Fixes tag, I have provided one several lines above.
>>>>>>
>>>>>> Unfortunately it should be done in the other way round, prepare for
>>>>>> migration, then migrate,
>>>>>>
>>>>>> I mean if it's a required migration, then it should be done and I'll
>>>>>> support it from both bridge and panel PoV.
>>>>>>
>>>>>> So, first this patch has the wrong Fixes tag, and I would like a
>>>>>> better explanation on the commit message in any case. Then I would
>>>>>> like to have an ack from some drm-misc maintainers before applying it
>>>>>> because it fixes a patch that was sent via the msm tree thus per the
>>>>>> drm-misc rules I cannot apply it via the drm-misc-next-fixes tree.
>>>>>
>>>>> Sorry, it's not clear to me what you'd like our feedback on exactly?
>>>>
>>>> So let me resume the situation:
>>>>
>>>> - pre_enable_prev_first was introduced in [1]
>>>> - some panels made use of pre_enable_prev_first
>>>> - Visionox VTDR6130 was enabled on SM8550 systems and works on v6.5 kernels and before
>>>> - patch [2] was introduced on MSM DRM tree, breaking VTDR6130 on SM8550 systems (and probably other Video mode panels on Qcom platforms)
>>>> - this fix was sent late, and is now too late to be merged via drm-misc-next
>>>
>>> Hi Neil and Maxime,
>>>
>>> I agree with Neil that 9e15123eca79 was the commit that introduced the issue (since it changed the MSM DSI host behavior).
>>>
>>> However, I'm not too keen on simply reverting that patch because
>>>
>>> 1) it's not wrong to have the dsi_power_on in pre_enable. Arguably, it actually makes more sense to power on DSI host in pre_enable than in modeset (since modeset is meant for setting the bridge mode), and
>>
>> I never objected that, it's the right path to go.
>>
> 
> Ack.
> 
>>>
>>> 2) I think it would be good practice to keep specific bridge chip checks out of the DSI host driver.
>>
>> We discussed about a plan with Maxime and Dmitry about that, and it would require adding
>> a proper atomic panel API to handle a "negociation" with the host controller.
>>
> 
> May I know what type of negotiation is needed here?
> 
>>>
>>>
>>> That being said, what do you think about setting the default value of prepare_prev_first to true (possibly in panel_bridge_attach)?
>>
>> As Dmitry pointed, all panels sending LP commands in pre_enable() should have prepare_prev_first to true.
>>
> 
> I wanted to respond to this earlier but didnt get a chance.
> 
>  From the documentation of this flag, this has nothing to do whether panels are sending the LP commands (commands sent in LP mode) OR HS commands (commands sent in HS mode).
> 
> This is more about sending the commands whether the lanes are in LP11 state before sending the ON commands.
> 
> 195      * The previous controller should be prepared first, before the prepare
> 196      * for the panel is called. This is largely required for DSI panels
> 197      * where the DSI host controller should be initialised to LP-11 before
> 198      * the panel is powered up.
> 199      */
> 200     bool prepare_prev_first;
> 
> These are conceptually different and thats what I explained Dmitry in our call.
> 
> Sending ON commands in LP11 state is a requirement I have seen with many panels and its actually the right expectation as well to send the commands when the lanes are in a well-defined LP11 state.
> 
>  From the panels which I have seen, the opposite is never true (OR i have never seen it this way).
> 
> The parade chip was the only exception and that issue was never root-caused leading us to have bridge specific handling in MSM driver.
> 
> In other words, it would be very unlikely that a panel should be broken or shouldn't work when the ON commands are sent when the lanes are in LP11 state.
> 
> So I agree with Jessica, that we should set the default value of this flag to true in the framework so that only the bridges/panels which need this to be false do that explicitly. From the examples I pointed out including MTK, even those vendors are powering on their DSI in pre_enable() which means none of these panels will work there too.
> 
>>>
>>> It seems to me that most panel drivers send DCS commands during pre_enable, so maybe it would make more sense to power on DSI host before panel enable() by default. Any panel that needs DSI host to be powered on later could then explicitly set the flag to false in their respective drivers.
>>
>> A proper migration should be done, yes, but not as a fix on top of v6.5.
>>
> 
> I am fine to drop this fix in favor of making the prepare_prev_first as default true but we need an agreement first. From what I can see, parade chip will be the only one which will need this to be set to false and we can make that change.
> 
> Let me know if this works as a migration plan.

Yep agreed, let's do this

The panel's prepare_prev_first should be reversed to something like not_prepare_prev_first to make it an exception.

Neil


> 
>> Neil
>>
>>>
>>> Thanks,
>>>
>>> Jessica Zhang
>>>
>>>
>>>>
>>>> I do not consider it's the right way to fix regression caused by [2]
>>>> I consider [2] should be reverted, panels migrated to pre_enable_prev_first when needed, tested and the [2] applied again
>>>>
>>>> I have no objection about [2] and it should be done widely over the whole DSI controllers
>>>> and DSI Video panels.
>>>>
>>>> I also object about the Fixes tag of this patch, which is wrong, and Dmitry considers [1]
>>>> should be used but it's even more wrong since [2] really caused the regression.
>>>>
>>>> And if [2] was to correct one to use, it was pushed via the MSM tree so it couldn't be
>>>> applied via drm-misc-next-fixes, right ?
>>>>
>>>> [1] 4fb912e5e190 ("drm/bridge: Introduce pre_enable_prev_first to alter bridge init order")
>>>> [2] 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI hosts at modeset")
>>>>
>>>> Thanks,
>>>> Neil
>>>>
>>>>>
>>>>> Maxime
>>>>
>>

