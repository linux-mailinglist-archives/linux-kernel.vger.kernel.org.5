Return-Path: <linux-kernel+bounces-21681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1798292B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7457FB23ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C7C6AA0;
	Wed, 10 Jan 2024 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BWJJ5Kks"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D9210B;
	Wed, 10 Jan 2024 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A1UMJt030426;
	Wed, 10 Jan 2024 03:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qvs8qvtjNFrrte8K+3p2MUtW8MNqP6IVzNBLDgvst3s=; b=BW
	JJ5KkshCR1mU2UfZGpb3u59jrM6ePGRsX557mPXzLVGuaIxasYDeo6Sb1QgJGlvv
	ogvhgoyDYcbcND0muxQa6kFX/hzGJZeCHwqxH2x04dJy5YeOPUAFZeX43Bq9u9YG
	m4kO50/PrM0kSXtLV0EDwowE5rOF3sJGIUrrcoGSi2iT3rHvcgmkPPbdEuDJux+x
	rHo+qSagSZCU3kxXGGfD6HH3J/5HFg73DtOHqYhUq1doVob3Sh40V7D0Zk1jfqBb
	hQWfRUAC1w+pqTD6pPGbOOyVBAD1ZwYFlxNbfewBeG5wI+Z678Rj7Q3ySP+jCd3K
	xIdpN0OtP+0NM89+GN/Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9q716jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 03:13:28 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A3DRk9014164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 03:13:27 GMT
Received: from [10.253.15.239] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 19:13:21 -0800
Message-ID: <2de50b16-bcf7-401d-a4f9-79540ac24311@quicinc.com>
Date: Wed, 10 Jan 2024 11:13:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH RFC v3 1/8] dt-bindings: net: document ethernet
 PHY package nodes
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Christian Marangi
	<ansuelsmth@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Vladimir
 Oltean <olteanv@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiner
 Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
 <20231126015346.25208-2-ansuelsmth@gmail.com>
 <0926ea46-1ce4-4118-a04c-b6badc0b9e15@gmail.com>
 <1437d9df-2868-43f5-aebd-e0c57fe4d905@lunn.ch>
 <b75e6267-7d54-412e-8882-af4d9a0b54e6@quicinc.com>
 <841ef784-b27e-4f7a-94f2-f04f93178c61@lunn.ch>
 <07c01c11-0cc2-4837-b371-1404f2ce3359@quicinc.com>
 <2f2328ee-205b-4b4f-a683-2df4fbb22dde@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <2f2328ee-205b-4b4f-a683-2df4fbb22dde@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vQvHT32-CIbe2Ge8LoWUTyaNM2oNaS72
X-Proofpoint-GUID: vQvHT32-CIbe2Ge8LoWUTyaNM2oNaS72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100025



On 1/9/2024 9:48 PM, Andrew Lunn wrote:
>>
>> __| |_______________| |__
>> | PCS0 |          |PCS1 |
>> |______|          |_____|
>> |_______                |<---- REF clock 50MHZ
>> |      |------------    |
>> |NSSCC |    |clks  |rsts|<---- GPIO reset
>> |______|    |      |    |
>> |           V      V    |
>> |_______________________|
>> |     |     |     |     |
>> |PHY1 |PHY2 |PHY3 |PHY4 |
>> |_____|_____|_____|_____|
> 
> Not the best of improvements. So the ref clock goes to the package,
> and then magically somehow gets to the NSSCC? Are there any more
> blocks it goes through before reaching the NSSCC? How does the GPIO
> reset get converted into multiple reset inside the package? Details,
> details, details.

The GPIO reset for the whole CHIP, like a GPIO reset on the single port
PHY qca8081, after the GPIO reset, the whole qca8084 chip is in the cold
reset state, so the initial clocks ans resets need to be initialized as
we are designing the clock model here.

As for the reference clock 50M input, this reference clock 50MHZ is
PLLed by the PCS1 block of qca8084, then there are fix 312.5MHZ is
generated to the NSSCC, NSSCC includes multiple RCG clock trees to
generate the clocks to the PHY and PCS, all these blocks(PCS and PHY)
are located in the qca8084 PHY chip, sorry for missed this diagram
info, updated the diagram as below, since the PCS generates the clocks
to NSSCC, there are initial clocks ans resets included for PCS need
to be configured before CHIP to work.

