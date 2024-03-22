Return-Path: <linux-kernel+bounces-111287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB95886A28
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04222857ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDCB38DF7;
	Fri, 22 Mar 2024 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B/GDueIx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADDC3D3B3;
	Fri, 22 Mar 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102958; cv=none; b=acV3D/u0lUsS35ywhcOBBLLh65nNe8G9WHiVICH7zK3dsV0CBhSr7mB5/dB1wG8RpV4lz6chmSoCzqvCe4Qw5xfLJWuV2U36ykwUnOBjdnuX1dmUn9Ro2AjHriUWUNUHUXQ9mcckHF0jcZPxHeFO16KD0pfgdi4bRPI84aTsCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102958; c=relaxed/simple;
	bh=jQ1A3iunoJqVPVAohgMpGzli1IusWCUHRlBP+T0f0OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oQRgVXBJB8+sfD+MqdpQ5uX4y8n6DdR6eb62hOjkZXfeuteRh8qPmrsrz+fonHuruVCYlwsV/KzRAPPxuh6E1nInX2FbIbxXi+CgZ4iXPIQOpIMEEJEyPfvh9HK9zYAGrqUIElqRZUMyRx3cBysJ6CUaG3N3wapoiUHBYdGDiYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B/GDueIx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42MAFdnN029095;
	Fri, 22 Mar 2024 10:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DGPQHj7+v6fyAAfdAuyrN1/4eFBJEz3zzoRR86rxgrI=; b=B/
	GDueIxJpEvZRyx4GLaU5O2cZxcykoixX8Qtuih+Ekdjm2aS5je5P7LrtFHdvcNi5
	98YzC7iBC36IXbtzeuBCIG7iw4F+GLCHSZrxDQkp6mdSEx/8ub3sElhIK+HBX3WS
	0MsOSLzoe1WM3O/1+RhfMj2lFQgXVpBiaDZVprG4mN0ueo5laEME6WhV4SUf5Tjl
	AOrNmvQyLKh9bL+doM2qoxS5sA9saT7b3AtjRLOoRXmOjnGnFPOCb2YJgd/OZB9+
	5mKe2z1eZDRswrypwRqhXSyFRmjQPVdT8nWUYVcXor6P12vftuB8HU1de7M+4zsf
	V5IuezQ7HegyvO3v2nTQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0wy91h9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 10:22:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42MAMIpa015998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 10:22:18 GMT
Received: from [10.233.17.145] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 22 Mar
 2024 03:22:12 -0700
Message-ID: <55829f0f-6f5a-4898-b3d6-33850e790d62@quicinc.com>
Date: Fri, 22 Mar 2024 18:22:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom,coresight-funnel: Add label
 for multi-ouput
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Rob Herring <robh@kernel.org>,
        Tao Zhang <quic_taozha@quicinc.com>
CC: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
References: <1711009927-17873-1-git-send-email-quic_taozha@quicinc.com>
 <1711009927-17873-2-git-send-email-quic_taozha@quicinc.com>
 <20240321144226.GA1689544-robh@kernel.org>
 <443edf61-2a28-4ae7-ac88-2da2d29cebe3@quicinc.com>
 <77fd8549-5e69-42a8-9e35-5d3de56a490f@arm.com>
From: Tingwei Zhang <quic_tingweiz@quicinc.com>
In-Reply-To: <77fd8549-5e69-42a8-9e35-5d3de56a490f@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IgLOd7gJWFknAndjGbnbJqNatcG6T4rm
X-Proofpoint-ORIG-GUID: IgLOd7gJWFknAndjGbnbJqNatcG6T4rm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403220073

