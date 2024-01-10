Return-Path: <linux-kernel+bounces-21649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B79829258
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B469281EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF3A1C2D;
	Wed, 10 Jan 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nRebz5nQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2669610F4;
	Wed, 10 Jan 2024 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A0MEZ9012118;
	Wed, 10 Jan 2024 02:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=krkaV+/3T5HCfsTM719GgUw4uSOlXRKe/hrTtbLRB+c=; b=nR
	ebz5nQJXjTCvRWTm3mb4u5A6tyWFheXl5HQtKad7ARtEZ1bhGqhiwLxDC5itvt7t
	/DjsKswjh/4D2e4+Vx8M6v3eGWoGU1U93sjSBI/TVoysZSguwD2OjUYXT6ObZAK5
	I6KPG7ORFGcQ30ay/7JAilRZntSEX1oF+xaKR/jK5ZAxI0U1I/tIDQ3l6hDbuPFk
	LiMMX/RpcFTCq7RpbAJETjD8a+g5c4Cqq20k0S4jBqNlXXsfYQgrbVQQeg9b/uNb
	psbndEQXUPfLOd4xY0AKorhVrzfO3h1A79U+7JiZ8tMidhF7oP5oc/7BH+BmvDre
	v/2D4raZtue4wM0p9/eA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh85t1bts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 02:10:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A2A7jn008701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 02:10:07 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 18:10:04 -0800
Message-ID: <9e13c2f5-b8e2-410c-9bf4-1ed4a4735dbb@quicinc.com>
Date: Wed, 10 Jan 2024 10:10:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mtd: Change the schema for nodename which
 includes "sram"
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Bjorn Andersson <quic_bjorande@quicinc.com>
CC: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tingweiz@quicinc.com>
References: <1704367382-29979-1-git-send-email-quic_zhenhuah@quicinc.com>
 <20240109184323.GA24189@hu-bjorande-lv.qualcomm.com>
 <20240109212202.GA3236341-robh@kernel.org>
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <20240109212202.GA3236341-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U54xXklOXClsEtD6dvfhWKaVf9VA9pjB
X-Proofpoint-GUID: U54xXklOXClsEtD6dvfhWKaVf9VA9pjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100016



On 2024/1/10 5:22, Rob Herring wrote:
> On Tue, Jan 09, 2024 at 10:43:23AM -0800, Bjorn Andersson wrote:
>> On Thu, Jan 04, 2024 at 07:23:02PM +0800, Zhenhua Huang wrote:
>>> Node name which includes "sram" not only represents MTD devices, but also
>>> lots of sram devices(eg, qcom,imem.yaml, rules in folder sram/*).
>>>
>>> To avoid the conflicts, change the schema as:
>>>   - if node name includes "sram", must select "compatible" to match
>>> (I have listed all "comptible" string in mtd.yaml by searching
>>> drivers/mtd/* to find applicable drivers)
>>>   - if node name is nand/flash, use "nodename" to select.
>>>
>>
>> You're right, it doesn't seem appropriate for the mtd binding to be
>> selected for nodes intended to match e.g. the qcom,imem binding.
>>
>>> Fixes: 7bdc671822e9 ("dt-bindings: mtd: physmap: Reuse the generic definitions")
>>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>>> ---
>>> Hello,
>>>
>>> Tested a few devicetree nodes, which confirms:
>>> "qcom,imem.yaml" which in sram/ not matches with mtd.yaml anymore.
>>> All nodes include string "sram" must have "compatible" which listed in
>>> mtd.yaml to be matched.
>>>
>>> Current I just modify the rule for "sram" as it is definitely conflicting with
>>> rules in sram/*. I have not much backgrounds on nand/flash whether they may have
>>> similar conflicts.
>>>
>>>   Documentation/devicetree/bindings/mtd/mtd.yaml | 24 +++++++++++++++++++++---
>>>   1 file changed, 21 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
>>> index f322290..1704437 100644
>>> --- a/Documentation/devicetree/bindings/mtd/mtd.yaml
>>> +++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
>>> @@ -10,10 +10,28 @@ maintainers:
>>>     - Miquel Raynal <miquel.raynal@bootlin.com>
>>>     - Richard Weinberger <richard@nod.at>
>>>   
>>> -properties:
>>> -  $nodename:
>>
>> The mtd binding is $ref'ed by other bindings, similar to how we do with
>> other bindings of common properties.
>>
>> So, I think the problem with mtd is that this ($nodename) turns into a
>> "select" automatically, which causes this binding to match nodes by
>> name, rather than just those $ref'ing it.
>>
>>
>> We should be able to avoid the automatically created select from the
>> $nodename, and rely on $ref, by just adding:
>>
>> select: false
> 
> Yes.
> 
> Rob

Thanks Bjorn and Rob for your suggestion. Let me try and update one new 
version.

Thanks,
Zhenhua

