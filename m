Return-Path: <linux-kernel+bounces-124147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A66891300
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58DE7B23A46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31863C068;
	Fri, 29 Mar 2024 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JAmhu/UQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1F53BBE7;
	Fri, 29 Mar 2024 04:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687984; cv=none; b=TqwNJ/14I1RNYJ/KsNOpyDJF9Fg+Tpxg/qdd8rvlU+mPMq/TGdslZPu5ufTWd1MlAsaT5W3CTH5E2eXksErXLYgWAnmcBk3C9RfNlRoBol8QQxO2iRhHMGtLbKQvR1u2anQ+RbobdwNmCNZNvszn2ymmg7NxzH7/eBMgY1KauxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687984; c=relaxed/simple;
	bh=wLGfAPWKXVpxSgIMKoReYsUkio66paCqJj9/69GyG9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BdUfc3WgIbcacA2SFjW9gaD/2w4sH3JaamyAl0Eq2xbvhGtF1u+NN9RPauCrsyw7aRnBc4H6h4bNw2XAlxKFmdhBgZ2o23yIxV1cP5nfldz3tyz8VNlDfYEhII9MGWXfcX0WVZVd4Qj+fmeKoAHm5vBilRHFlkn6cTh5hzG/6ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JAmhu/UQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T4kM2D010584;
	Fri, 29 Mar 2024 04:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=S+GCcASrxJq76sRMrKUGLRDKIKYjXFT1jdsvjPx0vwI=; b=JA
	mhu/UQK4G8m7c9589X7yAY80nqYMss8AGCLTpiEK3Xan5eYVmjgRd6pea2vWqSC0
	D7ag/WoYKB/yrjb5pEd/MRkrmUKeAdeos6BFQ5d7bF/wzn3gaGbOju1n4lKH0cLx
	8Q4pXaoB/JiJpza2PreYEAIjMfeG6t+0TGzGi4KdiPbQIeyWj7KMjtgWeXJMPeEs
	8x1FRc8KxC9Q8jIYZ5wIKmGv0iy1qFlv+1ZJNreQXXEOzzm2sBGoT/Gf5XW0S1+z
	g7RzBhMNHnezln2CsMHx5o1LlaAg9cF9rfGvYDgwsmxbQ9J3YPrtSAsJbcbxc+ic
	yxQp9EG4+5X133ISm53w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5fs88tqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 04:52:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T4qtSf012819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 04:52:55 GMT
Received: from [10.216.16.39] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 21:52:52 -0700
Message-ID: <629a2983-8db4-4ae0-8f68-72750985d5b3@quicinc.com>
Date: Fri, 29 Mar 2024 10:22:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
CC: Caleb Connolly <caleb.connolly@linaro.org>,
        "andersson@kernel.org >> Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML
	<linux-kernel@vger.kernel.org>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
 <19bb6ff0-04ff-4e88-8c8a-499c054bdea4@quicinc.com> <87sf0axanc.fsf@epam.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <87sf0axanc.fsf@epam.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dx0Qi2HUMurn-Om-psDQk0AKtsoLxGrB
X-Proofpoint-ORIG-GUID: Dx0Qi2HUMurn-Om-psDQk0AKtsoLxGrB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_03,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=990 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290037



On 3/29/2024 3:49 AM, Volodymyr Babchuk wrote:
> 
> Hi Maulik
> 
> "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com> writes:
> 
>> On 3/28/2024 1:39 AM, Volodymyr Babchuk wrote:
>>> It appears that hardware does not like cacheable accesses to this
>>> region. Trying to access this shared memory region as Normal Memory
>>> leads to secure interrupt which causes an endless loop somewhere in
>>> Trust Zone.
>>
>> Linux does not write into cmd-db region. This region is write
>> protected by XPU. Making this region uncached magically solves the XPU
>> write fault
>> issue.
>>
>> Can you please include above details?
> 
> Sure, I'll add this to the next version.
> 

Thanks.

>>
>> In downstream, we have below which resolved similar issue on qcm6490.
>>
>> cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WC);
>>
>> Downstream SA8155P also have MEMREMAP_WC. Can you please give it a try
>> on your device?
> 
> Yes, MEMREMAP_WC works as well. This opens the question: which type is
> more correct? I have no deep understanding in QCOM internals so it is
> hard to me to answer this question.
> 

XPU may have falsely detected clean cache eviction as "write" into the 
write protected region so using uncached flag MEMREMAP_WC may be helping 
here and is more correct in my understanding.

This can also be included in commit message.

Thanks,
Maulik

