Return-Path: <linux-kernel+bounces-72737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8E585B829
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F751C2239F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088AB60BB7;
	Tue, 20 Feb 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pt9P0viO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6467E62;
	Tue, 20 Feb 2024 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422441; cv=none; b=Dg8mZAIPL7wZuSg0nfKxlO5faVMygypur3e4H+yW0GmJaIP8yGUijU5P0SX1rC37jZQ0JtPlR+qiAE7GdVqZ10lmKbfOR4fb1i1YZ2xfMziAS1RkNYjtRWBQp+NoKuUWSCs3HGzUf6syl/6fzl59iTB3cfUfHYkbIvHeLYbBBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422441; c=relaxed/simple;
	bh=KesIi6Q8HPaFY4Ookna0XyPXTx7dEbSq0mOPhInm6GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F8LkbKF+xknkixI62XKODrVO+i6YAiaCOPvMH7bej4b6mwpIQTbzn2LnBaIpk+/q2k+cTNwIRQMzP8nY8eLdJqu88TroL6mrwGBde9eYGEY7nenpTLQdEWtrT3/qQhlycNikMiNFHVf+c8JyAkVlVv+yke3BrT/B6YoQ5Er2AcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pt9P0viO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K67Ymj007432;
	Tue, 20 Feb 2024 09:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PB46TtqBgvtRnJYtKHiJGTbbNaJF2LMInwNIkcF5WvY=; b=Pt
	9P0viOQInx3OmgE/nGbSm8TiqgulsDDfLKM+9GKBbNZ6gmmLFBj18KE4ANOD1ysY
	Q5JXacrTNXP2kdLbB+mkiTxCS9Y803O++X1oSHvVUyod0gMvRQvk/shy+HOXeoOr
	jHuJ1uwpBvRevHl1EFyFUxvDZNrs0l4OYe6xR8gPafSQ5HsOACdVBFyKgobG8vER
	CV0X6OH+knB0kcKs/YHWaGbv42KYVldJATlyZ6cS5z8j21O7ECmYwHRBHdJCn4Mj
	iWVLmjkIrzgHn7vb82/j9+BmEulQipJsDviRtUG5b+e8OB7dNdgmYBYt+FlN03EC
	gAm39zt403hJgP4p5iGg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcnbd8hgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 09:47:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41K9kvWx024927
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 09:46:57 GMT
Received: from [10.233.21.53] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 01:46:52 -0800
Message-ID: <56f7cafb-38fe-44e3-9a2d-1d3edcde9fcc@quicinc.com>
Date: Tue, 20 Feb 2024 17:46:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] dt-bindings: arm: qcom: Document sm8650p soc and
 AIM500 AIoT board
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <kernel@quicinc.com>
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
 <20240205115721.1195336-2-quic_jingyw@quicinc.com>
 <2fa4d857-7262-40df-a842-56945ecffb81@linaro.org>
 <441ffff2-81a8-4b53-b15b-5ac6375d65c3@quicinc.com>
 <56da3332-deb5-4fff-ad58-664bbea0dc73@linaro.org>
Content-Language: en-US
From: Jingyi Wang <quic_jingyw@quicinc.com>
In-Reply-To: <56da3332-deb5-4fff-ad58-664bbea0dc73@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YdeqbxKmCFN_KINRzN1ctmAw7TtsFSMq
X-Proofpoint-ORIG-GUID: YdeqbxKmCFN_KINRzN1ctmAw7TtsFSMq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=888 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402200070

Hi Krzysztof,

On 2/20/2024 5:43 PM, Krzysztof Kozlowski wrote:
> On 20/02/2024 09:55, Jingyi Wang wrote:
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
> Really? How?
> 
> 
> 
> Best regards,
> Krzysztof
> 
Sorry I made some mistakes, have just checked that remove this should be fine.

Thanks,
Jingyi 

