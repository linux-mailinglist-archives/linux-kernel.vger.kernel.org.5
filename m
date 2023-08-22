Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079FB78456B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbjHVPZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjHVPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:25:36 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BB2CD5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:25:34 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50078eba7afso4270549e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692717932; x=1693322732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y5CLA2KNaAWPxWmHn3gOeMHV9Mij34aiTzhvlGQZaYA=;
        b=gULeZIZxM1UDkuR2e7pdWHGfHRhZ7hVBNnziyChiJpXZtA8T3Lqt+zNhR6YmWG8Lwd
         QWBDk2Z+lS01O37XqNHRJSstML1IdWhRdagmgLmOh8F1UVKj2u6KdJIhaVgrLGJ62cu9
         9l+hB8Q0CMROKXQboZwHmJvR4FbuIk4gKvAiSF9Ui4hRAQq1m9jLUcBe9fr+z+i775In
         +CKEeno8a3QEIhXyeR+jl+I9E/QS0akU0BwMO4UTivyi19E07TmPdEoreD0/IzdVaf2t
         atoCkHSiJtBC3X2vkbFGITe+xTv5Ohp06mrMnm6al1e0DQF5lRpG18xOjGuZOihQOZl/
         RxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692717932; x=1693322732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5CLA2KNaAWPxWmHn3gOeMHV9Mij34aiTzhvlGQZaYA=;
        b=KSpq9zvgV/8qO31+HMcLr0pOy1DQ68pYVCCHRdx+vJIzyD50IeHQ8SQ7PbhTckCHx2
         mme1lqf9++oaVdQx1ROJWGYbCBOylTxhmLKk5f+bkTzR3NELFu4s19miztTPS0PVmTeo
         kxS7H/3BqSrPksLfUYjwOcbc1NgRwnSOSyUlU0HMuefQLi2vtNL+MZzjnzJvicCsNvbL
         /z2NRRBRfdSqW2hyr5EENacKlvsagN7kDlnySrKiDEmfWiffCTt6Hh2BrTAZlgwxVngn
         zmzEYh2IqJfahI9jrtSyizYti8+mvdI06LHgTM73G4ldz1g7FQdMOyvJm5ZJ5oDgvTpN
         sfTg==
X-Gm-Message-State: AOJu0Yzu4QwovP0D19LC7TvqRWWMEv6DpJYVZC0EGq+hQ0jJHavtEsxg
        dsXZN18dVuh4YGPVVegXDpRrqg==
X-Google-Smtp-Source: AGHT+IEZBABvrUJyOnUqIjt8DQpu4/Ght7kXWGlnDfbg74DLs7ajvH75DORb8rvzSwmWJ5nrCs9TaA==
X-Received: by 2002:a05:6512:39d1:b0:4f8:6625:f2ca with SMTP id k17-20020a05651239d100b004f86625f2camr7199083lfu.61.1692717932388;
        Tue, 22 Aug 2023 08:25:32 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id l2-20020aa7cac2000000b0052239012c65sm7794477edt.82.2023.08.22.08.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:25:31 -0700 (PDT)
Message-ID: <51bc0ccf-425b-5f16-b8f2-94d7cc979fae@linaro.org>
Date:   Tue, 22 Aug 2023 17:25:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB918567C378D420DB4830B869891FA@PAXPR04MB9185.eurprd04.prod.outlook.com>
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

On 22/08/2023 17:18, Shenwei Wang wrote:
> 
> 
>> -----Original Message-----
>> From: Rob Herring <robh+dt@kernel.org>
>> Sent: Monday, August 21, 2023 1:50 PM
>> To: Shenwei Wang <shenwei.wang@nxp.com>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
>> Ulf Hansson <ulf.hansson@linaro.org>; Liam Girdwood
>> <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
>>> Thank you for providing the link. After reviewing the entire thread, I
>>> still don't understand how to proceed. What is the conclusion
>>> regarding this commonly used use case but overlooked feature in the
>> upstream kernel?
>>
>> Overlooked implies we missed and ignored it, but the same concept has been
>> submitted twice and rejected twice. What use case cannot be supported?
>>
> 
> No offend. :) Sorry for my poor word. To provide more context, a common use case 
> example is using a GPIO pin as a power switch. The current implementation operates 
> as a fixed regulator, which makes it difficult to control the on/off timing without modifying
> its driver. 

So it is a problem of a driver?

> It also lacks power management support. 

Which is not related to bindings but implementation in given driver.

> 
>> The detail that power-domains get handled automatically is an implementation
>> detail in the kernel (currently). That could easily change and you'd be in the same
>> position as with regulator supplies.
> 
> The proposed regulator-pd driver follows the standard PD driver framework, so it for sure
> relies on certain kernel implementation details. If those underlying implementation details 
> change in the future, this driver as well as other PD drivers built on the same framework 
> would need to be updated accordingly. 

We talk about bindings which you would not be allowed to change. Thus
your case would stop working...

> 
>> We could just as easily decide to make the driver core turn on all supplies in a
>> node. That would give you the same "feature". Why would you design your DT
>> around implementation decisions of the OS?
>>
> 
> This DT properties are proposed solely for this specific driver, not to hack the OS. This 
> is no different than other PD drivers like gpc/scu-pd/imx93-pd.

I am not sure if you got Rob's point, I have feelings that not. Argument
that some OS implements something some way, is not an argument for a new
binding, barely hardware related.

Best regards,
Krzysztof

