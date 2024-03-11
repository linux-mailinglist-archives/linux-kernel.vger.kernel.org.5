Return-Path: <linux-kernel+bounces-98642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C972B877D24
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5531D1F21AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F28E2BAFC;
	Mon, 11 Mar 2024 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UGB3Cmkd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F418643;
	Mon, 11 Mar 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150217; cv=none; b=DviIpv71tQjTn16cyFVhzkbrZVlrSnFtfOkuaKB1TDXyDh14Gy+TH3QIDfl1Hnrn58hgLi/wxnZzvYkfrVEo+akoNHa10hgoQXSw0HGC1YgEt6ktxWrlXMHmVl0QoaUGzzBvp+mYySq635B4wy7d5F4UXVM51Rh2MZ8KJ6aYxo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150217; c=relaxed/simple;
	bh=yZ/RL5rPhH6GHVbkcDcntpSmzaRjN/cJqLI09syrTFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c6jKjspgJfwfs6YN4NUB9M/Cdjd51bLgfe5NsRb5PsPVqpHoxqAfH+88brs5ag6gYnsppHJ5qK7mkccebKe5VrPDow+iSil8hfkJ51gcsrKX8sbaSQHy5rDCLm3U6BlzHJW/j/7EXV+snR0ATFKlKWuPUb/57SRbeWUiW3Pjts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UGB3Cmkd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B8keQm007298;
	Mon, 11 Mar 2024 09:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SFVtr80gevnNIuE5evsZ9LlEeRl9dJRRHh5XOFnOAVA=; b=UG
	B3Cmkd8GemGH8u1/A4LYvmozRboChSSGCvXodP4duKtkmhITajfd8yhYgyce7LCW
	JWAlBVuzUSv0Kv/hDCDs0kU+l1NK+MCz7owSZCZOGzNfbE5CWLtGlYrvcV87JbJl
	qnNa9pwmlYJ+O5gqY/S3K1fIb5Cdx7aDZ2h+sxiWKaOZOUoA5iPj8JJTjZmFiTjF
	R/Rhci8ZyQOrWDE8Sn3tKyysRo/ljMfZ8ik7XlkcP23V5Eyj6YNsch9xQirvBcKf
	9vObSaeBesVwI/gON1/3Az17Cz6EeRudBPnIkC1vINyaGtoRPXhe7pROzk3XR5gB
	czz2DVYxBBxiRixCaVyQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wsxr1r3pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 09:43:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42B9hTUb031093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 09:43:29 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Mar
 2024 02:43:24 -0700
Message-ID: <2b512404-bc56-41b8-89aa-dcbb23d7b2bd@quicinc.com>
Date: Mon, 11 Mar 2024 17:43:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: update compatible name
 for match with driver
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
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
 <e828b14c-7a09-479a-bf60-0c16571f133f@quicinc.com>
 <abebde71-ac9f-434b-b48b-6567308a2873@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <abebde71-ac9f-434b-b48b-6567308a2873@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Cjeu1d7LmgJkYQ-PZ_VARWc6RnxpHCap
X-Proofpoint-ORIG-GUID: Cjeu1d7LmgJkYQ-PZ_VARWc6RnxpHCap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403110072



On 3/11/2024 2:48 PM, Krzysztof Kozlowski wrote:
> On 11/03/2024 03:27, Tengfei Fan wrote:
>>
>>
>> On 3/10/2024 7:44 AM, Linus Walleij wrote:
>>> On Fri, Mar 8, 2024 at 9:10 PM Rob Herring <robh+dt@kernel.org> wrote:
>>>> On Tue, Feb 27, 2024 at 7:37 AM Rob Herring <robh+dt@kernel.org> wrote:
>>>>> On Mon, Jan 29, 2024 at 3:25 AM Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>>>>>
>>>>>> Use compatible name "qcom,sm4450-tlmm" instead of "qcom,sm4450-pinctrl"
>>>>>> to match the compatible name in sm4450 pinctrl driver.
>>>>>>
>>>>>> Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>>>>> ---
>>>>>>    Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>>>>> index bb08ca5a1509..bb675c8ec220 100644
>>>>>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>>>>> @@ -17,7 +17,7 @@ allOf:
>>>>>>
>>>>>>    properties:
>>>>>>      compatible:
>>>>>> -    const: qcom,sm4450-pinctrl
>>>>>> +    const: qcom,sm4450-tlmm
>>>>>
>>>>> I think you forgot to update the example:
>>>>>
>>>>> Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.example.dtb:
>>>>> /example-0/pinctrl@f100000: failed to match any schema with
>>>>> compatible: ['qcom,sm4450-tlmm']
>>>>
>>>> Still a warning in linux-next. Please send a fix.
>>>
>>> I understand it as applying 1/2 is the fix so I applied it.
>>
>> I will check this warning, and I will fix it.
> 
> Now? We were all waiting for you to respond here without any effect, so
> finally I asked Linus to take the patch. In the future, be responsible
> for your patches and comments happening to them. The same if your
> applied commit causes issues in the next.

I will speed up the upstream work of the sm4450.
Before that, I had been focusing on the work of AIM300.

> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan

