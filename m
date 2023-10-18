Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84707CE87E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjJRUHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:06:58 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B7B114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:06:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c16757987fso96341051fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697659614; x=1698264414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fV7fTkn3aVtTytg7FjK9RSeuS2ZwMLzGixbs5gWSolA=;
        b=MhqVxXvnxZIYtc18dQccvzFd/4SAmWvq9iXnOtfzH42g5MtrA3i7iw96h4g5w0R8gO
         +2H//6lG3RxNZ0ECge5KhPXsT9cVFhP7BjIr2NZ68MP29oHX5tdhMz8T4WqrZ6dW2iCL
         hr9xIOFocT308reggY0Uo6jNkIuXUvveHa8sjIzSTowikV9eZ1RHw02TkEJrF0Ti34cr
         oDK8o84GPFjnNZrRzSk2y/Tn3nJ3SCpWtJpYuZUeWaJuxHhnygbUJUJ26wiwMvH1gVNt
         KDTBh+URHftLGqRvGNQaPjI9+6Ag9VPeK+EJepnKMYBd7UR1Fim1gTVVjT/UFzif4Llx
         qDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697659614; x=1698264414;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fV7fTkn3aVtTytg7FjK9RSeuS2ZwMLzGixbs5gWSolA=;
        b=N6pSMnL0qs0xHdl73zQdhwFr/b9m4LqzTcMjrYiVGVeB5sfThOk5SaHMU0kTzyTgOj
         57QxpEo1F95QOyqE5jhVZZCJif01gfJcKxoUXNoqCXqHczGisDK+gFlHehqSrfDBDkaB
         QMOh/W2VspAkVUUPF2GpOZkD7FtBvhoXvq9FfrOQzcVJwP8/etJoumufyg2wSddXyd1y
         X6qSfwgDO0vfSxxhqNSZAh0CZLiIHleoelK+xLIQfB/BZ/Je3ReRE46gBhaiN3CMu76a
         U29q8MgTCV80vMaKJ4pmZbS1vgA5kahQOabSvNkHS8jl/j4JpnuaOs2iqdRH00hHpLCE
         Ba1A==
X-Gm-Message-State: AOJu0Yyv0IEjuzRQyAAeblXXQQtIAtbsP06uxeo7XYm8+kn71jqFOgk8
        Y/zCR/pwNYNuMcBz7d0pN7G2Zg==
X-Google-Smtp-Source: AGHT+IG1Y7dg+9BY88IKn03L6i6fqmO+TD3nURIXN8mg6bV5JruPLssiJqQILJDxYCQmw9MeGFm9rg==
X-Received: by 2002:a05:651c:4d2:b0:2c5:2103:604b with SMTP id e18-20020a05651c04d200b002c52103604bmr33279lji.2.1697659614439;
        Wed, 18 Oct 2023 13:06:54 -0700 (PDT)
Received: from [172.30.205.86] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id l13-20020a2e99cd000000b002bcc303bbffsm817654ljj.104.2023.10.18.13.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 13:06:54 -0700 (PDT)
Message-ID: <8e57d7a7-2441-4056-848d-d8846f45156f@linaro.org>
Date:   Wed, 18 Oct 2023 22:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sa8775p-tlmm: add missing
 wakeup-parent
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231018145750.429385-1-krzysztof.kozlowski@linaro.org>
 <25185346-2d5d-469c-8a88-0f0f9f02a739@linaro.org>
 <56a8ec24-789f-42ae-88ac-cb35693df390@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <56a8ec24-789f-42ae-88ac-cb35693df390@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/23 21:23, Krzysztof Kozlowski wrote:
> On 18/10/2023 19:44, Konrad Dybcio wrote:
>>
>>
>> On 10/18/23 16:57, Krzysztof Kozlowski wrote:
>>> Add missing wakeup-parent property, already used by DTS to indicate that
>>> pins are wakeup capable:
>>>
>>>     sa8775p-ride.dtb: pinctrl@f000000: 'wakeup-parent' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
>>> index e119a226a4b1..2173c5255638 100644
>>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
>>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
>>> @@ -28,6 +28,7 @@ properties:
>>>      gpio-controller: true
>>>      "#gpio-cells": true
>>>      gpio-ranges: true
>>> +  wakeup-parent: true
>>>    
>>>      gpio-reserved-ranges:
>>>        minItems: 1
>> All the properties visiable in this diff sound reasonable to
>> put in the common yaml, no?
> 
> Is something missing from common?
No, I just forgot how the yaml worked and didn't notice
we're essentially status=okaying the properties here..

Konrad
