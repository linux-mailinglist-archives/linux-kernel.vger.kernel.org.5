Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF5F75AA3A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjGTI64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGTIiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:38:21 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157AA2686
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:38:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991f956fb5aso88509766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689842298; x=1692434298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0hr0LCgc9WMn+CUZSv9Kigz3HQbdZYh5sDSa/c1lIE=;
        b=v4qQBUsFbsxa+hbb4GT0mu/nuEWQGV2Q6oUe7R8IC5Tvk3rtWLT2aUmAd8lqBECEtF
         YEmry70ZZmiiMYc0wqk2iZmav2sWjLctiY35Ib2IL7+UKrmU3fkTGeAEKTjGVbOA/ljJ
         1cIYCkWVq+lZ479MLw2ouQzjnDGxfdZWWsV6fUQpJGLjh2rG+NaRV2fsmzrqNBpelc4H
         ixQ1HBCxqP6mObNlDPoWuNxlMvgnt9iOdllNwJSoVvv3LSub32S4xgU0mGBX+Dc8EAkJ
         a+xHcasnC5My0AcPIAvGSlw0hxmOoMc15kzd2LvvsL9OblV+NaA33rcnasHaGO9Gi7+5
         U0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689842298; x=1692434298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0hr0LCgc9WMn+CUZSv9Kigz3HQbdZYh5sDSa/c1lIE=;
        b=eCSCi6mZ1eIqcYaVVC8lTq9TJBZVdQ0uXWTUeLx96PJRSSxByK8cKK7aa2LSK6oKYK
         1XtAwSqi6bg8LpcWojpSRiocSATsQ8Kfd6SBbBpGDiz23KX1K0+DpnC5QKhIlDZqOr3C
         /LCRy3hufLJ+cYg9eX4nlvJ7gGF63Ju2pzzvtlRYWYkxGHj+sykC4bw9CThbn8ekC+Kg
         BDjz0pVX6IKqGyxVFRauerUDsIX1FIFyleJAp43DhLnvgT68O09ETY7uyOu2HtzS30Xj
         LgCtyMrNXaNE2U6FDa7pL4BOVnMgUPCgSsKEnlSBIIenA4epOb4bMfxHSscWvjbt7f4r
         mqlw==
X-Gm-Message-State: ABy/qLZwdyHpuIiE6xS2YLVutISmwckavCOxcmVFx05byb8Zavr9Izna
        no1vOYDufg3AAQLiw+d9SiAKqw==
X-Google-Smtp-Source: APBJJlHaF+MqFiiKhZpFpwKmpcOzsc8zeLgUPDCYXCDkleXcF8WUygHP6/jdhKAq0bv18qDtUWIg9Q==
X-Received: by 2002:a17:906:1091:b0:993:8d16:4c22 with SMTP id u17-20020a170906109100b009938d164c22mr4693862eju.75.1689842298563;
        Thu, 20 Jul 2023 01:38:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id va6-20020a17090711c600b00992c4103cb5sm347683ejb.129.2023.07.20.01.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 01:38:18 -0700 (PDT)
Message-ID: <fd37e408-34d2-8fd3-31b7-b3a07dfb9817@linaro.org>
Date:   Thu, 20 Jul 2023 10:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Content-Language: en-US
To:     Alina Yu <alina_yu@richtek.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1689758686-14409-1-git-send-email-alina_yu@richtek.com>
 <1689758686-14409-2-git-send-email-alina_yu@richtek.com>
 <44b50616-a6ee-76e4-21b8-3e39b1a2ccd1@linaro.org>
 <20230720080728.GA10433@linuxcarl2.richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230720080728.GA10433@linuxcarl2.richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 10:07, Alina Yu wrote:
> Hi,
> Krzysztof:
> 
> On Wed, Jul 19, 2023 at 11:44:45AM +0200, Krzysztof Kozlowski wrote:
>> On 19/07/2023 11:24, alina_yu@richtek.com wrote:
>>> From: alinayu <alina_yu@richtek.com>
>>>
>>> Add bindings for Richtek RTQ2208 IC controlled SubPMIC
>>>
>>> Signed-off-by: Alina Yu <alina_yu@richtek.com>
>>> ---
>>> v4
>>> - Modify filename to "richtek,rtq2208"
>>> - Add more desciptions for "regulator-allowed-modes"
> 
> ...
> 
>>> +
>>> +          regulator-mode:
>>> +            enum: [0, 1]
>>> +            description:
>>> +              describe buck initial operating mode in suspend state.
>>
>> There is no such property on this level. Aren't you mixing initial one?
> 
> It's the initial mode in suspend-mem state, should I modify that like this ?
>         patternProperties:
>           "^regulator-state-(standby|mem|disk)$":
> 	    type: object
> 	    $ref: regulator.yaml#
> 	    properties:
> 	      regulator-mode:
> 	        enum: [0, 1]
> 		description:
>                   describe byck initial operating mode in suspend state.

Please check how other bindings do it.

> ...
> 
>>
>>> +            enum: [ 900000, 1200000, 1800000, 3300000 ]
>>> +            description:
>>> +              the fixed voltage in micro volt which is decided at the factory.
>>
>> I don't understand this property. Why this is different from min/max
> 
> 
> Because ldo has fixed voltage, so I thinks I could use a property to
> represent the fixed voltage directly. Do you suggest me modifying that like this:
> 
> regulator-min-microvolt = <900000>;
> regulator-max-microvolt = <900000>;
> 
> Using min voltage equals to max voltage to represent fixed voltage, instead of self-defined property ?

Yes.



Best regards,
Krzysztof

