Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9654C784669
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbjHVP6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbjHVP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:58:02 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ADA12C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:58:00 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so78556021fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692719878; x=1693324678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziQuC645DrIZLGT5VV7OX3wRBfSiQDkNJDxc2Uc2oXw=;
        b=Y7NgyweM5DH3Gm2s9TufjiIGig+WFCgkXWcJGvd7/by/T1HVwHC5f6cO0OMGFXmCwR
         FjOCvQ8d5Fu3q0bk4OE1rm9i2OOGwiMnwEb49iuzc+ejIPAL37iR8Jz8c80HU/zQGwwX
         YGmMGibXiwWYnmWC/Mend1Hyi+vyj70md1bGNIlpPnofaip2Wm7TugJ82uBzzkE3wMSZ
         9Ce9FU7fpyH8bz2BHLnBZTQb+M+FJmYCoaBenL8y13tH5dWOBQcQRnlV2wu1mXhFe4pv
         SOyMDono7ZPmCzGEsEGCSan2XzBKgioNpXHH7aDBT7ZowTUhJWjxIOdbDOhNdhMl7d24
         8hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692719878; x=1693324678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziQuC645DrIZLGT5VV7OX3wRBfSiQDkNJDxc2Uc2oXw=;
        b=eOTe+7XcfysnW7dgfgPb6trnW/UEK21QAmySHYZelQRChCtDajs39ujByoc5GolsEj
         sRktEhOt9cwDKswb1XUTjDcbpSu3D3AmnkOQ3x3fdCXQFrCxN5SePM5E/Anjl/N2KnSN
         8NPVhtQnWSGiRXrqWQL5CK3uo9ZYPC7rdkL4OILb+BKwWE4lsDXthkS9fHqgKe8FTXvf
         XQP7EMEjQjBkPj1NQMOQconn0fbZP4G2oV6LpveRQVvVMsRf1NGZYlmGKxmbVDEYjjJ+
         qH4kx44Xh6vAamAd7QjdbC8Oo3PDAVk8lBaLEXBb5LU/PQidbvUDl7wIzCpL/4C5r2EM
         160Q==
X-Gm-Message-State: AOJu0YwV3pLhu9i5UsfXxJ6mr0RSOJQ1nQC0xIqV5/wG5EXV67m2hooA
        i2qwVvBScBvQoDvJDukHsPpDVA==
X-Google-Smtp-Source: AGHT+IGTiH0yWLnVA01NmPlWC40z88n4Ts80NmctR6S8tLxvtl5DLS8LM8jvfx6OVVJQwZJAghSsSQ==
X-Received: by 2002:a05:6512:2354:b0:4ff:a8c6:d1aa with SMTP id p20-20020a056512235400b004ffa8c6d1aamr8302630lfu.48.1692719878499;
        Tue, 22 Aug 2023 08:57:58 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id q6-20020aa7d446000000b0052718577668sm7698214edr.11.2023.08.22.08.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:57:58 -0700 (PDT)
Message-ID: <e146782f-a93c-e694-1b08-7c2dba597bcf@linaro.org>
Date:   Tue, 22 Aug 2023 17:57:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml
 file
Content-Language: en-US
To:     Shenwei Wang <shenwei.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAL_Jsq+XA_P-aRK9_WuGPmJ0_xJgsSr9smZy4BRbKZbmVsMQBQ@mail.gmail.com>
 <PAXPR04MB918539A19B8F817F623BBD1F891BA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <9927403d-6dd9-3e5e-8f9d-f38e6640f95f@linaro.org>
 <PAXPR04MB91850D8807CE374BD7C30CC5891EA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAL_JsqJ3dr7gxq+D5DYG8oQ=igzjARz=beQoYL7rrydV4SwDTw@mail.gmail.com>
 <PAXPR04MB918567C378D420DB4830B869891FA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <51bc0ccf-425b-5f16-b8f2-94d7cc979fae@linaro.org>
 <PAXPR04MB9185F7B520E8BE94B97C4908891FA@PAXPR04MB9185.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB9185F7B520E8BE94B97C4908891FA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 17:50, Shenwei Wang wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Tuesday, August 22, 2023 10:26 AM
>> To: Shenwei Wang <shenwei.wang@nxp.com>; Rob Herring
>> <robh+dt@kernel.org>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>> <conor+dt@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; Liam Girdwood
>> <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
>> imx@lists.linux.dev; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> dl-linux-imx <linux-imx@nxp.com>
>> Subject: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
>>>
>>> No offend. :) Sorry for my poor word. To provide more context, a
>>> common use case example is using a GPIO pin as a power switch. The
>>> current implementation operates as a fixed regulator, which makes it
>>> difficult to control the on/off timing without modifying its driver.
>>
>> So it is a problem of a driver?
>>
> 
> That is arguable too. The driver may assume its power is on when probed, which 
> aligns with how the PD behaves.

So everything in driver... no discussion about bindings.

> 
>>> It also lacks power management support.
>>
>> Which is not related to bindings but implementation in given driver.
>>
> 
> For those simple drivers, the default power management logic can handle 
> power correctly without requiring any specialized implementation in the 
> driver code.

You can create any drivers you wish or change existing ones. I don't see
a problem here.

> 
>>>
>>>> The detail that power-domains get handled automatically is an
>>>> implementation detail in the kernel (currently). That could easily
>>>> change and you'd be in the same position as with regulator supplies.
>>>
>>> The proposed regulator-pd driver follows the standard PD driver
>>> framework, so it for sure relies on certain kernel implementation
>>> details. If those underlying implementation details change in the
>>> future, this driver as well as other PD drivers built on the same framework
>> would need to be updated accordingly.
>>
>> We talk about bindings which you would not be allowed to change. Thus your
>> case would stop working...
>>
> 
> As a new driver, it has to involve some new bindings especially the compatible 
> string.

I am not talking about this. I do not speak about creating new bindings,
but changing them.
> 
>>>
>>>> We could just as easily decide to make the driver core turn on all
>>>> supplies in a node. That would give you the same "feature". Why would
>>>> you design your DT around implementation decisions of the OS?
>>>>
>>>
>>> This DT properties are proposed solely for this specific driver, not
>>> to hack the OS. This is no different than other PD drivers like gpc/scu-
>> pd/imx93-pd.
>>
>> I am not sure if you got Rob's point, I have feelings that not. Argument that
>> some OS implements something some way, is not an argument for a new
>> binding, barely hardware related.
>>
> 
> Thank you for the clarification. The issue is that this driver is purely a software layer 
> that wraps the regulators as a power domain. The bindings make the implementation 
> clean and easy to understand.  I don't think we should add extra complex logic inside 
> the driver solely to avoid introducing new bindings.

Since bindings are not for software layers, I don't think we should be
talking about them just to avoid introducing driver changes.

Best regards,
Krzysztof

