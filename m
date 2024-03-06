Return-Path: <linux-kernel+bounces-94382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD47873E50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E691F218E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7333513DB9C;
	Wed,  6 Mar 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OLqJT9LM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B25E08B;
	Wed,  6 Mar 2024 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748876; cv=none; b=UyaNmwxG9hrUUOYUhW2TRU4vDvVIpmtSGtV1UtaVklFILXtQwVKXjj/qh4GYhTCdhe7dCty8h/RgixoemYU+XDN+lK8tV2KthjJmkcO7aYMX2y80J8vihK2yeEQa3HH5aoIi0bsJR/cpZiFthTP1QxVxaDEbQlkIMFTgBHNh1MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748876; c=relaxed/simple;
	bh=RxbKhrbB/2wp+JwxPDNZ1Kp+Gp6gIS9JiuKrB6E8jWU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Itv0Rn91IqvDG5Jk+WdJQuo638XCragRNvnk6pHViJmR+cOBsL6bAKHlgCjg3zCrPWJkxzjdFPEPbVZ+5NE2HKRKNt9oHW/ZAAqbV7QnZTFVVC/mZ6UgD1BWJ8BaynyxIvRg2epFAqeoddjtgtxiDAHuHcVYpfJdohzOf53rTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OLqJT9LM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426GX29a028967;
	Wed, 6 Mar 2024 18:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ek62/UHujTn/7BPy3SR8QOhUnwaCquQK4Du0Pb3j7yQ=; b=OL
	qJT9LMO1MX1TuoGw4DwtBUKEQ+de+6NEj6+T0JCOsgrTwiQtL0rzhCalLa2jLShb
	vYnsS41k7pyf221RdfPhLUEWNyEjk3XpxxnJbce2OXaFEL2jjdmdWerd2wsM2AH1
	YHtld+5LAjEakTEvnWulljG5NkmFvxWkeEM4l6CT59GN5rLBjHq2L79FvZ9Jp7TH
	LDi4RUYw29PZvPTegfuEVtnICemphpdO+pzVE9ZZr6sTHMzAJoBePIoH9ogEhF2U
	Fxzn3cj9QQEV3hKtd5tAODll996U9FGBHUuEJ6Ap+d+0XpkPOekvqA/RlLLSYAm+
	M4125OQ9XDT4X+qk/u7w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpm4v9e2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 18:14:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426IET2x028443
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 18:14:29 GMT
Received: from [10.110.60.96] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 10:14:26 -0800
Message-ID: <32baf45d-b118-4476-a30b-3ad461ffdf1d@quicinc.com>
Date: Wed, 6 Mar 2024 10:14:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Subject: Re: [PATCH 2/3] firmware: qcom-scm: Support multiple waitq contexts
To: Chris Lew <quic_clew@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Prasad Sodagudi <quic_psodagud@quicinc.com>,
        "Murali
 Nalajala" <quic_mnalajal@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>
References: <20240228-multi_waitq-v1-0-ccb096419af0@quicinc.com>
 <20240228-multi_waitq-v1-2-ccb096419af0@quicinc.com>
 <d35c79eb-71be-c9eb-801a-0a08a145d36f@quicinc.com>
Content-Language: en-US
In-Reply-To: <d35c79eb-71be-c9eb-801a-0a08a145d36f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bfuuHHe-LSch-SEFuGjyJFZYp2p3kqQA
X-Proofpoint-GUID: bfuuHHe-LSch-SEFuGjyJFZYp2p3kqQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_11,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060146



