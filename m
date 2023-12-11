Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C611480CB01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbjLKN2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343657AbjLKN2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:28:48 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E219A;
        Mon, 11 Dec 2023 05:28:54 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBC8E0u015496;
        Mon, 11 Dec 2023 13:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=hzRg9lQ5wlvR0ytjhVGFgNlqq8PzBZgXecIaD+b3f5o=; b=cP
        gHfUJLAzqJ97458KmQWIMlpD3D7As1DN2mJeOkyfbz06ccpDYGkeIzXz78Mqt3/y
        TZLvyM26yYu7DW2pomydC7a+fR8oY/wtZ+bF4hM876Vqp7yPbt7AihVw4zbEZbsK
        UWk69GH2TEpUy4yfPDnqnyaHgaMeucTv04mhwb9oXglS9Oq6G2YMpO+fxDc/2rBX
        oz06R2L1sWxrmCm9O1N6MiTuSxYS6GGnE8v6ze2KFLDdus4lwm0d0ou+TGXe5uyK
        bu9ZWn8FT3K1mQYZ20D4XjeChwQxS8V88J89mqP9lQwM2lhlILlXtTj2U2hAe3jd
        BT8ek/GQq8Sz471LbPSw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ux25u05d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 13:28:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BBDSEHg021946
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 13:28:15 GMT
Received: from [10.216.51.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Dec
 2023 05:28:07 -0800
Message-ID: <8cc2a8ec-632e-4e3b-b13b-d1523a61c136@quicinc.com>
Date:   Mon, 11 Dec 2023 18:58:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: ipq5332: add support for the
 NSSCC
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20231211-ipq5332-nsscc-v3-0-ad13bef9b137@quicinc.com>
 <20231211-ipq5332-nsscc-v3-7-ad13bef9b137@quicinc.com>
 <c4034715-53a5-468e-914a-3f19d0618c42@linaro.org>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <c4034715-53a5-468e-914a-3f19d0618c42@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8dumfZNAehoavwUfHH3scMscGUxFzQAu
X-Proofpoint-GUID: 8dumfZNAehoavwUfHH3scMscGUxFzQAu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2023 4:02 PM, Konrad Dybcio wrote:
> On 11.12.2023 04:37, Kathiravan Thirumoorthy wrote:
>> Describe the NSS clock controller node and it's relevant external
>> clocks.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index 42e2e48b2bc3..a1504f6c40c1 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -15,6 +15,18 @@ / {
>>   	#size-cells = <2>;
>>   
>>   	clocks {
>> +		cmn_pll_nss_200m_clk: cmn-pll-nss-200m-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <200000000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		cmn_pll_nss_300m_clk: cmn-pll-nss-300m-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <300000000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>>   		sleep_clk: sleep-clk {
>>   			compatible = "fixed-clock";
>>   			#clock-cells = <0>;
>> @@ -473,6 +485,22 @@ frame@b128000 {
>>   				status = "disabled";
>>   			};
>>   		};
>> +
>> +		nsscc: clock-controller@39b00000{
> Missing space between the opening curly brace

My bad :( will fix it in next spin.

> 
>> +			compatible = "qcom,ipq5332-nsscc";
>> +			reg = <0x39b00000 0x80000>;
> the regmap_config in the clk driver has .max_register = 0x800, is this
> correct?

As per the memory map, 512KB is the size of this block. However the last 
register in that region is at the offset 0x800. Shall I update the 
max_register also to 512KB to keep it consistency?


> 
> 
> Konrad
