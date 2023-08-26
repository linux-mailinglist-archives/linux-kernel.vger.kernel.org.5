Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806B178956A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjHZJrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjHZJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:46:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588641FEC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:46:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99357737980so205735066b.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693043205; x=1693648005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEbLos18PAXF+VWDexugVSPY8cGgVPouJFgqeAIgj2g=;
        b=lmCoxeIqztpe+opKBbUijFsC6GOPWVrhtomY78qaM6TlZjVaPJSPk8s5ZlFe61FC7l
         p39cb4dpX1s+D3B0Jnrz9M1ECcH5aO7DTRyZAynGM5icqJjRr+caI80bdPdVM8Uw5+NN
         nIraLLC7pxJAmJt/QEdO7exAcUMsT7DxAnUaheSCaI1U3qsTqzHK68dinbD21gZDajGR
         rpiMi+G5nsu8DTn3+mDwZyD5pepNbhLfnuJ8CCWI2BVJzMQs+oylBtMUuKtL7vF1V+R0
         dryzW4yO1sm0IETnkgkdQ9rKJMt269re2UQrEfOKeCK99vBwCHZE993T2DmaX9r1Epqq
         5bKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693043205; x=1693648005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEbLos18PAXF+VWDexugVSPY8cGgVPouJFgqeAIgj2g=;
        b=fotGPTA/h+lw12cmA6+ajao9s/r39sD3NCAPYMl0ua9K/hCym9SX7Gey/xr1YjCVO0
         Y0pMEuMrQqWB43PMviuojh/0CFi2umO1WdgGpp/d19r5oxf4p+n8UAiVHVYgmJ0P5QGx
         u+sz+F0j/SfeV3/oQylfvyBmvpVR48Eeb1Y+VDJOFNHPHXWzoXyU4iGdFYI4m3w9T5Db
         H2GiCFVaI1mW8HcmO+JFrtpPsgQgqn90OYHiSCj2HnOrtX0OiYQVQ1TkFf6WqO1i/sNI
         ZsJX1jSwFUfJt6G+WhPuH8ZQDMLhjHUefSuek9EXGeKkpJThG50w7oTdV3PR4b0a3tGU
         iL+A==
X-Gm-Message-State: AOJu0YzpZGCis5M8f09TBr6gFp8xrYNJtn/+xR0dceLgk+vENDHVQFcX
        8QkiAILFgeXG61baMcZwkbF2Bw==
X-Google-Smtp-Source: AGHT+IEP7ndTWQOR+5ImclTFoFfHYoXYsPwZTnUGtRVfLr6CS1R55d2YXHpGL89sNFFvaNIT17wSUg==
X-Received: by 2002:a17:906:2098:b0:9a1:dd2a:c2c6 with SMTP id 24-20020a170906209800b009a1dd2ac2c6mr7448605ejq.8.1693043204734;
        Sat, 26 Aug 2023 02:46:44 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090648ce00b0099cb349d570sm1939294ejt.185.2023.08.26.02.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 02:46:44 -0700 (PDT)
Message-ID: <4007687e-1176-cffa-5945-94787fe6d5d9@linaro.org>
Date:   Sat, 26 Aug 2023 11:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,lpass-tx-macro: Add SM6115
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825-topic-6115tx-v1-0-ebed201ad54b@linaro.org>
 <20230825-topic-6115tx-v1-1-ebed201ad54b@linaro.org>
 <1a0dc235-eb44-9923-6206-560199a70d4e@linaro.org>
 <f3c43297-1b05-47b6-a158-5b45df77cfed@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f3c43297-1b05-47b6-a158-5b45df77cfed@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2023 11:37, Konrad Dybcio wrote:
> On 26.08.2023 11:32, Krzysztof Kozlowski wrote:
>> On 25/08/2023 19:23, Konrad Dybcio wrote:
>>> SM6115 has a TX Macro, requiring an NPL clock, but not DCODEC.
>>> Document it.
>>>
>>
>> ...
>>
>>>  
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          enum:
>>> +            - qcom,sm6115-lpass-tx-macro
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 4
>>> +          maxItems: 4
>>> +        clock-names:
>>> +          items:
>>> +            - const: mclk
>>> +            - const: npl
>>> +            - const: dcodec
>>> +            - const: fsgen
>>
>> Are you sure there is no macro? This means there will be no
>> LPASS_HW_MACRO_VOTE vote.
> Yes.
> 
> Do you have downstream sources somewhere?
> Also yes, but they're not public..

Indeed. Looks correct:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

