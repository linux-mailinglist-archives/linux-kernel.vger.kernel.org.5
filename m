Return-Path: <linux-kernel+bounces-4926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5A68183E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18834289E32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FFA125DE;
	Tue, 19 Dec 2023 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="koAV2O/O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E076612B60;
	Tue, 19 Dec 2023 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ6Kjam014499;
	Tue, 19 Dec 2023 08:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2IjR9WTnZRSKRr83K1HzdaurKy9qc2TXBR1+H/1+Ylw=; b=ko
	AV2O/OO8D/uxHVWkV/XDCxmax62VWzvwWU2ygVVS8SEN6SjOxMpX1zeuubdza3yH
	svyHNZ+L5w4RulT3u+15W/vRIA1apVvrVJBZQQ0F+XWFl3sfux+n7foXQkKWGi7f
	aV19Tcb99NYosJ7VV2Ii5eyakfHl8Vn4fX/vQ2pU/9r3P4ISnwS9ncg581p+VpXY
	uSwYJG4qwlgNddRsv72NO5cwiKZk1lF6fGmQeYhlhFkrYlNWIIlaVLuFdTAj9WQH
	1WwIZ+ZhBJvFE5gstw54Tecp2/wzsd8K0AGDRR2ZE3hIXXL0FnZdNRrT5Fg1g0Vf
	Ojp8E/7CpvNF4SNgdxGQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v35tm8dqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 08:52:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJ8qtrg020141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 08:52:55 GMT
Received: from [10.253.32.162] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 00:52:51 -0800
Message-ID: <f01665a8-96cb-4ddc-94d8-7f1811a12a23@quicinc.com>
Date: Tue, 19 Dec 2023 16:52:48 +0800
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
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <corbet@lwn.net>, <p.zabel@pengutronix.de>,
        <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <bdfba8a7-9197-4aae-a7f9-6075a375f60b@linaro.org>
 <c3391e33-e770-4c61-855e-d90e82b95f75@quicinc.com>
 <4cb2bd57-f3d3-49f9-9c02-a922fd270572@lunn.ch>
 <ed0dd288-be8a-4161-a19f-2d4d2d17b3ec@quicinc.com>
 <ZXxXzm8hP68KrXYs@shell.armlinux.org.uk>
 <3a40570b-40bf-4609-b1f4-a0a6974accea@quicinc.com>
 <b5ff9f69-e341-4846-bc5a-ebe636b7a71a@lunn.ch>
 <27ee13e7-5073-413c-8481-52b92d7c3687@quicinc.com>
 <b4fe4ac4-9b28-4dba-8287-1af4804eb0be@lunn.ch>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <b4fe4ac4-9b28-4dba-8287-1af4804eb0be@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kTfYW9S0PLYnargAsECQcv-y7BrqhOMP
X-Proofpoint-ORIG-GUID: kTfYW9S0PLYnargAsECQcv-y7BrqhOMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=665
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190065



On 12/18/2023 5:34 PM, Andrew Lunn wrote:
>> Thanks Andrew for the proposal.
>> For the pure PHY chip qca8084, there is no driver to parse the package
>> level device tree node for common clocks and resets.
> 
> So you still have not look at the work Christian is doing. You must
> work together with Christian. This driver is not going to be accepted
> unless you do.
OK, Andrew, i am looking at Christian's patches on at803x.c, and i will
update qca8084 patches based on Christian's patch set.

