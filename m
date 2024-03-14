Return-Path: <linux-kernel+bounces-103040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046DE87BA43
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2814C1C232A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7116CDB6;
	Thu, 14 Mar 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GRMeVH/T"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8446A2;
	Thu, 14 Mar 2024 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407994; cv=none; b=jiREstPZolYNEjg2VqY82t/cGT1s9MlKGwV19COQi5ixXBnMPami3VGa4rG7CKC1dejnpS6ym9a8rZyGfkx3dvEZiOIww/lfjyYnxahmGcgBMZRjs1j9PIoMUltkrhcayjtggwZIu0exgJcDEl/XDa6VRHVOqEo/pQ8fkCQz7Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407994; c=relaxed/simple;
	bh=CP1u2noOUsBFRb5fpWhhNZQ29Fcuc9a2yVFDxFUdOdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KESsQcZMA2csXSasPNYaX4nx0ng2LyNWRBvTSrxr/u7/zc5p+uruOPtdu72t6OFqExadnaFr+Dicz8CFAISpPMq5Kk0jnvrzvZPRhHlXlfqcBb/+5pxIQ6+dpLd3utlHi/sd2UvUpXzgLp8NT0hpsNJCfprDJzfoqlPYiJzVSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GRMeVH/T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E4NGOr027956;
	Thu, 14 Mar 2024 09:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mgXw84NhW/F9M48Q9bgUvSF8HTOLcYB3vZ4Nsk4Zvaw=; b=GR
	MeVH/TEMIYS/XS8KQYInBQZ9gWXoDyd10BbXwMUA8OvRzh3+t+TwVstjjcIMdv+M
	WD2M+QAhd1pfmd3rjGk3mNmYqXMK1tH4sFtFy4HyjVce9NzkGDn8WRZVZDyITQCF
	izJAbanIaihWj4M5hkr7Ujjv8ftDc8M2f8jF5GclHnu8bY32IOBNqtdDfYvGL65u
	Cac3N3yt0D4HSyyy7MiPDvgs8TO6z2tiz4FH/wUw0FMP3LFrCIpc80O0RXxagRx+
	AAo4L/vW7SbK4sU5iepKw7/9QrT0V4anXV50NsJLH64uQthUdltLYLr9COsOcjQv
	j2I2Sos61E+4QRaGfgaw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu9xattxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 09:19:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42E9JlFA032641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 09:19:47 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 02:19:41 -0700
Message-ID: <a09941ff-7b43-a964-1bd1-5321913be1a3@quicinc.com>
Date: Thu, 14 Mar 2024 14:49:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom: Update SM8150 videocc
 bindings
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh
 Kona" <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com>
 <20240313-videocc-sm8150-dt-node-v1-1-ae8ec3c822c2@quicinc.com>
 <CAA8EJpo63oRA07QNCdzJdHW_hJJWK6aj-LCpp-XwmPJYf0twZw@mail.gmail.com>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <CAA8EJpo63oRA07QNCdzJdHW_hJJWK6aj-LCpp-XwmPJYf0twZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eiZAt_OjynmwNLLB_loT5Cf7i1fNla2n
X-Proofpoint-GUID: eiZAt_OjynmwNLLB_loT5Cf7i1fNla2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_07,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=918 mlxscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403140064


On 3/14/2024 12:50 AM, Dmitry Baryshkov wrote:
> On Wed, 13 Mar 2024 at 13:11, Satya Priya Kakitapalli
> <quic_skakitap@quicinc.com> wrote:
>> Update the videocc device tree bindings for sm8150 to align with the
>> latest convention.
> But why? Bindings already exist. There is nothing wrong with them. And
> sm8150 platform in general uses name-based lookup.


With the new index based lookup introduced we cannot use this bindings, 
hence I moved to the sm8450-videocc bindings.


>> Fixes: 35d26e9292e2 ("dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings")
> It is not a fix, there is no bug that this commit is fixing.


The clocks list needs to be fixed to add both XO and AHB clocks, and we 
are adding required-opps property.


>> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml | 1 +
>>   Documentation/devicetree/bindings/clock/qcom,videocc.yaml        | 3 ---
>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> index bad8f019a8d3..e00fdc8ceaa4 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> @@ -20,6 +20,7 @@ properties:
>>       enum:
>>         - qcom,sm8450-videocc
>>         - qcom,sm8550-videocc
>> +      - qcom,sm8150-videocc
>>
>>     reg:
>>       maxItems: 1
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
>> index 6999e36ace1b..28d134ad9517 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
>> @@ -17,7 +17,6 @@ description: |
>>       include/dt-bindings/clock/qcom,videocc-sc7180.h
>>       include/dt-bindings/clock/qcom,videocc-sc7280.h
>>       include/dt-bindings/clock/qcom,videocc-sdm845.h
>> -    include/dt-bindings/clock/qcom,videocc-sm8150.h
>>       include/dt-bindings/clock/qcom,videocc-sm8250.h
>>
>>   properties:
>> @@ -26,7 +25,6 @@ properties:
>>         - qcom,sc7180-videocc
>>         - qcom,sc7280-videocc
>>         - qcom,sdm845-videocc
>> -      - qcom,sm8150-videocc
>>         - qcom,sm8250-videocc
>>
>>     clocks:
>> @@ -75,7 +73,6 @@ allOf:
>>             enum:
>>               - qcom,sc7180-videocc
>>               - qcom,sdm845-videocc
>> -            - qcom,sm8150-videocc
>>       then:
>>         properties:
>>           clocks:
>>
>> --
>> 2.25.1
>>
>>
>

