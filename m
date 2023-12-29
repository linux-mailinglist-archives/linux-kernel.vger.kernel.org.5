Return-Path: <linux-kernel+bounces-12924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BBE81FCBD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 04:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD6C2855BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 03:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA01FC9;
	Fri, 29 Dec 2023 03:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TXdOfEye"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577217CE;
	Fri, 29 Dec 2023 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BT3LB2q008136;
	Fri, 29 Dec 2023 03:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3iwCb4qcDiYcPO1CE8UgzT5vhsCnZQM30MoadwGuPLk=; b=TX
	dOfEyeQJqoNYQ3p4N4x5Bv4BwnKT9/qS9+RXF36zaEKjtjNurLUSLXG+ugJAe7na
	t+hOK5r1SIIm0p5kHBpp+2h1vhd2PdRXuBziUwVrVIysDrYpwybg2RxHMhmyRZf/
	OaEi3jaJH2gSuJscXf35j7mIv7t9hIkyx63pY0mZDlzPpU3BAPT9X6MxhHz955XT
	lWpc7hurEVSRdRud2JAIHJXywX2zs4wXy51Rs1dVGNwNEwqFixkJgaJQqyZMN/V+
	s6oyXxxOVhPX10WVZAyc883r+r3uK3nYsedun2Z3WtgHRHnLLtS8HDwHCbsfN7gG
	HeT3W8Ea+Z7Obr6W2kCg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v9cg3h0h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 03:21:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BT3LZgq029637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 03:21:35 GMT
Received: from [10.253.11.123] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Dec
 2023 19:21:31 -0800
Message-ID: <292b4694-8f11-1821-8dd3-d9650cfa194c@quicinc.com>
Date: Fri, 29 Dec 2023 11:21:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: coresight: Update the pattern of
 ete node name
To: James Clark <james.clark@arm.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>, <coresight@lists.linaro.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>, Leo Yan
	<leo.yan@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20231220140538.13136-1-quic_jinlmao@quicinc.com>
 <20231220140538.13136-2-quic_jinlmao@quicinc.com>
 <79f88d35-17cc-43b0-bb22-3c854f89d961@linaro.org>
 <8e5e9603-456b-4956-be03-b866feeeafb4@quicinc.com>
 <c41ff7c8-48d6-4f4f-a9df-aafe953a2e98@linaro.org>
 <f2f983b7-4c57-4b1b-925d-ffb18f6350a0@quicinc.com>
 <c64a41af-ff62-43c5-89f7-0558f8456010@linaro.org>
 <16932826-fcc2-49d3-95ab-201eff729360@quicinc.com>
 <d4c6c32f-b1cf-4cf2-9c52-85fa8c1ed73f@linaro.org>
 <9d13e1ce-38b1-4cdd-83ba-eca0c3091ce1@quicinc.com>
 <578d6319-5ab5-45e5-8457-00116c7c84ae@linaro.org>
 <cf5d97d0-ae79-9524-fc19-a73d4403a3d0@arm.com>
Content-Language: en-US
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <cf5d97d0-ae79-9524-fc19-a73d4403a3d0@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HTJT5c_xJwvujHgTa6iw13LH3PmKgqfx
X-Proofpoint-GUID: HTJT5c_xJwvujHgTa6iw13LH3PmKgqfx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312290023


On 12/28/2023 7:02 PM, James Clark wrote:
>
> On 26/12/2023 09:36, Krzysztof Kozlowski wrote:
>> On 26/12/2023 02:50, Jinlong Mao wrote:
>>>
>>> On 12/21/2023 4:44 PM, Krzysztof Kozlowski wrote:
>>>> On 21/12/2023 09:36, Jinlong Mao wrote:
>>>>>
>>>>> On 12/21/2023 4:17 PM, Krzysztof Kozlowski wrote:
>>>>>> On 21/12/2023 09:15, Jinlong Mao wrote:
>>>>>>>
>>>>>>> On 12/21/2023 4:12 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On 21/12/2023 04:28, Jinlong Mao wrote:
>>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>>>>>>>> index f725e6940993..cbf583d34029 100644
>>>>>>>>>>> --- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>>>>>>>> +++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>>>>>>>> @@ -23,7 +23,7 @@ description: |
>>>>>>>>>>>       
>>>>>>>>>>>       properties:
>>>>>>>>>>>         $nodename:
>>>>>>>>>>> -    pattern: "^ete([0-9a-f]+)$"
>>>>>>>>>>> +    pattern: "^ete-([0-9a-f]+)$"
>>>>>>>>>> My concerns are not resolved. Why is it here in the first place?
>>>>>>>>> Hi Krzysztof,
>>>>>>>>>
>>>>>>>>> ETE is acronym of embedded trace extension. The number of the name is
>>>>>>>>> the same as the number of the CPU it belongs to.
>>>>>>>> This is obvious and was not my question.
>> You already said it here...
>>
>>>>>>> Do you mean why the pattern match of the node name is added here ?
>>>>>> Yes, especially that it is requiring a non-generic name.
>>>>>>
>>>>>>> This node should not have the node name match, right ?
>>>>>> Usually. For sure shouldn't be for non-generic names.
>>>>>>
>>>>> Hi Suzuki,
>>>>>
>>>>> Can we remove the pattern match of the node name and use a generic name
>>>>> "ete" for the ete DT nodes ?
>>>> "ete" is not a generic name. What is generic here? It's an acronym of
>>>> some specific device name.
>>>>
>>> The device full name is embedded trace extension. So use ETE as the name
>>> here.
>> That's obvious and my comment was not about it. Second time... This is
>> my unlucky day... I said, why do you even want to enforce name which is
>> not generic, since the names should be generic?
>>
> I think we can just drop the enforced name if it's getting in the way.
> It doesn't really do anything and other Coresight bindings don't have it
> anyway.
>
>> I assume you read the DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
>>
>> Best regards,
>> Krzysztof
>>
> I couldn't find anything in that list that would be a good fit for a
> name, and it seems like all of the Coresight devices have already been
> added with non generic names (like funnel and replicator etc), so it
> might be a bit late now.
>
> But if we drop the enforced name then it's probably fine.
Thanks  James.

I will make change to remove the "$nodename:".

Thanks
Jinlong Mao

>
> James