> 
>>>>           ethernet-phy@0 {
>>>>               compatible = "ethernet-phy-id004d.d180";
>>>>               reg = <0>;
>>>>               clocks = <qca8k_nsscc NSS_CC_GEPHY0_SYS_CLK>,
>>>>               clock-names = <"gephy_sys">;
>>>>               resets = <&qca8k_nsscc NSS_CC_GEPHY0_SYS_ARES>,
>>>>                        <&qca8k_nsscc NSS_CC_GEPHY0_ARES>;
>>>>               reset-names = "gephy_sys", "gephy_soft";
> 
> Which of these properties exist for the Pure PHY device? Which exist
> for the integrated switch? And by that, i mean which are actual pins
> on the PHY device? We need the device tree binding to list which
> properties are required for each use case.
> 
> 	   Andrew

Hi Andrew,
For the clocks and resets listed here, only the clock "mdio_master_ahb"
is dedicated in qca8386, others are needed on the both chips qca8386
and qca8084.

Here is the DTS example for the clocks and resets working on the
devices, from the example below, we can get the dedicated clocks
and resets for each MDIO device and package level device.

The DTS properties in the "qcom,phy-common" should be initialized by
the first PHY probe function, and only being initialized one time.

phy0: ethernet-phy@0 { 

         compatible = "ethernet-phy-id004d.d180"; 

         reg = <1>;

         /* Package level configs, applicable on qca8386 and qca8081. */ 

         phy-common-config { 

                 qcom,phy-addr-fixup = <1 2 3 4 5 6 7>; 

                 qcom,phy-work-mode = <2>; 

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

 

                 resets = <&qca8k_nsscc NSS_CC_DSP_ARES>; 

                 reset-names = "gephy_dsp"; 

 

                 ethernet-ports { 

                         /* clocks and resets for pcs0. */ 

                         pcs0 {
                                 clocks = <&qca8k_nsscc 
NSS_CC_SRDS0_SYS_CLK>;
                                 clock-names = "srds0_sys"; 

                                 resets = <&qca8k_nsscc 
NSS_CC_SRDS0_SYS_ARES>;
                                 reset-names = "srds0_sys"; 

                         };

                         /* clocks and resets for pcs1. */ 

                         pcs1 {
                                 clocks = <&qca8k_nsscc 
NSS_CC_SRDS1_SYS_CLK>;
                                 clock-names = "srds1_sys"; 

                                 resets = <&qca8k_nsscc 
NSS_CC_SRDS1_SYS_ARES>;
                                 reset-names = "srds1_sys"; 

                         };

			/* clocks and resets for first phy */
                         phy0 {
                                 clocks = <&qca8k_nsscc 
NSS_CC_GEPHY0_SYS_CLK>;
                                 clock-names = "gephy0_sys"; 

                                 resets = <&qca8k_nsscc 
NSS_CC_GEPHY0_SYS_ARES>,
                                        <&qca8k_nsscc 
NSS_CC_GEPHY0_ARES>;
                                 reset-names = "gephy0_sys", 

                                         "gephy0_soft"; 

                         }; 


			/* clocks and resets for second phy */ 

                         phy1 {
                                 clocks = <&qca8k_nsscc 
NSS_CC_GEPHY1_SYS_CLK>;
                                 clock-names = "gephy1_sys"; 

                                 resets = <&qca8k_nsscc 
NSS_CC_GEPHY1_SYS_ARES>,
                                        <&qca8k_nsscc 
NSS_CC_GEPHY1_ARES>;
                                 reset-names = "gephy1_sys", 

                                         "gephy1_soft"; 

                         }; 


			/* clocks and resets for third phy */ 

                         phy2 {
                                 clocks = <&qca8k_nsscc 
NSS_CC_GEPHY2_SYS_CLK>;
                                 clock-names = "gephy2_sys"; 

                                 resets = <&qca8k_nsscc 
NSS_CC_GEPHY2_SYS_ARES>,
                                        <&qca8k_nsscc 
NSS_CC_GEPHY2_ARES>;
                                 reset-names = "gephy2_sys", 

                                         "gephy2_soft"; 

                         }; 


			/* clocks and resets for fourth phy */ 

                         phy3 {
                                 clocks = <&qca8k_nsscc 
NSS_CC_GEPHY3_SYS_CLK>;
                                 clock-names = "gephy3_sys"; 

                                 resets = <&qca8k_nsscc 
NSS_CC_GEPHY3_SYS_ARES>,
                                        <&qca8k_nsscc 
NSS_CC_GEPHY3_ARES>;
                                 reset-names = "gephy3_sys", 

                                         "gephy3_soft"; 

                         }; 

 

                 }; 

         };

phy1: ethernet-phy@1 { 

         compatible = "ethernet-phy-id004d.d180"; 

         reg = <2>; 

};
 

phy2: ethernet-phy@2 { 

         compatible = "ethernet-phy-id004d.d180"; 

         reg = <3>; 

}; 

 

phy3: ethernet-phy@3 { 

         compatible = "ethernet-phy-id004d.d180"; 

         reg = <4>; 

};

