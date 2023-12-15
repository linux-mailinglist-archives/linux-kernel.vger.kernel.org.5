Return-Path: <linux-kernel+bounces-960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA24A814896
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254F41F23BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF67C2D056;
	Fri, 15 Dec 2023 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kOv2hrgI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A807F2C688;
	Fri, 15 Dec 2023 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF7rS5o028527;
	Fri, 15 Dec 2023 12:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=a25RL4rBWi5rVQZx4+IX5SPuXPWTBxME9+jb/uBmDfc=; b=kO
	v2hrgIV9oDcnoPRj/gXdAG8IqX6WYPV4395tueZZ5W2XYXHxsMp1epBhi4/VILdc
	K3+F6LdiMMBaaopHeYbjjV1xn6V89gCcscDw9UIGCWW31Tg3HaVnuPXI9vWmcmWC
	zrae3m/49PMsci7rKviyA1Dve8VgLOp0N/wgz26Mm5ZPGva35hc4iT1WhECqVYvm
	R9iyVlrl55gIVD8x/il6GdaGVm+Q9GD1pTW9YtB67dJmEp8S5S2Ug/b4qxcH8QOM
	ITVmaooc7QI7Q6CK7hBtpM9y7Su+UQvnxDMqmuKn9sdAof7l7MAt7scsq6fQzyq4
	fh3Dku+WCyN0a4kL6oIg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0jt68rce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 12:55:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFCtlVt008724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 12:55:47 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 04:55:41 -0800
Message-ID: <6e5b6ab5-fc89-4986-894a-62af08343859@quicinc.com>
Date: Fri, 15 Dec 2023 20:55:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>
CC: <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231214090304.16884-1-quic_luoj@quicinc.com>
 <20231214090304.16884-6-quic_luoj@quicinc.com>
 <1e4c55c8-8ed6-4f2e-8328-8a173f09b62f@linaro.org>
 <3c8e33b4-6ebc-476f-a00f-15cc8a1ad9e4@quicinc.com>
 <b89abf8c-57f8-46a6-a071-b1591340fbdf@linaro.org>
 <3de98516-9a28-4f58-8951-2a7752621fee@quicinc.com>
 <1fa2d219-63d7-45cf-9e05-b85dbce24076@linaro.org>
 <f16dfe78-2e31-45fb-b2fe-f72b7e6c51a5@quicinc.com>
 <6acecb29-2a6c-40af-a5a3-bec3e7286df7@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <6acecb29-2a6c-40af-a5a3-bec3e7286df7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8MST0g6K1xkFPm_ln_-3VeMeMJSQUSEQ
X-Proofpoint-ORIG-GUID: 8MST0g6K1xkFPm_ln_-3VeMeMJSQUSEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=758
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150086



On 12/15/2023 8:14 PM, Krzysztof Kozlowski wrote:
> On 15/12/2023 13:03, Jie Luo wrote:
>>>> If i do not declare the property "reset-assert-us" and
>>>> "reset-deassert-us", the warning will be reported by "make
>>>> dt_binding_check" since i
>>>> add a example in this file.
>>>
>>> This argument does not make sense, sorry. Obviously if property is not
>>> allowed, it should be removed.
>>>
>>> Provide rationale, in terms of hardware, why this property must be added
>>> and why it cannot be deduced from the compatible.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> So i can remove "reset-assert-us" and "reset-deassert-us" from the added
>> example to avoid the dt check warning? even these two properties are
>> needed to be defined in the device tree to make this driver working
>> correctly.
> 
> Sorry, that does not answer my question at all. First, "Driver" is not
> hardware. My second question was simply ignored. In the v2 thread you as
> well respond with some short, unrelated sentences not answering to the
> real questions. It's a waste of my time. Please reach internally in
> Qualcomm for guidance how to upstream patches and how to write bindings.
> 
> Best regards,
> Krzysztof
> 

These properties "reset-assert-us" and "reset-deassert-us" are the
general properties from mdio.yaml, which are used when the MDIO
bus driver is registered by the MDIO framework.
The general DT property already supports to do the correct config,
then compatible string is not needed to be checked for doing the
configs.

i will check the binding examples to avoid this kind of problems.


