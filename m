Return-Path: <linux-kernel+bounces-28616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4523D8300C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A86C1C23858
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F125FC153;
	Wed, 17 Jan 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n09ViF2n"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C81BE5D;
	Wed, 17 Jan 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477795; cv=none; b=V55Cr4exH330a6YlByg4uGZr0xm7litRuOoPvgW4xTwMiRS6nXPp0AcNTLh0D13aLDWuvcjeiTmRWQSYbStGf4U2U3gJmseJRSQAUm+c0IB2UprBK93jHws7TBGcFsG8emOUAk+SArKOoylduTXLioskhDY6GVnVwofTo3G7Ktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477795; c=relaxed/simple;
	bh=jp4zzL0JvFzVtLtiQMUNXivkJjo+pREVawcLTw5rAaE=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=r3XVEPQwySvqBL7i5yduvSZK8xdMQxiMEkEeM4R/410fqe+Xt9h2xUPC82UGgARUiDbqvtAkODuUeGnze0PDIZ/Vh1VgBfDnEYtFLkECX4/2Ft/rl4CSPrDkznJTiLCeHm71Id8NbjFjaWK/EDT/OqhvE/fYKQoOBtEbokmqukA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n09ViF2n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H4TAXD002508;
	Wed, 17 Jan 2024 07:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/Yf5kgWVpjS6xWBebFznehRVVqI6qgZrrctcY8wWuKQ=; b=n0
	9ViF2nJpmv8g2fnfdcg4pmAosAdhA3gcNEJYWPV42TymjlCuOJZPABJBbfV7H9Yg
	fO6GyYJ5HpXnJ4fZ8qCVwL5RNqCkVLhCySD0nuMNn7bul7MMsqNf9QlPh4m3Pyyx
	BD0o6haQ1cDJDFz0kRCkCHho0KAHYiMPtV1X0uEXI2BdU6r1to7lrRyRkEpdrj3i
	5EtcOi39cY6aTEgN5LqtUDlCQ+86/jC7ikFykPsrdw1N1LdKQomtlBHz7LMCKS8m
	obIbTfEnvnDgMn+UkdRhbIh9yaHB3m+Ppyb03tUxl1FmWiLB2XORtXcWDtZIiPjo
	KwJWD7nhhyz8trJN0/Mw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp4ak0rd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 07:49:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H7nbmo003017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 07:49:37 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 23:49:33 -0800
Message-ID: <f74650fd-195f-4b93-a7e0-23b316dd74ad@quicinc.com>
Date: Wed, 17 Jan 2024 15:49:30 +0800
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
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <ff85db67-bd18-48fb-9050-81d731e5f402@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DjNG_RpX1kgDW6M-ATBwrqj2aP4_nma2
X-Proofpoint-GUID: DjNG_RpX1kgDW6M-ATBwrqj2aP4_nma2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_04,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=854 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170053



On 1/17/2024 3:40 PM, Krzysztof Kozlowski wrote:
> On 17/01/2024 03:14, Jinlong Mao wrote:
>>>>          - const: arm,embedded-trace-extension
>>>> @@ -55,13 +53,13 @@ examples:
>>>>    # An ETE node without legacy CoreSight connections
>>>>      - |
>>>> -    ete0 {
>>>> +    ete-0 {
>>>
>>> Why do we need the number ? why not simply "ete" as Krzysztof suggested ?
>>>
>>
>> Hi Suzuki & Krzysztof ,
>>
>> If name all the ete nodes' name as 'ete', there will be error below when
>> build images.
>>
>> arch/arm64/boot/dts/qcom/sm8450.dtsi:301.6-312.4: ERROR
> 
> Why are you pasting DTSI for binding? How is it related? Do we talk
> about DTSI here? No, this is a binding patch.
> 

Hi Krzysztof,

Do you mean the name in DTSI can be different from the name in binding ?

Thanks
Jinlong Mao

> 

