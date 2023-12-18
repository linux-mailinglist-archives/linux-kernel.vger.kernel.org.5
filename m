Return-Path: <linux-kernel+bounces-3010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A534B816613
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63695282028
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A793B63D7;
	Mon, 18 Dec 2023 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RdYQdNSk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491063C6;
	Mon, 18 Dec 2023 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI49H86008671;
	Mon, 18 Dec 2023 05:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=W6mEY5ZXYd2wnNecPuwM7uyfZQerkDjjIW8pNDaWfDo=; b=Rd
	YQdNSkj2U91uYjT5jpPn1E+yUbUOztqqVPOcD4AstSJ6iMyiS5yuYbG/DyXZbC70
	DcGkJw4Z0RYkV0i2DdggBe6gimdTLyFKUmQ1W5Y8idv7gCd8Du0aOVv9y7SC1n3M
	vOq/8g334pT4M4ethhlh2Dcn42O5tluJA7/k+qjkm+61BFUgGlEXpJx94Wglnhk7
	df3YgQ/2A6my4MSPM42QLVv1UBPz9S47zafbk/5d/Ue2kFYQ5cVBNOAWtaRr/fXq
	EGRh3I2SF4nxwlRUvK5pSK5ljLi7BenGKJZBeo5GCHksTUEf5YHk6tXOEf59T91F
	SEegJOFyNexVTBuYcV6w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14vjkgbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 05:36:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI5ag4X002126
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 05:36:42 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Dec
 2023 21:36:36 -0800
Message-ID: <6dc509ac-8f3b-40c2-bc1d-a86b76efde76@quicinc.com>
Date: Mon, 18 Dec 2023 11:06:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
To: Robin Murphy <robin.murphy@arm.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <will@kernel.org>, <joro@8bytes.org>, <konrad.dybcio@linaro.org>,
        <jsnitsel@redhat.com>, <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_pkondeti@quicinc.com>,
        <quic_molvera@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <qipl.kernel.upstream@quicinc.com>
References: <20231215101827.30549-1-quic_bibekkum@quicinc.com>
 <20231215101827.30549-4-quic_bibekkum@quicinc.com>
 <CAA8EJppcsr1sbeD1fK0nZ+rASABNcetBK3yMvaP7OiA4JPwskw@mail.gmail.com>
 <c9493c5f-ccf8-4e21-b00c-5fbc2a5f2edb@quicinc.com>
 <b7f2bbf9-fb5a-430d-aa32-3a220b46c2f0@arm.com>
Content-Language: en-US
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <b7f2bbf9-fb5a-430d-aa32-3a220b46c2f0@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CniKGAZeFXAF4hqSTKWglvRuB0pU74v1
X-Proofpoint-GUID: CniKGAZeFXAF4hqSTKWglvRuB0pU74v1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180037



On 12/15/2023 6:24 PM, Robin Murphy wrote:
> On 2023-12-15 12:20 pm, Bibek Kumar Patro wrote:
>>
>>
>> On 12/15/2023 4:14 PM, Dmitry Baryshkov wrote:
>>> On Fri, 15 Dec 2023 at 12:19, Bibek Kumar Patro
>>> <quic_bibekkum@quicinc.com> wrote:
>>>>
>>>> Add ACTLR data table for SM8550 along with support for
>>>> same including SM8550 specific implementation operations.
>>>>
>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>> ---
>>>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89 
>>>> ++++++++++++++++++++++
>>>>   1 file changed, 89 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c 
>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> index cb49291f5233..d2006f610243 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>> @@ -20,6 +20,85 @@ struct actlr_config {
>>>>          u32 actlr;
>>>>   };
>>>>
>>>> +/*
>>>> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
>>>> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the 
>>>> prefetch
>>>> + * buffer). The remaining bits are implementation defined and vary 
>>>> across
>>>> + * SoCs.
>>>> + */
>>>> +
>>>> +#define PREFETCH_DEFAULT       0
>>>> +#define PREFETCH_SHALLOW       BIT(8)
>>>> +#define PREFETCH_MODERATE      BIT(9)
>>>> +#define PREFETCH_DEEP          (BIT(9) | BIT(8))
>>>
>>> I thin the following might be more correct:
>>>
>>> #include <linux/bitfield.h>
>>>
>>> #define PREFETCH_MASK GENMASK(9, 8)
>>> #define PREFETCH_DEFAULT FIELD_PREP(PREFETCH_MASK, 0)
>>> #define PREFETCH_SHALLOW FIELD_PREP(PREFETCH_MASK, 1)
>>> #define PREFETCH_MODERATE FIELD_PREP(PREFETCH_MASK, 2)
>>> #define PREFETCH_DEEP FIELD_PREP(PREFETCH_MASK, 3)
>>>
>>
>> Ack, thanks for this suggestion. Let me try this out using
>> GENMASK. Once tested, will take care of this in next version.
> 
> FWIW the more typical usage would be to just define the named macros for 
> the raw field values, then put the FIELD_PREP() at the point of use. 
> However in this case that's liable to get pretty verbose, so although 
> I'm usually a fan of bitfield.h, the most readable option here might 
> actually be to stick with simpler definitions of "(0 << 8)", "(1 << 8)", 
> etc. However it's not really a big deal either way, and I defer to 
> whatever Dmitry and Konrad prefer, since they're the ones looking after 
> arm-smmu-qcom the most :)
> 

