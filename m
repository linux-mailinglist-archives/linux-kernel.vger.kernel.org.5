Return-Path: <linux-kernel+bounces-85403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEDC86B56C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8173B23D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A503FBA6;
	Wed, 28 Feb 2024 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lpwxnPBr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACFD208D7;
	Wed, 28 Feb 2024 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139673; cv=none; b=UcpFLYGKL2CR8q7duBgdCiJF695k1uLxxEXGJowgCoFEz0kir6oNpaJQHt76eYbH2Y4cf9RpX5qQBA8HWjda/Xqpjpdp8IWmQ9fkewpKjP1PyahYv/2lEy/PTQ7fU5iiBfn7KuY5GI9GTpSMfgDtOtt4GNSPAA+l19TWv0tejKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139673; c=relaxed/simple;
	bh=byrBJK1PNV5TLon9imE4YeO9CVPH8UfV/Eu8yZXb18g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o1jEYIlyUkRMZkBYsbpxH5xX+AddPJ070sbaWDAn/fhBP4yi7a7xX41LUbk5oPIl1Nj2NQCOX8DyKpJYF8g0stiHlPLRd7T2ZFwkQiYoTHW6W7hlZHMNWT8Vkp++HLyYmgNh4D5kyvLm1jC6aFtRMh2K/UaQnFTcYcH371WWGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lpwxnPBr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S97P1b023466;
	Wed, 28 Feb 2024 17:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kDrZQYUzq9AttFHiMFzCFe22kthPai9X0iD964whZFM=; b=lp
	wxnPBrR2WWOP0b3A25+YALReYorWG1W4XOxo+rG0R9yoa3Fy+l+JCYqMXdq9HXX5
	qJaPWjGYram+Q6LpshVAN125fP3sbfAXpG1WviUiWIl3dLii3gJiKA7v4Os45j8q
	VQDeM7tVMkZ+3J7Y4P0GpPI5xyxFV6MiEe08uvh5J9cQ4T5kR/PvB/akohQcDeSl
	VdJKrPaJlKAHtGG1r+ZwEIZ3bbl0Bpb2hVzNGgqKJx10MnOqFbEZCLbKqzEj2dLZ
	t+/IbnRpXhDQOiIHJ7S8ODWPrIkvQpNiTyeztZ/eYLjFylPBp+ejoD8zzsjhlIsP
	ae+r2KXEeqtfsQl0H8mQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whw3f1tvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 17:00:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SH0vaf030707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 17:00:57 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 09:00:53 -0800
Message-ID: <2608b2d8-f3b0-b4f5-f8e4-1f2242043ded@quicinc.com>
Date: Wed, 28 Feb 2024 22:30:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3 2/2] cpufreq: scmi: Register for limit change
 notifications
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <pierre.gondois@arm.com>,
        <dietmar.eggemann@arm.com>, <morten.rasmussen@arm.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <cristian.marussi@arm.com>, <sudeep.holla@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mdtipton@quicinc.com>, <linux-arm-msm@vger.kernel.org>
References: <20240227181632.659133-1-quic_sibis@quicinc.com>
 <20240227181632.659133-3-quic_sibis@quicinc.com>
 <f8bfc666-c216-44d5-a63b-99f04ff3b8ef@arm.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <f8bfc666-c216-44d5-a63b-99f04ff3b8ef@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Agk_FTkjIhwQNOGXeoMtaveUuzBaBums
X-Proofpoint-GUID: Agk_FTkjIhwQNOGXeoMtaveUuzBaBums
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402280133



On 2/28/24 18:54, Lukasz Luba wrote:
> 
> 
> On 2/27/24 18:16, Sibi Sankar wrote:
>> Register for limit change notifications if supported and use the 
>> throttled
>> frequency from the notification to apply HW pressure.

Lukasz,

Thanks for taking time to review the series!

>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> v3:
>> * Sanitize range_max received from the notifier. [Pierre]
>> * Update commit message.
>>
>>   drivers/cpufreq/scmi-cpufreq.c | 29 ++++++++++++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c 
>> b/drivers/cpufreq/scmi-cpufreq.c
>> index 76a0ddbd9d24..78b87b72962d 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -25,9 +25,13 @@ struct scmi_data {
>>       int domain_id;
>>       int nr_opp;
>>       struct device *cpu_dev;
>> +    struct cpufreq_policy *policy;
>>       cpumask_var_t opp_shared_cpus;
>> +    struct notifier_block limit_notify_nb;
>>   };
>> +const struct scmi_handle *handle;
>> +static struct scmi_device *scmi_dev;
>>   static struct scmi_protocol_handle *ph;
>>   static const struct scmi_perf_proto_ops *perf_ops;
>>   static struct cpufreq_driver scmi_cpufreq_driver;
>> @@ -151,6 +155,20 @@ static struct freq_attr *scmi_cpufreq_hw_attr[] = {
>>       NULL,
>>   };
>> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned 
>> long event, void *data)
>> +{
>> +    struct scmi_data *priv = container_of(nb, struct scmi_data, 
>> limit_notify_nb);
>> +    struct scmi_perf_limits_report *limit_notify = data;
>> +    struct cpufreq_policy *policy = priv->policy;
>> +
>> +    policy->max = clamp(limit_notify->range_max_freq/HZ_PER_KHZ, 
>> policy->cpuinfo.min_freq,
>> +                policy->cpuinfo.max_freq);
> 
> Please take the division operation out of this clamp() call, somewhere
> above. Currently it 'blurs' these stuff, while it's important convertion
> to khz. You can call it e.g.:
> 
> limit_freq_khz = limit_notify->range_max_freq / HZ_PER_KHZ;
> 
> then use in clamp(limit_freq_khz, ...)

ack

> 
>> +
>> +    cpufreq_update_pressure(policy);
>> +
>> +    return NOTIFY_OK;
>> +}
>> +
>>   static int scmi_cpufreq_init(struct cpufreq_policy *policy)
>>   {
>>       int ret, nr_opp, domain;
>> @@ -269,6 +287,15 @@ static int scmi_cpufreq_init(struct 
>> cpufreq_policy *policy)
>>           }
>>       }
>> +    priv->limit_notify_nb.notifier_call = scmi_limit_notify_cb;
>> +    ret = handle->notify_ops->devm_event_notifier_register(scmi_dev, 
>> SCMI_PROTOCOL_PERF,
>> +                            SCMI_EVENT_PERFORMANCE_LIMITS_CHANGED,
>> +                            &domain,
>> +                            &priv->limit_notify_nb);
>> +    if (ret)
>> +        dev_warn(cpu_dev,
>> +             "failed to register for limits change notifier for 
>> domain %d\n", domain);
>> +
>>       priv->policy = policy;
>>       return 0;
>> @@ -342,8 +369,8 @@ static int scmi_cpufreq_probe(struct scmi_device 
>> *sdev)
>>   {
>>       int ret;
>>       struct device *dev = &sdev->dev;
>> -    const struct scmi_handle *handle;
> 
> It should be a compilation error...
> 
>> +    scmi_dev = sdev;
>>       handle = sdev->handle;
> 
> due to usage here, wasn't it?

Not really, isn't it getting the first initialization here?
Are there any compiler options that I need to turn on to
catch these?

-Sibi

> 
>>       if (!handle)

