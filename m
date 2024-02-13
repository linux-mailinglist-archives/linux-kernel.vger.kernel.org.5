Return-Path: <linux-kernel+bounces-62953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B6085285C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD31E1F22B15
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D968F12B80;
	Tue, 13 Feb 2024 05:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dzk/QCn/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC911C88;
	Tue, 13 Feb 2024 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803181; cv=none; b=iG6oPxmgGyn51rdCxReHmQtpp9B1459w+yoFmd9koODDgfavWU20l9kr9YpLenQv/o4eyxp0e3oMYJoFBUJlGN7Y5jxHB4jdbhV33EM/BHthN+kkzkG+/FzBHgQo1Feycb67nRrqX+2z5ijoPS0PINAlzMkaJ6317rfrbron0Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803181; c=relaxed/simple;
	bh=e59/ayUjUY+es2XixMmiHGXpixYIfQ11/vi9lZrxF04=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rMHyJ6PGdQn/JtsOfllwM3HG8imTdOsgGxoZwLcxmot/iRrB5CvDhUU1dYUOZxK6UPzCWWVBRVHlsvJ5Zgf8+Jj1ZNaF+bg2k1G+APiPMinDUwNwSikI2C+zK0GoZUMJbacZXuy3uoinv3bE+kVFjp24cgarZHaS0erXxyY4+UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dzk/QCn/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D57NLm017691;
	Tue, 13 Feb 2024 05:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZvkZ/osVg05hrvTB6ilMZHXoKcxvtvVvgPItqoSc3z0=; b=Dz
	k/QCn/eSrwhX8O/6++jxmTH1IC/l5orb/zoVWBPYu7L5ylhals9CVhSs02+jM6bE
	Ig6fiZuLVShfhFM8nxaHWcJTxLZQ5PnqFir7JUVWyet+erHagOPecaK3C7oQqcOg
	C3+hKBq+Du0hqy5vLXZLuIjvfatUb6ur5CPUmZ1USeI1Vk/HX49qdYlttyBGQZ0w
	4ojYI9QPxqOHzmOf6PvecVZgRNmN2sFn9A0n0Mf8pv4BzcBjrElYv81wgBzGX8lq
	viBwJg0QWGXhQnoHur49xyofxTOJxbncLddIXqtSrv5RaedSDfVFpiNx5Bhn1d9A
	tzXEWxFHfIyJWaRcIlUw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7ww5rdbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 05:46:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D5kAmp025915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 05:46:10 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 21:46:06 -0800
Message-ID: <145277d6-ddb5-6dd6-c534-d92ea2d1ff28@quicinc.com>
Date: Tue, 13 Feb 2024 11:16:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 4/4] cpufreq: scmi: Register for limit change
 notifications
Content-Language: en-US
To: Pierre Gondois <pierre.gondois@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <sudeep.holla@arm.com>,
        <linux-pm@vger.kernel.org>, <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <quic_mdtipton@quicinc.com>,
        <lukasz.luba@arm.com>, <linux-arm-msm@vger.kernel.org>,
        <dietmar.eggemann@arm.com>, <morten.rasmussen@arm.com>
References: <20240117104116.2055349-1-quic_sibis@quicinc.com>
 <20240117104116.2055349-5-quic_sibis@quicinc.com>
 <512d7296-2706-4779-b475-fbf2d208e282@arm.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <512d7296-2706-4779-b475-fbf2d208e282@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kIRLLGYaX-z-LigucjBAuAeuP779U-44
X-Proofpoint-ORIG-GUID: kIRLLGYaX-z-LigucjBAuAeuP779U-44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130042



On 1/31/24 19:59, Pierre Gondois wrote:
> Hello Sibi,
> 
> On 1/17/24 11:41, Sibi Sankar wrote:
>> Register for limit change notifications if supported with the help of
>> perf_notify_support interface and determine the throttled frequency
>> using the perf_freq_xlate to apply HW pressure.
>>

Hey Pierre,

Thanks for taking time to review the series.

>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>
>> v2:
>> * Export cpufreq_update_pressure and use it directly [Lukasz]
>>
>>   drivers/cpufreq/scmi-cpufreq.c | 42 +++++++++++++++++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c 
>> b/drivers/cpufreq/scmi-cpufreq.c
>> index 4ee23f4ebf4a..e0aa85764451 100644
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
>> +    if (perf_ops->perf_freq_xlate(ph, priv->domain_id, 
>> limit_notify->range_max, &freq_hz))
>> +        return NOTIFY_OK;
>> +
>> +    policy->max = freq_hz / HZ_PER_KHZ;
> 
> Maybe 'policy->max' should be checked. The limits received by SCMI is 
> blindly
> trusted. This might be ok, but could also lead to some inconsistency.
> 
> The scmi_cpufreq_driver's verify() callback could be used.

ack, will fix this in the next re-spin.

> 
> ---
> 
> I think there might also be corner cases where the SCP might advertise
> the maximum boosted frequency as the max limit, but boosting might not
> be enabled on the kernel side.
> So I think this should be checked when setting 'policy->max',

ack

-Sibi
> 
> Regards,
> Pierre
> 
[...]
>>       if (!handle)

