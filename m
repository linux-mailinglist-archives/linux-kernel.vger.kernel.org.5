Return-Path: <linux-kernel+bounces-99919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59429878F33
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3761F21894
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DA86997B;
	Tue, 12 Mar 2024 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ekx8eCHi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D15AB657;
	Tue, 12 Mar 2024 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229692; cv=none; b=QTDBLiIwcTdZUYZFkZz3P4rFNLYQQZ8KbaDLf8XX/As5glNUIyz65xO7vX0VbPQbaN+zsYSnD56tWO8reR4zvIaE/MuW/QBv0CpVb50MsTQ0qN2+he/YA41+B/TCfNc7oDXlb1bLA8/JTYBTwVSicXkzFgt4npcRcoG2BlCs+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229692; c=relaxed/simple;
	bh=oHNMUs0E9LTvbdffnW9qL4JVkImwURiE8Vj3N2Ew36I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CQPcEuCO1XCs5DRcNixbpvhMydOp+Cy25ayHgpsmFYfptXD8B13pIYw+x5tCcDyblS4kG3tZSCbIe+Cyo85NBvov80wUWY0uat2GSMZH1Kwn/E/Dnes74JkS64SO9lw0dQX8u10Eu+3jrkGRXMVgy3kMjI8CO6aFdd5teix8lG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ekx8eCHi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C5fswZ010197;
	Tue, 12 Mar 2024 07:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=09wLCnezT9Uab9FiCyCAUmZgWKMnkvwzvdFxcpiHZ7Q=; b=ek
	x8eCHiCJLwB0ucuLy/+ZXmmgwB85Ni72Oz7TC1n4RXKuuEEcsvGGD1s0uGYzJcPJ
	kYb8PGB4ld4q+X2FA6g6d/WLQiDhDnJMcW2aSpWTECaEypWv0AsqRO+rwxAgfYUl
	deU+X3tV8+VtNuSDXpbq7VTMD61tOXhoDysSYZtJzbG9EJ4PnnI6MBLnjj6TAw27
	nB1IzrEndZV466AkL7Cto2YOyRHjy7XfW8xAEYPUvgF6AYyBgP2Kh86t0nUwBRBO
	GGOrPCkoj2kPpWnvl1AaIzP+uzwt07miHTzcsM1b7prw/KVzuJF90ko9q6fcQ4ld
	SB0Giha3oFgRhVoBrnPw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wte5d0hps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 07:47:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C7lrBW013216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 07:47:53 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 00:47:48 -0700
Message-ID: <31b02b76-88ff-42d7-a665-18d2661e028c@quicinc.com>
Date: Tue, 12 Mar 2024 15:47:44 +0800
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
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <0d768f17-22d9-448e-9253-8498b61bf71e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sGpLBNzSyAuYletnjCAvLzneg5Gd2Gcg
X-Proofpoint-GUID: sGpLBNzSyAuYletnjCAvLzneg5Gd2Gcg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_06,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 mlxlogscore=923
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120060



On 3/12/2024 3:41 PM, Krzysztof Kozlowski wrote:
> On 12/03/2024 03:58, Tengfei Fan wrote:
>> Use compatible name "qcom,sm4450-tlmm" instead of "qcom,sm4450-pinctrl"
>> to match the compatible name in sm4450 pinctrl driver.
>>
>> Fixes: 7bf8b78f86db ("dt-bindings: pinctrl: qcom: Add SM4450 pinctrl")
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Wasn't this applied?

My test code base on tag: next-20240308, this patch is still not applied.

In fact, the following dt binding check warning only can be got before 
this patch is applied.

Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.example.dtb:
/example-0/pinctrl@f100000: failed to match any schema with
compatible: ['qcom,sm4450-tlmm']


> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan

