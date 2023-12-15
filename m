Return-Path: <linux-kernel+bounces-773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45018145D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B741F230DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C331C2A8;
	Fri, 15 Dec 2023 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pfz/CkxI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200761A711;
	Fri, 15 Dec 2023 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF4JFfZ016770;
	Fri, 15 Dec 2023 10:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=i+hYv/pSpw2kbYopGbxDU8au4B+HJ8M+qETIolZ60fY=; b=Pf
	z/CkxIl4dPPmLawgW06YC4vwiPEtKfXIRXfoLTx5Y+InzDaTIp2HzrhSXgQPksAk
	Ny7Pbd/mhlGI7QxCBhvJK/RZJokhl5YdpX5P7wl4pUyI/ujXUjh6BbW8ig+6m+Me
	IhYdmEJAhXlv5l0KRtq/YYMQTZHO/rNneCIW6y+fpPrSTlAwjqyHbRhFQhxZ+vtp
	wGSu/uCgGn3hoaA50+lIgi932A2Tbj8q7ltYqKqhoozL++8GlheqKu/v+sc+S8my
	FPkxfdtGmYU5c0WNCNCJKLhbLctcjHG6VTIGPJb9laDzZOgUbxWC0u6iwitivPji
	il2xCM+fUoVxq6wC7WHw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v090u27qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:41:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFAfApf012150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:41:10 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 02:41:01 -0800
Message-ID: <7bae46fd-63fd-4b86-9a56-73052cf0ea95@quicinc.com>
Date: Fri, 15 Dec 2023 18:40:54 +0800
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
 <4b9c56b8-3b29-4861-a3d5-2da26fbc14b4@quicinc.com>
 <2e77e3b1-00b6-46b9-bfed-7cae3ffa15e9@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <2e77e3b1-00b6-46b9-bfed-7cae3ffa15e9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qiH7OeuuE9BcDQDb3Yvd84bvIAbzZ7-m
X-Proofpoint-ORIG-GUID: qiH7OeuuE9BcDQDb3Yvd84bvIAbzZ7-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=938
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150070



On 12/15/2023 6:37 PM, Krzysztof Kozlowski wrote:
> On 15/12/2023 11:33, Jie Luo wrote:
>>>>>>>>>> +  cmn-reference-clock:
>>>>>>>>>> +    oneOf:
>>>>>>>>>> +      - items:
>>>>>>>>>> +          - enum:
>>>>>>>>>> +              - 0   # CMN PLL reference internal 48MHZ
>>>>>>>>>> +              - 1   # CMN PLL reference external 25MHZ
>>>>>>>>>> +              - 2   # CMN PLL reference external 31250KHZ
>>>>>>>>>> +              - 3   # CMN PLL reference external 40MHZ
>>>>>>>>>> +              - 4   # CMN PLL reference external 48MHZ
>>>>>>>>>> +              - 5   # CMN PLL reference external 50MHZ
>>>>>>>>>> +              - 6   # CMN PLL reference internal 96MHZ
>>>>>>>>>
>>>>>>>>> Why is this not represented by an element of the clocks property?
>>>>>>>>
>>>>>>>> This property is for the reference clock source selection of CMN PLL,
>>>>>>>> CMN PLL generates the different clock rates for the different Ethernet
>>>>>>>> blocks, this CMN PLL configuration is not located in the GCC, so the
>>>>>>>> clock framework can't be used, which is the general hardware register
>>>>>>>> instead of RCG register for GCC.
>>>>>>>
>>>>>>> I don't see how the clock being provided by the "GCC" (whatever that is)
>>>>>>> or by some other clock controller or fixed clock makes a difference.
>>>>>>> Why can't the other clock provider be represented in the devicetree?
>>>>>>>
>>>>>>
>>>>>> cmn-reference-clock is for selecting the reference clock source for the
>>>>>> whole Ethernet block, which is just the standalone configure register.
>>>>>
>>>>> Sure, you are aware though that all clocks are just configure registers?
>>>>>
>>>>> Which clocks are these mentioned in the property? From where do they come?
>>>>>
>>>>> Anyway, property is in existing form is not correct - this is not a
>>>>> generic property.
>>>>>
>>>>
>>>> This property cmn-reference-clock is just the hardware register
>>>> configuration, since the different IPQ platform needs to select
>>>> the different reference clock source for the CMN PLL block that
>>>> provides the various clock outputs to the all kinds of Ethernet
>>>> devices, which is not from GCC provider.
>>>
>>> AGAIN: where do the clocks come from? Which device generates them?
>>
>> Oh, OK, the reference clock is from wifi that provides 48MHZ to
>> Ethernet block.
> 
> Then WiFi should be providing you the clock and this device should be
> clock consumer, right?

Yes, wifi provides 48MHz clock to CMM PLL block, there is no GCC
for this 48MHZ clock output, it is the hardware PIN connection.
> 
> 
> 
> Best regards,
> Krzysztof
> 

