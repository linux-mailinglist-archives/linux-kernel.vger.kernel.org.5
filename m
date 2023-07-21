Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4586075BC1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjGUCH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGUCH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:07:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B96271E;
        Thu, 20 Jul 2023 19:07:26 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L154we024025;
        Fri, 21 Jul 2023 02:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2LIetupMAQJQnMu0hUDiPUgD3wAu9tzAiyhRlJLpumA=;
 b=V6P279rqKTb0nLRFFphReWVu8V1cq/atP4Wp5Ifx33o9XfsG6M9pUkIBqC5XJ6pmpINF
 uEcKZ10MQUmTz+NZJ7yq44sqGPvkp39upU/FQ5BY4jnMzK3k7X8hwwLsPwcFALwW6mdB
 OrUA6UvRl2J+GpQ+QVdQIL+PXR2Rz0Hjyc5+std/RvBOWGEHiZ2SmuU1FIdRDJ3JsiBd
 KgmgknSp9Xvhl0O04MD5WhQCrbrm/DsmAKwH1dTK99KQBW/ojjdJMCr5Vp+2ylCZM0lw
 Emf0nDw7shT4wuQPFWGrfvPwuLp8ZDC+sTJnQiZLnruT4OkYFqrqUuxOq4bOufND8Cqm Qw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxpyquav0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:07:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L27LWJ003884
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 02:07:21 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 19:07:17 -0700
Message-ID: <5f070181-96cc-b8be-810f-f9ec8e55fbce@quicinc.com>
Date:   Fri, 21 Jul 2023 10:07:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: Add base SM4450 QRD DTS
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <quic_tsoni@quicinc.com>, <quic_shashim@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_tdas@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230719100135.21325-1-quic_tengfan@quicinc.com>
 <20230719100135.21325-3-quic_tengfan@quicinc.com>
 <484822a3-939f-599d-434c-38f7a560a015@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <484822a3-939f-599d-434c-38f7a560a015@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y4MPLe3WJ41zINT5WSPwepOL8WwCxHqN
X-Proofpoint-ORIG-GUID: Y4MPLe3WJ41zINT5WSPwepOL8WwCxHqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=726 malwarescore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307210017
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 7/19/2023 6:17 PM, Dmitry Baryshkov 写道:
> On 19/07/2023 13:01, Tengfei Fan wrote:
>> Add DTS for Qualcomm QRD platform which uses SM4450 SoC.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile       |  1 +
>>   arch/arm64/boot/dts/qcom/sm4450-qrd.dts | 18 ++++++++++++++++++
>>   2 files changed, 19 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile 
>> b/arch/arm64/boot/dts/qcom/Makefile
>> index 337abc4ceb17..a0cfd37e674b 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -215,3 +215,4 @@ dtb-$(CONFIG_ARCH_QCOM)    += 
>> sm8450-sony-xperia-nagara-pdx223.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8450-sony-xperia-nagara-pdx224.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8550-mtp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += sm8550-qrd.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)    += sm4450-qrd.dtb
> 
> You guess, this should be sorted.
sure, will resorted.
> 
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450-qrd.dts 
>> b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> new file mode 100644
>> index 000000000000..851a6761a6ea
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm4450-qrd.dts
>> @@ -0,0 +1,18 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sm4450.dtsi"
>> +/ {
>> +    model = "Qualcomm Technologies, Inc. SM4450 QRD";
>> +    compatible = "qcom,sm4450-qrd", "qcom,sm4450";
>> +
>> +    aliases { };
>> +
>> +    chosen {
>> +        bootargs = " ";
> 
> Do you need this?
V2 patch will remove bootargs = " ".
> 
>> +    };
>> +};
> 

-- 
Thx and BRs,
Tengfei Fan
