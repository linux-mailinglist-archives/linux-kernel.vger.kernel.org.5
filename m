Return-Path: <linux-kernel+bounces-2136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DAD815858
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 08:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02741F25303
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DB614010;
	Sat, 16 Dec 2023 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j+yNSa8B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00650134AD;
	Sat, 16 Dec 2023 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG7nUMZ018883;
	Sat, 16 Dec 2023 07:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fnMD6sWn5JauQnf2NKHRcmULg+huo6geS/+D0dv+DQE=; b=j+
	yNSa8B9G3KRVEhXl9Lr4B7peUC2XdxZiNs4YCPZFM9rOyVRwbcsQTl7m4yw4gcLX
	9dd7PJVTBr0N971O9Scm5xbkViTZw7oJoKz7SNDb2nuOHppToTs3TQk96h2Xj1dG
	5L+oa1kPHpTG9gmpMWgRe7SkbN4LGws+sA0t7TmBcZ/3Fs4SVApyObUNcC+xngX2
	mqnNW/e9ZCQZFDieIxNSyLov86AQNQn6LN3jtVCyAtIZVZw5117z4nPvbgKWaZe6
	KJ7VUC/gZy5GQkwQZMjdtyuUil1sV06w8MmhrH4ZSjRu5/eljTm0qyMzHgOB9tI+
	vKWmhyFI0ZB7y1h5NP9w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14xy070k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 07:58:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG7w49s024125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 07:58:04 GMT
Received: from [10.253.9.247] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 23:58:00 -0800
Message-ID: <3a40570b-40bf-4609-b1f4-a0a6974accea@quicinc.com>
Date: Sat, 16 Dec 2023 15:57:57 +0800
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
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>,
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
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZXxXzm8hP68KrXYs@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZTp40rRHLF3MMr3sZOw_pyzCnD4WlzwX
X-Proofpoint-ORIG-GUID: ZTp40rRHLF3MMr3sZOw_pyzCnD4WlzwX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312160060



On 12/15/2023 9:42 PM, Russell King (Oracle) wrote:
> On Fri, Dec 15, 2023 at 08:16:53PM +0800, Jie Luo wrote:
>> On 12/15/2023 7:25 PM, Andrew Lunn wrote:
>>>> The "maxItems: 1" of the property resets is defined in ethernet-phy.yaml
>>>> that is referenced by qca,ar803x.yaml, but i have 11 reset instances
>>>> used for qca8084 PHY
>>>
>>> 11!?!?? Really? Why?
>>>
>>> I assume the order and timer matters, otherwise why would you need
>>> 11? So the PHY driver needs to handle this, not phylib framework. So
>>> you will be adding vendor properties to describe all 11 of them. So
>>> ethernet-phy.yaml does not matter.
>>>
>>> 	Andrew
>>
>> Since these resets need to be configured in the special sequence, and
>> these clocks need to be configured with different clock rate.
>>
>> But the clock instance get, the property name is fixed to "clock-names"
>> according to the function of_parse_clkspec, and the reset property name
>> is also fixed to "reset-names" from function __of_reset_control_get.
> 
> I think you need to give more details about this.
> 
> Where are these 11 resets located? What is the sequence? Why does the
> PHY driver need to deal with each individual reset?

All these resets and clocks are located in qca8084 chip that includes
the GCC module registered as the clock provider, all these clocks and
resets are from qca8084 clock provider driver, the clock and reset name
prefix with PCS or EPHY is for the individual MDIO device, others are
the qca8084 level, but these clocks and resets need to be initialized
completely, then the PHY probe function can be initialized correctly
with the PHY capabilities acquired after the qca8084 chip level GPIO
reset.

The sequence code is realized in the function qca8084_clock_config of
the patch <net: phy: at803x: add qca808x initial config sequence>, this
function is doing as below.
1. set the Ethernet system clock tree as 25M clock rate.
2. reset and enable PCS system clocks.
3. reset and enable the PHY system clocks.
4. loading the efuse, which is not related the clock and reset.

> 
> IMHO, a PHY driver should _not_ be dealing with the resets outside of
> the PHY device itself, and I find it hard to imagine that qca8084
> would have 11 external resets.

Indeed, these resets are not for a PHY device, some are the chip level
resets, and each PHY has the individual resets.

> 
> If these are 11 internal resets (to qca8084) then why are you using the
> reset subsystem, and why do you need to describe them in DT? Surely if
> they are internal to the PHY, that can be encapsulated within the PHY
> driver?

