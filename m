Return-Path: <linux-kernel+bounces-103106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8F687BB19
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08761C21B88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4A6E616;
	Thu, 14 Mar 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RZtsRSrR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356026E60E;
	Thu, 14 Mar 2024 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411321; cv=none; b=bUmE4tl88oCY5hvw8YknplNWJZipYXoTmp5yLbF/B6gqaJGXDIG6cWgJtMdRv4bjpV49jBCogtqqoRPxKEpA1pFC7QFjDB/YMgFn9g19sUSsfvS774Ppjm6JdcKoOZRPk3qQGxSTQyozJlCSZ1RHO+aHHZYJup7GUitusgmng70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411321; c=relaxed/simple;
	bh=gvWWFnoja/uQ4wxkGeFqleadvmNvo0/6Y5PqxYgqZyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uyQvrDo1pXTQnJqz3EpPcnb8B6x24OP5NrQaSOM1aGPro2dJ6kUfSu8tGebcV13AFTHf4FkP3u++X/tpVmCqZh+DaHsoLiRU1q4bzMyBqALnxiKbXtq9uCY1qE0moaARCtjUHynV/aRKQ8q16u1EbB1rsCgGngiDFr4vH+iggV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RZtsRSrR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E5Gv4I007740;
	Thu, 14 Mar 2024 10:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0uKg55Ve0ppdH9/LgTqLgn+XcTUF/8sUOQU6Y+kxKAM=; b=RZ
	tsRSrRD3MIwk2XumzM+gSPjvL4PSNHFqGXsSFKLROB5BvKCNzD5NkVV/TJGA7OEj
	mqHazOzbzglF/p+08Sgb3IXXhxuIbH2S7rfQHv7lDH+88BQMNWqrwNFnl33b1oj3
	agsT0B0mpXtod6W+bnEJTNudLObp4uQt8A0Jl02YE8Z4IVzUIsCRYRc7IZIOg5pA
	523nNTSlj59a2aTAl77zL834YXiAl2fpx6nnYGbwDvzXjQJQAxSO6+sxRkZodIi2
	NhPT7DXmVF7iEA4Tl4mkpput/rAvMC6KOeXLrD4Vt1WV57FvAI3a37VPWif5M0P5
	NIy+q4IiJSQk7d8YAcdw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuruqrwub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 10:15:16 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EAFDqa023164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 10:15:14 GMT
Received: from [10.239.29.49] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 03:15:08 -0700
Message-ID: <41889d0b-fe20-4fde-a71c-45d928ede11d@quicinc.com>
Date: Thu, 14 Mar 2024 18:15:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sm8650: Add three missing
 fastrpc-compute-cb nodes
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <quic_ekangupt@quicinc.com>, <kernel@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240314063334.31942-1-quic_lxu5@quicinc.com>
 <c7ac2b10-eee3-4269-85e4-a68d24c2337a@linaro.org>
 <88c32ccb-fadd-49e8-a8fc-76f93353d204@quicinc.com>
 <46e90e1f-1c93-4e88-b73c-94c165217d98@linaro.org>
From: Ling Xu <quic_lxu5@quicinc.com>
In-Reply-To: <46e90e1f-1c93-4e88-b73c-94c165217d98@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _KX1XI8PGm3nlyF5raEMMPEi0UoW3Iq2
X-Proofpoint-GUID: _KX1XI8PGm3nlyF5raEMMPEi0UoW3Iq2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_08,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140072

在 2024/3/14 18:09, Krzysztof Kozlowski 写道:
> On 14/03/2024 11:05, Ling Xu wrote:
>> 在 2024/3/14 14:55, Krzysztof Kozlowski 写道:
>>> On 14/03/2024 07:33, Ling Xu wrote:
>>>> Add three missing cDSP fastrpc compute-cb nodes for the SM8650 SoC.
>>>>
>>>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 29 ++++++++++++++++++++++++++++
>>>>  1 file changed, 29 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>>> index ba72d8f38420..c238ad1be0d4 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
>>>> @@ -5084,6 +5084,35 @@
>>>>  							 <&apps_smmu 0x19c8 0x0>;
>>>>  						dma-coherent;
>>>>  					};
>>>> +
>>>> +					/* note: secure cb9 in downstream */
>>>> +
>>>> +					compute-cb@10 {
>>>> +						compatible = "qcom,fastrpc-compute-cb";
>>>> +						reg = <12>;
>>>> +						iommus = <&apps_smmu 0x196C 0x0000>,
>>>> +							 <&apps_smmu 0x0C0C 0x0020>,
>>>> +							 <&apps_smmu 0x19CC 0x0000>;
>>>
>>> Lowercase hex. Please look at the code above, don't copy downstream
>>> code. This applies to all your work: don't send us downstream code, but
>>> clean it up from all of its problems.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Hi, sorry, do you mean that I should delete this line: /* note: secure cb9 in downstream */?
>> All I sent are upstream codes, I didn't copy cb9 here and I also see this commented line in sm8550.dtsi.
> 
> My comment was about the style. If you send "upstream codes", how could
> you have there uppercase hex? It is even visible in the diff context
> that it should be lowercase!
> 
> Best regards,
> Krzysztof
> 
Sorry for that, I got it. Thanks for your comment.
-- 
Thx and BRs,
Ling Xu


