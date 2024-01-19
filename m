Return-Path: <linux-kernel+bounces-31009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E3083277E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C841DB221FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15DA3CF60;
	Fri, 19 Jan 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pXzz3agU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C603CF57;
	Fri, 19 Jan 2024 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659163; cv=none; b=Qhi9jlz3vBnQ+y9pLp3CPqg4LfVCnJTWX2xAWaVLzOp+AN4EMvy3AZ/mRJshIzZ6tqGA3kl2VyhXK1liauiz9WUy+Bi2IrTjX4FAB3RW7v2DXRwFBzcjXW6AXZiEPiZMazNGx8k5hsQ475BDlk9EYKIx8Ayd6m86ar4bE8V46sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659163; c=relaxed/simple;
	bh=HuEMCJS9G0VJ8qDiv6qy19PqibIaS3UKkvvAZAJp5No=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gyQtpYISvwoUYALO6Ur27gje0jKDKaieXF8u2H+qHG86X3OAfVbvsCy0eHsElopnBOPINF1JgRMoJYb4O6QUiDWakxx0ndKkVIoPtUlwdkMVy1fxCVREWfOuyI4EbAIGS1CHYgPnt9+7Ccd39b4gw/SSgJKCbsPg+pVQALyDqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pXzz3agU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J8gi4I021328;
	Fri, 19 Jan 2024 10:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=U7EBF2ywQsmJhbqBYQAuBlZReDesIt1cR6QYeVj2qDU=; b=pX
	zz3agUjyGjr0eUj/sFep1xt9BIbVn2y+9rZldpYKXAKGkTFbf3smNecKL6cRyJkF
	/IT7qHDifSLCrnOy18uIjLPnNzBYfN/+JDHTjdxWQKW9HrIsvCMLRN0Y4YbjdG0z
	hxBi+siMwTk3Wxe/n6EJj0oMjJcKkw1knEc6fC0jGCVFPf3ngyhAv53GAC6Kiqpy
	ONGFZ966DtfYadqLBKfmA5eTVnFgVA3IR3Z6rOB5PnhiNNzY8l65sGAh+GppXFuf
	x5ODX87ZzuQYMy5WMPCF0JHeGifodl+ft630xaMWtVNEha6LCKefXJCzlP1eYTCl
	XzduEUp0+8sfWX3Aq0pg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqn89g7wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:12:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40JACMed005039
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 10:12:22 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 19 Jan
 2024 02:12:16 -0800
Message-ID: <d2cf0179-03d4-4766-b93e-f29e284e1048@quicinc.com>
Date: Fri, 19 Jan 2024 15:42:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <jsnitsel@redhat.com>,
        <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240116150411.23876-1-quic_bibekkum@quicinc.com>
 <20240116150411.23876-5-quic_bibekkum@quicinc.com>
 <7d012b9f-b1ca-4633-8dc2-03d90c418e7d@linaro.org>
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <7d012b9f-b1ca-4633-8dc2-03d90c418e7d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: A6zI8AaFwg0jpvyWzYPvukxFto6Y1_IC
X-Proofpoint-ORIG-GUID: A6zI8AaFwg0jpvyWzYPvukxFto6Y1_IC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=912 clxscore=1015
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190044



On 1/18/2024 11:28 PM, Konrad Dybcio wrote:
> 
> 
> On 1/16/24 16:04, Bibek Kumar Patro wrote:
>> Add ACTLR data table for SM8550 along with support for
>> same including SM8550 specific implementation operations.
>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
> 
> [...]
> 
>> +static const struct actlr_variant sm8550_actlr[] = {
>> +    { .io_start = 0x15000000, .actlrcfg = sm8550_apps_actlr_cfg,
>> +            .num_actlrcfg = ARRAY_SIZE(sm8550_apps_actlr_cfg) },
>> +    { .io_start = 0x03da0000, .actlrcfg = sm8550_gfx_actlr_cfg,
>> +            .num_actlrcfg = ARRAY_SIZE(sm8550_gfx_actlr_cfg) },
>> +};
> Just a nit again, but if struct definitions need to be wrapped, this looks
> better:
> 
> {
>      .io_start = 0...,
>      .aclrcfg = ...,
>      .num_actlrcfg = ARR..,
> }, {
>      .io_start = 0..,
>      .aclrcfg = ...,
>      .num_actlrcfg = ARR..,
> };
> 

Noted, will wrap this to keep each member in a new line as shown.
This looks much cleaner. Thanks for this suggestion.

Regards,
Bibek

> Konrad

