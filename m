Return-Path: <linux-kernel+bounces-63093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A775F852AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D114281E31
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F0229CEC;
	Tue, 13 Feb 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D5/aIync"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2EB286B3;
	Tue, 13 Feb 2024 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812287; cv=none; b=QQQV+5ttONGZ8/WsppBX/TXd6nbU3sluHGxaN5QMwAQ66q93AT0ArhZ98bfpME+PHPpmOyClbUbH0s2LJO+VRiSRLnDp/zWFOVdNZEVF289oos7PX1YwrC1Bx900J9PmWGW1MCrUGqGeXrD5fWK11hlk8hJbWrCb00r0Y9QuDug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812287; c=relaxed/simple;
	bh=H5tk7A4bfY+JAigsJktni+BUbROwql+zPc9UW2KH6dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uMT9ooFzJylerW1CYwPN4D6pQo82Jxcpre+iz+eDN5J5139e458puT1wz7A1uqO9c13bJ4SC9J9zP7M+17qzrMof1Iak8BE8ROT/AVgTzAF/m75oE7mOK8dfvcFP+bXWinqIy1/J9R/o9QXe9iNzi5YYnm9s30fVmMNgyKd6Mls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D5/aIync; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D7WfDP022653;
	Tue, 13 Feb 2024 08:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iZUS6Avy7ObEdkigZ/4tAp8qc2aWyi1mNik6pmtJqH8=; b=D5
	/aIyncPlaqJKZXq/uL2ufkYxJcY1TvAvYsK39nmNi1fLEw7PmS35adTYoCLySb8F
	cwwShfCBWuqw6TBsMU2tlGhmXanMnGsIVrrEx8LXhwkIxa8zlkLYV10fR728wbaC
	gZu/dMLDafwj/26oR2GExSiAbUAAOYqN0mlpVH9NHgEqT/KlE3Rv+fghpXiTr7st
	xVIJHsciCwKtNmzPoex7TyPAVTrKSFGM4U4R8czcjl4e4QqKujmRfKxHmfqTWAdk
	lFffQ+G5bcLHbu24jhNqy1mtb3QdbRiu8gJ9DErKKPhQV411fRXuBeN3MoZcNc2o
	7iJlaEUyoaKDxIqCq2/w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8448r2b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:17:52 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D8Hpas007157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:17:51 GMT
Received: from [10.214.25.202] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 00:17:43 -0800
Message-ID: <ccb6b2a2-040b-46cc-9b72-2e4bd4c75565@quicinc.com>
Date: Tue, 13 Feb 2024 13:47:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/arm-smmu-qcom: Fix use-after-free issue in
 qcom_smmu_create()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <quic_c_gdjako@quicinc.com>, <andersson@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <djakov@kernel.org>,
        <iommu@lists.linux.dev>, <joro@8bytes.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cgoldswo@quicinc.com>, <quic_pdaly@quicinc.com>,
        <quic_sudaraja@quicinc.com>, <quic_sukadev@quicinc.com>,
        <robdclark@gmail.com>, <robh+dt@kernel.org>, <robin.murphy@arm.com>,
        <will@kernel.org>
References: <20240201210529.7728-4-quic_c_gdjako@quicinc.com>
 <20240213062608.13018-1-quic_pbrahma@quicinc.com>
 <CAA8EJpoh-m_fzt9WcUXOkTxVZRQMDf-WrgqqoM0C_-qzjgDm1w@mail.gmail.com>
Content-Language: en-US
From: Pratyush Brahma <quic_pbrahma@quicinc.com>
In-Reply-To: <CAA8EJpoh-m_fzt9WcUXOkTxVZRQMDf-WrgqqoM0C_-qzjgDm1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E8HABBGpe90ZckuLynaPQmD2JWHJUBNe
X-Proofpoint-GUID: E8HABBGpe90ZckuLynaPQmD2JWHJUBNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402130064


On 2/13/2024 1:36 PM, Dmitry Baryshkov wrote:
> On Tue, 13 Feb 2024 at 08:27, Pratyush Brahma <quic_pbrahma@quicinc.com> wrote:
>> Currently, during arm smmu probe, struct arm_smmu_device pointer
>> is allocated. The pointer is reallocated to a new struct qcom_smmu in
>> qcom_smmu_create() with devm_krealloc() which frees the smmu device
>> after copying the data into the new pointer.
>>
>> The freed pointer is then passed again in devm_of_platform_populate()
>> inside qcom_smmu_create() which causes a use-after-free issue.
>>
>> Fix the use-after-free issue by reassigning the old pointer to
>> the new pointer where the struct was copied by devm_krealloc().
>>
>> Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
> Missing Fixes tag.
Haven't added as the patchset in-reply-to hasn't been merged to 
linux-next. Please refer my next reply.
>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> index ed5ed5da7740..49eaeed6a91c 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>> @@ -710,6 +710,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>>          qsmmu = devm_krealloc(smmu->dev, smmu, sizeof(*qsmmu), GFP_KERNEL);
>>          if (!qsmmu)
>>                  return ERR_PTR(-ENOMEM);
>> +       smmu = &qsmmu->smmu;
>>
>>          qsmmu->smmu.impl = impl;
>>          qsmmu->data = data;
>> @@ -719,7 +720,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>>          if (ret)
>>                  return ERR_PTR(ret);
> What is the tree that you have been developing this against? I don't
> see this part of the code in the linux-next.
This is in reply to the patchset at: 
https://lore.kernel.org/all/20240201210529.7728-4-quic_c_gdjako@quicinc.com
The aforementioned patchset introduces this bug. This is a suggested fix 
to the bug.
>> -       return &qsmmu->smmu;
>> +       return smmu;
>>   }
>>
>>   /* Implementation Defined Register Space 0 register offsets */
>> --
>> 2.17.1
>>
>>
Thanks,
Pratyush

