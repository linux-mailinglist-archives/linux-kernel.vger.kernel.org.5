Return-Path: <linux-kernel+bounces-937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13128814844
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23C6281100
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396A22C6AA;
	Fri, 15 Dec 2023 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VvkRb+4Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E3E2574B;
	Fri, 15 Dec 2023 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFBWoLl021140;
	Fri, 15 Dec 2023 12:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=B61GhZHnhYwWb3C8z/OV06tvezyEbwYLqKpoXeDZ8aU=; b=Vv
	kRb+4Y961NdXByE/RcephGFIXmgX96yZIk9ztafCYz7oYCT59jIdAnhjH5gt74UQ
	GMARy4b2ciwbyGig3YR8gyCII3YqqJjTuiflF8hPV77So3xdnAMg1yVSVzSGWOA3
	u1btTcdTs1zmVcLweHvITCeqUzVRNsbjVwCbGEMlwmJYUeza4hiTtRbloiwflj15
	l1RVMHrmq32EQRQNWRDAP4ntLc9Yjz28/xYQvnIElEIM6tIX1DNXphyZIEtm75L4
	ctZs2NeJlVQM05vqGqerJtF6tPVeE7fG/7WxXvYSE+yn/fiL5D9WXbKk/nQhQjsr
	al5QniDsCv2v49w0pwRw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0p1003sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 12:40:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFCeS6e023276
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 12:40:29 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 04:40:23 -0800
Message-ID: <f656d1c7-ea86-405a-9165-9eb079ea6f2a@quicinc.com>
Date: Fri, 15 Dec 2023 20:40:20 +0800
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley
	<conor@kernel.org>
CC: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
 <20231212115151.20016-6-quic_luoj@quicinc.com>
 <20231212-caution-improvise-ed3cc6a1d305@spud>
 <11ffc985-3f2b-46b9-ae0b-911f7abe98d1@quicinc.com>
 <20231214-outshine-shush-8a11c68607cd@spud>
 <c5123ce7-6fdc-43c7-ac07-251c39196e66@quicinc.com>
 <a1e5ffec-a20d-4389-83f9-ee09bd9d733d@linaro.org>
 <a84a36af-69f8-46af-967e-b06d028597a3@quicinc.com>
 <26c8b0b1-5ea9-45cc-adf3-0d0b03a1284d@linaro.org>
 <4b9c56b8-3b29-4861-a3d5-2da26fbc14b4@quicinc.com>
 <2e77e3b1-00b6-46b9-bfed-7cae3ffa15e9@linaro.org>
 <7bae46fd-63fd-4b86-9a56-73052cf0ea95@quicinc.com>
 <5a8095e6-b6a6-4d11-b006-31519e8d8622@linaro.org>
 <7466b655-2b7e-44f2-a510-6e0cc1b95248@quicinc.com>
 <602759ce-c93d-4111-9272-1dce7e4a170a@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <602759ce-c93d-4111-9272-1dce7e4a170a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pJglisA-8S8KnxCJTj_EzLPIVPxPRnDQ
X-Proofpoint-ORIG-GUID: pJglisA-8S8KnxCJTj_EzLPIVPxPRnDQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=845 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150084



On 12/15/2023 8:19 PM, Krzysztof Kozlowski wrote:
> On 15/12/2023 12:42, Jie Luo wrote:
>>>>>>>>> Which clocks are these mentioned in the property? From where do they come?
>>>>>>>>>
>>>>>>>>> Anyway, property is in existing form is not correct - this is not a
>>>>>>>>> generic property.
>>>>>>>>>
>>>>>>>>
>>>>>>>> This property cmn-reference-clock is just the hardware register
>>>>>>>> configuration, since the different IPQ platform needs to select
>>>>>>>> the different reference clock source for the CMN PLL block that
>>>>>>>> provides the various clock outputs to the all kinds of Ethernet
>>>>>>>> devices, which is not from GCC provider.
>>>>>>>
>>>>>>> AGAIN: where do the clocks come from? Which device generates them?
>>>>>>
>>>>>> Oh, OK, the reference clock is from wifi that provides 48MHZ to
>>>>>> Ethernet block.
>>>>>
>>>>> Then WiFi should be providing you the clock and this device should be
>>>>> clock consumer, right?
>>>>
>>>> Yes, wifi provides 48MHz clock to CMM PLL block, there is no GCC
>>>> for this 48MHZ clock output, it is the hardware PIN connection.
>>>
>>> All clocks are some hardware pin connections.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Yes, all reference clocks here are from hardware pin connection.
> 
> You keep answering with short sentences without touching the root of the
> problem. I don't know exactly why, but I feel this discussion leads
> nowhere. After long discussion you finally admitted that clocks came
> from another device - Wifi. It took us like 6 emails?
> 
> So last statement: if you have clock provider and clock consumer, you
> must represent it in the bindings or provide rationale why it should not
> or must not be represented in the bindings. So far I do not see any of
> such arguments.
> 
> If you use arguments like:
> "My driver....": sorry, bindings are not about drivers
> "I don't have clock driver for WiFi": sorry, it does not matter if you
> can write one, right?
> 
> Please reach internally your colleagues to solve these problems and make
> review process smoother.
> 
> Best regards,
> Krzysztof
> 
> 

These reference clocks source do not need the hardware configuration,
that is the reason why the clock provider is not needed, some reference
clock source are even from external crystal.

There is also no enable control for the reference clocks since it is
inputted by the hardware PIN connection, i will update these description
in the DT to make it more clear.

