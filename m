Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B49776484F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjG0HTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjG0HSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:18:32 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312CD5584
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:11:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5223fbd54c6so783504a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690441819; x=1691046619;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JYep43itLi484JjMyR1Wqkn5aeEi0wNHqtDvsnoQYt4=;
        b=RaE6n6Gunpftj1GFdzPxvEQGGy7My9xgpFOh6jjNMx/KowsR5Y0kSZkZRQL09KuQYC
         zMCxNx9RFmxzi6qI4yJB4CoMLKhrBvtSSQJGHPVUedhxrUCDByurJNzpVJgl5Q0QTKcz
         /x4UIDy91I8FGK0knJdeG9Z3ldoMfts5Y27ixiYbYFjg2vJmxGMEmDAKle9APuEZZ/NO
         F93o8Vw6H4WoTV+RMzhCB6N+7/qNDvLXr1k/op93IGLdQUNTwxCzxthxHrUdkfpps74i
         gq8X0GNB97I9HuWAVUX2/Q7O1yk+ooPfMHzFcjvXaH57X2hahZQbRjLbWXNGu6B896mE
         hsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690441819; x=1691046619;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYep43itLi484JjMyR1Wqkn5aeEi0wNHqtDvsnoQYt4=;
        b=OPplyU1V8ZV2D3o9dE7Uk7Sh0ywhX5SyW6f5Vyb4pJR7bb0wj6ap4yzbTePIzKzddZ
         4mfXdEy8O/FD+zQbDUk3YzEVMREu3UsfgtVqMBB/QqsKxH5eYUj4zyvAMiuZijIjNDx6
         Y2XoaSguHYP/7UcEv2AwsBsE69D0Jh0RNVm93ukjqBeDbDw8sHLGZmSR++RAnBu9rmFw
         BOHaK72QHlhTQl3mz1qVBVVFgS2tuRPazBJl6LSDlzpbsV0oh8+7i44hWNUJIqnhazQE
         2pxEdnQFtZkj8tZQMHoA6urOHpCxzNsprOFi5GmNV63wfsZrMnkWGuiBN5KG87kf1A3z
         JxZQ==
X-Gm-Message-State: ABy/qLZnyRS1nSjdWQe6Wr08DXVSh7k2oV4JHTsbBluWyw8DqKE6BhZp
        cmcIy143G5krKJzpc54ZF7SXSA==
X-Google-Smtp-Source: APBJJlFreRkEmmdoQULIo/F/9SCFJqDWq8XA7O8D6UDXTNRm9pXQfR/6rmweX5nXwqD4Bz+951NBMA==
X-Received: by 2002:aa7:d689:0:b0:521:d23b:f2c5 with SMTP id d9-20020aa7d689000000b00521d23bf2c5mr1110718edr.14.1690441819273;
        Thu, 27 Jul 2023 00:10:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a18-20020aa7d752000000b0051dd16f7e50sm310445eds.44.2023.07.27.00.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 00:10:18 -0700 (PDT)
Message-ID: <2fa3f27d-ff08-b923-2fb1-cf7cc888e5d5@linaro.org>
Date:   Thu, 27 Jul 2023 09:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: input: qcom,pm8xxx-vib: add more PMIC
 support
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <dd5864ee-7df2-eb64-c7f2-0fb234900d6a@linaro.org>
In-Reply-To: <dd5864ee-7df2-eb64-c7f2-0fb234900d6a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 10:02, Krzysztof Kozlowski wrote:
> On 18/07/2023 09:59, Fenglin Wu wrote:
> 
>>>> Just FYI,the change log was updated in the cover letter here:
>>>> https://lore.kernel.org/linux-arm-msm/20230718062639.2339589-1-quic_fenglinw@quicinc.com/T/#m3819b50503ef19e0933a10bf797351a4af35537f
>>>>
>>>> Also the commit text and the driver change were also updated accordingly
>>>> to address your review comment by removing 'pm7550ba-vib' compatible string.
>>>
>>> Removing compatible was never my feedback. Did you read:
>>> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
>>> ?
>>>
>> Okay, so do you want me to add 'pm7550ba-vib' as a fallback compatible 
>> like this?
>>
>>   properties:
>>     compatible:
>> -    enum:
>> -      - qcom,pm8058-vib
>> -      - qcom,pm8916-vib
>> -      - qcom,pm8921-vib
>> -      - qcom,pmi632-vib
>> -      - qcom,pm7250b-vib
>> -      - qcom,pm7325b-vib
>> +    oneOf:
>> +      - enum:
>> +          - qcom,pm8058-vib
>> +          - qcom,pm8916-vib
>> +          - qcom,pm8921-vib
>> +          - qcom,pmi632-vib
>> +          - qcom,pm7250b-vib
>> +          - qcom,pm7325b-vib
>> +      - items:
>> +          - enum:
>> +              - qcom,pm7550ba-vib
>> +          - const: qcom,pm7325b-vib
>>
> 
> Yes

I wonder why this approved change turned out to something incorrect in
your v3 patch...

Best regards,
Krzysztof

