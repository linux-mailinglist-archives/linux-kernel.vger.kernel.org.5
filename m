Return-Path: <linux-kernel+bounces-61449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC06851283
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9221C214E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3AC3987A;
	Mon, 12 Feb 2024 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K6CKNWch"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0EC39AC3;
	Mon, 12 Feb 2024 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738317; cv=none; b=hGQBTOJ5kH1el/z1eksKw0jvn/xMRILtt1vp4AqYeIEMygFjskyrRIQYPcHRHbl4vFpT0zyDl26uxG+zffA2BCxCtB63kFtz45OWcSS1ddIl0fw4VEgG/k4WzmVs8WDCBGNRS0zI39XiD3F7XzyQu0oEU89GCn+Wgd4qe8ecEyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738317; c=relaxed/simple;
	bh=sM9JdWac8EQctajM8GcYhhS6Gz2/rcvrg0+gVYZXE9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AIj3wLGdYwbGm9i+ZlhIBpgJUyMFB/ToWKaq1Griewqei4mzovJgxa9TBnawdEwL1SS5o3PxKqLV3o9Gnq2EopHeBn5AVjvinYsrOIncdfm9Yr/8uPjzZ+qIOpU7Kp86RMmiBgsUIqKb9FqkTD2HWZNYB08uGHNo1S669kND4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K6CKNWch; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CB7nll030374;
	Mon, 12 Feb 2024 11:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bVXESDt5VUA7sbwEoMSiKvR75YpbBHREXJRI0oKkbP4=; b=K6
	CKNWch/KMBtcObKafHH/Pz8ft06HWXhKQM9sBOu++/sSZ4qV9B8QBrHmsyzddYZr
	7L2TfKQGrS/VKQLxo/Zkx7gTjwC2zzv/R2rRQ4sMp555AqOK8LBtZnvLtDWqRcwC
	AWQTT9NweElSVjToGwntwqGNf9y2C5FI5iufLvfR9INwQmbgZJMJLZ92G8xi02FY
	qOKslFewAg9eShOE6/LsEw9a24SeAY9s24xWSCQkwfzh0MRvAzoVGb0TEwz88GOq
	H+CsEHM/bXHgidzJ7qFVaQcdamBsCItRjMHH9DGsjmWoh+K1S+VkvjsdJzR0hD5A
	h+OhCeplpKI9gilAnQsg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gvjg83b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:45:10 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CBj9YM021092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:45:09 GMT
Received: from [10.253.10.1] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 03:45:03 -0800
Message-ID: <73cdc81b-f58f-4eb5-b6ad-3011768781bd@quicinc.com>
Date: Mon, 12 Feb 2024 19:45:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8650: Add dma-coherent property
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <quic_kuiw@quicinc.com>, <quic_ekangupt@quicinc.com>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Aiqun Yu
 (Maria)" <quic_aiquny@quicinc.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>
References: <20240125102413.3016-1-quic_lxu5@quicinc.com>
 <20240125102413.3016-3-quic_lxu5@quicinc.com>
 <069b82ac-b59c-4665-8a77-6c11a2463faa@linaro.org>
 <690e64d6-8888-4f99-9ee0-c731aeea7762@linaro.org>
 <7edfed88-d84f-41e1-8c10-4af6efe53c4c@quicinc.com>
 <ed9bf914-8b3e-401e-93c0-77eae97e2ab8@linaro.org>
From: Ling Xu <quic_lxu5@quicinc.com>
In-Reply-To: <ed9bf914-8b3e-401e-93c0-77eae97e2ab8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9ge81GHtuyasV-qE9JHWdynI3q_lkEDk
X-Proofpoint-ORIG-GUID: 9ge81GHtuyasV-qE9JHWdynI3q_lkEDk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_08,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=639 adultscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120087

在 2024/2/12 19:41, Krzysztof Kozlowski 写道:
> On 12/02/2024 12:31, Ling Xu wrote:
>> 在 2024/2/12 19:10, Krzysztof Kozlowski 写道:
>>> On 12/02/2024 12:00, Krzysztof Kozlowski wrote:
>>>> On 25/01/2024 11:24, Ling Xu wrote:
>>>>> Add dma-coherent property to fastRPC context bank nodes to pass dma
>>>>> sequence test in fastrpc sanity test, ensure that data integrity is
>>>>> maintained during DMA operations.
>>>>>
>>>>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 13 +++++++++++++
>>>>
>>>> This wasn't ever tested:
>>>>
>>>> sm8650-qrd.dtb: remoteproc@32300000: glink-edge:fastrpc:compute-cb@1:
>>>> 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
>>>>
>>>> Ling,
>>>> How is this testing-patches-before-sending work in different teams? Do
>>>> you have such requirement?
>>>
>>> No clue if the original DTS change should be reverted or these are in
>>> fact DMA coherent, but let's choose one path...
>>>
>>> https://lore.kernel.org/linux-devicetree/254c1d14-25e3-4f4c-9e79-4ef7cec4d22f@linaro.org/T/#t
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Hi Krzysztof,
>> Add dma-coherent: true in this file: Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml at line number 89 can pass the DTcheck.
> 
> I don't understand your comment. Did you read the link above?
> 
> Anyway, I was asking: are you testing the patches before sending?
> 
> Best regards,
> Krzysztof
> 
Yes, I tested before sending.
-- 
Thx and BRs,
Ling Xu


