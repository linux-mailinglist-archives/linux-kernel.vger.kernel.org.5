Return-Path: <linux-kernel+bounces-2227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7708159EA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB261C21670
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A123010E;
	Sat, 16 Dec 2023 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RJPLelQn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D52E3F7;
	Sat, 16 Dec 2023 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BGEaW6Q014745;
	Sat, 16 Dec 2023 14:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jeup1XKuXC1dfr0GIzJNBoSzPXm9x0Y37fq3AHM5c2g=; b=RJ
	PLelQnLCKU8kdEyJZs0rtSdXg4bDE4Kgf3bjuG/93q8rdL4/DOcJ4l6ynifs7hLZ
	amriGIJczAyWoSQ+4hfH73NcjWMBArA72gih4fGCRzZtYhCCJY19j9EJzyKKF291
	URQMdKjLuz/9PYe6JuSa4FU26pwOmZGGIsCzEgOj/qjA90my332X/p4d6W7cijLW
	biCUSDhdb4u9RBvXAKN18XsiNUEN54JVCYnCIjHCm4YaTwqTc1o+GhJ7UYF9lIpt
	vJRPDD8NX3HNGo843/5ImGlABPyhw9zOfn5Qf1TOL0qFladtngrd04g298D01wsh
	ZcZBBkulGIjzu0pScMUw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14vj8qfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 14:41:37 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BGEfaiK000685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 14:41:36 GMT
Received: from [10.253.9.247] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 16 Dec
 2023 06:41:32 -0800
Message-ID: <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>
Date: Sat, 16 Dec 2023 22:41:28 +0800
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
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Andrew Lunn
	<andrew@lunn.ch>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <corbet@lwn.net>, <p.zabel@pengutronix.de>,
        <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, Christian Marangi <ansuelsmth@gmail.com>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch>
 <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>
 <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
 <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
 <7c05b08a-bb6d-4fa1-8cee-c1051badc9d9@lunn.ch>
 <ZX2rU5OFcZFyBmGl@shell.armlinux.org.uk>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZX2rU5OFcZFyBmGl@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: D8XBKJi8ukb0WS4wTZ5UYeUvnYA0wgO1
X-Proofpoint-GUID: D8XBKJi8ukb0WS4wTZ5UYeUvnYA0wgO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160113



On 12/16/2023 9:51 PM, Russell King (Oracle) wrote:
> On Sat, Dec 16, 2023 at 11:21:53AM +0100, Andrew Lunn wrote:
>>> The following is the chip package, the chip can work on the switch mode
>>> like the existed upstream code qca8k, where PHY1-PHY4 is connected with
>>> MAC1-MAC4 directly;
>>
>> Ah, that is new information, and has a big effect on the design.
> 
> This QCA8084 that's being proposed in these patches is not a PHY in
> itself, but is a SoC. I came across this:
> 
>   https://www.rt-rk.com/android-tv-solution-tv-in-smartphone-pantsstb-based-on-qualcomm-soc-design/

The chip mentioned in the link you mentioned is SoC, which is not the
chip that the qca8084 driver work for.

qca8084/qca8386 is just the Ethernet CHIP, not SoC, for the switch mode 
qca8386, which is most like qca8337 the dsa drive qca8k.c is already in 
upstream.

i qca8084 chip package includes 4 PHYs, 2 PCSs and the common chip level
modules such as GCC and security control modules, all these modules are
located in the qca8084 chip package, since qca8084 works on PHY mode, so
the MACs are not used.

qca8084 is connected with the SoC CHIP such as IPQ platform by PCS1
working on 10g-qxgmii mode and the fourth PHY can also optionally
be connected with the IPQ SoC PCS by sgmii mode, there is no more
interface on qca8084 to connect the external chips.

> It's sounding like what we have here is some PHY IP that is integrated
> into a larger SoC, and the larger SoC needs to be configured so the
> PHY IP can work correctly.

qca8084 is not a SoC, it is the Ethernet chip, in this qca8084 package,
there are GCC that is driving the PHY working on the various link speed.
that is the reason we need to do these package level common clocks and
resets initialization before probing PHY correctly.

> 
> Given that this package of four PHYs seems to be rather unique, I think
> we need Jie Luo to provide sufficient information so we can understand:
> 
> 1) this package of four PHYs itself

Yes, this chip package for all 4 PHYs itself, also including the PCSes
and common package level modules such as GCC.

> 2) how this package is integrated into the SoC

the qca8084 is connected with SoC by PCSes.

> 
> Specifically, what resets and clocks are controlled from within the
> package's register space, which are external to the package
> register space (and thus are provided by other IPs in the SoC).

All clocks and resets mentioned for qca8084 drive including package
level and PCS & PHY clocks and resets from the qca8084 internal GCC
modules register space,

> 
> As I've said previously, the lack of DT example doesn't help to further
> our understanding. The lack of details of what the package encompases
> also doesn't help us understand the hardware.

Indeed, i will add the qca8084 DT example in the next patch set.
BTW, i also replied your earlier comments by providing the DTS defined
for the current qca8084 drive code.

hope you can have a better understanding with the provided DTS code in
earlier reply of this email thread.
> 
> Unless we can gain that understanding, I feel that Jie Luo's patches
> are effectively unreviewable and can't be accepted into mainline.
> 

