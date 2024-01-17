Return-Path: <linux-kernel+bounces-28628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4D78300ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E74FB2346C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA22CD272;
	Wed, 17 Jan 2024 08:01:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DBCD29B;
	Wed, 17 Jan 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478505; cv=none; b=RmSqbhECVGETf9E2XEEViky9Y3cKcK3QDSR0UMu7cRazhRc/J+rUhamyHB1mWU1xJX/kaV10R3jWmREDj+bVN3+UPBw9E6Pc86x5D7Y1s84UhyBQdV0uwPG4cqprBOuuCAsbXMja0sN0UAFvqryPBYpuZkDFP1cv3kuefT1mmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478505; c=relaxed/simple;
	bh=yb5BrpRTiH6NGEkCU9W7D4r0H6Act+ZlT/+5wPBw81U=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=swGP9d8H2yAO3Yu48Q7n3HGkzODCs9IaYYggcyt7KcRFxNW4LwVoFc59Lsk7IRuzNgAJrx6eBQmFqvkQAGQsU1UfzoiEfqqa0CaS+mGzQ03M+Q89vuXQfx0LwcQ7N+2Dhts9+mYYiPUlj7dnpd5V1dpvkV1vwGk1EBQWTRhdDSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD94FDA7;
	Wed, 17 Jan 2024 00:02:27 -0800 (PST)
Received: from [10.57.90.139] (unknown [10.57.90.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C01CD3F5A1;
	Wed, 17 Jan 2024 00:01:39 -0800 (PST)
Message-ID: <f427fb5b-f451-4d17-98e5-5f079a017735@arm.com>
Date: Wed, 17 Jan 2024 08:03:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpufreq: scmi: Register for limit change
 notifications
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-kernel@lists.infradead.org, viresh.kumar@linaro.org,
 rafael@kernel.org, cristian.marussi@arm.com, sudeep.holla@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20240108140118.1596-1-quic_sibis@quicinc.com>
 <20240108140118.1596-4-quic_sibis@quicinc.com>
 <94aad654-4f20-4b82-b978-77f1f9376dab@arm.com>
 <dca6e28e-8bde-be3e-bc3c-e97e349b3f04@quicinc.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <dca6e28e-8bde-be3e-bc3c-e97e349b3f04@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/17/24 02:58, Sibi Sankar wrote:
> 
> 
> On 1/10/24 13:56, Lukasz Luba wrote:
>> Hi Sibi,
>>
> 
> Hey Lukasz,
> Thanks for taking time to review the series!
> 
>> + Morten and Dietmar on CC
>>
>> On 1/8/24 14:01, Sibi Sankar wrote:
>>> Register for limit change notifications if supported with the help of
>>> perf_notify_support interface and determine the throttled frequency
>>> using the perf_opp_xlate to apply HW pressure.
>>>
>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>> ---
>>>   drivers/cpufreq/scmi-cpufreq.c | 42 +++++++++++++++++++++++++++++++++-
>>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/scmi-cpufreq.c 
>>> b/drivers/cpufreq/scmi-cpufreq.c
>>> index 4ee23f4ebf4a..53bc8868455d 100644
>>> --- a/drivers/cpufreq/scmi-cpufreq.c
>>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>>> @@ -25,9 +25,13 @@ struct scmi_data {
>>>       int domain_id;
>>>       int nr_opp;
>>>       struct device *cpu_dev;
>>> +    struct cpufreq_policy *policy;
>>>       cpumask_var_t opp_shared_cpus;
>>> +    struct notifier_block limit_notify_nb;
>>>   };
>>> +const struct scmi_handle *handle;
>>> +static struct scmi_device *scmi_dev;
>>>   static struct scmi_protocol_handle *ph;
>>>   static const struct scmi_perf_proto_ops *perf_ops;
>>> @@ -144,6 +148,22 @@ scmi_get_cpu_power(struct device *cpu_dev, 
>>> unsigned long *power,
>>>       return 0;
>>>   }
>>> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned 
>>> long event, void *data)
>>> +{
>>> +    unsigned long freq_hz;
>>> +    struct scmi_perf_limits_report *limit_notify = data;
>>> +    struct scmi_data *priv = container_of(nb, struct scmi_data, 
>>> limit_notify_nb);
>>> +    struct cpufreq_policy *policy = priv->policy;
>>> +
>>> +    if (perf_ops->perf_opp_xlate(ph, priv->domain_id, 
>>> limit_notify->range_max, &freq_hz))
>>> +        return NOTIFY_OK;
>>> +
>>> +    /* Update HW pressure (the boost frequencies are accepted) */
>>> +    arch_update_hw_pressure(policy->related_cpus, (freq_hz / 
>>> HZ_PER_KHZ));
>>
>> This is wrong. The whole idea of the new HW pressure was that I wanted
>> to get rid of the 'signal smoothing' mechanism in order to get
>> instantaneous value from FW to task scheduler. Vincent created
>> 2 interfaces in that new HW pressure:
>> 1. cpufreq_update_pressure(policy) - raw variable
>> 2. arch_update_hw_pressure(policy->related_cpus, (freq_hz / HZ_PER_KHZ))
>>     - smoothing PELT mechanism, good for raw IRQ in drivers
>>
>> In our SCMI cpufreq driver we need the 1st one:
>> cpufreq_update_pressure(policy)
>>
>> The FW will do the 'signal smoothing or filtering' and won't
>> flood the kernel with hundreds of notifications.
> 
> Ack, even though I see no mention of filtering being mandated in the 
> SCMI specification, the scmi notification by itself will serve as a
> rate limiter I guess.
> 
>>
>> So, please change that bit and add me, Morten and Dietmar on CC.
>> I would like to review it.
> 

True, the SCMI protocol doesn't describe the rate or limits of
often these performance limit notifications can be sent.
It's too HW specific and some balance has to made to not
flood the kernel with hundreds or thousands of notifications
per second. That could overload the SCMI channel.

The FW implementation has to combine the perf. limit
restrictions from different areas: thermal, power
conditions, MPMM, etc. Some smarter approach in FW
to the processing and filtering of perf limit notification
would be needed. The kernel is not able to do the job at the same
quality as FW in those areas.

Therefore, in the kernel HW pressure signal we don't need
another 'filtering or smoothing' on already processed
SCMI notification information. That could even harm us
if we don't get that FW information in kernel at right time
due to convergence delays of the HW pressure w/ PELT smoothing.

