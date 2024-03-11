Return-Path: <linux-kernel+bounces-98418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D73968779D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135401C208B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A127138C;
	Mon, 11 Mar 2024 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UE1c0fHq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2DA35;
	Mon, 11 Mar 2024 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710124048; cv=none; b=PjU4uwROkq8PqFSBdwKqOkod2WUZDkD02ABEang6vBhKdtKwGpo2KwrpKbcBXEVZ6+IM1Owyze9h2CuJK1OJODzbU7N2GX+fy7R9VUa9B8cY28h1GlVMbVvDtXR01FMp3HLaS0zy2WxdPNgF9syf6KsDgYipNi12u2HPWyl23c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710124048; c=relaxed/simple;
	bh=Jz+xpLC/KxTkm53pRouKirdFn0/ISctTYR2AiNW/DwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WUwwMV5GfFXKOXi4s5QC+0qVxfn8x9w9jHIhq1+Gsr5nFbcIeabp9knYNujCARTm9kevX9SMIOwA0F1MKo8lnMiczUTUr5G7/nTEKjG57NZ0MQJtpphuZWEldAjk6ph/i4zQDNVGLZ5JhrVc5bSUlUTlgNvo1PCETS+5Kcx+CCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UE1c0fHq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B1Y3XF005556;
	Mon, 11 Mar 2024 02:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6K7GqWZ1l7QtK62aXuhH4ekYN4CVFpaWJjy+l2Pdimk=; b=UE
	1c0fHq7CFzAInx9FHFhn5En3gJXbmKsdFieXEcKywP8XYPb2FGi11gq/Y60vvSAI
	HtuV2yWBnS8f99KTC71SHcRsszn5d10LGOfLeCKNAnKyXWeIaVF3tPFI9i7ZfdrV
	zGa3nWLWD07oRbs/T/f/8V6Mg6P3BTu0ZSCsppS1yU0MNGoQ/y6cfdGqINR0p68H
	4lx1G/+t9Rk4WwFtXskPrTTsCMWyWz5G5PN+UYJJaLw05V45F2VnjhwmT5TFd3fE
	3t3rUP+oYWkeWPfOkAes0PEqqr1aq4WkwXxdi27OgV9PeFwpDWJINzp1acbkES2U
	3+2+gyYtLdNEATo4RVkQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wrfuxtghn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 02:27:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42B2RHaE018244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 02:27:17 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 10 Mar
 2024 19:27:11 -0700
Message-ID: <e828b14c-7a09-479a-bf60-0c16571f133f@quicinc.com>
Date: Mon, 11 Mar 2024 10:27:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: update compatible name
 for match with driver
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240129092512.23602-1-quic_tengfan@quicinc.com>
 <20240129092512.23602-2-quic_tengfan@quicinc.com>
 <CAL_JsqJfsWaj9OPkvc34rBvx7W_3v9+1kZqNu6QKDsA=iWAA4w@mail.gmail.com>
 <CAL_JsqLbbRFijBXS5CyRm0P4FMY7bR3UUdgXA7xP4Z1oRevnzQ@mail.gmail.com>
 <CACRpkdZ3uhyTnF7YkMk9sOeJJFZ4UPEna7PwpqPeBpWDdAmayA@mail.gmail.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <CACRpkdZ3uhyTnF7YkMk9sOeJJFZ4UPEna7PwpqPeBpWDdAmayA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Xkx0luqQbokh_5i-9W3M3TRlwkqKloRR
X-Proofpoint-GUID: Xkx0luqQbokh_5i-9W3M3TRlwkqKloRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_16,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110018



On 3/10/2024 7:44 AM, Linus Walleij wrote:
> On Fri, Mar 8, 2024 at 9:10 PM Rob Herring <robh+dt@kernel.org> wrote:
>> On Tue, Feb 27, 2024 at 7:37 AM Rob Herring <robh+dt@kernel.org> wrote:
>>> On Mon, Jan 29, 2024 at 3:25 AM Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>>>
>>>> Use compatible name "qcom,sm4450-tlmm" instead of "qcom,sm4450-pinctrl"
>>>> to match the compatible name in sm4450 pinctrl driver.
>>>>
>>>> Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>>> index bb08ca5a1509..bb675c8ec220 100644
>>>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>>> @@ -17,7 +17,7 @@ allOf:
>>>>
>>>>   properties:
>>>>     compatible:
>>>> -    const: qcom,sm4450-pinctrl
>>>> +    const: qcom,sm4450-tlmm
>>>
>>> I think you forgot to update the example:
>>>
>>> Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.example.dtb:
>>> /example-0/pinctrl@f100000: failed to match any schema with
>>> compatible: ['qcom,sm4450-tlmm']
>>
>> Still a warning in linux-next. Please send a fix.
> 
> I understand it as applying 1/2 is the fix so I applied it.

I will check this warning, and I will fix it.

> 
> Yours,
> Linus Walleij

-- 
Thx and BRs,
Tengfei Fan

