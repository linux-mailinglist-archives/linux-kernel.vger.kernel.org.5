Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB1D77A456
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 02:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjHMAXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 20:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHMAXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 20:23:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E7FC
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 17:23:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bf9252eddso442335366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 17:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691886204; x=1692491004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8UpPEN/PkpMGRBM/kJqhYOp8lqLmyddT0ZDjSAgSpY=;
        b=MHI6BSdYmfvQUuGts4c9XfX7RmDJKyv/Ebh8scD0xAZWfMgl0jCvAmv4Az37voEGv8
         ruPlzjOSso8TG8jzcytKqkZeuxIB3n4ZLqcz1GgTApZHwWrIb6BoFDMYqP6XMA90/med
         TEYh2deTkvBBSw3cNfs8AqBXQUh+jvYkjKe4v1hKcQXmd5AdnIXjmCWx2Y5455MnN92w
         D7qKm2XnfmQ2QcIX29wT5Hiu7a90vT6efxQLMwYEfXlD70fRQ63Dz7LF4o9D9JVHRXYd
         rgDDtd9KX2CSpjLlBC9EAXPs91P1qI8aMo6Q0Yad044igMY1xghV0qqChKjhGwagljT8
         /Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691886204; x=1692491004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8UpPEN/PkpMGRBM/kJqhYOp8lqLmyddT0ZDjSAgSpY=;
        b=hHZUs3BPon++wg+sIrS76JFykg5/wEuigiPaGNAbYg86T3c1o4qcpqW/+T4b0CpjNn
         b/OoNnJo2AXhBQGgms81yc+Cv4QssGkKVMGdn5lMRR2S3LaBoA6xn65U11RsbGkMK4Lu
         dXbtCkaeG39CKypNbByzvvB8QI/YPrCZIS0oLxMaa2Fb80E0TP4heZF+wGehhf9YGLv+
         J0gOHNKyg17IApHAXbFITjurYCzSbYZei1KXmsMhvLBteTtkQX/k8WnmnjZYeMe2AkJv
         3zKRSCPvu+c90JsgbcPsWBLyaXyLvW75flO3jYw7rTZd5m7VqlqwhHAt2S0sw4QS2IP8
         XOAw==
X-Gm-Message-State: AOJu0YwfjUNDeGN0prAZ6t4RVLTmItHq+4qQk4IXzc3DPWQFE8RpV+Y6
        ZbOhs1n/gJSt2YYTg3/2sxA=
X-Google-Smtp-Source: AGHT+IGmxGn+1wkhVOC2Kxcn/Fx1V1CGIxcIkQTjXVlEIo+4NlVGkUPQ4yN9ZshjCtW779kxW6O6cw==
X-Received: by 2002:a17:906:315a:b0:99b:e5c3:2e45 with SMTP id e26-20020a170906315a00b0099be5c32e45mr4636857eje.28.1691886204277;
        Sat, 12 Aug 2023 17:23:24 -0700 (PDT)
Received: from ?IPV6:2a02:908:8b3:1840:9c00:9bd:fed3:8356? ([2a02:908:8b3:1840:9c00:9bd:fed3:8356])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709061c0800b0099d9b50d786sm720356ejg.199.2023.08.12.17.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 17:23:23 -0700 (PDT)
Message-ID: <92396880-edb5-d8e0-4fcf-54aeaa2b40d7@gmail.com>
Date:   Sun, 13 Aug 2023 02:23:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/11] drm/bridge: tc358768: Fix bit updates
Content-Language: en-US
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Aradhya Bhatia <a-bhatia1@ti.com>
References: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
 <20230804-tc358768-v1-2-1afd44b7826b@ideasonboard.com>
 <cd5d39a2-4f4c-419a-8137-d2719135e205@gmail.com>
 <241937b4-1ef8-abad-7c4a-b26bfab86a3a@ideasonboard.com>
From:   Maxim Schwalm <maxim.schwalm@gmail.com>
In-Reply-To: <241937b4-1ef8-abad-7c4a-b26bfab86a3a@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11.08.23 19:02, Tomi Valkeinen wrote:
> On 11/08/2023 19:23, Péter Ujfalusi wrote:
>>
>>
>> On 04/08/2023 13:44, Tomi Valkeinen wrote:
>>> The driver has a few places where it does:
>>>
>>> if (thing_is_enabled_in_config)
>>> 	update_thing_bit_in_hw()
>>>
>>> This means that if the thing is _not_ enabled, the bit never gets
>>> cleared. This affects the h/vsyncs and continuous DSI clock bits.
>>
>> I guess the idea was to keep the reset value unless it needs to be flipped.
>>
>>>
>>> Fix the driver to always update the bit.
>>>
>>> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>>> ---
>>>   drivers/gpu/drm/bridge/tc358768.c | 13 +++++++------
>>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
>>> index bc97a837955b..b668f77673c3 100644
>>> --- a/drivers/gpu/drm/bridge/tc358768.c
>>> +++ b/drivers/gpu/drm/bridge/tc358768.c
>>> @@ -794,8 +794,8 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>>>   		val |= BIT(i + 1);
>>>   	tc358768_write(priv, TC358768_HSTXVREGEN, val);
>>>   
>>> -	if (!(mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
>>> -		tc358768_write(priv, TC358768_TXOPTIONCNTRL, 0x1);
>>> +	tc358768_write(priv, TC358768_TXOPTIONCNTRL,
>>> +		       (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
>>>   
>>>   	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
>>>   	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
>>> @@ -861,11 +861,12 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
>>>   	tc358768_write(priv, TC358768_DSI_HACT, hact);
>>>   
>>>   	/* VSYNC polarity */
>>> -	if (!(mode->flags & DRM_MODE_FLAG_NVSYNC))
>>> -		tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5), BIT(5));
>>> +	tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5),
>>> +			     (mode->flags & DRM_MODE_FLAG_PVSYNC) ? BIT(5) : 0);
>>
>> Was this the reverse before and should be:
>> (mode->flags & DRM_MODE_FLAG_PVSYNC) ? 0 : BIT(5)
> 
> Bit 5 is 1 for active high vsync polarity. The test was previously 
> !nvsync, i.e. the same as pvsync.

this statement doesn't seem to be true, since this change causes a
regression on the Asus TF700T. Apparently, !nvsync is true and pvsync is
false in the present case. 

Best regards,
Maxim
