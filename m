Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EB17B7C8D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242077AbjJDJqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjJDJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:46:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A288CAF;
        Wed,  4 Oct 2023 02:46:01 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3947m4A7003310;
        Wed, 4 Oct 2023 09:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Sl8iYN0t1lulbY2SJQrh/y+Ci1QKo3Vf0tBZD83VA5I=;
 b=HJgRF9ft8COG7dIf14efTpYQT3xQFmIvJGcE7UHBMcoVViUZ9effD73PtXgEnASOSA5K
 9aktT9HORYBn2FPKyCO8nSy9JbSZo+/0sArHg72RuMQOULY0zkhWpIcD5LUYiF/YbrON
 0BCmWY0yHwjX8FRuStkhayHD55HaBKl8v4HrPmnZS1BztLAyl0oW883qjmpLDBPxn9By
 3Kav91FS/Kb0lGhNclFWRCL9Vo7rGSR/BxBLNrucVxZ3JrcrW89REbqOgxO/wpDJSMZ1
 DX4YoofQaWfgKllDxB/uH3jzJLr39MXJt7vDk5sbmQ0MeF3Nv2mlKBLqGhoNkw4fidCl Lw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3th1cy0gb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 09:45:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3949jP1N023626
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 09:45:25 GMT
Received: from [10.216.40.132] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 4 Oct
 2023 02:45:19 -0700
Message-ID: <f1e9f12d-5b40-0e08-3b67-94cfb0130bc5@quicinc.com>
Date:   Wed, 4 Oct 2023 15:15:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V13 4/4] arm64: dts: ipq6018: add pwm node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thierry.reding@gmail.com>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <baruch@tkos.co.il>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20231004090449.256229-1-quic_devipriy@quicinc.com>
 <20231004090449.256229-5-quic_devipriy@quicinc.com>
 <bcc7ba00-8a45-4ba6-8691-6420782054ff@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <bcc7ba00-8a45-4ba6-8691-6420782054ff@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DZiJwyAXB4MmJvS0cIUJRL6BY088r7TT
X-Proofpoint-GUID: DZiJwyAXB4MmJvS0cIUJRL6BY088r7TT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040070
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/2023 3:13 PM, Krzysztof Kozlowski wrote:
> On 04/10/2023 11:04, Devi Priya wrote:
>> Describe the PWM block on IPQ6018.
>>
>> The PWM is in the TCSR area. Make &tcsr "simple-mfd" compatible, and add
>> &pwm as child of &tcsr.
>>
> 
> ...
> 
>> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
>>
>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> index e59b9df96c7e..429ad7cb681c 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> @@ -390,8 +390,21 @@ tcsr_mutex: hwlock@1905000 {
>>   		};
>>   
>>   		tcsr: syscon@1937000 {
>> -			compatible = "qcom,tcsr-ipq6018", "syscon";
>> +			compatible = "qcom,tcsr-ipq6018", "syscon", "simple-mfd";
>>   			reg = <0x0 0x01937000 0x0 0x21000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges = <0x0 0x0 0x01937000 0x21000>;
> 
> Please put ranges just after reg.
Sure, okay
> 
> With that:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Thank you!

Regards,
Devi Priya
> 
> Best regards,
> Krzysztof
> 
