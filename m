Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D87578DDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245732AbjH3SyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245128AbjH3ObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:31:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D830B193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:31:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso8311479e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693405862; x=1694010662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZY0deiTnO9HqTmhq+9BgjkHv5GVPaKmFZj60VWc3fuQ=;
        b=Sp4Qp1INlwluUcKwE3TVFel+MWI64hDyTegxnv46kLJLmosTA3vq2rttm2Lbit8HPL
         p8Tl6QpJqz47uzwXurUbJIh+KVu/Sz8OpW6ERVRxOCY6WS/pH3lH/SAvDWVYnIoMOX34
         524OrLL28vrDEWOLid/jNE912TB9kWfI/uv98vrDkhRuBUfk+ETV4rAwFEqO4JTtdEhb
         es4d5PGmeTJH8M4J97PuFZiM4cQ0uRRMgqYUhQuc9Cv690UZHPA/S7JwJDE/c2ZeXoTC
         2L6SPclqCvzVbgtz9VoVmis01G2lQc3KQ4IEMojdpPsxdH2oImP/GXWPJRRT9nqsYXdx
         95eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693405862; x=1694010662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY0deiTnO9HqTmhq+9BgjkHv5GVPaKmFZj60VWc3fuQ=;
        b=VYDPSlnaLZFnlXwKhChA5GkavrV89T6QzmiBOna8R0Ti9/da6ZVBIpXG6HbJzrZrpG
         U9WUDQHB0KdwTkc09utC/DFzSxwPbGOYdDe/cX+8RtOsnLbVOrXoK3dSjbiBRpAh83k9
         CK0j8ePrrhXjCo1xyt73pwdO0ZKBrm9chT7KsbC0i2I2BOqneAKlfLSiiEmCEE/VirWO
         aDcLU8uM3xKC238Y0gw6jiP+18lx6ZwRXl7JnWz6mtIb06Rxah5xBAO4IGnW9RuD2KKu
         UhQO+cOfyB9ldcrfbS3OxclhG1LK+EU4EouBljij8Xtd2Bjd00QF1j2bb7ZUNeNOk0Eo
         L4gw==
X-Gm-Message-State: AOJu0Ywt6YJZBA3TRphU7Gqeej+XzI2VtY4ZuQo3QI4UZWGdMfKhcTWT
        IAczBAApKNoW2976w8ZjglhOVg==
X-Google-Smtp-Source: AGHT+IGWIQNzv/lcLcwsBoqxI/zsSA+mv5sN7MpUDDHR/4HMuhQG491t3VHz0giePI4M6CLRnRQv0g==
X-Received: by 2002:a05:6512:220d:b0:4f8:752f:df48 with SMTP id h13-20020a056512220d00b004f8752fdf48mr1753066lfu.29.1693405862090;
        Wed, 30 Aug 2023 07:31:02 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709062b5100b009a219ecbaf1sm7241362ejg.85.2023.08.30.07.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:31:01 -0700 (PDT)
Message-ID: <3f7f6427-51eb-a251-f8dd-f7922b9fcfd7@linaro.org>
Date:   Wed, 30 Aug 2023 16:31:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 05/11] dt-bindings: document the Qualcomm TEE Shared
 Memory Bridge
Content-Language: en-US
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACMJSeuOigO38_jgjNLz6AiWK1BoLN+shDQHrubS5s-dkDFG7A@mail.gmail.com>
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

On 30/08/2023 15:48, Bartosz Golaszewski wrote:
> On Tue, 29 Aug 2023 at 11:30, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 29.08.2023 10:02, Krzysztof Kozlowski wrote:
>>> On 28/08/2023 21:25, Bartosz Golaszewski wrote:
>>>> Add Device Tree bindings for Qualcomm TEE Shared Memory Brige - a
>>>> mechanism that allows sharing memory buffers between trustzone and the
>>>> kernel.
>>>
>>> Subject prefix:
>>> dt-bindings: firmware:
>>>
>>>
>>>
>>>>
>>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>> ---
>>>>  .../bindings/firmware/qcom,shm-bridge.yaml    | 36 +++++++++++++++++++
>>>>  1 file changed, 36 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml b/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
>>>> new file mode 100644
>>>> index 000000000000..f660962b7b86
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
>>>> @@ -0,0 +1,36 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/firmware/qcom,shm-bridge.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: QCOM Shared Memory Bridge
>>>> +
>>>> +description: |
>>>
>>> Do not need '|' unless you need to preserve formatting.
>>>
>>>> +  Qualcomm TEE Shared Memory Bridge allows sharing limited areas of kernel's
>>>> +  virtual memory with the trustzone in order to avoid mapping the entire RAM.
>>>> +
>>>> +maintainers:
>>>> +  - Bjorn Andersson <andersson@kernel.org>
>>>> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - enum:
>>>> +          - qcom,shm-bridge-sa8775p
>>>> +          - qcom,shm-bridge-sm8150
>>>> +          - qcom,shm-bridge-sm8450
>>>> +      - const: qcom,shm-bridge
>>>> +
>>>
>>> Looks quite empty... Why this cannot be part of qcom,scm? IOW, why do
>>> you need new binding if you do not have any resources here and the block
>>> is essentially feature of qcom,scm firmware?
>> Since it's "discoverable" (via retval of an scm call), I'd second the
>> idea of probing this from within the SCM driver.
>>
>> Konrad
> 
> Downstream has a bunch of DT switches that we don't support for now
> upstream. I disagree about shoehorning this into the SCM driver. It
> really is a layer on top of SCM but also SCM is a user of this
> interface.

Sure, for the driver makes sense, but it does not really explain why DT
node is needed. It is not separate hardware. I doubt it is even separate
firmware, but part of SCM.

Best regards,
Krzysztof

