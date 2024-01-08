Return-Path: <linux-kernel+bounces-19395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EE3826C54
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666BF1C221E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD1314294;
	Mon,  8 Jan 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gSwj9aSw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606914A89;
	Mon,  8 Jan 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4086SBHx016678;
	Mon, 8 Jan 2024 11:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=36H5GjphPYvxeORwQa+KRPMjUEAJvfmLyoyu0hL94pE=; b=gS
	wj9aSwld33hJ5lXcBLAsQMtLaHNrnhuKQB3PSXEkgeFf1IkckOOK/leALbYwzXXx
	KjJf0yisHGw2scCkhRWPGflMxfd/fHhTHsWhfO0JIvQzqYuhMIC4v1Cpzd+a5GS7
	OCmGjke5xUiDjapqmANw66tSE90ok6+FvwtvDjtcH/ujxlW7RbUtadpfk8ak/wom
	S8hVC0NLP4nG+IB/QflJX+TBJa+CsyOr5OmxMaImoYwSFjxCLu0J15M7Mj3ByKHY
	Ymx+krDECAC43b1xM1Z1sIAthKzHXMhgdiYeeqhOk7RB7rHSrNFfddJ9hE4piv4E
	QbGwTHoM4Pb07MZq6rsA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg97b0t45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 11:13:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408BDknW002923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 11:13:46 GMT
Received: from [10.253.76.26] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 03:13:38 -0800
Message-ID: <b75e6267-7d54-412e-8882-af4d9a0b54e6@quicinc.com>
Date: Mon, 8 Jan 2024 19:13:34 +0800
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
To: Andrew Lunn <andrew@lunn.ch>, Sergey Ryazanov <ryazanov.s.a@gmail.com>
CC: Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko
	<robert.marko@sartura.hr>,
        Vladimir Oltean <olteanv@gmail.com>, Rob Herring
	<robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
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
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <1437d9df-2868-43f5-aebd-e0c57fe4d905@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rmDs5m9z-QNWKbr2VGYfsgblG9aS_q-T
X-Proofpoint-ORIG-GUID: rmDs5m9z-QNWKbr2VGYfsgblG9aS_q-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1011 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080096



On 1/8/2024 2:31 AM, Andrew Lunn wrote:
>> And I would like to ask you about another issue raised by Vladimir [1].
>> These phy chips become SoC with all these built-in PHYs, PCSs, clocks,
>> interrupt controllers, etc. Should we address this now? Or should we go with
>> the proposed solution for now and postpone modeling of other peripherals
>> until we get a real hardware, as Andrew suggested?
>>
>> I'm asking because it looks like we have got a real hardware. Luo currently
>> trying to push QCA8084 (multi-phy/switch chip) support, and this chip
>> exactly contains a huge clock/reset controller [2,3].
> 
> Ideally the reset controller is modelled as a Linux reset
> controller. The clock part of it is modelled using the common clock
> framework. When done correctly, the PHY should not really care. All it
> does is ask for its clock to be enabled, and its reset to be disabled.
> 
> Also, given how difficult it is proving to be to make any progress at
> all, i want to get one little part correctly described, the pure
> PHY. Once we have that, we can start on the next little part. So long
> as we keep to the Linux architecture of blocks or hardware with
> standard Linux drivers, and DT to glue them together, a small step by
> step approach should work out.
> 
>       Andrew

Since qca8075 PHY is also multiple port PHY, which is same as qca8084,
but qca8084 also includes the integrated clock controller, this is the
first qcom PHY chip integrating the clock controller internally.
can we also consider designing the clocks and resets DT models in the
PHY package DT.

For qca8084 PURE PHY chip, which is the quad PHY chip and two PCSes,
it integrates the clock controller that generates the clocks to be used
by the link of PHYs, the integrated controller also provides the resets
to the PHY,  the clock controller(NSSCC) driver of qca8084 works at the
same way of the GCC of SoC(IPQ), qca8084 needs to be initialized with
the clocks and resets for the qca8084 PHY package, these clocks and
resets are generated by the NSSCC, even for PURE phy chip qca8084, there
is also some PHY package level clocks needs to be initialized.

here is the diagram of qca8084.
__| |_______________| |__
| PCS0 |          |PCS1 |
|______|          |_____|
|_________________      |
|                |      |
|     NSSCC      |      |
|________________|      |
|_______________________|
|     |     |     |     |
|PHY1 |PHY2 |PHY3 |PHY4 |
|_____|_____|_____|_____|

