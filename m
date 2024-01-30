Return-Path: <linux-kernel+bounces-44041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7B8841C89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2879B283722
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE144524AC;
	Tue, 30 Jan 2024 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZubvYpTB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D344C610;
	Tue, 30 Jan 2024 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599544; cv=none; b=Yz1KVHyvrNpWHi5nvHjAzN0fcOGDCXqKBoQL0QmzukcEeIn5jVUXe78RlYm+Z3yJcnj72qAxyX46RGow5nx/+YWVw984eJNJKF8WHnH7sqjnIuANOuaJD+UrTbhxToz4RUw2lDSD3/BKBdIkGXdQsTNqjQv1J3MT35TJBWje938=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599544; c=relaxed/simple;
	bh=MRA41ka2nVnCbPPGCvn7oFWP5clgArfJ49C9bC+V1/c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=TGVV5Jer0Y6toqtAEorPp9R1+DajX55oXFsLuRyrCy8OnDWrqHCwTLplIVE6COEHjPjMygsstzfWhWFpCFcunABXP97HcyTyoAd6LtUHt0wtXB/cysQwIXTRqMD/8lFLVx8UUd3N/7Wafq3aag90WnSM13G9s7a1FcbEhgPQJoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZubvYpTB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U58bYQ019343;
	Tue, 30 Jan 2024 07:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oTne4YMLOus8vGIzuyLPoBXkJ+ZLYaFNZ+RfBayVdyk=; b=Zu
	bvYpTB4kwNwB0/Kwja0fxCcrr7UrA6OAM2q6cEBk2WBg/FtIPVvTPftDry5lDKS3
	D6C6Tuiqjeqy4HR4UlBxZb32xdqXUZWt3PCxaiqFHe3ouoXPGYGB4lGIdE1EAT2b
	t3gwvtLI+JVG2SsBr8LQsuncYkiWPHoDYv3Jvk+GMdtSSNTmDPRZ9ajToVjfjoQq
	HevosAsMK8/24dCFgDWQ57gYcrerU29DanZYFwvtgOOFxahKCQyeDVO1HZxgu/lD
	2aXlGxJrPwiwrJO0j7o5wrxrJJ132FWkIQTFtwgCpZ4Y58qYDbo2fjaa4NTbXILX
	o1Q9BTFKvUtAjn5nRqKg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxtp30705-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 07:25:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U7PYiF017742
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 07:25:34 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 23:25:29 -0800
Message-ID: <c17dafd2-db89-4fe2-8e98-2a031f7237c2@quicinc.com>
Date: Tue, 30 Jan 2024 15:25:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: aim300: add AIM300 AIoT
From: Tengfei Fan <quic_tengfan@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dmitry.baryshkov@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Qiang Yu
	<quic_qianyu@quicinc.com>,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-7-quic_tengfan@quicinc.com>
 <d3ef45cf-2de8-4f5b-8857-62d1996f3f58@linaro.org>
 <842bf6ad-46e1-43d8-86be-79ab0f49710b@quicinc.com>
In-Reply-To: <842bf6ad-46e1-43d8-86be-79ab0f49710b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ue10aO-2c8EtjIE0C8dO9fOw6FOoVxOi
X-Proofpoint-GUID: ue10aO-2c8EtjIE0C8dO9fOw6FOoVxOi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_02,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxlogscore=361 malwarescore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300052



On 1/29/2024 4:18 PM, Tengfei Fan wrote:
> 
> 
> On 1/29/2024 4:09 PM, Krzysztof Kozlowski wrote:
>> On 19/01/2024 11:06, Tengfei Fan wrote:
>>> Add AIM300 AIoT board DTS support, including usb, serial, PCIe, mpss,
>>> adsp, cdsp and sound card functions support.
>>>
>>
>> ...
>>
>>> +
>>> +    sound {
>>> +        compatible = "qcom,sm8550-sndcard", "qcom,sm8450-sndcard";
>>> +        model = "AIM300-AIOT";
>>> +        audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
>>> +                "SpkrRight IN", "WSA_SPK2 OUT",
>>> +                "IN1_HPHL", "HPHL_OUT",
>>> +                "IN2_HPHR", "HPHR_OUT",
>>> +                "AMIC2", "MIC BIAS2",
>>> +                "VA DMIC0", "MIC BIAS1",
>>> +                "VA DMIC1", "MIC BIAS1",
>>> +                "VA DMIC2", "MIC BIAS3",
>>> +                "TX DMIC0", "MIC BIAS1",
>>> +                "TX DMIC1", "MIC BIAS2",
>>> +                "TX DMIC2", "MIC BIAS3",
>>> +                "TX SWR_ADC1", "ADC2_OUTPUT";
>>
>> This should be probably TX SWR_INPUT1.
>>
>> Best regards,
>> Krzysztof
>>
> 
> I will double check this with related team and I will update this.
> 

I will apply "TX SWR_INPUT1" on audio-routing node in the next patch 
series.

-- 
Thx and BRs,
Tengfei Fan

