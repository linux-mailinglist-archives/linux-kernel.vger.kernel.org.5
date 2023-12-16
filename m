Return-Path: <linux-kernel+bounces-2201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F85481594A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EA01F23B89
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384212C86C;
	Sat, 16 Dec 2023 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B4N2zR7X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3E02E654;
	Sat, 16 Dec 2023 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BGDTw7N030909;
	Sat, 16 Dec 2023 13:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eu/oWRlUKGD7Ko78kFik9fjmYv3n+qJR55gbQO8Y4Tc=; b=B4
	N2zR7XJFtXHcvBwg3tp9dTlxFC3WVZTb7/1gwoobARmbqE8zk6TAGcZGDOIqt6aA
	NG34Uo/6rDxhQV+37LK1WizolZ12psBoUY7kwb/bS6Fq6DxpsEOSZL/nfYC/foRq
	iBdXortLiFOXP4MnnbdPp5Mxn01QCZI6i7YNe4gCsMqnklcfI1HfjK/+kSn6vrf/
	KhAxxIVwuGKkKrsTpBF+Dvjn2iU3CE0DG4bZWR6+OMQF5finxmIN1twd2ieC8pZm
	3MhE/2Bk0qhRJQo+wF3vu46YEK+W197tZxHsf4MUNwMzfLKewMLe4J4ZzT4vwPpc
	WVBTc7s7KXT89zBShsiQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14vj8mk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 13:31:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BGDVCEc024172
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 13:31:12 GMT
Received: from [10.253.9.247] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 16 Dec
 2023 05:31:07 -0800
Message-ID: <d24c6c64-0271-45c6-922e-3108f034fe58@quicinc.com>
Date: Sat, 16 Dec 2023 21:31:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley
	<conor@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <a1e5ffec-a20d-4389-83f9-ee09bd9d733d@linaro.org>
 <a84a36af-69f8-46af-967e-b06d028597a3@quicinc.com>
 <26c8b0b1-5ea9-45cc-adf3-0d0b03a1284d@linaro.org>
 <4b9c56b8-3b29-4861-a3d5-2da26fbc14b4@quicinc.com>
 <2e77e3b1-00b6-46b9-bfed-7cae3ffa15e9@linaro.org>
 <7bae46fd-63fd-4b86-9a56-73052cf0ea95@quicinc.com>
 <5a8095e6-b6a6-4d11-b006-31519e8d8622@linaro.org>
 <7466b655-2b7e-44f2-a510-6e0cc1b95248@quicinc.com>
 <602759ce-c93d-4111-9272-1dce7e4a170a@linaro.org>
 <f656d1c7-ea86-405a-9165-9eb079ea6f2a@quicinc.com>
 <3d89a725-ce81-4d13-b5e3-75198c408f78@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <3d89a725-ce81-4d13-b5e3-75198c408f78@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tMIBXr1Cyfb7n0yo4czZdvah8N5G_eP9
X-Proofpoint-GUID: tMIBXr1Cyfb7n0yo4czZdvah8N5G_eP9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=423 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160104



On 12/15/2023 9:39 PM, Andrew Lunn wrote:
>>> You keep answering with short sentences without touching the root of the
>>> problem. I don't know exactly why, but I feel this discussion leads
>>> nowhere. After long discussion you finally admitted that clocks came
>>> from another device - Wifi. It took us like 6 emails?
>>>
>>> So last statement: if you have clock provider and clock consumer, you
>>> must represent it in the bindings or provide rationale why it should not
>>> or must not be represented in the bindings. So far I do not see any of
>>> such arguments.
>>>
>>> If you use arguments like:
>>> "My driver....": sorry, bindings are not about drivers
>>> "I don't have clock driver for WiFi": sorry, it does not matter if you
>>> can write one, right?
>>>
>>> Please reach internally your colleagues to solve these problems and make
>>> review process smoother.
> 
> Yes, i strongly agree with this. Its not our job as maintainers to
> educate big companies like Qualcomm how to write Linux drivers. There
> are more experienced driver writer within Qualcomm, you need to make
> contact with them, and get them to help you. Or you need to outsource
> the driver development to one of the companies which write mainline
> Linux drivers.
> 
> 	Andrew

Understand this, sorry for some easy mistakes happens here.
i will sync with internal team before pushing the next patch set.

Thanks a lot.

