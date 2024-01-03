Return-Path: <linux-kernel+bounces-15214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51457822869
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB27A1F23B9D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B89179AC;
	Wed,  3 Jan 2024 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="agE6PUbi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633CF1798E;
	Wed,  3 Jan 2024 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4035jmfx013745;
	Wed, 3 Jan 2024 06:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ucH66wfieCeWWgEeqZEDdxHXb+f7gX4VUgyWpqVU/p8=; b=ag
	E6PUbiiVljwpMLI6UMkGCGJAvf81+jHl/MuHRJKl59yisztZFif9GKaEoF6DWoMO
	5nkNRSvxN5dLlsMiusks1p/EDuiHCliaYrYAdRflOtVVQ2UqmzaW1FNY4wXRp6Ul
	/P65EuQfkzEFQ/Bs8213Z0iL017XRZFVEYimRA4ZGI2C+GnA+8y/XOtnzD0wxIiQ
	iR9OpdNyDbZ4QzCrsyjFC+hw3ye5mYweywlBLdqmbuywV0oSibwL3mPkN7M+/RGz
	nio8y28evHj2Yt8G63oHDEfvcGy/wMfoFO3aoE9xMqDeFNM4s9tscFMPxE9wSWWt
	GNWr8fHLQpPdL3OjAIlA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vch7na6hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 06:26:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4036QDNb000697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 06:26:13 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Jan
 2024 22:26:06 -0800
Message-ID: <be075bef-808b-4175-acbe-e26abc4a7a25@quicinc.com>
Date: Wed, 3 Jan 2024 11:54:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <konrad.dybcio@linaro.org>, <jsnitsel@redhat.com>,
        <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
References: <20231220133808.5654-1-quic_bibekkum@quicinc.com>
 <20231220133808.5654-4-quic_bibekkum@quicinc.com>
 <CAA8EJpo8X+jfi20N9P7kUshxe6_7pwQe8G0Q02JDuB8ozH7hLA@mail.gmail.com>
 <7b32b7a7-bc64-4102-a6bf-3c3fc8d979ac@quicinc.com>
 <CAA8EJpo6LdBQm5q=r2+ETBwhKL3YkUsPDuzA2MGCqb-1R_9b7w@mail.gmail.com>
Content-Language: en-US
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <CAA8EJpo6LdBQm5q=r2+ETBwhKL3YkUsPDuzA2MGCqb-1R_9b7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8ntEr63AlUb5ibHk2srvV2kUfOt-8kUh
X-Proofpoint-ORIG-GUID: 8ntEr63AlUb5ibHk2srvV2kUfOt-8kUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030051



