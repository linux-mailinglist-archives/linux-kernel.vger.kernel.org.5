Return-Path: <linux-kernel+bounces-164627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D318B8055
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5491F23A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A652C19066F;
	Tue, 30 Apr 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B9IS6J9X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390C172BD7;
	Tue, 30 Apr 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714504239; cv=none; b=jiydydyn/Y5b+QKY/3DR7ixhFLwY8l0ce4ZVG1u6Lc0pxTgMWKlRWe/cU8VNpkmLCiNd4zExuAxID0JyjSQDVo/WRYBntNUi0bglHmiTJhkf+eKtgpfeoQBbIEqrOsPt5jgeK2Jwww6ebf+RN0yCZ4nadPOP9ECPgWSm9ErwqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714504239; c=relaxed/simple;
	bh=OCDOHM9FrUXf71gdI+BpH35InCDk4my/AE7spgjXRRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MZPb13Ei7Ax9MYx4tHsJkh2Tzq7c5X8vJvyRIo+u3mHG9rYZiD+IrGbdCOHoRkOV2xgwCB1zQ4x0chpRQdHnV08kw1Qsnk3/5denq2dpfrX9wIGgM0RdBLRflBfpuLGp/CV0xUpHPR0JGbRu2sUSIx9oUQGZKKRX3e/8xSjTYD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B9IS6J9X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UDiEmM028868;
	Tue, 30 Apr 2024 19:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6Dqu70Mx0g9EBKr268I4btbMishqqyi4Ir+N7pWhkYc=; b=B9
	IS6J9XmKX4DuODhqlAmcfEM62vOjD6oQKDFjlDF+ec3zbESDysfS9ofvOx31JVUZ
	LDm/HYiPZhS/yv7fJ6whejIdPRWnymE5NLnPqMpQQa6aQApkPmFCi8qLm09jyzmv
	pkMpts9uQGZa728z7Rg7ZEPBw4jHkOpZOApjLcRJ888ELXdAn1f3vhpmbOAq/vav
	4mHspeDVPHwTFnddU8gZ0RwvDq8dRsdRAA8bwmOEX5pCFsVNrlLDziUiW4vka571
	eu3oWhAlltbjdQyeBVcSqDQhQIbO7NdNQhG+Xdt72JhBWI5e1+XYdJLavOkRAfRr
	nnlVSHzwH0xqySzha0bw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xthgvuyp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 19:10:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UJAR2G024458
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 19:10:27 GMT
Received: from [10.110.59.215] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 12:10:27 -0700
Message-ID: <256161ea-a298-541e-42d9-990df2f3f006@quicinc.com>
Date: Tue, 30 Apr 2024 12:10:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 6/6] remoteproc: qcom: enable in-kernel PD mapper
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        "Mathieu
 Poirier" <mathieu.poirier@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        "Johan
 Hovold" <johan+linaro@kernel.org>,
        Xilin Wu <wuxilin123@gmail.com>,
        "Bryan
 O'Donoghue" <bryan.odonoghue@linaro.org>
References: <20240424-qcom-pd-mapper-v7-0-05f7fc646e0f@linaro.org>
 <20240424-qcom-pd-mapper-v7-6-05f7fc646e0f@linaro.org>
 <f1ee1fc0-64cb-5610-db92-3a06d477e8b8@quicinc.com>
 <CAA8EJpoDuKyy2_7Lwih6gLW3UO4sduV6Fun6RSzJg6RHSHgMsQ@mail.gmail.com>
From: Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <CAA8EJpoDuKyy2_7Lwih6gLW3UO4sduV6Fun6RSzJg6RHSHgMsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1ZNo0XrL8Z5_WB9kGUd_O0h6h4NCf8Kg
X-Proofpoint-GUID: 1ZNo0XrL8Z5_WB9kGUd_O0h6h4NCf8Kg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300137



On 4/26/2024 6:36 PM, Dmitry Baryshkov wrote:
> On Sat, 27 Apr 2024 at 04:03, Chris Lew <quic_clew@quicinc.com> wrote:
>>
>>
>>
>> On 4/24/2024 2:28 AM, Dmitry Baryshkov wrote:
>>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
>>> index 1d24c9b656a8..02d0c626b03b 100644
>>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>>> @@ -23,6 +23,7 @@
>>>    #include <linux/remoteproc.h>
>>>    #include <linux/reset.h>
>>>    #include <linux/soc/qcom/mdt_loader.h>
>>> +#include <linux/soc/qcom/pd_mapper.h>
>>>    #include <linux/soc/qcom/smem.h>
>>>    #include <linux/soc/qcom/smem_state.h>
>>>
>>> @@ -375,10 +376,14 @@ static int adsp_start(struct rproc *rproc)
>>>        int ret;
>>>        unsigned int val;
>>>
>>> -     ret = qcom_q6v5_prepare(&adsp->q6v5);
>>> +     ret = qcom_pdm_get();
>>>        if (ret)
>>>                return ret;
>>
>> Would it make sense to try and model this as a rproc subdev? This
>> section of the remoteproc code seems to be focused on making specific
>> calls to setup and enable hardware resources, where as pd mapper is
>> software.
>>
>> sysmon and ssr are also purely software and they are modeled as subdevs
>> in qcom_common. I'm not an expert on remoteproc organization but this
>> was just a thought.
> 
> Well, the issue is that the pd-mapper is a global, not a per-remoteproc instance
> 

Both sysmon and ssr have some kind of global states that they manage 
too. Each subdev functionality tends to be a mix of per-remoteproc 
instance management and global state management.

If pd-mapper was completely global, pd-mapper would be able to 
instantiate by itself. Instead, instantiation is dependent on each 
remoteproc instance properly getting and putting references.

The pdm subdev could manage the references to pd-mapper for that 
remoteproc instance.

On the other hand, I think Bjorn recommended this could be moved to 
probe time in v4. The v4 version was doing the reinitialization-dance, 
but I think the recommendation could still apply to this version.

>>
>> Thanks!
>> Chris
>>
>>>
>>> +     ret = qcom_q6v5_prepare(&adsp->q6v5);
>>> +     if (ret)
>>> +             goto put_pdm;
>>> +
>>>        ret = adsp_map_carveout(rproc);
>>>        if (ret) {
>>>                dev_err(adsp->dev, "ADSP smmu mapping failed\n");
>>> @@ -446,6 +451,8 @@ static int adsp_start(struct rproc *rproc)
>>>        adsp_unmap_carveout(rproc);
>>>    disable_irqs:
>>>        qcom_q6v5_unprepare(&adsp->q6v5);
>>> +put_pdm:
>>> +     qcom_pdm_release();
>>>
>>>        return ret;
>>>    }
>>
> 
> 

