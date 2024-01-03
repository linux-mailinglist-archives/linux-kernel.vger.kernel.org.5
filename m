Return-Path: <linux-kernel+bounces-15580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A32822E68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8E7B228F1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858C61A5BA;
	Wed,  3 Jan 2024 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CfOe4WOT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F293199BE;
	Wed,  3 Jan 2024 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403ChflD013742;
	Wed, 3 Jan 2024 13:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=KU0V7Bd7DJVl6XpxVBwR1yq5cIuxkCvJpQh9cuBMpao=; b=Cf
	Oe4WOTgHRH9LZdRfxM0r6bH7fd7CVb8ElQC+KRbIeBwQs0XBISGTl0HwO3/zTpIJ
	wVnSm0TjViszPBPL0DPMllNtMGvWlPZEnwLlVv52sZPa1h9Z8WhCkRZHUkURwts5
	cMTC6j/lNCE4QAD4yigzpU7qOxcEajnbVG5Oy/7tVmDGQQuimr2GeRXW+U9zbz4r
	a2VOZf4BYk4Xwc5YhP345Ta5sAUlAV6FxkJ4zDnwe2/UuAbX06/mb12zHW+aEwGl
	NICiTxTyL+OvN79SRlqPTOu9alIXlaIy9EmV2Nl90w1soR5NgOemDq+rX6dzYBGp
	keBkQjrocKsHu++aWGZA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd3k18t6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 13:31:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 403DVBYT031794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 13:31:11 GMT
Received: from [10.253.72.77] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 3 Jan
 2024 05:31:06 -0800
Message-ID: <cfb04c82-3cc3-49f6-9a8a-1f6d1a22df40@quicinc.com>
Date: Wed, 3 Jan 2024 21:31:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] support ipq5332 platform
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>, <agross@kernel.org>,
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
 <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jLOGI-OFleMcfRPDcPmmHtZrAjZ4ideQ
X-Proofpoint-ORIG-GUID: jLOGI-OFleMcfRPDcPmmHtZrAjZ4ideQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030111



On 1/2/2024 7:01 AM, Sergey Ryazanov wrote:
> Hi Luo,
> 
> I have a few questions regarding the high level design of 
> implementation. I hope that clarifying these topics will help us to find 
> a good model for the case and finally merge a supporting code. Please 
> find the questions below.
> 
> On 25.12.2023 10:44, Luo Jie wrote:
>> For IPQ5332 platform, there are two MAC PCSs, and qca8084 is
>> connected with one of them.
>>
>> 1. The Ethernet LDO needs to be enabled to make the PHY GPIO
>>     reset taking effect, which uses the MDIO bus level reset.
>>
>> 2. The SoC GCC uniphy AHB and SYS clocks need to be enabled
>>     to make the ethernet PHY device accessible.
>>
>> 3. To provide the clock to the ethernet, the CMN clock needs
>>     to be initialized for selecting reference clock and enabling
>>     the output clock.
>>
>> 4. Support optional MDIO clock frequency config.
>>
>> 5. Update dt-bindings doc for the new added properties.
>>
>> Changes in v2:
>>     * remove the PHY related features such as PHY address
>>       program and clock initialization.
>>     * leverage the MDIO level GPIO reset for qca8084 PHY.
>>
>> Changes in v3:
>>     * fix the christmas-tree format issue.
>>     * improve the dt-binding changes.
>>
>> Changes in v4:
>>     * improve the CMN PLL reference clock config.
>>     * improve the dt-binding changes.
>>
>> Luo Jie (5):
>>    net: mdio: ipq4019: move eth_ldo_rdy before MDIO bus register
>>    net: mdio: ipq4019: enable the SoC uniphy clocks for ipq5332 platform
>>    net: mdio: ipq4019: configure CMN PLL clock for ipq5332
>>    net: mdio: ipq4019: support MDIO clock frequency divider
>>    dt-bindings: net: ipq4019-mdio: Document ipq5332 platform
>>
>>   .../bindings/net/qcom,ipq4019-mdio.yaml       | 141 ++++++++-
>>   drivers/net/mdio/mdio-ipq4019.c               | 288 ++++++++++++++++--
>>   2 files changed, 399 insertions(+), 30 deletions(-)
> 
> I'm asking these questions because after checking the patches and 
> following the earlier discussion, the series is looks like an 
> overloading of the MDIO driver with somehow but not strictly related 
> functionality.
> 
> 
> First, let me summarize the case. Feel free to correct me if I took 
> something wrong. So, we have:
> - a reference design contains IPQ5332 SoC + QCA8084 switch/Phy;

IPQ5322 SoC is currently connected with qca8386(switch that includes
QCA8084 PHY), the pure PHY chip qca8084 is currently connected on the
SoC IPQ9574.

> - QCA8084 requires a reference clock for normal functionality;

The reference clock is selected for the CMN PLL block, which outputs
the clocks to the Ethernet devices including the qca8084 PHY for normal
functionality, also for other connected Ethernet devices, the CMN PLL
block is located in SoC such as ipq5332 and ipq9574.

> - IPQ5332, as a chip, is able to provide a set of reference clocks for 
> external devices;

