Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B57B76D72D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjHBSuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjHBSuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:50:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D303330C4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:50:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c10ba30afso275904766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691002184; x=1691606984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mp+0iys45R+COvRGoe9xq5NbJ5tCg5rlzk5Lyr+iieg=;
        b=INydIfxMSPrYH/0htfHExzXf4y45dWPGuVuckUOzCPVHLtMtexfSkab3QBaIrMW9dA
         g4AcdVRPLYfTtE3iK+UOJoiZIWFXSfAduRnPi7o2U9GAgoMLk1+WZBkcIQJSP1Hp2hgn
         cTPelSgDpcWmeXa39cGmYccd7LZ2CDZCUvYJb+yrjIMjSf8YR3SxlKfj+4UKhJMnQQzW
         lC4zsPPWMQRCQmQcntFGboF/aDK7qAC4GKuInT3f9zR5yNAfN8JOTN1xY85sAQZEI2e6
         0a2fKkuvVPVQYAQV0VKAAlEyuVk5Mbf6vRTsgSWTknJdWCY/6LoBMgp1XxW/54RyO/Zu
         D4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691002184; x=1691606984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mp+0iys45R+COvRGoe9xq5NbJ5tCg5rlzk5Lyr+iieg=;
        b=HbEqzAB65Bqy/i3T7s/5izgs4Z7n/SA9w2xW00vFxpskYBWQG5XXsb227aFY475MmC
         3GD4iwskN0q/zje6y4mM67xeXCp05AI+1yUQTwqId9/eLToOnMMngHTsodn+9gIhyXxU
         2ts+5UTMaDh0wh8MTftgrxOUFXch5+oRP460RL05d1JAbSC4dNnaQsTA6ChftMpGJCO9
         YSMtrGPxIfcC8Ybi/R4NJ/kkgnVaH/slaEGW6JygOGK/r4n1sK5ZeX+bZUk2oony4jSz
         WczwVoMNk50yNFfzGCds+5tWKCw0/n04LBgHmKTB919KZ/a2GWo0HRiXduXp5SdAjeQ8
         W6pg==
X-Gm-Message-State: ABy/qLaJ2cHztBOum7FnN0/1m3MP0Ai5VbDepMZlqGd8Q29GIFNriIpx
        1G0HvHcElaYUh3EA6Zc9O2iGCA==
X-Google-Smtp-Source: APBJJlFKw65pjz/lElTd1e/LmLeScXS0aZUMnJRHLFiyOxbnraQJYFwQWYOxBirmlDhLcmf76eueLA==
X-Received: by 2002:a17:907:3f1f:b0:98d:abd4:4000 with SMTP id hq31-20020a1709073f1f00b0098dabd44000mr6419594ejc.35.1691002183791;
        Wed, 02 Aug 2023 11:49:43 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id l12-20020a1709065a8c00b00992b2c5598csm9480948ejq.128.2023.08.02.11.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 11:49:43 -0700 (PDT)
Message-ID: <69900221-503a-693a-f52e-cfa5841230a6@linaro.org>
Date:   Wed, 2 Aug 2023 21:49:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA
 and EOT packet"
Content-Language: en-GB
To:     Marek Vasut <marex@denx.de>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>
References: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
 <5cf0e3fa-f66d-06c4-cfda-c48efd8c6508@linaro.org>
 <bf95af44-2510-1835-dec9-183144de8413@denx.de>
 <CAA8EJppp_ZJr-DcoZGd1GZmWuo=AECNS+X9zx0dNB4Edn8M2zg@mail.gmail.com>
 <c5597c50-d41c-9f7e-fb85-4e4a1bc29f15@denx.de>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <c5597c50-d41c-9f7e-fb85-4e4a1bc29f15@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 21:45, Marek Vasut wrote:
