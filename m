Return-Path: <linux-kernel+bounces-103026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F91087BA15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E6B1F239CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A556BFB7;
	Thu, 14 Mar 2024 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GcuPoVlo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B79EEC4;
	Thu, 14 Mar 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407605; cv=none; b=aeSXeHTzC1Np44UdpQO03vl3DeK4/1U/Ya/LROAOGE2LohpNBVHMOhmrMOkURMh8Uv6CRPne32y9MSzWBMOG1n5I3Q2Aypvlw4U/nInkhJaIgC/b/PW9lMqNMWMghkaRXZ+NfQb/u5zbOEYqLtpEBbtbv7GjpUxbBeZwCoJcQp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407605; c=relaxed/simple;
	bh=BgurNZq4ZEkhsrJqAie62GBHUDuak0mFgu1fBlM7rZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KnmnT+rv7h9kUGmxRyNh+FkNigN2w3SrhcDQ0+v3F3IDF7Km7rGzCIfgm6X1cSpUYfubX4DRA/UsH18nqgup0U3fraP6YVa90tFM0XcATAgrcDoA5GHcRdfkq2wvPcN1tomjQ0yvqaQDA7opbYpJR0Vyc+OTzoKdnhYHCyz8ows=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GcuPoVlo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42E5GeU3021620;
	Thu, 14 Mar 2024 09:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hHnHHxoibt7V1jPUG53jjF/kyVu5rUCZMOCFak+vHhg=; b=Gc
	uPoVlo5PBjUpGBtECuLFXYYJM0GTUcENFXCRpTSXbKJmehc8LKzHeTBk+BmbUWfD
	PKJZFr4Dvgr8vsIiZOlJx8lg/yBDNA1KAOIGfGkBpRebwWEt2ThClAXWMhUNfH9A
	OYyRnzj85UllH6mphVKJjfLvEea/EMW3nX6duMgFyEoJNL9v+pdfu80/PcE+J4rh
	WAKx0hBhErNXL1AX48fPsufFA+qb3TA3TlKrSeDALT3QfB/TPjC59IOHRkUWcf1X
	WNqsTQZBmawOwUcMN4B3KGa2lTiVmw39bcX8n+1r7972CuSQVgRwS3ys4zgW65nf
	MtQ0fJERPY1ZI9cGYM1Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wugq19tgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 09:13:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42E9DIut024475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 09:13:18 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 02:13:12 -0700
Message-ID: <a69f6dda-f488-a1be-803d-258fb8c6cb7b@quicinc.com>
Date: Thu, 14 Mar 2024 14:43:09 +0530
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh
 Kona" <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com>
 <20240313-videocc-sm8150-dt-node-v1-1-ae8ec3c822c2@quicinc.com>
 <e8037775-78cf-4d18-9f8b-9dc5f497ad14@linaro.org>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <e8037775-78cf-4d18-9f8b-9dc5f497ad14@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2Ih2D024hcpEwhSu3KL4vgBCWXaBshrV
X-Proofpoint-GUID: 2Ih2D024hcpEwhSu3KL4vgBCWXaBshrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_07,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140062


On 3/13/2024 10:21 PM, Krzysztof Kozlowski wrote:
> On 13/03/2024 12:08, Satya Priya Kakitapalli wrote:
>> Update the videocc device tree bindings for sm8150 to align with the
>> latest convention.
> Everything is an update. Please explain what you did and why. The "why"
> part you tried to cover but I just don't understand what is "align with
> the latest convention". What convention?


As per the recent upstream discussions, it is recommended to use 
index-based lookup instead of using clock names. The current bindings is 
not aligned with this, hence updating. I'll add the details to commit text.


>> Fixes: 35d26e9292e2 ("dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings")
> What is the bug being fixed here?


There are 2 clocks required for this, AHB and XO. Only one clock is 
mentioned in the bindings for SM8150, this is one of the reasons to move 
to latest sm8450 bindings apart from clock names. Hence added a Fixes tag.


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
> Wrong order. Look at the place from where you copied it.


Sure, will correct it.


> Best regards,
> Krzysztof
>

