Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720057B2B32
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 07:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjI2F2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 01:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2F2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 01:28:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0B4195;
        Thu, 28 Sep 2023 22:28:19 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T4VBtM009375;
        Fri, 29 Sep 2023 05:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2MmhY5n+x+FttbpEdu4GPZXBa6ZtwaMPVPJou3WoPr8=;
 b=SYUwlC8Ujf7+MqbvTeXOn1moVxRwIQUH2Z99ANG9Z6TpuX7xLzXS/nIC15dAYMfzab6j
 w2w7nJMNrHSxmo/Lxhpr+G0BRa1R7hyL8290YVHMdjj2YP0pVsZ0IDSv5jgDZRuwueNW
 +UecWiNot3VJQuWbIMMCIlM8G4fBzdoxk7kAHg1RWz6ItzjhGh5yasWNnEsmOKB5KgW4
 IvcGeBPNz1SGuY84VcXdGPnyIHCkGcn4GSntC1nOVj2pMo25t/bxF90QnA2SSBjRjCHh
 PazsxxY7xVyKuORN0YBtjtX9W3lxksWp8YL6Sd3MQqMVbcMyO/Rk08gY85AlExMGzKkk 4w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tdfbrrv3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 05:28:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T5SAYk024216
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 05:28:10 GMT
Received: from [10.50.55.181] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 28 Sep
 2023 22:28:06 -0700
Message-ID: <1d74ceae-f337-4062-a93d-bd4a2799dc3f@quicinc.com>
Date:   Fri, 29 Sep 2023 10:58:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8775p: Add RPMh sleep stats
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <quic_mkshah@quicinc.com>, <quic_lsrao@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230926044814.535-1-quic_rkakarla@quicinc.com>
 <149165d9-1c89-45a5-90ab-82ce546f49f5@linaro.org>
Content-Language: en-US
From:   Raghavendra Kakarla <quic_rkakarla@quicinc.com>
In-Reply-To: <149165d9-1c89-45a5-90ab-82ce546f49f5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gFghcoWSqqqQyGlkFhZQQ4BIQ80p_8zV
X-Proofpoint-GUID: gFghcoWSqqqQyGlkFhZQQ4BIQ80p_8zV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_03,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=584 adultscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/27/2023 12:36 AM, Konrad Dybcio wrote:
> On 26.09.2023 06:48, Raghavendra Kakarla wrote:
>> Add device node for sleep stats driver which provides various
>> low power mode stats.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sa8775p.dtsi | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> index 9f4f58e831a4..cee7491de675 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> @@ -1912,6 +1912,11 @@
>>   			#clock-cells = <0>;
>>   		};
>>   
>> +		sram@c3f0000 {
>> +			compatible = "qcom,rpmh-stats";
>> +			reg = <0 0x0c3f0000 0 0x400>;
> Other nodes (such as the one 5 lines below) use 0x0 instead of
> 0 to fill out bits 63:32. Please make it consistent.
Sure, will address this in next patch.
>
> Konrad
>> +		};
>> +
>>   		spmi_bus: spmi@c440000 {
>>   			compatible = "qcom,spmi-pmic-arb";
>>   			reg = <0x0 0x0c440000 0x0 0x1100>,
