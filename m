Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4F7F607D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345528AbjKWNkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345510AbjKWNj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:39:58 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EBC1A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:40:03 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-407da05f05aso5819775e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700746802; x=1701351602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3TPUaHvZ6rw/hVh2543ObAlnWCVHD/ml9MkJlTvJwY=;
        b=QoZaBBUWzABKEXmKw1H3WzdkWiKBmAM63AUU8+zvPbjNJcFIHDdMJoPN5JdCSaa+nr
         i0+gFWu9C0n+h0wys5XnbKvB3R+bClJrLwFzJ4NLM7AWD56LMSRqj+4drL19jsUuB+42
         xZc6s3KaMYVVc7dmG7dQ8jchLQGuy3oC6J7BEDz1qh6OmoMmDcPgIqRzYwWP1XZPKhO7
         xug4AXTJrwQhFnivyVY2SZfj2LUN4cO7TPJDQdf5uT3yM6ZaApkQvlzSUcIY41RgpCTJ
         a+qCnn2G7Zqdb+9l68nhtIP7juBjg6otH5kJFDUX3sUQH4POWiBy7V4cwfZE9CvOxVWe
         LAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746802; x=1701351602;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J3TPUaHvZ6rw/hVh2543ObAlnWCVHD/ml9MkJlTvJwY=;
        b=CB0Q6ZDc+jiPq+b5Jhs2Ar2R+0FGZZvFOvxoHMFjvb47OkeTWfWimD8MpgDOJgS/6U
         aB6AvxO5rdcm5F6jMV9bfR75H7GdTfqeSGR+jiw5KeSJqpwMkqUE2LdaQxk71RqkP1fz
         txAjmRHDtH2DSrTNrep99zJXuVYh7xpUK5s0fAP1ZHOH2zFe1nCFHY8OlO4N50JJUomT
         xz0REnhy6Pq+H5PTOiN+q8UACOCn0T2s76yvNRYxOHgENXs2s5LrD7XWmMfcOJC2/gHA
         mKke4LDMTJAQg6xXzoL+ubDEOsykon3aUSnjN/sF6H9u2d/j94Ue9UM2sap3sK1cceQs
         JfXg==
X-Gm-Message-State: AOJu0Yw86RDYn8bW6qeHEUKuSzg6WHP04yGibFXBorDgJuKb2WdCu0WK
        TldNZMZBg7m1BSKqbbLPbmMnXw==
X-Google-Smtp-Source: AGHT+IEtpD7tPtTabhaiSeHfEY+xR8fiJQ5KN7fy/TFv3GL9r/hftulj44JOf2YzigBM5nkioHoqCg==
X-Received: by 2002:a05:600c:35cf:b0:3f6:9634:c8d6 with SMTP id r15-20020a05600c35cf00b003f69634c8d6mr4278069wmq.18.1700746801550;
        Thu, 23 Nov 2023 05:40:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:89c5:1f48:b86f:30ba? ([2a01:e0a:982:cbb0:89c5:1f48:b86f:30ba])
        by smtp.gmail.com with ESMTPSA id x22-20020a05600c189600b0040a4cc876e0sm1996390wmp.40.2023.11.23.05.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 05:40:01 -0800 (PST)
