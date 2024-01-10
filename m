Return-Path: <linux-kernel+bounces-22062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 092B98298A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F302B26878
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1678147F65;
	Wed, 10 Jan 2024 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lth6Jf8c"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195047F5B;
	Wed, 10 Jan 2024 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A9a4HY004758;
	Wed, 10 Jan 2024 11:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=g9xuwmwnv77m6yLMd6UvlmhVtVKT1QYeO0gAErvBHgE=; b=Lt
	h6Jf8cKFbWSHgYDouVDyTfFKZOJUsShEn4ZUpRZ5sAT5wtF4uI+TmwQ9WocGrEJz
	wOL8zW+uzRvosXZ53soeRPYyfqVjjCRo+cQfE7ZKohEpmwd8VpdkOGphlVrA3I//
	AZQ/GvWQg87genB1WIntjdL+cnrJqiXTH80sGmlWtHlu5C9il69Dd143BRO3pIue
	ImiDECtTTHSgqwZ4A7IqGUejqjhAvDfkTiUMGwTLehkb3OM8EcSAdg8sFRja0hDl
	iQbQ5Ex4Vg83uMNPIO6tt2eNqADxrcssKaxv8yHdnevkfP5QqPLFFJEzaQZT7QZJ
	LjhinQgmk0ZrqfgM5aIA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhg8g1844-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:17:02 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABH1IK009829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:17:01 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 03:16:54 -0800
Message-ID: <ec31fafa-b912-454a-8b64-e0593911aaf2@quicinc.com>
Date: Wed, 10 Jan 2024 16:46:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Pavan Kondeti <quic_pkondeti@quicinc.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <jsnitsel@redhat.com>, <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-4-quic_bibekkum@quicinc.com>
 <2ad70157-27d1-41df-8866-c226af690cf6@quicinc.com>
Content-Language: en-US
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <2ad70157-27d1-41df-8866-c226af690cf6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SAGdCQf8fpU7gVcpiSgWX-iDG8BOwoaB
X-Proofpoint-GUID: SAGdCQf8fpU7gVcpiSgWX-iDG8BOwoaB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100092



On 1/10/2024 9:36 AM, Pavan Kondeti wrote:
> On Tue, Jan 09, 2024 at 05:12:18PM +0530, Bibek Kumar Patro wrote:
>>   static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>   		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>   {
>> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>> +	const struct actlr_variant *actlrvar;
>> +	int cbndx = smmu_domain->cfg.cbndx;
>>   	struct adreno_smmu_priv *priv;
>>
>>   	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
>> @@ -248,6 +285,16 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>   	priv->set_stall = qcom_adreno_smmu_set_stall;
>>   	priv->resume_translation = qcom_adreno_smmu_resume_translation;
>>
>> +	if (qsmmu->data->actlrvar) {
>> +		actlrvar = qsmmu->data->actlrvar;
>> +		for (; actlrvar->io_start; actlrvar++) {
>> +			if (actlrvar->io_start == smmu->ioaddr) {
>> +				qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>>   	return 0;
>>   }
>>
>> @@ -274,6 +321,21 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>>   static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>   		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>   {
>> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>> +	const struct actlr_variant *actlrvar;
>> +	int cbndx = smmu_domain->cfg.cbndx;
>> +
>> +	if (qsmmu->data->actlrvar) {
>> +		actlrvar = qsmmu->data->actlrvar;
>> +		for (; actlrvar->io_start; actlrvar++) {
>> +			if (actlrvar->io_start == smmu->ioaddr) {
>> +				qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
> 
> This block and the one in qcom_adreno_smmu_init_context() are exactly
> the same. Possible to do some refactoring?
> 

I will check if this repeated blocks can be accomodated this into 
qcom_smmu_set_actlr function if that would be fine.

>>   	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
>>
>>   	return 0;
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>> index f3b91963e234..29d26dfa2ed9 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>> @@ -1,6 +1,6 @@
>>   /* SPDX-License-Identifier: GPL-2.0-only */
>>   /*
>> - * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>    */
>>
> 
> It should be 2022-2023 .
> 

Ack

>>   #ifndef _ARM_SMMU_QCOM_H
>> @@ -24,8 +24,17 @@ struct qcom_smmu_config {
>>   	const u32 *reg_offset;
>>   };
>>
>> +struct actlr_config;
>> +
>> +struct actlr_variant {
>> +	const struct actlr_config *actlrcfg;
>> +	const resource_size_t io_start;
>> +};
>> +
>>   struct qcom_smmu_match_data {
>> +	const struct actlr_variant *actlrvar;
>>   	const struct qcom_smmu_config *cfg;
>> +	const int num_smmu;
>>   	const struct arm_smmu_impl *impl;
>>   	const struct arm_smmu_impl *adreno_impl;
>>   };
> 
> qcom_smmu_match_data::num_smmu needs cleanup.
> 

Ack, thanks for pointing this out.

Thanks & regards,
Bibek

> Thanks,
> Pavan

