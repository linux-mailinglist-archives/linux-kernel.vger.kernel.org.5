Return-Path: <linux-kernel+bounces-16486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D518E823F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E12E1F25187
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E1720B1D;
	Thu,  4 Jan 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XZiT6c0v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15D20B05;
	Thu,  4 Jan 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4047a7Jq020740;
	Thu, 4 Jan 2024 10:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9Fd3CczjbK2ceyM/qpmHxhVJoIFe7T0z6TeQhWzsuXg=; b=XZ
	iT6c0v50Es3sWBbKAbUJP+6Jy+SacP5rRpekmwZCCh0oaWsKUw76Tnver4KTRPaV
	8Q+o48CFUqSMfkQnBJttiVTGf6Dpfz2ntK9aCEH5vACyLrxwCEnDJq3WHJBIfb9Z
	mt0R2wHr0rzMhFDq+Pv1AE6RlzO15dpDVUk/l9RWk3uTonxvz23vAddH0gUZOZMK
	DiQWAVI5PaZ44bk8HVpOl5kRmRyqTW8B4j8rsVeBgj3JV4frkjway+a/wpqP5c6g
	zfgjoFuszokkt0+a82q+J+zK56oVzsly0VBOLAnKFK56nIhWz/2HyvuxLHvlStnt
	Eah/fcYtslcWavEWxSkw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vdm07h269-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 10:07:06 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 404A746U027384
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 10:07:05 GMT
Received: from [10.253.72.77] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 02:06:58 -0800
Message-ID: <7c4f12d8-e336-41b9-b0ab-2a8ab3574036@quicinc.com>
Date: Thu, 4 Jan 2024 18:06:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
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
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-6-quic_luoj@quicinc.com>
 <dee72ce8-b24e-467a-b265-1b965588807f@linaro.org>
 <aeb364a3-6c05-4a1b-ba32-e687a89f20f8@quicinc.com>
 <58dde1a7-ed4a-442c-bb5c-c3f6d926fb7e@linaro.org>
 <06ddbae8-1502-41fb-8cf8-9a3390dad557@quicinc.com>
 <28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org>
 <d231b7e2-51f5-4676-8fc0-e4bc6154e2d7@quicinc.com>
 <c4831e26-5ff0-40b1-98d4-addfdc1ee5a8@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <c4831e26-5ff0-40b1-98d4-addfdc1ee5a8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EAH_1m8SRLtB1saNx2JVLd7ETERUpPYk
X-Proofpoint-ORIG-GUID: EAH_1m8SRLtB1saNx2JVLd7ETERUpPYk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401040076



On 1/4/2024 3:47 PM, Krzysztof Kozlowski wrote:
> On 28/12/2023 08:38, Jie Luo wrote:
>>>> Sorry for this confusion.
>>>> Rob said the internal reference source can be decided by the absence of
>>>> the property combined with compatible string, because i said the
>>>
>>> So all your three DT maintainers agree that lack of property for
>>> choosing clock, defines the usage of interrupt source.
>>
>> This is the reference clock source selection of CMN block, which
>> generates the clocks for the Ethernet devices.
>>
>>>
>>> Now we had huge amount of arguments that you do not represent properly
>>> the clock relationships. Still.
>>
>> here is the clock topology.
>> reference clock sources ---> CMN PLL ---> various output clocks
> 
> How do you guarantee that these clocks are enabled without proper
> relationships described in DT? In current and future designs?

Will update the patch to add the clock relationship in the DT, thanks.

> 
>>
>> the output clocks are provided to the Ethernet devices(such as the
>> qca808x PHY devices).
>>
>> These information is also provided the commit message of the patch
>> <net: mdio: ipq4019: configure CMN PLL clock for ipq5332>.
>>
>>>
>>>> internal 96MHZ is used on ipq5018 currently in the previous message.
>>>>
>>>> per double checked the current IPQ platforms, the internal 96MHZ is also
>>>> possible on ipq9574, and the reference clock source should be kept as
>>>> configurable instead of limited by the compatible string, maybe the
>>>> different reference clock source is acquired in the future, even
>>>> currently it is not used on the special platform for now.
>>>>
>>>> so i update the solution with a little bit of changes.
>>>
>>> You still do not want to implement our suggestions and I don't
>>> understand your arguments. Nothing in above paragraph explains me why
>>> you cannot use clock provider/consumer relationships.
>>
>> Hi Krzysztof,
>>
>> The reference clock source can be registered as the fix clock provider,
>>   From the current fix clock provider, the clock rate is useful for the
>> clock consumer, the fix clock rate is used to generate the output clocks
>> by the divider or multiplier.
>>
>> For the CMN block to select reference clock, which is configuring the
>> clock source, we don't know the formula to get the output clock value
>> based on the reference clock value.
> 
> I don't understand what does it mean. You do not know how to program CMN
> block?

The output clock value of CMN block is not related to the clock value of
the reference source clock, the output clocks of CMN block are fixed to
25M and 50M, which are provided to the different Ethernet devices, there
is no formula for the relationship of input clock value and output clock
value of CMN block.

> 
>>
>> i also see there is an example in the upstream code, which is same as
>> the CMN block to select the reference clock source.
> 
> Oh, the old argument. So if there is a bug in the code, you are going
> for example to implement it as well?

The reference source clock can be registered as fix clock, and we can
get the clock rate of reference source clock with the external or
internal flag to distinguish the reference clock source, then program
the CMN block corresponding.
> 
>>
>> the property "ref-clock-frequency" is defined in the yaml file below.
>> Documentation/devicetree/bindings/net/wireless/ti,wlcore.yaml.
> 
> And how does the hardware look like there? It's TI, so how do you even know?

According to the driver code and DT description, the example is also for
selecting the reference clock source according to the clock value of DT
properties.

Sure, we can also use the registered fix clock to identify the
reference clock source for CMN block.

> 
> 
> 
> Best regards,
> Krzysztof
> 