Message-ID: <22676a5b-cc2b-4cb9-b921-d1fb6c13a626@linaro.org>
Date:   Thu, 23 Nov 2023 14:39:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 8/8] drm/bridge: it66121: Allow link this driver as a lib
Content-Language: en-US, fr
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Phong LE <ple@baylibre.com>, Maxime Ripard <mripard@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev>
 <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <79301d04-c0cb-4740-8a6d-27a889b65daf@linux.dev>
 <CAA8EJpom5kAbDkacOdqp6BR7YPfmCSXaQfDYRVcLf9eGmi64CQ@mail.gmail.com>
 <121163c9-0d56-47ad-a12e-e67390fef2b4@linux.dev>
 <CAA8EJpowjhX=LL-9cnQL4pfCei63zNkCGW5wGOeeFxcnFpNCVA@mail.gmail.com>
 <00ba2245-0e48-4b21-bcd4-29dfb728e408@linux.dev>
 <CAA8EJpoiehS2wS3ri_DggzxeEfLY4yK7X6c+bCFKvkwSce6r+A@mail.gmail.com>
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
In-Reply-To: <CAA8EJpoiehS2wS3ri_DggzxeEfLY4yK7X6c+bCFKvkwSce6r+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 09:08, Dmitry Baryshkov wrote:
> On Thu, 23 Nov 2023 at 07:05, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>>
>> Hi,
>>
>>
>> On 2023/11/16 19:19, Dmitry Baryshkov wrote:
>>> On Thu, 16 Nov 2023 at 12:13, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>>>> Hi,
>>>>
>>>>
>>>> On 2023/11/16 17:30, Dmitry Baryshkov wrote:
>>>>> On Thu, 16 Nov 2023 at 11:14, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Thanks a lot for reviewing!
>>>>>>
>>>>>>
>>>>>> On 2023/11/15 00:30, Dmitry Baryshkov wrote:
>>>>>>> On Tue, 14 Nov 2023 at 17:09, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>>>>>>>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>>>>>>>
>>>>>>>> The it66121_create_bridge() and it66121_destroy_bridge() are added to
>>>>>>>> export the core functionalities. Create a connector manually by using
>>>>>>>> bridge connector helpers when link as a lib.
>>>>>>>>
>>>>>>>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/bridge/ite-it66121.c | 134 +++++++++++++++++++--------
>>>>>>>>      include/drm/bridge/ite-it66121.h     |  17 ++++
>>>>>>>>      2 files changed, 113 insertions(+), 38 deletions(-)
>>>>>>>>      create mode 100644 include/drm/bridge/ite-it66121.h
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
>>>>>>>> index 8971414a2a60..f5968b679c5d 100644
>>>>>>>> --- a/drivers/gpu/drm/bridge/ite-it66121.c
>>>>>>>> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
>>>>>>>> @@ -22,6 +22,7 @@
>>>>>>>>
>>>>>>>>      #include <drm/drm_atomic_helper.h>
>>>>>>>>      #include <drm/drm_bridge.h>
>>>>>>>> +#include <drm/drm_bridge_connector.h>
>>>>>>>>      #include <drm/drm_edid.h>
>>>>>>>>      #include <drm/drm_modes.h>
>>>>>>>>      #include <drm/drm_print.h>
>>>>>>>> @@ -703,14 +704,32 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
>>>>>>>>                                      enum drm_bridge_attach_flags flags)
>>>>>>>>      {
>>>>>>>>             struct it66121_ctx *ctx = bridge_to_it66121(bridge);
>>>>>>>> +       struct drm_bridge *next_bridge = ctx->next_bridge;
>>>>>>>> +       struct drm_encoder *encoder = bridge->encoder;
>>>>>>>>             int ret;
>>>>>>>>
>>>>>>>> -       if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
>>>>>>>> -               return -EINVAL;
>>>>>>>> +       if (next_bridge) {
>>>>>>>> +               if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
>>>>>>>> +                       WARN_ON(1);
>>>>>>> Why? At least use WARN() instead
>>>>>> Originally I want to
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>>> +                       flags |= DRM_BRIDGE_ATTACH_NO_CONNECTOR;
>>>>>>>> +               }
>>>>>>>> +               ret = drm_bridge_attach(encoder, next_bridge, bridge, flags);
>>>>>>>> +               if (ret)
>>>>>>>> +                       return ret;
>>>>>>>> +       } else {
>>>>>>>> +               struct drm_connector *connector;
>>>>>>>>
>>>>>>>> -       ret = drm_bridge_attach(bridge->encoder, ctx->next_bridge, bridge, flags);
>>>>>>>> -       if (ret)
>>>>>>>> -               return ret;
>>>>>>>> +               if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>>>>>>>> +                       WARN_ON(1);
>>>>>>> No. It is perfectly fine to create attach a bridge with no next_bridge
>>>>>>> and with the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
>>>>>>>
>>>>>> The document say when DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is set
>>>>>> the bridge shall not create a drm_connector. So I think if a display
>>>>>> bridge driver don't have a next bridge attached (Currently, this is
>>>>>> told by the DT), it says that this is a non-DT environment. On such
>>>>>> a case, this display bridge driver(it66121.ko) should behavior like
>>>>>> a *agent*. Because the upstream port of it66121 is the DVO port of
>>>>>> the display controller, the downstream port of it66121 is the HDMI
>>>>>> connector. it66121 is on the middle. So I think the it66121.ko should
>>>>>> handle all of troubles on behalf of the display controller drivers.
>>>>> No. Don't make decisions for the other drivers. They might have different needs.
>>>> [...]
>>>>
>>>>
>>>>>> Therefore (when in non-DT use case), the display controller drivers
>>>>>> side should not set DRM_BRIDGE_ATTACH_NO_CONNECTOR flag anymore.
>>>>>> Which is to hint that the it66121 should totally in charge of those
>>>>>> tasks (either by using bridge connector helper or create a connector
>>>>>> manually). I don't understand on such a case, why bother display
>>>>>> controller drivers anymore.
>>>>> This is the reason why we had introduced this flag. It allows the
>>>>> driver to customise the connector. It even allows the driver to
>>>>> implement a connector on its own, completely ignoring the
>>>>> drm_bridge_connector.
>>>>
>>>> I know what you said is right in the sense of the universe cases,
>>>> but I think the most frequent(majority) use case is that there is
>>>> only one display bridge on the middle. Therefore, I don't want to
>>>> movethe connector things into device driver if there is only one display
>>>> bridge(say it66121) in the middle. After all, there is no *direct
>>>> physical connection* from the perspective of the hardware. I means that
>>>> there is no hardware wires connectthe HDMI connector and the DVO port. So display controller drivers
>>>> should not interact with anything related with the connector on a
>>>> perfect abstract on the software side. Especially for such a simple use
>>>> case. It probably make senses to make a  decision for themost frequently use case, please also note
>>>> that this patch didn't introduce any-restriction for the more advance
>>>> uses cases(multiple bridges in the middle).
>>> So, for the sake of not having the connector in the display driver,
>>> you want to add boilerplate code basically to each and every bridge
>>> driver. In the end, they should all behave in the same way.
>>>
>>> Moreover, there is no way this implementation can work without a
>>> warning if there are two bridges in a chain and the it66121 is the
>>> second (the last) one. The host can not specify the
>>> DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>>>>>>>> +                       WARN_ON(1);
>>>>>>> No. It is perfectly fine to create attach a bridge with no next_bridge
>>>>>>> and with the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
>>>>>>>
>>>>>> The document say when DRM_BRIDGE_ATTACH_NO_CONNECTOR flag is set
>>>>>> the bridge shall not create a drm_connector. So I think if a display
>>>>>> bridge driver don't have a next bridge attached (Currently, this is
>>>>>> told by the DT), it says that this is a non-DT environment. On such
>>>>>> a case, this display bridge driver(it66121.ko) should behavior like
>>>>>> a *agent*. Because the upstream port of it66121 is the DVO port of
>>>>>> the display controller, the downstream port of it66121 is the HDMI
>>>>>> connector. it66121 is on the middle. So I think the it66121.ko should
>>>>>> handle all of troubles on behalf of the display controller drivers.
>>>>> No. Don't make decisions for the other drivers. They might have different needs.
>>>> [...]
>>>>
>>>>
>>>>>> Therefore (when in non-DT use case), the display controller drivers
>>>>>> side should not set DRM_BRIDGE_ATTACH_NO_CONNECTOR flag anymore.
>>>>>> Which is to hint that the it66121 should totally in charge of those
>>>>>> tasks (either by using bridge connector helper or create a connector
>>>>>> manually). I don't understand on such a case, why bother display
>>>>>> controller drivers anymore.
>>>>> This is the reason why we had introduced this flag. It allows the
>>>>> driver to customise the connector. It even allows the driver to
>>>>> implement a connector on its own, completely ignoring the
>>>>> drm_bridge_connector.
>>>>
>>>> I know what you said is right in the sense of the universe cases,
>>>> but I think the most frequent(majority) use case is that there is
>>>> only one display bridge on the middle. Therefore, I don't want to
>>>> movethe connector things into device driver if there is only one display
>>>> bridge(say it66121) in the middle. After all, there is no *direct
>>>> physical connection* from the perspective of the hardware. I means that
>>>> there is no hardware wires connectthe HDMI connector and the DVO port. So display controller drivers
>>>> should not interact with anything related with the connector on a
>>>> perfect abstract on the software side. Especially for such a simple use
>>>> case. It probably make senses to make a  decision for themost frequently use case, please also note
>>>> that this patch didn't introduce any-restriction for the more advance
>>>> uses cases(multiple bridges in the middle).
>>> So, for the sake of not having the connector in the display driver,
>>> you want to add boilerplate code basically to each and every bridge
>>> driver. In the end, they should all behave in the same way.
>>
>> No, I'm only intend to modify the one when there has a user emerged.
>> If we have the connector related code in the KMS display driver side,
>> then I think we don't honor the meaning of the word *bridge*. I was
>> told drm_bridge is a modern design, if we still need the DC side
>> worry about something do not have a physical connection, then it will
>> not be modern anymore, it is not a good bridge.
> 
> Next time the user emerges for another bridge. And then for another.
> This way the very similar code is copy-pasted over all bridge drivers.
> So instead it was decided to keep it in the display driver code.
> 
>>
>>
>>> Moreover, there is no way this implementation can work without a
>>> warning if there are two bridges in a chain and the it66121 is the
>>> second (the last) one.
>>
>> Yes and no!
>>
>> If one of them are transparent, then thisimplementation still can works. It is just that this will not be a good
>> abstract anymore.I do have seen such design on some notebook hardware.  But from my programming experiences,
>> using two bridges are typically a bad practice in engineering. As it tend
>> to increase the PCB board area and increase entire cost. As you need buy
>> one more TX encoder chip. Please also consider that the embedded world focus
>> on low cost and low power consume.
> 
> A typical pipeline for an embedded device can perfectly look like:
> - DSI host (drm_encoder)
> - DSI-HDMI or DSI-eDP bridge (drm_bridge)
> - hdmi-connector or panel-bridge (drm_bridge)
> - drm_bridge_connector.
> 
> Two drm_bridge instances.

