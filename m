Return-Path: <linux-kernel+bounces-109205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC13D881626
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9AB1C21F60
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0674B6A029;
	Wed, 20 Mar 2024 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hxcmjFpS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B031769DEF;
	Wed, 20 Mar 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954532; cv=none; b=QC8y7HIPeCXFHEnKvxmqRG7hkKt3Lg2rHj2PgN+nvHHVDOGOEkc+RId06SblzSaod+1luLbHBfJQDkEYBjs8XCPd6RWIufbuAPA0pDm6DothoyNG1BXVuO7MCKc9drwICL+4Ej1quG6XxFeqUClmpwhLAsQ1GWwc/PZZc1MkffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954532; c=relaxed/simple;
	bh=8kJjEg5oZzMxRIneLopSxQOQPEokcxyAnvhzEeygCH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XXm/gpvlIXuMEa/BlUNRhlJ/1RqaqnXYTfJLpcLduKlttoXiQAudAbtXRZbCk7jQ3D51hwzcQ5B+YEk7BJqYvUStxkXiFz6f+m8ccw1TsRztZTwoY2bbOZkcovqX34hbjPbKyZNF+zKK4qbtWCQBUahpKWpXFLg0PKbJxsCl4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hxcmjFpS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KGHFuG011885;
	Wed, 20 Mar 2024 17:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=W3c2Ki/rrQQbC0kKjrOLvX5JTBp+FdNp6TjIx/lPAT4=; b=hx
	cmjFpSmlPEIU/E+iYVNzojH7nZAZ9E3VMaBO2tJQK6km7K1BgDgXSSD7Qqs9vYbw
	8aUOqQfaZ7xXouYiTriBoHPyB0kAI9bAAhslTzJZeFaChNmDadlcDC6ChQpGPAmo
	PiRjYfKcRPdddHJhdjAe/VpXSBUrw0HIoX9lOZZBPc9ZrZgI/lV7GcaW/Xb3kRA0
	OoANaQ+cpUtqOcGID5Go1M3CHuxcEcvr94YQPmBJRKbU8MbO9gk5IRQqZBd2dIl6
	tTGpVXlmU06p6bVFCdyeZ4sChvXq8rQPjoWWgYHUii06/P8RDCMlBWLIKIYCPgbZ
	zuV0DIL3PEaeF3cAGy/g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyq60ss5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:08:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KH8cop021480
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 17:08:39 GMT
Received: from [10.50.49.240] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Mar
 2024 10:08:33 -0700
Message-ID: <69364c99-9b99-4727-812b-209bb82254a7@quicinc.com>
Date: Wed, 20 Mar 2024 22:38:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] dt-bindings: interconnect: add clock property to
 enable QOS on SC7280
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Georgi
 Djakov" <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>
References: <20240306073016.2163-1-quic_okukatla@quicinc.com>
 <20240306073016.2163-4-quic_okukatla@quicinc.com>
 <7ccb838b-f548-4ca4-9859-051689935eb7@linaro.org>
From: Odelu Kukatla <quic_okukatla@quicinc.com>
In-Reply-To: <7ccb838b-f548-4ca4-9859-051689935eb7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VPPrqXpNbPfX2C93aomTgHO54xrA78C4
X-Proofpoint-GUID: VPPrqXpNbPfX2C93aomTgHO54xrA78C4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200137



On 3/6/2024 1:56 PM, Krzysztof Kozlowski wrote:
> On 06/03/2024 08:30, Odelu Kukatla wrote:
>> Added clock property to enable clocks required for accessing
>> qos registers.
>>
>> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
>> ---
>>  .../interconnect/qcom,sc7280-rpmh.yaml        | 49 +++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
>> index b135597d9489..758a6e924037 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
>> @@ -53,10 +53,50 @@ allOf:
>>        required:
>>          - reg
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sc7280-aggre1-noc
>> +    then:
>> +      properties:
>> +        clocks:
> 
> All properties must be defined in top-level.
> 

I will address this in v4, "clocks" property could be optional.

>> +          items:
>> +            - description: aggre UFS PHY AXI clock
>> +            - description: aggre USB3 PRIM AXI clock
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sc7280-aggre2-noc
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: RPMH CC IPA clock
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sc7280-aggre1-noc
>> +              - qcom,sc7280-aggre2-noc
>> +    then:
>> +      required:
>> +        - clocks
> 
> That's an ABI break without reason. This is a stable and already used
> platform, so clear NAK.
> 
> Best regards,
> Krzysztof
> 

Thanks,
Odelu

