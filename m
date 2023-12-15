Return-Path: <linux-kernel+bounces-908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D548147DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BDC2857A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8ED2D797;
	Fri, 15 Dec 2023 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Gvf7xjmi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643C82D791;
	Fri, 15 Dec 2023 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFBCEd3006980;
	Fri, 15 Dec 2023 12:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SjAc9xSwFEvgxE2XF2soQP8TSLGd94LVavcRIIRlmP4=; b=Gv
	f7xjmi5EJtNjwvC4i/E3TvF8ZruBPA9bZr1DWd4Bw2TNpVP7j91Hzj2BnaT2IIkU
	v4RBcgufIs4Z4lhgFmsTFozJsMZkt1dEBlvGAUpWkYc/nAVOo6yyiZWxNkotgte1
	RgKIVaq1NYlUrZHX2Bv4KHJTgKXDDM8orIc41CqucffWT/zmL+ligmsMqAxcXj/S
	epTyFjUUGUP/bQouEvZC0U5eGdmtYdDglrFbvhEVuFwsWugjD+s516QOj4BniSSw
	ndBjUY0XnNHuTFC8W58fxDa98ltWF0vYRKoaYVq3aWVFKUjivihiDQkTYAzmbJeC
	DtYdfNTFxwM8T9npy86A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v05jqj821-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 12:17:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFCH2mF027677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 12:17:02 GMT
Received: from [10.253.13.71] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 04:16:58 -0800
Message-ID: <ed0dd288-be8a-4161-a19f-2d4d2d17b3ec@quicinc.com>
Date: Fri, 15 Dec 2023 20:16:53 +0800
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
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
 <20231215074005.26976-15-quic_luoj@quicinc.com>
 <bdfba8a7-9197-4aae-a7f9-6075a375f60b@linaro.org>
 <c3391e33-e770-4c61-855e-d90e82b95f75@quicinc.com>
 <4cb2bd57-f3d3-49f9-9c02-a922fd270572@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <4cb2bd57-f3d3-49f9-9c02-a922fd270572@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rgb4cnH8aUEOEI7Fs_2SOUQ8LW9gJqBD
X-Proofpoint-GUID: rgb4cnH8aUEOEI7Fs_2SOUQ8LW9gJqBD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=958 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150082



On 12/15/2023 7:25 PM, Andrew Lunn wrote:
>> The "maxItems: 1" of the property resets is defined in ethernet-phy.yaml
>> that is referenced by qca,ar803x.yaml, but i have 11 reset instances
>> used for qca8084 PHY
> 
> 11!?!?? Really? Why?
> 
> I assume the order and timer matters, otherwise why would you need
> 11? So the PHY driver needs to handle this, not phylib framework. So
> you will be adding vendor properties to describe all 11 of them. So
> ethernet-phy.yaml does not matter.
> 
> 	Andrew

Since these resets need to be configured in the special sequence, and
these clocks need to be configured with different clock rate.

But the clock instance get, the property name is fixed to "clock-names"
according to the function of_parse_clkspec, and the reset property name
is also fixed to "reset-names" from function __of_reset_control_get.

