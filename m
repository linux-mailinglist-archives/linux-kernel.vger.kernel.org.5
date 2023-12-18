Return-Path: <linux-kernel+bounces-3036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B07E281666C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15CE2B210AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4896FAC;
	Mon, 18 Dec 2023 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aLbzit/h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4170B6D1B;
	Mon, 18 Dec 2023 06:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BI4nMhi017780;
	Mon, 18 Dec 2023 06:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=baBePT4zJn/be1yNNuGFIki7R4X5vXvErWD9X3nuaCg=; b=aL
	bzit/hS3GcNmdtIfaneVwi0vmeBuiYOZwcoT5JcKkb475CZH3Ek9d3iiykHOX/WF
	2LIhbDTEjABbRweUzJp3GyiOFSA6+E+/ORkVC9wSIMiU5TbsRLCs2Bs+KsbMaWY6
	cQfnAwrgXHMHiCnyBSZGCcbE7L2kUKco3HTBJR1KXAFrPIPI3f2w/3EtZ4E3qOag
	TyTZmMFVqNvdoiSMKSSNppyi3JV5+A31DKpDdbpoW8+CNL6qOPuczYKiowRUqxN7
	531v5oOJHl8qdrl/PXKcSKV1iXFPqYgZUim7LTY3ksPseOABmo7O/8Kd5FZWLNTy
	iaCv5st+MT/fIasF1O2Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v14vjkjs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 06:17:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BI6Hd3W025607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 06:17:39 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 17 Dec
 2023 22:17:33 -0800
Message-ID: <7caf4e99-49fd-4a81-9a97-4d67675a5c66@quicinc.com>
Date: Mon, 18 Dec 2023 11:47:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robin Murphy
	<robin.murphy@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <will@kernel.org>, <joro@8bytes.org>, <jsnitsel@redhat.com>,
        <quic_bjorande@quicinc.com>, <mani@kernel.org>,
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
 <1eee8bae-59f0-4066-9d04-8c3a5f750d3a@linaro.org>
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <1eee8bae-59f0-4066-9d04-8c3a5f750d3a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: C-tWu2ak0OjQSZVU2IIkJCpZxJfiX9Jl
X-Proofpoint-GUID: C-tWu2ak0OjQSZVU2IIkJCpZxJfiX9Jl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxlogscore=946 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180043



On 12/16/2023 5:33 AM, Konrad Dybcio wrote:
> On 15.12.2023 13:54, Robin Murphy wrote:
>> On 2023-12-15 12:20 pm, Bibek Kumar Patro wrote:
>>>
>>>
>>> On 12/15/2023 4:14 PM, Dmitry Baryshkov wrote:
>>>> On Fri, 15 Dec 2023 at 12:19, Bibek Kumar Patro
>>>> <quic_bibekkum@quicinc.com> wrote:
>>>>>
>>>>> Add ACTLR data table for SM8550 along with support for
>>>>> same including SM8550 specific implementation operations.
>>>>>
>>>>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>>>>> ---
>>>>>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 89 ++++++++++++++++++++++
>>>>>    1 file changed, 89 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>> index cb49291f5233..d2006f610243 100644
>>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
>>>>> @@ -20,6 +20,85 @@ struct actlr_config {
>>>>>           u32 actlr;
>>>>>    };
>>>>>
>>>>> +/*
>>>>> + * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
>>>>> + * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
>>>>> + * buffer). The remaining bits are implementation defined and vary across
>>>>> + * SoCs.
>>>>> + */
>>>>> +
>>>>> +#define PREFETCH_DEFAULT       0
>>>>> +#define PREFETCH_SHALLOW       BIT(8)
>>>>> +#define PREFETCH_MODERATE      BIT(9)
>>>>> +#define PREFETCH_DEEP          (BIT(9) | BIT(8))
>>>>
>>>> I thin the following might be more correct:
>>>>
>>>> #include <linux/bitfield.h>
>>>>
>>>> #define PREFETCH_MASK GENMASK(9, 8)
>>>> #define PREFETCH_DEFAULT FIELD_PREP(PREFETCH_MASK, 0)
>>>> #define PREFETCH_SHALLOW FIELD_PREP(PREFETCH_MASK, 1)
>>>> #define PREFETCH_MODERATE FIELD_PREP(PREFETCH_MASK, 2)
>>>> #define PREFETCH_DEEP FIELD_PREP(PREFETCH_MASK, 3)
>>>>
>>>
>>> Ack, thanks for this suggestion. Let me try this out using
>>> GENMASK. Once tested, will take care of this in next version.
>>
>> FWIW the more typical usage would be to just define the named macros for the raw field values, then put the FIELD_PREP() at the point of use. However in this case that's liable to get pretty verbose, so although I'm usually a fan of bitfield.h, the most readable option here might actually be to stick with simpler definitions of "(0 << 8)", "(1 << 8)", etc. However it's not really a big deal either way, and I defer to whatever Dmitry and Konrad prefer, since they're the ones looking after arm-smmu-qcom the most :)
> My 5 cents would be to just use the "common" style of doing this, so:
> 
> #define ACTRL_PREFETCH	GENMASK(9, 8)
>   #define PREFETCH_DEFAULT 0
>   #define PREFETCH_SHALLOW 1
>   #define PREFETCH_MODERATE 2
>   #define PREFETCH_DEEP 3
> 
> and then use
> 
> | FIELD_PREP(ACTRL_PREFETCH, PREFETCH_x)
> 
> it can get verbose, but.. arguably that's good, since you really want
> to make sure the right bits are set here
> 

Thanks for the suggestion with these mods.
Let me try out the suggested way and once tested will post this in next
version.

Thanks,
Bibek

> Konrad

