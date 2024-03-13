Return-Path: <linux-kernel+bounces-101359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C5687A5EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE451F24872
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B95C3D39F;
	Wed, 13 Mar 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pL6AaKXF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE73B299;
	Wed, 13 Mar 2024 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325896; cv=none; b=nelDGVvlID/bK9adfRFtrLvcyRXAfvzUXYSlDc059hae5egHzn+7wnCTAPJBr7M+7jtqflKGFr0ibcZsTimRvbn6XaP/EZTKKO+IpGWk+9RBvEdFq4IIL/RtQtxBmAd2ZWNval0Ap0GnkO7U7wsjZNOZzQzOcxQTuJ1aE7fBBhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325896; c=relaxed/simple;
	bh=YL67QLFi8itRo/mf08zqoOV8qxPWioGfX6CBCSqydtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eCzY5IMnDGuXhUnqcgZlc2GYtSiG/oYMP9E+m6YYn2uqKcj2kiLhLBolV+pUq8xJwKBrkKVLICX4QoFxXIUFMmHBAXgmu2bDzMheexYnDSw4b2aQrWDT8Qcqa7bbBapbi1MXaxTe++MzmQfttJraOjUttWAlfdZbbvCMbbMSzFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pL6AaKXF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D7jS2w028458;
	Wed, 13 Mar 2024 10:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1bRxUmmC5D7JOkclXvnpf6YXrdazHfBRXnnBcjbKPz8=; b=pL
	6AaKXF+h8PGxoWZvPc8UNnFExRE4uF3o1eJMDuVGkdp1obpXvaBgKvlWOjbezNvY
	kAoUbATRp6/WreLT1v5e3VZUOl4uSEyNTja8j1uUNAkigv+mJRxTEvQT3tX2lyeB
	dRbjwm9CdP3RAqNHmkYGcbasj6BsdkXB4nGkHMZMoIc+q9G3VVUDv3vbIGSF4VuB
	LQHSz5ribOPhi0CAl2FYSLgRfGok9Ho2rKUalgxxehtBQEKXtFHjfo585mlRY7/z
	0y38WdqVltjOSE/KfkzmAhrCtevG47CeEpPbRu0jCcLEFUejnpATTxrdrVoMfKK8
	ZvHF+zbcAitoAX3b13Tg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu81m0b5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 10:31:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DAVT0m024921
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 10:31:29 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 03:31:23 -0700
Message-ID: <fb4f6b7f-7447-4af6-8d8e-d6f1be030e73@quicinc.com>
Date: Wed, 13 Mar 2024 18:31:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: update compatible name
 for match with driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240312025807.26075-1-quic_tengfan@quicinc.com>
 <20240312025807.26075-2-quic_tengfan@quicinc.com>
 <0d768f17-22d9-448e-9253-8498b61bf71e@linaro.org>
 <31b02b76-88ff-42d7-a665-18d2661e028c@quicinc.com>
 <6a3b5c9d-6375-457f-83c9-269746c1612a@linaro.org>
 <ef237b3c-8613-4cd8-9391-e4a08d50cc6c@quicinc.com>
 <60a0e51f-dc0e-4bbf-8127-f987ac2aae71@linaro.org>
 <f515f9f4-b87c-465b-83c0-f4b7b5c47840@quicinc.com>
 <15e344a8-8ad2-41f2-a8ac-6e5d1627c19a@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <15e344a8-8ad2-41f2-a8ac-6e5d1627c19a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jMlKTiFCA9cN5SU98-Ci9Mjx_bkCFTHr
X-Proofpoint-GUID: jMlKTiFCA9cN5SU98-Ci9Mjx_bkCFTHr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130078



On 3/13/2024 5:11 PM, Krzysztof Kozlowski wrote:
> On 13/03/2024 08:55, Tengfei Fan wrote:
>>>>>>> Wasn't this applied?
>>>>>>
>>>>>> My test code base on tag: next-20240308, this patch is still not applied.
>>>>>>
>>>>>> In fact, the following dt binding check warning only can be got before
>>>>>> this patch is applied.
>>>>>>
>>>>>
>>>>> Please read all emails in the previous thread. You ignored two emails in
>>>>> the past and apparently one more recent.
>>>>
>>>> I don't know if you mean I ignored the email which related with "Patch
>>>> applied" tag from Linus Walleij. If so, the following is the reasion why
>>>> I still include this patch:
>>>
>>> Yep, that's the one. Please do not send patches which were already
>>> applied. It causes unnecessary effort on reviewer and maintainer side.
>>>
>>>>
>>>> I synced the latest upstream code on 03/12/2024, the latest tag is
>>>> next-20240308, this tag still doesn't include this patch[PATCH v3 1/2].
>>>
>>> Happens, considering Linus applied it after 8th of March, I think.
>>>
>>>>
>>>> Dt binding check still get warning if I only send [PATCH v3 2/2] patch
>>>> to upstream base on next-20240308. so I include this patch[PATCH v3 1/2]
>>>
>>> If you send patch 1+2, dt_binding_check will have exactly the same
>>> result. I don't know about what sort of dt binding check you talk, but
>>> for all cases: you changed nothing by sending these two patches in that
>>> regard. Only noise on the lists.
>>
>> The dt binding check failed which Rob Herring remind me in previous
>> patch series as the following:
> 
> This does not make any sense. Whether Rob runs his test on previous or
> future next, changes nothing in regard of this patchset being sent with
> duplicated patch or not. The result will be exactly the same for Rob.
> 
>>
>> Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.example.dtb:
>> /example-0/pinctrl@f100000: failed to match any schema with
>> compatible: ['qcom,sm4450-tlmm']
>>
>> This failed is introduced by
>> https://lore.kernel.org/linux-arm-msm/20231206020840.33228-2-quic_tengfan@quicinc.com/.
>> Something got broken aroud -m flags for dtschema, so indeed no reports
>> this unmatched compatibles warning when this patch was revriwed. We also
>> have some discusstion in patch email.
> 
> Again, not related at all whether you send patch *which was applied* or not.
> 
>>
>> The patch[PATCH v3 1/2] is made for fix this previous patch dt binding
>> check failed. So dt binding check failed will disappear after this
>> patch[PATCH v3 1/2] is applied.
> 
> And who is supposed to run that dt binding check and on what base? Your
> patch changes absolutely nothing in that regard, just creates confusion.
> 
> And the fact that you keep arguing over this simple case, reminds me
> other clueless discussions I had with some Qualcomm folks. None of the
> arguments you brought here justify sending patch which was applied.

Sending duplicated patch isn't a correct approach, I will avoid making 
similar mistakes in the future.

> 
>>
>>>
>>>> in patch series even if this patch have "Patch applied" tag.
>>>>
>>>> Looking forward to getting your advice if submitting patch series this
>>>> way is problematic.
>>>
>>> Do not send patches which are known to be applied.
>>
>> Yes, I will be careful not to resend the patch which have already been
>> applied in the future work.
> 
> Then why do you keep arguing that sending this duplicated patch was
> correct approach?
There may be some confusion here. Sending this duplicated patch isn't a 
correct approach, I will not send duplicated patch again in the future 
upstream work.

> 
>>
>> Do you think it is necessary to send another version patch series for
>> remove this applied patch[PATCH v3 1/2] from patch series?
> 
> No. It is merge window, please read process documents in Documentation
> directory. Then please read Qualcomm upstreaming guide.
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan

