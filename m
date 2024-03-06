Return-Path: <linux-kernel+bounces-94611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CDD874218
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0EA1C22084
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3871B809;
	Wed,  6 Mar 2024 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fC5LTY5q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3BC175A5;
	Wed,  6 Mar 2024 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761071; cv=none; b=Ot/UHn5mf4hLJZ8pKmOV1Kg8Woyun3JYisHWU1Tnwc2fUMfdsjzeLoUH2MUsPGRL234UdHg1fDlWeKoN/XRP/z7B9nqNigxW7Z3tp0/+dNX/aznn47cMxkImUlWhq09dj9CMarAtdiumg1T61crDu9Te83sVIpMghs2em+ktJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761071; c=relaxed/simple;
	bh=IIwyZCTYC1DV5wVwrhueK1Yz7GyKvMRSYiumqubQs2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PhwutYezbMSsj5fGOOhgcjCw0vXeOIDdc3vQw09QdqLOEu/uMJFklAVSxwhUwphpzbSHNrwSt+Ehit8TVAD5AoG/QdmMgEpAdsv/1uU/ONam3ye/SD8q27PE0Tf0f/8Z5eFqVk3SLQTRxAXmBEgCRmpH7RjFMEpszo+T6/IOte8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fC5LTY5q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426IKvck014960;
	Wed, 6 Mar 2024 21:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=laqVYnETKhJ1nPYMmkY2leBHH5rGMvNEYckv6LpZBsk=; b=fC
	5LTY5qudSjj1698H9CSgyY9VPChIsuGzvzbDudKkLM0Ccn4O9d2LGhO+dGaQl81r
	G47x0I6A+hiJaVaJquLrdmf2LeoAmI5zzrLzcT6e5pw0EZAjiyTLn5+fqCrD+lwO
	U7tQxxt/2NhpkiIcrVD8IDraWqaeSedK1ZIAjkoASdIQm6XiipSMYk6mSAd8CLue
	iL3ZGOugcTqSRL788DjWWvtqCydXupqNzVGaWsBIe7iE6KN+ZVjQMLXOJQTNYwFt
	Lom7WkLtHUVNz5DV+9O+anilOa2mAtPIBZ7NKe0g28ShdQmu9iOlkn2QMrmFijVa
	0UJAYv6ce+Krjn22sKRQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpepcag6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 21:37:34 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426LbYeG028696
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 21:37:34 GMT
Received: from [10.110.60.96] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 13:37:31 -0800
Message-ID: <f99d957b-7494-4f89-aa06-8016593301d2@quicinc.com>
Date: Wed, 6 Mar 2024 13:37:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] firmware: qcom-scm: Support multiple waitq contexts
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>,
        "Murali
 Nalajala" <quic_mnalajal@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>
References: <20240228-multi_waitq-v1-0-ccb096419af0@quicinc.com>
 <20240228-multi_waitq-v1-2-ccb096419af0@quicinc.com>
 <20240305222816.GD3213752@hu-bjorande-lv.qualcomm.com>
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
In-Reply-To: <20240305222816.GD3213752@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DIBvlQ-9LD1Z8Jh28y89y9kGdCv8y5My
X-Proofpoint-ORIG-GUID: DIBvlQ-9LD1Z8Jh28y89y9kGdCv8y5My
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403060175



On 3/5/2024 2:28 PM, Bjorn Andersson wrote:
> On Wed, Feb 28, 2024 at 10:50:00AM -0800, Unnathi Chalicheemala wrote:
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
> 
> No client driver will be prepared to handle an EPROBE_DEFER from here.
> 
>> +			}
>> +
>> +			ret = qcom_scm_wait_for_wq_completion(dev_get_drvdata(dev), wq_ctx);
> 
> I think it's fine to just continue to rely on __scm in the callee. If
> you don't agree, please consider this a separate cleanup patch.
> 

Yes, sure. I will remove the !dev check. 

>>  			if (ret)
>>  				return ret;
>>  
>> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
>> index c1be8270ead1..4606c49ef155 100644
>> --- a/drivers/firmware/qcom/qcom_scm.c
>> +++ b/drivers/firmware/qcom/qcom_scm.c
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
> 
> What happens if qcom_scm_waitq_wakeup() is invoked concurrently with
> qcom_scm_waitq_wakeup(), such that both find wq = NULL here?
> 

Ack. Thanks, I didn't check this race condition. I will define a mutex to check for
wq=NULL before creating one.

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
> 
> I'm confused, when I reviewed this previously I expressed that unless "a
> few" is more than 73, or that the value space is sparse, the use of an
> xarray only complicates the implementation.
> 
> Either describe why this wouldn't work, or use a statically sized array.
> 

Sorry I missed this comment. I'll check and change this to a static array
in the next version.

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
> 
> You don't attempt to wait until a few lines further down, so this error
> message doesn't seem to reflect the actual problem that occurred. Seems
> like this will only ever be ENOMEM in practice, in which case we
> shouldn't print an error, right?
> 
> dev_err() seems suitable if this remains though.
> 

Ack. You're right; will use dev_err().

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
> 
> As above.
> 

Ack. Thanks a lot for the review Bjorn!

> Regards,
> Bjorn
> 
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
>>  int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);
>>  
>>  #define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
>>
>> -- 
>> 2.25.1
>>

