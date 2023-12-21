Return-Path: <linux-kernel+bounces-7997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3231D81B061
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6527D1C2225A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10784171D3;
	Thu, 21 Dec 2023 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y0zDclnx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B53817985;
	Thu, 21 Dec 2023 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL644PI007998;
	Thu, 21 Dec 2023 08:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3Aag4otRGxrW6+eAW+xzpp1aKCmszeeh7FaLhYvUitg=; b=Y0
	zDclnx0AC6xfuGCSiSwrnr8FqsW79U0yVTRIdIVpiP9GCZvN5Vfbxeks8YhSrIK0
	NkHXVUXdy9J3jmAzZJtpBBkkmuvHWPvVEFIf0NGaoY9WL0o7m+gfKWHtMCBdeyei
	DCHtqze/y7ok1htspCE5UBmYG/HVsyFd8wrgcxF0rwYaHsYOpwAOPH/o65wh6hBb
	GvoTezNY8x109gVWhePfsX+e8hqiLWOHShlY8JnGcArVm8RkfYrFl4HhI50ZYf2u
	T2JpsT1i5G11NCH+WH29KnfFHaewTonEwnt2ptRt0I1H/G2/C72VVJztzY2Y2aM7
	otDH85dGe/qUwmO7G09w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4d89h7k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:36:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BL8aC3Z026509
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:36:12 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 00:36:07 -0800
Message-ID: <16932826-fcc2-49d3-95ab-201eff729360@quicinc.com>
Date: Thu, 21 Dec 2023 16:36:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: coresight: Update the pattern of
 ete node name
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Mike Leach" <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>, Leo
 Yan <leo.yan@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>, <coresight@lists.linaro.org>
References: <20231220140538.13136-1-quic_jinlmao@quicinc.com>
 <20231220140538.13136-2-quic_jinlmao@quicinc.com>
 <79f88d35-17cc-43b0-bb22-3c854f89d961@linaro.org>
 <8e5e9603-456b-4956-be03-b866feeeafb4@quicinc.com>
 <c41ff7c8-48d6-4f4f-a9df-aafe953a2e98@linaro.org>
 <f2f983b7-4c57-4b1b-925d-ffb18f6350a0@quicinc.com>
 <c64a41af-ff62-43c5-89f7-0558f8456010@linaro.org>
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <c64a41af-ff62-43c5-89f7-0558f8456010@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Rjg4dITOhNiZrEWdtuYo574jqeJHPPqh
X-Proofpoint-ORIG-GUID: Rjg4dITOhNiZrEWdtuYo574jqeJHPPqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210062



On 12/21/2023 4:17 PM, Krzysztof Kozlowski wrote:
> On 21/12/2023 09:15, Jinlong Mao wrote:
>>
>>
>> On 12/21/2023 4:12 PM, Krzysztof Kozlowski wrote:
>>> On 21/12/2023 04:28, Jinlong Mao wrote:
>>>>>> diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>>> index f725e6940993..cbf583d34029 100644
>>>>>> --- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>>> @@ -23,7 +23,7 @@ description: |
>>>>>>     
>>>>>>     properties:
>>>>>>       $nodename:
>>>>>> -    pattern: "^ete([0-9a-f]+)$"
>>>>>> +    pattern: "^ete-([0-9a-f]+)$"
>>>>>
>>>>> My concerns are not resolved. Why is it here in the first place?
>>>>
>>>> Hi Krzysztof,
>>>>
>>>> ETE is acronym of embedded trace extension. The number of the name is
>>>> the same as the number of the CPU it belongs to.
>>>
>>> This is obvious and was not my question.
>>
>> Do you mean why the pattern match of the node name is added here ?
> 
> Yes, especially that it is requiring a non-generic name.
> 
>>
>> This node should not have the node name match, right ?
> 
> Usually. For sure shouldn't be for non-generic names.
> 
Hi Suzuki,

Can we remove the pattern match of the node name and use a generic name 
"ete" for the ete DT nodes ?

Thanks
Jinlong Mao

> Best regards,
> Krzysztof
> 

