Return-Path: <linux-kernel+bounces-37862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D4783B6B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2DF1F2284B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1E63AC;
	Thu, 25 Jan 2024 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wus4cQzp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD89111AD;
	Thu, 25 Jan 2024 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146564; cv=none; b=S6qXEHFeS+IbXzsBJnIRwySBvrkl30D/je1D+4Nf58uxrxkyZbKpZq7dCxTX4idedsHCBcdzCLGQK46L81V5/RiOEiWCd4JtGyXR+Hj2LqJUCAhgGkkZ2FLmI9ZVs8N1Ps9FPZsxUxiulfCrycxjMi8oh3DlTsLy2xXgWwdZmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146564; c=relaxed/simple;
	bh=mmwtViixHPyN0IeRkwXKJl9Ty56hou9fwhbuIGk8JK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i3cSk4DWJDE/uPgIa5mnCCgmOlSJNXAFXAvO/AxMjufj3l3D9zds8BJQNgdHy+4FSSCK3bP+GvXONcd95/fL8uXf2fvRGQ7pBtHCb9ksRgYgX1g4SdTPNw2EB6hUKR/2GZaB1qiZcVpRVUQy58Go/VOv0Wkle2D9V1LsNCcVNhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wus4cQzp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P1XhJC013398;
	Thu, 25 Jan 2024 01:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=D5cxF8vGv2q3m04Eh8Yk7meNcjCOLYUj1AOW87Wzu/I=; b=Wu
	s4cQzpHH2ZVCjL+eemlkP8JTS3b3nsxdqLXriic3NGCbWTzmAlMSvs4OcnL5LuaA
	1ro9dycornLMoFB/oCBe+U8NZon8eTUjtKgFbc0ZP35LXxM8AKtjlwx8SasfzgM9
	PCphXtr6UtkXPdYBsYfzf2PmrnHzVGuQ/sKM2xkGOr2uD86gY80G2bUMDEdcdP4e
	GKUPdIY01fy7dmD5Qj/epmZqai0J+VrCy5WjMA3NXnhvReN4kbkrhfBhUJqEZf9V
	IpJjrCvy++aS7k5sNIXJOBlGwpza8f9dUBPF0g4q0+BL4tJKJ9vt/U3D4TjotRem
	jk6CcUKQcuZCB3ld8YrQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtykwa3p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 01:35:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40P1ZwNf028039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 01:35:58 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 17:35:52 -0800
Message-ID: <02b8c633-0e49-47a1-8e72-a4d988801d18@quicinc.com>
Date: Thu, 25 Jan 2024 09:35:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: modify the wrong
 compatible name
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240124023305.15755-1-quic_tengfan@quicinc.com>
 <20240124023305.15755-2-quic_tengfan@quicinc.com>
 <CAA8EJpqkDcqjn-8HrK7=rRe49ycDY6fbNDCKKQOeUpa_EDjFtw@mail.gmail.com>
 <67e17efa-df15-45f0-9a13-873cbd8f7507@quicinc.com>
 <CAA8EJprqPg_TJAwm4CyoJH9_uspueVJTgpwYZ-mPykPcrU8BBA@mail.gmail.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <CAA8EJprqPg_TJAwm4CyoJH9_uspueVJTgpwYZ-mPykPcrU8BBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: T-EouPyxdUBCnC4ZE1TGH4uwHPrkc8j8
X-Proofpoint-ORIG-GUID: T-EouPyxdUBCnC4ZE1TGH4uwHPrkc8j8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_12,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401250010



On 1/25/2024 9:20 AM, Dmitry Baryshkov wrote:
> On Thu, 25 Jan 2024 at 03:18, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>
>>
>>
>> On 1/24/2024 11:33 AM, Dmitry Baryshkov wrote:
>>> On Wed, 24 Jan 2024 at 04:33, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>>>
>>>> Use right compatible name "qcom,sm4450-tlmm" instead of
>>>> "qcom,sm4450-pinctrl".
>>>>
>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>>> index bb08ca5a1509..bb675c8ec220 100644
>>>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>>> @@ -17,7 +17,7 @@ allOf:
>>>>
>>>>    properties:
>>>>      compatible:
>>>> -    const: qcom,sm4450-pinctrl
>>>> +    const: qcom,sm4450-tlmm
>>>
>>> Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>
>> Thanks Dmitry. I will inside this "Fixes" tage into commit message in
>> the next patch series.
> 
> No need to, unless there are other changes to the patches. Such
> trailers are picked up automatically.

Thank you for the heads-up.

> 
>>
>>>
>>>
>>>>
>>>>      reg:
>>>>        maxItems: 1
>>>> --
>>>> 2.17.1
>>>>
>>>>
>>>
>>>
>>> --
>>> With best wishes
>>> Dmitry
>>
>> --
>> Thx and BRs,
>> Tengfei Fan
> 
> 
> 

-- 
Thx and BRs,
Tengfei Fan

