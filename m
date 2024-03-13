Return-Path: <linux-kernel+bounces-101017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4F487A0BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753001F2328F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD9AB663;
	Wed, 13 Mar 2024 01:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C87PEHjb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6F18F6F;
	Wed, 13 Mar 2024 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293423; cv=none; b=kuuQ8g32nimJHXcVN73S3Gp3sDaQ+ChY8GgAv9LHgNEir43MGAPy8P+03rL3KQ2WN0fmq4SPlpRW/TpKu6DjtMtOVGKWlwFWdE40MssYYNDWw35841772TWD15DMXoG4+DLSDoNG3u27nx+B1jolhkrbOD2xFqDFGqv9Vg3KkvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293423; c=relaxed/simple;
	bh=QeLHPMjtJQa9u4WOOLbF84Sos8zF1E8vXw09x+PS0QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PEHWIj8AcGqV1eLSyY6EkWgYXuvYtoC9iE+BXPnTRL1bDxc68yXSHVca2V2iPh673BTLBrMjaHPwwxlbNSMjd10Txf2BWSHwj/iketFyZjxfuNZMgMfEsnULbiu8vMVMnIa1r4MVkvQoWKzeBvtU1YycChQK+bD1Ka2IUpLozbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C87PEHjb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D0gDH0019760;
	Wed, 13 Mar 2024 01:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ouYn95H+zAQcXhJ9561a3sq1sdW1pT1PRaJbAoeiPVw=; b=C8
	7PEHjbpB6gK6X5rRmyhRG4qumP2JfXag15854fGJ3OROzTzB+Eg2/Q6fufcMsZ0D
	o0DkdKVMxv3szxG6yTBL7qOTV4PkXm+jUWyYTK/0viLzLhqiwAD/ZlG1P8OzUWQr
	LN57rB9ziyMOD0ieDk96Vu75Op/zQpwT+zEd0tVUE/wGKXgJHzjNhHRYUAntANPG
	N+7VkjswSXEu3NXkh8cmZEOrdfhOew1oOXLoJrz0QrpH/aT0kmhErfT2SWYQaX9R
	Pe2CLtlydMrZu0F3Ae2rnZn2Phf2yDYag1JeeogoHvyB1gbk6SEJ0DVNglOcRyNu
	ddRBtrDNHCLMu2rdKb0g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtmpd2041-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 01:30:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42D1UFkF010432
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 01:30:15 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 18:30:09 -0700
Message-ID: <ef237b3c-8613-4cd8-9391-e4a08d50cc6c@quicinc.com>
Date: Wed, 13 Mar 2024 09:30:07 +0800
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
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <6a3b5c9d-6375-457f-83c9-269746c1612a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jsOBfqwhhLdUvo5ElmlqqDO-Hc4Hp-4J
X-Proofpoint-ORIG-GUID: jsOBfqwhhLdUvo5ElmlqqDO-Hc4Hp-4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_14,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=928 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403130010



On 3/12/2024 6:55 PM, Krzysztof Kozlowski wrote:
> On 12/03/2024 08:47, Tengfei Fan wrote:
>>
>>
>> On 3/12/2024 3:41 PM, Krzysztof Kozlowski wrote:
>>> On 12/03/2024 03:58, Tengfei Fan wrote:
>>>> Use compatible name "qcom,sm4450-tlmm" instead of "qcom,sm4450-pinctrl"
>>>> to match the compatible name in sm4450 pinctrl driver.
>>>>
>>>> Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Wasn't this applied?
>>
>> My test code base on tag: next-20240308, this patch is still not applied.
>>
>> In fact, the following dt binding check warning only can be got before
>> this patch is applied.
>>
> 
> Please read all emails in the previous thread. You ignored two emails in
> the past and apparently one more recent.

I don't know if you mean I ignored the email which related with "Patch 
applied" tag from Linus Walleij. If so, the following is the reasion why 
I still include this patch:

I synced the latest upstream code on 03/12/2024, the latest tag is 
next-20240308, this tag still doesn't include this patch[PATCH v3 1/2].

Dt binding check still get warning if I only send [PATCH v3 2/2] patch 
to upstream base on next-20240308. so I include this patch[PATCH v3 1/2] 
in patch series even if this patch have "Patch applied" tag.

Looking forward to getting your advice if submitting patch series this 
way is problematic.

Thank Krzysztof again for your patient and kind review this patch series!

> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan

