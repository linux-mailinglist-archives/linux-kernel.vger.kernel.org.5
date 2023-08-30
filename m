Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F65478DB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbjH3SjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245261AbjH3O63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:58:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91511A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:58:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso737284166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693407505; x=1694012305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLDIxOJaEszasiCn1zcMVYnWQkwKtpMOaSPTUz6xA1E=;
        b=eh4ssLoH8099Kx8G3/qkDV7kqk3McS4IlJZ7glfOW+jX61IM4ggmU9zOb5TmN2c/MI
         xIRKvM8aYiDTCvbqJiaV4ainKNL8jHFJX3acf0Ia7yTnoELl29DPJ+S10+hroi2/SHeT
         oiS/nw6DUkQekpV0Xuaj9vrZt9FAXqcDEY8v5KR0JGw90M1FUT514RliveyFCKy8h+bF
         QPcVaFKJ8Q8W4kf/8TOlIJU47lprirUeuA30e7VJXEbWjCNkUi5uoE4M1fHMIP2QhOfP
         5iDDUxSgjSvsVCsDYJg3jAGYuscJ02qojK5wmrz2fdmFMn0WWNTrEqtM+4S//6YUz/Ta
         Vl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693407505; x=1694012305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLDIxOJaEszasiCn1zcMVYnWQkwKtpMOaSPTUz6xA1E=;
        b=ViAIMQ1HYWc38xlB7hZbprff2R8S2w4CHypjRCtcmSBFZG/8BDX9obAeZ4lqHMh9LN
         LOvo5XSW0Viquu6S6Iu4BNxhlT/LVta922snhhXzqyRc8oA3cyoMuVhLErTZFouISqC3
         zL6ONHR9pufGDyETewutFlbCmaynwIiqx9yjlsEnd97ACgBakoWKIBT4HXb49PYb2aS+
         6YvpKFNcQiedbNGurzDWlEY1oSmygiRFM3O68zpMglJy9a22gHpwCHscdGLV1R1dVEa/
         RSng0/zUJQxbUTRpTj9URxYIb+An5j/5UDCh/SDoRopqyI/QKtW56Xe1yo0h3jicI0gJ
         lRNg==
X-Gm-Message-State: AOJu0YwfkelHWupg8BN0n79qqa+zyx1SnREXlYSCLxBDCkOCVqUWQQuO
        EsJj1+kjfL2EDiub2xMatlcZ+Q==
X-Google-Smtp-Source: AGHT+IExqtAvw85uOYoISyCNcaiIGfaHR43JUwoyg6pAOWLwnTCuf1Jc31Ui+I5CLnUlgMVI9kPReQ==
X-Received: by 2002:a17:906:20dc:b0:9a5:9f8d:770 with SMTP id c28-20020a17090620dc00b009a59f8d0770mr1504462ejc.46.1693407505160;
        Wed, 30 Aug 2023 07:58:25 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id f24-20020a1709067f9800b00977eec7b7e8sm7291810ejr.68.2023.08.30.07.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:58:24 -0700 (PDT)
Message-ID: <72af9e51-3fc5-c2a8-b81b-7a7cbd0c9311@linaro.org>
Date:   Wed, 30 Aug 2023 16:58:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 05/11] dt-bindings: document the Qualcomm TEE Shared
 Memory Bridge
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-6-bartosz.golaszewski@linaro.org>
 <9b69a4a6-b011-f0e8-217f-5f91d9a00382@linaro.org>
 <48feda07-525d-4319-ba09-14928ab1fd29@linaro.org>
 <CACMJSeuOigO38_jgjNLz6AiWK1BoLN+shDQHrubS5s-dkDFG7A@mail.gmail.com>
 <3f7f6427-51eb-a251-f8dd-f7922b9fcfd7@linaro.org>
 <CACMJSevO7sGZ5Yj_wBrs6kV+eo7iW_aLwBj68zjbU3dS7tJ-sA@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACMJSevO7sGZ5Yj_wBrs6kV+eo7iW_aLwBj68zjbU3dS7tJ-sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 16:39, Bartosz Golaszewski wrote:
> On Wed, 30 Aug 2023 at 16:31, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 30/08/2023 15:48, Bartosz Golaszewski wrote:
>>> On Tue, 29 Aug 2023 at 11:30, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>> On 29.08.2023 10:02, Krzysztof Kozlowski wrote:
>>>>> On 28/08/2023 21:25, Bartosz Golaszewski wrote:
>>>>>> Add Device Tree bindings for Qualcomm TEE Shared Memory Brige - a
>>>>>> mechanism that allows sharing memory buffers between trustzone and the
>>>>>> kernel.
>>>>>
>>>>> Subject prefix:
>>>>> dt-bindings: firmware:
>>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>> ---
>>>>>>  .../bindings/firmware/qcom,shm-bridge.yaml    | 36 +++++++++++++++++++
>>>>>>  1 file changed, 36 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml b/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..f660962b7b86
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
>>>>>> @@ -0,0 +1,36 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/firmware/qcom,shm-bridge.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: QCOM Shared Memory Bridge
>>>>>> +
>>>>>> +description: |
>>>>>
>>>>> Do not need '|' unless you need to preserve formatting.
>>>>>
>>>>>> +  Qualcomm TEE Shared Memory Bridge allows sharing limited areas of kernel's
>>>>>> +  virtual memory with the trustzone in order to avoid mapping the entire RAM.
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Bjorn Andersson <andersson@kernel.org>
>>>>>> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>> +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    items:
>>>>>> +      - enum:
>>>>>> +          - qcom,shm-bridge-sa8775p
>>>>>> +          - qcom,shm-bridge-sm8150
>>>>>> +          - qcom,shm-bridge-sm8450
>>>>>> +      - const: qcom,shm-bridge
>>>>>> +
>>>>>
>>>>> Looks quite empty... Why this cannot be part of qcom,scm? IOW, why do
>>>>> you need new binding if you do not have any resources here and the block
>>>>> is essentially feature of qcom,scm firmware?
>>>> Since it's "discoverable" (via retval of an scm call), I'd second the
>>>> idea of probing this from within the SCM driver.
>>>>
>>>> Konrad
>>>
>>> Downstream has a bunch of DT switches that we don't support for now
>>> upstream. I disagree about shoehorning this into the SCM driver. It
>>> really is a layer on top of SCM but also SCM is a user of this
>>> interface.
>>
>> Sure, for the driver makes sense, but it does not really explain why DT
>> node is needed. It is not separate hardware. I doubt it is even separate
>> firmware, but part of SCM.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Because not all platforms support it and it's the simplest way of

Platforms like SoCs or boards?

> marking the ones that do. Both SHM and SCM nodes sit on the firmware
> node anyway. What do you recommend? A property of the SCM node? Like
> 'qcom,shm-bridge` or something?

If the first - you talk about SoCs - then you have everything needed
already: SCM compatibles. This defines it fully.

If it varies by boards with one SoC, would be different case, but I
really doubt it.

Best regards,
Krzysztof

