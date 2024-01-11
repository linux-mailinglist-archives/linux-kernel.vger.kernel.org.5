Return-Path: <linux-kernel+bounces-23963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F97B82B488
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5C02892F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A81F5380A;
	Thu, 11 Jan 2024 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="expIiGO9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D952F90;
	Thu, 11 Jan 2024 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B8B0AP005246;
	Thu, 11 Jan 2024 18:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=d+FeWuF+MXwS6XPriMB52QuaXQMuGywYMW+thXPOIUg=; b=ex
	pIiGO9C/W71ZqYtmNFcCSIzxKZ1ENrR14KKEUuDAIHpsuti0IV081lPG4NugJqw5
	tkl0wyzU1zhDZrQtAHEjM+e/BztU6ku9WJxOvPOsvxkmiW9B8snheHcJ7XzamBEI
	kn0+RWfONMJUB85tQ5S6gxaRzpExxEYSx3n/y5G1IP37S0RNU+/KYFQHzD1az9Y0
	sOCli+8duMBFqlQA+0dchILx6JLJvkfjwQ8BXwUUuHIfYlizP91nMsuadINHb+K6
	wgsa+ANep6EVN0XJmrd2pUb0TDpnHM7iJqC3I30OS4K+x74Ao4fKs84t+B0/49An
	QEDbFdElmrXPTaqMtBTQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjckh9c3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 18:09:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BI9kcQ014233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 18:09:46 GMT
Received: from [10.216.16.210] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 10:09:39 -0800
Message-ID: <1a1f9b11-5a6d-41f7-8bcd-533a61a27a65@quicinc.com>
Date: Thu, 11 Jan 2024 23:39:36 +0530
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
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Pavan Kondeti
	<quic_pkondeti@quicinc.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <dmitry.baryshkov@linaro.org>, <jsnitsel@redhat.com>,
        <quic_bjorande@quicinc.com>, <mani@kernel.org>,
        <quic_eberman@quicinc.com>, <robdclark@chromium.org>,
        <u.kleine-koenig@pengutronix.de>, <robh@kernel.org>,
        <vladimir.oltean@nxp.com>, <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20240109114220.30243-1-quic_bibekkum@quicinc.com>
 <20240109114220.30243-4-quic_bibekkum@quicinc.com>
 <2ad70157-27d1-41df-8866-c226af690cf6@quicinc.com>
 <ec31fafa-b912-454a-8b64-e0593911aaf2@quicinc.com>
 <4a595815-7fcc-47e2-b22c-dac349af6d79@quicinc.com>
 <492aeca3-a4df-47a3-9c77-02ea4235d736@linaro.org>
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
In-Reply-To: <492aeca3-a4df-47a3-9c77-02ea4235d736@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zVFn-BH7dMnP9KgOwl_Wb9OjB68c8kxb
X-Proofpoint-GUID: zVFn-BH7dMnP9KgOwl_Wb9OjB68c8kxb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110142



On 1/10/2024 11:26 PM, Konrad Dybcio wrote:
> 
> 
> On 1/10/24 13:55, Bibek Kumar Patro wrote:
>>
>>
>> On 1/10/2024 4:46 PM, Bibek Kumar Patro wrote:
>>>
>>>
>>> On 1/10/2024 9:36 AM, Pavan Kondeti wrote:
>>
>> [...]
>>
>>>>> @@ -274,6 +321,21 @@ static const struct of_device_id 
>>>>> qcom_smmu_client_of_match[] __maybe_unused = {
>>>>>   static int qcom_smmu_init_context(struct arm_smmu_domain 
>>>>> *smmu_domain,
>>>>>           struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
>>>>>   {
>>>>> +    struct arm_smmu_device *smmu = smmu_domain->smmu;
>>>>> +    struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
>>>>> +    const struct actlr_variant *actlrvar;
>>>>> +    int cbndx = smmu_domain->cfg.cbndx;
>>>>> +
>>>>> +    if (qsmmu->data->actlrvar) {
>>>>> +        actlrvar = qsmmu->data->actlrvar;
>>>>> +        for (; actlrvar->io_start; actlrvar++) {
>>>>> +            if (actlrvar->io_start == smmu->ioaddr) {
>>>>> +                qcom_smmu_set_actlr(dev, smmu, cbndx, 
>>>>> actlrvar->actlrcfg);
>>>>> +                break;
>>>>> +            }
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>
>>>> This block and the one in qcom_adreno_smmu_init_context() are exactly
>>>> the same. Possible to do some refactoring?
>>>>
>>>
>>> I will check if this repeated blocks can be accomodated this into 
>>> qcom_smmu_set_actlr function if that would be fine.
>>>
>>
>> Also adding to this, this might increase the number of indentation 
>> inside qcom_smmu_set_actlr as well, to around 5. So wouldn't this
>> be an issue?
> 
> By the way, we can refactor this:
> 
> if (qsmmu->data->actlrvar) {
>      actlrvar = qsmmu->data->actlrvar;
>      for (; actlrvar->io_start; actlrvar++) {
>          if (actlrvar->io_start == smmu->ioaddr) {
>              qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
>              break;
>          }
>      }
> }
> 
> into
> 
> // add const u8 num_actlrcfgs to struct actrl_variant to
> // save on sentinel space:
> //   sizeof(u8) < sizeof(ptr) + sizeof(resource_size_t)
> 

Git it, Would it be better to add this in struct qcom_smmu_match_data ?
Posted a sample below.

> 
> [declarations]
> const struct actlr_variant *actlrvar = qsmmu->data->actlrvar;
> int i;
> 
> [rest of the functions]
> 
> if (!actlrvar)
>      return 0;
>  > for (i = 0; i < actrlvar->num_actrlcfgs; i++) {
>      if (actlrvar[i].io_start == smmu->ioaddr) {
>          qcom_smmu_set_actlr(dev, smmu, cbndx, actlrvar->actlrcfg);
>          break;
>      }
> }
>  > Saving both on .TEXT size and indentation levels :)
> 
Thanks for this suggestion Konrad, will try to implement this, as it 
would reduce the indent levels to good extent.
Would something like this be okay?

static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
  	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
  	const struct actlr_variant *actlrvar;
  	int cbndx = smmu_domain->cfg.cbndx;
+	int i;

+	actlrvar = qsmmu->data->actlrvar;
+
+	if (!actlrvar)
+		goto end;
+
+	for (i = 0; i < qsmmu->data->num_smmu ; i++) {
+		if (actlrvar[i].io_start == smmu->ioaddr) {
+			qcom_smmu_set_actlr(dev, smmu, cbndx,
+						actlrvar[i].actlrcfg);
+			break;
  		}
  	}

+end:
  	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;

  	return 0;

Thanks & regards,
Bibek

> Konrad

