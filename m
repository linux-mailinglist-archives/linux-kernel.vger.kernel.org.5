Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011EA7A1D74
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjIOL33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjIOL30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:29:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6405C1BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:29:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-403012f27e3so23096775e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694777360; x=1695382160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOKPrQtwKxSzhyF/0RrIr5RFzt3C+vCUzllNvO9L9aU=;
        b=j74KRIxPmlG0EEMIS6nGU8IQndATjhvnajcUwjvjSp3/u2uhRWE/Y5wsK4yuR+khyq
         pHCVGIPtlicBnYy7/Jblgg4FC8VqrYcefRaPvcNzZGi9si/e+n/7bbF3vb4y5a4xm2Af
         XGESiFDyRxvlCVeCHpkMN3UKZq7WvGk/8zFs2FvSix+Zj33SbWfP1YTe0UHfKJastzTm
         R6JbDZIbu8/EfRxhsDNgzkdwQP5QkLHcDzXTOSjEVl5oUK4iap2NoUjJKbyk8u1FTa9c
         aGN6sDWbxKeFxcN8RTcOfBNeJy+UpMyr8Eu0LGI5jfsEEPW1mHdvcC9xLlaT97dJmZTB
         pUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694777360; x=1695382160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOKPrQtwKxSzhyF/0RrIr5RFzt3C+vCUzllNvO9L9aU=;
        b=lYc9u0kolHp3I6iL/C26585NMSKOPX/qrE1vM4fC0wHuWnjYLFPJosR0lVnadrsrIK
         f4UIXR2w83LkPgTNPWOTeRzHaIsuaC1siL3ufXSX1ActOoEFkdXyCNzL2SH6C5U5CVEW
         tX8NOihuUpv7EXznPsnuG9JcKyYWm6AItrR1Uwi3nnEJFTEWqXaYcnBWNxNaS1NVsKtg
         uUFWNxsHjXLYpEHs9U3M+PkIiaYt+EXx66Qbic05UDaZLrfEnpqey/rGygOYzNQgu5cL
         g94khVbtSHeCtCbrSaJRasNFmOacav9nTPY/R8ao+p/9yKcMi8QpP/4fqUjI0beWPDPA
         OudQ==
X-Gm-Message-State: AOJu0Yy86GMCXty7a7e2xGwdVZXTLe/Gn3n1P9Gzj3UQsCR1Tm4dgmTT
        lljUngkXfwItHpc8bBkHug0L6A==
X-Google-Smtp-Source: AGHT+IEr38/mWh5mpLtWDFh75MFd/hOiBed0DnDtLaMt/qeG5SkPrc/bmhTeLtAB2RW6MNldvvzfpA==
X-Received: by 2002:a1c:721a:0:b0:3fc:1a6:7764 with SMTP id n26-20020a1c721a000000b003fc01a67764mr1374584wmc.16.1694777359704;
        Fri, 15 Sep 2023 04:29:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bcb8a000000b003fed7fa6c00sm7338300wmi.7.2023.09.15.04.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 04:29:18 -0700 (PDT)
Message-ID: <b7398390-23bc-467c-5b83-411110d60f43@linaro.org>
Date:   Fri, 15 Sep 2023 13:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl
 for SM4450
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
 <20230915021509.25773-10-quic_tengfan@quicinc.com>
 <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
 <e9ff05b3-2742-416e-b417-5e2414036008@quicinc.com>
 <0a34dd35-7aea-4655-4cdd-e7196a1ba52b@linaro.org>
 <f76e1cc8-fc48-4208-bbe4-9204d9d28363@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f76e1cc8-fc48-4208-bbe4-9204d9d28363@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 13:18, Tengfei Fan wrote:
> 
> 
> 在 9/15/2023 5:16 PM, Krzysztof Kozlowski 写道:
>> On 15/09/2023 11:12, Tengfei Fan wrote:
>>>
>>>
>>> 在 9/15/2023 3:21 PM, Krzysztof Kozlowski 写道:
>>>> On 15/09/2023 04:15, Tengfei Fan wrote:
>>>>> Add the SM4450 interconnect and pinctrl drivers as built-in for
>>>>> support the Qualcomm SM4450 platform to boot to uart shell.
>>>>>
>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>> ---
>>>>>    arch/arm64/configs/defconfig | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>>> index ec59174b14db..e91993de865e 100644
>>>>> --- a/arch/arm64/configs/defconfig
>>>>> +++ b/arch/arm64/configs/defconfig
>>>>> @@ -598,6 +598,7 @@ CONFIG_PINCTRL_SC8280XP=y
>>>>>    CONFIG_PINCTRL_SDM660=y
>>>>>    CONFIG_PINCTRL_SDM670=y
>>>>>    CONFIG_PINCTRL_SDM845=y
>>>>> +CONFIG_PINCTRL_SM4450=y
>>>>>    CONFIG_PINCTRL_SM6115=y
>>>>>    CONFIG_PINCTRL_SM6125=y
>>>>>    CONFIG_PINCTRL_SM6350=y
>>>>> @@ -1500,6 +1501,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
>>>>>    CONFIG_INTERCONNECT_QCOM_SC8180X=y
>>>>>    CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>>>>>    CONFIG_INTERCONNECT_QCOM_SDM845=y
>>>>> +CONFIG_INTERCONNECT_QCOM_SM4450=y
>>>>
>>>> Why it cannot be =m?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Hi Krzysztof,
>>> Because system haven't capacity of loading ko files at this time on
>>> SM4450 platform, so setting to "Y".
>>
>> Hm? System has this capability. All systems have. What is so different
>> on SM4450 comparing to everything else we have here?
>>
>> No, this should be =m and you need to fix your system.
>>
>> Best regards,
>> Krzysztof
>>
> Hi Krzysztof,
> Find new way which can load ko files on SM4450 platform, still need use 
> "Y", because of some other modules have dependence to these two config, 
> like scm, smmu module drivers, uart shell console cannot be got if set 
> to "m".

That's what I am asking, which device exactly needs it.

> 
> Also do test for setting these two config to "m" on SM8450 platform, get 
> uart shell consle failed if so setting.

Yeah, this we know, I did this. I am asking about SM4450.

Best regards,
Krzysztof

