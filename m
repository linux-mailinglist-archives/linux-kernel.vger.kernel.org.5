Return-Path: <linux-kernel+bounces-928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC1B814824
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9BB1C23472
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AAE2AD2D;
	Fri, 15 Dec 2023 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kwsZ2WCX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002CE2C868;
	Fri, 15 Dec 2023 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFCQm8U022578;
	Fri, 15 Dec 2023 12:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Zem9zj92wvAtdEA8Fe7XFOaOhnvk2FMTdxZ40u2vP6E=; b=kw
	sZ2WCXvxb0OwWIfAnMVfsBIQieYVruY+aVBoVPYq3oJx9ActuEazE1r+RSSZz0wS
	54/n8hprq03E5GRFRVHLn4yQuK+TzO3rjI3rGRFoajo/pphnH9TygThVInqtuh1h
	nnOe84/XQr4rGrCDPJ2qEl4Etzz8TdpFkpakuBdtmmzwCfd8NZLOqyOu4BJsrqO5
	U3UMEsJJxpiBrINxSwyoPyNizRB4q7omoQG1SUIkzAX5nrh+Hr6nG1k5M5AyiB2e
	8nUNlGSrouptfkKEZXvjEZtLkucVntkhGaG5AtGrkWlHtt8yPCgzBaj02qiN2YO/
	2PxKCivnBt8OxxwwFj6A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0k90rkax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 12:33:08 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFCX7EN013389
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 12:33:07 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 04:33:03 -0800
Message-ID: <a65ad12d-b990-4439-b196-903f4a5f096a@quicinc.com>
Date: Fri, 15 Dec 2023 20:33:00 +0800
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
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <60b9081c-76fa-4122-b7ae-5c3dcf7229f9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4Uz7d0EgknsiF0Y5kIan2k8PGtrPqcmd
X-Proofpoint-GUID: 4Uz7d0EgknsiF0Y5kIan2k8PGtrPqcmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=990 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150084



On 12/15/2023 8:12 PM, Andrew Lunn wrote:
>> +  clocks:
>> +    items:
>> +      - description: APB bridge clock
>> +      - description: AHB clock
>> +      - description: Security control clock
>> +      - description: TLMM clock
>> +      - description: TLMM AHB clock
>> +      - description: CNOC AHB clock
>> +      - description: MDIO AHB clock
>> +      - description: MDIO master AHB clock
>> +      - description: PCS0 system clock
>> +      - description: PCS1 system clock
>> +      - description: EPHY0 system clock
>> +      - description: EPHY1 system clock
>> +      - description: EPHY2 system clock
>> +      - description: EPHY3 system clock
> 
> What exactly are you describing here? A PHY, or a PHY package?
> 
> The ethernet-phy.yaml describes a PHY. So does each of your 4 PHYs
> have 14 clocks? The PHY package as a whole has 14*4 clocks?
> 
> This seems unlikely. You have some clocks used by the package as a
> whole, and you have some clocks used by one specific PHY within the
> package. So you need a hierarchical description of the hardware in DT,
> to match the actual hierarchical of the hardware.
> 
> This is exactly what Christian has been working on, and you have
> persistently ignored what he is doing. You need to work with him.
> Nothing is going to be merged until you and Christian have one
> consistent design for the two PHYs you are working on.
> 
> 
>      Andrew
> 
> ---
> pw-bot: cr

Hi Andrew,
These clocks are for the whole PHY package including quad PHYs, since
these clocks & resets need to be initialized at one point, i put it
the previous MDIO driver code, these clocks & resets are configured
after GPIO hardware reset, after these clocks and resets sequences
configured, each PHY capabilities can be acquired correctly in the PHY
probe function.

Sorry for missing Christian's patches, i will look his patches and
update qca8084 PHY driver correspondingly.


