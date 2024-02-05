Return-Path: <linux-kernel+bounces-52404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820EF8497A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3724F2853FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327C8171A6;
	Mon,  5 Feb 2024 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CVaoUzLs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95123168CD;
	Mon,  5 Feb 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128465; cv=none; b=Yn99nWtnwaJQ4VHWpOJFKBJQD/ctkNcJ8aJww2Bc/xklVs8WoauL6xcmL5X6pyMpv/GsMWO3C4G7Ms6TQoITPSCem90qpfHG12t2EV9YUDw60mRr2hgHpwrrLFotRMvzwKLcEjusXA1iFo5I/59qvYBHjtmcSSr+/qFSEAK60OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128465; c=relaxed/simple;
	bh=VLGzVaM3Mj7P+IEAuP2IoiJSDH9MT9MjxjQrm4VijZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P5Lt17XssUxVasIAFF8U5+AgNV6FcE9lDrPMX0Ggqu4GsKauLX6kbXd8hq5Q4woVvfpcY935unFpXso6EU4nsit90WtF29xTpzUb+n3XK9SqOpRtxiEkH5lv/JlTB73F8ztmvnBpayPr4mvwTnrGNZys5l0VXekng4Fg+L+8tAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CVaoUzLs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4158THM4011213;
	Mon, 5 Feb 2024 10:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HZNc3roTrbVrajfUeI29OzYVEwJSo8Id9bwqToV0jrI=; b=CV
	aoUzLsAMCBuf6gOiwNWjSpu+nj851vdPSp5fKdLleRIwv4brqG0BMxN/GPoeOOOc
	7T2/pD56sjm/DVsmGN89ipPrlv83EtIvHefOi/g5ibUvcUqIH2wUyBRRPCmY8Sy1
	wnnjxrAnVHwbxAcd3TH43M5uFRxzmIf/8ZWMvxDUo0R10N5eJ+xLSn0fgXvXDk1P
	+wdMnfq2JVsv34ArEKPfsnlAsXDAfyTWJy73XdiMqo10akBhKAFCIw6r5i2x+l4J
	DD81dx8bp6Ryg+HOiT/LgSEum8DBnOOODlRpExoY80qAN4yDcF0DRFe9Rbkwf9mf
	kbeSYcITzsHjQpDglsfA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2v728708-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 10:20:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415AKEUr002384
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 10:20:14 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 02:20:08 -0800
Message-ID: <86672501-206a-49ed-8af7-2b6c332c1697@quicinc.com>
Date: Mon, 5 Feb 2024 18:20:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: arm: qcom: Document QCM8550, QCS8550
 SoC and board
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-2-quic_tengfan@quicinc.com>
 <CAA8EJprpMjK03rKPK6wgfVuDvBikYsKZjMc0Wusa1BxFOBnXhQ@mail.gmail.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <CAA8EJprpMjK03rKPK6wgfVuDvBikYsKZjMc0Wusa1BxFOBnXhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yXgrD-41-EqAXm8DnK2zplpNBsoLxeTm
X-Proofpoint-ORIG-GUID: yXgrD-41-EqAXm8DnK2zplpNBsoLxeTm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050078



On 2/5/2024 12:29 AM, Dmitry Baryshkov wrote:
> On Fri, 19 Jan 2024 at 11:07, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>>
>> Document QCM8550, QCS8550 SoC and the AIM300 AIoT board bindings.
>> QCS8550 and QCM8550 processor combines powerful computing, extreme edge
>> AI processing, Wi-Fi 7, and robust video and graphics for a wide range
>> of use cases for the Internet of Things (IoT). QCS8550 is a QCS version
>> for QCM8550. Modem RF only in QCM8550 but not in QCS8550.
>> AIM300 Series is a highly optimized family of modules designed to
>> support AIoT applications. The module is mounted onto Qualcomm AIoT
>> carrier board to support verification, evaluation and development. It
>> integrates QCS8550 SoC, UFS and PMIC chip etc.
>> AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 1a5fb889a444..9cee874a8eae 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -49,8 +49,10 @@ description: |
>>           msm8996
>>           msm8998
>>           qcs404
>> +        qcs8550
>>           qcm2290
>>           qcm6490
>> +        qcm8550
> 
> Drop

we want to introduce qcm8550 here.

qcm8550.dtsi has been introduced and qcs8550-aim300.dtsi include 
qcm8550.dtsi directly.

qcs8550 is a QCS version for qcm8550. qcs8550 is a sub-series of 
qcm8550. qcm8550 will be a firmware release series from qualcomm.

here is the qcm8550/qcs8550 detailed spec: 
https://docs.qualcomm.com/bundle/publicresource/87-61717-1_REV_A_Qualcomm_QCS8550_QCM8550_Processors_Product_Brief.pdf

here is the sm8550 detailed spec: 
https://docs.qualcomm.com/bundle/publicresource/87-71408-1_REV_C_Snapdragon_8_gen_3_Mobile_Platform_Product_Brief.pdf

> 
>>           qdu1000
>>           qrb2210
>>           qrb4210
>> @@ -93,6 +95,7 @@ description: |
>>     The 'board' element must be one of the following strings:
>>
>>           adp
>> +        aim300-aiot
> 
> We probably need to drop this list, it doesn't surve its purposes.

I am a little confused, do you expect to just remove this "aim300-aiot" 
or do you want to introduce a new patch and remove the whole list?

> 
>>           cdp
>>           dragonboard
>>           idp
>> @@ -904,6 +907,14 @@ properties:
>>             - const: qcom,qcs404-evb
>>             - const: qcom,qcs404
>>
>> +      - items:
>> +          - enum:
>> +              - qcom,qcs8550-aim300-aiot
>> +          - const: qcom,qcs8550-aim300
>> +          - const: qcom,qcs8550
>> +          - const: qcom,qcm8550
> 
> In the review comments for v3 you have been asked to add qcom,sm8550.
> But not the qcom,qcm8550. I don't think that there is any need to
> mention qcm8550 here.

qcm8550 and sm8550 are different, they have different firmware release.

AIM300 AIoT board depend on qcs8550, qcs8550 is a QCS version for 
qcm8550. Modem RF only in qcm8550 but not in qcs8550.

> 
>> +          - const: qcom,sm8550
>> +
>>         - items:
>>             - enum:
>>                 - qcom,sa8155p-adp
>> --
>> 2.17.1
>>
> 
> 

-- 
Thx and BRs,
Tengfei Fan