So the parent clocks are PCS0(uniphy0) and PCS1(uniphy1) for NSSCC,
as i provide the DT of NSSCC provider below, the parent clock rate
of PCS is changed according to the PHY link speed, and there are
also fix clock rate 312.5MHZ from PCS1, these parent clocks are
the root clock of RCG clock tree in NSSCC, the output clocks of
the RCG are consumed by the PHYs(PHY1-PHY4 and PCS0, PCS1).

    REF 50MHZ
       |
       |
______V__________________
| PCS1 |       ____|PCS0|
|______|      |    |____|
|  |  ________|         |
|  | |                  |<----------GPIO reset
|__V_V__                |
|      |------------    |
|NSSCC |    |clks  |rsts|
|______|    |      |    |
|           V      V    |
|_______________________|
|     |     |     |     |
|PHY1 |PHY2 |PHY3 |PHY4 |
|_____|_____|_____|_____|

> 
>> There are difference clock trees generated from NSSCC for the different
>> PHYs, all clocks and resets for qca8084 CHIP working are internally
>> provided by the NSSCC.
> 
> So show this in the block diagram.
> 
>> Yes, Andrew, the NSSCC provider driver is probed based on the MDIO
>> device, the PHY CHIP occupies the MDIO addresses, so the NSSCC is
>> registered as the MDIO device.
>>
>> DT of the NSSCC device node:
>> mdio {
>>        #address-cells = <1>;
>>        #size-cells = <0>;
>>
>>        clock-controller@18 {
>>          compatible = "qcom,qca8084-nsscc";
>>          reg = <0x18>;
>>          clocks = <&qca8k_xo>,
>>                   <&qca8k_uniphy0_rx>,
>>                   <&qca8k_uniphy0_tx>,
>>                   <&qca8k_uniphy1_rx>,
>>                   <&qca8k_uniphy1_tx>,
>>                   <&qca8k_uniphy1_rx312p5m>,
>>                   <&qca8k_uniphy1_tx312p5m>;
>>          #clock-cells = <1>;
>>          #reset-cells = <1>;
>>          #power-domain-cells = <1>;
>>        };
>>      };
>   
> This does not make any sense. You have one clock input, 50MHz. So why
> are you listing 6 consumer clocks, not one? And where are the clocks
> this clock controller provides, clock-output-names=<...>;

Hi Andrew,
Sorry for the confusion.
the DT of the NSSCC device node is from the NSSCC provider driver, which
is under review currently as the link below.
https://lore.kernel.org/lkml/20231104034858.9159-2-quic_luoj@quicinc.com/T/#m204c22d14be8f9dda7cd7f666ed726b8fc3301ef

the property "clocks" are the parent clock list of RCG clock tree in
the NSSCC driver, for qca8084 chip, there are two UNIPHY(PCS) as
mentioned in the diagram, there are also fix rate clocks 312.5MHZ,
the output clocks of NSSCC are not listed in the DT, which is same
as the GCC(IPQ SoC) DT.

The output clocks of NSSCC are provided by the DT of the clock consumer
such as the DT of qca8084 as below.
phy0 {
         reg = <0>;
         clocks = <&qca8k_nsscc NSS_CC_GEPHY0_SYS_CLK>;
         clock-names = "gephy0_sys";
         resets = <&qca8k_nsscc NSS_CC_GEPHY0_SYS_ARES>,
                  <&qca8k_nsscc NSS_CC_GEPHY0_ARES>;
         reset-names = "gephy0_sys", "gephy0_soft";
      };

In the DT node above, the qca8k_nssc refers to the NSSCC clock provider
DT node "clock-controller@18", the clock ID "NSS_CC_GEPHY0_SYS_CLK" is
also provided by the NSSCC clock provider driver.

The different PHY(PHY1-PHY4) of qca8084 has the different clock
tree(RCG), the clock consumer driver needs to define the DT properties
clocks and clcok-names to get the clocks from the NSSCC clock provider.

> 
> I give up. Please consider this PHY driver NACKed.
> 
> Get Linaro, or some other organisation with a lot of experience with
> mainline to take over the work.
> 
> 	 Andrew

