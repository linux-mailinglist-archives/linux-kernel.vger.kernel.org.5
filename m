Return-Path: <linux-kernel+bounces-92588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDD2872289
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471E61C2197E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FFC1272B3;
	Tue,  5 Mar 2024 15:18:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251F3126F32
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651906; cv=none; b=MBLCvyKy2GbjskGU5CCI0wHoupq/T+xMt+NBv+in/1QgsoIIAXC9+vepqewVn/XQ4q9CA+bBxOkIu21AsCz6X62kBZyLVsMJy2zHWuEf+QpR10PFdLneM5zPGSW/on2whFZXRC0YZtrJXFH6A69nkZgM4yswv1JiafY/HqnWGzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651906; c=relaxed/simple;
	bh=p9voIdo9D0+0Lmf8WuL+uz0FKxiXDKJMY8lKAMlFPrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QviWXHWzldXCMVJuOzWCsx4MfMSOev2zIxWbZ+jGze69nUt7R3NC8vzDIm2oo2OQVfE8suznPbAytbgIjLyCBsZwkHl/XmMuXdjPEjlC70qblRoBOSVD6dWbdRPm7xw1pVKl3eQBvOFQIepmahl29QE826ZgE6ylqb/U9ilHpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CD111FB;
	Tue,  5 Mar 2024 07:19:00 -0800 (PST)
Received: from [10.1.29.29] (e133047.arm.com [10.1.29.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68D693F738;
	Tue,  5 Mar 2024 07:18:22 -0800 (PST)
Message-ID: <0e2833ee-0939-44e0-82a2-520a585a0153@arm.com>
Date: Tue, 5 Mar 2024 15:18:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Remove stale FREQUENCY_UTIL comment
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 dietmar.eggemann@arm.com
References: <20240305095111.777525-1-christian.loehle@arm.com>
 <CAKfTPtC6D4RTP3T8tqEJKA1drGbAANOaGPKqmELd1G8TLocizg@mail.gmail.com>
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtC6D4RTP3T8tqEJKA1drGbAANOaGPKqmELd1G8TLocizg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2024 15:05, Vincent Guittot wrote:
> On Tue, 5 Mar 2024 at 10:51, Christian Loehle <christian.loehle@arm.com> wrote:
>>
>> effective_cpu_util() flags were removed, so remove the comment part
>> mentioning it.
>>
>> commit 9c0b4bb7f6303 ("sched/cpufreq: Rework schedutil governor performance estimation")
>> reworked effective_cpu_util() removing enum cpu_util_type.
>>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  kernel/sched/fair.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 533547e3c90a..6b0c47d00fd3 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7849,8 +7849,6 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
>>                  * Performance domain frequency: utilization clamping
>>                  * must be considered since it affects the selection
>>                  * of the performance domain frequency.
>> -                * NOTE: in case RT tasks are running, by default the
>> -                * FREQUENCY_UTIL's utilization can be max OPP.
> 
> Yes, it's no more accurate.
> Should we update the comment instead of deleting it as the effect is
> still there ?
>  "NOTE: in case RT tasks are running, by default the min utilization
> can be max OPP."

I'm fine with either and that was my first thought here, too, but it did seem like
the comment was mostly placed there to justify the 'unexpected' high utilization
when explicitly passing FREQUENCY_UTIL and the need to clamp it then.
So removing did feel slightly more natural to me anyway.

So alternatively:

From: Christian Loehle <christian.loehle@arm.com>
Date: Tue, 5 Mar 2024 09:34:41 +0000
Subject: [PATCH] sched/fair: Remove stale FREQUENCY_UTIL mention

effective_cpu_util() flags were removed, so remove mentioning of the
flag.

commit 9c0b4bb7f6303 ("sched/cpufreq: Rework schedutil governor performance estimation")
reworked effective_cpu_util() removing enum cpu_util_type. Modify the
comment accordingly.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..f5151cbcd94e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7849,8 +7849,8 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 		 * Performance domain frequency: utilization clamping
 		 * must be considered since it affects the selection
 		 * of the performance domain frequency.
-		 * NOTE: in case RT tasks are running, by default the
-		 * FREQUENCY_UTIL's utilization can be max OPP.
+		 * NOTE: in case RT tasks are running, by default the min
+		 * utilization can be max OPP.
 		 */
 		eff_util = effective_cpu_util(cpu, util, &min, &max);
 
-- 
2.34.1


