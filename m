Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE95F7AD37D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjIYIg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjIYIgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:36:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A2CAF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:36:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-404fbfac998so66154675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695631007; x=1696235807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWHXGf/28UmGg0QYv/KDMxlG6hTCVFQe8U+b4Xx9ObM=;
        b=iIYy84UwD3FRZQGdiMoLuSB0u2fae3h74+qhniZYG5q1+b23K9vnHSEqFz3A2eipQG
         RXlaBZfbYPYxUKLM/OLBFndEB3ayOLRgdHZUAY2v0vys2oFR5FPDWu7D1KTigyUYqJ8Q
         jIOxLpuYe5b8jyxQ/Xt5RBCq99VcwjIDrOFy3cEhLy2eENwibeEhGxIjvaJrbKKeoAJb
         b4j64u5XP9y4Y3mi7Myt8Hc95Cc9pOSRrbqnjKNJqu7J+Oh+hNVDplaQQfshpqK5XbRr
         22ljO2MWCl4w0mU8PA3eUVLzatQbDCaXoRjvgzsia7xTXVBL1tlPzgMvArY2+r3G2TPX
         89nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695631007; x=1696235807;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWHXGf/28UmGg0QYv/KDMxlG6hTCVFQe8U+b4Xx9ObM=;
        b=JvhdGC7xMwWUqbMy0mXFt4zzxee9R/IMNQvbNc2OkJxOjXb2rWI4J+Cd67vc/NzDMH
         IxcyjSRoGgHBLx5kTJH+oLlfh4ohwofOLw/Hn/t6Bqgs7HhQXTGF4Ad1rpeUV3e6JiuU
         ME7oFHnPasg9YiEXu/Ww5l4wz9o/lYK7pO3/yRElRi+JPnIplpmyw/yyRy8E2IXmBNLI
         nGEU3MZyM+9LTLKuhWcU+nRKdVOkEzTZV6NwJhU8ux8q9py8rXJKmeW8J+bYJ9PwCOuw
         K/izjgMRLcTRQLw4r3tw8Cuh3CPL98lB60gMU23dN486UaqYgSxPfJFmYKTXNFvC8w+y
         f4Mw==
X-Gm-Message-State: AOJu0YyD7faVGXXrYa0Bmtbqlna9n5UN5y1rGH6cCmlbdzOFncgQtAbv
        EwlpmISn43hzM0EMuSgEmlxveg==
X-Google-Smtp-Source: AGHT+IEj8GV6kW4W9+YjFYpTKqIX3yRSpMMeifsTqhuG1Qtc3FnNeS+ajKhOLku1duVjtqHcI+uoUw==
X-Received: by 2002:a05:600c:22c7:b0:401:c436:8999 with SMTP id 7-20020a05600c22c700b00401c4368999mr5440828wmg.30.1695631006792;
        Mon, 25 Sep 2023 01:36:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4e48000000b00315af025098sm11089954wrt.46.2023.09.25.01.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 01:36:46 -0700 (PDT)
Message-ID: <7f539f82-d904-4c46-ba84-6aedd4fafcbe@linaro.org>
Date:   Mon, 25 Sep 2023 10:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl_rpmsg: List DAPM endpoints
 ignoring suspend
Content-Language: en-US
To:     Chancel Liu <chancel.liu@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230925024847.2971421-1-chancel.liu@nxp.com>
 <c3e682dd-7bb7-4662-b97d-872df1ff879d@linaro.org>
 <DB9PR04MB9498338014461E28A9988538E3FCA@DB9PR04MB9498.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <DB9PR04MB9498338014461E28A9988538E3FCA@DB9PR04MB9498.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2023 10:20, Chancel Liu wrote:
>>> Add a property to list DAPM endpoints which mark paths between these
>>> endpoints ignoring suspend. These DAPM paths can still be power on
>>> when system enters into suspend.
>>>
>>> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
>>> ---
>>>  Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
>>> b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
>>> index 188f38baddec..ec6e09eab427 100644
>>> --- a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
>>> @@ -91,6 +91,12 @@ properties:
>>>        - rpmsg-audio-channel
>>>        - rpmsg-micfil-channel
>>>
>>> +  fsl,lpa-widgets:
>>
>> What is LPA? It's not explained in property description.
>>
> 
> On asymmetric multiprocessor, there are Cortex-A core and Cortex-M core, Linux
> is running on Cortex-A core, RTOS or other OS is running on Cortex-M core. The
> audio hardware devices can be controlled by Cortex-M. LPA means low power audio
> case. The mechanism can be explained that Cortex-A allocates a large buffer and
> fill audio data, then Cortex-A can enter into suspend for the purpose of power
> saving. Cortex-M continues to play the sound during suspend phase of Cortex-A.
> When the data in buffer is consumed, Cortex-M will trigger the Cortex-A to
> wakeup to fill data.
> 
> I can add above explanation to LPA in patch v2.
> 
>>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>>> +    description: |
>>> +      A list of DAPM endpoints which mark paths between these endpoints
>>> +      ignoring suspend.
>>
>> And how does it differ from audio-routing? Also, you need to explain what is
>> "suspend" in this context. Bindings are independent of Linux.
>>
> 
> Normally audio paths will be disabled by ASoC dynamic audio power management if
> Linux enters into suspend. LPA requires some audio paths enabled when Cortex-A
> enters into suspend. We can read DAPM endpoints from the "fsl,lpa-widgets"
> property and keep the paths between these endpoints enabled during suspend
> phase of Cortex-A. Property "audio-routing" just declares the connection
> between widgets and doesn't have such feature.
> 
> I will modify the description as following:
> "A list of DAPM endpoints which mark paths between these endpoints still enabled
> when system enters into suspend."

Yes, that's better, but even better would be to say not how the OS
should behave, but how the actual entire system works. Basically these
widgets remain in use by your co-processor, thus OS should not disable
them when entering in system suspend state.

Best regards,
Krzysztof

