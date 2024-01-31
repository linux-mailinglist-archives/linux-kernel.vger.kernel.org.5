Return-Path: <linux-kernel+bounces-46014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F048E84393D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB1C289A48
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5785FB85;
	Wed, 31 Jan 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BGJuhUjL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC9860885;
	Wed, 31 Jan 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690432; cv=none; b=IGumEelsAh0omMVrr/yaf2sf6AekVNZdTRJBO8Gd0msF/uYyZzS6uV3LunRsm6+1nDWWJmnHfewNwzciyPzHdSvDI1f6eoZZmUj9SPATIv5VXqDzINUCdyafSHEhNpRZWypuZoZS1qGybe1yo7cZusDuDxqSUASSI5GMDrpaJ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690432; c=relaxed/simple;
	bh=vRFrum47agDuMfsKxoMe79Z/7FuOXXiGEk93cyE0i14=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dkn1R5EPf71KBgxy0uRa2gktQ9vVSRn1KvUtTm8UUwx/sKygvl7falSXOFe8vVeXoMIFKVVXplo1Jy9w2MUul25XZ92F4ffXLZMt3P3DLakzbR0iZUcMVJNtV8TdfevrBmiJhmwIJJeKqdx8CMc/w5H43mkme95VxxPvmmgbe08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BGJuhUjL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V76vUO012185;
	Wed, 31 Jan 2024 08:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pGxUNSGAM2+sHX8XNYpFr+J6CxjXMvpl6ND2fcKYOqU=; b=BG
	JuhUjLbNDMY1mdkJ4GIQ6NY3bwCCtyR05Pot9ENWRNTmWSCVXYVU/V7vHtqH198u
	V9CtaXWG+kIwR/8WD7l1W+CnclimSzQdBuZmhNp0QOhgEPT0KnxUvygoN/XCPc3A
	cZ5nx8fEZ84tDGnh/iO3xcZn8HuPpwnyi+m6IREciYEQzPxqTyo1UQmQoA+eWee3
	rA40siBHRVXQdgI7KtHHNBCoqsqjvY67j3eulQwB2cr4wyC5Cn3j/8T4+QJ+HcYe
	frFLV6q4eIVbBEqsxNM3M863Mlv2IEN7N+y+JUX347iHJlp5ge91l/dSa880x6xY
	AWfsFW4NW38FsO8KGv/A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vy6gmhqwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 08:40:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V8eP4A028110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 08:40:25 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 00:40:20 -0800
Message-ID: <cf2ea585-0fb1-443a-a467-60f8b5d28174@quicinc.com>
Date: Wed, 31 Jan 2024 16:40:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: pinctrl: qcom: consolidate functions
 to match with driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240129092512.23602-1-quic_tengfan@quicinc.com>
 <20240129092512.23602-3-quic_tengfan@quicinc.com>
 <aa870f52-d956-4c3e-82a4-980a32f5f698@linaro.org>
 <8a3866ee-d70b-419c-bde4-7bf55415402e@quicinc.com>
 <6fb7286c-8669-4f99-9bb7-3ef8dfa229c2@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <6fb7286c-8669-4f99-9bb7-3ef8dfa229c2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bRJvpjjzF5DuQ24DXdfFyiZTryIr9is3
X-Proofpoint-ORIG-GUID: bRJvpjjzF5DuQ24DXdfFyiZTryIr9is3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_03,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=851 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310065



On 1/31/2024 4:34 PM, Krzysztof Kozlowski wrote:
> On 31/01/2024 09:24, Tengfei Fan wrote:
>>
>>
>> On 1/29/2024 7:24 PM, Krzysztof Kozlowski wrote:
>>> On 29/01/2024 10:25, Tengfei Fan wrote:
>>>> Consolidate functions to match with SM4450 pinctrl driver, because
>>>> consolidate functions are being used in SM4450 pinctrl driver.
>>>
>>> It's very difficult to see what changed from the diff, so please explain
>>> brieflyl changes here.
>>>
>>> What is that "consolidate functions" that you use in the driver?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> please help to comfirm that the following description as commit message
>> whether it covers your concerns:
>>
>> Pin alternative functions are consolidated(like: atest_char, phase_flag,
>> qdss_gpio etc.) in SM4450 pinctrl driver while they are still split in
>> DeviceTree binding file. SM4450 pinctrl function is broken if current
>> binding doc is followed. Update SM4450 pinctrl DeviceTree binding doc to
>> align with driver.
> 
> Please list the functions which are being removed and added. I usually
> do not expect such commit msg, but this is an exception: diff is tricky
> to parse.
> 
> Best regards,
> Krzysztof
> 

yes, I understand your concerns. I will list all the functions that need 
to be updated.

-- 
Thx and BRs,
Tengfei Fan

