Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D7976548C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjG0NIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjG0NIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:08:40 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386251FC4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:08:39 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so13763041fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690463317; x=1691068117;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Kd6oHs2QTvmJWiIALNrAWDoU2wpAabwv5dblMxirYg=;
        b=b/LUujK6N3vuRoT9JKNkv6gdi3vpQ5M1wz+e0dNIimg3cqTFiKh0d2bgSJGE+8Lhqt
         wrzPDBjNIz0DLOaVyAwk8gNx7jkdHDxEcnlsaDi/JKVflzQjbivUUB3jZjhFtS7O8rcN
         mU+mB941DXbJXBtKOaf8PzO+zFUXABESQg9BAJgknQK59pJndUqdOAcba/z7BqwDB4GE
         AOUIQ4pqHEyC58StHdRHuT6eBcAkSmhSiyG0/KKmBLHKYpiqa0gcL1B2tUGcbQNrbbTZ
         nIugnaf2oHxMVkmeH+jnSHc69Ni1FoStwZNyD4+LgisPWOZGNcsA0vtnwSNgtB4cOVIl
         DciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690463317; x=1691068117;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Kd6oHs2QTvmJWiIALNrAWDoU2wpAabwv5dblMxirYg=;
        b=aop+DkscozhT8COTiPBAArNUv7AlwgAKRpG8UiCkvKo4SNMLNTXHqDEVHvbEhAnPMW
         nnrNQzRs4Kls+t2amTKGcxkKqlYEGNrSduKngmJSe+itCUobvdysiWh2K0uj3O2n3lln
         fjSFELzqVf4vyMmugAaysAAxcjALjP8tRTek1XvBTmIwdnAJ/aNARFOdfszUUISlws3g
         LMJJhWS5T3AJmajdzw6jx2QrjAmc3VnLB7qJPSXcmNJC32CInVNCks4bM90DwMcEegwO
         ZoEHn14+Ad+rZuz9ehM1rFfNi3ucuVPfezrRQAJVdBgnrByOqFDiaYYriFJwBrTmzFfV
         Bxfg==
X-Gm-Message-State: ABy/qLYIszS8fNT+OHvAigE+Ks1NZHiKamtHQufKWjcgt+U5IGxrQPKA
        qnSRU/PACXjcA/Qa9xt0JgYucg==
X-Google-Smtp-Source: APBJJlEbFhIeCLs5ShD64Ybgb1exeXf5bBbCkY/XPSqRilLDbicTEeKPQihfP95ctEtGLYti6CE2pA==
X-Received: by 2002:a2e:8483:0:b0:2b6:cf64:7a8e with SMTP id b3-20020a2e8483000000b002b6cf647a8emr1532757ljh.19.1690463317461;
        Thu, 27 Jul 2023 06:08:37 -0700 (PDT)
Received: from [192.168.1.101] (abxj4.neoplus.adsl.tpnet.pl. [83.9.3.4])
        by smtp.gmail.com with ESMTPSA id g13-20020a2e9ccd000000b002b6cba03427sm330659ljj.79.2023.07.27.06.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 06:08:36 -0700 (PDT)
Message-ID: <3ba67502-1781-2abf-32dc-254796ce7621@linaro.org>
Date:   Thu, 27 Jul 2023 15:08:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: Add base SM4450 QRD DTS
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727023508.18002-1-quic_tengfan@quicinc.com>
 <20230727023508.18002-5-quic_tengfan@quicinc.com>
 <f974f48a-05b0-530d-25a0-7ccf1b1ad113@linaro.org>
 <518770c2-05ad-a2a2-4e73-7ceb30687614@linaro.org>
 <ba733dbe-c44e-2199-e7f4-7152a9be065b@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ba733dbe-c44e-2199-e7f4-7152a9be065b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.07.2023 10:49, Tengfei Fan wrote:
> 
> 
> 在 7/27/2023 3:59 PM, Konrad Dybcio 写道:
>> On 27.07.2023 08:56, Krzysztof Kozlowski wrote:
>>> On 27/07/2023 04:35, Tengfei Fan wrote:
>>>> Add DTS for Qualcomm QRD platform which uses SM4450 SoC.
>>>>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/Makefile       |  1 +
>>>>   arch/arm64/boot/dts/qcom/sm4450-qrd.dts | 18 ++++++++++++++++++
>>>>   2 files changed, 19 insertions(+)
>>>>   create mode 100644 arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>>> index 337abc4ceb17..db805d0929c8 100644
>>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>>> @@ -186,6 +186,7 @@ dtb-$(CONFIG_ARCH_QCOM)    += sdm850-lenovo-yoga-c630.dtb
>>>>   dtb-$(CONFIG_ARCH_QCOM)    += sdm850-samsung-w737.dtb
>>>>   dtb-$(CONFIG_ARCH_QCOM)    += sdx75-idp.dtb
>>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm4250-oneplus-billie2.dtb
>>>> +dtb-$(CONFIG_ARCH_QCOM)    += sm4450-qrd.dtb
>>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm6115-fxtec-pro1x.dtb
>>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm6115p-lenovo-j606f.dtb
>>>>   dtb-$(CONFIG_ARCH_QCOM)    += sm6125-sony-xperia-seine-pdx201.dtb
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>>> new file mode 100644
>>>> index 000000000000..04ad1dd4285a
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>>> @@ -0,0 +1,18 @@
>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>> +/*
>>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "sm4450.dtsi"
>>>> +/ {
>>>> +    model = "Qualcomm Technologies, Inc. SM4450 QRD";
>>>> +    compatible = "qcom,sm4450-qrd", "qcom,sm4450";
>>>> +
>>>> +    aliases { };
>>>> +
>>>> +    chosen {
>>>> +        bootargs = "console=hvc0 earlycon=hvc0 hvc_dcc.enable=1 cpuidle.off=1";
>>>
>>> No earlycon, no hvc.enable (there is no such parameter), no cpuidle.off
>>> (again don't add fake stuff). So the only suitable argument is console,
>>> but this should be actually used via stdout path, although it seems
>>> there is no device node for such usage?
>> hvc totally comes from Qualcomm downstream and all the Gunyah
>> shenanigans..
>>
>> Tengfei, please ensure the patches are tested against linux-next
>> with no additional changes or modules, with a clean Linux userspace
>> (or at least a ramdisk).
>>
>> Konrad
> Hi Konrad,
> All these patches are tesed on linux-next, and get DCC console.
> For support this test, I did a temporal for enable CONFIG_HVC_DCC(this change haven't push to upstream).
So what you've said is that you've not tested against linux-next + this patchset.

You're supposed to `git checkout linux-next/master && (pick the series
you're sending)` and test just that. No less, no more. Preferably with
the upstream arm64 defconfig.

Konrad
