Return-Path: <linux-kernel+bounces-2969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFA881655A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95921F2239F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F95238;
	Mon, 18 Dec 2023 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N0qMc3BU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97B03C0C;
	Mon, 18 Dec 2023 03:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI3PpHZ014875;
	Mon, 18 Dec 2023 03:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gojjaXBEc+kO4oVw4mzTak01G0tZndo2wiSa7LeZHSo=; b=N0
	qMc3BUjp6/i8PiiLyDRgIA2Tprm2PsYw2mqwdoRUOH5u6Bs1NRKjhwTu8LlAthFm
	uUDGwAJzA+ycoUZO8U4DdOf6eeSnh0vN2yue17qDPUxHVI1+0OLkUxRHAr/s8feW
	UxCuDuCc625FOQPhhDq5K9D+2xlVXbBI++4Uq7RTa1iqeVei4KhLl0BoEPnkP4JS
	rCNgOUru+WFohEGisQAfM6silHx8y4B5nieXNqjXle6vvrZ5Ccl5nefUpFNVjTAK
	tg3cQueDRLhHvAQ1y0Qw4OO0olVuJb38/+XBkVGF+IgugsuCuoFU+M3Nir+CpKtC
	dWHFGp7fZV1pUdGFDOjA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v1536u6yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 03:27:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI3Rggp030682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 03:27:42 GMT
Received: from [10.253.9.247] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Dec
 2023 19:27:37 -0800
Message-ID: <7638f650-cf8c-4245-a28f-b1a9edf33c38@quicinc.com>
Date: Mon, 18 Dec 2023 11:27:34 +0800
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
 <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
 <15d95222-35dd-4ea1-a1a3-3ad9e4ef0349@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <15d95222-35dd-4ea1-a1a3-3ad9e4ef0349@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zFsfc1a37Geumjp2IrytesshiosWIibg
X-Proofpoint-ORIG-GUID: zFsfc1a37Geumjp2IrytesshiosWIibg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=957
 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180022



On 12/17/2023 1:30 AM, Andrew Lunn wrote:
>> The following is the chip package, the chip can work on the switch mode
>> like the existed upstream code qca8k, where PHY1-PHY4 is connected with
>> MAC1-MAC4 directly; The chip can also work on the PHY mode, where PHY1-
>> PHY4 is connected with PCS1 by 10g-qxgmii; Either switch mode or PHY mode,
>> the PHY4 is optionally connected with PCS0 by SGMII, PCS0 and PCS1
>> are connected with the SoC(IPQ platform) PCSes.
> 
> I don't really understand. Are you saying the hardware is actually :
> 
> 
> +----------------------------------------------+
> |          PCS1           PCS0                 |
> |                                              |
> |          MAC0           MAC5                 |
> |           |              |                   |
> |     +-----+--------------+-------------+     |
> |     |                                  |     |
> |     |                Switch            |     |
> |     |                                  |     |
> |     +-+---------+---------+---------+--+     |
> |       |         |         |         |        |
> |      MAC1      MAC2      MAC3      MAC4      |
> |                                              |
> |      PHY1      PHY2      PHY3      PHY4      |
> +----------------------------------------------+
> 

Actually there are two CHIP types, ,let me explain to be more clear.

1. The diagram you describe is actually the switch work mode, which has
the different chip name called qca8386, the DSA driver and PHY driver
are used, since the general PHY driver can't work for the PHY here.

  +----------------------------------------------+
  | +-----+
  | | GCC |
  | +-----+  PCS1           PCS0                 |
  |                                              |
  |          MAC0           MAC5                 |
  |           |              |                   |
  |     +-----+--------------+-------------+     |
  |     |                                  |     |
  |     |                Switch            |     |
  |     |                                  |     |
  |     +-+---------+---------+---------+--+     |
  |       |         |         |         |        |
  |      MAC1      MAC2      MAC3      MAC4      |
  |                                              |
  |      PHY1      PHY2      PHY3      PHY4      |
  +----------------------------------------------+

2. The pure PHY chip called by qca8084 works on the PHY mode 10-qxgmii
on quad-phy, or the sgmii mode can be configured on PHY4 optionally.
The qca8084 is below, there is no MAC involved on qca8084.

  +----------------------------------------------+
  |          PCS1           PCS0                 |
  |                                              |
  |   +-----+
  |   | GCC |
  |   +-----+
  |                                              |
  |      PHY1      PHY2      PHY3      PHY4      |
  +----------------------------------------------+

On qca8386, the same qca8084 PHY is used, but the qca8084 PHY is
connected with internal MAC directly same as qca8337(qca8k dsa driver).

On both Ethernet chips qca8386 and qca8084, GCC block is same and
with the same clock controller driver that provides the clocks and
resets used by the qca8084 PHY driver and qca8386 DSA driver(leverage
the existed DSA driver qca8k.c).

> When in PHY mode, the switch is hard coded to map the 4 PCS1 channels
> straight to MAC1-MAC4 and all switch functionality is disabled. But
> then in switch mode, the switch can be controlled as a DSA switch? The
> 10G PCS1 is then a single 10G port, not 4x 2.5G?

For the qca8084 PHY chip, there is no MAC involved, the PHY is connected 
with the PCS with 10g-qxgmii, PHY4 is optional connected with sgmii.

For the qca8386 switch chip, it is controlled as DSA, the PCS is
connected with the SOC(such as IPQ5332) PCS.
> 
> Is there a product brief for this PHY? That might help us understand
> this hardware?
> 
Sorry, i also searched it on the internet and Qualcomm website, there is
no Doc found, the CHIP is developed recently 1-2 year before, the Doc is
not updated to the website.

>      Andrew

