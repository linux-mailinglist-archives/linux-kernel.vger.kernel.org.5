Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428DD800521
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377777AbjLAIDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjLAIDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:03:07 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F9710FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:03:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bce40bc4aso1990626e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 00:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701417792; x=1702022592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ponRrg7TizGLB9l+GsvRKwNCtFphHDbSfkIhNOwyzeY=;
        b=qSTTH0BAnH0hBpypQL1Pn+L7f00jQtwfIExYddXtA2Q1d/oIDTz+uVKtWXbcpEhJIc
         ICUClYu1R8UYRlAe7rDQm0XXbbR2Zqxo4IwnKIt2ewfswNNw0nHTIxuFdKRHKNS8xXVa
         vddxGb49T4pc9lzlADeQHn0DRKDSSlWnyDxe73EYLzXVUChxTaONGdZZLIDLMdgRxnKE
         nfGoFHPgVMRmbJT04K2n4l+J6Vsdgyo2XMevLlcuOCRuQ7wZ53i356zceLzmRe23Bs6R
         ayJ05/CoTrKiuREC2LerAht6ZM13HxVZhBI+1dIs395zMEXO90ScGV5nWqohzA3B4bWF
         HLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701417792; x=1702022592;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ponRrg7TizGLB9l+GsvRKwNCtFphHDbSfkIhNOwyzeY=;
        b=Yv/G43QW17EBdkYN68M6A8Mnl70qm6mIO9g9WkiCHgFC3oTcRaA9Owa52S0a3R6E/2
         Etfi3b9Tx6PSZw5xvEDeTdKAS13fv7t8iUqx93MhLlFnzSDwfsg/WL2s7AaX0f9qhEWo
         ZLrzzVTbe6cuRYhmRByatx7uEBP8FSjUnwtkduqBA0BeAx6EkEpJUCwJIroIQUUjYpaH
         YQyBSUdxcZTJHXnqtlmgomvkzYJGu//CkzQ58Q4twMSyPOyUD2x2uU7ib6gJM7DH6s1F
         CGABXVvFa3lUKrQwXmR4irmLEvh0DgCrtRrtxtwYxadv0NPktG1SzYDMdbtfOKMq8vkD
         bf3g==
X-Gm-Message-State: AOJu0Yy+MX0bNJFjVcQk5Gr9O4zdKBqyT94Cme4V+O18dRGkQQP+1PmB
        ROVf5vNnYHg0gH+1JGDQwy79pQ==
X-Google-Smtp-Source: AGHT+IHliUm93Ad0LW8i7zaPsiYQdEunXgHDrktGw58FXlDj4H1fGDnGue5fQsTW7Eqp9lAlkp00Vg==
X-Received: by 2002:a05:6512:1596:b0:50b:d764:804c with SMTP id bp22-20020a056512159600b0050bd764804cmr611926lfb.127.1701417791532;
        Fri, 01 Dec 2023 00:03:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c4e8f00b0040b3632e993sm8204509wmq.46.2023.12.01.00.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 00:03:10 -0800 (PST)
Message-ID: <7b9a2f1a-59d6-454c-95ed-6cb920751551@linaro.org>
Date:   Fri, 1 Dec 2023 09:03:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: cros-ec: Allow interrupts-extended
 property
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231130083333.932862-1-wenst@chromium.org>
 <2288442b-9002-4711-9b64-16b204f19985@linaro.org>
 <CAGXv+5HwzSX=x_0u-95i1+q+xbstrCmuMxRoKXJwEL5ErnRgOQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAGXv+5HwzSX=x_0u-95i1+q+xbstrCmuMxRoKXJwEL5ErnRgOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2023 05:37, Chen-Yu Tsai wrote:
> On Thu, Nov 30, 2023 at 4:52 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 30/11/2023 09:33, Chen-Yu Tsai wrote:
>>> "interrupts-extended" provides a more concise way of describing external
>>> GPIO interrupts.
>>>
>>> Allow using this instead of "interrupts" plus "interrupt-parent" for
>>> cros-ec.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>>  .../devicetree/bindings/mfd/google,cros-ec.yaml          | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
>>> index e1ca4f297c6d..e514eac9f4fc 100644
>>> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
>>> @@ -75,6 +75,9 @@ properties:
>>>    interrupts:
>>>      maxItems: 1
>>>
>>> +  interrupts-extended:
>>> +    maxItems: 1
>>> +
>>
>> I don't understand why you need it. You already have interrupts there,
>> so this is redundant. I suggest to drop the patch or provide real
>> rationale (which I doubt you can get :) ).
> 
> I'm sorry, I should've included this in the commit message.
> 
> The other half of the patch gets rid of a DT validation fail when
> interrupts-extended is used instead of interrupts:
> 
> .../arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dtb: ec@0:
> 'interrupts' is a required property
>     from schema $id: http://devicetree.org/schemas/mfd/google,cros-ec.yaml#
> 

That looks either like a bug in bindings or in dtschema or in your DTS.
This patch should not be needed to solve that.


Best regards,
Krzysztof

