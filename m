Return-Path: <linux-kernel+bounces-154855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FEF8AE205
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16FA283108
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E3860BB6;
	Tue, 23 Apr 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gmA02qVO"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55260DCF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867868; cv=none; b=EcY+NP+RPo8qyOLLfBqnnEOSdbB6e50sSOXAxLVQyvuLHopa504TvtkUFuDMci6QlRqU68oyjJ24NUOczBhkE0Uzn0y+2Sl7ZWyyaZQp3I7F0YrQyyXQfGpST43ZVMcx9abUFiujYice/i4UmWGpuel0DQ8d2BKG1fYGUEAK0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867868; c=relaxed/simple;
	bh=qaSAT1+TaIc7tGENMqXgteVrWscZh7cUNCbhrTleCg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Z8EIKLGZoWDi065bKxim8uPhk6k8WKkN2FFo/8Eb37+pGNhmXyWgrhMOMqGm7GIHuwciUb7pfCotDuFZptl/OcWfFricrvTKfJMfTKINmUEDtTLOkfN6vrgA4Zs8JSg6TkYIDN/CikIBruSwLfEys8l0m6EWnoENELhu6gf/Sig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gmA02qVO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N8gSB4023774;
	Tue, 23 Apr 2024 10:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : cc : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4AQ5OdGzRd9ced7hbJBtlQQmE/elMqN8PzOldBw2HRM=;
 b=gmA02qVOy+Ybw0wV5NcfkG6q0SLV1rNSjbGFN8lcvanIU0PVddp+/c9J2cp7NEm8S0CE
 qzvVskXpjNHfuktmzsUAvAJ1PpTTgVeuZdDe0Y0vUrnF9zKWXJuNMWP4H1bu/EGeeIlt
 yQrJc7N55ZOM90IPESFO9LFitnJhLxlhw2Hdc0apxrsPHr97C0CM5c39rVm2y+B8VFQo
 AHsQxsUwkAHrZjiA9KcQqPc0H7TfVkj6o2ksTuYIaS4vDu+4svr3804TNGAe0xA8KeBS
 YeQqm6aL0Tsfne6ZYPpspss5CZG/cswa/Adzf4JSVksOU1wJugkYPgl4N2Cd/9yrPnwy Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp9q406dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 10:24:17 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NAKW4W008099;
	Tue, 23 Apr 2024 10:24:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp9q406ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 10:24:16 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43N7wnAi015277;
	Tue, 23 Apr 2024 10:24:15 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshm4um9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 10:24:15 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43NAODMb28377812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 10:24:15 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E129D58060;
	Tue, 23 Apr 2024 10:24:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3FDF58051;
	Tue, 23 Apr 2024 10:24:09 +0000 (GMT)
Received: from [9.204.206.228] (unknown [9.204.206.228])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Apr 2024 10:24:09 +0000 (GMT)
Message-ID: <14898c69-6a2e-4a9d-a0d4-d674087cd1ae@linux.ibm.com>
Date: Tue, 23 Apr 2024 15:54:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tracing/sched: sched_switch: place prev_comm and
 next_comm in right order
To: tiozhang@didiglobal.com
References: <20240417102840.GA6614@didi-ThinkCentre-M930t-N000>
Content-Language: en-US
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        zyhtheonly@gmail.com, zyhtheonly@yeah.net,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240417102840.GA6614@didi-ThinkCentre-M930t-N000>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UtKRG6xtEF9d_N7qcflet19AJ5LfuYd3
X-Proofpoint-ORIG-GUID: 57xv38v1tFx1ZLPPldUOfHBA0ZLrsuN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_08,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230028

Hi Tio zhang,

On 17/04/24 15:59, Tio Zhang wrote:
> Switch the order of prev_comm and next_comm in sched_switch's code to
> align with its printing order.
> 
> Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
> ---
>  include/trace/events/sched.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index dbb01b4b7451..a4bd4330db4c 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -239,11 +239,11 @@ TRACE_EVENT(sched_switch,
>  	),
>  
>  	TP_fast_assign(
> -		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
> +		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
>  		__entry->prev_pid	= prev->pid;
>  		__entry->prev_prio	= prev->prio;
>  		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
> -		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
> +		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
>  		__entry->next_pid	= next->pid;
>  		__entry->next_prio	= next->prio;
>  		/* XXX SCHED_DEADLINE */

Yes, makes sense to have all previous and then the next for increased readability.

Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

