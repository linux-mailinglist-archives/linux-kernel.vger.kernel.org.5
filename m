Return-Path: <linux-kernel+bounces-763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703F38145B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E81E1C23117
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C22249F2;
	Fri, 15 Dec 2023 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Su+5Fsu2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F724B47;
	Fri, 15 Dec 2023 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF52exE014231;
	Fri, 15 Dec 2023 10:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ErghD2DU58fu4FrgHwTi/CSNEsLFLKIVRl/dA43D9K4=; b=Su
	+5Fsu2Jv1t56qyrnS+BEpsrmjJgtkEcpEoFmKrBcaeYR6sI0KRj893NLwliJorRC
	8BXld7k4MDV+IdMmDw1m09hldDN5YF2GaRxN1QFxRg++uYMeThDJklvaLYAGfBWb
	FqNken6A/SB4j0ZbhRZqDsw7WZnGUrfS5q6eIgC5x1xrFO8IITGoY5qurbaTRo3v
	jaW+PKQvgtmbIbTo8zjat4IDlu+Pe1Grt13sfZTebYqRlwqkvUbmjJgfpIhNK6Y9
	KDwcQrZ36YTsroO7rcdTTwv2clrepgj1src1lyZ4iX2pXN2gLWW4eGJtL4uziSFp
	NwHKucii/qvLUTqBW55w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v07c62r2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:33:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFAX9tT021425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:33:09 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 02:33:03 -0800
Message-ID: <4b9c56b8-3b29-4861-a3d5-2da26fbc14b4@quicinc.com>
Date: Fri, 15 Dec 2023 18:33:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley
	<conor@kernel.org>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
 <20231212115151.20016-6-quic_luoj@quicinc.com>
 <20231212-caution-improvise-ed3cc6a1d305@spud>
 <11ffc985-3f2b-46b9-ae0b-911f7abe98d1@quicinc.com>
 <20231214-outshine-shush-8a11c68607cd@spud>
 <c5123ce7-6fdc-43c7-ac07-251c39196e66@quicinc.com>
 <a1e5ffec-a20d-4389-83f9-ee09bd9d733d@linaro.org>
 <a84a36af-69f8-46af-967e-b06d028597a3@quicinc.com>
 <26c8b0b1-5ea9-45cc-adf3-0d0b03a1284d@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <26c8b0b1-5ea9-45cc-adf3-0d0b03a1284d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y6nGBTW_zJBwfy1rJG7Tc75ilNabOBc5
X-Proofpoint-ORIG-GUID: y6nGBTW_zJBwfy1rJG7Tc75ilNabOBc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150070



