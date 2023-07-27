Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265B8764EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjG0JIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjG0JIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:08:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF2059E1;
        Thu, 27 Jul 2023 01:50:09 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R4wFrY025115;
        Thu, 27 Jul 2023 08:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Dg/6iMgZ3+ILLBF9d/6F/4xH4zT9eUYv7MT1t6eVGO8=;
 b=Xg18iGmbn5eUtdsxoLB3gLENgrkL3S8ogVUBiGonN1Y1E3w1z2PiK+7CRyMAOoBuS2u2
 U+qC50NPz5K7lZOtg2Y4K+o3xq2JkG/MwxHrpmZ712tUalBh86LneLw8Yx58TgNqK1cr
 W+70FszufdALTpv8Ms5vp4FZGX+ibvUg0gzQbzbHAVwh3vgUI7qFyhXcZJqLRSyL0U4d
 Uxc1g4hfSJgeTUklg5vKFKydOyFISrm9AVKaFa+4zIa3uaFZAABrRfiKKwJGJhDHsTEO
 ixMLTHanhkTEleXuDeE0bGRvmx5sZWmw3Ef8EfG+vQ5DPr0/Ds5bzG1Vq4OUiZK4Oc4F /g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3b0g13px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 08:50:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36R8o4Iq001276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 08:50:04 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 01:49:28 -0700
Message-ID: <ba733dbe-c44e-2199-e7f4-7152a9be065b@quicinc.com>
Date:   Thu, 27 Jul 2023 16:49:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: Add base SM4450 QRD DTS
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230727023508.18002-1-quic_tengfan@quicinc.com>
 <20230727023508.18002-5-quic_tengfan@quicinc.com>
 <f974f48a-05b0-530d-25a0-7ccf1b1ad113@linaro.org>
 <518770c2-05ad-a2a2-4e73-7ceb30687614@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <518770c2-05ad-a2a2-4e73-7ceb30687614@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Di7yZVm7FCKkLzMyC06m29HlQKckRgJx
X-Proofpoint-ORIG-GUID: Di7yZVm7FCKkLzMyC06m29HlQKckRgJx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270078
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 7/27/2023 3:59 PM, Konrad Dybcio 写道:
> On 27.07.2023 08:56, Krzysztof Kozlowski wrote:
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
> hvc totally comes from Qualcomm downstream and all the Gunyah
> shenanigans..
> 
> Tengfei, please ensure the patches are tested against linux-next
> with no additional changes or modules, with a clean Linux userspace
> (or at least a ramdisk).
> 
> Konrad
Hi Konrad,
All these patches are tesed on linux-next, and get DCC console.
For support this test, I did a temporal for enable CONFIG_HVC_DCC(this 
change haven't push to upstream).

-- 
Thx and BRs,
Tengfei Fan