These resets and clocks are realized by the qca8k clock controller
driver, and i use the clock consumer APIs to initialize these clocks and
resets,
when qca8084 works on the PHY mode, there are only PHY driver
and PCS driver needed to be enabled to make PHY working, and these
clocks and resets need to be initialized before the PHY probe function
finished correctly, where the phy capabilities is read during the probe
function.

> 
> This is an example of why it is useful to have an _example_ of the use
> of this binding, because it would answer some of the above questions.
> 

Yes, Russell, i will add an example in the DT doc in the next patch set.
The following is the device node used for the current qca8084 PHY
code design.

mdio: mdio@90000 {
     ethernet-phy@0 { 

               compatible = "ethernet-phy-id004d.d180"; 

               reg = <1>; 

               qcom,phy-addr-fixup = <1 2 3 4 5 6 7>; 

               qcom,phy-work-mode = <2>; 

               clocks = <&qca8k_nsscc NSS_CC_APB_BRIDGE_CLK>, 

                      <&qca8k_nsscc NSS_CC_AHB_CLK>, 

                      <&qca8k_nsscc NSS_CC_SEC_CTRL_AHB_CLK>, 

                      <&qca8k_nsscc NSS_CC_TLMM_CLK>, 

                      <&qca8k_nsscc NSS_CC_TLMM_AHB_CLK>, 

                      <&qca8k_nsscc NSS_CC_CNOC_AHB_CLK>, 

                      <&qca8k_nsscc NSS_CC_MDIO_AHB_CLK>, 

                      <&qca8k_nsscc NSS_CC_MDIO_MASTER_AHB_CLK>, 

                      <&qca8k_nsscc NSS_CC_SRDS0_SYS_CLK>, 

                      <&qca8k_nsscc NSS_CC_SRDS1_SYS_CLK>, 

                      <&qca8k_nsscc NSS_CC_GEPHY0_SYS_CLK>, 

                      <&qca8k_nsscc NSS_CC_GEPHY1_SYS_CLK>, 

                      <&qca8k_nsscc NSS_CC_GEPHY2_SYS_CLK>, 

                      <&qca8k_nsscc NSS_CC_GEPHY3_SYS_CLK>; 

 

               clock-names = "apb_bridge", 

                       "ahb", 

                       "sec_ctrl_ahb", 

                       "tlmm", 

                       "tlmm_ahb", 

                       "cnoc_ahb", 

                       "mdio_ahb", 

                       "mdio_master_ahb", 

                       "srds0_sys", 

                       "srds1_sys", 

                       "gephy0_sys", 

                       "gephy1_sys", 

                       "gephy2_sys", 

                       "gephy3_sys";
               resets = <&qca8k_nsscc NSS_CC_SRDS0_SYS_ARES>, 

                      <&qca8k_nsscc NSS_CC_SRDS1_SYS_ARES>, 

                      <&qca8k_nsscc NSS_CC_GEPHY0_SYS_ARES>, 

                      <&qca8k_nsscc NSS_CC_GEPHY1_SYS_ARES>, 

                      <&qca8k_nsscc NSS_CC_GEPHY2_SYS_ARES>, 

                      <&qca8k_nsscc NSS_CC_GEPHY3_SYS_ARES>, 

                      <&qca8k_nsscc NSS_CC_GEPHY0_ARES>, 

                      <&qca8k_nsscc NSS_CC_GEPHY1_ARES>, 

                      <&qca8k_nsscc NSS_CC_GEPHY2_ARES>, 

                      <&qca8k_nsscc NSS_CC_GEPHY3_ARES>, 

                      <&qca8k_nsscc NSS_CC_DSP_ARES>; 

 

               reset-names = "srds0_sys", 

                       "srds1_sys", 

                       "gephy0_sys", 

                       "gephy1_sys", 

                       "gephy2_sys", 

                       "gephy3_sys", 

                       "gephy0_soft", 

                       "gephy1_soft", 

                       "gephy2_soft", 

                       "gephy3_soft", 

                       "gephy_dsp"; 

 

       }; 

       ethernet-phy@1 { 

               compatible = "ethernet-phy-id004d.d180"; 

               reg = <2>; 

       }; 

       ethernet-phy@2 { 

               compatible = "ethernet-phy-id004d.d180"; 

               reg = <3>; 

       }; 

 

       ethernet-phy@3 { 

               compatible = "ethernet-phy-id004d.d180"; 

               reg = <4>; 

       };
    };

Thanks.

