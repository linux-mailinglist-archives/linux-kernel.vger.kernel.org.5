Return-Path: <linux-kernel+bounces-72700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D152185B791
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329CA282E10
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061F460264;
	Tue, 20 Feb 2024 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O5K+c4Vo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78BB5F480;
	Tue, 20 Feb 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421540; cv=none; b=pT2W4XeA/RgXcIFgPn4P2j59jbWHGUVf2tF73wHyj2WRd+ipT7F4FAMkaXPyXnf8dtG9x9PRSlHJU7d2U2gnJ6r4IcLs7C8pFe208wwruljJldC+9ZbxiZB1VSHsed5Htp2YBzKkEqWS+gqvWGF0DqYdmKMfDFkaWSqS57+LJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421540; c=relaxed/simple;
	bh=3nwtz/G2kMU3HJP/BL1fcvkdH1IJYB8dTOMqm0RhrTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rv3z8zyqMa4GEi0dBtNN07pkGK+iurcuhLFgE5KpVFfxHBN1SXB3iR0tFDs0m92rfoC5DQ9eKXOsXj2N1gT+5WvR2MsBC91vOF6VAj4ZbW4fJEfSsjM8n702jjLeYD50PRiNkcsi8V3AqZfLpMvA/TrnJktxBJnr1zmlp9tY+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O5K+c4Vo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K47St2001024;
	Tue, 20 Feb 2024 09:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lZ5zwfLJm/Xp4JWcbeEaCx0YtxmVfhVd6zx37LLu5X4=; b=O5
	K+c4VoOw0/wFlDgHVLp86XhRvdHiJItngQ4HBW/BVYCJh0IwVnopco8eKEvS5xqO
	6KQHfn8SUNr96zeBbQAHarvT3iqwpmacacbT/26orjVX9eo9+LIbbf9p9+aM5cHF
	Ni4xCHEdWhpMCyts+9WJUMTSnF/wkxgPA7d5Weu8jHKa2kMRugEFwQefRMQoYpuy
	eKxNMtYBQTGIXWLmFPppuR59BrFAZDl6HQhXuL9THbYqebBfMXqPrxZ6bFx/mp99
	X/wSN9n5GaSVbbd4N1T0gepHeAinBZJoHUPq1AiEzJA2Zl92+ysPOatD/LwOvK5r
	w8L9yFxEvtnTYSC7cb6A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcmqp8jau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 09:32:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41K9VnwV007613
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 09:31:49 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 01:31:43 -0800
Message-ID: <9f2df575-ca45-4cfc-9010-691f0e799bcf@quicinc.com>
Date: Tue, 20 Feb 2024 17:31:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] dt-bindings: arm: qcom: Document sm8650p soc and
 AIM500 AIoT board
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <kernel@quicinc.com>
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
 <20240205115721.1195336-2-quic_jingyw@quicinc.com>
 <2fa4d857-7262-40df-a842-56945ecffb81@linaro.org>
 <441ffff2-81a8-4b53-b15b-5ac6375d65c3@quicinc.com>
 <CAA8EJpra8UjWzWArQQg3Cq3m7WLo4Shnsj=EOhb50Yh46bOh7w@mail.gmail.com>
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <CAA8EJpra8UjWzWArQQg3Cq3m7WLo4Shnsj=EOhb50Yh46bOh7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: d-QiMM4IplYQwUcsruZiyywewSYjle4q
X-Proofpoint-ORIG-GUID: d-QiMM4IplYQwUcsruZiyywewSYjle4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=954 adultscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200068

Hi Krzysztof & Dmitry 

On 2/20/2024 5:06 PM, Dmitry Baryshkov wrote:
> On Tue, 20 Feb 2024 at 11:00, Jingyi Wang <quic_jingyw@quicinc.com> wrote:
>>
>>
>> Hi Krzysztof,
>>
>> On 2/5/2024 8:33 PM, Krzysztof Kozlowski wrote:
>>> On 05/02/2024 12:57, Jingyi Wang wrote:
>>>> Document Qualcomm SM8650P SoC and AIM500 AIoT board.
>>>
>>> Please describe shortly what is SM8650P and what are the differences
>>> with SM8650.
>>>

sm8650p has same base functions as sm8650 without modem-RF system.
Will update the description.

>>>>
>>>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/qcom.yaml | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> index 1999a5f2f254..e87ceb42853b 100644
>>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>>> @@ -88,11 +88,13 @@ description: |
>>>>          sm8450
>>>>          sm8550
>>>>          sm8650
>>>> +        sm8650p
>>>>          x1e80100
>>>>
>>>>    The 'board' element must be one of the following strings:
>>>>
>>>>          adp
>>>> +        aim500-aiot
>>>
>>> Drop this line.
>>>
>> drop this line will cause fail dt binding check failure, any suggestion on that?
> 
> It will not, it is just a free-form text
> 
will drop that.
>>>>          cdp
>>>>          dragonboard
>>>>          idp
>>>> @@ -1051,6 +1053,13 @@ properties:
>>>>                - qcom,sm8650-qrd
>>>>            - const: qcom,sm8650
>>>>
>>>> +      - items:
>>>> +          - enum:
>>>> +              - qcom,sm8650p-aim500-aiot
>>>> +          - const: qcom,sm8650p-aim500
>>>> +          - const: qcom,sm8650p
>>>> +          - const: qcom,sm8650
>>>
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Thanks,
>> Jingyi
>>
> 
> 
Thanks,
Jingyi

