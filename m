Return-Path: <linux-kernel+bounces-28478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EF982FF09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFB128C280
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048334685;
	Wed, 17 Jan 2024 02:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I7tJJWZO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B87F5;
	Wed, 17 Jan 2024 02:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460336; cv=none; b=tXGWFUpxxRtif3l7X7O36C6hMvUaVv3aGPVp6grTR8Zz1EekYDeBKW7wwS0Ed5yFGDa0NiW6Z3OhLOaLRYMrZkfeD9+0hiWTfC0VtZ1mgmPQPE2Fw/uZOzKdS/nc5U3qDMeIXLJn8MgViE4EFaJs9xO1jS28LF36/NyXrj1Jqqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460336; c=relaxed/simple;
	bh=WwF8WDsQiNqKPzAWmgzoJEmT2aqTa/gucOxXs5ngG9Y=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=ToVhJrvePDZ4p7QBPU5MSAg9TkAs/StUwLMNNqDRipGGYYIAlia/a1GV+1HXj/xxdbnNSgmN9jyLeVOoLviGsUSa+Ukc+p4kLd8h9WvTqXAhIb8TzM9iDG82fGSUrMCqvGaXko7AvpkjQrqgFa2J3LYdCFL/2y05/HU43wMzd5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I7tJJWZO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H1U81a028624;
	Wed, 17 Jan 2024 02:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XT20oMvm0oGcwlHUcMRLH+G6eMPHlGWYcVsCf6M2eeQ=; b=I7
	tJJWZO7tCHXU1dWgDoeQ2o2SUnuG/oT/ROjRQmNvvHItNqYyXSZ/7iHps5bJKDGS
	farya5mynkycY+vpay9olPje8hadOViWrRb0M6CkporTfZggtvhJWClPJfXlmSF3
	I2zSs/9zsWmC9JMpatLJVVfQl7Wdb5sy1VFWeaIr64PC6tDJzRAynI72Xg42C9w4
	5xdFwNUKBOk+Qu38dD8ufhVtsoXTO7B93kzpDKjM/ahHiLSsVGVIyie54bE4NJMJ
	RXf2JCZVzb6T4AAe6Nlb1rbnGHxUar0NovMq8PIwL6JFNUsLMDZ/Y8rldJArNSrx
	6BfD94t3u/fCCvnlIRUg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnnvbjj2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 02:58:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H2whKn009635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 02:58:43 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 18:58:39 -0800
Message-ID: <dca6e28e-8bde-be3e-bc3c-e97e349b3f04@quicinc.com>
Date: Wed, 17 Jan 2024 08:28:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] cpufreq: scmi: Register for limit change
 notifications
Content-Language: en-US
To: Lukasz Luba <lukasz.luba@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <cristian.marussi@arm.com>,
        <sudeep.holla@arm.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        "Morten
 Rasmussen" <morten.rasmussen@arm.com>,
        Dietmar Eggemann
	<dietmar.eggemann@arm.com>
References: <20240108140118.1596-1-quic_sibis@quicinc.com>
 <20240108140118.1596-4-quic_sibis@quicinc.com>
 <94aad654-4f20-4b82-b978-77f1f9376dab@arm.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <94aad654-4f20-4b82-b978-77f1f9376dab@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 95Ab1lA2b0o4CIWTz5Uh_vK9rDZnYcsw
X-Proofpoint-ORIG-GUID: 95Ab1lA2b0o4CIWTz5Uh_vK9rDZnYcsw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170019



On 1/10/24 13:56, Lukasz Luba wrote:
> Hi Sibi,
> 

Hey Lukasz,
Thanks for taking time to review the series!

> + Morten and Dietmar on CC
> 
> On 1/8/24 14:01, Sibi Sankar wrote:
>> Register for limit change notifications if supported with the help of
>> perf_notify_support interface and determine the throttled frequency
>> using the perf_opp_xlate to apply HW pressure.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   drivers/cpufreq/scmi-cpufreq.c | 42 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c 
>> b/drivers/cpufreq/scmi-cpufreq.c
>> index 4ee23f4ebf4a..53bc8868455d 100644
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
>> @@ -144,6 +148,22 @@ scmi_get_cpu_power(struct device *cpu_dev, 
>> unsigned long *power,
>>       return 0;
>>   }
>> +static int scmi_limit_notify_cb(struct notifier_block *nb, unsigned 
>> long event, void *data)
>> +{
>> +    unsigned long freq_hz;
>> +    struct scmi_perf_limits_report *limit_notify = data;
>> +    struct scmi_data *priv = container_of(nb, struct scmi_data, 
>> limit_notify_nb);
>> +    struct cpufreq_policy *policy = priv->policy;
>> +
>> +    if (perf_ops->perf_opp_xlate(ph, priv->domain_id, 
>> limit_notify->range_max, &freq_hz))
>> +        return NOTIFY_OK;
>> +
>> +    /* Update HW pressure (the boost frequencies are accepted) */
>> +    arch_update_hw_pressure(policy->related_cpus, (freq_hz / 
>> HZ_PER_KHZ));
> 
> This is wrong. The whole idea of the new HW pressure was that I wanted
> to get rid of the 'signal smoothing' mechanism in order to get
> instantaneous value from FW to task scheduler. Vincent created
> 2 interfaces in that new HW pressure:
> 1. cpufreq_update_pressure(policy) - raw variable
> 2. arch_update_hw_pressure(policy->related_cpus, (freq_hz / HZ_PER_KHZ))
>     - smoothing PELT mechanism, good for raw IRQ in drivers
> 
> In our SCMI cpufreq driver we need the 1st one:
> cpufreq_update_pressure(policy)
> 
> The FW will do the 'signal smoothing or filtering' and won't
> flood the kernel with hundreds of notifications.

Ack, even though I see no mention of filtering being mandated in the 
SCMI specification, the scmi notification by itself will serve as a
rate limiter I guess.

> 
> So, please change that bit and add me, Morten and Dietmar on CC.
> I would like to review it.

ack

-Sibi

> 
> Regards,
> Lukasz

