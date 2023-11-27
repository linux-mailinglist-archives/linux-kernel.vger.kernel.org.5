Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A497F9820
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 05:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjK0EG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 23:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjK0EGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 23:06:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B7318F;
        Sun, 26 Nov 2023 20:06:25 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR2vIa7019476;
        Mon, 27 Nov 2023 04:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qihjlYJ9Zk58q2u/A2EOlARfuTPFniwvFgt/hGDu1KI=;
 b=O3cnkcSEWkRiwYHkTb++i5wQWN2bLVinivz3FWM4c/xgsAHvsp1dkWBrvqM8yPkE2bUI
 bNvWyrWxNiFjn/41jik/y4UnKDG99Zmpk11/IBcfpkHvS3eurr9x9LQuq8GeftXZWqJu
 tg7m4RQrfw2trozboOaospe7UPm+p7irLJ0e+YsifvDU+aCjx/CcokA0vwWa5YFQWV9R
 sXAdvBN4myPOiiv7M1WBJuFAqq/xNJqT0vNVHj1eJw55Te1T60LkD3pB0Ebj3mPNwmD/
 Xh8UaZlf0Wlxn0UKoHFSl65bI0TtrUugMLsu4vtGSHACNmxvW64ZTRyTdmvYADuKXAa+ qg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk8h8k5b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 04:06:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AR46K7m010637
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 04:06:20 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 26 Nov
 2023 20:06:17 -0800
Message-ID: <a64ded1e-af5d-481c-b66c-8019b3d1ad5a@quicinc.com>
Date:   Mon, 27 Nov 2023 12:06:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Fix the warnings from coresight
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
References: <20231124061739.2816-1-quic_jinlmao@quicinc.com>
 <47406b19-811f-47ab-8c08-dd8c4cc5d8bd@linaro.org>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <47406b19-811f-47ab-8c08-dd8c4cc5d8bd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GY5WYH6PdDb_ygZhnmyOvwpkx-9-jj36
X-Proofpoint-GUID: GY5WYH6PdDb_ygZhnmyOvwpkx-9-jj36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_25,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=455 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/2023 3:50 PM, Krzysztof Kozlowski wrote:
> On 24/11/2023 07:17, Mao Jinlong wrote:
>> Fix all warnings in Qualcomm boards coming from Coresight bindings.
> 
> One logical thing, one patch. That applies not only to Linux kernel, but
> to all software projects.
> 
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/msm8996.dtsi | 26 ----------------------
>>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 32 +++++++++++++++++----------
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi  |  5 +----
>>   arch/arm64/boot/dts/qcom/sm8150.dtsi  |  5 +----
>>   arch/arm64/boot/dts/qcom/sm8250.dtsi  | 24 ++++----------------
>>   5 files changed, 26 insertions(+), 66 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> index 6ba9da9e6a8b..e42c22b26adc 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
>> @@ -2637,24 +2637,6 @@ funnel1_out: endpoint {
>>   			};
>>   		};
>>   
>> -		funnel@3023000 {
>> -			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>> -			reg = <0x3023000 0x1000>;
>> -
>> -			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
>> -			clock-names = "apb_pclk", "atclk";
>> -
>> -
>> -			out-ports {
>> -				port {
>> -					funnel2_out: endpoint {
>> -						remote-endpoint =
>> -						  <&merge_funnel_in2>;
>> -					};
>> -				};
>> -			};
>> -		};
> 
> Why do you remove nodes? How is this anyhow related to commit msg?
> Nothing here is explained.
> 
>> -
>>   		funnel@3025000 {
>>   			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
>>   			reg = <0x3025000 0x1000>;
>> @@ -2681,14 +2663,6 @@ merge_funnel_in1: endpoint {
>>   						  <&funnel1_out>;
>>   					};
>>   				};
>> -
>> -				port@2 {
>> -					reg = <2>;
>> -					merge_funnel_in2: endpoint {
>> -						remote-endpoint =
>> -						  <&funnel2_out>;
>> -					};
> 
> Why?
> 
>> -				};
>>   			};
>>   
>>   			out-ports {
>> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> index b485bf925ce6..ebc5ba1b369e 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> @@ -2031,9 +2031,11 @@ etm5: etm@7c40000 {
>>   
>>   			cpu = <&CPU4>;
>>   
>> -			port {
>> -				etm4_out: endpoint {
>> -					remote-endpoint = <&apss_funnel_in4>;
>> +			out-ports {
>> +				port {
> 
> So you want to say out-ports is missing? Commit msg is really not
> explaining anything.
> 
>> +					etm4_out: endpoint {
>> +						remote-endpoint = <&apss_funnel_in4>;
>> +					};
>>   				};
> 
> 
> Best regards,
> Krzysztof
Thanks for the review. I will separate the patches and update the commit 
message.

Thanks
Jinlong Mao

> 
