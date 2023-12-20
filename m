Return-Path: <linux-kernel+bounces-7083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4970481A16E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002FB1F212B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072CE3E470;
	Wed, 20 Dec 2023 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ClvpklYP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E943D972
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKEjJ1N010381;
	Wed, 20 Dec 2023 14:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9ZJ+mGAq5RlbQCkh+6A8mvZK3kZnxP0yjFw34mQOsgo=;
 b=ClvpklYPrsbtXgIjCG8zBR/Zi/wXo9MY9kAU9zGLMeRMRCxMzktOKxaNcfcgM64xBKsT
 yPFxR1iJeVW9vvJ6zsnkymi9LVb4KHZXihDEKmMY72ZkovmqYuJsFwGKv3lgU3GlWcuf
 ADoIzbkIDNY1hTmNuPSaJ11HoTQ/sBeTzh/VNJUqp/JX9Q8j/3PmnqHvNxjv9/h2rrv6
 5jDhnSdtUBTgbPUJc7EihUSX71mxGdGKtcyb777IstdCmpZGZX3xuQmNAgWD8CCPMxUd
 lIQblw3oPdpymdgAEHVrHEgJvZmjCHozOetgcN10K32YaGOadQLTmyzZkWjbIUPxkajw YA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v41mq98sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 14:48:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BKCS3lC027076;
	Wed, 20 Dec 2023 14:48:49 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1rek6mpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 14:48:49 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BKEmm868258222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 14:48:48 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8D6758058;
	Wed, 20 Dec 2023 14:48:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 976E458059;
	Wed, 20 Dec 2023 14:48:45 +0000 (GMT)
Received: from [9.43.114.58] (unknown [9.43.114.58])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Dec 2023 14:48:45 +0000 (GMT)
Message-ID: <85230ed0-26a0-4f08-aab0-f0a6ce03abe8@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2023 20:18:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: move access of avg_rt and avg_dl into existing
 helper functions
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        yu.c.chen@intel.com, tim.c.chen@linux.intel.com
References: <20231220065522.351915-1-sshegde@linux.vnet.ibm.com>
 <CAKfTPtCRoLULQkRTZcJfXvSSqZYV2oRN0a3_AFiuqD7k0LtL-Q@mail.gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <CAKfTPtCRoLULQkRTZcJfXvSSqZYV2oRN0a3_AFiuqD7k0LtL-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y_RsWzR6zoHEMipnPktbzQeJqAzKZZ1w
X-Proofpoint-GUID: y_RsWzR6zoHEMipnPktbzQeJqAzKZZ1w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-20_08,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312200106



On 12/20/23 7:29 PM, Vincent Guittot wrote:

Hi Vincent, thanks for taking a look.

> On Wed, 20 Dec 2023 at 07:55, Shrikanth Hegde
> <sshegde@linux.vnet.ibm.com> wrote:
>>
>> This is a minor code simplification. There are helper functions called
>> cpu_util_dl and cpu_util_rt which gives the average utilization of DL
>> and RT respectively. But there are few places in code where these
>> variables are used directly.
>>
>> Instead use the helper function so that code becomes simpler and easy to
>> maintain later on.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
>> ---
>>  kernel/sched/fair.c | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index bcea3d55d95d..02631060ca7e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9212,19 +9212,17 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
>>
>>  static inline bool others_have_blocked(struct rq *rq)
>>  {
>> -       if (READ_ONCE(rq->avg_rt.util_avg))
>> +       if (cpu_util_rt(rq))
>>                 return true;
>>
>> -       if (READ_ONCE(rq->avg_dl.util_avg))
>> +       if (cpu_util_dl(rq))
>>                 return true;
>>
>>         if (thermal_load_avg(rq))
>>                 return true;
>>
>> -#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>> -       if (READ_ONCE(rq->avg_irq.util_avg))
>> +       if (cpu_util_irq(rq))
> 
> cpu_util_irq doesn't call READ_ONCE()
> 


I see. Actually it would be right if cpu_util_irq does call READ_ONCE no? 

Sorry i havent yet understood the memory barriers in details. Please correct me 
if i am wrong here, 
since ___update_load_avg(&rq->avg_irq, 1) does use WRITE_ONCE and reading out this 
value using cpu_util_irq on a different CPU should use READ_ONCE no? 

> 
>>                 return true;
>> -#endif
>>
>>         return false;
>>  }
>> @@ -9481,8 +9479,8 @@ static unsigned long scale_rt_capacity(int cpu)
>>          * avg_thermal.load_avg tracks thermal pressure and the weighted
>>          * average uses the actual delta max capacity(load).
>>          */
>> -       used = READ_ONCE(rq->avg_rt.util_avg);
>> -       used += READ_ONCE(rq->avg_dl.util_avg);
>> +       used = cpu_util_rt(rq);
>> +       used += cpu_util_dl(rq);
>>         used += thermal_load_avg(rq);
>>
>>         if (unlikely(used >= max))
>> --
>> 2.39.3
>>

