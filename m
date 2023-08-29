Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3885178C185
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjH2Ja6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjH2Jav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:30:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE4B1B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:30:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso6033569e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693301408; x=1693906208;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fs0Qm2hgmSFBZX49jDZZ+9ucPaImXV3DE2a4D54Z0Gg=;
        b=FbWUpEDjTAM06Bsz+cziHfBtlrfQcqSWLqHKiNZ01G0yGCG8ylPXmOluZtav73Z1xs
         1+jkCAcK8sSRLyzZPK4qCYBpCN3nC+QloLWBKZrif+zxKuzMIzXrJAyiMxIi8BTeZUTc
         5nxidoGwH9y3ZlCyVG6EYoDZgRtrHtmIGpSAHkTdo1RI1vUKLT1+RY8DRTQqAi/XJj4T
         yYYXqZWj201E5JGP9CmbWM5Gg4wX7TpQCpRg/uDkaZqPJ1S6iMbMNlMm6SEdzbWBBce0
         1dV+GcrhdK62t8DtCgEx2B3gb8pdUhsxLMnaKZafNwDFsbzm0aKI60RrkHJi8j5d+kRx
         ptrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693301408; x=1693906208;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fs0Qm2hgmSFBZX49jDZZ+9ucPaImXV3DE2a4D54Z0Gg=;
        b=I9GIM5qZwLNl178EdDYE56B5S1fgFoz2AcOcJlMkkPULt709Ydn7atwt7p/lLM3Gfe
         niDozIyhUGBtBXoDTSy+3R9VqcmkrX0PjFpMeWClHlVy3913JrutmT8Yp0LoH4xsrHG0
         ZTVq3OjoNii/HuKsx3/A2hMzcIVeCVG66DEKw2/F5BjC2RoUJY/QwL90ZZytqjYOyy0D
         8ElQagH2Up9HOJFlaD0cjTbADVlXwriWAA4/BbH4kn695SRbV/lGuj6jFsK4OCE+f2wp
         4Ih0gGGH8q4kjmdpsrA+EtIg9y4t8febGWUUUltDnBprnhQlhawYDdxnXMrjalogSfws
         vBxQ==
X-Gm-Message-State: AOJu0YykEzCKhDAfaQSH638xhAjDtE/Je99SqBk0LeMtSBbczbrY3xP+
        62OD0VYv44CAw43f0kTezU58cQ==
X-Google-Smtp-Source: AGHT+IGiKrfe39DpEJJDgBpHFcrpdUzNujr0HxpfocS8WbOkZLWHBzqF8FKsVXUN1bu7DP/+53e9lg==
X-Received: by 2002:ac2:52a1:0:b0:500:bffa:5b85 with SMTP id r1-20020ac252a1000000b00500bffa5b85mr1614334lfm.32.1693301408382;
        Tue, 29 Aug 2023 02:30:08 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id o21-20020a056512051500b004ff8f090057sm1900561lfb.59.2023.08.29.02.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 02:30:08 -0700 (PDT)
Message-ID: <48feda07-525d-4319-ba09-14928ab1fd29@linaro.org>
Date:   Tue, 29 Aug 2023 11:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] dt-bindings: document the Qualcomm TEE Shared
 Memory Bridge
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-6-bartosz.golaszewski@linaro.org>
 <9b69a4a6-b011-f0e8-217f-5f91d9a00382@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <9b69a4a6-b011-f0e8-217f-5f91d9a00382@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.2023 10:02, Krzysztof Kozlowski wrote:
> On 28/08/2023 21:25, Bartosz Golaszewski wrote:
>> Add Device Tree bindings for Qualcomm TEE Shared Memory Brige - a
>> mechanism that allows sharing memory buffers between trustzone and the
>> kernel.
> 
> Subject prefix:
> dt-bindings: firmware:
> 
> 
> 
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
>>  .../bindings/firmware/qcom,shm-bridge.yaml    | 36 +++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml b/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
>> new file mode 100644
>> index 000000000000..f660962b7b86
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
>> @@ -0,0 +1,36 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/firmware/qcom,shm-bridge.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: QCOM Shared Memory Bridge
>> +
>> +description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
>> +  Qualcomm TEE Shared Memory Bridge allows sharing limited areas of kernel's
>> +  virtual memory with the trustzone in order to avoid mapping the entire RAM.
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
>> +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - qcom,shm-bridge-sa8775p
>> +          - qcom,shm-bridge-sm8150
>> +          - qcom,shm-bridge-sm8450
>> +      - const: qcom,shm-bridge
>> +
> 
> Looks quite empty... Why this cannot be part of qcom,scm? IOW, why do
> you need new binding if you do not have any resources here and the block
> is essentially feature of qcom,scm firmware?
Since it's "discoverable" (via retval of an scm call), I'd second the
idea of probing this from within the SCM driver.

Konrad