On 12/21/2023 4:02 PM, Dmitry Baryshkov wrote:
> On Thu, 21 Dec 2023 at 12:02, Bibek Kumar Patro
> <quic_bibekkum@quicinc.com> wrote:
>>
>>
>>
>> On 12/21/2023 6:06 AM, Dmitry Baryshkov wrote:
>>> On Wed, 20 Dec 2023 at 15:39, Bibek Kumar Patro
>>> <quic_bibekkum@quicinc.com> wrote:
>>>>
>>>> Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
>>>> the TLB to fetch just the next page table. MMU-500 features ACTLR
>>>> register which is implementation defined and is used for Qualcomm SoCs
>>>> to have a custom prefetch setting enabling TLB to prefetch the next set
>>>> of page tables accordingly allowing for faster translations.
>>>>
>>>> ACTLR value is unique for each SMR (Stream matching register) and stored
>>>> in a pre-populated table. This value is set to the register during
>>>> context bank initialisation.
>>>>
>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>> ---
>>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 45 ++++++++++++++++++++++
>>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  6 ++-
>>>>    drivers/iommu/arm/arm-smmu/arm-smmu.c      |  5 ++-
>>>>    drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 +++
>>>>    4 files changed, 58 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> index 20c9836d859b..1cefdd0ca110 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> @@ -24,6 +24,12 @@
>>>>    #define CPRE                   (1 << 1)
>>>>    #define CMTLB                  (1 << 0)
>>>>
>>>> +struct actlr_config {
>>>> +       u16 sid;
>>>> +       u16 mask;
>>>> +       u32 actlr;
>>>> +};
>>>> +
>>>>    static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>>>>    {
>>>>           return container_of(smmu, struct qcom_smmu, smmu);
>>>> @@ -215,9 +221,38 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
>>>>           return true;
>>>>    }
>>>>
>>>> +static void qcom_smmu_set_actlr(struct device *dev, struct arm_smmu_device *smmu, int cbndx,
>>>> +               const struct actlr_config *actlrcfg)
>>>> +{
>>>> +       struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
>>>> +       struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>>>> +       struct arm_smmu_smr *smr;
>>>> +       u16 mask;
>>>> +       int idx;
>>>> +       u16 id;
>>>> +       int i;
>>>> +
>>>> +       for (; actlrcfg->sid || actlrcfg->mask || actlrcfg->actlr; actlrcfg++) {
>>>> +               id = actlrcfg->sid;
>>>> +               mask = actlrcfg->mask;
>>>> +
>>>> +               for_each_cfg_sme(cfg, fwspec, i, idx) {
>>>> +                       smr = &smmu->smrs[idx];
>>>> +                       if (smr_is_subset(smr, id, mask)) {
>>>> +                               arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_CB_ACTLR,
>>>> +                                               actlrcfg->actlr);
>>>> +                               break;
>>>> +                       }
>>>> +               }
>>>> +       }
>>>> +}
>>>> +
>>>>    static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>>>                   struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>>>    {
>>>> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>>>> +       int cbndx = smmu_domain->cfg.cbndx;
>>>>           struct adreno_smmu_priv *priv;
>>>>
>>>>           smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
>>>> @@ -248,6 +283,9 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>>>           priv->set_stall = qcom_adreno_smmu_set_stall;
>>>>           priv->resume_translation = qcom_adreno_smmu_resume_translation;
>>>>
>>>> +       if (qsmmu->data->actlrcfg_gfx)
>>>> +               qcom_smmu_set_actlr(dev, smmu, cbndx, qsmmu->data->actlrcfg_gfx);
>>>
>>> There was a feedback point against v4 that there can be more than two
>>> (apps + gpu) SMMU devices. No, we can not use additional compat
>>> strings, the SMMU units are compatible with each other.
>>
>> Just to understand better, did you mean if in the below check
>> [inside arm-smmu-qcom.c file during qcom_smmu_create()], "else" has two
>> things? (Currently adreno_impl for gpu smmu, else for only
>> apps smmu)
> 
> qcom,adreno-smmu is quite unique here, this is the only distinctive
> substring. We do not have such compat strings for any other of SMMU
> nodes.
> 

Apologies for the delayed response, I was on leave and could
not monitor the replies.

for other SMMUs (except qcom-adreno-smmu) we would
need to use the IO address matching.

>>
>>            if (np && of_device_is_compatible(np, "qcom,adreno-smmu"))
>>                    impl = data->adreno_impl;
>>            else
>>                    impl = data->impl;
>>
>>> Please add
>>> matching between the smmu and particular actlr table using the IO
>>> address of the SMMU block.
>>>
>>
>> The ACTLR table for each smmu will have A IO address attached, so based
>> on IO address we can apply ACTLR.
>> Is this your proposal((IMO hardcoding IO in driver won't be viable,
>> isn't it?), or in smmu DT we would need to set the IO?
> 
> Unfortunately, I meant exactly that: hardcoding addresses of the SMMU
> register spaces. see drivers/gpu/drm/msm/dsi_cfg.c
> Then during device probe the driver can match the IO address to the
> list of the per-platform ACTLR tables and select the correct one.
> Then you don't even need a special actlrcfg_gfx. The GFX will fall
> into the main schema.
> 

Thanks for the reference, I will check once and try to evaluate a
similar implementation for ACTLR table as well.

Thanks,
Bibek

>>
>>
>> Thanks & regards,
>> Bibek
>>
>>>> +
>>>>           return 0;
>>>>    }
>>>>
>>>> @@ -274,6 +312,13 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>>>>    static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>>>                   struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>>>    {
>>>> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>> +       struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>>>> +       int cbndx = smmu_domain->cfg.cbndx;
>>>> +
>>>> +       if (qsmmu->data->actlrcfg)
>>>> +               qcom_smmu_set_actlr(dev, smmu, cbndx, qsmmu->data->actlrcfg);
>>>> +
>>>
>>> One issue occured to me, while I was reviewing the patchset. The ACTLR
>>> settings are related to the whole SMMU setup, but we are applying them
>>> each time there is an SMMU context init (in other words, one per each
>>> domain). Is that correct? Or it's just that there is no better place
>>> for initialising the global register set? Would it be better to
>>> reprogram the ACTLR registers which are related just to this
>>> particular domain?
>>>
>>>>           smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;
>>>>
>>>>           return 0;
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>>>> index f3b91963e234..cb4cb402c202 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
>>>> @@ -1,6 +1,6 @@
>>>>    /* SPDX-License-Identifier: GPL-2.0-only */
>>>>    /*
>>>> - * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>>>     */
>>>>
>>>>    #ifndef _ARM_SMMU_QCOM_H
>>>> @@ -24,7 +24,11 @@ struct qcom_smmu_config {
>>>>           const u32 *reg_offset;
>>>>    };
>>>>
>>>> +struct actlr_config;
>>>> +
>>>>    struct qcom_smmu_match_data {
>>>> +       const struct actlr_config *actlrcfg;
>>>> +       const struct actlr_config *actlrcfg_gfx;
>>>>           const struct qcom_smmu_config *cfg;
>>>>           const struct arm_smmu_impl *impl;
>>>>           const struct arm_smmu_impl *adreno_impl;
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> index d6d1a2a55cc0..0c7f700b27dd 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> @@ -990,9 +990,10 @@ static int arm_smmu_find_sme(struct arm_smmu_device *smmu, u16 id, u16 mask)
>>>>                    * expect simply identical entries for this case, but there's
>>>>                    * no harm in accommodating the generalisation.
>>>>                    */
>>>> -               if ((mask & smrs[i].mask) == mask &&
>>>> -                   !((id ^ smrs[i].id) & ~smrs[i].mask))
>>>> +
>>>> +               if (smr_is_subset(&smrs[i], id, mask))
>>>>                           return i;
>>>> +
>>>>                   /*
>>>>                    * If the new entry has any other overlap with an existing one,
>>>>                    * though, then there always exists at least one stream ID
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>>>> index 703fd5817ec1..2e4f65412c6b 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>>>> @@ -501,6 +501,11 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
>>>>                   writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
>>>>    }
>>>>
>>>> +static inline bool smr_is_subset(struct arm_smmu_smr *smrs, u16 id, u16 mask)
>>>> +{
>>>> +       return (mask & smrs->mask) == mask && !((id ^ smrs->id) & ~smrs->mask);
>>>> +}
>>>> +
>>>>    #define ARM_SMMU_GR0           0
>>>>    #define ARM_SMMU_GR1           1
>>>>    #define ARM_SMMU_CB(s, n)      ((s)->numpage + (n))
>>>> --
>>>> 2.17.1
>>>>
>>>
>>>
> 
> 
> 

