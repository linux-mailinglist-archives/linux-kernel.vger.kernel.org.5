Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A128757628
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjGRIDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjGRICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:02:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BC71993
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:02:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e5d9e20ecso7666544a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689667323; x=1692259323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsIxNK0J5zdm7hoTGkqELX9EdWQda/w8CE55dNKdQBI=;
        b=KdKmYaQBSFl0lVylZviXy1L8wRpdutlz6y72k+fhKifuidOimyIzONwkAlJbbhNg2t
         c309jLRA4Gz0xvuIe5hAvQ5u3av8x+NIxbiDYlcj15j33wCU8fmcDvTVoP+G7sn6dFRe
         OrZsPE6+5bCs5lTumVNLsZ2fhSyz7ea2Zdx2nf9YyQaPcK/f6rBEWvraSSJfbQrMmfbd
         RAOPRMzYs3epeWJIUYd96XrCUsPPOhYlx7eRprG7Vf0f+JmMoCtMDPNGWTnM6F6qScL7
         0pMeFnnOv8lEmoaMNA93mHM6GCZKDsvDxvjbOysnhP5nGgHUKz95LCy1K6n7iEKTSseW
         VOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667323; x=1692259323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsIxNK0J5zdm7hoTGkqELX9EdWQda/w8CE55dNKdQBI=;
        b=S/nP65kVXYXWxPNb4ujuWa8tz3ZKlSuCWIJRvm309CfSO3r64cZDEqcUayqPT1zT3e
         flSV45E3UfP8zlA/3OmLmUIIgZ/wC1Y3urlAxIhuOhP1HJCNwqAcUGH8gtYPfBw8qRiI
         s5V5Ye16X37S7/J6md5U0RUP/nqnTeSmRi2z+QhF7HT+8IPrNojWdzWMdN/9yLJLz6sZ
         hBBF9RSJQNJ+dgYs/F4Rjb50rOQ3oeyWd2G3ps62c3kYaryaKWd67tFVwR1I3T6v4VJ2
         cx3G0Gl5KjCx+ZBvDhHJpfHOSOnhWZ2OX0eLlSFkMrWWwlDOW2+5AXPtPW2b1A+XVnlI
         pdsg==
X-Gm-Message-State: ABy/qLbCTldAUNIPf9wJIUtZL/Lb1/FURm46O4aV1JWEaQPcB/01EC4u
        7rijD6JYHrAAplsksC6kNpNhGw==
X-Google-Smtp-Source: APBJJlFW9DT9BZsr+XSPA2vB4OYCmyLRfrxqABO39xqF1LRjNNFkSnkQk8GPqJZQvi8LFGtx8O/ekQ==
X-Received: by 2002:a05:6402:68b:b0:521:94f0:9987 with SMTP id f11-20020a056402068b00b0052194f09987mr4209464edy.37.1689667323562;
        Tue, 18 Jul 2023 01:02:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u25-20020aa7d899000000b0051e19bf66a4sm804060edq.83.2023.07.18.01.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 01:02:03 -0700 (PDT)
Message-ID: <dd5864ee-7df2-eb64-c7f2-0fb234900d6a@linaro.org>
Date:   Tue, 18 Jul 2023 10:02:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: input: qcom,pm8xxx-vib: add more PMIC
 support
Content-Language: en-US
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
 <fec38f3a-f103-ff0f-138c-cffa3a808001@linaro.org>
 <4210b137-2d5d-a467-ea8c-d047701fdcc2@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4210b137-2d5d-a467-ea8c-d047701fdcc2@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 09:59, Fenglin Wu wrote:

>>> Just FYI,the change log was updated in the cover letter here:
>>> https://lore.kernel.org/linux-arm-msm/20230718062639.2339589-1-quic_fenglinw@quicinc.com/T/#m3819b50503ef19e0933a10bf797351a4af35537f
>>>
>>> Also the commit text and the driver change were also updated accordingly
>>> to address your review comment by removing 'pm7550ba-vib' compatible string.
>>
>> Removing compatible was never my feedback. Did you read:
>> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
>> ?
>>
> Okay, so do you want me to add 'pm7550ba-vib' as a fallback compatible 
> like this?
> 
>   properties:
>     compatible:
> -    enum:
> -      - qcom,pm8058-vib
> -      - qcom,pm8916-vib
> -      - qcom,pm8921-vib
> -      - qcom,pmi632-vib
> -      - qcom,pm7250b-vib
> -      - qcom,pm7325b-vib
> +    oneOf:
> +      - enum:
> +          - qcom,pm8058-vib
> +          - qcom,pm8916-vib
> +          - qcom,pm8921-vib
> +          - qcom,pmi632-vib
> +          - qcom,pm7250b-vib
> +          - qcom,pm7325b-vib
> +      - items:
> +          - enum:
> +              - qcom,pm7550ba-vib
> +          - const: qcom,pm7325b-vib
> 

Yes

Best regards,
Krzysztof

