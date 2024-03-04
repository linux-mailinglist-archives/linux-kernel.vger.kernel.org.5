Return-Path: <linux-kernel+bounces-90334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFE486FDCF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8309728370B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0272E210EE;
	Mon,  4 Mar 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HDnLPhvY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA742233B;
	Mon,  4 Mar 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545162; cv=none; b=YXTC9E92LYoHX9hvf3rqI04qbjZlBgUiCa9wGAchEBfq0FpLtNgHtco5IVhQ1vJg7TetiUs5E+Ync4rZq1XDKEtkUAmkVugbc2CdfI1cwY3Ax4TuaEanob7LLHj0K7nDO01LReXAc1yorTpv/3MpfMBtTnd0DaKK1yJJLdD4Swk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545162; c=relaxed/simple;
	bh=hlMnB2dL75qiH2zwxqxYzYy0Kk77oHmDiQwP2ar0g+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iJDbX6pEpPeIVUWHtRk28kQFHltjijh1Ugc0E/3GZgiCHof9vGRXO2Vxy2j5RCCwnUVF6tFZchdK8VSFmabu0YGVkFVt+JdOlHBzwv/WpBI8MDg3n5xWYbFqycFJhzCZLWiMA6NeVBJ5WLl7DXKidPVkrI8YEAfIhXSSmEZuQ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HDnLPhvY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4248eTIA017035;
	Mon, 4 Mar 2024 09:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zL7GlEKCJbsbLAgrwLYsbWRzSQBTSvsPBIMLHHqN6J8=; b=HD
	nLPhvYtXJU1d0I2xM5W7z5sVwKx5DqPgPhVEq74en05GwTBzpC6Rq4qttzNSbU60
	WdXq8AyxY6o+ZZjp8xUNmxFOjzaxXXRxlKoxa5qdP3r3CXMaflkeby0iqfMIzbx2
	3bKnsXmooyrk9UTL2YcWM4jc/A4YDMMVIAhOvaaivWZsYdemlcEU1cWoXE+wE37Y
	eYc2rc/VxjhzHepR7ZDlVEDZF2HhUT/hXjRkB8WlprHymwqWle17WI9MsFCxIL0k
	3D5Y5ugU4rM268D37bFfnijrXbrnmdsfDrxivwwNhMJa/nx53nIigvZKwwPvYLsG
	IAPoUBkEKuvmdD/hkjoA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn420rt4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 09:39:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4249dCjm009892
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 09:39:13 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 01:39:06 -0800
Message-ID: <539e642a-fd2f-4e55-ac02-f75f58da8eb8@quicinc.com>
Date: Mon, 4 Mar 2024 17:39:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] dt-bindings: arm: qcom: Document QCS8550 SoC and
 the AIM300 AIoT board
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>
CC: <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.co>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240301134113.14423-1-quic_tengfan@quicinc.com>
 <20240301134113.14423-2-quic_tengfan@quicinc.com>
 <f19113bb-d66a-4197-a5d7-f51c1fb8c157@linaro.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <f19113bb-d66a-4197-a5d7-f51c1fb8c157@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3XlRvknQG6r-_V5qZOarQ3WgSp-TR5cm
X-Proofpoint-GUID: 3XlRvknQG6r-_V5qZOarQ3WgSp-TR5cm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_05,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040073



On 3/4/2024 3:42 PM, Krzysztof Kozlowski wrote:
> On 01/03/2024 14:41, Tengfei Fan wrote:
>> Document QCS8550 SoC and the AIM300 AIoT board bindings.
>> QCS8550 is derived from SM8550. The difference between SM8550 and
>> QCS8550 is QCS8550 doesn't have modem RF system. QCS8550 is mainly used
>> in IoT scenarios.
>> AIM300 Series is a highly optimized family of modules designed to
>> support AIoT applications. It integrates QCS8550 SoC, UFS and PMIC chip
>> etc.
>> AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 66beaac60e1d..0ca4333fa8cf 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -42,6 +42,7 @@ description: |
>>           msm8996
>>           msm8998
>>           qcs404
>> +        qcs8550
>>           qcm2290
>>           qcm6490
>>           qdu1000
>> @@ -868,6 +869,13 @@ properties:
>>             - const: qcom,qcs404-evb
>>             - const: qcom,qcs404
>>   
>> +      - items:
>> +          - enum:
>> +              - qcom,qcs8550-aim300-aiot
>> +          - const: qcom,qcs8550-aim300
>> +          - const: qcom,qcs8550
>> +          - const: qcom,sm8550
> 
> This should be after sm8550 boards, not after qcs404.

Yes, I will adjust the order in the next patch series.

> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Tengfei Fan

