Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68277AA898
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 07:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjIVFwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 01:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjIVFwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 01:52:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438FAC2;
        Thu, 21 Sep 2023 22:52:17 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M4D4N2016202;
        Fri, 22 Sep 2023 05:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aG8KcH6dsFy8qFXYDAKQvrkJm6F0SCeNzjijU4CaS1Y=;
 b=MQk4V8Ek2mc5iihTEKGFnbCEhBjL3VZWjTwcVJzaozNFhScDaQIJM4qthr+Ha9R4X4kU
 fn1yxHmfLwdeB3DUZH2EIFDmxSBo33Wzq8Pn12rX/KOnlZri5mHVKiYjkU79Ozb2kRUB
 ymSSZrC+aBVThppRPJETSBYYzvVPd/cHGtoh6FJoJJTUsNFVhf2u0uMTgDRzO2O11Orm
 h/PMbpwBZ+czs5RUCG79+X9PGyqOxA1E8CFfjSVmDXmIwaOaVMIiL32r7qYsKYDgbLIg
 zfGeQD9buqOuMs0zaVyGwloEXEtYHiAJV/yBVRVFykAUJc1Q4Vzw6/7Tekaf4RwFimhU +w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u6ah26t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 05:51:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38M5pihi005998
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 05:51:44 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 21 Sep
 2023 22:51:36 -0700
Message-ID: <181402d1-1f62-46f1-9306-14688e12a1a3@quicinc.com>
Date:   Fri, 22 Sep 2023 13:51:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] arm64: dts: qcom: sm4450: Add RPMH and Global
 clock
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <quic_ajipan@quicinc.com>,
        <kernel@quicinc.com>
References: <20230920065459.12738-1-quic_tengfan@quicinc.com>
 <20230920065459.12738-4-quic_tengfan@quicinc.com>
 <21b8b019-42b8-6e47-e640-8bca28d2d784@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <21b8b019-42b8-6e47-e640-8bca28d2d784@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h5epdG8whUqRlgkwIGmrbJHqvyzZyvUo
X-Proofpoint-ORIG-GUID: h5epdG8whUqRlgkwIGmrbJHqvyzZyvUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_04,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=882 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/20/2023 6:00 PM, Konrad Dybcio 写道:
> 
> 
> On 9/20/23 08:54, Tengfei Fan wrote:
>> Add device node for RPMH and Global clock controller on Qualcomm
>> SM4450 platform.
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm4450.dtsi | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi 
>> b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> index 3d9d3b5e9510..c27f17a41699 100644
>> --- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> @@ -3,6 +3,8 @@
>>    * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>>    */
>> +#include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/clock/qcom,sm4450-gcc.h>
> These should be sorted alphabetically.
> 
Hi Konrad,
I think these included header files already were sorted alphabetically(r 
-> s), so there are unnecessary for adjust them again, right?
> [...]
> 
>> +            rpmhcc: clock-controller {
>> +                compatible = "qcom,sm4450-rpmh-clk";
>> +                #clock-cells = <1>;
>> +                clock-names = "xo";
>> +                clocks = <&xo_board>;
> property
> property-names
> 
> Konrad

-- 
Thx and BRs,
Tengfei Fan
