Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A9F7A1A02
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjIOJKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjIOJKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:10:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053E5E69
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:10:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9adcb89b48bso73882566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769018; x=1695373818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mYurZD8ziFDRqchUnDGZKwBbS/2WFyHG5fbkvlBT2g=;
        b=y2egOUR7CBlYVvpxmSRZqvPR+KaLj4XccMALmTsyYJaqGm5HGsEpW4ew2434N57fgf
         vGxqWsS3gNosTYbR6abFVkU7lv/j/kOQy8+p+PwW/qiSnCXPXJWuAoX6KeDZD3XxM7qz
         emFK6JC7xChlRpVIgBl8DOQaZzEKECjIWl0LNQWHKzr3U6ZzYyixG/cFlBrelnl9sEtm
         fugh1XwC17qYVPRuMQodWe9fPK03x4TS/jClmqWp0QCMInrLEB7BLmjwGFCesvJxwv+q
         E/kj+o2U4aEefuX6hAHjFi72DmTmj3QSh+baqttVIY5nkw4lE6AUUikDu6jbrex/CatE
         +pdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769018; x=1695373818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mYurZD8ziFDRqchUnDGZKwBbS/2WFyHG5fbkvlBT2g=;
        b=PT2Z1aKk9aWGad40D3ZnV3Uybwlg8rLVxcHgMOSjHlTa3TsvSkcym37Jthzr5eSYp1
         AHwfa0TyeR432UeQsh/kWrbfBtwRWxAlkPcTK4VHblgHfMJDYR0w821MZq+/JatTmHwc
         TU6lqDmtobcHuSLp8ME3vv1Kysa9UBk3q2/7HZyGCbAr+MeQv/1IYd4uiUOZOyQ2T25I
         IVkh7UvpSFE99ijezO3gZW9PJzhdy1aaAXsDHSNB8Mz2ZQhG3RjMW1zJ4ldz+jBx8U/5
         n1oXE/DfcB/ZCYPBPJz0wk/+LtUEiVtoqoiQT1Adf0UFFdcNVKSzmT+uH1SUlzcemBLn
         xCkA==
X-Gm-Message-State: AOJu0YycIchddX1och2+xY0p5byBJ+oq4OvdDuSp5kITK3tkLkeh/si7
        07YNRIf9WcIoiKE7on3sbskIyQ==
X-Google-Smtp-Source: AGHT+IHiXgvnk9181h78AWvJiNP0aier6ytGOVVosZgBZ7n55wGrwTWePBUH316xtZO8twLna74yjA==
X-Received: by 2002:a17:906:54:b0:9ad:78b7:29ef with SMTP id 20-20020a170906005400b009ad78b729efmr787901ejg.57.1694769018446;
        Fri, 15 Sep 2023 02:10:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906345600b009a9fbeb15f2sm2120791ejb.62.2023.09.15.02.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 02:10:17 -0700 (PDT)
Message-ID: <f932d000-e328-3267-33ad-f3555a6689fb@linaro.org>
Date:   Fri, 15 Sep 2023 11:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/8] dt-bindings: arm-smmu: Add compatible for SM4450
 SoC
To:     Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        catalin.marinas@arm.com
Cc:     geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-3-quic_tengfan@quicinc.com>
 <5a386be4-facc-8aef-aad7-da6508aa0505@linaro.org>
 <c993ecc1-771e-4061-bd10-d3dea1254389@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c993ecc1-771e-4061-bd10-d3dea1254389@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:52, Tengfei Fan wrote:
> 
> 
> 在 9/15/2023 3:11 PM, Krzysztof Kozlowski 写道:
>> On 15/09/2023 04:15, Tengfei Fan wrote:
>>> Add the SoC specific compatible for SM4450 implementing arm,mmu-500.
>>>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> index cf29ab10501c..b57751c8ad90 100644
>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> @@ -47,6 +47,7 @@ properties:
>>>                 - qcom,sdx55-smmu-500
>>>                 - qcom,sdx65-smmu-500
>>>                 - qcom,sdx75-smmu-500
>>> +              - qcom,sm4450-smmu-500
>>>                 - qcom,sm6115-smmu-500
>>>                 - qcom,sm6125-smmu-500
>>>                 - qcom,sm6350-smmu-500
>>> @@ -70,6 +71,7 @@ properties:
>>>                 - qcom,sc8180x-smmu-500
>>>                 - qcom,sc8280xp-smmu-500
>>>                 - qcom,sdm845-smmu-500
>>> +              - qcom,sm4450-smmu-500
>>
>> Isn't there comment just few lines above your edit? Comment saying DON'T?
>>
>>
>> Best regards,
>> Krzysztof
>>
> Hi Kraysztof
> I seems haven't understand your comments totaly.
> I want to confirm that if you think only need "qcom,smmu-500" and 
> "arm,mmu-500" compitbale name, needn't specific compitable name for each 
> platform?


No, please read the comment. It tells you explicitly what to do - which
compatible add where.

Best regards,
Krzysztof

