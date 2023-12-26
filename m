Return-Path: <linux-kernel+bounces-11466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938A81E6C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FC01F228A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4B84D59E;
	Tue, 26 Dec 2023 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TYw9b/QA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35404D582;
	Tue, 26 Dec 2023 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BQ2lBpe007802;
	Tue, 26 Dec 2023 10:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EbK0Zbrv9EAUjwNIQmV+qBbfXKtF8OfJi0XbfDJeMOc=; b=TY
	w9b/QAnaP0n4Dyc2yQaMSyo4SQ0sTgl2NC7HAeSSCPe5+P4LkmPI9U3KhqsZHDaW
	a3rX7BKaPGVz4eSGYyj+6hfDa8jsVlwI5j3vfxHNzV1AT9i5OgotVRt/HhLFpCX8
	pd9f5OIGkSTPAd5murFQn8Qg9v57OVjVqdVdnQeo3K5l+mbOIQiyfCL+Zu/BWdIL
	BqK2la6S3+VATIS0YW/3vhaqoWpQuxFTryG3qO2+ajzUslbTBbQmBIghrcNb1c0e
	sUX+B6jecSRoOlBccs0j0CkwVJyJG1xYNA/yd+Cj0p/unm1pfBra2KauF+koEGA8
	Hfp1HENKVEaxU36jI+yw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v7c9jhp6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 10:03:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BQA3IcZ007942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 10:03:18 GMT
Received: from [10.216.59.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Dec
 2023 02:03:13 -0800
Message-ID: <67c7c84c-c631-468e-ae67-1c31d41a605b@quicinc.com>
Date: Tue, 26 Dec 2023 15:33:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 binding
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bjorn
 Andersson" <bjorn.andersson@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Johan
 Hovold" <johan@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Andy Gross <agross@kernel.org>
References: <20231222063648.11193-1-quic_kriskura@quicinc.com>
 <20231222063648.11193-2-quic_kriskura@quicinc.com>
 <e6419898-0d77-4286-a04b-7240eb90d8df@linaro.org>
 <268f9f54-8b2a-42bb-9a5d-10bd930cb282@quicinc.com>
 <55c478c7-abcc-4487-b81c-479df47d5666@linaro.org>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <55c478c7-abcc-4487-b81c-479df47d5666@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fJCHyT5XdHpAzkVGSbod1V8F0sxOoLx6
X-Proofpoint-ORIG-GUID: fJCHyT5XdHpAzkVGSbod1V8F0sxOoLx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=783 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312260074



On 12/26/2023 3:03 PM, Krzysztof Kozlowski wrote:
> On 26/12/2023 06:37, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 12/25/2023 6:35 PM, Krzysztof Kozlowski wrote:
>>> On 22/12/2023 07:36, Krishna Kurapati wrote:
>>>> The high speed related interrupts present on QC targets are as follows:
>>>>
>>>
>>>
>>>>    
>>>>      interrupt-names:
>>>> -    minItems: 1
>>>> -    maxItems: 4
>>>> +    minItems: 2
>>>> +    maxItems: 5
>>>>    
>>>>      qcom,select-utmi-as-pipe-clk:
>>>>        description:
>>>> @@ -361,60 +378,21 @@ allOf:
>>>>            compatible:
>>>>              contains:
>>>>                enum:
>>>> -              - qcom,ipq4019-dwc3
>>>
>>> Why do you remove it, without adding it somewhere else. Nothing in the
>>> commit msg explains it.
>>>
>>
>> Apologies, Will check and add it back.
> 
> Please check your patch for other entries. I just took first compatible
> which turns out to be gone. I did not check the reset and I don't want
> to keep checking.
> > ...
> 
>>>> -    then:
>>>> -      properties:
>>>> -        interrupts:
>>>> -          minItems: 1
>>>> -          maxItems: 2
>>>> -        interrupt-names:
>>>> -          minItems: 1
>>>> -          items:
>>>> -            - const: hs_phy_irq
>>>> -            - const: ss_phy_irq
>>>> -
>>>> -  - if:
>>>> -      properties:
>>>> -        compatible:
>>>> -          contains:
>>>> -            enum:
>>>> -              - qcom,sc7280-dwc3
>>>> +              - qcom,sm6115-dwc3
>>>> +              - qcom,sm6125-dwc3
>>>>        then:
>>>>          properties:
>>>>            interrupts:
>>>>              minItems: 3
>>>>              maxItems: 4
>>>>            interrupt-names:
>>>> -          minItems: 3
>>>>              items:
>>>> +            - const: pwr_event
>>>>                - const: hs_phy_irq
>>>> -            - const: dp_hs_phy_irq
>>>> -            - const: dm_hs_phy_irq
>>>> +            - const: qusb2_phy
>>>
>>> Why qusb2_phy is after hs_phy_irq? In the earlier if:then: it is the
>>> second one.
>>>
>>
>> In v3 as well, the hs_phy_irq is before qusb2_phy interrupt:
>> https://lore.kernel.org/all/20231211121124.4194-2-quic_kriskura@quicinc.com/
> 
> ? How v3 matters?
> 
>>
>>>
>>>>                - const: ss_phy_irq
>>>>    
>>>>      - if:
>>>> @@ -460,11 +422,13 @@ allOf:
>>>>            compatible:
>>>>              contains:
>>>>                enum:
>>>> +              - qcom,ipq5332-dwc3
>>>>                  - qcom,sc8280xp-dwc3
>>>>                  - qcom,x1e80100-dwc3
>>>>        then:
>>>>          properties:
>>>>            interrupts:
>>>> +          minItems: 3
>>>
>>> Hm, why? This commit is unmanageable. Your commit msg is already huge
>>> but still does not explain this. Are you sure you are fixing only one
>>> logical thing per patch? Does not look like.
>>>
>>
>> This is reordering the targets based on interrupts they have. I put it
>> in one commit because splitting this into multiple patches breaks one
>> thing or other. Also once I am defining permutations, I have to group
>> targets into these combinations in the same patch. I know this is a big
>> commit but it solves the interrupt cleanup and defines a way for future
>> targets.
> 
> 
> This does not answer why, you sc8280xp and x1e80100 not get one optional
> interrupt. I asked "why" you are doing this change. Why do you need it?
> What is the rationale?
> 
> Then I grunted about unmanageable commit, because all my troubles to
> review it are the effect of it: it is very difficult to read. It is also
> difficult for you, because you keep making here mistakes. So if you
> cannot write this commit properly and I cannot review it, then it is way
> over-complicated, don't you think? But this is still second problem
> here, don't ignore the fist - "why?"

HI Krzysztof,

  Thanks for the review.
  To answer the question,

"why ?" : The interrupts have been mis-interpreted on many platforms or 
many interrupts are missing.

Now, if I am adding the missing interrupts, I need to segregate targets 
also into respective buckets in the same patch and that is what making 
this patch a little complicated. Is it possible / acceptable to split 
this into two patches if this is the case. Can you help with suggestions 
from your end ? Or may be I am understanding your question wrong ? 😅

Regards,
Krishna,

