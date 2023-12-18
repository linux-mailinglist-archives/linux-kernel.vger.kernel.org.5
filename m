Return-Path: <linux-kernel+bounces-3049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04625816697
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCBD282934
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20486FBD;
	Mon, 18 Dec 2023 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dRM4QHdJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640D6FA4;
	Mon, 18 Dec 2023 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI3ou2Z029401;
	Mon, 18 Dec 2023 06:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gayK+sHDuUi4o6C3Z7Bj9qdwZbNscH6MTD5VsMa+pSg=; b=dR
	M4QHdJRWL3ROJqkFh1BvHSQa/gHZHBLJ7DHqLqvv1RbiiW0BZAzXtqexOwVtSa1R
	CEiFQuL7EBHQuedOUEywl1cmxOj0w8KCOZAIIFFR9kmsimaTyl98+kbHDwpql0Az
	Jb/P7gsGmSnfwV3ejLjg9tpjG7ONWinIaoHhA4YSfokUXVTkcrUsAOVM5fw8fkJS
	9OoW2QyMsS6JwAqzFto/uAleSwP8LTc1RvxMFWBynpFaYrT+lNtsN674OTlKTj5/
	VxF5LxXcr88CYVDQtRaEfUARzWeY6WTz4hCjKLJMIt6x9KwqFAhwGDVYqw9OJo0W
	alOy7VNzVcO+qP7xkmSA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v1536uht0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 06:37:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI6beST017254
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 06:37:40 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Dec
 2023 22:37:33 -0800
Message-ID: <2ef44a36-7895-4562-bac6-703e5fb9c17a@quicinc.com>
Date: Mon, 18 Dec 2023 12:07:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
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
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <qipl.kernel.upstream@quicinc.com>
References: <20231215101827.30549-1-quic_bibekkum@quicinc.com>
 <20231215101827.30549-6-quic_bibekkum@quicinc.com>
 <3c7b8c2c-7174-4ced-8954-5a249f792c1e@linaro.org>
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <3c7b8c2c-7174-4ced-8954-5a249f792c1e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xttuK34oYhnfq3L0-gxFPOTsBLsRZ7L2
X-Proofpoint-ORIG-GUID: xttuK34oYhnfq3L0-gxFPOTsBLsRZ7L2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180046



On 12/16/2023 5:24 AM, Konrad Dybcio wrote:
> On 15.12.2023 11:18, Bibek Kumar Patro wrote:
>> Default MMU-500 reset operation disables context caching in
>> prefetch buffer. It is however expected for context banks using
>> the ACTLR register to retain their prefetch value during reset
>> and runtime suspend.
>>
>> Replace default MMU-500 reset operation with Qualcomm specific reset
>> operation which envelope the default reset operation and re-enables
>> context caching in prefetch buffer for Qualcomm SoCs.
>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
> This probably deserves a fixes tag, but I can't find a good commit for
> it, so I guess not having it is fine as well.
> 

I was also trying to find any suitable commit, but this default reset
implementation didn't have a separate commit, so did not add any fixes
tag here.

> Also, since it seems to be independent from the rest of the patches, please
> reorder it to become patch 1 in the next spin, so that it can perhaps be
> easily picked up independently of the rest.
> 

Sure, agree on the same. Will keep this as 1st patch, and start the rest
of the patches on top of it.

>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 23 +++++++++++++++++++---
>>   1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index c8f5dd4186b7..70d2a5d43993 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -516,11 +516,28 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>>   	return match ? IOMMU_DOMAIN_IDENTITY : 0;
>>   }
>>
>> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
>> +{
>> +	int i;
>> +	u32 reg;
> That's rather nitty/codestyle-y, but:
> 
> - reverse Christmas tree would be nice (it's in a week! :D)
> - "reg" to me sounds like "register address", "val" is used widely for
>    register values
> 

Thanks for pointing to this, will take care of this val name and
sorting in next version.(Will try to post the reserse xmas tree sorted
patch asap for the xmas celebration! :) )

>> +
>> +	arm_mmu500_reset(smmu);
> We should check the return value here, in case the function is modified
> some day in a way that makes it return something else than 0
> 
> LGTM otherwise!
>

Thanks,
Bibek

> Konrad

