Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D15793CEA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbjIFMoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjIFMoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:44:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9DA1721
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:43:59 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-501bef6e0d3so2906008e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694004238; x=1694609038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZjPlBqgnDQzIPB5KuAwzX6y/nfJycbmx8H+lJxBo78=;
        b=ri/F0L/fo2e2r+1K7sP1+QtDiGO4oZbCfC0XH1I2fVXDoWmRDmIWZ8cykRfYgoBm5F
         P36AzB2jAarNxNB1DSP85TtKgHdmfP0vLaBVRsDMOLeofGTqrNP41mTpdyZ+FpPfs73R
         1f0mdJFfy5XafL7Rj9YzlT9qBi4bPIHRwqt4QiOYeJsqq4g4oLFbkG7RlV7C5j2rlfTf
         1vCAMYZ5JaOuarF2/TDXptr5qEq3O4fmc41a12nRfsoAt/blmE8j3YwSxFqfCFmoKDyf
         FuRZHgb8DnzRg75aUstdrYP6oR84WURHK08NqA/Y8fYCoGptOCCEaSRhvizFgcCvmXxo
         jK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694004238; x=1694609038;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZjPlBqgnDQzIPB5KuAwzX6y/nfJycbmx8H+lJxBo78=;
        b=b5kOLmV32A/m9Z9utTbtevcvyvZg6pOkqy6gDISR4r6/vmAkYWq25iRaecuRp8Tqit
         HMRV1JX3WlhP/O7vpz7tHCNhQIrKEG5vM3zXS7iDpjg0kHUudGb0iMWdrp+G8hfrosNJ
         HLe3/J8W21yfUzJK+udZlE0RmgHZdLTytvU/3jVtDvJsk22prBMHFy3PD7G6YN/w7E2W
         Bkoz5JixJDN25AnSSu2tbDcE2hfgOgOOU1E+xsprhVHIGgTTknF0bfPF5qPuf91yrPtK
         wcekTve1zQd1NBw+XJcUb3k+C91gZnSzlxHfTtCe3s7Yow17w8jHpOsEM3MC3ojeZLMQ
         rY2Q==
X-Gm-Message-State: AOJu0Yx7rSuxtb2m4dKl6XlBJ0hl9fgO04M7HGKgBCmK+WQn8ECREnnZ
        CxI/RJELHLSL9PnFS6fYMeOJJg==
X-Google-Smtp-Source: AGHT+IFRWlzlHNwcMzhjaCekHtz8y2GT5557IniLJLUxSqX4REkvEuvBZ/WhKLTSC9YTYVzWnzvPyQ==
X-Received: by 2002:ac2:5457:0:b0:4fb:8948:2b8e with SMTP id d23-20020ac25457000000b004fb89482b8emr2271482lfn.8.1694004237744;
        Wed, 06 Sep 2023 05:43:57 -0700 (PDT)
Received: from [192.168.37.154] (178235177204.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.204])
        by smtp.gmail.com with ESMTPSA id ko18-20020a170907987200b0099de082442esm9022170ejc.70.2023.09.06.05.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 05:43:57 -0700 (PDT)
Message-ID: <77f3e252-5209-44e8-83ed-2a578c5a94d4@linaro.org>
Date:   Wed, 6 Sep 2023 14:43:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/53] dt-bindings: interconnect: qcom,bcm-voter: Add
 qcom,bcm-voter-idx
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Mike Tipton <quic_mdtipton@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
 <20230708-topic-rpmh_icc_rsc-v1-2-b223bd2ac8dd@linaro.org>
 <68fb8e22-dd23-d4bf-eda0-444039fd8e26@linaro.org>
 <9201cb8d-845a-b5dc-02a5-9633572b5877@linaro.org>
 <f393324f-c9ec-1572-fb15-1856cef9d846@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <f393324f-c9ec-1572-fb15-1856cef9d846@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.08.2023 23:21, Krzysztof Kozlowski wrote:
> On 15/07/2023 17:09, Konrad Dybcio wrote:
>> On 12.07.2023 22:43, Krzysztof Kozlowski wrote:
>>> On 11/07/2023 14:18, Konrad Dybcio wrote:
>>>> In order to (at least partially) untangle the global BCM voter lookup
>>>> (as again, they are shared throughout the entire system and not bound to
>>>> individual buses/providers), introduce a new required property to assign
>>>> a unique identifier to each BCM voter.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  .../devicetree/bindings/interconnect/qcom,bcm-voter.yaml       | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>>>> index eec987640b37..09321c1918bf 100644
>>>> --- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
>>>> @@ -38,8 +38,14 @@ properties:
>>>>  
>>>>      $ref: /schemas/types.yaml#/definitions/uint32
>>>>  
>>>> +  qcom,bcm-voter-idx:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +    description:
>>>> +      A globally unique predefined discrimnator, identifying each BCM voter.
>>>
>>> s/each/this/ ?
>> Right, this makes more sense
>>
>>> If I understand correctly, there might be more than one instance. The
>>> problem is that I cannot find such case in upstream sources.
>> I don't think there can be more than one per RSC.
>>
>> SM8550 splits some RSCs into "channels" and these channels have their
>> individual voters, however they would still be attached to these
>> channel subnodes/subdevices and no, we don't support that yet.
> 
> Then shouldn't this be one number, not an array?
> 
>>
>>>
>>>
>>>> +
>>>>  required:
>>>>    - compatible
>>>> +  - qcom,bcm-voter-idx
>>>
>>> This should not be really required, because it affects the ABI.
>> Hm.. can I deprecate lack of it somehow?
> 
> In general: no. Anyway, it depends how much you need it. Breaking ABI
> might be justified, but I just did not get such need from the commit
> msg. Your commit msg looks to me closer to a cleanup.
+ Mike

Yes and no. But mostly yes.

The current way of depicting the BCM voter as a child of the RSC
is rather stupid. Think of the discussion that we had with
Bartosz about adding child devices to SCM only to bind Linux
drivers.

The "voters" are totally a Linux software construct - there is a
piece of hw called BCM (Bus Clock Manager) to which you send votes
through the RSC (Resource State Coordinator). Each major subsystem
has its own RSC (APPS, display, pcie on newer/compute, camera
starting from 8550 etc.) that you submit these through.

Currently the bcm-voter driver provides a structure where vote data
is stored and everything is concluded with a pair of rpmh_write_batch
(one for wake-only and one for sleep buckets).

After reading what I just wrote, maybe we can just reference the RSC
directly. Or in the aforementioned case of 8550 CAMSS RSC having
multiple channels per RSC, its subchannel.

Perhaps this cleanup should be extended to get rid of this subnode.
Or maybe even the driver, or part of it.

Actually, I need to think about this a bit more, as we also need to
reuse half of BCM voter logic in the Adreno code (to shove the
generated RPMh commands into the GPU Management Unit which pokes at
RPMh on its own)...

I think Mike should comment on this rather incoherent monologue of
mine..

Konrad