let me example the initial clocks and resets for the pure PHY chip 
qca8084 as below, the clocks and resets should be put into the first
MDIO node to be initialized firstly before qca8084 PHY will work.

ethernet-phy-package@0 { 

         #address-cells = <1>; 

         #size-cells = <0>; 

         compatible = "ethernet-phy-package"; 

         reg = <0>; 

 

         /* initial PHY package level clocks */ 

         clocks = <&qca8k_nsscc NSS_CC_APB_BRIDGE_CLK>, 

                <&qca8k_nsscc NSS_CC_AHB_CLK>, 

                <&qca8k_nsscc NSS_CC_SEC_CTRL_AHB_CLK>, 

                <&qca8k_nsscc NSS_CC_TLMM_CLK>, 

                <&qca8k_nsscc NSS_CC_TLMM_AHB_CLK>, 

                <&qca8k_nsscc NSS_CC_CNOC_AHB_CLK>, 

                <&qca8k_nsscc NSS_CC_MDIO_AHB_CLK>; 

         clock-names = "apb_bridge", 

                 "ahb", 

                 "sec_ctrl_ahb", 

                 "tlmm", 

                 "tlmm_ahb", 

                 "cnoc_ahb", 

                 "mdio_ahb"; 

 

         /* initial PHY package level reset */ 

         resets = <&qca8k_nsscc NSS_CC_DSP_ARES>; 

         reset-names = "gephy_dsp"; 

 

         /* initial clocks and resets for first phy */ 

         phy0 { 

                 reg = <0>; 

                 clocks = <&qca8k_nsscc NSS_CC_GEPHY0_SYS_CLK>; 

                 clock-names = "gephy0_sys"; 

                 resets = <&qca8k_nsscc NSS_CC_GEPHY0_SYS_ARES>, 

                        <&qca8k_nsscc NSS_CC_GEPHY0_ARES>; 

                 reset-names = "gephy0_sys", 

                         "gephy0_soft"; 

         }; 

 

         /* initial clocks and resets for second phy */ 

         phy1 { 

                 reg = <1>; 

                 clocks = <&qca8k_nsscc NSS_CC_GEPHY1_SYS_CLK>; 

                 clock-names = "gephy1_sys"; 

                 resets = <&qca8k_nsscc NSS_CC_GEPHY1_SYS_ARES>, 

                        <&qca8k_nsscc NSS_CC_GEPHY1_ARES>; 

                 reset-names = "gephy1_sys", 

                         "gephy1_soft"; 

         }; 

 

         /* initial clocks and resets for third phy */ 

         phy2 { 

                 reg = <2>; 

                 clocks = <&qca8k_nsscc NSS_CC_GEPHY2_SYS_CLK>; 

                 clock-names = "gephy2_sys";
                 resets = <&qca8k_nsscc NSS_CC_GEPHY2_SYS_ARES>, 

                        <&qca8k_nsscc NSS_CC_GEPHY2_ARES>; 

                 reset-names = "gephy2_sys", 

                         "gephy2_soft"; 

         }; 

 

         /* initial clocks and resets for fourth phy */ 

         phy3 { 

                 reg = <3>; 

                 clocks = <&qca8k_nsscc NSS_CC_GEPHY3_SYS_CLK>; 

                 clock-names = "gephy3_sys"; 

                 resets = <&qca8k_nsscc NSS_CC_GEPHY3_SYS_ARES>, 

                        <&qca8k_nsscc NSS_CC_GEPHY3_ARES>; 

                 reset-names = "gephy3_sys", 

                         "gephy3_soft"; 

         }; 

 

         /* initial clocks and resets for pcs0. */ 

         pcs0 { 

                 reg = <4>; 

                 clocks = <&qca8k_nsscc NSS_CC_SRDS0_SYS_CLK>; 

                 clock-names = "srds0_sys"; 

                 resets = <&qca8k_nsscc NSS_CC_SRDS0_SYS_ARES>; 

                 reset-names = "srds0_sys"; 

         }; 

 

         /* initial clocks and resets for pcs1. */ 

         pcs1 { 

                 reg = <5>; 

                 clocks = <&qca8k_nsscc NSS_CC_SRDS1_SYS_CLK>; 

                 clock-names = "srds1_sys"; 

                 resets = <&qca8k_nsscc NSS_CC_SRDS1_SYS_ARES>; 

                 reset-names = "srds1_sys"; 

         }; 
 

};

appreciated for the PHY package level DT model design.

