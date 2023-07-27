Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DF4764EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjG0JI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjG0JIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:08:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030EC59E6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:50:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe04882c66so1215736e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690447832; x=1691052632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTPr6htwM3Aij5CLD7r7Y7TamLm7+8o6pc1M7Zo8TSE=;
        b=pvHmCMMddcHQU9PZ4sD2YCKY3GJdkQT9HBAYiQc/XJOcmINq/AnLCQAymYRDNUMo5X
         J01mx6LgpbSU6jruqBNrhI/PkhUbPAu4cYkeV4gYhIADKpulw/xbD/hn0aZiCxD9X1Jk
         8qtzA3JbYjERURWA8SunmPJCSnbI00j4HRo8Ex1fCQAZ2Ju4Q21CZ5YK1cXFkGKrG0mm
         uHfu/z9nt+hcW0nGHjoUILtWzvR4QwZ245yWCts2KTR91IUlqAMoUvQ0d8D0f1t6EQ92
         FkN3eb1XuF/YhSzcx7pDXlJksL0GiT21XLMkUt5ZbDDfB6PZcFlq1Qm9ocJa96nd3zgT
         ZZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690447832; x=1691052632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTPr6htwM3Aij5CLD7r7Y7TamLm7+8o6pc1M7Zo8TSE=;
        b=kGSlkkqFKAE492f45HsNCC56VTRSeflJnTNT/3ZuS3KOu6hdfDPRJNm/FIP9XhkW9r
         2XK7+JVdly2pxclg+gOuA9kEfao1JwSqeg7sMesbGdR5MmHQPhGewqAZpwD82TRzDP6m
         swNAkmQDI6J+IrTU4xBLmaSYL79gnNdHW0nEgbsAqRWJIFK3LSToQ+87jBOD3sN5ueNF
         z3HJY/I7SF667qEKKu/ekR2lDpXScmYF6HNbZLrvn8hkNuv97nSsk/6RDLZGGO0vABnx
         EGXxQfF/6y0NzPGbkpphJ8gytPfM0bhkNJY/K9ik234+q96gGRRS49UnelF3cPVvrIKN
         6Lxw==
X-Gm-Message-State: ABy/qLZdR20SKN+rwFTlrhBF5pz995PZDFPvqHbWvvh3PQymEfbnv8Ys
        ZQDXjyK72gHZJu4FOAUKIxMnsA==
X-Google-Smtp-Source: APBJJlHYjvq+7TFp9xVBfruh/QwNHUZ1W1ugGkKWUeVSfwpvm58C0ADTdi/rwkftDTbX1QmNm/Q5/w==
X-Received: by 2002:a05:6512:3690:b0:4f9:6842:afc with SMTP id d16-20020a056512369000b004f968420afcmr1028058lfs.64.1690447832238;
        Thu, 27 Jul 2023 01:50:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w5-20020aa7d285000000b005227ead61d0sm391742edq.83.2023.07.27.01.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 01:50:31 -0700 (PDT)
Message-ID: <e20781ea-09ba-2190-7318-dc62e713302d@linaro.org>
Date:   Thu, 27 Jul 2023 10:50:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: Add base SM4450 QRD DTS
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727023508.18002-1-quic_tengfan@quicinc.com>
 <20230727023508.18002-5-quic_tengfan@quicinc.com>
 <f974f48a-05b0-530d-25a0-7ccf1b1ad113@linaro.org>
 <dba27a60-8681-e2e7-b89f-608bfbc05e93@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dba27a60-8681-e2e7-b89f-608bfbc05e93@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 10:27, Tengfei Fan wrote:
> 
> 
> 在 7/27/2023 2:56 PM, Krzysztof Kozlowski 写道:
>> On 27/07/2023 04:35, Tengfei Fan wrote:
>>> Add DTS for Qualcomm QRD platform which uses SM4450 SoC.
>>>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/Makefile       |  1 +
>>>   arch/arm64/boot/dts/qcom/sm4450-qrd.dts | 18 ++++++++++++++++++
>>>   2 files changed, 19 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index 337abc4ceb17..db805d0929c8 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -186,6 +186,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>> new file mode 100644
>>> index 000000000000..04ad1dd4285a
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>> @@ -0,0 +1,18 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "sm4450.dtsi"
>>> +/ {
>>> +	model = "Qualcomm Technologies, Inc. SM4450 QRD";
>>> +	compatible = "qcom,sm4450-qrd", "qcom,sm4450";
>>> +
>>> +	aliases { };
>>> +
>>> +	chosen {
>>> +		bootargs = "console=hvc0 earlycon=hvc0 hvc_dcc.enable=1 cpuidle.off=1";
>>
>> No earlycon, no hvc.enable (there is no such parameter), no cpuidle.off
>> (again don't add fake stuff). So the only suitable argument is console,
>> but this should be actually used via stdout path, although it seems
>> there is no device node for such usage?
> Hi Krzysztof,
> Checked upstream linux kernel code, there is not "hvc_dcc.enable", but 
> have other parameters, like earlycon, cpuidle.off.
> Do you mean we should not set "earlycon=hvc0 cpuidle.off=1" parameters, 

Of course not. Why production code would have earlycon? This is debug
argument, not suitable for each user of this DTS.

cpuidle.off is neither explained nor needed. Otherwise please add a
comment why this is part of hardware description.

> right? only need: bootargs = "console=hvc0" ?

You should use stdout-path if possible. If not, then only console.

Best regards,
Krzysztof

