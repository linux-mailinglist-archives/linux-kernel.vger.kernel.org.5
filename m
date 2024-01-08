Return-Path: <linux-kernel+bounces-19232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA955826A11
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B79B21B62
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C7DDBD;
	Mon,  8 Jan 2024 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O59smkcF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD761118C;
	Mon,  8 Jan 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4087Hf5v009254;
	Mon, 8 Jan 2024 09:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rOfctw++PUBILkkvixQPj+AABeHQSmMuQzLQY1deU9w=; b=O5
	9smkcFbu7vKwQ5VM56PZMnwFDY0xjm59djQkTNuhdOHqeYbkc/NkmvJabbkItjzI
	bn/nmVRWu5On8IWlNQIJto0rX3L5q1rA4GPkn3M4Lwce4KPmsBEpYgn53tGSb3zT
	OR8UCkC9AYTQFR05DrjOulXQlXAtpUPMHNFIkZtM2pHGfk51zlhY50DXMN8zysYV
	MLNMGULo2UsgOL9VpFSaPLQ3bP2aW5NFqdzONHIxjV7/ec3fF9+qWgnga9VvBsY7
	h2CeHEEzCHLOBAgIr/opXDm0/hUh0qxPKMLbYqhx11/JKVnfbiNyoOdYflKB2w1y
	P5mzMhXQxi3LNBZZvJZA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgbu2g8f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 09:01:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40891Qq7008995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 09:01:26 GMT
Received: from [10.253.76.26] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 01:01:18 -0800
Message-ID: <e8722b79-e58a-4856-ae56-e44e2860c2f6@quicinc.com>
Date: Mon, 8 Jan 2024 17:01:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] support ipq5332 platform
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Sergey Ryazanov <ryazanov.s.a@gmail.com>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
 <cfb04c82-3cc3-49f6-9a8a-1f6d1a22df40@quicinc.com>
 <dd05a599-247a-4516-8ad3-7550ceea99f7@gmail.com>
 <ac1977f5-cd6a-4f16-b0a0-f4322c34c5f5@quicinc.com>
 <bdeca791-f2e5-4256-b386-a75c03f93686@gmail.com>
 <895eadd7-1631-4b6b-8db4-d371f2e52611@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <895eadd7-1631-4b6b-8db4-d371f2e52611@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rK1-JPpjQXFI3bJprToWqy5EzZNKUM8G
X-Proofpoint-ORIG-GUID: rK1-JPpjQXFI3bJprToWqy5EzZNKUM8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=689 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401080075



On 1/6/2024 11:45 PM, Andrew Lunn wrote:
>> I just realized that the UNIPHY block is a MII (probably SGMII) controller.
>> Isn't it? And I expect that it responsible more then just for clock
>> enabling. It should also activate and perform a basic configuration of MII
>> for actual data transmission. If so, then it should placed somewhere under
>> drivers/net/phy or drivers/net/pcs.

UNIPHY is located in PPE, which controls the interface mode for
connecting with external PHY, the hardware register(4 bytes) of UNIPHY
is accessed by local bus(ioremap).

> 
> Before we decide that, we need a description of what the UNIPHY
> actually does, what registers it has, etc. Sometimes blocks like this
> get split into a generic PHY, aka drivers/phy/ and a PCS driver. This
> would be true if the UNIPHY is also used for USB SERDES, SATA SERDES
> etc. The SERDES parts go into a generic PHY driver, and the SGMII on
> to of the SERDES is placed is a PCS driver.

Hi Andrew,
the UNIPHY is the hardware part of PPE(packet process engine) in IPQ
platform, which can't be used for USB, SATA serdes, the UNIPHY of
PPE is dedicated for connecting with external PHY CHIP.

> 
> The problem i have so far is that there is no usable description of
> any of this hardware, and the developers trying to produce drivers for
> this hardware don't actually seem to understand the Linux architecture
> for things like this.

Sorry for missing this description of UNIPHY, since the UNIPHY block is
the part of PPE, PPE driver will be posted as the independent driver for
review, so i did not give the description of UNIPHY.

The IPQ PPE includes MAC and UNIPHY integrated, the connection with
external PHY is as below.
MAC ---- UNIPHY(PCS) ---- (PCS)external PHY.

The UNIPHY here is the Ethernet dedicated SERDES for connecting with
external PHY.

> 
>> As far as I understand, we basically agree that clocks configuration can be
>> implemented based on the clock API using a more specialized driver(s) than
>> MDIO. The only obstacle is the PHY chip initialization issue explained
>> below.
>> Thank you for this compact yet detailed summary. Now it much more clear,
>> what this phy chip requires to be initialized.
>>
>> Looks like you need to implement at least two drivers:
>> 1. chip (package) level driver that is responsible for basic "package"
>> initialization;
>> 2. phy driver to handle actual phy capabilities.
> 
> Nope. As i keep saying, please look at the work Christian is
> doing. phylib already has the concept of a PHY package, e.g. look at
> the MSCC driver, and how it uses devm_phy_package_join(). What is
> missing is a DT binding which allows package properties to be
> expressed in DT. And this is what Christian is adding.
> 
> 	  Andrew

Thanks Andrew, the driver of qca8084 will be updated based on the
concept of PHY package.

