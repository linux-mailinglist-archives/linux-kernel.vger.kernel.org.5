Return-Path: <linux-kernel+bounces-2234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEF6815A02
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50135B23F77
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB3530351;
	Sat, 16 Dec 2023 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZmY88sC5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123D30108;
	Sat, 16 Dec 2023 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BGFaYwv014522;
	Sat, 16 Dec 2023 15:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=uGlb/TPNWpEJl79n9W8Wm6WCK61dQReXPFFaCE45owc=; b=Zm
	Y88sC5CrFHI3xDKOSXJ3BduaK4sqeem4iAC19Nsui+6+UOZysvF5U3IRNUSZ4F7L
	5SPbCNvzqZVxV0K6Seg8MsWPWRIXwpl4cu28qMRfFyvcaOQDWJ2kkznSjZkK1Wui
	Eu0B2WslUGuhePxUWATXwGXn5s7Z1w12pWqY/AqPO8a4su+W74ygzBLdsOn0goT8
	ONves22MhnoNHLDsMADSQB7pm6Ewznh23SFm7yB4yuTAk8BvsfYpQDFsbpHYVhDO
	9qPa4ylvlzGECVf+u/+WopnStaLLJrTx4qgv5mUqcQdWnFDlrVPhXgPHGAVkXsQ7
	ZO7IIi7oiiZW5JVvM5bQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v152q8rj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 15:37:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BGFbG4M013078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 15:37:16 GMT
Received: from [10.253.9.247] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 16 Dec
 2023 07:37:11 -0800
Message-ID: <af1dff98-a63e-47b3-a709-6f4110a97529@quicinc.com>
Date: Sat, 16 Dec 2023 23:37:08 +0800
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
To: Conor Dooley <conor@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <26c8b0b1-5ea9-45cc-adf3-0d0b03a1284d@linaro.org>
 <4b9c56b8-3b29-4861-a3d5-2da26fbc14b4@quicinc.com>
 <2e77e3b1-00b6-46b9-bfed-7cae3ffa15e9@linaro.org>
 <7bae46fd-63fd-4b86-9a56-73052cf0ea95@quicinc.com>
 <5a8095e6-b6a6-4d11-b006-31519e8d8622@linaro.org>
 <7466b655-2b7e-44f2-a510-6e0cc1b95248@quicinc.com>
 <602759ce-c93d-4111-9272-1dce7e4a170a@linaro.org>
 <f656d1c7-ea86-405a-9165-9eb079ea6f2a@quicinc.com>
 <20231215-gauze-sprinkled-172729f22b6c@spud>
 <9eab958e-d91f-4f3c-aadd-6b34eaed2cef@quicinc.com>
 <20231216-unearned-lucid-4bd2ddcd4ac2@spud>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231216-unearned-lucid-4bd2ddcd4ac2@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ApFIEr5kM3vkvqXQ_SqxM_VKXP6SgMOc
X-Proofpoint-GUID: ApFIEr5kM3vkvqXQ_SqxM_VKXP6SgMOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160121



