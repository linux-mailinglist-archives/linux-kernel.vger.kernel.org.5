Return-Path: <linux-kernel+bounces-20797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D4828558
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515871F2515C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E49374F2;
	Tue,  9 Jan 2024 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b3r6pCWH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3B364DF;
	Tue,  9 Jan 2024 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409BM4h2018891;
	Tue, 9 Jan 2024 11:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vXki4NuBkKObf09YMnXb/tchPytZp9W2B/SRnZQVDgU=; b=b3
	r6pCWH5af7mtGch1lATLL5DlLoCbPiCaxcbcEmwApWwkpe2VHls2E+iQKbPeyMJt
	kIS/LwnXeJhhmVl8NI2qKf1mtXen/QdDbXfghcqDw65EhYiJUOi6MT/6cbi8yUqi
	i673kpA+dQXpGGHjcnnjlpoobF5e7pPK3X0kzurVsHuHMk2gvHbvlO8Sd0q3hVgo
	2zG7FwCB8m6GpoEz9bF4WahL5D9Yy4yNnG8t6wujzGAsLA1nsYpq3iJBFsUDPvM1
	k6Q3vDvrG+Vu1rLBE9GcTlOndQ8bNCKloRJiDeWz3U1R2PanSLaJsyXUjP79kla3
	qb9Sk0+de6xeROusXuVg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgq2ysm7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 11:44:20 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409BiIgm031355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 11:44:18 GMT
Received: from [10.253.15.239] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 03:44:12 -0800
Message-ID: <07c01c11-0cc2-4837-b371-1404f2ce3359@quicinc.com>
Date: Tue, 9 Jan 2024 19:44:08 +0800
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
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <841ef784-b27e-4f7a-94f2-f04f93178c61@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dii3QXZX0Tzs_kISbCTyei3tmZyHI2XW
X-Proofpoint-ORIG-GUID: Dii3QXZX0Tzs_kISbCTyei3tmZyHI2XW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090095



On 1/8/2024 9:19 PM, Andrew Lunn wrote:
>> Since qca8075 PHY is also multiple port PHY, which is same as qca8084,
>> but qca8084 also includes the integrated clock controller, this is the
>> first qcom PHY chip integrating the clock controller internally.
>> can we also consider designing the clocks and resets DT models in the
>> PHY package DT.
>>
>> For qca8084 PURE PHY chip, which is the quad PHY chip and two PCSes,
>> it integrates the clock controller that generates the clocks to be used
>> by the link of PHYs, the integrated controller also provides the resets
>> to the PHY,  the clock controller(NSSCC) driver of qca8084 works at the
>> same way of the GCC of SoC(IPQ), qca8084 needs to be initialized with
>> the clocks and resets for the qca8084 PHY package, these clocks and
>> resets are generated by the NSSCC, even for PURE phy chip qca8084, there
>> is also some PHY package level clocks needs to be initialized.
>>
>> here is the diagram of qca8084.
>> __| |_______________| |__
>> | PCS0 |          |PCS1 |
>> |______|          |_____|
>> |_________________      |
>> |                |      |
>> |     NSSCC      |      |
>> |________________|      |
>> |_______________________|
>> |     |     |     |     |
>> |PHY1 |PHY2 |PHY3 |PHY4 |
>> |_____|_____|_____|_____|
> 
> Please add to the diagram the external clocks and external resets.

__| |_______________| |__
| PCS0 |          |PCS1 |
|______|          |_____|
|_______                |<---- REF clock 50MHZ
|      |------------    |
|NSSCC |    |clks  |rsts|<---- GPIO reset
|______|    |      |    |
|           V      V    |
|_______________________|
|     |     |     |     |
|PHY1 |PHY2 |PHY3 |PHY4 |
|_____|_____|_____|_____|

There are difference clock trees generated from NSSCC for the different
PHYs, all clocks and resets for qca8084 CHIP working are internally
provided by the NSSCC.

