Return-Path: <linux-kernel+bounces-16465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF41823EF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EB01C2397E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD8120B04;
	Thu,  4 Jan 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k3udE0bm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB11208B9;
	Thu,  4 Jan 2024 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4047mN1S014984;
	Thu, 4 Jan 2024 09:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IXRZGb3I1tl57Tzisoz/TOJ1kfrS0DgM+Y1DjmEn3BE=; b=k3
	udE0bm9l7o0p+pZVGDmQAwF4mMr3qMjRk25v7EDR07vtgWZ+OSy6YjCjXbjB3Xa/
	I5gq5HFZd/WMnDRKsjAROwtwZ1iWR+FWMpMBaCWK7+SBwv5BmiZKK1n5wG6MashR
	sK8Bg6cilyDw1HFAPk5OWxwraQhyK1jcUycbmGYaKQjelPiwWULXRlca+U3vRQSG
	cEspQo/eTNLiyOKcGNQH9jqtazaGPrtKc1sS5F+xhZ73WdJ1DjrgKjIuobiYpXcx
	7BApJszilxp3kwxfnBf9MgnC5kkIu5UjKiMl2LU8KQR8K3H7uHfCsyBdg1uGjgqs
	RYO/1+gWjymtdMScbw/A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd8s1jem1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 09:53:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4049rInU002993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 09:53:18 GMT
Received: from [10.253.72.77] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 01:53:13 -0800
Message-ID: <c5263daa-b5f4-4b9c-a216-73d68493a802@quicinc.com>
Date: Thu, 4 Jan 2024 17:53:10 +0800
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
References: <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
 <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
 <7c05b08a-bb6d-4fa1-8cee-c1051badc9d9@lunn.ch>
 <ZX2rU5OFcZFyBmGl@shell.armlinux.org.uk>
 <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>
 <ZX3LqN8DSdKXqsYc@shell.armlinux.org.uk>
 <1bddd434-024c-45ff-9866-92951a3f555f@quicinc.com>
 <ZZPeHJJU96y1kdlZ@shell.armlinux.org.uk>
 <6593e0a3.050a0220.5c543.8e12@mx.google.com>
 <cee9de2c-bfa4-4ca9-9001-725e2041bc25@quicinc.com>
 <85590a5b-9d5a-40cb-8a0e-a3a3a1c3720a@lunn.ch>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <85590a5b-9d5a-40cb-8a0e-a3a3a1c3720a@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I7BiBPJKFAxZPLJyuounftiweA9NAazj
X-Proofpoint-ORIG-GUID: I7BiBPJKFAxZPLJyuounftiweA9NAazj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=747 phishscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040074



On 1/3/2024 10:22 PM, Andrew Lunn wrote:
>> Yes, APQ8084 is the application SoC.
>> QCA8084 is the pure PHY chip which has quad-phy.
> 
> I think everybody agrees these are terrible names, being so close
> together but being very different devices.
> 
> You have the issues of not giving clear explanations of your
> hardware. This is resulting in a lot of wasted tome for everybody. S
> please make your explanations very clear. I personally would avoid
> using APQ8084 or QCA8084 on there own. Always say the application SoC
> APQ8084, or the PHY chip QCA8084, or the switch embedded within the
> application processor APQ8084, or the PHYs embedded within the
> Application processor etc. This is particularly important when talking
> about clocks and resets, since the PHYs embedded within the
> application processor are likely to have different clocks and reset
> controllers to the PHY chip QCA8084.
> 
> 	Andrew

Let me explain it more.
APQ8084 is the Snapdragon SoC(for smart phone or other applicaiton)
according to the link below.
https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-processors-805.
which has nothing to do with QCA8084 or IPQ SoC we are discussing here.
let's remove out the APQ SoC from the discussion here.

1. For IPQ SoC series, there are only ipq4019, ipq5018, ipq6018,
ipq8074 documented in the current dt-bindings doc qcom,ipq4019-mdio.yaml
and ipq9574, ipq5332 that are being added by the MDIO patch, and one
more ipq8064 whose MDIO driver is mdio-ipq8064.c, on more others.

2. For qca8084(pure PHY chip), which is the quad-phy chip, which is just
    like qca8081 PHY(single port PHY), each port can be linked to maximum
    speed 2.5G.

    For qca8386(switch chip), which includes the same PHY CHIP as qca8084
    (4 physical ports and two CPU ports), qca8386 switch can work with
    the current qca8k.c DSA driver with the supplement patches.

    Both qca8084 and qca8386 includes same network clock controller(let's
    call it NSSCC, since this clock controller is located in the
    Ethernet chip qca8084 and qca8386), they have the same clock initial
    configuration sequence to initialize the Ethernet chip.

   The Ethernet chip qca8084 and qca8386 are only connected with IPQ SoC,
   Currently qca8084 is connected with IPQ SoC by 10G-QXGMII mode.
   the 4 PHYs of qca8386 are connected with the internal MAC of qca8386
   by GMII, the maximum speed is also 2.5G.
   The port4 of qca8084 or qca8386 is optionally be able to connected
   with IPQ SoC by sgmii.






