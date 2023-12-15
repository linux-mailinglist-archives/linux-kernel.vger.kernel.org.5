Return-Path: <linux-kernel+bounces-858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE4814727
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A20B2174B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C825546;
	Fri, 15 Dec 2023 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F9eh01gU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8A124B59;
	Fri, 15 Dec 2023 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFBDspj029068;
	Fri, 15 Dec 2023 11:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YKUiqBVw6OWlqi1p+nzC/T/GBXXbHrpi6T1kO/Zhncs=; b=F9
	eh01gUzNwlZQrgS4VH/gEVyzwtAydLLWpS9ERWYTx6tZB0yN6zxIz3o7uXetSbpK
	crkeHPz4qx8YocUK+ly7TetTCJS5v2atp7k6vX6/j4P2b4v40VLWgrmT5ALEkAua
	jEYAijj2kw+dttaV5nGQS/tntjc1kgdcxQIWmh7/7uxxmBt8pOLWMsOKtOumjHxv
	DBXoUyKtOs3ADcSRqHm4kt5sMsjBc9hCliUZ/3xcatbO0FmwtZeeGi8tsge5qGZ4
	WnjD4MeAb5lTx5gASPspJ5Z4gZmxM/rEeK7+NpxYh46JEDM8YSZjjFv3ilOttt3a
	NUzOf8vLzSaQRUXwRRnA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hdf8uts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 11:42:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFBgCjX012108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 11:42:12 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 03:42:07 -0800
Message-ID: <7466b655-2b7e-44f2-a510-6e0cc1b95248@quicinc.com>
Date: Fri, 15 Dec 2023 19:42:04 +0800
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
 <7bae46fd-63fd-4b86-9a56-73052cf0ea95@quicinc.com>
 <5a8095e6-b6a6-4d11-b006-31519e8d8622@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <5a8095e6-b6a6-4d11-b006-31519e8d8622@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0oW0G03b6P3eW9FhPhSjtMz9wI_PHHAv
X-Proofpoint-GUID: 0oW0G03b6P3eW9FhPhSjtMz9wI_PHHAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=985 impostorscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150077



On 12/15/2023 6:53 PM, Krzysztof Kozlowski wrote:
> On 15/12/2023 11:40, Jie Luo wrote:
>>
>>
>> On 12/15/2023 6:37 PM, Krzysztof Kozlowski wrote:
>>> On 15/12/2023 11:33, Jie Luo wrote:
>>>>>>>>>>>> +  cmn-reference-clock:
>>>>>>>>>>>> +    oneOf:
>>>>>>>>>>>> +      - items:
>>>>>>>>>>>> +          - enum:
>>>>>>>>>>>> +              - 0   # CMN PLL reference internal 48MHZ
>>>>>>>>>>>> +              - 1   # CMN PLL reference external 25MHZ
>>>>>>>>>>>> +              - 2   # CMN PLL reference external 31250KHZ
>>>>>>>>>>>> +              - 3   # CMN PLL reference external 40MHZ
>>>>>>>>>>>> +              - 4   # CMN PLL reference external 48MHZ
>>>>>>>>>>>> +              - 5   # CMN PLL reference external 50MHZ
>>>>>>>>>>>> +              - 6   # CMN PLL reference internal 96MHZ
>>>>>>>>>>>
>>>>>>>>>>> Why is this not represented by an element of the clocks property?
>>>>>>>>>>
>>>>>>>>>> This property is for the reference clock source selection of CMN PLL,
>>>>>>>>>> CMN PLL generates the different clock rates for the different Ethernet
>>>>>>>>>> blocks, this CMN PLL configuration is not located in the GCC, so the
>>>>>>>>>> clock framework can't be used, which is the general hardware register
>>>>>>>>>> instead of RCG register for GCC.
>>>>>>>>>
>>>>>>>>> I don't see how the clock being provided by the "GCC" (whatever that is)
>>>>>>>>> or by some other clock controller or fixed clock makes a difference.
>>>>>>>>> Why can't the other clock provider be represented in the devicetree?
>>>>>>>>>
>>>>>>>>
>>>>>>>> cmn-reference-clock is for selecting the reference clock source for the
>>>>>>>> whole Ethernet block, which is just the standalone configure register.
>>>>>>>
>>>>>>> Sure, you are aware though that all clocks are just configure registers?
>>>>>>>
>>>>>>> Which clocks are these mentioned in the property? From where do they come?
>>>>>>>
>>>>>>> Anyway, property is in existing form is not correct - this is not a
>>>>>>> generic property.
>>>>>>>
>>>>>>
>>>>>> This property cmn-reference-clock is just the hardware register
>>>>>> configuration, since the different IPQ platform needs to select
>>>>>> the different reference clock source for the CMN PLL block that
>>>>>> provides the various clock outputs to the all kinds of Ethernet
>>>>>> devices, which is not from GCC provider.
>>>>>
>>>>> AGAIN: where do the clocks come from? Which device generates them?
>>>>
>>>> Oh, OK, the reference clock is from wifi that provides 48MHZ to
>>>> Ethernet block.
>>>
>>> Then WiFi should be providing you the clock and this device should be
>>> clock consumer, right?
>>
>> Yes, wifi provides 48MHz clock to CMM PLL block, there is no GCC
>> for this 48MHZ clock output, it is the hardware PIN connection.
> 
> All clocks are some hardware pin connections.
> 
> Best regards,
> Krzysztof
> 

Yes, all reference clocks here are from hardware pin connection.

