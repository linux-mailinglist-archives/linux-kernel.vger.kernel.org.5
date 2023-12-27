Return-Path: <linux-kernel+bounces-11774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A951381EB83
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210AB2833B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DD92581;
	Wed, 27 Dec 2023 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oLRreVyP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D52210F;
	Wed, 27 Dec 2023 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BR2GhNc014632;
	Wed, 27 Dec 2023 02:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=9/HQZGbtop8fnbO6JTfa5TBQcnEZlTaVzl4vyS/b3NM=; b=oL
	RreVyPEXewp0FfHLtQhJTS3XmbFiPc/8OJX/7WXFT6d7f0ed8UHOQctQXtnadZ12
	CrhuHMUAVIGJqc2++AuriOx+v7gMNbLXAf6E1UQgdWNKLP8NJVQ9+juVsyB6Wfj1
	uKPmMsGAXax1HiXWMG1M8vkJwLwUWDsXQWh0amtUh4PRRfXMcYgawvOxtFli6l2B
	pnhDV/B2D4MIKl3TshsQ+FilZIOYRqnv6B+hOd426d2YFZ0pU5BoVDFqVO6sKMHJ
	yLY3y60a8pZ4cCwGbCHiXBhqgIMOZIyGfCD45CqcG/7zAbUxoIgGz7CPQJDYSiAQ
	yuUds9JpgBsATLxzVgig==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v7c9jk6qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 02:18:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BR2IOhe001070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 02:18:24 GMT
Received: from [10.216.28.88] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Dec
 2023 18:18:18 -0800
Message-ID: <a2108be4-5f35-4625-9c80-e7d6db978bab@quicinc.com>
Date: Wed, 27 Dec 2023 07:48:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: usb: dwc3: Clean up hs_phy_irq in
 binding
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Andy Gross <agross@kernel.org>
References: <20231222063648.11193-1-quic_kriskura@quicinc.com>
 <20231222063648.11193-2-quic_kriskura@quicinc.com>
 <e6419898-0d77-4286-a04b-7240eb90d8df@linaro.org>
 <268f9f54-8b2a-42bb-9a5d-10bd930cb282@quicinc.com>
 <55c478c7-abcc-4487-b81c-479df47d5666@linaro.org>
 <67c7c84c-c631-468e-ae67-1c31d41a605b@quicinc.com>
 <efdf2923-4669-409f-b5c4-d5b95009309f@linaro.org>
 <a284c13d-b55a-467d-8756-c41b0f913df3@quicinc.com>
 <1f8fdd47-0c48-4ccd-9352-41c830ec9240@linaro.org>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <1f8fdd47-0c48-4ccd-9352-41c830ec9240@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U96yhAiXlMwworn7unip6mWtyMVWfE6e
X-Proofpoint-ORIG-GUID: U96yhAiXlMwworn7unip6mWtyMVWfE6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=507 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312270016



On 12/27/2023 12:34 AM, Krzysztof Kozlowski wrote:
> On 26/12/2023 16:03, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 12/26/2023 5:52 PM, Krzysztof Kozlowski wrote:
>>
>>>>>
>>>>> This does not answer why, you sc8280xp and x1e80100 not get one optional
>>>>> interrupt. I asked "why" you are doing this change. Why do you need it?
>>>>> What is the rationale?
>>>>>
>>>>> Then I grunted about unmanageable commit, because all my troubles to
>>>>> review it are the effect of it: it is very difficult to read. It is also
>>>>> difficult for you, because you keep making here mistakes. So if you
>>>>> cannot write this commit properly and I cannot review it, then it is way
>>>>> over-complicated, don't you think? But this is still second problem
>>>>> here, don't ignore the fist - "why?"
>>>>
>>>> HI Krzysztof,
>>>>
>>>>     Thanks for the review.
>>>>     To answer the question,
>>>>
>>>> "why ?" : The interrupts have been mis-interpreted on many platforms or
>>>> many interrupts are missing.
>>>
>>> I asked about these two specific platforms. Please explain these
>>> changes. Above is so generic that tells me nothing.
>>>
>>
>> Is the question, "Why do x1e80100 and sc8280 don't have hs_phy_irq ?"
> 
>   No, not entirely, the question was why these have flexible number of
> IRQs (last one optional)?
> 
> 
>> If so, I checked the SC8280 HW specifics and I see one small error. The
>> name was printed wrong. I got it from another source. Will move sc8280
>> to list having 5 interrupts. As per x1e80100, I wasn't able to get my
>> hands on the hw specifics and I followed the following link by Abel Vesa:
>>
>> https://lore.kernel.org/r/20231214-x1e80100-usb-v1-1-c22be5c0109e@linaro.org
>>
>> As per the above patch, x1e80100 had only 4 interrupts.
> 
> Hm, ok, you say "4" but your patch says "minItems: 3". 3 != 4.
> 

Actually, you are right. We don't need the max/min items as we are sure 
that the targets mentioned under this have 4 interrupts definitively.

But the optional interrupt was put in just in case any target comes in 
that has no ss_phy and no hs_phy and has only the other 3 interrupts. 
Since those targets are not present currently, I will remove the max/min 
items from this.

Thanks for the catch. Sorry for bothering you with a couple of mails 
because I didn't understand the question you were trying to ask.

Regards,
Krishna,

