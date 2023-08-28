Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C978B7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjH1TMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjH1TME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:12:04 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02AFCD7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:11:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so464509766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693249897; x=1693854697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJpk0152nUK7MAn+YHkTbH/h73b7L0QzmLeU7H8QQVw=;
        b=BMHlkVU7vOt8RhnhlNEUEQzhKuwUno5YJ5C8yTDb2SMAZ4ImaLh9xAQMSudCjWyjCU
         nErdsiSar1QqN3KvJmtYDNs/19kXyCbx5kqTHC5RkkeBlxMrJ2IyF6IQ3qmswiKKgPPV
         Mg9LpGGGeS6Eb87m4ewNlPtmQ6LLCjPzzn8hSdtD65Z2G40Lbz8OYzgIJUujZESPkxJ1
         xwgxm0GoX5wBkKUhYh/fIz1gwNRK9NKHtwAFNMPvE2IqGxXycGUg+ysfJSiS6kOGEVon
         KeF3Tad1LzUerju5/ZtCnGjKQ9VICYuE7+P16eL6+buPA827pUrPBAnxiQ9J1S4wAiLT
         2AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693249897; x=1693854697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJpk0152nUK7MAn+YHkTbH/h73b7L0QzmLeU7H8QQVw=;
        b=C1jmNEmm7EZZJAwBovVMdvryq8DS/xZyqn4DUmHz/RaSE/E3ZYldXDiCYRFa18O8GP
         Ep0igF0wyIsQVL328IfjfQjs1Yu3RPfdkDm3Qz+BCCWGqqk5p6yaGut2iic0mbDZcOXS
         WWu3oaeO60R1YYX6VOTOOWT4QXgsUCJE8imMNVrCnuWcfzy1QsE5lYn6bkDhoNGYnW6b
         qvB+I2Xw3BJXZxYzbd7VLFQ59hBEVPH4Biu0MgrDDryUgvA4rjm5OsYP3Fjzrl/EE96F
         146b/RPpZ8K9wZhrFF0ne4jm2cUcR96/3d7o7/NRf91iZWQ+Pw6mKu8jYd0st9zuJ8is
         oNvA==
X-Gm-Message-State: AOJu0YwISil0Xs9Kto79jmx2IFHGjKQGfpIJFNBYeRedw6VoWAyyuHO6
        PrmY6b+zwAdT5clniebYrkd8vQ==
X-Google-Smtp-Source: AGHT+IFAlLZZ7/DQKN9k+MBu0E+BaiPGpFYDLSfsZbH5elEegq7maUi4CQhGqVXz5H6zpB+iEWMoug==
X-Received: by 2002:a17:907:770f:b0:9a5:7759:19c0 with SMTP id kw15-20020a170907770f00b009a5775919c0mr6873428ejc.64.1693249897414;
        Mon, 28 Aug 2023 12:11:37 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id l21-20020a1709061c5500b009882e53a42csm4947462ejg.81.2023.08.28.12.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 12:11:36 -0700 (PDT)
Message-ID: <465e61a0-895d-54b9-d1b9-424265c82855@linaro.org>
Date:   Mon, 28 Aug 2023 21:11:35 +0200
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
 <154b36de-652b-3931-96e6-04e99253a09f@linaro.org>
 <PAXPR04MB91852AD4E5242306B57A910B89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <f3e89479-14ab-d1d0-ad87-6f457f313c39@linaro.org>
 <PAXPR04MB9185D87525AA88A8C3543EEA89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB9185D87525AA88A8C3543EEA89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 21:09, Shenwei Wang wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Monday, August 28, 2023 1:53 PM
>> To: Shenwei Wang <shenwei.wang@nxp.com>; Ulf Hansson
>> <ulf.hansson@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
>> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
>> imx@lists.linux.dev; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> dl-linux-imx <linux-imx@nxp.com>
>> Subject: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
>>>>>>>>> Are you suggesting to move the regulator-pd to the imx directory
>>>>>>>>> and add a company prefix to the compatible string?
>>>>>>>>
>>>>>>>> There is no such part of iMX processor as such
>>>>>>>> regulator-power-domain, so I don't recommend that approach. DTS
>>>>>>>> nodes represent hardware, not your SW layers.
>>>>>>>>
>>>>>>>
>>>>>>> That's not always the case, as we do sometimes need a virtual device.
>>>>>>> As an example, the "regulator-fixed" acts as a software
>>>>>>> abstraction layer to create virtual regulator devices by
>>>>>>> interfacing with the underlying
>>>>>> GPIO drivers.
>>>>>>
>>>>>> Not true. This is a real regulator device. Real hardware on the board.
>>>>>> You can even see and touch it.
>>>>>>
>>>>>
>>>>> The physical hardware component is the GPIO pin, which is what you
>>>>> can only
>>>> touch.
>>>>
>>>> No. The regulator is the chip.
>>>>
>>>
>>> In the definition of dts node below, where is the chip? The real hardware is just
>> a GPIO Pin.
>>>     reg1: regulator-1 {
>>>       compatible = "regulator-fixed";
>>>       regulator-name = "REG1";
>>>       regulator-min-microvolt = <3000000>;
>>>       regulator-max-microvolt = <3000000>;
>>>       gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
>>>       enable-active-high;
>>>     };
>>
>> There is a chip. This is the chip. If you have there only GPIO pin, then your DTS is
>> just wrong. Drop it. If you learn from wrong DTS, then sure, power-domain-
>> regulator seems like great idea...
>>
> 
> When you talk about the chip, can you please be more specific?

What to say more? The device node you quoted above is the regulator. You
brought specific example and now claim this is not a regulator, but just
GPIO. Please fix your DTS.

> 
> Regarding the dts node, how about the example in the fixed-regulator.yaml under the bindings directory.

That's an example, how is it related to anything?

> 
>     reg_1v8: regulator-1v8 {
>       compatible = "regulator-fixed";
>       regulator-name = "1v8";
>       regulator-min-microvolt = <1800000>;
>       regulator-max-microvolt = <1800000>;
>       gpio = <&gpio1 16 0>;
>       startup-delay-us = <70000>;
>       enable-active-high;
>       regulator-boot-on;
>       gpio-open-drain;
>       vin-supply = <&parent_reg>;
>     };
> 
> If you take a look at the fixed regulator driver (fixed.c), I don't think you'll find anything related to a hardware 
> component (chip) other than the GPIO Pin.

That's a driver. How is it related to this discussion? Bindings are not
about drivers.


Best regards,
Krzysztof

