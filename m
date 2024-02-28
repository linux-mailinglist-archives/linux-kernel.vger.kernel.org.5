Return-Path: <linux-kernel+bounces-85842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B486BC17
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947561C20B38
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312AD13D30A;
	Wed, 28 Feb 2024 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QvojPPhU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0082261D;
	Wed, 28 Feb 2024 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162484; cv=none; b=uaQHO3bdDNZF7ikBc2YMeV6oyrcUxQb9pUKHDyAOh3a3/yFY/BPo3en19hVHRNhglAVLvEbTA6kJiH6pZilU6SfYFfYK9ay8C2jofaAd3Obw83B5r3q/Rdif92fdno8QviPUcw8FxyYRIKItOE/6rHLVNBiHM3UiVVKMH6Nf9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162484; c=relaxed/simple;
	bh=llMgPqBOhKYxH2Pt+Lj+fDQYa1bH7rX7zuj8F/YrXok=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qwTG7k30radBH+vm8KMP5EhQWNB/Trv1zDvRBP8ZlIc5QltJYKNpySFX9rVhv7hrA6WDm+uZ1gES26GAkr7Tp3R6KQOVRNA7UqlWyWk/QjHGPreGXJbYTvfn7aypqeN3OqsHrAQJFXAr7O35SEw+wJZcy1gSnx84QFAt3QpmqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QvojPPhU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SKDZWn007582;
	Wed, 28 Feb 2024 23:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TAU+hzFaUF/PYkSTeSlBUzwBl11309ihErorR6BD+wU=; b=Qv
	ojPPhUWUnCJKB2rbQOBcdX47nkeDqVBBO5k4BLmxAhmBZhkYvvFIZqkhxCjbZMkD
	s2ZtOL1naSHrFe5Qavsj/6KuFwj39YIlKyRu0IpKVNNmlIuAeTdH8KJ7eJ7xJXsQ
	vvMucuybIaOtNzkbFhRoV8oFAaAZQkyyeqXjxPrwrf8o7JqyE9DFqqj+w0AH2t0W
	WMVOe3GjyFtMzoQd0hKasIaqaE1c72hAq50+e7dzIMzfI9psQqZe+YxHAwyv6jsD
	JgjwoBlVkyflOVl68VI4YUCMgWdaMbwdwL+ZrOtY+L23echHKsCkUSLWL4ugchZ5
	wwlQfTH9Y2CVrv5FmLxA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wja0egjm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 23:21:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SNLHrp001908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 23:21:17 GMT
Received: from [192.168.142.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 15:21:13 -0800
Message-ID: <d35c79eb-71be-c9eb-801a-0a08a145d36f@quicinc.com>
Date: Wed, 28 Feb 2024 15:20:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] firmware: qcom-scm: Support multiple waitq contexts
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Prasad Sodagudi <quic_psdoagud@quicinc.com>,
        "Murali
 Nalajala" <quic_mnalajal@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>
References: <20240228-multi_waitq-v1-0-ccb096419af0@quicinc.com>
 <20240228-multi_waitq-v1-2-ccb096419af0@quicinc.com>
Content-Language: en-US
From: Chris Lew <quic_clew@quicinc.com>
In-Reply-To: <20240228-multi_waitq-v1-2-ccb096419af0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9vZgvOUbxp5UYanx59wV73nngvohsgBR
X-Proofpoint-ORIG-GUID: 9vZgvOUbxp5UYanx59wV73nngvohsgBR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 impostorscore=0 adultscore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402280184



