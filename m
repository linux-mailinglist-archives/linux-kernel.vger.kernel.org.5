Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BDA78B765
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjH1Sml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjH1SmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:42:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CF4B3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:42:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so51935781fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693248136; x=1693852936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4crfFK9rbkvRAtTGcELIJgSDL7K1RAR2VvV1PTA/yS8=;
        b=UufLu8sEdTBwkzCCLhJYuXW+vIpDt5IVesFf31AZIV4tBqaWT78XsJU8vMBZhsBeXU
         5BAxgvCKb31UscQ68QGvnBEHkhhRR1nsjV/FzpmOFcCcrNCyCh0v97MK61a0QAeq6Anh
         f20r3JZ0vPBPq5gMChHQMMuyn6PWFBYnJpfcWavo65xEqw/GgRqjzCVtcGjo9ykCjv5e
         rqLXtj6XFcEhmCF2ggubbgx7H3KyRDKvbBiqWKjaUM0yWLMI9DmCcfrIMrJZb2ThbjNG
         +gwDrCueai5hwfO04wXYLPF4Ffvt1AIhjOTGy2DQ2zaAGFy0T316pzzxv6//1KvFwbDe
         uwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248136; x=1693852936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4crfFK9rbkvRAtTGcELIJgSDL7K1RAR2VvV1PTA/yS8=;
        b=afDA9reakC1qnHN1U7TP5Hfl/t6ZEp0q6XoW8uQwmFRTSl05ucj8kmXk5TfBWqG0ln
         +niGAvSBJ4MCGHuUzArsZrK8876Vb2brfdzSqNP6inayUehlIHnIvVw02D2Mj0mvS17z
         rClLv9UF86S/TTMUL+b4KFtwVEMKgdBcH8A6koafd+IATzCXu3DHRKSsbsKF5PIclqCQ
         hguWuLaneaRyrZk5YIAgjiJNL+xjAUAaE4iW/bkQwYvVxtcJ+gAvw2nrY2EEuylEok4W
         HaQnVgEH/lMb8F1a7g9+SfZA10KG1ApUX1JLwOGLvmd+HlBXHbg3a0dNWtF6SmuI0Nls
         NRxw==
X-Gm-Message-State: AOJu0YxhXKfPQB1RgOfXZhMuF5X1R4nU+EZ9n/1vZtKjsYZn3vLLn0JN
        XKHJOPLWTfomvFBhi4zSP/KvKg==
X-Google-Smtp-Source: AGHT+IFvRz58L4vS5FMH8WGd1L+nXz7BkWynYCX2F5o9W0KTVWQfHur/iCV+WULOlxr+cKlREecxLw==
X-Received: by 2002:a2e:2404:0:b0:2bc:dcdb:b5dc with SMTP id k4-20020a2e2404000000b002bcdcdbb5dcmr11162107ljk.39.1693248135751;
        Mon, 28 Aug 2023 11:42:15 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090626d600b009a1fd22257fsm4960187ejc.207.2023.08.28.11.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 11:42:15 -0700 (PDT)
Message-ID: <154b36de-652b-3931-96e6-04e99253a09f@linaro.org>
Date:   Mon, 28 Aug 2023 20:42:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
To:     Shenwei Wang <shenwei.wang@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
 <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
 <PAXPR04MB9185957B729588D3E7CA3A5089E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <51fe3126-16ba-ade6-b106-e3683f96ad26@linaro.org>
 <PAXPR04MB9185DC79721E78E631F9889589E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB9185DC79721E78E631F9889589E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 20:39, Shenwei Wang wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Monday, August 28, 2023 12:11 PM
>> To: Shenwei Wang <shenwei.wang@nxp.com>; Ulf Hansson
>> <ulf.hansson@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
>> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
>> imx@lists.linux.dev; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> dl-linux-imx <linux-imx@nxp.com>
>> Subject: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
>> On 28/08/2023 16:04, Shenwei Wang wrote:
>>
>>>>> Are you suggesting to move the regulator-pd to the imx directory and
>>>>> add a company prefix to the compatible string?
>>>>
>>>> There is no such part of iMX processor as such
>>>> regulator-power-domain, so I don't recommend that approach. DTS nodes
>>>> represent hardware, not your SW layers.
>>>>
>>>
>>> That's not always the case, as we do sometimes need a virtual device.
>>> As an example, the "regulator-fixed" acts as a software abstraction
>>> layer to create virtual regulator devices by interfacing with the underlying
>> GPIO drivers.
>>
>> Not true. This is a real regulator device. Real hardware on the board.
>> You can even see and touch it.
>>
> 
> The physical hardware component is the GPIO pin, which is what you can only touch. 

No. The regulator is the chip.

> The regulator functions virtually through software layer above of the GPIO driver. While 
> we may call it a "regulator" or whatever else, this cannot obscure the fact that the underlying 
> hardware is just a GPIO pin being used in a specialized way.

The regulator is some tiny little box, you can touch and called
ti,tps51632 or similar.



Best regards,
Krzysztof

