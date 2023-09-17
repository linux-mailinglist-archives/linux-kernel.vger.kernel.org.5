Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81F7A3468
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 10:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjIQIct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 04:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbjIQIcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 04:32:25 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C17136
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 01:32:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a65f9147ccso451629166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 01:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694939537; x=1695544337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b23jMIF5+DQOp/GSGV7SwrYXy7pfETR+qmI0IugD7mE=;
        b=Oc65dVS0PW57ID/u1flhJ4fGxqD8kxVj8uguApEvdrKknuFaVw/0smPrSZFi50wjUz
         P2s9BvE0+RYFZnmoT0AhLDZF53IzS10SDyPEhZYoZCeqGJuUDfD21CAZtPJEN9TuYBkZ
         i25wo8N7GEdSlKR6FZpFuSCxhV/+WvJtMJuiSCATyjLlNLzNjxswy8iqm4tT+UXCTlpU
         SqdnqXSETMydynCwG6RziaU5c/HAEY7dRI0pSr3lEydPZlPCVdRYIKnUcZygGXmBcGIX
         gDv4Z0wTWGA8Zm5gpfrifUrPpI3cHKgyCN0ersjTyWBMhV+d84hYj/dfR4LzwQBNDxBA
         chGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694939537; x=1695544337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b23jMIF5+DQOp/GSGV7SwrYXy7pfETR+qmI0IugD7mE=;
        b=Yh/V9bwaoHzEVRj3ZTlV/i+gWZWHleSb1PINnd0RPE+GWKhjpXTGBHfklAkGSm4fsI
         JRA+9e4DCYqi38pImoDM29Aw7gbC65xcRCghUHl7+uSNln/gLw8nQbnIJAUcH3Em1oFC
         FpwEuIY3wRysl2cp5jSrAKv/uC3eQh/3QhpAus8RRXAsTUsETUmQT1PYbCyRRJG2HMZj
         FSHSLocS74P28fvv7NrEog/NgJgr1QEKpItqTyRYFbecA2pwAfrwwyknIqGeaxy3EWo2
         gMSS3F1p/QZqkeDwkobtHubVBPXY4/otMm8bRjBPqVQHfaRMHPc0REnzYSnfJ8ehuily
         suwA==
X-Gm-Message-State: AOJu0YxcSDtYddWrTGk/HcZ67kYxfQ1CtvPQtYQDA07URWTBiCUTx5R/
        N9PKQcLUQqDUaTczVN9MvsuhFQ==
X-Google-Smtp-Source: AGHT+IFqbSxj61c+q2xrmKMYlDKNM94+pfIvL33VUVR4I9eHxwJ+oE7xpKSsmL6C7BTKtM5kQwIg4w==
X-Received: by 2002:a17:906:32d2:b0:9ad:99a8:7c4e with SMTP id k18-20020a17090632d200b009ad99a87c4emr6066682ejk.55.1694939537384;
        Sun, 17 Sep 2023 01:32:17 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id n26-20020a170906119a00b00997cce73cc7sm4676360eja.29.2023.09.17.01.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 01:32:16 -0700 (PDT)
Message-ID: <011074e5-cec2-1c69-7324-30d9ab653577@linaro.org>
Date:   Sun, 17 Sep 2023 10:32:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] dt-bindings: mfd: qcom,spmi-pmic: Add pm8916 vm-bms
 and lbc
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru>
 <20230916-pm8916-dtsi-bms-lbc-v1-1-7db0b42f9fb1@trvn.ru>
 <18bef7a4-608b-9ba3-ce8f-ca25999705c3@linaro.org>
 <fac4a27d08108bd6e902ba0fa4708ec4@trvn.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fac4a27d08108bd6e902ba0fa4708ec4@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2023 10:26, Nikita Travkin wrote:
> Krzysztof Kozlowski писал(а) 17.09.2023 12:58:
>> On 16/09/2023 15:57, Nikita Travkin wrote:
>>> PM8916 (and probably some other similar pmics) have hardware blocks for
>>> battery monitoring and charging. Add patterns for respecive nodes so the
>>
>> typo: respective
>>
> 
> Oops, will fix if we get to v2.
> 
>>> dt for those blocks can be validated properly.
>>>
>>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>>> ---
>>> Schemas for those devices were added in [1].
>>
>> "Dependency"
>>
> 
> You are right, will try to word it better next time.
> 
>>>
>>> [1] https://lore.kernel.org/r/20230915-pm8916-bms-lbc-v3-0-f30881e951a0@trvn.ru
>>> ---
>>>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>>> index 9f03436b1cdc..8bcd76748faa 100644
>>> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>>> @@ -133,9 +133,15 @@ patternProperties:
>>>      type: object
>>>      $ref: /schemas/sound/qcom,pm8916-wcd-analog-codec.yaml#
>>>
>>> +  "^battery@[0-9a-f]+$":
>>> +    type: object
>>> +    oneOf:
>>> +      - $ref: /schemas/power/supply/qcom,pm8916-bms-vm.yaml#
>>
>> That's just ref, so no need for oneOf... unless you already think this
>> will grow with different schemas like the charger below?
>>
> 
> Yes, I think some other PMICs have different battery/fuel-gauge
> blocks too so I'd like to have some room for expansion here.

There is always room. Which other device will have different battery
charger?

Best regards,
Krzysztof

