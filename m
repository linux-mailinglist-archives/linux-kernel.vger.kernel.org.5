Return-Path: <linux-kernel+bounces-2971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AE6816562
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF321C22174
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486CB5392;
	Mon, 18 Dec 2023 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kI1/rP3J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465333C3F;
	Mon, 18 Dec 2023 03:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI2Hlgx021170;
	Mon, 18 Dec 2023 03:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yyKM8tIA8Gm7cyAlgfj8PpOwjrQQ4AfU/FmZy6+Ljf8=; b=kI
	1/rP3J7IA1ScVblZ6+gnILov0JVeTC4QDOQABwVPqypgi5zRuQ0vrfiV2091fgfh
	6d8VLKUQPeVxKLlwaDy2DszBug11R81GUZcotAQfza9QCgwuD4RIb3nZvcg0IGhD
	RNV9oF6V1roqYnCc8D9X4/nSOVSZUOkvbSlBAE85kwRjHtxP8vFwJMTi8K8Q7dKN
	jMAkgginMWCmR0oiRki1S22kjHfOQdsmN+2t7IV03ofgiIocQMUTRzOEJ5MqomiI
	PnRs8T66iyBNwEh95jM4m5BV1upFAwHU+FcgInAJ1/nC7KE+MxB/WvMBlwd1MYx1
	7iKx1FIJPvGMlYT+ZAOQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14yg374k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 03:31:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI3VKha031417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 03:31:20 GMT
Received: from [10.253.9.247] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Dec
 2023 19:31:15 -0800
Message-ID: <ecf77d6b-e160-410c-a4f2-281ca8980509@quicinc.com>
Date: Mon, 18 Dec 2023 11:31:13 +0800
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
        <linux-doc@vger.kernel.org>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch>
 <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>
 <f5c5cbce-c36e-498a-97e2-35f06d927d74@lunn.ch>
 <a9798333-3105-422f-8033-76c0b1d4f439@quicinc.com>
 <15d95222-35dd-4ea1-a1a3-3ad9e4ef0349@lunn.ch>
 <ZX31pq4yXM8Fb/rj@shell.armlinux.org.uk>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZX31pq4yXM8Fb/rj@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BlvCavNIj8Ee3x0LWYgToLPTkUPrd4-L
X-Proofpoint-GUID: BlvCavNIj8Ee3x0LWYgToLPTkUPrd4-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=619 suspectscore=0 adultscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180023



On 12/17/2023 3:08 AM, Russell King (Oracle) wrote:
> On Sat, Dec 16, 2023 at 06:30:00PM +0100, Andrew Lunn wrote:
>>> The following is the chip package, the chip can work on the switch mode
>>> like the existed upstream code qca8k, where PHY1-PHY4 is connected with
>>> MAC1-MAC4 directly; The chip can also work on the PHY mode, where PHY1-
>>> PHY4 is connected with PCS1 by 10g-qxgmii; Either switch mode or PHY mode,
>>> the PHY4 is optionally connected with PCS0 by SGMII, PCS0 and PCS1
>>> are connected with the SoC(IPQ platform) PCSes.
>>
>> I don't really understand. Are you saying the hardware is actually :
>>
>>
>> +----------------------------------------------+
>> |          PCS1           PCS0                 |
>> |                                              |
>> |          MAC0           MAC5                 |
>> |           |              |                   |
>> |     +-----+--------------+-------------+     |
>> |     |                                  |     |
>> |     |                Switch            |     |
>> |     |                                  |     |
>> |     +-+---------+---------+---------+--+     |
>> |       |         |         |         |        |
>> |      MAC1      MAC2      MAC3      MAC4      |
>> |                                              |
>> |      PHY1      PHY2      PHY3      PHY4      |
>> +----------------------------------------------+
>>
>> When in PHY mode, the switch is hard coded to map the 4 PCS1 channels
>> straight to MAC1-MAC4 and all switch functionality is disabled. But
>> then in switch mode, the switch can be controlled as a DSA switch? The
>> 10G PCS1 is then a single 10G port, not 4x 2.5G?
>>
>> Is there a product brief for this PHY? That might help us understand
>> this hardware?
> 
> Not even digikey give any clues what "QCA8084" is - they list it as
> "unclassified" and give no documentation and no photo. Basically it
> seems to be a super secret device.
> 
Sorry for the confusion here, maybe the chip is developed recently,
which leads to the Doc or introduction is not released in time.