On 12/16/2023 10:16 PM, Conor Dooley wrote:
> On Sat, Dec 16, 2023 at 09:16:49PM +0800, Jie Luo wrote:
>>
>>
>> On 12/15/2023 9:41 PM, Conor Dooley wrote:
>>> On Fri, Dec 15, 2023 at 08:40:20PM +0800, Jie Luo wrote:
>>>>
>>>>
>>>> On 12/15/2023 8:19 PM, Krzysztof Kozlowski wrote:
>>>>> On 15/12/2023 12:42, Jie Luo wrote:
>>>>>>>>>>>>> Which clocks are these mentioned in the property? From where do they come?
>>>>>>>>>>>>>
>>>>>>>>>>>>> Anyway, property is in existing form is not correct - this is not a
>>>>>>>>>>>>> generic property.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> This property cmn-reference-clock is just the hardware register
>>>>>>>>>>>> configuration, since the different IPQ platform needs to select
>>>>>>>>>>>> the different reference clock source for the CMN PLL block that
>>>>>>>>>>>> provides the various clock outputs to the all kinds of Ethernet
>>>>>>>>>>>> devices, which is not from GCC provider.
>>>>>>>>>>>
>>>>>>>>>>> AGAIN: where do the clocks come from? Which device generates them?
>>>>>>>>>>
>>>>>>>>>> Oh, OK, the reference clock is from wifi that provides 48MHZ to
>>>>>>>>>> Ethernet block.
>>>>>>>>>
>>>>>>>>> Then WiFi should be providing you the clock and this device should be
>>>>>>>>> clock consumer, right?
>>>>>>>>
>>>>>>>> Yes, wifi provides 48MHz clock to CMM PLL block, there is no GCC
>>>>>>>> for this 48MHZ clock output, it is the hardware PIN connection.
>>>>>>>
>>>>>>> All clocks are some hardware pin connections.
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Krzysztof
>>>>>>>
>>>>>>
>>>>>> Yes, all reference clocks here are from hardware pin connection.
>>>>>
>>>>> You keep answering with short sentences without touching the root of the
>>>>> problem. I don't know exactly why, but I feel this discussion leads
>>>>> nowhere. After long discussion you finally admitted that clocks came
>>>>> from another device - Wifi. It took us like 6 emails?
>>>>>
>>>>> So last statement: if you have clock provider and clock consumer, you
>>>>> must represent it in the bindings or provide rationale why it should not
>>>>> or must not be represented in the bindings. So far I do not see any of
>>>>> such arguments.
>>>>>
>>>>> If you use arguments like:
>>>>> "My driver....": sorry, bindings are not about drivers
>>>>> "I don't have clock driver for WiFi": sorry, it does not matter if you
>>>>> can write one, right?
>>>>>
>>>>> Please reach internally your colleagues to solve these problems and make
>>>>> review process smoother.
>>>
>>>> These reference clocks source do not need the hardware configuration,
>>>> that is the reason why the clock provider is not needed, some reference
>>>> clock source are even from external crystal.
>>>
>>> I fail to understand how that makes this clock different to the clocks
>>> on any other platform. Clocks from external crystals are present in many
>>> many systems. See for example fixed-clock.yaml.
>>
>> The reference clock rate has no meaning to the CMN PLL block, since the
>> software can't control the behavior of CMN PLL, and various output
>> clocks of CMN PLL block are fixed, adding this custom property is just
>> for selecting the different reference clock source, since different
>> IPQ platform needs to be configured the different reference clock source
>> for the CMN PLL block.
> 
> Many, many other systems are in the same situation, where clocks are
> provided to a peripheral that has no control over the clock rate, but
> has to pick internal dividers or set bits in a config register depending
> on what clock rate is provided to it. That is not something special
> about this particular platform and other systems are able to use the
> clocks property for this purpose.

Sure, Thanks Conor for this information.
i will try to replace this custom property with clocks property and
verify the drive.

> 
>> let's say if we register 48MHZ reference clock as the fix clock, we
>> can't distinguish it is internal 48MHZ or external 48MHZ, for these
>> two reference clock sources, there are different hardware configuration
>> of CMN PLL block
> 
> That's easy, if the reference is external, it is provided by the clocks
> property. If it internal, then there will be no clocks property
> providing it.

Thanks for this detail.

> 
>> and this reference clock selection is not applicable
>> for the IPQ4019 platform.
> 
> Isn't this a patch for the IPQ4019? Why would it not be relevant?
IPQ4019 is the legacy chip, and the same MDIO bus driver is also
extended to support the new IPQ platform, since the MDIO hardware
is leveraged by the new IPQ platform.

For the CMN PLL block, which is not existed on the legacy platform
IPQ4019, but it does not matter, we can also distinguish it according
to the CMN register base defined or not, the CMN reference clocks is
configured only when the CMN register base defined in the reg  property.

> 
>>>> There is also no enable control for the reference clocks since it is
>>>> inputted by the hardware PIN connection, i will update these description
>>>> in the DT to make it more clear.
>>>
>>> Again, this does not justify having custom properties for this clock,
>>> as it is no different to other platforms. As far as I can tell, the only
>>> thing that a standard "clocks" property cannot convey here is the
>>> internal reference. I would suggest that since there is only one
>>> internal clock frequency, the absence of this particular clock in the
>>> "clocks" property can be used to determine that the reference is the
>>> internal on
> 
> I'm surprised you didn't pick up on this, but there are actually _2_
> internal references, which I have just noticed while double checking the
> binding patch.

i noticed this, the reference clock source can be supported by clocks as
you suggested here, it is really helpful.
> 
> What is the impact of using the 48 MHz or 96 MHz internal reference?
They works on the different IPQ platform, 96MHZ internal reference is
used on IPQ5018, the internal 48MHZ is used on the IPQ5332, that is
same as what you describe above, the different clock source rate is
selected as the different register value, then the PLL can do the
corresponding config to output the correct clock rate, the external
clock source is also same if the clock rate is same, just the different
hardware PIN is selected if the external reference source is configured.

Thanks.

> 
> Thanks,
> Conor.
> 
>> Yes, we can get the clock rate of the clocks property if we register
>> these as the fix clock to distinguish the different clock source.
>>
>> Since the reference clock rate value has no matter with the CMN clock
>> configuration, it is just the reference clock source selection, so
>> i did not use the fix clock for this.
>>
>> Thanks for this suggestion, i will verify the fix clock register solution.

