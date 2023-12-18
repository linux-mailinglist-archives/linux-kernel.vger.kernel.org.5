Return-Path: <linux-kernel+bounces-2955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8A81652C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66E71F21B22
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517783C23;
	Mon, 18 Dec 2023 03:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fqYhvevW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB4628FA;
	Mon, 18 Dec 2023 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI2Fr3o019478;
	Mon, 18 Dec 2023 03:01:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ijg50v2NRSyEcWW1uDog7pK7q6uRGdgRLOO5t2TDY5U=; b=fq
	YhvevW2ldbJfeZZZgTYAL9KHhnR+M729U7FmmQBIAYJ9ei4EMUn3UA6oeVZGIfrr
	A3+q/b/y2QWgOjxNMY4bPt8B8D+MSGgQnz3yov+z8FpdkY09Et91ptBsAL5TZnbI
	pUXHx0BuveB7d+sjFBXmECn4mlDbqSw2Am4gHvijM9mobVwTALQ8CmU3Ytyb/3Kq
	knzmOdJDqGS1Ikdzn7fmFqu8ZyExj/JiVIeGnepPz4+oz8egdN1oXzma44pqX3Z9
	AaueKvquZyk5oVNcCdgcabqQAltUpFfmTVZTjwCX5XOC4Ovpn0YZc9Y5g9GCvN84
	wP714JJRcle/iGzBeRuQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v151fu7f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 03:01:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI31AAA001558
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 03:01:10 GMT
Received: from [10.253.9.247] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Dec
 2023 19:01:05 -0800
Message-ID: <1bddd434-024c-45ff-9866-92951a3f555f@quicinc.com>
Date: Mon, 18 Dec 2023 11:01:03 +0800
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
CC: Andrew Lunn <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
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
 <6abe5d6f-9d00-445f-8c81-9c89b9da3e0a@quicinc.com>
 <ZX3LqN8DSdKXqsYc@shell.armlinux.org.uk>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZX3LqN8DSdKXqsYc@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 51ZW3ugJimD_YNNjYwMWwlsUrfy0Zysl
X-Proofpoint-ORIG-GUID: 51ZW3ugJimD_YNNjYwMWwlsUrfy0Zysl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180021



On 12/17/2023 12:09 AM, Russell King (Oracle) wrote:
> On Sat, Dec 16, 2023 at 10:41:28PM +0800, Jie Luo wrote:
>>
>>
>> On 12/16/2023 9:51 PM, Russell King (Oracle) wrote:
>>> On Sat, Dec 16, 2023 at 11:21:53AM +0100, Andrew Lunn wrote:
>>>>> The following is the chip package, the chip can work on the switch mode
>>>>> like the existed upstream code qca8k, where PHY1-PHY4 is connected with
>>>>> MAC1-MAC4 directly;
>>>>
>>>> Ah, that is new information, and has a big effect on the design.
>>>
>>> This QCA8084 that's being proposed in these patches is not a PHY in
>>> itself, but is a SoC. I came across this:
>>>
>>>    https://www.rt-rk.com/android-tv-solution-tv-in-smartphone-pantsstb-based-on-qualcomm-soc-design/
>>
>> The chip mentioned in the link you mentioned is SoC, which is not the
>> chip that the qca8084 driver work for.
> 
> So there's two chips called QCA8084 both produced by Qualcomm? I find
> that hard to believe.
> 

The SoC mentioned in the link you provided is the APQ8084 that is 
introduced in the link below:
https://www.qualcomm.com/products/mobile/snapdragon/smartphones/snapdragon-8-series-mobile-platforms/snapdragon-processors-805

https://hwbot.org/hardware/processor/snapdragon_805_apq8084_pro__(8084_fusion_4.5)_2700mhz/

The driver here is for qca8084, which has the different prefix,
and qca8084 is the Ethernet CHIP like qca8081, but qca8084 is
multiple ports(quad-phy).