Yes, the CMN PLL block of IPQ5332 provides the output clocks as the
working clocks for the external Ethernet devices such as the QCA8386
(switch chip), the reference clocks we are discussing is as the
reference clock source of the CMN PLL block.

> - you want to configure IPQ5332 to provide the reference clock for QCA8084.

The reference clocks for CMN PLL block is configurable, and the output
clocks of CMN PLL are fixed, the output clocks are 50MHZ, which is given
to the external Ethernet devices.
here is the topology of clocks.
		     ---------
		    |	     |
reference clock --->| CMN PLL|--> output 50M clocks --> qca8084/qca8386
	            |        |
	            ---------
> 			   	
> 
> So, the high level questions are:
> 1. Is QCA8084 capable to consume the clock from some other generator? Is 
> it possible to clock QCA8084 from external XO/PLL/whatever?
No, the clock of qca8084/qca8386 is provided from the output clock of
CMN PLL as above.

> 2. Is IPQ5332 capable to provide reference clock to another switch model?

Yes, IPQ5332 can provide the reference clock to all connected Ethernet
devices, such as qca8386(switch), qca8081 phy and others.

> 3. Is the reference clock generation subsystem part of the MDIO block of 
> IPQ5332?

the reference clock of CMN PLL block can be from wifi and external xtal, 
the CMN PLL is integrated in the MDIO block, CMN PLL is the independent
block that generates the clocks for the connected Ethernet devices.

> 
> 
> And there are some tiny questions to make sure that we are on the same 
> page:
> a. What is the mentioned Ethernet LDO? AFAIK, LDO is some kind of gate 
> (or switch) that enables clock output through an IPQ5332 pin. Isn't it?

That's correct, the LDO is for enabling the output 50M clock of CMN PLL
to the connected Ethernet device, which is controlled by the hardware
register on the IPQ5332.

> And if it's true, then can you clarify, what exactly clock is outputted?

the 50M clock is outputted to the external Ethernet devices.

> b. Is the Ethernet LDO part of the MDIO block of IPQ5332? According to 
> iomem addresses that was used in the example reg property, the Ethernet 
> LDO is not part of MDIO.

LDO is not the part of MDIO block, LDO has the different register space
from MDIO, which is located in the independent Ethernet part.

> c. Is the CMN PLL part of the MDIO block of IPQ5332? Again, according to 
> iomem address, the CMN PLL is not part of MDIO.

No, CMN PLL is not the part of MDIO block, which is the independent
block, but it generates the clocks to the connected Ethernet devices
managed by MDIO bus, and the CMN PLL block needs to be configured
correctly to generate the clocks to make the MDIO devices(Ethernet
devices) working.

> d. Are GCC AHB & SYS clocks really consumed by MDIO itself? Or are they 
> need for the external reference clock generation?

GCC AHB & SYS clocks are consumed by the uniphy(PCS) that is connected
with the Ethernet devices, so we can say the GCC AHB & SYS clocks are
consumed by the Ethernet devices, which is not for the external
reference clock generation, external reference clock of CMN PLL are the
fix clock that are from wifi or external XO.

> 
> 
> Please answer these questions one by one and we will have a good basis 
> to move forward.
OK.
> 
> 
> 
> To speed up the discussion, let me share my user's view of the reference 
> clocks modeling. I would like to join the option that has already been 
> suggested by the maintainers. It is better to implement reference clocks 
> handling using the clocks API, and the clock subsystem will take care of 
> enabling and configuring them.
> 
> And considering the expected answers to the above questions, I would 
> like to suggest to implement the clock handling using a dedicated clock 
> controlling driver. Or even using several of such tiny dedicated 
> drivers. So DTS will become like this:
> 
>    ext_ref_clock: ext_ref_clock {
>      compatible = "fixed-clock";
>      clock-frequency = <48000000>;
>    };
> 
>    eth_cmn_pll: clock-controller@9b000 {
>      compatible = "qcom,eth-cmn-pll-ipq5223";
>      reg = <0x9b000 0x800>;
>      clocks = <&ext_ref_clock>; /* use external 48MHz clock */
>    };
> 
>    phy0_ext_clk: clock-controller@7a00610 {
>      compatible = "qcom,ipq-eth-ldo";
>      reg = <0x7a00610 0x4>;
>      clocks = <&eth_cmn_pll>;
>    };
> 
>    mdio@90000 {
>      compatible = "qcom,ipq4019-mdio";
>      reg = <0x90000 0x64>;
>      clocks = <&gcc GCC_MDIO_AHB_CLK>;
> 
>      ethernet-phy@1 {
>        compatible = "...";
>        reg = <1>;
>        clocks = <&phy0_ext_clk>;
>        reset-gpios = <&gcc ...>;
>      };
>    };
> 
> -- 
> Sergey

Thanks Sergey for the reference DTS.
Since the GPIO reset of qca8084/qca8386 is needed before configuring the
Ethernet device.

The configuration of and phy0_ext_clk(LDO) should be configured
firstly, which enables the clocks to the Ethernet devices, then the GPIO
reset of the connected Ethernet devices(such as qca8386) can take
effect, currently the GPIO reset takes the MDIO bus level reset.

So phy0_ext_clk can't be put in the PHY device tree node, one LDO
controls the clock output enabled to the connected Ethernet device such
as qca8386.

