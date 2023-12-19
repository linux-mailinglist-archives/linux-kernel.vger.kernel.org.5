Return-Path: <linux-kernel+bounces-4978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 304B18184B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62CE1F25BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D490913FFB;
	Tue, 19 Dec 2023 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l/VC7WI2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599D13AD8;
	Tue, 19 Dec 2023 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ38jnJ004506;
	Tue, 19 Dec 2023 09:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IIwSulmoVmy7q4LR/z3VTL+vU7D4EhFmFLr2WhETerU=; b=l/
	VC7WI2pk2lj5RTZ4hGqD8INO6XlhvmPokk789XuWjV0ALWLMmTUO89ay7jey2/M7
	M9R62syfeaDAd49wzfnxqv4D5fjATrjcSpRMwMLxDhn01JoQaVfweTVwKUAO7A04
	/bT1gl7gsAdFP2Gkx9p4XySR+kOtlvZb3YpIjH5hQ/+V2fFxzOjdakCgf97oB69q
	QyKa2j3jRADG9VNzshCdww5KHE6CGDzdLvsvB8hU5qMP9PTfKGjZUe6FatV3DcJh
	P03JmtubpiD3Kj5k3wfuK7zVU/6HjqpwoJPbPVi5fXKNqAD89gTeCu3GFtajqMSX
	pCRNjpzvVJELDGdunMHw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v330krup6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 09:45:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJ9jEDi030548
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 09:45:14 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 01:45:11 -0800
Message-ID: <4629b22b-9395-47a3-8af2-a85a9d4412ba@quicinc.com>
Date: Tue, 19 Dec 2023 17:45:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: arm: qcom: Document qcs8550 SoC and
 board
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tengfei Fan
	<quic_tengfan@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231219005007.11644-1-quic_tengfan@quicinc.com>
 <20231219005007.11644-2-quic_tengfan@quicinc.com>
 <30ecd718-4303-4380-8587-53c6f6b2a9bd@linaro.org>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <30ecd718-4303-4380-8587-53c6f6b2a9bd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 57O0pX12S3DDbFD27z9jLmbuGTRngG-L
X-Proofpoint-GUID: 57O0pX12S3DDbFD27z9jLmbuGTRngG-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=686 clxscore=1015
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190071



On 12/19/2023 2:56 PM, Krzysztof Kozlowski wrote:
> On 19/12/2023 01:50, Tengfei Fan wrote:
>> Document the qcs8550 SoC and the AIM300 AIoT board bindings.
>> AIM300 Series is a highly optimized family of modules designed to support
>> AIoT applications. The Module is mounted onto Qualcomm AIoT carrier board
>> to support verification, evaluation and development.
>> AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Drop
> 
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 1a5fb889a444..a0e3cf271cfe 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -49,6 +49,7 @@ description: |
>>           msm8996
>>           msm8998
>>           qcs404
>> +        qcs8550
>>           qcm2290
>>           qcm6490
>>           qdu1000
>> @@ -904,6 +905,12 @@ properties:
>>             - const: qcom,qcs404-evb
>>             - const: qcom,qcs404
>>   
>> +      - items:
>> +          - enum:
>> +              - qcom,qcs8550-aim300-aiot
>> +          - const: qcom,qcs8550-aim300
>> +          - const: qcom,qcs8550
Need to add below line here, right?
+          - const: qcom,sm8550
> 
> Missing compatible. Please read previous discussions.
The previous comments was missed. Just double confirm here for 
"fallback" meaning here.

Could you pls also double confirm for my understandings for the 
compatible rules?
As long as sm8550 was designed "hardware compatible"(pin-to-pin 
compatible) and "software firmware compatible"(firmware also support 
sm8550) to qcs8550, it is request to add compatible sm8550 to current 
compatible sequence like: board/SOM/soc/base soc.

Note that, we don't really have hardware like "sm8550 inside aim300".
> 
> Best regards,
> Krzysztof
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

