Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B372A757531
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjGRHUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjGRHUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:20:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58ED115
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:20:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99313a34b2dso644340366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689664810; x=1692256810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w9lU547pQxoXPTCiKCeGs33MoErEECshjjhbexSYDSI=;
        b=fUtFEe8pr2uAkgpj5yltLux0H1Y1EGtwKZsU5EQ+lBRmIYPa0Klnfi6G3zKHyO2GmQ
         Q+bvPYf0eGE9Yh9Pu7Fp+Aygwom6zg6kEVbUoYXyhJynOUc+phBCZOZvJkqcFv16H67J
         AW8fqMyRl7J1cHF72cSTuNZwOlTQRCGuITp5RkWF7poLeczB3k9UjvogexYzpwcFeGhg
         +Zaiwfzj2HRIFEgNvwxRygR4wpYxntCf5WLyMzJTcXUryMc8ZDqoCO2v223tuSqMxvQG
         8lGLLEmodgs5cBRJhOVEx21Zo+l9dW9r0xhidZA2cGMcCmmo5G7JFVHjtLzQhOkWfxdW
         xsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689664810; x=1692256810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9lU547pQxoXPTCiKCeGs33MoErEECshjjhbexSYDSI=;
        b=YcOOAY8gzRjU/sjLxwIhNOKHTJU42Jez5zNvwl3o6K+YpBQC6xHEoIwaukpRZEN7Qx
         3J83fvvhb8gVi+MQ07y7Ix7JoJrYfAGF4NvZcht4U1xzoSz6uKxcsyk/z/GDzN3wE0wk
         /aDCqCHc0JQmuaTSmTHqaEcRytxJcBHnA8OcyQpGJLGQuMYWAR9J4+ZcTlikel6F1KnS
         OGdSqIbfDjYbY/HBkrb/GemNHBdMzm05zeCtKeFvQOra8gP8DAWWVbR8lqrE3R27fGll
         mLUw1cwzXx6l0ny0cWgAJOogLgSh5mv5mSn23nUEyCwWPA8Blx5HCsYYW5X4m47ldEIN
         lwyQ==
X-Gm-Message-State: ABy/qLZ9mAxs663NPoKli1VD2QGeH+/fc/7ePFvbyQXCdlkvLJ9qnbXF
        pxhAQ9DuVyuaXZbhWCg67QZzoQ==
X-Google-Smtp-Source: APBJJlHozXmVdS49WlvakDj4YokD/ymIOY7jP3ESI0KcELq/33VrcfhD9G6domk0ypAzc9GCGgVBOw==
X-Received: by 2002:a17:907:7656:b0:977:4b64:f5e8 with SMTP id kj22-20020a170907765600b009774b64f5e8mr13375774ejc.57.1689664810412;
        Tue, 18 Jul 2023 00:20:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z12-20020a170906240c00b00977eec7b7e8sm652041eja.68.2023.07.18.00.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 00:20:09 -0700 (PDT)
Message-ID: <fec38f3a-f103-ff0f-138c-cffa3a808001@linaro.org>
Date:   Tue, 18 Jul 2023 09:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: input: qcom,pm8xxx-vib: add more PMIC
 support
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_kamalw@quicinc.com, jestar@qti.qualcomm.com,
        quic_huliu@quicinc.com
References: <20230718062639.2339589-1-quic_fenglinw@quicinc.com>
 <20230718062639.2339589-2-quic_fenglinw@quicinc.com>
 <cb534cdb-508e-b03e-4e39-50cd6654377a@linaro.org>
 <4cb9f443-bdea-695a-f1b7-3963747e9a17@quicinc.com>
 <5b7e624b-5d06-826d-92d1-2a721b7c83b7@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5b7e624b-5d06-826d-92d1-2a721b7c83b7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 09:06, Fenglin Wu wrote:
> 
> 
> On 7/18/2023 2:38 PM, Fenglin Wu wrote:
>>
>>
>> On 7/18/2023 2:33 PM, Krzysztof Kozlowski wrote:
>>> On 18/07/2023 08:26, Fenglin Wu wrote:
>>>> Add support for vibrator module inside Qualcomm PMI632, PM7250B, PM7325B
>>>> PMICs.
>>>>
>>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>>>> ---
>>>
>>> I don't see changelog. No changes then?
>>>
>> Sorry, I updated the change log in the cover letter which didn't seems 
>> to be sent to a wider audience, I will resend it by adding more 
>> receivers in the to list
>>
>> Fenglin
> 
> Just FYI,the change log was updated in the cover letter here: 
> https://lore.kernel.org/linux-arm-msm/20230718062639.2339589-1-quic_fenglinw@quicinc.com/T/#m3819b50503ef19e0933a10bf797351a4af35537f
> 
> Also the commit text and the driver change were also updated accordingly 
> to address your review comment by removing 'pm7550ba-vib' compatible string.

Removing compatible was never my feedback. Did you read:
https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
?

Best regards,
Krzysztof