> 
> Additionally, add the resets and clocks between the NSSCC and the
> individual PHYs. Typically, the internal clocks and resets are not in
> DT, at last not for a single PHY. For a quad PHY in a package, it
> might make sense to add them. Before we can decide that, we need a
> clear idea what the hardware looks like.

Yes, that is true.
The reason why i add the DTs for the clocks and resets is these clocks
and resets are provided by the internal NSSCC provider driver, in this
chip, both the clock provider and clock consumer are located in the
qca8084 PHY chip.

> 
>> let me example the initial clocks and resets for the pure PHY chip qca8084
>> as below, the clocks and resets should be put into the first
>> MDIO node to be initialized firstly before qca8084 PHY will work.
>>
>> ethernet-phy-package@0 {
>>
>>          #address-cells = <1>;
>>
>>          #size-cells = <0>;
>>
>>          compatible = "ethernet-phy-package";
>>
>>          reg = <0>;
>>
>>
>>
>>          /* initial PHY package level clocks */
>>
>>          clocks = <&qca8k_nsscc NSS_CC_APB_BRIDGE_CLK>,
>>
>>                 <&qca8k_nsscc NSS_CC_AHB_CLK>,
>>
>>                 <&qca8k_nsscc NSS_CC_SEC_CTRL_AHB_CLK>,
>>
>>                 <&qca8k_nsscc NSS_CC_TLMM_CLK>,
>>
>>                 <&qca8k_nsscc NSS_CC_TLMM_AHB_CLK>,
>>
>>                 <&qca8k_nsscc NSS_CC_CNOC_AHB_CLK>,
>>
>>                 <&qca8k_nsscc NSS_CC_MDIO_AHB_CLK>;
> 
> Device tree effectively defined devices on bus, in a tree, and how
> they interconnect. Does the NSSCC have its own address on the MDIO
> bus? Or does it share an address with one of the PHYs? It could be we
> want to describe the NSSCC as a DT node of its own within the
> package. It is probably both a clock consumer, and a clock provider.
> The individual PHYs are then clock consumers, of the clocks the NSSCC
> exports. Same for resets.

Yes, Andrew, the NSSCC provider driver is probed based on the MDIO
device, the PHY CHIP occupies the MDIO addresses, so the NSSCC is
registered as the MDIO device.

The following is the DT of the NSSCC driver, normally we should not
enable the clocks in the clock provider driver. The clocks also can't
be configured during the NSSCC driver probed because of the initial
clocks and resets(mentioned in this DT example ethernet-phy-package@0)
are not configured.

DT of the NSSCC device node:
mdio {
       #address-cells = <1>;
       #size-cells = <0>;

       clock-controller@18 {
         compatible = "qcom,qca8084-nsscc";
         reg = <0x18>;
         clocks = <&qca8k_xo>,
                  <&qca8k_uniphy0_rx>,
                  <&qca8k_uniphy0_tx>,
                  <&qca8k_uniphy1_rx>,
                  <&qca8k_uniphy1_tx>,
                  <&qca8k_uniphy1_rx312p5m>,
                  <&qca8k_uniphy1_tx312p5m>;
         #clock-cells = <1>;
         #reset-cells = <1>;
         #power-domain-cells = <1>;
       };
     };


> 
>>
>>          clock-names = "apb_bridge",
>>
>>                  "ahb",
>>
>>                  "sec_ctrl_ahb",
>>
>>                  "tlmm",
>>
>>                  "tlmm_ahb",
>>
>>                  "cnoc_ahb",
>>
>>                  "mdio_ahb";
>>
>>
>>
>>          /* initial PHY package level reset */
>>
>>          resets = <&qca8k_nsscc NSS_CC_DSP_ARES>;
>>
>>          reset-names = "gephy_dsp";
>>
>>
>>
>>          /* initial clocks and resets for first phy */
>>
>>          phy0 {
>>
>>                  reg = <0>;
>>
>>                  clocks = <&qca8k_nsscc NSS_CC_GEPHY0_SYS_CLK>;
>>
>>                  clock-names = "gephy0_sys";
>>
>>                  resets = <&qca8k_nsscc NSS_CC_GEPHY0_SYS_ARES>,
>>
>>                         <&qca8k_nsscc NSS_CC_GEPHY0_ARES>;
>>
>>                  reset-names = "gephy0_sys",
>>
>>                          "gephy0_soft";
>>
>>          };
>>
>>
>>
>>          /* initial clocks and resets for second phy */
>>
>>          phy1 {
>>
>>                  reg = <1>;
>>
>>                  clocks = <&qca8k_nsscc NSS_CC_GEPHY1_SYS_CLK>;
>>
>>                  clock-names = "gephy1_sys";
>>
>>                  resets = <&qca8k_nsscc NSS_CC_GEPHY1_SYS_ARES>,
>>
>>                         <&qca8k_nsscc NSS_CC_GEPHY1_ARES>;
>>
>>                  reset-names = "gephy1_sys",
>>
>>                          "gephy1_soft";
>>
>>          };
>>
>>
>>
>>          /* initial clocks and resets for third phy */
>>
>>          phy2 {
>>
>>                  reg = <2>;
>>
>>                  clocks = <&qca8k_nsscc NSS_CC_GEPHY2_SYS_CLK>;
>>
>>                  clock-names = "gephy2_sys";
>>                  resets = <&qca8k_nsscc NSS_CC_GEPHY2_SYS_ARES>,
>>
>>                         <&qca8k_nsscc NSS_CC_GEPHY2_ARES>;
>>
>>                  reset-names = "gephy2_sys",
>>
>>                          "gephy2_soft";
>>
>>          };
>>
>>
>>
>>          /* initial clocks and resets for fourth phy */
>>
>>          phy3 {
>>
>>                  reg = <3>;
>>
>>                  clocks = <&qca8k_nsscc NSS_CC_GEPHY3_SYS_CLK>;
>>
>>                  clock-names = "gephy3_sys";
>>
>>                  resets = <&qca8k_nsscc NSS_CC_GEPHY3_SYS_ARES>,
>>
>>                         <&qca8k_nsscc NSS_CC_GEPHY3_ARES>;
>>
>>                  reset-names = "gephy3_sys",
>>
>>                          "gephy3_soft";
>>
>>          };
> 
> This is starting to look O.K.
> 
>>          /* initial clocks and resets for pcs0. */
>>
>>          pcs0 {
>>
>>                  reg = <4>;
>>
>>                  clocks = <&qca8k_nsscc NSS_CC_SRDS0_SYS_CLK>;
>>
>>                  clock-names = "srds0_sys";
>>
>>                  resets = <&qca8k_nsscc NSS_CC_SRDS0_SYS_ARES>;
>>
>>                  reset-names = "srds0_sys";
>>
>>          };
>>
>>
>>
>>          /* initial clocks and resets for pcs1. */
>>
>>          pcs1 {
>>
>>                  reg = <5>;
>>
>>                  clocks = <&qca8k_nsscc NSS_CC_SRDS1_SYS_CLK>;
>>
>>                  clock-names = "srds1_sys";
>>
>>                  resets = <&qca8k_nsscc NSS_CC_SRDS1_SYS_ARES>;
>>
>>                  reset-names = "srds1_sys";
>>
>>          };
> 
> PCS will need further work and thinking about. Typically, they are not
> described in DT for a PHY. In general, a PCS in a PHY does not have a
> driver of its own, the firmware in the PHY mostly controls it, not
> Linux. For the moment, lets leave them as they are, and we will come
> back to them once we get the clocks and resets correctly described.
> 
>       Andrew

Got it.
Since there is no firmware located in the qca8084 PHY, the qca8084 PHY
is only configured by the Linux driver to make it working.

Thanks Andrew for the comments and suggestions.

