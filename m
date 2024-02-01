Return-Path: <linux-kernel+bounces-48135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0AE8457DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0FB1F21257
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D8853375;
	Thu,  1 Feb 2024 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="czaYRD7d"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568E53363;
	Thu,  1 Feb 2024 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790452; cv=none; b=bBF8dDCqxqbJALAR6ayyZFiQL1+YGOJaOH6YHuOyCloYfRopaWLLVNiOluDbE8msQVWmc3xMdI0ra7JYWXjppETEBpVV1wb3MxybxzKZlTiYPCk2FxWdFpmaOIbjIbYul02XKYY51cfjTC87e6T3wP3wVsT8BASu6eRjud0/S2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790452; c=relaxed/simple;
	bh=GvJ6UC3m5Gt80ckKHHc5Z0iPYxmYUNv9YAO1yLrwBxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=To2AzdAIkR90yORc58rrcxKc20dNzmOHDrEUZylhv7a2RBG0QI/bdrfEQIm25FBtRAPWzvOmxAO1qmTTz7Wd4ApbUbEWpDASAefEkJ3ydwORShC6bJRmRVbPuE5IYs+CVFCByIIGeEjhgr4SIPQAlTXpk2GkIx+WROkPDI36GjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=czaYRD7d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411CFMkc018597;
	Thu, 1 Feb 2024 12:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nphFBV7jRUlL4pJWoJtaUA6/hmMdEE8mLfbOdZWsKFc=; b=cz
	aYRD7deBYz2VhGa2ex43+TdjHvXEoiRJC2xMMukDGN+QPbiG+YUk9EzKY2oBIy41
	5CeOEkb/euIqWP/6K0T+M19M8YRp5a1y0creMmKtPMyj1B49jd7u8FfxUDyYB2kn
	ix4Oa2eSR564weWbWGUD9FzagEMpa01tXKPQgTGoWPN0k4GepNVQIRx30aQJ+FRU
	/l3SP5TdPM+2xd5QO9nmOpYr9DNjMS5hbhpGlzA4DpVbxCvZPMvBgIKy96CyO9dU
	+rvsL9xTUlbyLj4gLVr1l9PbilSX5meVy+IQzZLx6GGfxWcPMCq4LMYNO8q3rHPz
	du12aBWHjrshB5G/nj0Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0b4y00tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 12:27:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411CRQm1006554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 12:27:26 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 04:27:20 -0800
Message-ID: <a163702b-40f9-4082-a4d1-d89de645a651@quicinc.com>
Date: Thu, 1 Feb 2024 20:27:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: aim300: add AIM300 AIoT
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Qiang Yu
	<quic_qianyu@quicinc.com>,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-7-quic_tengfan@quicinc.com>
 <d3ef45cf-2de8-4f5b-8857-62d1996f3f58@linaro.org>
 <842bf6ad-46e1-43d8-86be-79ab0f49710b@quicinc.com>
 <c17dafd2-db89-4fe2-8e98-2a031f7237c2@quicinc.com>
 <b28904a6-c1ef-44b5-96ca-313a9a2a3f8b@quicinc.com>
 <3e3cbc36-2f3f-4295-9325-90757f0d77ce@linaro.org>
 <012bb387-2472-4bcb-ba87-3bf75dd88d64@quicinc.com>
 <5c6fec5f-79ed-4c93-b337-68a2c25d8a44@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <5c6fec5f-79ed-4c93-b337-68a2c25d8a44@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UnX-wVQ6ezZSGJuR7TVmZyFlQ2-Ay2sB
X-Proofpoint-GUID: UnX-wVQ6ezZSGJuR7TVmZyFlQ2-Ay2sB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_01,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=547 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010099



On 2/1/2024 8:20 PM, Krzysztof Kozlowski wrote:
> On 01/02/2024 13:16, Tengfei Fan wrote:
>>
>>
>> On 2/1/2024 8:03 PM, Krzysztof Kozlowski wrote:
>>> On 01/02/2024 12:49, Tengfei Fan wrote:
>>>>>>> This should be probably TX SWR_INPUT1.
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Krzysztof
>>>>>>>
>>>>>>
>>>>>> I will double check this with related team and I will update this.
>>>>>>
>>>>>
>>>>> I will apply "TX SWR_INPUT1" on audio-routing node in the next patch
>>>>> series.
>>>>>
>>>>
>>>> This patch series has been sent for nearly two weeks. do you think it is
>>>> better to modify the patch series acording to the current comments and
>>>> submit a new patch series, or continue to wait for your review comments
>>>> on the current path series?
>>>
>>> Hi,
>>>
>>> Whom do you ask?
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Sorry Krzysztof, can you give sone guidance on whether I should update
>> patch and submit a new patch series, or do you need time to review
>> current patch series?
> 
> Up to you, I do not plan to provide more reviews on this. I just
> commented about this thing here, because I was doing similar work for QRD.
> 
> Best regards,
> Krzysztof
> 

Thank youfor clarification.

Next I will update patches according to the current comments and submit 
a new path series.

-- 
Thx and BRs,
Tengfei Fan

