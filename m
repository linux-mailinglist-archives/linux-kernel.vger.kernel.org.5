Return-Path: <linux-kernel+bounces-103587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF7787C176
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FDE2B2138E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD76C74419;
	Thu, 14 Mar 2024 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PeTffSwR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D72E410;
	Thu, 14 Mar 2024 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434678; cv=none; b=uew5Lt+BOM0epkxUc2s2DNY7ApAeY9DCEgH/5+b2iiVXjikisnndV0jlSb17pdL3Jwyw9NC/XItAcPk83zwfG3OqVNBDmtYoSNCvOMgnoIlrfsJa7xpcqll55kpPDGfw3VP/qXmIxR7d7/nuGNAszZPG3wk5Amhm/unoUVneGg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434678; c=relaxed/simple;
	bh=X4ETqXGFr9Z6VXyiAGMaq+hLf7847MJEttp17fIvYFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bnAznqxMCM6E/J1dPuxcIQdXTbsXaKuAauJ4Ov34RmLeqF/+pE+qOKzbP7UBF6PlEY2UYRDg3AZxexEN+V4OAYnXs0jbI8PwpTqJVh/JS6dNKWUGo5ZftmPrl5sVLKXTHOBUsmp8OiOgXwix/g2BjXvB46N9RiEp6t02O9sC92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PeTffSwR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42EDerW3015388;
	Thu, 14 Mar 2024 16:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Fam0GzRMfK4d846fCu3OJ3/SnO4PS61b4OFyJFtygKo=; b=Pe
	TffSwR8V4J1WYv0G/OnO4Kxe/fMO/Kv3q5p3kO9kJH2057uY+BgqljKlcTjdggxQ
	niAoE4HVHikugaMIR4Hmqec3/5APNoo8KOG6eNX28DCPA7Ikba9AynUmfGQcNewA
	CR1i2W+XQh00DlmTI4bLbfvoZif0rHiVcD7lDo3+2IIN2UFg2FC2VPlDAUrGaIan
	XEtu7C+5jSe8ey5BxVf5d/4hRFM58MYYVGHrvw2yVHeVUhRuCijavOQX4Bks4x8b
	rQIQU7xK3lYKgP/RKO8DfYOZA6oJqkkfaPeumnoQK4aDn/nuXaJn27hXi6ejk3Wz
	l/wZC74hsuhBXX1too+A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuruqssgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 16:44:34 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EGiXrP007125
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 16:44:33 GMT
Received: from [10.216.10.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 09:44:30 -0700
Message-ID: <69a8c14c-109a-103a-b8dc-d8e303c0f0d5@quicinc.com>
Date: Thu, 14 Mar 2024 22:13:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8450: Add qfprom node
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1709727995-19821-1-git-send-email-quic_mojha@quicinc.com>
 <1709727995-19821-2-git-send-email-quic_mojha@quicinc.com>
 <45fcf8fb-9d9b-4e6a-a7c5-9bfb96875e64@linaro.org>
Content-Language: en-US
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <45fcf8fb-9d9b-4e6a-a7c5-9bfb96875e64@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eaVKVTF6if1RSJV9Su-aFo1J_5aNZ2hr
X-Proofpoint-GUID: eaVKVTF6if1RSJV9Su-aFo1J_5aNZ2hr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=854 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140126

Sorry for the late reply, was on vacation.

On 3/6/2024 9:24 PM, Konrad Dybcio wrote:
> 
> 
> On 3/6/24 13:26, Mukesh Ojha wrote:
>> Add the qfprom node for sm8450 SoC.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi 
>> b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index b86be34a912b..02089a388d03 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -4575,6 +4575,13 @@
>>               };
>>           };
>> +        qfprom: efuse@221c8000 {
>> +            compatible = "qcom,sm8450-qfprom", "qcom,qfprom";
>> +            reg = <0 0x221c8000 0 0x1000>;
> 
> Is is really only 0x1000-long? Also, is the base you put
> here the ECC-corrected part (if that still exists)?

No, its not.

Entire fuse space is this.
0x221C0000-0x221Cbfff

ECC corrected range is this 0x221C2000-0x221C3fff and High level OS
does have a access to ECC range however, they are not recommended for
SW usage.

Above mentioned SW range(4) in the patch is  one and only accessible 
range available out of 0-7 SW ranges(0x221C4000-0x221Cbfff with each
size 0x1000) and does not have ECC fuses.

All the downstream use cases are getting fulfilled with this.

-Mukesh

> 
> Konrad

