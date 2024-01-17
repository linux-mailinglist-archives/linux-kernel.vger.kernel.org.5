Return-Path: <linux-kernel+bounces-28622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BAD8300D6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2969E1F25280
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3946EC2E3;
	Wed, 17 Jan 2024 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BSBvzt7I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37169C121;
	Wed, 17 Jan 2024 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478128; cv=none; b=uLvquC2p3BcjfK6Qz8V4tz5FUMHwAonTd5lIzeRpZm8ns7hGtV4BceH5Ep/9ZYh8gT65e2vejNpAV0mjFySm8XLabfTDgyqYEPNmGOxZB9sAZT4G5Iii1Xczs04MAluLX0WfNjFxUs/T4pRk37ATXttKCI/Iiyvd3gQT5f6gMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478128; c=relaxed/simple;
	bh=szjRXdH1jflRRWy780XcAW9WPV5amXqQ6ahOmzsm0GE=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=DdU8OckoSoqgoQovh3PDabLOBJP+qhmWeYbUCNs+ee2vY2e4GAp/aLxKp76jQdsU4xGIwTDauTHt8BtkMsmrMCFG43K418/GNTGydpkJsk8JfriAAwAjMUjtWPm1SXitDbF95mnXiEN+RqypOrY/jj+rQVKtItlcR3dAT7dow08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BSBvzt7I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GNrtWr012376;
	Wed, 17 Jan 2024 07:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WdlAPSH87H+AJDxhsOz4c0Q3Kc9tVqhZ+0vH6ibMhQg=; b=BS
	Bvzt7IvoeyxdNOGIoUPi1wggKgrm4ygGOsGqi0jWf90WAGojnLBB6RufO3V74vby
	CBVVmHnp9lfwXGEEO65mvx3dAvoXTHYQuw56r26U30nj1ZHt8LxG5fIw0EQjVEZB
	FMY4FuIf5LCftTv6Ku9udGrXFmiOwDJLI8y0fLWQV7y8CtOMynDpW6grjwrceq8I
	f9f0X3t3tgA5VGD+LmWbOMBqdrHP8zOMN9qVgnT5klRbOIs47Yp6NkzqwO/IHetv
	M+REZhD04I/lm04R5P0SxgxRrwPnVpoyEKFsOAH3PjLYGc5fAgW88TFytccA+Oau
	5mWuKFTxewiqZ4fSeEZw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnrndaphg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 07:55:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H7tElW009406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 07:55:14 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 23:55:09 -0800
Message-ID: <34c6fb24-cc97-4cbf-bd22-74d1e27a6595@quicinc.com>
Date: Wed, 17 Jan 2024 15:55:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: coresight: Remove pattern match
 of ETE node name
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Suzuki K Poulose
	<suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, James Clark
	<james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>
References: <20240116064505.487-1-quic_jinlmao@quicinc.com>
 <20240116064505.487-2-quic_jinlmao@quicinc.com>
 <f616989b-2d84-483d-80c4-d3c6eb97b137@arm.com>
 <69875d89-651e-41ff-a1be-385dcbb15108@quicinc.com>
 <ff85db67-bd18-48fb-9050-81d731e5f402@linaro.org>
 <f74650fd-195f-4b93-a7e0-23b316dd74ad@quicinc.com>
 <5648e6e3-e2b1-4fa3-a0cd-74a0f0c0aa30@linaro.org>
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <5648e6e3-e2b1-4fa3-a0cd-74a0f0c0aa30@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 329r9XVur4LHJt4sGlE5Jf-_klLmcR1q
X-Proofpoint-ORIG-GUID: 329r9XVur4LHJt4sGlE5Jf-_klLmcR1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_04,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=863 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170053



On 1/17/2024 3:53 PM, Krzysztof Kozlowski wrote:
> On 17/01/2024 08:49, Jinlong Mao wrote:
>>
>>
>> On 1/17/2024 3:40 PM, Krzysztof Kozlowski wrote:
>>> On 17/01/2024 03:14, Jinlong Mao wrote:
>>>>>>           - const: arm,embedded-trace-extension
>>>>>> @@ -55,13 +53,13 @@ examples:
>>>>>>     # An ETE node without legacy CoreSight connections
>>>>>>       - |
>>>>>> -    ete0 {
>>>>>> +    ete-0 {
>>>>>
>>>>> Why do we need the number ? why not simply "ete" as Krzysztof suggested ?
>>>>>
>>>>
>>>> Hi Suzuki & Krzysztof ,
>>>>
>>>> If name all the ete nodes' name as 'ete', there will be error below when
>>>> build images.
>>>>
>>>> arch/arm64/boot/dts/qcom/sm8450.dtsi:301.6-312.4: ERROR
>>>
>>> Why are you pasting DTSI for binding? How is it related? Do we talk
>>> about DTSI here? No, this is a binding patch.
>>>
>>
>> Hi Krzysztof,
>>
>> Do you mean the name in DTSI can be different from the name in binding ?
> 
> Yes, we do not talk about DTSI here, so I did not suggest anything about
> DTSI.

Ok. I will use 'ete' as the name here.

Thanks
Jinlong Mao

> 
> Best regards,
> Krzysztof
> 

