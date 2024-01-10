Return-Path: <linux-kernel+bounces-22200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D19829AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0861F218C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2AC48CE1;
	Wed, 10 Jan 2024 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pTKqrjD+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148D48CD9;
	Wed, 10 Jan 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40ACekq5010668;
	Wed, 10 Jan 2024 12:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7vMT1hFktDJAz+gNb9eLyhKcykMUQ9DQvdKP5jgUOYE=; b=pT
	KqrjD+iOnFyCEzjMKBY747zU++IgyPUaVXqCHy4E6ey2aWTyA2WYTtaSjkxXGBOw
	BEXbvxFk6xRzD/aS5+gtvJva4/RKBepI+OJO107W7Nc6HQ2r7z3tBOWkQ1CHJkIj
	k38b/G6Ghfyozl/ZGM9rrGJ1PlzzVWfJGwHYhxrPshBLil6ooJRop3yuCQRj0Xbk
	4hfrz3pObkliri1w/C8z8cPYMYEdq1kUi4GqVfrz2cEiNSOY7FtG9R1Na5a5zu+y
	3UEh8w1MHXZejkAgK0HVj2e5nHCoVPwZ84NLxZ7IHpcM4AdnAj8uqg6Ex4MThK9V
	pze0+lLjwuRSLMjSoj8w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhkem15c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 12:55:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ACtXZ6007220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 12:55:33 GMT
Received: from [10.214.66.253] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 04:55:27 -0800
Message-ID: <4a595815-7fcc-47e2-b22c-dac349af6d79@quicinc.com>
Date: Wed, 10 Jan 2024 18:25:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu: introduction of ACTLR for custom
 prefetcher settings
Content-Language: en-US
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
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
 <ec31fafa-b912-454a-8b64-e0593911aaf2@quicinc.com>
In-Reply-To: <ec31fafa-b912-454a-8b64-e0593911aaf2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hiHoHz-1KztRZSPuXEpqyxfs5P7xS_HR
X-Proofpoint-GUID: hiHoHz-1KztRZSPuXEpqyxfs5P7xS_HR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=940 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100106



On 1/10/2024 4:46 PM, Bibek Kumar Patro wrote:
> 
> 
> On 1/10/2024 9:36 AM, Pavan Kondeti wrote:

[...]

>>> @@ -274,6 +321,21 @@ static const struct of_device_id 
>>> qcom_smmu_client_of_match[] __maybe_unused = {
>>>   static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>>>           struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>>   {
>>> +    struct arm_smmu_device *smmu = smmu_domain->smmu;
>>> +    struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>>> +    const struct actlr_variant *actlrvar;
>>> +    int cbndx = smmu_domain->cfg.cbndx;
>>> +
>>> +    if (qsmmu->data->actlrvar) {
>>> +        actlrvar = qsmmu->data->actlrvar;
>>> +        for (; actlrvar->io_start; actlrvar++) {
>>> +            if (actlrvar->io_start == smmu->ioaddr) {
>>> +                qcom_smmu_set_actlr(dev, smmu, cbndx, 
>>> actlrvar->actlrcfg);
>>> +                break;
>>> +            }
>>> +        }
>>> +    }
>>> +
>>
>> This block and the one in qcom_adreno_smmu_init_context() are exactly
>> the same. Possible to do some refactoring?
>>
> 
> I will check if this repeated blocks can be accomodated this into 
> qcom_smmu_set_actlr function if that would be fine.
> 

Also adding to this, this might increase the number of indentation 
inside qcom_smmu_set_actlr as well, to around 5. So wouldn't this
be an issue?

Thanks,
Bibek

