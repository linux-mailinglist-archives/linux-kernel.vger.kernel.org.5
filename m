Return-Path: <linux-kernel+bounces-6715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CE5819C81
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE7AFB2644F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712BD208CC;
	Wed, 20 Dec 2023 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hoa4Rx2p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747FA208A2;
	Wed, 20 Dec 2023 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK8luVw028280;
	Wed, 20 Dec 2023 10:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+ISZfyjJ8xoWX7MpOHN6GSDh8GtMiiJz24SeTeDi1kA=; b=ho
	a4Rx2pKcMyDMLauHx7zsoaPmr00+JjeovS1lj6JU4Ll2+p4OrYsv31VBfjiktqQi
	yB4zzlBQLUSJdIxblxjizyj3tJKMVy2gmk1eqguSZldTcA4/NrlD2AO4dChAx3+F
	S5+YrYcOz3uUQEJUg9kjyhriX47hzij1oeW1HW6WqExRtpBhQB0mc8pX2D2TiwFF
	+HjaPGXGiUmtA0DhSifBVnM9Pcsz1LWV8YHbCJ1gZknXjldgqhFblHG/q14/Au0Y
	d12MfyOi7MBQROPaO1lFm/HzpwCaOaa+sKA+MIp87Hs1Bg2ITeqhA2rbM5KkfLAG
	AGv1wgYTztpBUNeRvO9w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3tmm0j63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 10:11:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKABgYP020814
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 10:11:42 GMT
Received: from [10.253.32.162] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 02:11:37 -0800
Message-ID: <a4f566c2-17bd-480b-be72-fef808f0be43@quicinc.com>
Date: Wed, 20 Dec 2023 18:11:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
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
References: <26c8b0b1-5ea9-45cc-adf3-0d0b03a1284d@linaro.org>
 <4b9c56b8-3b29-4861-a3d5-2da26fbc14b4@quicinc.com>
 <2e77e3b1-00b6-46b9-bfed-7cae3ffa15e9@linaro.org>
 <7bae46fd-63fd-4b86-9a56-73052cf0ea95@quicinc.com>
 <5a8095e6-b6a6-4d11-b006-31519e8d8622@linaro.org>
 <7466b655-2b7e-44f2-a510-6e0cc1b95248@quicinc.com>
 <602759ce-c93d-4111-9272-1dce7e4a170a@linaro.org>
 <f656d1c7-ea86-405a-9165-9eb079ea6f2a@quicinc.com>
 <20231215-gauze-sprinkled-172729f22b6c@spud>
 <9eab958e-d91f-4f3c-aadd-6b34eaed2cef@quicinc.com>
 <20231216-unearned-lucid-4bd2ddcd4ac2@spud>
 <af1dff98-a63e-47b3-a709-6f4110a97529@quicinc.com>
 <4ad99501-01e2-47e7-b185-f7f96d872bf7@linaro.org>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <4ad99501-01e2-47e7-b185-f7f96d872bf7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ggKUiSiqCP1KhU6T7wNkwBeU2REdVsUA
X-Proofpoint-ORIG-GUID: ggKUiSiqCP1KhU6T7wNkwBeU2REdVsUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312200071



On 12/20/2023 3:28 PM, Krzysztof Kozlowski wrote:
> On 16/12/2023 16:37, Jie Luo wrote:
>>>
>>> I'm surprised you didn't pick up on this, but there are actually _2_
>>> internal references, which I have just noticed while double checking the
>>> binding patch.
>>
>> i noticed this, the reference clock source can be supported by clocks as
>> you suggested here, it is really helpful.
>>>
>>> What is the impact of using the 48 MHz or 96 MHz internal reference?
>> They works on the different IPQ platform, 96MHZ internal reference is
>> used on IPQ5018, the internal 48MHZ is used on the IPQ5332, that is
> 
> So the binding is just incorrect. Why do you even consider configuring
> 96 MHz internal reference on IPQ5332?
> 
> 
> Best regards,
> Krzysztof
> 

Normally there is the fix reference clock source used per each IPQ
platform, but we should keep it configurable, the CMN PLL block is
same among the supported IPQ platforms, Maybe there is special case
to switch the reference clock in the future.
i will also update the dtbinding doc to limit the reference clock based
on the compatible string.