Nowadays, we are moving the encoder code into bridge so we can have way
more than 2 bridges, and connector code has been moved to a bridge.

On Amlogic SoCs, the HDMI chain has at least 3 bridges, it can have up to 4
on DSI usecase if you plug a DSI to eDP bridge.

On iMX8 platform, they have multiple internal SoC bridges even before the HDMI or DSI bridge.

The model works very well across extremely heterogeneous embedded platforms.

> 
>>
>> I think, multiple display bridges case should be avoided for middle/low end
>> application. Or allow us to handle the two and/or more bridges cases in the
>> future. When there has at least one user emerged, we will introduce new
>> approach to handle then.
>>
>> Do you find any product level boards that using two external display bridge and
>> one of them is it66121? If we can not even find a user, we are not even have a
>> board to test if current design (state of art) works. Does it suffer from module
>> loading order problems? what if their i2c slave address is same? Does such a use
>> case will past the S3/S4 test? All of those concerns are imposed to every display
>> bridges programmer from the very beginning.
> 
> Please add a hdmi-connector device to your testing model. You don't
> have to use it, but it is a fully legit use case. And suddenly you
> have to drm_bridge instances in your chain.
> 
>>
>> I'm agree with the idea that drm bridges drivers involved toward to a direction
>> that support more complex design, but I think we should also leave a way for the
>> most frequent use case. Make it straight-forward as a canonical design.
> 
> Not having anything connector-related in the drm_bridge driver is a
> canonical design.
> 
>>
>>> The host can not specify the
>>> DRM_BRIDGE_ATTACH_NO_CONNECTOR flag, it will cause a warning here. And
>>> it can not omit the flag (as otherwise the first bridge will create a
>>> connector, without consulting the second bridge).
>>
>> The semantics of DRM_BRIDGE_ATTACH_NO_CONNECTOR flagare implement-defined,
> 
> No, they are not. Semantics are pretty simple: do not create the
> drm_connector instance. Pass the flag to the next bridge in the chain.
> 
>> for our case, I could just ignore it if their
>> don't have a signal(DT or ACPI) tell me that there are multiple bridges
>> in the chain. This depend on community's attitude.
> 
> Ignoring a flag is a bad idea.
> 
>>
>> For it66121 with a canonical design, the host should not need to specify this flag.
>> Because at the time of when the device driver(it66121.ko) get loaded, the it66121
>> driver could parse the DT by itself, and detect if there has a next bridge, is it a
>> connector or is it yet another display bridges. The DT speak everything about the
>> topology. The flag is there just for the KMS display controller driver to explicit
>> control, use it and make it more useful is the right way, is it?
> 
> No. We have been there (before the DRM_BRIDGE_ATTACH_NO_CONNECTOR was
> introduced), we have gone away from it.
> 
>>
>>
>>>>
>>>>>>>> +
>>>>>>>> +               connector = drm_bridge_connector_init(bridge->dev, encoder);
>>>>>>>> +               if (IS_ERR(connector))
>>>>>>>> +                       return PTR_ERR(connector);
>>>>>>>> +
>>>>>>>> +               drm_connector_attach_encoder(connector, encoder);
>>>>>>> This goes into your device driver.
>>>>>>>
>>>>>>>> +
>>>>>>>> +               ctx->connector = connector;
>>>>>>>> +       }
>>>>>>>>
>>>>>>>>             if (ctx->info->id == ID_IT66121) {
>>>>>>>>                     ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
>>>>>>>> @@ -1632,16 +1651,13 @@ static const char * const it66121_supplies[] = {
>>>>>>>>             "vcn33", "vcn18", "vrf12"
>>>>>>>>      };
>>>>>
>>>
>>>
> 
> 
> 

