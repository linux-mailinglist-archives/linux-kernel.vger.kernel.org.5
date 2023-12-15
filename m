Return-Path: <linux-kernel+bounces-731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86077814548
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B258A1C22E39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7911946E;
	Fri, 15 Dec 2023 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mTIRw6YX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8124B42;
	Fri, 15 Dec 2023 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF9Mqgk032346;
	Fri, 15 Dec 2023 10:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Tun7DRNtaaSLQZm0TAzmr2NH9jDXt4w0fbSSJYXmQkY=; b=mT
	IRw6YXWH74HMQuu+Gz87bBRaA0ugHj3LKQm5JFUwFjJ5OlJZtQmzw6WnBvARAuzr
	VObYybK4bBBD9U8RyFegpnzJiX4mM1Yq4kPY0Tu8Lv8V2PfvMjm4lptFqqQYNNzG
	uu6E8PerIWq0TOYaq6MFRMUSIqoVLd1KciD+7ltjUYMoxVFTlpA1yuHHqKou0QgL
	DKBREb+mUMFmxOMlSk68bFSkxEltJbAaxic+wWl97OFSsaNqLLOEFZszVjM3p5de
	iO7tjbTRGTFIAFAtQIxtsGlj/LZn3fJQwojBDY1cVljQtUNolbr111wu6uaSbgOK
	VDFiqoDP2kdNv7uMTbwA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0m46g4gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:17:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFAGirw014118
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 10:16:44 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 02:16:40 -0800
Message-ID: <c3391e33-e770-4c61-855e-d90e82b95f75@quicinc.com>
Date: Fri, 15 Dec 2023 18:16:37 +0800
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <andrew@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <bdfba8a7-9197-4aae-a7f9-6075a375f60b@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <bdfba8a7-9197-4aae-a7f9-6075a375f60b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6BPPAA1eXPd8CZFoyaMl93amoket_0Rb
X-Proofpoint-ORIG-GUID: 6BPPAA1eXPd8CZFoyaMl93amoket_0Rb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=955 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150069



On 12/15/2023 4:22 PM, Krzysztof Kozlowski wrote:
> On 15/12/2023 08:40, Luo Jie wrote:
>> The following properties are added for qca8084 PHY.
>>
>> 1. add the compatible string "ethernet-phy-id004d.d180" since
>>     the PHY device is not accessible during MDIO bus register.
>> 2. add property "qcom,phy-addr-fixup" for customizing MDIO address.
>> 3. add property "qcom,phy-work-mode" for specifying qca8084 PHY
>>     work mode.
>> 4. add the initial clocks and resets.
> 
> All my previous comments (sent one minute before this patchset :) )
> apply. Please respond to them or implement them in v5 (not earlier than
> after 24h).
> 
> 
> Best regards,
> Krzysztof
> 

Sure, will update the new version after the discussion completed.
actually i have query about the dt-bindings doc.

The "maxItems: 1" of the property resets is defined in ethernet-phy.yaml
that is referenced by qca,ar803x.yaml, but i have 11 reset instances
used for qca8084 PHY, it seems i can't overwrite maxItems of reset
property to 11 from 1 in qca,ar803x.yaml.

is there any method to overwrite the maxItems value?

Thanks,
Jie