On 2/28/2024 3:20 PM, Chris Lew wrote:
> 
> 
> On 2/28/2024 10:50 AM, Unnathi Chalicheemala wrote:
>> Currently, only a single waitqueue context is supported, with waitqueue
>> id zero. SM8650 firmware now supports multiple waitqueue contexts, so
>> add support to dynamically create and support as many unique waitqueue
>> contexts as firmware returns to the driver.
>> Unique waitqueue contexts are supported using xarray to create a
>> hash table for associating a unique wq_ctx with a struct completion
>> variable for easy lookup.
>> The waitqueue ids can be >=0 as now we have more than one waitqueue
>> context.
>>
>> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
>> ---
>>  drivers/firmware/qcom/qcom_scm-smc.c |  7 +++-
>>  drivers/firmware/qcom/qcom_scm.c     | 77 ++++++++++++++++++++++++++----------
>>  drivers/firmware/qcom/qcom_scm.h     |  3 +-
>>  3 files changed, 64 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
>> index 16cf88acfa8e..80083e3615b1 100644
>> --- a/drivers/firmware/qcom/qcom_scm-smc.c
>> +++ b/drivers/firmware/qcom/qcom_scm-smc.c
>> @@ -103,7 +103,12 @@ static int __scm_smc_do_quirk_handle_waitq(struct device *dev, struct arm_smccc_
>>  			wq_ctx = res->a1;
>>  			smc_call_ctx = res->a2;
>>  
>> -			ret = qcom_scm_wait_for_wq_completion(wq_ctx);
>> +			if (!dev) {
>> +				/* Protect the dev_get_drvdata() call that follows */
>> +				return -EPROBE_DEFER;
>> +			}
>> +
> 
> Do we need to do this !dev check within the do/while loop? Seems like it
> could be done once at the start.
> 
Apologies for the late reply Chris.
Yes, will move this check out side the do {} while() loop.

>> +			ret = qcom_scm_wait_for_wq_completion(dev_get_drvdata(dev), wq_ctx);
>>  			if (ret)
>>  				return ret;
>>  
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index c1be8270ead1..4606c49ef155 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/reset-controller.h>
>>  #include <linux/types.h>
>> +#include <linux/xarray.h>
>>  
>>  #include "qcom_scm.h"
>>  
>> @@ -33,7 +34,7 @@ struct qcom_scm {
>>  	struct clk *iface_clk;
>>  	struct clk *bus_clk;
>>  	struct icc_path *path;
>> -	struct completion waitq_comp;
>> +	struct xarray waitq;
>>  	struct reset_controller_dev reset;
>>  
>>  	/* control access to the interconnect path */
>> @@ -1742,42 +1743,74 @@ bool qcom_scm_is_available(void)
>>  }
>>  EXPORT_SYMBOL_GPL(qcom_scm_is_available);
>>  
>> -static int qcom_scm_assert_valid_wq_ctx(u32 wq_ctx)
>> +static struct completion *qcom_scm_get_completion(struct qcom_scm *scm, u32 wq_ctx)
>>  {
>> -	/* FW currently only supports a single wq_ctx (zero).
>> -	 * TODO: Update this logic to include dynamic allocation and lookup of
>> -	 * completion structs when FW supports more wq_ctx values.
>> +	struct completion *wq;
>> +	struct completion *old;
>> +	int err;
>> +
>> +	wq = xa_load(&scm->waitq, wq_ctx);
>> +	if (wq) {
>> +		/*
>> +		 * Valid struct completion *wq found corresponding to
>> +		 * given wq_ctx. We're done here.
>> +		 */
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * If a struct completion *wq does not exist for wq_ctx, create it. FW
>> +	 * only uses a finite number of wq_ctx values, so we will be reaching
>> +	 * here only a few times right at the beginning of the device's uptime
>> +	 * and then early-exit from idr_find() above subsequently.
>>  	 */
>> -	if (wq_ctx != 0) {
>> -		dev_err(__scm->dev, "Firmware unexpectedly passed non-zero wq_ctx\n");
>> -		return -EINVAL;
>> +	wq = kzalloc(sizeof(*wq), GFP_ATOMIC);
>> +	if (!wq) {
>> +		wq = ERR_PTR(-ENOMEM);
>> +		goto out;
>>  	}
>>  
>> -	return 0;
>> +	init_completion(wq);
>> +
>> +	old = xa_store(&scm->waitq, wq_ctx, wq, GFP_ATOMIC);
>> +	err = xa_err(old);
>> +	if (err) {
>> +		kfree(wq);
>> +		wq = ERR_PTR(err);
>> +	}
>> +
> 
> Any chance for this function to be called concurrently before there is a
> valid wq stored in the xarray? If that were to happen we could have two
> valid xa_stores happen on the same wq_ctx. One of the entries would be
> returned as old and might be leaked depending on timing.
> 

Thanks for pointing this out. Yes, this function is called every time a
qcom_smc_call() is made. But xarray documentation says that xa_store() uses
an internal xa_lock to synchronize accesses - I will look more into this.

To prevent rewriting entries at same wq_ctx, I think xa_store can be replaced
with xa_insert() - it'll prevent rewrite on existing entry.

>> +out:
>> +	return wq;
>>  }
>>  
>> -int qcom_scm_wait_for_wq_completion(u32 wq_ctx)
>> +int qcom_scm_wait_for_wq_completion(struct qcom_scm *scm, u32 wq_ctx)
>>  {
>> -	int ret;
>> +	struct completion *wq;
>>  
>> -	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
>> -	if (ret)
>> -		return ret;
>> +	wq = qcom_scm_get_completion(scm, wq_ctx);
>> +	if (IS_ERR(wq)) {
>> +		pr_err("Unable to wait on invalid waitqueue for wq_ctx %d: %ld\n",
>> +						wq_ctx, PTR_ERR(wq));
>> +		return PTR_ERR(wq);
>> +	}
>>  
>> -	wait_for_completion(&__scm->waitq_comp);
>> +	wait_for_completion(wq);
>>  
>>  	return 0;
>>  }
>>  
>>  static int qcom_scm_waitq_wakeup(struct qcom_scm *scm, unsigned int wq_ctx)
>>  {
>> -	int ret;
>> +	struct completion *wq;
>>  
>> -	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
>> -	if (ret)
>> -		return ret;
>> +	wq = qcom_scm_get_completion(scm, wq_ctx);
>> +	if (IS_ERR(wq)) {
>> +		pr_err("Unable to wake up invalid waitqueue for wq_ctx %d: %ld\n",
>> +						wq_ctx, PTR_ERR(wq));
>> +		return PTR_ERR(wq);
>> +	}
>>  
>> -	complete(&__scm->waitq_comp);
>> +	complete(wq);
>>  
>>  	return 0;
>>  }
>> @@ -1854,7 +1887,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> -	init_completion(&scm->waitq_comp);
>> +	platform_set_drvdata(pdev, scm);
>> +
>> +	xa_init(&scm->waitq);
>>  
>>  	__scm = scm;
>>  	__scm->dev = &pdev->dev;
>> diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
>> index 4532907e8489..d54df5a2b690 100644
>> --- a/drivers/firmware/qcom/qcom_scm.h
>> +++ b/drivers/firmware/qcom/qcom_scm.h
>> @@ -62,7 +62,8 @@ struct qcom_scm_res {
>>  	u64 result[MAX_QCOM_SCM_RETS];
>>  };
>>  
>> -int qcom_scm_wait_for_wq_completion(u32 wq_ctx);
>> +struct qcom_scm;
>> +int qcom_scm_wait_for_wq_completion(struct qcom_scm *scm, u32 wq_ctx);
> 
> Is there a benefit to having qcom_scm passed in? I see we're adding scm
> as drvdata in this patch, but we still have a single global __scm
> pointer in qcom_scm.c. Are there going to be multiple instances of the
> qcom_scm device?
> 

I'll check and remove if possible.
Thanks a lot for the review Chris!

> Thanks,
> Chris
> 
>>  int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);
>>  
>>  #define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
>>

