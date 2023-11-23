Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C25A7F58E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344837AbjKWHNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKWHNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:13:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E05CB;
        Wed, 22 Nov 2023 23:13:48 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN6u2Rs014625;
        Thu, 23 Nov 2023 07:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pAQAfqihYi2DiVm04BqeShmGb4dAjJKqb3uGVZ3wapA=;
 b=dUKGSkAp3KRRjqDy12n0HrLhPXu8uH81qhNmHFKiCPW7lDsMAjNgODWWzhad+/dG1BVA
 Z7qD8sEXtA1qRBXf0hPEI9MfWnEiMtGiFYQ5U6frhXhG7e54kyAIfkQ5DtMjJMzISSmr
 MHpTSb2oWjAG9dH6YWGs5XUopZ8NrX+CvDpOHrqqEhCeHRodNJ2Q8xmLLByml0KHJOxk
 VmkDJcHiJ8nOnVSnPMavx2xylcLtqQ9BSAsMQDH8O2iodG3uspb2ibRgZ9NnkagHShId
 ngO0/7rEbdi1CvsXWFOdhhWbljPouQx8dz0fogeE2N1SQftl02RYH3pzVr0y3F3/Q53B 7g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uhgudaadv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 07:13:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AN7DPe2021541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 07:13:25 GMT
Received: from [10.216.58.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 23:13:17 -0800
Message-ID: <459005b7-df82-48c1-a85f-d4125ddde124@quicinc.com>
Date:   Thu, 23 Nov 2023 12:43:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] arm64: dts: qcom: ipq5332: add support for the
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
References: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
 <20231121-ipq5332-nsscc-v2-8-a7ff61beab72@quicinc.com>
 <8cece5d7-0fcb-4366-be72-6494842b7c41@linaro.org>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <8cece5d7-0fcb-4366-be72-6494842b7c41@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V7vh9dVEOWNCbszbHchbgdNhNVn2IHq-
X-Proofpoint-ORIG-GUID: V7vh9dVEOWNCbszbHchbgdNhNVn2IHq-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_04,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311230049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2023 1:52 AM, Konrad Dybcio wrote:
> 
> 
> On 11/21/23 15:30, Kathiravan Thirumoorthy wrote:
>> Describe the NSS clock controller node and it's relevant external
>> clocks.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>> ---
>> Changes in V2:
>>     - Update the node names with proper suffix
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index 42e2e48b2bc3..5cbe72f03869 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -15,6 +15,18 @@ / {
>>       #size-cells = <2>;
>>       clocks {
>> +        cmn_pll_nss_200m_clk: cmn-pll-nss-200m-clk {
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <200000000>;
>> +            #clock-cells = <0>;
>> +        };
>> +
>> +        cmn_pll_nss_300m_clk: cmn-pll-nss-300m-clk {
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <300000000>;
>> +            #clock-cells = <0>;
>> +        };
>> +
>>           sleep_clk: sleep-clk {
>>               compatible = "fixed-clock";
>>               #clock-cells = <0>;
>> @@ -473,6 +485,22 @@ frame@b128000 {
>>                   status = "disabled";
>>               };
>>           };
>> +
>> +        nsscc: clock-controller@39b00000{
>> +            compatible = "qcom,ipq5332-nsscc";
>> +            reg = <0x39b00000 0x80000>;
>> +            clocks = <&cmn_pll_nss_200m_clk>,
>> +                 <&cmn_pll_nss_300m_clk>,
>> +                 <&gcc GPLL0_OUT_AUX>,
>> +                 <0>,
>> +                 <0>,
>> +                 <0>,
>> +                 <0>,
>> +                 <&xo_board>;
>> +            #clock-cells = <0x1>;
>> +            #reset-cells = <0x1>;
> 0x1 -> 1, it's a number and not a register

Thanks for pointing it out, will fix it in next spin.
> 
> Konrad
