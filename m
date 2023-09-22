Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996537AA67B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjIVBZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjIVBZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:25:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA522F1;
        Thu, 21 Sep 2023 18:25:29 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M1JAUW006017;
        Fri, 22 Sep 2023 01:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=C0IxRojZ/dwDccz4QGvwLNyPhvswR+HvuHxLkTuPw1g=;
 b=fQjzVbGdZDJyYAoi8yMwY/HCpKMcvlF5QEy1HCUKYsYQboW8dWJT+EEyqEZHZCwQ2qJg
 0zuPfWQwNVMycMsd6wiLNMFrQU1JMsE0FXrLAcMlhv8Q8qWpTxe9kZlLIXzzAtk0OTRV
 V0dmo2FRQrmsUWE/POlNJU6F6EcjeZ+RN7n+DcGYoezjgseH3sG8sF7i3a1xi4PMSF+F
 X95+NX8VBlccUWMFxdeubuh0Ma1Ha2Bclgey2ZSiazZxQzamoODiyQtYcM31rlMiMVv7
 khzumGJ7qyGnZ8yKUOvcD5IP1jJvs97ww2PGk2sYkNa9/DjfmxICY4HeFHANlpT8FIF2 eA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u6agn86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 01:25:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38M1PEfr012221
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 01:25:14 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 21 Sep
 2023 18:25:07 -0700
Message-ID: <3372b707-a216-498f-84ab-adb7b6484c91@quicinc.com>
Date:   Fri, 22 Sep 2023 09:25:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm4450: Add RPMH and Global clock
 controller
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <lee@kernel.org>
CC:     <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        <quic_bjorande@quicinc.com>, Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230908065847.28382-1-quic_tengfan@quicinc.com>
 <20230908065847.28382-6-quic_tengfan@quicinc.com>
 <ae4df26d-b74e-f22e-f532-7ff34d139fa3@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <ae4df26d-b74e-f22e-f532-7ff34d139fa3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aqhYro06R3iPJu_mRMWifWlR8ObWB5Ht
X-Proofpoint-ORIG-GUID: aqhYro06R3iPJu_mRMWifWlR8ObWB5Ht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_01,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=912 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/20/2023 10:33 PM, Konrad Dybcio 写道:
> 
> 
> On 9/8/23 08:58, Tengfei Fan wrote:
>> From: Ajit Pandey <quic_ajipan@quicinc.com>
>>
>> Add device node for RPMH and Global clock controller on Qualcomm
>> SM4450 platform.
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm4450.dtsi | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi 
>> b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> index eb544d875806..2395b1d655a2 100644
>> --- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> @@ -3,6 +3,8 @@
>>    * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>>    */
>> +#include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/clock/qcom,sm4450-gcc.h>
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> @@ -367,6 +369,22 @@
>>               apps_bcm_voter: bcm-voter {
>>                   compatible = "qcom,bcm-voter";
>>               };
>> +
>> +            rpmhcc: clock-controller {
>> +                compatible = "qcom,sm4450-rpmh-clk";
>> +                #clock-cells = <1>;
>> +                clock-names = "xo";
>> +                clocks = <&xo_board>;
> property
> property-names
> 
> please
> 
> Konrad
Hi Konrad,
I will adjust these nodes.

-- 
Thx and BRs,
Tengfei Fan
