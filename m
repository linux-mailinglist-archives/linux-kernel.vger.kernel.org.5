Return-Path: <linux-kernel+bounces-83937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5E086A046
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EEC1C24E51
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F9E13A891;
	Tue, 27 Feb 2024 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hFrQP6av"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2CC2D60B;
	Tue, 27 Feb 2024 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062382; cv=none; b=WQBZR1L5iIr5WFRxuOglk9mWVVi6YN8XwcUzOMJGWPwdCbxIn0yZp/NAhAiQ+RnJOVhNKyAwasrvtmC30kQH4U+MizqbQY5CykHFBt1awN8XWLqcb+0D0jC7VZH45ZN9fsL/YxqqSWQFQFO/lED4V2pYCnXOxnNQdYOROQrAEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062382; c=relaxed/simple;
	bh=rH3Rvw3OhcbG2+ZhusfjTExRHzkSVF49LWJYUyw2w6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cdeLxG2NIlBR1u942JXgqo8WG0xSOtt8FJKJtCz5G8Gn8n9B2R8eQwYTWvUnQds7nnBigtJHgauF+KiUxP2HaCtaFNtpsodKXcrJ2ogfYIuxGdn4ybUJbkSv9EgtE8Eevv6Ey5ojNFBmeNOAO+KiVzmIhH0zDsAepjaZwJk+cKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hFrQP6av; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9Yw5k020990;
	Tue, 27 Feb 2024 19:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4rgs/+JhDQ/M7BmZhgx83ZFnIZeMbAxrqVJ/CrWjNDg=; b=hF
	rQP6avAMhGCdvX4XiuJNHBGEjaSyFgrE6CjAJBchJTmbMQHIyU6S7yEejRI6kdHD
	YhtF9JYbW3hd4NnuQsf5OcwsyuVouF/mkWybWYff/x3PEvHggJxtpo3DckSV+fo2
	zuwAUtBr3ZYfiAWFVZa1A/7NOl+br5zkqbCvfx44Sf2WWImKleQjJ2Nn5aADpbPb
	95ixbBa82EHs2f5EyQRdnZJCGWbxMVzfiqQsEoceqyBbfWTwUwUS+jnOD1oWbNb3
	LT+edXXxIxLgJ/A2k3210CKCUr8iXxCe/Ge8WnVcCZHl/CEzu9dYOzOntpInI7JD
	wEueGQUM+uT5EdPk+5qg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh89t233a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 19:32:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RJWpIk032041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 19:32:51 GMT
Received: from [10.110.28.247] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 11:32:50 -0800
Message-ID: <2b68e15b-71ce-cf3b-a42d-e3e18aeb5ef2@quicinc.com>
Date: Tue, 27 Feb 2024 11:32:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3 1/2] cpufreq: Export cpufreq_update_pressure
To: Sibi Sankar <quic_sibis@quicinc.com>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20240227181632.659133-1-quic_sibis@quicinc.com>
 <20240227181632.659133-2-quic_sibis@quicinc.com>
Content-Language: en-US
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20240227181632.659133-2-quic_sibis@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ePa0O3hmRhspncpvJM9k6cpA0XTw5_Dz
X-Proofpoint-GUID: ePa0O3hmRhspncpvJM9k6cpA0XTw5_Dz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 mlxlogscore=997
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270152

On 2/27/2024 10:16 AM, Sibi Sankar wrote:
> The SCMI cpufreq driver doesn't require any additional signal
> smoothing provided by arch_update_hw_pressure interface, export
> cpufreq_update_pressure so that it can be called upon directly
> instead.
> 
> Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  include/linux/cpufreq.h   | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 76002aa3d12d..bdec2dfd77eb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2573,7 +2573,7 @@ DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
>   *
>   * Update the value of cpufreq pressure for all @cpus in the policy.
>   */
> -static void cpufreq_update_pressure(struct cpufreq_policy *policy)
> +void cpufreq_update_pressure(struct cpufreq_policy *policy)
>  {
>  	unsigned long max_capacity, capped_freq, pressure;
>  	u32 max_freq;
> @@ -2598,6 +2598,7 @@ static void cpufreq_update_pressure(struct cpufreq_policy *policy)
>  	for_each_cpu(cpu, policy->related_cpus)
>  		WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
>  }
> +EXPORT_SYMBOL(cpufreq_update_pressure);

EXPORT_SYMBOL_GPL please. Other symbols in this file are _GPL as well. 

>  
>  /**
>   * cpufreq_set_policy - Modify cpufreq policy parameters.
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 414bfc976b30..957bf8e4ca0d 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -241,6 +241,7 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
>  void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
>  void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
>  bool has_target_index(void);
> +void cpufreq_update_pressure(struct cpufreq_policy *policy);
>  
>  DECLARE_PER_CPU(unsigned long, cpufreq_pressure);
>  static inline unsigned long cpufreq_get_pressure(int cpu)
> @@ -270,6 +271,7 @@ static inline bool cpufreq_supports_freq_invariance(void)
>  }
>  static inline void disable_cpufreq(void) { }
>  static inline void cpufreq_update_limits(unsigned int cpu) { }
> +static inline void cpufreq_update_pressure(struct cpufreq_policy *policy) { }
>  static inline unsigned long cpufreq_get_pressure(int cpu)
>  {
>  	return 0;
-- 
---Trilok Soni


