Return-Path: <linux-kernel+bounces-2135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6B7815849
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 08:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925F5287F40
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281D413FF1;
	Sat, 16 Dec 2023 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QiDW06Er"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDAD6FAA;
	Sat, 16 Dec 2023 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG7XqhJ014419;
	Sat, 16 Dec 2023 07:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ndYd+Iu1vbd/bN6oLMb7dJWtSKVu7rA8gkPyWVZ0MI8=; b=Qi
	DW06Ern132uckvBCXfh1b9fzuQcoZR2OcbeU9Etm/66IQaYqAZ3ZBB55zBdsnMjl
	AlmhfWVK511uG898V4LBdUIoMoATO1PYFxX12Ef6cwt5D2dWQIvmNSg/IqJgTXLL
	xN7XX51aGpgq/1vXO4hx5U3qLI5HmzAwsCmfttI01nv1I52gpjbNbWtb7C5ou0VO
	iWhJiu6fgj5N7+IlGfgQhkmZZzmpMwL4B7xJilUcEaAxR52X9h2aub7Tbl512/NX
	nwDQAX/i9loUd5ekGw8Go0B3uGwuAGPWOZ9QWmQECgeJd7zQRlVE225QJcSUudk3
	c789TAwnCIffOPOHkPBg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v1531r62x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 07:38:00 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG7bxXC027203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 07:37:59 GMT
Received: from [10.253.9.247] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 23:37:55 -0800
Message-ID: <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
Date: Sat, 16 Dec 2023 15:37:52 +0800
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
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch>
 <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>
 <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yaqN3gKkiwOCxb0oIMz_hdARHIPkCsMv
X-Proofpoint-ORIG-GUID: yaqN3gKkiwOCxb0oIMz_hdARHIPkCsMv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160056



On 12/15/2023 9:31 PM, Andrew Lunn wrote:
> On Fri, Dec 15, 2023 at 08:33:00PM +0800, Jie Luo wrote:
>>
>>
>> On 12/15/2023 8:12 PM, Andrew Lunn wrote:
>>>> +  clocks:
>>>> +    items:
>>>> +      - description: APB bridge clock
>>>> +      - description: AHB clock
>>>> +      - description: Security control clock
>>>> +      - description: TLMM clock
>>>> +      - description: TLMM AHB clock
>>>> +      - description: CNOC AHB clock
>>>> +      - description: MDIO AHB clock
>>>> +      - description: MDIO master AHB clock
>>>> +      - description: PCS0 system clock
>>>> +      - description: PCS1 system clock
>>>> +      - description: EPHY0 system clock
>>>> +      - description: EPHY1 system clock
>>>> +      - description: EPHY2 system clock
>>>> +      - description: EPHY3 system clock
> 
>> Hi Andrew,
>> These clocks are for the whole PHY package including quad PHYs, since
>> these clocks & resets need to be initialized at one point, i put it
>> the previous MDIO driver code, these clocks & resets are configured
>> after GPIO hardware reset, after these clocks and resets sequences
>> configured, each PHY capabilities can be acquired correctly in the PHY
>> probe function.
> 
> I really expect the hardware is hierarchical. Its unlikely that EPHY0
> is connected to all four PHYs in the package. Its specific to one
> PHY. So it should be in the DT properties for that one specific PHY. I
> expect the resets are the same. It seems there is a soft and hard
> reset per PHY, so i would expect these to be in the node for one PHY.be 

Hi Andrew,
i understand your point, i tried putting the related clocks and resets
into each device node per PHY, which does not work, since these clocks
ans resets need to be initialized at one function pointer after GPIO 
reset on the qca8084 package.

Sorry for these confusions here, let me explain the qca8084 chip more
detail here, and i will also update this info on the cover letter.

The following is the chip package, the chip can work on the switch mode
like the existed upstream code qca8k, where PHY1-PHY4 is connected with
MAC1-MAC4 directly; The chip can also work on the PHY mode, where PHY1-
PHY4 is connected with PCS1 by 10g-qxgmii; Either switch mode or PHY 
mode, the PHY4 is optionally connected with PCS0 by SGMII, PCS0 and PCS1
are connected with the SoC(IPQ platform) PCSes.
+----------------------------------------------+
|          PCS1           PCS0                 |
|                                              |
|          MAC0           MAC5                 |
|                                              |
|                                              |
|                                              |
|      MAC1      MAC2      MAC3      MAC4      |
|                                              |
|      PHY1      PHY2      PHY3      PHY4      |
+----------------------------------------------+

After the GPIO reset on this package from the MDIO bus level, the chip
is in the cold hardware reset status, the clocks and resets mentioned
here need to be initialized before the capabilities of PHY can be
acquired correctly in the PHY probe function, that is why i put these
clocks and resets in the first PHY device tree node.
When the chip works on the PHY mode, the MAC listed in the block is
not used, the MAC is only used in the switch mode.

i know we can also put the related clocks and resets into the each
PHY and PCS device node to make the hardware hierarchical, then i can
read all initial clocks and resets in the first PHY probe function,
but there are still some package level clocks such as APB/AHB/CNOC
clocks needed for these initial configuration, so i put these clocks
and resets at one PHY device node and only needed to be called by one
time.

 From the clocks and resets name, EPHY0 is specific to the first PHY1,
which is providing clock and reset on the first PHY1, other EPHY clock
and reset is same for the corresponding PHY.

> 
> Do the two PCS instances take up two MDIO address? They can be
> considered devices on the bus, so could have a DT node, and hence you
> can place the PCS clocks on that node?

Yes, two PCS instances take up two MDIO device with different MDIO
address, which also have the DT nodes as the child node of MDIO bus node
there is also some specific clocks and resets defined in the PCS DT
node for the PCS driver.

> 
> What exactly do the two MDIO clocks do? I assume these are not for the
> MDIO bus master, but the MDIO slave block within the PHY package?
> There is one MDIO slave block shared by the four PHYs. So these are
> package properties and should be in the package node in DT.

The MDIO clocks are the qca8084 package level clock, since there
are other modules such as GCC and security control located in the
qca8084 chip, these module register is also accessed by the MDIO bus,
the MDIO AHB clock is this modules access.
there is also a MDIO master for the back pressure function in qca8084
chip, the MDIO master AHB clock is for this function, actually this
function is for the switch mode, but it is the package level clock,
so i put it together here.

No, these clocks are not for the IPQ4019 SoC MDIO bus master. Four PHYs 
are the independent MDIO slave devices.

For the switch mode, we can define these package level clocks and resets
in the DSA device node.

But for the PHY mode, All 4 PHYs is connected with PCS1 by 10g-qxgmii,
there is no package level device tree node defined.

> 
> Look at all the other clocks and decide, are they package clocks, or
> specific to one block on the MDIO bus? Do the properties go in the
> package node, or the per PHY node?
> 
> 	Andrew

The clocks and resets with prefix PCS or EPHY is per PHY/PCS node, other
clocks and resets are the qca8084 package level node.

