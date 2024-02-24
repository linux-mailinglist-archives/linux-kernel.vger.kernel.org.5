Return-Path: <linux-kernel+bounces-79723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927B08625CE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC74FB218E3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AD647774;
	Sat, 24 Feb 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EwTh/2ha"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AE01E49D;
	Sat, 24 Feb 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708788227; cv=none; b=MIHJ/keDsN5L10B3+2a/O8rN1Wln9B8Dso8VgCMxS79ryHoZRH+0TpbaWip7TMkgCes41Xo5mknIPZMJVFCw6nO/w7MAt38lfUtV3PzvjnFJoSD64DZkB2Bd/7cPRNsHbtwLA7FM07cCeHMzwriAy2Pn459CFquw+TJhdbcvRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708788227; c=relaxed/simple;
	bh=6nrakddqbtIAKcQx+Akt7IgDKGs7jLI9EnzDIr41adM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M2+uA8Qf86r7R8x9kU0HWXxe1MPvCpmg8LCipJptUd8XhHEKpywGya5+Cds+RKZp2wIataVuID8smdYSGp/5KtwzYmGe9uNkWTKumeq1OTRUtnsdEDU3ioxP8tl80vsGQeOJhBZdRN38dVFQUpouaKpEr4sXo8e+RZNDFQf4Fg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EwTh/2ha; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41OFHmtr030560;
	Sat, 24 Feb 2024 15:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CiHDP0Zv4SsHMLEVKB76n+d60+Sr/8nVq0fUSf9nGcc=; b=Ew
	Th/2haOHI8nutPRZenvjgXR62M19jJ2auIh+BN9LbaB9kEN3UPW/Mcoojm7LZoJX
	C6ccEAtxrLyyFnMagIKNctngjM306MiPzfHe9mfiBDaIj2bfW7Nh/qzZ4AZjZZfV
	cE8DILaixvCCrvo0z1ygzRj17iY9k9yzmalYtU3dYbUgibdhjN5yM0v1uwxpVTIK
	CNXnlpx8xj6TCc0C5+jKKR9BFMCN7rWWqiD6hV4ITIXJ19dXrlBj2RqhSaiWiFzg
	OmtFwaWLDLxdGB45akd6es058nw2YwDjN171YiWiuKe397N6JHhWAxoCSRq0CKzE
	mNXGK7o1lu84DYw0jyNA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wf9rfgnf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 15:23:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41OFNY1t020228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 24 Feb 2024 15:23:34 GMT
Received: from [10.216.12.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 24 Feb
 2024 07:23:29 -0800
Message-ID: <7afe540b-05c9-4b45-a8ef-622e32f6de97@quicinc.com>
Date: Sat, 24 Feb 2024 20:53:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Limit resolving a frequency to policy min/max
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_pkondeti@quicinc.com>, <quic_namajain@quicinc.com>,
        <stable@vger.kernel.org>, <quic_rgottimu@quicinc.com>
References: <20240222083515.1065025-1-quic_kshivnan@quicinc.com>
 <CAJZ5v0gDeCbQ5rGOfCdpsVUpAsq3L=9DoLFChHc5=Zdq9Jc_7g@mail.gmail.com>
From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
In-Reply-To: <CAJZ5v0gDeCbQ5rGOfCdpsVUpAsq3L=9DoLFChHc5=Zdq9Jc_7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xqzEhWvtDoB_FJcfPGTCHBkxnNGV-hYR
X-Proofpoint-GUID: xqzEhWvtDoB_FJcfPGTCHBkxnNGV-hYR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_10,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402240129

Hi Rafael,

Thanks for reviewing the change.

On 2/23/2024 12:52 AM, Rafael J. Wysocki wrote:
> On Thu, Feb 22, 2024 at 9:35 AM Shivnandan Kumar
> <quic_kshivnan@quicinc.com> wrote:
>>
>> Resolving a frequency to an efficient one should not transgress policy->max
>> (which can be set for thermal reason) and policy->min. Currently there is
>> possibility where scaling_cur_freq can exceed scaling_max_freq when
>> scaling_max_freq is inefficient frequency. Add additional check to ensure
>> that resolving a frequency will respect policy->min/max.
>>
>> Fixes: 1f39fa0dccff ("cpufreq: Introducing CPUFREQ_RELATION_E")
>> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>> ---
>>   include/linux/cpufreq.h | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index afda5f24d3dd..42d98b576a36 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -1021,6 +1021,19 @@ static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
>>                                                     efficiencies);
>>   }
>>
>> +static inline bool cpufreq_table_index_is_in_limits(struct cpufreq_policy *policy,
>> +                                                   int idx)
> 
> This is not really about the index only, but about the frequency at
> that index too, so I'd call the function differently.
> 

ACK

>> +{
>> +       unsigned int freq;
>> +
>> +       if (idx < 0)
>> +               return false;
>> +
>> +       freq = policy->freq_table[idx].frequency;
>> +
>> +       return (freq == clamp_val(freq, policy->min, policy->max));
> 
> Redundant outer parens.
> 

ACK


>> +}
>> +
>>   static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
>>                                                   unsigned int target_freq,
>>                                                   unsigned int relation)
>> @@ -1054,7 +1067,10 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
>>                  return 0;
>>          }
>>
>> -       if (idx < 0 && efficiencies) {
>> +       /*
>> +        * Limit frequency index to honor policy->min/max
>> +        */
> 
> This comment need not be multi-line.
> 

ACK
I will make the changes in next patch set.

Thanks
Shivnandan

>> +       if (!cpufreq_table_index_is_in_limits(policy, idx) && efficiencies) {
>>                  efficiencies = false;
>>                  goto retry;
>>          }
>> --
> 
> Thanks!

