Return-Path: <linux-kernel+bounces-50268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA9384769A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD2928697F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A6014AD24;
	Fri,  2 Feb 2024 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UxJu2BVf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D9168B9;
	Fri,  2 Feb 2024 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896178; cv=none; b=GAEO9/guA8TxnyAffTF7ikPxN+WdEm3YFWU/9gxf3vDsBY8GdH0ZXMOLP4DFtOFZyB4UI7W5V9Uh2YgDfeLpurVLhb6hwjaP7s0NBNM7gMzwI/8pIM1MoiBZJFTw3G8Vf6cKIrumjXAc2n4d9JWzuwQ4jpuN/x6Ih3Ah1PUHMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896178; c=relaxed/simple;
	bh=ORUBZj9VbJrS+6YnsNZ+Hq1I3Z9kACZ53vfnC6z1j6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=naks1ljI9+daVPefYn33BRXN4Ik6eSFqFH3i0QUtB4eTkuVjMfnFnQQZ+4OKIx/v5WBJ2tHUJ1ZyPqyfQM/qogkhWBBoQtcxcAIdzcIBUAEfSQ2xPQJtQq6ISh3IR31sj1EooKcxgPl2VggnFzqAyiVfKajPNIUE6eTXoh5VOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UxJu2BVf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412B5I9j003316;
	Fri, 2 Feb 2024 17:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oDjf0Uy4yNJyMguYyjd0ZF+yN77D94FizZdVWHnKdZ8=; b=Ux
	Ju2BVf+IR5KBBoGt0+JaQALT4a2O7Xy0Vf/hm1XJfccC00RvoOTEmrXRSDhd3jCL
	xWrVCY9BwcIupl9QlU/Ko+PICCcbRbjvfB/7k9sR+hoT2C9PKcMXZY6jzWdZyMgZ
	0o7B5GmHg2OI60jOPrmtnUK0F6SBrW6s9ZUQZwzeuZWIED7TuapKDQBeEyXO1HTn
	CY90RjN724QauLDBdC66lMGoN1Fy+pGg+H1K46eGVFz4FgfIQ2WkNXqvwCdDs0Tt
	aGb/rh2OTtl2d6ydA6Fw15pYS66Ypn93hrVxrkZ90sQj8NyqisUvppfWZfUqw5fh
	v2HCb908A0CHkHSp5utw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwc20h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 17:49:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412HnWKs001766
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 17:49:32 GMT
Received: from [10.110.0.40] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 09:49:31 -0800
Message-ID: <4a9b6d7b-70ab-cd18-770c-37993b0ccc63@quicinc.com>
Date: Fri, 2 Feb 2024 09:49:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: Add qcom,pbs bindings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC: <konrad.dybcio@linaro.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <20240201204421.16992-2-quic_amelende@quicinc.com>
 <20240201204421.16992-4-quic_amelende@quicinc.com>
 <1de7cfbc-3507-459f-842e-c9349b2f05ac@linaro.org>
From: Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <1de7cfbc-3507-459f-842e-c9349b2f05ac@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1RG0hPmpTWbv0d2sxE46VFefcLvl8srb
X-Proofpoint-ORIG-GUID: 1RG0hPmpTWbv0d2sxE46VFefcLvl8srb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_11,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=438 clxscore=1015
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020128



On 2/1/2024 11:29 PM, Krzysztof Kozlowski wrote:
> On 01/02/2024 21:44, Anjelique Melendez wrote:
>> Add binding for the Qualcomm Programmable Boot Sequencer device.
>>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> How is it possible? This is v1, not a resend, and I never give review
> tags not in public.
> 
> Best regards,
> Krzysztof
> 
Sorry for the confusion, this patch was originally in this series:
https://lore.kernel.org/all/20231221185838.28440-2-quic_amelende@quicinc.com/,
where you gave your reviewed by tag in v3:
https://lore.kernel.org/all/102328fa-5699-4731-d639-079bce8863a5@linaro.org/.
This was separated into a new series since half of the original
patches were already applied. I mentioned this in the cover
letter but in future should I keep version the same as the original
series?

Thanks,
Anjelique

