Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623BD76616B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjG1Bl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjG1Bl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:41:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4AC3584;
        Thu, 27 Jul 2023 18:41:25 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S1CD1G007355;
        Fri, 28 Jul 2023 01:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YrEbahFLCFL7csIrXO6lWacWAQuzQw9aXw3pZ2h7owM=;
 b=ols9dIOPL8D071dim5FpELt6kwskqluoTxr0jKOZmNb54u9qQR5OqFJsamwCMQ/KniGR
 zb6vvNdrONvSonp3UWsnYXLLFyQMIdV1f7drM1nNAtbBcAeAY4XMqGNjV9H/fLSoJW9y
 0A9rPhv1hTjGR5TG7DVkSS5LGJcWS/ZnvF4evQ4yNg18MmpY87e810wrLpgyTJgh6ix+
 LD1uKT3m1h6112KOPXIIO36Xflypkg7svxJdG/auqnAJMUoBV4uEVU8aYz1U0dCiafvo
 z+97iIQNE906shICpTlZxETD9AeCYSKNyQOjPTcx+ZC0B5xkq2MsAOVBNPIqDexA8uVk Dg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s37g0kke3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 01:41:21 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S1fKQo012705
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 01:41:20 GMT
Received: from [10.110.109.223] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 18:41:19 -0700
Message-ID: <496c14de-1e02-66f6-37d1-90713c2f6742@quicinc.com>
Date:   Thu, 27 Jul 2023 18:41:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: Add base SM4450 QRD DTS
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230727023508.18002-1-quic_tengfan@quicinc.com>
 <20230727023508.18002-5-quic_tengfan@quicinc.com>
 <f974f48a-05b0-530d-25a0-7ccf1b1ad113@linaro.org>
 <518770c2-05ad-a2a2-4e73-7ceb30687614@linaro.org>
 <ba733dbe-c44e-2199-e7f4-7152a9be065b@quicinc.com>
 <3ba67502-1781-2abf-32dc-254796ce7621@linaro.org>
 <50e73c8b-97d3-9db9-a2ab-2f9e0deee8e5@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <50e73c8b-97d3-9db9-a2ab-2f9e0deee8e5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4RqxJVfOXR7TMYcRBpqVM045zWg480y7
X-Proofpoint-ORIG-GUID: 4RqxJVfOXR7TMYcRBpqVM045zWg480y7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280014
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2023 5:49 PM, Tengfei Fan wrote:
> 
> 
> 在 7/27/2023 9:08 PM, Konrad Dybcio 写道:
>> On 27.07.2023 10:49, Tengfei Fan wrote:
>>>
>>>
>>> 在 7/27/2023 3:59 PM, Konrad Dybcio 写道:
>>>> On 27.07.2023 08:56, Krzysztof Kozlowski wrote:
>>>>> On 27/07/2023 04:35, Tengfei Fan wrote:
>>>>>> Add DTS for Qualcomm QRD platform which uses SM4450 SoC.
>>>>>>
>>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>>> ---
>>>>>>    arch/arm64/boot/dts/qcom/Makefile       |  1 +
>>>>>>    arch/arm64/boot/dts/qcom/sm4450-qrd.dts | 18 ++++++++++++++++++
>>>>>>    2 files changed, 19 insertions(+)
>>>>>>    create mode 100644 arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile 
>>>>>> b/arch/arm64/boot/dts/qcom/Makefile
>>>>>> index 337abc4ceb17..db805d0929c8 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>>>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>>>>> @@ -186,6 +186,7 @@ dtb-$(CONFIG_ARCH_QCOM)    += 
>>>>>> sdm850-lenovo-yoga-c630.dtb
>>>>>>    dtb-$(CONFIG_ARCH_QCOM)    += sdm850-samsung-w737.dtb
>>>>>>    dtb-$(CONFIG_ARCH_QCOM)    += sdx75-idp.dtb
>>>>>>    dtb-$(CONFIG_ARCH_QCOM)    += sm4250-oneplus-billie2.dtb
>>>>>> +dtb-$(CONFIG_ARCH_QCOM)    += sm4450-qrd.dtb
>>>>>>    dtb-$(CONFIG_ARCH_QCOM)    += sm6115-fxtec-pro1x.dtb
>>>>>>    dtb-$(CONFIG_ARCH_QCOM)    += sm6115p-lenovo-j606f.dtb
>>>>>>    dtb-$(CONFIG_ARCH_QCOM)    += sm6125-sony-xperia-seine-pdx201.dtb
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts 
>>>>>> b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>>>>> new file mode 100644
>>>>>> index 000000000000..04ad1dd4285a
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>>>>> @@ -0,0 +1,18 @@
>>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>>> +/*
>>>>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All 
>>>>>> rights reserved.
>>>>>> + */
>>>>>> +
>>>>>> +/dts-v1/;
>>>>>> +
>>>>>> +#include "sm4450.dtsi"
>>>>>> +/ {
>>>>>> +    model = "Qualcomm Technologies, Inc. SM4450 QRD";
>>>>>> +    compatible = "qcom,sm4450-qrd", "qcom,sm4450";
>>>>>> +
>>>>>> +    aliases { };
>>>>>> +
>>>>>> +    chosen {
>>>>>> +        bootargs = "console=hvc0 earlycon=hvc0 hvc_dcc.enable=1 
>>>>>> cpuidle.off=1";
>>>>>
>>>>> No earlycon, no hvc.enable (there is no such parameter), no 
>>>>> cpuidle.off
>>>>> (again don't add fake stuff). So the only suitable argument is 
>>>>> console,
>>>>> but this should be actually used via stdout path, although it seems
>>>>> there is no device node for such usage?
>>>> hvc totally comes from Qualcomm downstream and all the Gunyah
>>>> shenanigans..
>>>>
>>>> Tengfei, please ensure the patches are tested against linux-next
>>>> with no additional changes or modules, with a clean Linux userspace
>>>> (or at least a ramdisk).
>>>>
>>>> Konrad
>>> Hi Konrad,
>>> All these patches are tesed on linux-next, and get DCC console.
>>> For support this test, I did a temporal for enable 
>>> CONFIG_HVC_DCC(this change haven't push to upstream).
>> So what you've said is that you've not tested against linux-next + 
>> this patchset.
>>
>> You're supposed to `git checkout linux-next/master && (pick the series
>> you're sending)` and test just that. No less, no more. Preferably with
>> the upstream arm64 defconfig.
>>
>> Konrad
> Hi Konrad,
> Sorry, my explain isn't enough before.
> 
> My tested against linux-next + this patchset, all my test code from 
> upstream linux-next, haven't downstream code related.
> 
> About the temporal patch which enable CONFIG_HVC_DCC, because we haven't 
> enable uart, so I enable CONFIG_HVC_DCC for verify if we can get DCC 
> console through "make ARCH=arm64 menuconfig" on linux-next/master, but 
> this patchset haven't contain this enable CONFIG_HVC_DCC patch, because 
> upstream seems don't want to enable CONFIG_HVC_DCC defaultly.
> 
> Besides these, I all do dtbs_check and checkpatch.pl check, all these 
> check passed.

CONFIG_HVC_DCC is at upstream. It is not necessary to have UART to test 
the kernel w/ the console.

One can boot the kernel w/ JTAG console too. This will allow us to 
submit the patches without submitting the UART / clocks dependencies.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/hvc/hvc_dcc.c


-- 
---Trilok Soni