> On 8/2/23 20:16, Dmitry Baryshkov wrote:
>> On Wed, 2 Aug 2023 at 20:34, Marek Vasut <marex@denx.de> wrote:
>>>
>>> On 8/2/23 15:38, Dmitry Baryshkov wrote:
>>>> On 02/08/2023 11:52, Neil Armstrong wrote:
>>>>> This reverts commit [1] to fix display regression on the 
>>>>> Dragonboard 845c
>>>>> (SDM845) devboard.
>>>>>
>>>>> There's a mismatch on the real action of the following flags:
>>>>> - MIPI_DSI_MODE_VIDEO_NO_HSA
>>>>> - MIPI_DSI_MODE_VIDEO_NO_HFP
>>>>> - MIPI_DSI_MODE_VIDEO_NO_HBP
>>>>> which leads to a non-working display on qcom platforms.
>>>>>
>>>>> [1] 8ddce13ae696 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and
>>>>> EOT packet")
>>>>>
>>>>> Cc: Marek Vasut <marex@denx.de>
>>>>> Cc: Robert Foss <rfoss@kernel.org>
>>>>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>>>>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>> Fixes: 8ddce13ae69 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA
>>>>> and EOT packet")
>>>>> Reported-by: Amit Pundir <amit.pundir@linaro.org>
>>>>> Link:
>>>>> https://lore.kernel.org/r/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> ---
>>>>>    drivers/gpu/drm/bridge/lontium-lt9611.c | 4 +---
>>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>>>
>>>> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #fix db845c
>>>>
>>>> The boards broken by [1] are used in production by different parties
>>>> since 5.10, breaking them doesn't seem more acceptable than breaking 
>>>> the
>>>> new out-of-tree iMX8m hardware.
>>>
>>> The MX8M is also in-tree, so this does not apply.
>>
>> v6.5-rc4:
>>
>> $ git grep lontium,lt9611 | grep -v 9611uxc
>> Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml:$id:
>> http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
>> Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml:
>>      - lontium,lt9611
>> Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml:
>>        compatible = "lontium,lt9611";
>> arch/arm64/boot/dts/qcom/sdm845-db845c.dts: compatible = 
>> "lontium,lt9611";
>> drivers/gpu/drm/bridge/lontium-lt9611.c: { "lontium,lt9611", 0 },
>> drivers/gpu/drm/bridge/lontium-lt9611.c: { .compatible = 
>> "lontium,lt9611" },
>>
>> next-20230802:
>>
>> $ git grep lontium,lt9611 | grep -v 9611uxc
>> Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml:$id:
>> http://devicetree.org/schemas/display/bridge/lontium,lt9611.yaml#
>> Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml:
>>      - lontium,lt9611
>> Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml:
>>        compatible = "lontium,lt9611";
>> arch/arm64/boot/dts/qcom/sdm845-db845c.dts: compatible = 
>> "lontium,lt9611";
>> drivers/gpu/drm/bridge/lontium-lt9611.c: { "lontium,lt9611", 0 },
>> drivers/gpu/drm/bridge/lontium-lt9611.c: { .compatible = 
>> "lontium,lt9611" },
>>
>> Your device is not in the tree. Your commit broke existing users.
> 
> These devices are in tree:
> arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dts
> arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
> 
> The LT9211 and LT9611 are both expansion modules handled by DTOs and 
> bound to the DSIM (which is also in tree).

And they DT for them is not in the tree, that was my point. You have 
broken the existing user for the DTBO that is not present even in 
linux-next.

> 
>> Can we please end the argument, land the fix (this revert) for 6.5 and
>> work on the solution for 6.6 or 6.7?
> 
> I would much prefer a solution which does not break my existing use 
> case. It is still not even clear whether the problem really is on MX8M 
> side at all, or whether it is QCOM misinterpreting flags. I cannot debug 
> the later, since I have no access to that platform, nor its documentation.

You can get the RB1 for $199 and check the DSI behaviour on that 
platform. It has newer bridge, but the DSI controller is (mostly) the same.

-- 
With best wishes
Dmitry

