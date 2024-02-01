Return-Path: <linux-kernel+bounces-48035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6462D845686
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2148A290237
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A1615DBA1;
	Thu,  1 Feb 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IXXaOLMS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399D415D5CA;
	Thu,  1 Feb 2024 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788202; cv=none; b=sG9HhLjIR0OYew6FMp8mIa7XuiSm8uJHzzdC5nYqWjU+9cg8uAfTyk+HCxyEczvjfdQn+wZKRzhloO5KkkuOqxX+meKcE9NjgAoEOnXBYLm4t3XF7RkGYXGNX/ktBoMFdxe//uJea+5nkuHmCtYmiPmg/jSOGBO3m2wZTe/HGwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788202; c=relaxed/simple;
	bh=gsyE1W4bsrrTahd04s1tVYBjBTSJ9ADslLu7TIwcQJY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=B98SMp/p//CBxEXFJz3uQnWpFeblCK1n+OoiKmpriqgL7O4eGEyDJnhbr9PShfcdrO/hhz9a0ETl6PAjdCzcYZqNfQrP02if0wy7dsm+CMmptmY7dcXVHFKHc6jOH8jLcwWTwo7sWFm7vQdoo5DO/kFP5KXmHr+jpt+IAMnjKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IXXaOLMS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411BJ9hB017825;
	Thu, 1 Feb 2024 11:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=poig66Qauuj3+aCfWML9OzLxJ3EYXmSQfOtwaVslujE=; b=IX
	XaOLMSkpaVntVydO6XTFj3qR1FaHx9Hnkwyckn3cpUf3ATG/RjCAc7D7EGzyYeO7
	9eE9glmCiSJWo4SL9dJxsYlNDfSIt3c4ppmHkdfKj6UweDUK+GAISaPN1ZNO1fBV
	QA6h6pOcxW8dlhQbSapO7EPqhmcoi2SyQadhMRjZh+cf3hSoivlzswI4h9uAX8+C
	cyeatw+ZXGAMFihgrUFftOO0UhveECbCR/GW8AAf0sOyLNam+U0VzCXIaSJ/b3Fk
	zkD5KsblEBo1BZNcv/vc37oNFzHWCZc1eOmz9b2M6KBLiKpPaZrkTzo1Vz2yPULI
	WDDWkG7wS7cvI5JXBoDA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w09q684ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 11:49:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411Bntwg003058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 11:49:55 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 03:49:49 -0800
Message-ID: <b28904a6-c1ef-44b5-96ca-313a9a2a3f8b@quicinc.com>
Date: Thu, 1 Feb 2024 19:49:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: aim300: add AIM300 AIoT
From: Tengfei Fan <quic_tengfan@quicinc.com>
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
In-Reply-To: <c17dafd2-db89-4fe2-8e98-2a031f7237c2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: svgA3E3KxTNsOoBFiEqbfSefLkOThBHJ
X-Proofpoint-GUID: svgA3E3KxTNsOoBFiEqbfSefLkOThBHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=528 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010095



On 1/30/2024 3:25 PM, Tengfei Fan wrote:
> 
> 
> On 1/29/2024 4:18 PM, Tengfei Fan wrote:
>>
>>
>> On 1/29/2024 4:09 PM, Krzysztof Kozlowski wrote:
>>> On 19/01/2024 11:06, Tengfei Fan wrote:
>>>> Add AIM300 AIoT board DTS support, including usb, serial, PCIe, mpss,
>>>> adsp, cdsp and sound card functions support.
>>>>
>>>
>>> ...
>>>
>>>> +
>>>> +    sound {
>>>> +        compatible = "qcom,sm8550-sndcard", "qcom,sm8450-sndcard";
>>>> +        model = "AIM300-AIOT";
>>>> +        audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
>>>> +                "SpkrRight IN", "WSA_SPK2 OUT",
>>>> +                "IN1_HPHL", "HPHL_OUT",
>>>> +                "IN2_HPHR", "HPHR_OUT",
>>>> +                "AMIC2", "MIC BIAS2",
>>>> +                "VA DMIC0", "MIC BIAS1",
>>>> +                "VA DMIC1", "MIC BIAS1",
>>>> +                "VA DMIC2", "MIC BIAS3",
>>>> +                "TX DMIC0", "MIC BIAS1",
>>>> +                "TX DMIC1", "MIC BIAS2",
>>>> +                "TX DMIC2", "MIC BIAS3",
>>>> +                "TX SWR_ADC1", "ADC2_OUTPUT";
>>>
>>> This should be probably TX SWR_INPUT1.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> I will double check this with related team and I will update this.
>>
> 
> I will apply "TX SWR_INPUT1" on audio-routing node in the next patch 
> series.
> 

This patch series has been sent for nearly two weeks. do you think it is 
better to modify the patch series acording to the current comments and 
submit a new patch series, or continue to wait for your review comments 
on the current path series?

-- 
Thx and BRs,
Tengfei Fan

