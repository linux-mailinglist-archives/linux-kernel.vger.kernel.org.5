Return-Path: <linux-kernel+bounces-17746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1BE8251F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D381F21921
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3502510C;
	Fri,  5 Jan 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FeKeyRfM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65032CCB8;
	Fri,  5 Jan 2024 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4058CtSL006789;
	Fri, 5 Jan 2024 10:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EkP5kIkm5I5NQXP6fb85AU2ocIb7I4jlvhR2pOBwxJ0=; b=Fe
	KeyRfMSUAvuqedJh4yvFULzK3tqltvUsNdey0qBe6wLT9kXbU+LDZ40sZmoTPFyK
	OLE1kMyIMAmL9NEEXKGkJXRK1JOshOADuGY4v8c1g8uCdZ6GVDfMY/Bau/0B5iBf
	c0Vbd0yA3Yvm4LX3/1gLBCvlAO9nt4eg3M9YZpZhXxq4c9ktQGn2H3biURuPoCPY
	edpMnInuPsYN9MdF4DhAK5an6HUxRXnoMm8A+STlihqaVFAux0WjOk3+u6n5nKbV
	Kz8gy/7NrRSRVetf6MoRVgBSi8wriVVaTkqjo/i6Ysjo4yAAfdynKkLoTHyrepXS
	+jt6v5C38bVR+/ydliow==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve98hrrvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 10:27:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 405AR2Qe021417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Jan 2024 10:27:02 GMT
Received: from [10.253.39.156] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 5 Jan
 2024 02:26:58 -0800
Message-ID: <b427c89a-81a9-439f-905e-2a6632065b78@quicinc.com>
Date: Fri, 5 Jan 2024 18:26:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
To: Andrew Lunn <andrew@lunn.ch>
CC: Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)"
	<linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <corbet@lwn.net>, <p.zabel@pengutronix.de>,
        <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <7c05b08a-bb6d-4fa1-8cee-c1051badc9d9@lunn.ch>
 <ZX2rU5OFcZFyBmGl@shell.armlinux.org.uk>
 <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>
 <ZX3LqN8DSdKXqsYc@shell.armlinux.org.uk>
 <1bddd434-024c-45ff-9866-92951a3f555f@quicinc.com>
 <ZZPeHJJU96y1kdlZ@shell.armlinux.org.uk>
 <6593e0a3.050a0220.5c543.8e12@mx.google.com>
 <cee9de2c-bfa4-4ca9-9001-725e2041bc25@quicinc.com>
 <85590a5b-9d5a-40cb-8a0e-a3a3a1c3720a@lunn.ch>
 <c5263daa-b5f4-4b9c-a216-73d68493a802@quicinc.com>
 <50252a5a-e4fb-42d3-b838-9ef04faf4c5c@lunn.ch>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <50252a5a-e4fb-42d3-b838-9ef04faf4c5c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zHj3boj0OggfIBob6oxflhmprqOH5DoK
X-Proofpoint-GUID: zHj3boj0OggfIBob6oxflhmprqOH5DoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050089



On 1/4/2024 9:57 PM, Andrew Lunn wrote:
>> 1. For IPQ SoC series, there are only ipq4019, ipq5018, ipq6018,
>> ipq8074 documented in the current dt-bindings doc qcom,ipq4019-mdio.yaml
>> and ipq9574, ipq5332 that are being added by the MDIO patch, and one
>> more ipq8064 whose MDIO driver is mdio-ipq8064.c, on more others.
>>
>> 2. For qca8084(pure PHY chip), which is the quad-phy chip, which is just
>>     like qca8081 PHY(single port PHY), each port can be linked to maximum
>>     speed 2.5G.
>>
>>     For qca8386(switch chip), which includes the same PHY CHIP as qca8084
>>     (4 physical ports and two CPU ports), qca8386 switch can work with
>>     the current qca8k.c DSA driver with the supplement patches.
> 
> Is the qca8386 purely a switch plus integrated PHYs? There is no CPU
> on it? What is the management path? MDIO?

Yes, qca8386 is a pure switch plus integrated PHYs(same PHY type as
qca8084), there is no CPU on qca8386, the management path is MDIO.
the access of switch register is by the multiple MDIO operations.

> 
>>
>>     Both qca8084 and qca8386 includes same network clock controller(let's
>>     call it NSSCC, since this clock controller is located in the
>>     Ethernet chip qca8084 and qca8386), they have the same clock initial
>>     configuration sequence to initialize the Ethernet chip.
> 
> You said For "qca8084(pure PHY chip)". Here you just called it an
> Ethernet chip? To me, and Ethernet chip is a MAC, Intel e1000e etc.
> Do you now see how your explanations are confusing. Is it s pure PHY,
> or is it an Ethernet chip?

My bad, sorry for this confusion.
qca8084 is a pure PHY, there is no MAC in qca8084.

> 
> O.K. Since we are getting nowhere at the moment, lets take just the
> pure PHY chip, and ignore the rest for the moment.
> 
> For any pure PHY, there is generally one clock input, which might be a
> crystal, or an actual clock. If you look at other DT bindings for
> PHYs, it is only listed if the clock is expected to come from
> somewhere else, like a SoC, and it needs to be turned on before the
> PHY will work. And generally, a pure PHY has one defined clock
> frequency input. If that is true, there is no need to specify the
> clock. If multiple clock input frequencies are supported, then you do
> need to specify the clock, so its possible to work out what frequency
> it is using. How that clock input is then used internally in the PHY
> is not described in DT, but the driver can set any dividers, PLLs
> needed etc.

Yes, Andrew, there is only one clock input to qca8084(same as qca8386),
this input clock rate is 50MHZ, which is from the output clock of CMN
PLL block that is configured by the MDIO bus driver patch under review.

In qca8084(same as qca8386), there is a clock controller, let's call it
as NSSCC, the logic of NSSCC is same as qualcomm GCC(located in SoC),
the NSSCC provides the clocks to the quad PHYs, the initial clocks for
quad PHYs need to be configured before PHY to work.

These clocks and resets are provided by the NSSCC provider driver,
i need to define these clocks and resets in DT to use it.

> 
> So, for the pure PHY chip, what is the pinout? Is there one clock
> input? Or 4 clock inputs, one per PHY in the quad package? Typically,
> where does this/these clocks come from? Is the frequency fixed by the
> design, or are a number of input frequencies supported?

There is one 50M clock input for qca8084(same as qca8386), the input
clock is generated from the CMN PLL block that is configured by MDIO
driver patch of mdio-ipq4019.c.
The frequency of input clock is fixed to 50MHZ.

> 
>>    The Ethernet chip qca8084 and qca8386 are only connected with IPQ SoC,
>>    Currently qca8084 is connected with IPQ SoC by 10G-QXGMII mode.
>>    the 4 PHYs of qca8386 are connected with the internal MAC of qca8386
>>    by GMII, the maximum speed is also 2.5G.
>>    The port4 of qca8084 or qca8386 is optionally be able to connected
>>    with IPQ SoC by sgmii.
> 
> To some extent, this does not matter. The DT binding and the driver
> should not care what the pure PHY is connected to. It has standardised
> ports, so in theory it could be connected to any vendors MAC.

Yes, it can be connected with any vendors MAC with the interface mode
supported.

> 
> Please be very careful with your wording. Because computers
> instructions should be unambiguous, it does what it is told, we also
> expect computer scientists to be unambiguous. Wording is very
> important.
> 
>         Andrew
Got it. Thanks Andrew for the comments and suggestions.

