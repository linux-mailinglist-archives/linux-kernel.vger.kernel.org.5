Return-Path: <linux-kernel+bounces-11355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3918981E50F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6634282BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9254B5B4;
	Tue, 26 Dec 2023 05:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pru6ZLVa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDDE4B12B;
	Tue, 26 Dec 2023 05:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BQ52MXB007526;
	Tue, 26 Dec 2023 05:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=NKISodyv7L5WQ1e9xudYOVUIOYOCl7Cp0/KhkGuHHS8=; b=pr
	u6ZLVavTzmKyaV3kyujmzSWFe8SBjP1OtEJ6YEljZ9QgMg/aGxrjc7sdf6jHq1kB
	FdfO8wiEQTvDgqofsqh+wuO0AFCPBN/JF6N9Dn9HCzqCbD/KppwebVhozdRFbvF0
	FALo2O6Nca3uZHWbeD4TFADqcHnhlx3ruCHUC5ipSzsxWArj5oxyXljuMBOReNI4
	Qu3H14hYNBKCyagPQLsUmJ55gdM1n6onvTW36Pb4SteQz6gbrKnltyoKYSwoGtLe
	8oIH0rZqoWPuglRpLNXLFz/wgAS3EhGvkcZL32xij9XVM9xe4+F+QWqEqyr5sLSU
	HkU+9TW8iHUNUu9h1tgw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v7baq956r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 05:37:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BQ5beH9026647
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 05:37:40 GMT
Received: from [10.216.59.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Dec
 2023 21:37:35 -0800
Message-ID: <268f9f54-8b2a-42bb-9a5d-10bd930cb282@quicinc.com>
Date: Tue, 26 Dec 2023 11:07:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 binding
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bjorn
 Andersson" <bjorn.andersson@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Johan
 Hovold" <johan@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Andy Gross <agross@kernel.org>
References: <20231222063648.11193-1-quic_kriskura@quicinc.com>
 <20231222063648.11193-2-quic_kriskura@quicinc.com>
 <e6419898-0d77-4286-a04b-7240eb90d8df@linaro.org>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <e6419898-0d77-4286-a04b-7240eb90d8df@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Prfdge6fS4ZNsx5Sg5ZKn9v0bAu56B6q
X-Proofpoint-GUID: Prfdge6fS4ZNsx5Sg5ZKn9v0bAu56B6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=511 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312260040



On 12/25/2023 6:35 PM, Krzysztof Kozlowski wrote:
> On 22/12/2023 07:36, Krishna Kurapati wrote:
>> The high speed related interrupts present on QC targets are as follows:
>>
> 
> 
>>   
>>     interrupt-names:
>> -    minItems: 1
>> -    maxItems: 4
>> +    minItems: 2
>> +    maxItems: 5
>>   
>>     qcom,select-utmi-as-pipe-clk:
>>       description:
>> @@ -361,60 +378,21 @@ allOf:
>>           compatible:
>>             contains:
>>               enum:
>> -              - qcom,ipq4019-dwc3
> 
> Why do you remove it, without adding it somewhere else. Nothing in the
> commit msg explains it.
> 

Apologies, Will check and add it back.

>> +              - qcom,ipq5018-dwc3
>>                 - qcom,ipq6018-dwc3
>> -              - qcom,ipq8064-dwc3
>>                 - qcom,ipq8074-dwc3
>> -              - qcom,msm8994-dwc3
>> -              - qcom,qcs404-dwc3
>> -              - qcom,sc7180-dwc3
>> -              - qcom,sdm670-dwc3
>> -              - qcom,sdm845-dwc3
>> -              - qcom,sdx55-dwc3
>> -              - qcom,sdx65-dwc3
>> -              - qcom,sdx75-dwc3
>> -              - qcom,sm4250-dwc3
>> -              - qcom,sm6350-dwc3
>> -              - qcom,sm8150-dwc3
>> -              - qcom,sm8250-dwc3
>> -              - qcom,sm8350-dwc3
>> -              - qcom,sm8450-dwc3
>> -              - qcom,sm8550-dwc3
>> -              - qcom,sm8650-dwc3
>> -    then:
>> -      properties:
>> -        interrupts:
>> -          items:
>> -            - description: The interrupt that is asserted
>> -                when a wakeup event is received on USB2 bus.
>> -            - description: The interrupt that is asserted
>> -                when a wakeup event is received on USB3 bus.
>> -            - description: Wakeup event on DM line.
>> -            - description: Wakeup event on DP line.
>> -        interrupt-names:
>> -          items:
>> -            - const: hs_phy_irq
>> -            - const: ss_phy_irq
>> -            - const: dm_hs_phy_irq
>> -            - const: dp_hs_phy_irq
>> -
>> -  - if:
>> -      properties:
>> -        compatible:
>> -          contains:
>> -            enum:
>>                 - qcom,msm8953-dwc3
>> -              - qcom,msm8996-dwc3
>>                 - qcom,msm8998-dwc3
>> -              - qcom,sm6115-dwc3
>> -              - qcom,sm6125-dwc3
>> +              - qcom,qcm2290-dwc3
>>       then:
>>         properties:
>>           interrupts:
>> -          maxItems: 2
>> +          minItems: 2
>> +          maxItems: 3
>>           interrupt-names:
>>             items:
>> -            - const: hs_phy_irq
>> +            - const: pwr_event
>> +            - const: qusb2_phy
>>               - const: ss_phy_irq
>>   
>>     - if:
>> @@ -422,37 +400,21 @@ allOf:
>>           compatible:
>>             contains:
>>               enum:
>> -              - qcom,ipq5018-dwc3
>> -              - qcom,ipq5332-dwc3
>> +              - qcom,msm8996-dwc3
>> +              - qcom,qcs404-dwc3
>>                 - qcom,sdm660-dwc3
>> -    then:
>> -      properties:
>> -        interrupts:
>> -          minItems: 1
>> -          maxItems: 2
>> -        interrupt-names:
>> -          minItems: 1
>> -          items:
>> -            - const: hs_phy_irq
>> -            - const: ss_phy_irq
>> -
>> -  - if:
>> -      properties:
>> -        compatible:
>> -          contains:
>> -            enum:
>> -              - qcom,sc7280-dwc3
>> +              - qcom,sm6115-dwc3
>> +              - qcom,sm6125-dwc3
>>       then:
>>         properties:
>>           interrupts:
>>             minItems: 3
>>             maxItems: 4
>>           interrupt-names:
>> -          minItems: 3
>>             items:
>> +            - const: pwr_event
>>               - const: hs_phy_irq
>> -            - const: dp_hs_phy_irq
>> -            - const: dm_hs_phy_irq
>> +            - const: qusb2_phy
> 
> Why qusb2_phy is after hs_phy_irq? In the earlier if:then: it is the
> second one.
> 

In v3 as well, the hs_phy_irq is before qusb2_phy interrupt:
https://lore.kernel.org/all/20231211121124.4194-2-quic_kriskura@quicinc.com/

> 
>>               - const: ss_phy_irq
>>   
>>     - if:
>> @@ -460,11 +422,13 @@ allOf:
>>           compatible:
>>             contains:
>>               enum:
>> +              - qcom,ipq5332-dwc3
>>                 - qcom,sc8280xp-dwc3
>>                 - qcom,x1e80100-dwc3
>>       then:
>>         properties:
>>           interrupts:
>> +          minItems: 3
> 
> Hm, why? This commit is unmanageable. Your commit msg is already huge
> but still does not explain this. Are you sure you are fixing only one
> logical thing per patch? Does not look like.
> 

This is reordering the targets based on interrupts they have. I put it 
in one commit because splitting this into multiple patches breaks one 
thing or other. Also once I am defining permutations, I have to group 
targets into these combinations in the same patch. I know this is a big 
commit but it solves the interrupt cleanup and defines a way for future 
targets.

Regards,
Krishna,

