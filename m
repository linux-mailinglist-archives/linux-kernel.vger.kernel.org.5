Return-Path: <linux-kernel+bounces-720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFA3814517
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446B01C2299A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3FC18C3A;
	Fri, 15 Dec 2023 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EqtSz8d0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F918C09;
	Fri, 15 Dec 2023 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF5F27t015003;
	Fri, 15 Dec 2023 10:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BRxgl//zknMrW5V/U7mkOhKeb9Q7bg36q8gBhzKKTVk=; b=Eq
	tSz8d0JLOSAvfnZvIn5IINNlLksNUqgx+FmGfCtUHyG8gDuya26IjO2OqTVzuC8Z
	V+tvnRSJ0/6tUxwzLwtWH7OOW94K9pWLznCriJRTRZGKVbNO6/9vW2ykGZ0vD9iq
	28c9c9QD565f8IJROnmm5RDyx8xWIj6TUm60dX03n16qy08RRBb59op336D019or
	U82/kJxhTUQYjElXb7+sCa3rCYfbZJXVxLyKMP9bYvuF14hcFkmZarv57ZUyhPq8
	x1UunfxTsQNjmFGYxIKZrS8Y48Dq+AbM7+tRvsSJLaqMj9WnYQuqEMJ9PVR/AZAk
	uyWGjXG4huYDYBh7p23g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v05jqj068-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:03:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFA3fHc013778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:03:41 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 02:03:36 -0800
Message-ID: <3de98516-9a28-4f58-8951-2a7752621fee@quicinc.com>
Date: Fri, 15 Dec 2023 18:03:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>
CC: <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231214090304.16884-1-quic_luoj@quicinc.com>
 <20231214090304.16884-6-quic_luoj@quicinc.com>
 <1e4c55c8-8ed6-4f2e-8328-8a173f09b62f@linaro.org>
 <3c8e33b4-6ebc-476f-a00f-15cc8a1ad9e4@quicinc.com>
 <b89abf8c-57f8-46a6-a071-b1591340fbdf@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <b89abf8c-57f8-46a6-a071-b1591340fbdf@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bxKaZEW4wPbab5whn79-T1BjlytsHqbD
X-Proofpoint-GUID: bxKaZEW4wPbab5whn79-T1BjlytsHqbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150067



On 12/15/2023 4:39 PM, Krzysztof Kozlowski wrote:
> On 15/12/2023 09:28, Jie Luo wrote:
>>
>>
>> On 12/15/2023 3:27 PM, Krzysztof Kozlowski wrote:
>>> On 14/12/2023 10:03, Luo Jie wrote:
>>>> Update the yaml file for the new DTS properties.
>>>>
>>>> 1. cmn-reference-clock for the CMN PLL source clock select.
>>>> 2. clock-frequency for MDIO clock frequency config.
>>>> 3. add uniphy AHB & SYS GCC clocks.
>>>> 4. add reset-gpios for MDIO bus level reset.
>>>>
>>>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>>>> ---
>>>>    .../bindings/net/qcom,ipq4019-mdio.yaml       | 143 +++++++++++++++++-
>>>>    1 file changed, 139 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>>>> index 3407e909e8a7..79f8513739e7 100644
>>>> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>>>> @@ -20,6 +20,8 @@ properties:
>>>>              - enum:
>>>>                  - qcom,ipq6018-mdio
>>>>                  - qcom,ipq8074-mdio
>>>> +              - qcom,ipq9574-mdio
>>>> +              - qcom,ipq5332-mdio
> 
> Why do you add entries to the end of the list? In reversed order?

Thanks for pointing it out, i will move "- qcom,ipq5332-mdio" before
"- qcom,ipq6018-mdio".

> 
>>>>              - const: qcom,ipq4019-mdio
>>>>    
>>>>      "#address-cells":
>>>> @@ -30,19 +32,77 @@ properties:
>>>>    
>>>>      reg:
>>>>        minItems: 1
>>>> -    maxItems: 2
>>>> +    maxItems: 5
>>>>        description:
>>>> -      the first Address and length of the register set for the MDIO controller.
>>>> -      the second Address and length of the register for ethernet LDO, this second
>>>> -      address range is only required by the platform IPQ50xx.
>>>> +      the first Address and length of the register set for the MDIO controller,
>>>> +      the optional second, third and fourth address and length of the register
>>>> +      for ethernet LDO, these three address range are required by the platform
>>>> +      IPQ50xx/IPQ5332, the last address and length is for the CMN clock to
>>>> +      select the reference clock.
>>>> +
>>>> +  reg-names:
>>>> +    minItems: 1
>>>> +    maxItems: 5
>>>>    
>>>>      clocks:
>>>> +    minItems: 1
>>>>        items:
>>>>          - description: MDIO clock source frequency fixed to 100MHZ
>>>> +      - description: UNIPHY0 AHB clock source frequency fixed to 100MHZ
>>>> +      - description: UNIPHY1 AHB clock source frequency fixed to 100MHZ
>>>> +      - description: UNIPHY0 SYS clock source frequency fixed to 24MHZ
>>>> +      - description: UNIPHY1 SYS clock source frequency fixed to 24MHZ
>>>>    
>>>>      clock-names:
>>>> +    minItems: 1
>>>>        items:
>>>>          - const: gcc_mdio_ahb_clk
>>>> +      - const: uniphy0_ahb
>>>> +      - const: uniphy1_ahb
>>>> +      - const: uniphy0_sys
>>>> +      - const: uniphy1_sys
>>>> +
>>>> +  cmn-reference-clock:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>
>>> Nothing improved here
>>
>> With this change, the warning is not reported when i run
>> dt_binding_check, looks the new added property needs
>> the type ref to avoid the warning reported.
> 
> Nothing improved in the property name, nor its style, nor in the actual
> contents/values.

This property is for CMN PLL block reference clock configuration,
so i use this property name.

it will be appreciated if you can suggest a suitable name, thanks.

> 
> ...
> 
>>>> +  reset-gpios:
>>>> +    maxItems: 1
>>>> +
>>>> +  reset-assert-us:
>>>> +    maxItems: 1
>>>
>>> This does not look related to ipq5332.
>>
>> The reset gpio properties are needed on ipq5332, since qca8084 phy is
>> connected, which uses the MDIO bus level gpio reset.
> 
> I am talking about this property, not these properties.

ok.

> 
>>
>> Without declaring these gpio properties, the warning will be reported
>> by dt_binding_check.
> 
> How is it even possible to have warnings if there is no such node in
> DTS? We do not care about warnings in your downstream code.
> 
> 
> Best regards,
> Krzysztof
> 

If i do not declare the property "reset-assert-us" and 
"reset-deassert-us", the warning will be reported by "make 
dt_binding_check" since i
add a example in this file.



