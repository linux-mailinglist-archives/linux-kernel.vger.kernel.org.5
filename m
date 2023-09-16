Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E077A310E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 17:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjIPPNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 11:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIPPNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 11:13:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C261CCC9;
        Sat, 16 Sep 2023 08:13:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA167C433C8;
        Sat, 16 Sep 2023 15:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694877205;
        bh=UJcG/Z4VLEEdcyUQ1btwTp8/xlKMyVOUA/d+z5tDKPE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NS6hr4/Wd6HWpqFTi90Cbt/zkPXqtLtXB9/M2GugUVKALv9XtGEUqk+2e+htsDuXU
         ohpqAQDK6EipATqHisod7Gxqxkw49iUaZpr9xvqqNInza5o1MihQNdKDsvK4Xq/o+Z
         lrF/me9MFNUgGa0q82mkM/ZyB6sSJRyvHwHFo7yN3wKBM/qaJt3QC2NIVTfRPACIc2
         EIMm6FRfe8Uxkbrut4AiGm8QolfvgtB8uHI2N/FVo+pkwanNzekTl2I6v+K7qi+mrF
         qZGNb9PhINkg1OdQcXNm94ffHwWHWr2SFHiRL7QkaAMgDqVCRQ2qLn83w+9+HGWotq
         p3oH8hUhuyA5g==
Message-ID: <e30870d5-a0cc-4210-a2b0-c7621ea5ecfa@kernel.org>
Date:   Sat, 16 Sep 2023 18:13:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl
 for SM4450
Content-Language: en-US
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        catalin.marinas@arm.com
Cc:     geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-10-quic_tengfan@quicinc.com>
 <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
 <e9ff05b3-2742-416e-b417-5e2414036008@quicinc.com>
 <0a34dd35-7aea-4655-4cdd-e7196a1ba52b@linaro.org>
 <f76e1cc8-fc48-4208-bbe4-9204d9d28363@quicinc.com>
 <b7398390-23bc-467c-5b83-411110d60f43@linaro.org>
 <01c020ae-a019-e4eb-14cb-64503bde05a6@quicinc.com>
 <212f9bfa-6d4c-bba2-60d2-272c001a4322@quicinc.com>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <212f9bfa-6d4c-bba2-60d2-272c001a4322@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trilok,

On 16.09.23 5:25, Trilok Soni wrote:
> On 9/15/2023 7:21 PM, Trilok Soni wrote:
>> On 9/15/2023 4:29 AM, Krzysztof Kozlowski wrote:
>>> On 15/09/2023 13:18, Tengfei Fan wrote:
>>>>
>>>>
>>>> 在 9/15/2023 5:16 PM, Krzysztof Kozlowski 写道:
>>>>> On 15/09/2023 11:12, Tengfei Fan wrote:
>>>>>>
>>>>>>
>>>>>> 在 9/15/2023 3:21 PM, Krzysztof Kozlowski 写道:
>>>>>>> On 15/09/2023 04:15, Tengfei Fan wrote:
>>>>>>>> Add the SM4450 interconnect and pinctrl drivers as built-in for
>>>>>>>> support the Qualcomm SM4450 platform to boot to uart shell.
>>>>>>>>
>>>>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>>>>> ---
>>>>>>>>     arch/arm64/configs/defconfig | 2 ++
>>>>>>>>     1 file changed, 2 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>>>>>> index ec59174b14db..e91993de865e 100644
>>>>>>>> --- a/arch/arm64/configs/defconfig
>>>>>>>> +++ b/arch/arm64/configs/defconfig
>>>>>>>> @@ -598,6 +598,7 @@ CONFIG_PINCTRL_SC8280XP=y
>>>>>>>>     CONFIG_PINCTRL_SDM660=y
>>>>>>>>     CONFIG_PINCTRL_SDM670=y
>>>>>>>>     CONFIG_PINCTRL_SDM845=y
>>>>>>>> +CONFIG_PINCTRL_SM4450=y
>>>>>>>>     CONFIG_PINCTRL_SM6115=y
>>>>>>>>     CONFIG_PINCTRL_SM6125=y
>>>>>>>>     CONFIG_PINCTRL_SM6350=y
>>>>>>>> @@ -1500,6 +1501,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=y
>>>>>>>>     CONFIG_INTERCONNECT_QCOM_SC8180X=y
>>>>>>>>     CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>>>>>>>>     CONFIG_INTERCONNECT_QCOM_SDM845=y
>>>>>>>> +CONFIG_INTERCONNECT_QCOM_SM4450=y
>>>>>>>
>>>>>>> Why it cannot be =m?
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Krzysztof
>>>>>>>
>>>>>>
>>>>>> Hi Krzysztof,
>>>>>> Because system haven't capacity of loading ko files at this time on
>>>>>> SM4450 platform, so setting to "Y".
>>>>>
>>>>> Hm? System has this capability. All systems have. What is so different
>>>>> on SM4450 comparing to everything else we have here?
>>>>>
>>>>> No, this should be =m and you need to fix your system.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>> Hi Krzysztof,
>>>> Find new way which can load ko files on SM4450 platform, still need use
>>>> "Y", because of some other modules have dependence to these two config,
>>>> like scm, smmu module drivers, uart shell console cannot be got if set
>>>> to "m".
>>>
>>> That's what I am asking, which device exactly needs it.
>>>
>>>>
>>>> Also do test for setting these two config to "m" on SM8450 platform, get
>>>> uart shell consle failed if so setting.
>>>
>>> Yeah, this we know, I did this. I am asking about SM4450.
>>
>> Why we have =m requirement when other drivers above are =Y?. Can we confirm
>> w/ Georgi? I am not aware that Interconnect drivers needs to be =m only.
>>
>> CONFIG_INTERCONNECT_QCOM_SC8180X=y
>> CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>> CONFIG_INTERCONNECT_QCOM_SDM845=y
> 
> Complete list here, and it is inconsistent. Latest 8550 is also =y. Do we document
> the reasons somewhere on why they are added as =y?
> 
> CONFIG_INTERCONNECT_QCOM=y
> CONFIG_INTERCONNECT_QCOM_MSM8916=m
> CONFIG_INTERCONNECT_QCOM_MSM8996=m
> CONFIG_INTERCONNECT_QCOM_OSM_L3=m
> CONFIG_INTERCONNECT_QCOM_QCM2290=m
> CONFIG_INTERCONNECT_QCOM_QCS404=m
> CONFIG_INTERCONNECT_QCOM_SA8775P=y
> CONFIG_INTERCONNECT_QCOM_SC7180=y
> CONFIG_INTERCONNECT_QCOM_SC7280=y
> CONFIG_INTERCONNECT_QCOM_SC8180X=y
> CONFIG_INTERCONNECT_QCOM_SC8280XP=y
> CONFIG_INTERCONNECT_QCOM_SDM845=y
> CONFIG_INTERCONNECT_QCOM_SM8150=m
> CONFIG_INTERCONNECT_QCOM_SM8250=m
> CONFIG_INTERCONNECT_QCOM_SM8350=m
> CONFIG_INTERCONNECT_QCOM_SM8450=y
> CONFIG_INTERCONNECT_QCOM_SM8550=y

If the device can boot (to console/initramfs) with =m, we go with that.
But if something critical like the UART depends on the interconnect
provider, then we make it built-in.

On SM8550 for example, we have enabled bandwidth scaling support for QUP
and that's why it needs to be =y.

It looks like on SM4450 this should be =y too.

Thanks,
Georgi
