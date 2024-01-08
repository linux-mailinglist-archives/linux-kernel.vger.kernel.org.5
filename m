Return-Path: <linux-kernel+bounces-19184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857D882697A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB6F1C21B95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA80BA33;
	Mon,  8 Jan 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YJi/vpm5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721F13AC7;
	Mon,  8 Jan 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40860CQ0009945;
	Mon, 8 Jan 2024 08:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lzYxfaFzQtBCI6PD1UXT0CYm6nKTZBF5UPuLGV0Yrgo=; b=YJ
	i/vpm5/6dC2ufWheJwfAxzTxCI+H0WFqjiZy0Ft9DAouykkn50415nzsW4agGY0Q
	STiDfae32c5nK2qypCUw834WiQlHsGSJAkVODiTXiJUQ2P9kACimZH8J69uMMw8Q
	q6mFxhuT2+W3hBtz9mN5c3hN3RJy40lpmqEK5iX65rmqOcK8e8H9FQlvG8/7Iq7l
	nFvGA3z0rtScWiFo51kyWX48dwrZCE/n+H6XRUWWgGjtVd0+JuXpu2D9FCT43kT9
	OFjU0bDReu7pe8WpnHaWNv0hRZLIvVnB5XjH1iuamDLl+ZuOmWN1qjCMNOo9AB0B
	uvwwWsj52loym3JRYJbg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3veymmbcxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 08:27:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4088R9qm018144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 08:27:09 GMT
Received: from [10.253.76.26] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 00:27:04 -0800
Message-ID: <6a7d62fc-a518-4aab-bb28-9289c398b74b@quicinc.com>
Date: Mon, 8 Jan 2024 16:27:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY
 properties
Content-Language: en-US
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
References: <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>
 <ZX3LqN8DSdKXqsYc@shell.armlinux.org.uk>
 <1bddd434-024c-45ff-9866-92951a3f555f@quicinc.com>
 <ZZPeHJJU96y1kdlZ@shell.armlinux.org.uk>
 <6593e0a3.050a0220.5c543.8e12@mx.google.com>
 <cee9de2c-bfa4-4ca9-9001-725e2041bc25@quicinc.com>
 <85590a5b-9d5a-40cb-8a0e-a3a3a1c3720a@lunn.ch>
 <c5263daa-b5f4-4b9c-a216-73d68493a802@quicinc.com>
 <50252a5a-e4fb-42d3-b838-9ef04faf4c5c@lunn.ch>
 <b427c89a-81a9-439f-905e-2a6632065b78@quicinc.com>
 <864b0867-06c0-4c6d-ae71-9b5025c8d93a@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <864b0867-06c0-4c6d-ae71-9b5025c8d93a@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _JTl_QMG-Z0PXhZbt5wiQBTQfpaSIKJ7
X-Proofpoint-GUID: _JTl_QMG-Z0PXhZbt5wiQBTQfpaSIKJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080071



On 1/5/2024 9:37 PM, Andrew Lunn wrote:
>>> O.K. Since we are getting nowhere at the moment, lets take just the
>>> pure PHY chip, and ignore the rest for the moment.
>>>
>>> For any pure PHY, there is generally one clock input, which might be a
>>> crystal, or an actual clock. If you look at other DT bindings for
>>> PHYs, it is only listed if the clock is expected to come from
>>> somewhere else, like a SoC, and it needs to be turned on before the
>>> PHY will work. And generally, a pure PHY has one defined clock
>>> frequency input. If that is true, there is no need to specify the
>>> clock. If multiple clock input frequencies are supported, then you do
>>> need to specify the clock, so its possible to work out what frequency
>>> it is using. How that clock input is then used internally in the PHY
>>> is not described in DT, but the driver can set any dividers, PLLs
>>> needed etc.
>>
>> Yes, Andrew, there is only one clock input to qca8084(same as qca8386),
>> this input clock rate is 50MHZ, which is from the output clock of CMN
>> PLL block that is configured by the MDIO bus driver patch under review.
> 
> Lets concentrate on the pure PHY. All it sees is a clock. It does not
> care where it come from. All you need in the device tree for the pure
> PHY is a clock consumer.
Yes.

> 
> There is one clock input, so its shared by all four instances in the
> pure PHY package. So you need to use Christians code which extends the
> PHY DT bindings to allow DT properties for a package of PHYs.

OK, will

> 
> What about resets. Is there one reset pin for the pure PHY package, or
> one per PHY?

There is only one GPIO hardware reset PIN for the chip qca8084 including
all 4 PHYs.

> 
> Go find Christians code, understand it, and propose a DT binding for
> the pure PHY. Include the clock provider and the reset
> provider. Forget about the MDIO controller, and the PHY integrated
> into the switch, etc. Baby steps...

Thanks Andrew for pointing me the Christians code, i will keep the
driver of qca8084 synced with Christian's code before pushing the
next patch set.

> 
>> In qca8084(same as qca8386), there is a clock controller, let's call it
>> as NSSCC, the logic of NSSCC is same as qualcomm GCC(located in SoC),
>> the NSSCC provides the clocks to the quad PHYs, the initial clocks for
>> quad PHYs need to be configured before PHY to work.
> 
> You said above, there is one clock input to the qca8084. Here you use
> the word clocks, plural. Is there one clock, or multiple clocks?
> 
>      Andrew

Yes, Andrew, it is multiple clocks.
These multiple clocks are generated(PLL, divider) and used internally by
qca8084 CHIP, these clocks are generated by the clock controller of
qca8084, let's call the clock controller of qca8084 as NSSCC provider,
which generates the clocks to the PHYs, this NSSCC is located in
qca8084.

The only one input clock of qca8084 is the clock source of the chip
qca8084, which is fixed to 50MHZ.

The NSSCC of qca8084 generates different clock rates for the different
link speed of the PHY, which is the internal block of qca8084.