On 12/15/2023 6:19 PM, Krzysztof Kozlowski wrote:
> On 15/12/2023 10:49, Jie Luo wrote:
>>
>>
>> On 12/15/2023 3:29 PM, Krzysztof Kozlowski wrote:
>>> On 15/12/2023 07:46, Jie Luo wrote:
>>>>
>>>>
>>>> On 12/15/2023 1:12 AM, Conor Dooley wrote:
>>>>> On Wed, Dec 13, 2023 at 04:26:56PM +0800, Jie Luo wrote:
>>>>>>
>>>>>>
>>>>>> On 12/13/2023 12:06 AM, Conor Dooley wrote:
>>>>>>> On Tue, Dec 12, 2023 at 07:51:50PM +0800, Luo Jie wrote:
>>>>>>>> Update the yaml file for the new DTS properties.
>>>>>>>>
>>>>>>>> 1. cmn-reference-clock for the CMN PLL source clock select.
>>>>>>>> 2. clock-frequency for MDIO clock frequency config.
>>>>>>>> 3. add uniphy AHB & SYS GCC clocks.
>>>>>>>> 4. add reset-gpios for MDIO bus level reset.
>>>>>>>>
>>>>>>>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>>>>>>>> ---
>>>>>>>>      .../bindings/net/qcom,ipq4019-mdio.yaml       | 157 +++++++++++++++++-
>>>>>>>>      1 file changed, 153 insertions(+), 4 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>>>>>>>> index 3407e909e8a7..9546a6ad7841 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>>>>>>>> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
>>>>>>>> @@ -20,6 +20,8 @@ properties:
>>>>>>>>                - enum:
>>>>>>>>                    - qcom,ipq6018-mdio
>>>>>>>>                    - qcom,ipq8074-mdio
>>>>>>>> +              - qcom,ipq9574-mdio
>>>>>>>> +              - qcom,ipq5332-mdio
>>>>>>>>                - const: qcom,ipq4019-mdio
>>>>>>>>        "#address-cells":
>>>>>>>> @@ -30,19 +32,71 @@ properties:
>>>>>>>>        reg:
>>>>>>>>          minItems: 1
>>>>>>>> -    maxItems: 2
>>>>>>>> +    maxItems: 5
>>>>>>>>          description:
>>>>>>>> -      the first Address and length of the register set for the MDIO controller.
>>>>>>>> -      the second Address and length of the register for ethernet LDO, this second
>>>>>>>> -      address range is only required by the platform IPQ50xx.
>>>>>>>> +      the first Address and length of the register set for the MDIO controller,
>>>>>>>> +      the optional second, third and fourth address and length of the register
>>>>>>>> +      for ethernet LDO, these three address range are required by the platform
>>>>>>>> +      IPQ50xx/IPQ5332/IPQ9574, the last address and length is for the CMN clock
>>>>>>>> +      to select the reference clock.
>>>>>>>> +
>>>>>>>> +  reg-names:
>>>>>>>> +    minItems: 1
>>>>>>>> +    maxItems: 5
>>>>>>>>        clocks:
>>>>>>>> +    minItems: 1
>>>>>>>>          items:
>>>>>>>>            - description: MDIO clock source frequency fixed to 100MHZ
>>>>>>>> +      - description: UNIPHY0 AHB clock source frequency fixed to 100MHZ
>>>>>>>> +      - description: UNIPHY1 AHB clock source frequency fixed to 100MHZ
>>>>>>>> +      - description: UNIPHY0 SYS clock source frequency fixed to 24MHZ
>>>>>>>> +      - description: UNIPHY1 SYS clock source frequency fixed to 24MHZ
>>>>>>>>        clock-names:
>>>>>>>> +    minItems: 1
>>>>>>>>          items:
>>>>>>>>            - const: gcc_mdio_ahb_clk
>>>>>>>> +      - const: gcc_uniphy0_ahb_clk
>>>>>>>> +      - const: gcc_uniphy1_ahb_clk
>>>>>>>> +      - const: gcc_uniphy0_sys_clk
>>>>>>>> +      - const: gcc_uniphy1_sys_clk
>>>>>>>
>>>>>>>> +  cmn-reference-clock:
>>>>>>>> +    oneOf:
>>>>>>>> +      - items:
>>>>>>>> +          - enum:
>>>>>>>> +              - 0   # CMN PLL reference internal 48MHZ
>>>>>>>> +              - 1   # CMN PLL reference external 25MHZ
>>>>>>>> +              - 2   # CMN PLL reference external 31250KHZ
>>>>>>>> +              - 3   # CMN PLL reference external 40MHZ
>>>>>>>> +              - 4   # CMN PLL reference external 48MHZ
>>>>>>>> +              - 5   # CMN PLL reference external 50MHZ
>>>>>>>> +              - 6   # CMN PLL reference internal 96MHZ
>>>>>>>
>>>>>>> Why is this not represented by an element of the clocks property?
>>>>>>
>>>>>> This property is for the reference clock source selection of CMN PLL,
>>>>>> CMN PLL generates the different clock rates for the different Ethernet
>>>>>> blocks, this CMN PLL configuration is not located in the GCC, so the
>>>>>> clock framework can't be used, which is the general hardware register
>>>>>> instead of RCG register for GCC.
>>>>>
>>>>> I don't see how the clock being provided by the "GCC" (whatever that is)
>>>>> or by some other clock controller or fixed clock makes a difference.
>>>>> Why can't the other clock provider be represented in the devicetree?
>>>>>
>>>>
>>>> cmn-reference-clock is for selecting the reference clock source for the
>>>> whole Ethernet block, which is just the standalone configure register.
>>>
>>> Sure, you are aware though that all clocks are just configure registers?
>>>
>>> Which clocks are these mentioned in the property? From where do they come?
>>>
>>> Anyway, property is in existing form is not correct - this is not a
>>> generic property.
>>>
>>
>> This property cmn-reference-clock is just the hardware register
>> configuration, since the different IPQ platform needs to select
>> the different reference clock source for the CMN PLL block that
>> provides the various clock outputs to the all kinds of Ethernet
>> devices, which is not from GCC provider.
> 
> AGAIN: where do the clocks come from? Which device generates them?

Oh, OK, the reference clock is from wifi that provides 48MHZ to
Ethernet block.

> 
>>
>> This is indeed not a generic property, which is the Ethernet
>> function configs same as clock-frequency.
> 
> 
> Then it should not be made as a generic property...

sure, i saw your another comments, will prefix qcom_ on this property.

> 
> 
> 
> Best regards,
> Krzysztof
> 