On 2/28/2024 10:50 AM, Unnathi Chalicheemala wrote:
> Currently, only a single waitqueue context is supported, with waitqueue
> id zero. SM8650 firmware now supports multiple waitqueue contexts, so
> add support to dynamically create and support as many unique waitqueue
> contexts as firmware returns to the driver.
> Unique waitqueue contexts are supported using xarray to create a
> hash table for associating a unique wq_ctx with a struct completion
> variable for easy lookup.
> The waitqueue ids can be >=0 as now we have more than one waitqueue
> context.
> 
> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm-smc.c |  7 +++-
>  drivers/firmware/qcom/qcom_scm.c     | 77 ++++++++++++++++++++++++++----------
>  drivers/firmware/qcom/qcom_scm.h     |  3 +-
>  3 files changed, 64 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
> index 16cf88acfa8e..80083e3615b1 100644
> --- a/drivers/firmware/qcom/qcom_scm-smc.c
> +++ b/drivers/firmware/qcom/qcom_scm-smc.c
> @@ -103,7 +103,12 @@ static int __scm_smc_do_quirk_handle_waitq(struct device *dev, struct arm_smccc_
>  			wq_ctx = res->a1;
>  			smc_call_ctx = res->a2;
>  
> -			ret = qcom_scm_wait_for_wq_completion(wq_ctx);
> +			if (!dev) {
> +				/* Protect the dev_get_drvdata() call that follows */
> +				return -EPROBE_DEFER;
> +			}
> +

Do we need to do this !dev check within the do/while loop? Seems like it
could be done once at the start.

> +			ret = qcom_scm_wait_for_wq_completion(dev_get_drvdata(dev), wq_ctx);
>  			if (ret)
>  				return ret;
>  
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index c1be8270ead1..4606c49ef155 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -21,6 +21,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset-controller.h>
>  #include <linux/types.h>
> +#include <linux/xarray.h>
>  
>  #include "qcom_scm.h"
>  
> @@ -33,7 +34,7 @@ struct qcom_scm {
>  	struct clk *iface_clk;
>  	struct clk *bus_clk;
>  	struct icc_path *path;
> -	struct completion waitq_comp;
> +	struct xarray waitq;
>  	struct reset_controller_dev reset;
>  
>  	/* control access to the interconnect path */
> @@ -1742,42 +1743,74 @@ bool qcom_scm_is_available(void)
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_is_available);
>  
> -static int qcom_scm_assert_valid_wq_ctx(u32 wq_ctx)
> +static struct completion *qcom_scm_get_completion(struct qcom_scm *scm, u32 wq_ctx)
>  {
> -	/* FW currently only supports a single wq_ctx (zero).
> -	 * TODO: Update this logic to include dynamic allocation and lookup of
> -	 * completion structs when FW supports more wq_ctx values.
> +	struct completion *wq;
> +	struct completion *old;
> +	int err;
> +
> +	wq = xa_load(&scm->waitq, wq_ctx);
> +	if (wq) {
> +		/*
> +		 * Valid struct completion *wq found corresponding to
> +		 * given wq_ctx. We're done here.
> +		 */
> +		goto out;
> +	}
> +
> +	/*
> +	 * If a struct completion *wq does not exist for wq_ctx, create it. FW
> +	 * only uses a finite number of wq_ctx values, so we will be reaching
> +	 * here only a few times right at the beginning of the device's uptime
> +	 * and then early-exit from idr_find() above subsequently.
>  	 */
> -	if (wq_ctx != 0) {
> -		dev_err(__scm->dev, "Firmware unexpectedly passed non-zero wq_ctx\n");
> -		return -EINVAL;
> +	wq = kzalloc(sizeof(*wq), GFP_ATOMIC);
> +	if (!wq) {
> +		wq = ERR_PTR(-ENOMEM);
> +		goto out;
>  	}
>  
> -	return 0;
> +	init_completion(wq);
> +
> +	old = xa_store(&scm->waitq, wq_ctx, wq, GFP_ATOMIC);
> +	err = xa_err(old);
> +	if (err) {
> +		kfree(wq);
> +		wq = ERR_PTR(err);
> +	}
> +

Any chance for this function to be called concurrently before there is a
valid wq stored in the xarray? If that were to happen we could have two
valid xa_stores happen on the same wq_ctx. One of the entries would be
returned as old and might be leaked depending on timing.

> +out:
> +	return wq;
>  }
>  
> -int qcom_scm_wait_for_wq_completion(u32 wq_ctx)
> +int qcom_scm_wait_for_wq_completion(struct qcom_scm *scm, u32 wq_ctx)
>  {
> -	int ret;
> +	struct completion *wq;
>  
> -	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
> -	if (ret)
> -		return ret;
> +	wq = qcom_scm_get_completion(scm, wq_ctx);
> +	if (IS_ERR(wq)) {
> +		pr_err("Unable to wait on invalid waitqueue for wq_ctx %d: %ld\n",
> +						wq_ctx, PTR_ERR(wq));
> +		return PTR_ERR(wq);
> +	}
>  
> -	wait_for_completion(&__scm->waitq_comp);
> +	wait_for_completion(wq);
>  
>  	return 0;
>  }
>  
>  static int qcom_scm_waitq_wakeup(struct qcom_scm *scm, unsigned int wq_ctx)
>  {
> -	int ret;
> +	struct completion *wq;
>  
> -	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
> -	if (ret)
> -		return ret;
> +	wq = qcom_scm_get_completion(scm, wq_ctx);
> +	if (IS_ERR(wq)) {
> +		pr_err("Unable to wake up invalid waitqueue for wq_ctx %d: %ld\n",
> +						wq_ctx, PTR_ERR(wq));
> +		return PTR_ERR(wq);
> +	}
>  
> -	complete(&__scm->waitq_comp);
> +	complete(wq);
>  
>  	return 0;
>  }
> @@ -1854,7 +1887,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	init_completion(&scm->waitq_comp);
> +	platform_set_drvdata(pdev, scm);
> +
> +	xa_init(&scm->waitq);
>  
>  	__scm = scm;
>  	__scm->dev = &pdev->dev;
> diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
> index 4532907e8489..d54df5a2b690 100644
> --- a/drivers/firmware/qcom/qcom_scm.h
> +++ b/drivers/firmware/qcom/qcom_scm.h
> @@ -62,7 +62,8 @@ struct qcom_scm_res {
>  	u64 result[MAX_QCOM_SCM_RETS];
>  };
>  
> -int qcom_scm_wait_for_wq_completion(u32 wq_ctx);
> +struct qcom_scm;
> +int qcom_scm_wait_for_wq_completion(struct qcom_scm *scm, u32 wq_ctx);

Is there a benefit to having qcom_scm passed in? I see we're adding scm
as drvdata in this patch, but we still have a single global __scm
pointer in qcom_scm.c. Are there going to be multiple instances of the
qcom_scm device?

Thanks,
Chris

>  int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);
>  
>  #define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
> 

