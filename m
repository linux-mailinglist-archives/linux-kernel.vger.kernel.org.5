Return-Path: <linux-kernel+bounces-28480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0488E82FF10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244CE284487
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3719C4690;
	Wed, 17 Jan 2024 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CD9EvpYk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE9613C;
	Wed, 17 Jan 2024 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460426; cv=none; b=lqnnO2Ys8V6dDAFmxRrT56xPp4yHh1PSVLRUMC6IJCh7xrUZVm4/Sdjo1HmiTRndJWVDNc33RZwDTTREh2zgzPKrIhcL2hstBWOpLA7fVgeAqR/nXwTLbqsNMxdhisjwottB/sON1lj+UcNHu+GgxDsA04VEhPkSeoS1Ewqw0xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460426; c=relaxed/simple;
	bh=huhDjS/FysDhMk2XBBGDNLNvYNAqjTIDA6KOPUS9giY=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=RI9J/Qe0nN5mNbSljPV/OMGodFkmvrkdzAs+kY89baWbVw10ZgKqF1Mq36ovwWx2s21CshFdWkR+LyARO4Pcqj5a4QVZjOz0GDFo80q3Tax+na1VIjys8pa/eAw/b1y9+MaUlHigBJz5K0NHixc510ciKtxs/4Y81KlK+k5lWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CD9EvpYk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H16Lwf020111;
	Wed, 17 Jan 2024 03:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HLw4+Z1ecP3dMooOn4xJFlhUXZmcw9BpiM+2fDOjgXw=; b=CD
	9EvpYkQZszXiaHT/txq10HKd9oypVyBH/Fn5j4H6tv41qzZkQ8Pab5y2beJTbvAo
	/xjwg0+AGEMfifOHzrUM+TZdCpK/y8twJLkdKBODkDtF4EhusAUFt9DTr/nwd6H9
	yk4HftfaYFjOKogwJWgkn/Iy9Qd78bryHECbYrLp6YD3KPG93Dgs0jslLMOThONX
	brJj81pFKlve2GY/RrLL3C1d6X9hK4ogtTFhyDnBEUw/pzMmST7y3fKQ9JBwLVrY
	ppGQm5ZyDBUX9ShXD20ngw1oqMabTqlB+H24LFJxGzTf6a2H3mhraRkz3L/AiXep
	jaitvUxdBLJdEIiLs5Jw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnmq0jman-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 03:00:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H301QL011018
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 03:00:01 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 18:59:58 -0800
Message-ID: <0800860a-e090-153f-bbbd-1f7666b14fed@quicinc.com>
Date: Wed, 17 Jan 2024 08:29:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Add perf_opp_xlate interface
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20240108140118.1596-1-quic_sibis@quicinc.com>
 <20240108140118.1596-3-quic_sibis@quicinc.com>
 <20240110072906.7vnqykkcw3rkhoxa@vireshk-i7>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20240110072906.7vnqykkcw3rkhoxa@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cbyLFxNUivVLSbp6ELhXfzojiYWrbd1B
X-Proofpoint-ORIG-GUID: cbyLFxNUivVLSbp6ELhXfzojiYWrbd1B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170019



On 1/10/24 12:59, Viresh Kumar wrote:
> On 08-01-24, 19:31, Sibi Sankar wrote:
>> Add a new perf_opp_xlate interface to the existing perf_ops to translate
>> a given perf index to frequency.
>>

Hey Viresh,
Thanks for taking time to review the series!

>> This can be used by the cpufreq driver and framework to determine the
>> throttled frequency from a given perf index and apply HW pressure
>> accordingly.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   drivers/firmware/arm_scmi/perf.c | 21 +++++++++++++++++++++
>>   include/linux/scmi_protocol.h    |  3 +++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
>> index c167bb5e3607..f26390924e1c 100644
>> --- a/drivers/firmware/arm_scmi/perf.c
>> +++ b/drivers/firmware/arm_scmi/perf.c
>> @@ -964,6 +964,26 @@ static int scmi_notify_support(const struct scmi_protocol_handle *ph, u32 domain
>>   	return 0;
>>   }
>>   
>> +static int scmi_perf_opp_xlate(const struct scmi_protocol_handle *ph, u32 domain,
>> +			       int idx, unsigned long *freq)
>> +{
>> +	struct perf_dom_info *dom;
>> +
>> +	dom = scmi_perf_domain_lookup(ph, domain);
>> +	if (IS_ERR(dom))
>> +		return PTR_ERR(dom);
>> +
>> +	if (idx >= dom->opp_count)
>> +		return -ERANGE;
>> +
>> +	if (!dom->level_indexing_mode)
>> +		*freq = dom->opp[idx].perf * dom->mult_factor;
>> +	else
>> +		*freq = dom->opp[idx].indicative_freq * dom->mult_factor;
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct scmi_perf_proto_ops perf_proto_ops = {
>>   	.num_domains_get = scmi_perf_num_domains_get,
>>   	.info_get = scmi_perf_info_get,
>> @@ -979,6 +999,7 @@ static const struct scmi_perf_proto_ops perf_proto_ops = {
>>   	.fast_switch_possible = scmi_fast_switch_possible,
>>   	.power_scale_get = scmi_power_scale_get,
>>   	.perf_notify_support = scmi_notify_support,
>> +	.perf_opp_xlate = scmi_perf_opp_xlate,
> 
> The use of "opp" here is a bit confusing as this doesn't have anything to do
> with the OPP framework and you are only getting the frequency out of it after
> all.

Sure will re-name it.

-Sibi

> 

