Return-Path: <linux-kernel+bounces-61432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF6851248
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0421C20FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5326E3984F;
	Mon, 12 Feb 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eVJB/3bP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E838FA0;
	Mon, 12 Feb 2024 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737509; cv=none; b=MPTDgc9ki81BHta0Y3ZsrEfATCx5kjLvBKM7a2VgDqintbTTJzIcVOKlouvz7RVlMmE7JFVIzZs10l/eRWRdaX+wsFgtDMEdwWD6PKsUhKTmOwURQF9LbUdOoqd24e0GmksvSpIWxaa30ZLMOC6/iy1BqP66JD/Eap/qMnxRUhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737509; c=relaxed/simple;
	bh=VoBUN0aollmxYMv8gO1z43fBi/mUksY3u3S6lW72neM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q7VZzBEN89Gy0EcaDr0usD6B0XoxC9R5vE8rGNd/Sx5OV+L4sbhsEmOgXLIm2otJqFso/IW+jwtIzgZ+1pHhV4Q7HhFTtTxyZ9UD1ZOss+RkhlTypA1En1kze70wfsheGedhY59rw4qbuVDmr5Cvi6gW6CEvUbcO+6V87t7bsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eVJB/3bP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CBK8mi024678;
	Mon, 12 Feb 2024 11:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=y127VQqW3ggnrY8DwnNEDlppLPa31FdwBRhZF/TEXMs=; b=eV
	JB/3bPPknBV5ycrVYMCorelus1ASxMNNM/hMvEzaxEY8tPrDMFBRo8d6YugkSGhw
	FzRzQ0c4K9OOM8PWv7Z3xSNzZ9d0jD6iyX6qr97wTELvzQO7rbbw92dipuv3GZ6S
	FTW916MK7iQPGELiWDSvhCAL8wZsUd6cHB5aD+51QzS8SykNkfXmJBQIhKoJo0l7
	WWgkMlAHIqHIqXB+HjnNQinXkgpW9gcCIGtF+LkbtK2exY+U7n0r1+5x3rOcr3mu
	QnMKVSdgBhUzk0C5m5/CLnmzkaS4Zgzu933unKfCe+v+I4fmWVcgPcAPwiMUr58p
	JeaUwFe4ngr0AExJL2vg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gse08ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:31:44 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CBVhZ2022324
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:31:43 GMT
Received: from [10.253.10.1] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 03:31:37 -0800
Message-ID: <7edfed88-d84f-41e1-8c10-4af6efe53c4c@quicinc.com>
Date: Mon, 12 Feb 2024 19:31:35 +0800
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
From: Ling Xu <quic_lxu5@quicinc.com>
In-Reply-To: <690e64d6-8888-4f99-9ee0-c731aeea7762@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o93DF_q9D-83hJsYug4rKSEAiA7JF0UV
X-Proofpoint-ORIG-GUID: o93DF_q9D-83hJsYug4rKSEAiA7JF0UV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_08,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=617 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120087

在 2024/2/12 19:10, Krzysztof Kozlowski 写道:
> On 12/02/2024 12:00, Krzysztof Kozlowski wrote:
>> On 25/01/2024 11:24, Ling Xu wrote:
>>> Add dma-coherent property to fastRPC context bank nodes to pass dma
>>> sequence test in fastrpc sanity test, ensure that data integrity is
>>> maintained during DMA operations.
>>>
>>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 13 +++++++++++++
>>
>> This wasn't ever tested:
>>
>> sm8650-qrd.dtb: remoteproc@32300000: glink-edge:fastrpc:compute-cb@1:
>> 'dma-coherent' does not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> Ling,
>> How is this testing-patches-before-sending work in different teams? Do
>> you have such requirement?
> 
> No clue if the original DTS change should be reverted or these are in
> fact DMA coherent, but let's choose one path...
> 
> https://lore.kernel.org/linux-devicetree/254c1d14-25e3-4f4c-9e79-4ef7cec4d22f@linaro.org/T/#t
> 
> Best regards,
> Krzysztof
> 
Hi Krzysztof,
Add dma-coherent: true in this file: Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml at line number 89 can pass the DTcheck.
-- 
Thx and BRs,
Ling Xu


