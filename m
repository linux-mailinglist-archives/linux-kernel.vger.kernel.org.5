Return-Path: <linux-kernel+bounces-28455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90BC82FEB8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427221F25705
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5379A67C6F;
	Wed, 17 Jan 2024 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bgVPuA1K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E9B15B7;
	Wed, 17 Jan 2024 02:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705457694; cv=none; b=ATO6eTS3UA6rIia9P2ogaMXNdRgIH+sQV9pRhA87XdpUNPp+EYfTICnQCt0aH4mYmbgxODRqJbQRneBgkHiMIeqhtIl0eWhBbxObQsq+eebpd5ktQV8Kayvs8kURZwnru3AEoLo94Q2Kl7GghH7fi99hHPHgth1RlurSkBnSXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705457694; c=relaxed/simple;
	bh=WlYroLN8zk0cT2xYQ519Wg7+h2Smv//csVjWDekZDLo=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=phUXQeDdozyINZp+dmw/ounaetA5h8t0D7OJ1nsYeqm465niQy0HSy6GqlQoackvbVB3iDUd8gWWHKdF0I4cBXmpYAgsZ7jifQcmi0spNIBucVAdtrnwf7bT4OfpmVSpxEYfLRJcsxtkisjwtm6bduhs7LOdKYoyUaFbFTJUTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bgVPuA1K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H1RiZK003849;
	Wed, 17 Jan 2024 02:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0JgvLvRSoE1NiIl5rFnwqikJYRa+NwQLhAd6Lin9niY=; b=bg
	VPuA1K/aqd8vjBDEEiLmPm6+wTiCj89Sz21pc1hLU1fcVHc5KCh2HI1hOYPBr2r+
	IoiZ2TIjiiJ4Ef16ELYK3Rj6dmP2d1IlJMnGXCbY0Uc319C6dXhn+4Ss+BAiCeF5
	wpdAnBCNEufu9SqRm+v0cqkiyNDZfmd8CF6sP0T3qKAIPmthb8K65K7ae2+1EU/9
	JPrrscN7xcxkKaX1ROnWE7meaoAYRkUzczrq/B3FuEeeusFQx6+2AW1TE6GrTZpy
	Qw6ckveFPKLpZWNTlkjKwwup/mCuEzL/sN4T6eiHR2yMau8ltoOf4ngVy7/c1WSn
	9d81XXEPY5eVi1s32/OA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnn1qthxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 02:14:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H2EgFp019998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 02:14:42 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 18:14:37 -0800
Message-ID: <69875d89-651e-41ff-a1be-385dcbb15108@quicinc.com>
Date: Wed, 17 Jan 2024 10:14:35 +0800
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
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Leo Yan
	<leo.yan@linaro.org>,
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
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <f616989b-2d84-483d-80c4-d3c6eb97b137@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 02NpGnyyBgOoVZrKQnFsgBZhJ9_P5zlE
X-Proofpoint-ORIG-GUID: 02NpGnyyBgOoVZrKQnFsgBZhJ9_P5zlE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170013



On 1/16/2024 5:33 PM, Suzuki K Poulose wrote:
> On 16/01/2024 06:45, Mao Jinlong wrote:
>> Remove pattern match of ETE node name. Use ete with the number as the
>> name for ete nodes.
>>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   .../bindings/arm/arm,embedded-trace-extension.yaml          | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>> index f725e6940993..ed78cc7ae94a 100644
>> --- 
>> a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>> +++ 
>> b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>> @@ -22,8 +22,6 @@ description: |
>>     with any optional connection graph as per the coresight bindings.
>>   properties:
>> -  $nodename:
>> -    pattern: "^ete([0-9a-f]+)$"
>>     compatible:
>>       items:
>>         - const: arm,embedded-trace-extension
>> @@ -55,13 +53,13 @@ examples:
>>   # An ETE node without legacy CoreSight connections
>>     - |
>> -    ete0 {
>> +    ete-0 {
> 
> Why do we need the number ? why not simply "ete" as Krzysztof suggested ?
> 

Hi Suzuki & Krzysztof ,

If name all the ete nodes' name as 'ete', there will be error below when 
build images.

arch/arm64/boot/dts/qcom/sm8450.dtsi:301.6-312.4: ERROR 
(duplicate_node_names): /ete: Duplicate node name
arch/arm64/boot/dts/qcom/sm8450.dtsi:314.6-325.4: ERROR 
(duplicate_node_names): /ete: Duplicate node name
arch/arm64/boot/dts/qcom/sm8450.dtsi:327.6-338.4: ERROR 
(duplicate_node_names): /ete: Duplicate node name
arch/arm64/boot/dts/qcom/sm8450.dtsi:340.6-351.4: ERROR 
(duplicate_node_names): /ete: Duplicate node name
arch/arm64/boot/dts/qcom/sm8450.dtsi:353.6-364.4: ERROR 
(duplicate_node_names): /ete: Duplicate node name
arch/arm64/boot/dts/qcom/sm8450.dtsi:366.6-377.4: ERROR 
(duplicate_node_names): /ete: Duplicate node name
arch/arm64/boot/dts/qcom/sm8450.dtsi:379.6-390.4: ERROR 
(duplicate_node_names): /ete: Duplicate node name

Thanks
Jinlong Mao

> 
> 