On 3/22/2024 5:42 PM, Suzuki K Poulose wrote:
> On 22/03/2024 07:02, Tingwei Zhang wrote:
>> On 3/21/2024 10:42 PM, Rob Herring wrote:
>>> On Thu, Mar 21, 2024 at 04:32:04PM +0800, Tao Zhang wrote:
>>>> Add new property "label" to label the source corresponding to the
>>>> output connection. When the funnel supports multi-output, this
>>>> property needs to be introduced to mark which source component a
>>>> certain output connection corresponds to.
>>>>
>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>> ---
>>>>   .../arm/arm,coresight-dynamic-funnel.yaml     | 34 
>>>> ++++++++++++++++---
>>>>   1 file changed, 30 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
>>>> index 44a1041cb0fc..cde62c286d29 100644
>>>> --- 
>>>> a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
>>>> +++ 
>>>> b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
>>>> @@ -66,13 +66,39 @@ properties:
>>>>           $ref: /schemas/graph.yaml#/properties/port
>>>>     out-ports:
>>>> -    $ref: /schemas/graph.yaml#/properties/ports
>>>> -    additionalProperties: false
>>>> -
>>>> +    type: object
>>>>       properties:
>>>> +      "#address-cells":
>>>> +        const: 1
>>>> +
>>>> +      "#size-cells":
>>>> +        const: 0
>>>> +
>>>>         port:
>>>> +        type: object
>>>> +
>>>> +    patternProperties:
>>>> +      '^port(@[0-7])?$':
>>>> +        type: object
>>>>           description: Output connection to CoreSight Trace bus
>>>> -        $ref: /schemas/graph.yaml#/properties/port
>>>
>>> Nope, now you have no constraints on port node properties. Please look
>>> at how other bindings are done to add properties on endpoint node.
>>>
>> Thanks for pointing this out, Rob. Shall we ref port-base and
>> endpoint-base then add new properties on endpoint? In this way, the 
>> redundant code from port schema is not required.
>>>> +
>>>> +        patternProperties:
>>>> +          "^endpoint(@[0-9a-f]+)?$":
>>>> +            type: object
>>>> +            properties:
>>>> +              remote-endpoint:
>>>> +                description: |
>>>> +                  phandle to an 'endpoint' subnode of a remote 
>>>> device node.
>>>> +                  $ref: /schemas/types.yaml#/definitions/phandle
>>>
>>> Don't need this.
>>>
>>>> +              label:
>>>> +                description: Label the source corresponding to the 
>>>> output connection
>>>> +                $ref: /schemas/types.yaml#/definitions/string
>>>
>>> label already has a type.
>>>
>>> As this node is an output, aren't you labeling what the destination is,
>>> not the "source"?
>>>
>>> Why can't you look at the remote connection to identify what it is?
>>>
>> This funnel can route data stream from different trace source to 
>> different output ports. This lable property is added to describe which 
>> source is routed to this output port.
>>
>> For example, the graph is as below. Funnel3 routes trace data from 
>> TPDM0 to output[0] and output[0] of funnel3 is connected to input[0] 
>> of TPDA0.
> 
> Funnel3 and Funnel4 are really Replicators ! How are they Funnels ? 
> Again, my question still stands. Are Funnel(Replicator-renamed)3/4 and 
> Funnel 0/1/2 programmable ?

Sorry for oversimplied the topology. Funnel3 and Funnel4 have multiple 
input ports instead of just one input port. It can have multiple input 
ports and multiple output ports. Unlike replicator, it won't replicate 
same data trace to all the outputs.

Funnel3/funnel4 has same programing capability like standard coresight 
funnel. It can enable input ports as requested. It can not be programed 
to route which source to which output ports. Hardware staticlly defined 
which source is routed to which output.

> 
> Suzuki
> 
> 
>> While Funnels routes trace data from TPDM1 to output[1] which connects 
>> to input[1] of TPDA0. Hope that clarifies this a little bit.
>>
>> |---------|    |---------|    |---------|    |---------|    |---------|
>> |  TPDM0  |    |  TPDM1  |    |  TPDM2  |    |  TPDM3  |    |  TPDM4  |
>> |---------|    |---------|    |---------|    |---------|    |---------|
>>      |               |             |               |              |
>>      |               |             |               |              |
>>      |               |             |               |              |
>>      |-----|   |-----|             |-----|   |-----|              |
>>            |   |                         |   |                    |
>>            |   |                         |   |                    |
>>         [0]|   |[1]                   [0]|   |[1]                 |
>>       \-------------/               \-------------/        \------------/
>>        \  FUNNEL0  /                 \  FUNNEL1  /          \  FUNNEL2  /
>>         -----------                   -----------            -----------
>>              |                             |                      |
>>       \-------------/               \-------------/               |
>>        \  FUNNEL3  /                 \  FUNNEL4  /                |
>>         -----------                   -----------                 |
>>            |  |                         |   |
>>         [0]|  |[1]                   [0]|   |[1]                  |
>>            |  |----------               |   |                     |
>>            |            |               |   |                     |
>>            |-------|    |      |------- |   |          |--------- |
>>                    |    |      |            |          |
>>                    |    |      |            |          |
>>                 [0]|    |[1]   |[2]         |[3]       |[4]
>>             \ ---------------------------------------------------/
>>              \                     TPDA0                        /
>>               \                                                /
>>                ------------------------------------------------
>>
>>>
>>>> +    oneOf:
>>>> +      - required:
>>>> +          - port
>>>> +      - required:
>>>> +          - "#address-cells"
>>>> +          - "#size-cells"
>>>
>>> The common schema that you removed handles this.
>>>
>>> Rob
>>
> 

-- 
Thanks,
Tingwei


