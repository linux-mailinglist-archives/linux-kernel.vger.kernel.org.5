Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5877A1A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjIOJLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjIOJLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:11:37 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043B730C4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:11:04 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bf78950354so30836081fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769062; x=1695373862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqTeh00riXaBjNescHiFGhXjL1S5jjpClV66tpjmVfI=;
        b=nTkLXp/iw5Jy5fMjZkKVR6u37u+mb7TFRgJFat0bWpDakMZ5uxj2CMA57CyRU8W715
         0QIZ7op9VNMaleh+msQrvCf2iS4UgPOXfG8vJtDNMyaNbUv1FZ84ZkCM/TsE/bdtksRj
         vc9gJN80R1kub4L72NDUdl4lMSmpyJw50Fi5cFfPfEZ+9EotYy6CRPAAh6R1Om+QAsy+
         vUMSdIFb10Mb7qzFEOloLrpQNrzV1VCy9kF4EKAb/fCVNRi4JhczR2unqYqg3jiC2dhM
         BkH/aKo5xesgusbDsIl/OfWS67E+CRPNHWhjmA7I0QHDAYI4jT+7DTjBaPVhiZHQvzxw
         edhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769062; x=1695373862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqTeh00riXaBjNescHiFGhXjL1S5jjpClV66tpjmVfI=;
        b=bcpsiF+Ke48zGyV9G75K3nCUaiJyhZLtmGmXo1lPzZtjL7x1c6HL+DzwvdIiFebT2N
         faxHgrRbi3GTIajaz7kzw/Xw4VG+rM5A02G8tUpwRRGZp7Yk3oNGhFa4+E69R5T/4AQ6
         iTOPfe+ILrI9B07yvL87o0yyZBpS2FwMzY7MI/0Qb4SZdzYkqsjEjZKX5e/zsl5Nn+CT
         c4z9Y0Sg2nvLMqkWMFDMpuO1lXn/zWuqd6ZAV0Wit9AFWF20BqzIWW0i3uuCf5kgRBaL
         C0Y43Dl5E/ahEV76Xvl8WEnkHsX40PGh286+G+UYmaT/yRzxRoM0sbR2RHKDib/l0yEa
         NjwQ==
X-Gm-Message-State: AOJu0Yxu9Zbyvj6IrlqVm/LCf8jGhWZkctThf5Zyh1YcOAWj/NV7bbHs
        krT3E8yKRTksGv/La2MfdSOGxw==
X-Google-Smtp-Source: AGHT+IHo7+SxnYzd0/bI0C3S/ETu/ji64wJvleV9efcp2lx53ggD6d7oaLyfrVGa7I3B7WTP908rSQ==
X-Received: by 2002:a2e:8ec1:0:b0:2bf:cbff:7017 with SMTP id e1-20020a2e8ec1000000b002bfcbff7017mr1089791ljl.11.1694769062001;
        Fri, 15 Sep 2023 02:11:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id oq14-20020a170906cc8e00b0099e12a49c8fsm2142599ejb.173.2023.09.15.02.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 02:11:01 -0700 (PDT)
Message-ID: <e026878f-9303-4cae-bcab-7ee69e32db2d@linaro.org>
Date:   Fri, 15 Sep 2023 11:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/8] dt-bindings: arm-smmu: Add compatible for SM4450
 SoC
Content-Language: en-US
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
 <2c42d2b6-a838-4d8e-99f1-c08b0c8e4457@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2c42d2b6-a838-4d8e-99f1-c08b0c8e4457@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 09:15, Tengfei Fan wrote:
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
> yes, I saw this "DON'T" comment, but if I remove "qcom,sm4450-smmu-500" 
> from sm4450.dtsi and this arm,smmu.yaml, will get DT check warning about 

Why would you remove it?

> this, this warning cannot be find after add "qcom,sm4450-smmu-500" from 
> sm4450.dtsi and this arm,smmu.yaml, so update this patch again.

What does the comment say? Why are you adding it to the enum which asks
- do not add to this enum, but add to other above and below?


Best regards,
Krzysztof