Agree, surely simple macros would be easy to understand the bits we are
setting/resetting, but to get good verbosity bitfield would surely be
helpful as you rightly pointed. I can see some improved suggestions form
Konrad as well in the latest reply, the way it'd be better in arm-smmu-
qcom. Will try to incorporate these inputs in next version.

Thanks,
Bibek

> Thanks,
> Robin.
> 
>>
>> Thanks,
>> Bibek
>>
>>>> +#define PREFETCH_SWITCH_GFX    (BIT(5) | BIT(3))
>>>> +#define CPRE                   BIT(1)
>>>> +#define CMTLB                  BIT(0)
>>>> +
>>>> +static const struct actlr_config sm8550_apps_actlr_cfg[] = {
>>>> +       { 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>> +       { 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>> +       { 0x0800, 0x0020, PREFETCH_DEFAULT | CMTLB },
>>>> +       { 0x1800, 0x00c0, PREFETCH_DEFAULT | CMTLB },
>>>> +       { 0x1820, 0x0000, PREFETCH_DEFAULT | CMTLB },
>>>> +       { 0x1860, 0x0000, PREFETCH_DEFAULT | CMTLB },
>>>> +       { 0x0c01, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x0c02, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x0c03, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x0c04, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x0c05, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x0c06, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x0c07, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x0c08, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x0c09, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x0c0c, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x0c0d, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x0c0e, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x0c0f, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x1961, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x1962, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x1963, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x1964, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x1965, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x1966, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x1967, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x1968, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x1969, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x196c, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x196d, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x196e, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x196f, 0x0000, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x19c1, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x19c2, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x19c3, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x19c4, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x19c5, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x19c6, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x19c7, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x19c8, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x19c9, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x19cc, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x19cd, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x19ce, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x19cf, 0x0010, PREFETCH_DEEP | CPRE | CMTLB },
>>>> +       { 0x1c00, 0x0002, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>> +       { 0x1c01, 0x0000, PREFETCH_DEFAULT | CMTLB },
>>>> +       { 0x1920, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>> +       { 0x1923, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>> +       { 0x1924, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>> +       { 0x1940, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>> +       { 0x1941, 0x0004, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>> +       { 0x1943, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>> +       { 0x1944, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>> +       { 0x1947, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
>>>> +       {},
>>>> +};
>>>> +
>>>> +static const struct actlr_config sm8550_gfx_actlr_cfg[] = {
>>>> +       { 0x0000, 0x03ff, PREFETCH_SWITCH_GFX | PREFETCH_DEEP | CPRE 
>>>> | CMTLB },
>>>> +       {},
>>>> +};
>>>> +
>>>>   static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>>>>   {
>>>>          return container_of(smmu, struct qcom_smmu, smmu);
>>>> @@ -549,6 +628,15 @@ static const struct qcom_smmu_match_data 
>>>> sdm845_smmu_500_data = {
>>>>          /* Also no debug configuration. */
>>>>   };
>>>>
>>>> +
>>>> +static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data 
>>>> = {
>>>> +       .impl = &qcom_smmu_500_impl,
>>>> +       .adreno_impl = &qcom_adreno_smmu_500_impl,
>>>> +       .cfg = &qcom_smmu_impl0_cfg,
>>>> +       .actlrcfg = sm8550_apps_actlr_cfg,
>>>> +       .actlrcfg_gfx = sm8550_gfx_actlr_cfg,
>>>> +};
>>>> +
>>>>   static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
>>>>          .impl = &qcom_smmu_500_impl,
>>>>          .adreno_impl = &qcom_adreno_smmu_500_impl,
>>>> @@ -583,6 +671,7 @@ static const struct of_device_id __maybe_unused 
>>>> qcom_smmu_impl_of_match[] = {
>>>>          { .compatible = "qcom,sm8250-smmu-500", .data = 
>>>> &qcom_smmu_500_impl0_data },
>>>>          { .compatible = "qcom,sm8350-smmu-500", .data = 
>>>> &qcom_smmu_500_impl0_data },
>>>>          { .compatible = "qcom,sm8450-smmu-500", .data = 
>>>> &qcom_smmu_500_impl0_data },
>>>> +       { .compatible = "qcom,sm8550-smmu-500", .data = 
>>>> &sm8550_smmu_500_impl0_data },
>>>>          { .compatible = "qcom,smmu-500", .data = 
>>>> &qcom_smmu_500_impl0_data },
>>>>          { }
>>>>   };
>>>> -- 
>>>> 2.17.1
>>>>
>>>
>>>

