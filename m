Return-Path: <linux-kernel+bounces-63124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0922852B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402821F22944
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C87E1AAD0;
	Tue, 13 Feb 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SQDdGGw8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C518657;
	Tue, 13 Feb 2024 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813026; cv=none; b=bAxfKarLTgyDjGRkkGuVEQUf3sA1PTP3MeI69bH/csQN3tRxsIZYkDxbwo92g+IC3ad8tgNVFEMgpFEKj2RLP5ovKRXoA1IIYtq3mEOwyJxySUzwFlrj2bB7YiVS4cCvjuiVZCLaFEBVIruO4oNbVGajtvEG9PtalT2bNTKpR+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813026; c=relaxed/simple;
	bh=G6GFe/xxnU+wCJI9L6Xwt03DepEVKkpZr/GK2WjqDDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eQz2OMF4UeQgVzJ/Dft6f6kSUUtQXBulpCz7xubCgVdXItkBN1vB8MnatcF7Fy0Mk6rHOENlpVpt1/+QXlmqyVv9wPVjf8D84FnaaERv6GphJcY6iQC6+xu5+7CiWMoYjmhLa340JcaP2gMGBpNmB06pwtzPNXXgqEYWiYYV7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SQDdGGw8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D7sqBM021912;
	Tue, 13 Feb 2024 08:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=G67nKLCfr69ua9V5FD95/88WYmttYaFQ1WldH+6JbI0=; b=SQ
	DdGGw8OFWs1sbi1pnkn+ZCMg+C2jy3WTJ/wgN/VMEfmsEbgSaKt8yrCyePn3z6V5
	cp1A7s2lVlHDiBDocsg/k6teuzbB4DTDaMaqazA90bVep1AxkAENMTNuoNLO1rDv
	xYx1visa/BiluY2RO+0kVV4Jc3TZB1Z/6Bwb9A7CbyKIaKSFFhr0zXnxa6lUAkDX
	cTdYQipPhCCOGdxMplwes3MLUE6uQT6lJB3lqktVjfQ6EgJv4IT6YiI0fXmof++A
	RTmjH3daHVb8A1LdLA2rXdeB2R/v+V/B2Kys4KXIbwEGycz8/sgkSzsqwkW1Dw5h
	75nnbcUF1LTlljGbT1YQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7tans216-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:30:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D8UFXa017426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 08:30:15 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 00:30:11 -0800
Message-ID: <b57c6699-92f8-192c-34b6-97c04cd18fb4@quicinc.com>
Date: Tue, 13 Feb 2024 14:00:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Add support for marking certain
 frequencies as boost
Content-Language: en-US
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <cristian.marussi@arm.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <morten.rasmussen@arm.com>, <dietmar.eggemann@arm.com>,
        <lukasz.luba@arm.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <nm@ti.com>
References: <20240117110443.2060704-1-quic_sibis@quicinc.com>
 <20240117110443.2060704-3-quic_sibis@quicinc.com>
 <20240131112507.fu355wnolbsoiqxn@bogus>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20240131112507.fu355wnolbsoiqxn@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0BgYND4qgUQPRb4w_MYqK9jjanG_uF7u
X-Proofpoint-ORIG-GUID: 0BgYND4qgUQPRb4w_MYqK9jjanG_uF7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130065



On 1/31/24 16:55, Sudeep Holla wrote:
> On Wed, Jan 17, 2024 at 04:34:42PM +0530, Sibi Sankar wrote:
>> All opps above the sustained level/frequency are treated as boost, so mark
>> them accordingly.
>>
>> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   drivers/firmware/arm_scmi/perf.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
>> index e286f04ee6e3..d3fb8c804b3d 100644
>> --- a/drivers/firmware/arm_scmi/perf.c
>> +++ b/drivers/firmware/arm_scmi/perf.c
>> @@ -811,7 +811,7 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>>   				     struct device *dev, u32 domain)
>>   {
>>   	int idx, ret;
>> -	unsigned long freq;
>> +	unsigned long freq, sustained_freq;
>>   	struct dev_pm_opp_data data = {};
>>   	struct perf_dom_info *dom;
>>   
>> @@ -819,12 +819,21 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>>   	if (IS_ERR(dom))
>>   		return PTR_ERR(dom);
>>   
>> +	if (!dom->level_indexing_mode)
>> +		sustained_freq = dom->sustained_perf_level * dom->mult_factor;
>> +	else
>> +		sustained_freq = dom->sustained_freq_khz * dom->mult_factor;
>> +
> 
> Can't we just use dom->sustained_freq_khz * 1000UL in both the cases ?

sure, I retained sustained_perf_level because I wasn't sure how the
sustained_perf_level would be populated in systems not using level
indexing mode.

> 
> Other than that this series looks good to me but it would be good to
> explain how you would use this. Since it is enabled by default, do you
> plan to disable boost at time and when ? If it is for thermal reasons,
> why your other series handling thermal and limits notification from the
> firmware not sufficient.

Boost frequencies defined in X1E are achievable by only one CPU in a
cluster i.e. either the other CPUs in the same cluster should be in low
power mode or offline. So it's mostly for book keeping i.e. we wouldn't
to intimate incorrectly that the CPUs are running at max possible
frequency when it's actually running at a lower frequency.

-Sibi

> 

