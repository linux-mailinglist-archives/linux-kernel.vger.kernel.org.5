Return-Path: <linux-kernel+bounces-77746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 389BD8609A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CE02886A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3131097D;
	Fri, 23 Feb 2024 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXIkQapq"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E062F25
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660365; cv=none; b=Dof6ad6J5gXDHM1HFaY1r1bpAzQVqRpOKXk2HNpejLYPmn/Bpm1DUXJ0BQcYLegE0g8wfZ2gN3nJjQgr7UDMLzpDuTrz5tV8wO6YF7C73yp2fUuD0zp+S7kbYtvSyBtHd+5siBNY6NupR5DNggXJ0LFJ04HqEQG90x+42XTgngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660365; c=relaxed/simple;
	bh=B0RgCkjGQsXNLUjBlf7ZkqjS+RUdrdMzF2FlcZsD3l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeLZs1eutlmtv95BUjTbjX8SLe3/UI6E1YCL6VzXhHCyRQc0ADiQM6AfmubInbDMaH+KYLpjahgNC8Y+6Al699pN70LKlN6KE7/in0YQu2Ny2Srfv5abj1i1LQEcrdqDAD75KPN5nnSfAXZiWgt01P4Dac5bHxAIibWPNuanqYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXIkQapq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b519e438so387637a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708660363; x=1709265163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9FniuYRkAhXbyKeSYAOggD5zLt/qSqT9iOeegdh9kyI=;
        b=nXIkQapqrJXu18qKcPQVzH3FB01Med47G6gtCQyrB2M5bPSK7JqdbGpuuSgfm09GkX
         W+PQvNGxWCuKZ0zvoV2IBaXm5Fz2lh2TzBHPilonsvJsenKK1k0Xcw1kXVpHRgnYBT4s
         5TDCKBMBPQNT20DfMOzlonIwhJg9N8nuvuBrISCZj9jCNP/5VaaL2rfpcZqAqvaaCOIK
         R8Y9+GWDZsHyAsLt9ypdV7x76rFKAbtGOYnnH41l2Y5msvX8XVCqqstBk7m/8V0WbVWR
         OMgWzwMIliZlr3dIjjug8GI2O7xMfzSCbfC7ZVixXjoSANLuG6GHRGEibp46zdVEwzN6
         oEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708660363; x=1709265163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FniuYRkAhXbyKeSYAOggD5zLt/qSqT9iOeegdh9kyI=;
        b=m9bxDzzXjRA48zD38xjG8PQVrW/mkesSI8eN62QsA9zLcUYjq2w5rIMvNVvHwfh8Op
         A+m80fF9zkgUJL0y5NGhWZ1WwXdN2e/IUS5004FKeTsbZwHdgQ8ndwfyVlXorSB7s+Pb
         1/rmsn+RqnigZDAbsyNbivIrs+AyAB7KPmnfOPXXEyo9Nob2ARnk+FPV1nAwSWqrnlCR
         aBlQAZzsz11uChy7KGqguCbbfCO/YU/ASPRxk5WAyEROL0j5drFLrhm+CS+Yc+RY2srX
         yjZvcYzHTDOZambtc4zbQeAB2CD0zXtbY2mpEWuq1SA1SfrZ5ZxTZ9Y2DXn8abH3/8K+
         dZtA==
X-Forwarded-Encrypted: i=1; AJvYcCVKf3Vsb4u87z1NjiNBAK9wal43CYEMoLqHmlcdXhbjp7b6ZJ5AsIcDNIKjRKAHHCGlhUwr1Y0e+eI510plw793PRVt8tu5aOOXwofB
X-Gm-Message-State: AOJu0YxklBFz6EH7r6UGSwpO+qvhCB4ESneWGrkfY7oSimwmWB0N2sOF
	uA8zfHE/E88efic87PXJvZtc0OnicaYImt0TtwoZZMX44QxKhmYO
X-Google-Smtp-Source: AGHT+IHoppTnYk3oiC+FWgyaLIZqeJ5oY7zgPwh/M5fPuSbDhnpOUjZEXE1Wa4NG438vE95Fakor+w==
X-Received: by 2002:a05:6a20:e594:b0:1a0:decf:eabc with SMTP id ng20-20020a056a20e59400b001a0decfeabcmr746762pzb.23.1708660362554;
        Thu, 22 Feb 2024 19:52:42 -0800 (PST)
Received: from [192.168.255.10] ([43.132.141.27])
        by smtp.gmail.com with ESMTPSA id ca20-20020a17090af31400b00298d203d359sm298126pjb.24.2024.02.22.19.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 19:52:41 -0800 (PST)
Message-ID: <a26c0db2-79a6-4662-9ca6-7e7105cdac03@gmail.com>
Date: Fri, 23 Feb 2024 11:52:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] sched/fair: Rework sched_use_asym_prio() and
 sched_asym_prefer()
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>, alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <20240210113924.1130448-1-alexs@kernel.org>
 <20240210113924.1130448-3-alexs@kernel.org>
 <CAKfTPtDtf0WhtWV-eO2hMUpP2rDgTgUBPbHZYWMuytYJ9ifU5w@mail.gmail.com>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <CAKfTPtDtf0WhtWV-eO2hMUpP2rDgTgUBPbHZYWMuytYJ9ifU5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/24 12:51 AM, Vincent Guittot wrote:
> On Sat, 10 Feb 2024 at 12:36, <alexs@kernel.org> wrote:
>>
>> From: Alex Shi <alexs@kernel.org>
>>
>> sched_use_asym_prio() and sched_asym_prefer() are used together in various
>> places. Consolidate them into a single function sched_asym().
>>
>> The existing sched_group_asym() is only used when collecting statistics
> 
> nit: The existing sched_asym()

Hi Vincent,

Thanks for all reviewing. Do I need to update this for next version? or just fix it during merge?

Alex

> 
>> of a scheduling group. Rename it as sched_group_asym(), and remove the
>> obsolete function description.
>>
>> This makes the code easier to read. No functional changes.
>>
>> Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> Cc: Valentin Schneider <vschneid@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
>> ---
>>  kernel/sched/fair.c | 45 ++++++++++++++++++++-------------------------
>>  1 file changed, 20 insertions(+), 25 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 607dc310b355..426eda9eda57 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9746,8 +9746,18 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>>         return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
>>  }
>>
>> +static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
>> +{
>> +       /*
>> +        * First check if @dst_cpu can do asym_packing load balance. Only do it
>> +        * if it has higher priority than @src_cpu.
>> +        */
>> +       return sched_use_asym_prio(sd, dst_cpu) &&
>> +               sched_asym_prefer(dst_cpu, src_cpu);
>> +}
>> +
>>  /**
>> - * sched_asym - Check if the destination CPU can do asym_packing load balance
>> + * sched_group_asym - Check if the destination CPU can do asym_packing balance
>>   * @env:       The load balancing environment
>>   * @sgs:       Load-balancing statistics of the candidate busiest group
>>   * @group:     The candidate busiest group
>> @@ -9755,34 +9765,21 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>>   * @env::dst_cpu can do asym_packing if it has higher priority than the
>>   * preferred CPU of @group.
>>   *
>> - * SMT is a special case. If we are balancing load between cores, @env::dst_cpu
>> - * can do asym_packing balance only if all its SMT siblings are idle. Also, it
>> - * can only do it if @group is an SMT group and has exactly on busy CPU. Larger
>> - * imbalances in the number of CPUS are dealt with in find_busiest_group().
>> - *
>> - * If we are balancing load within an SMT core, or at PKG domain level, always
>> - * proceed.
>> - *
>>   * Return: true if @env::dst_cpu can do with asym_packing load balance. False
>>   * otherwise.
>>   */
>>  static inline bool
>> -sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
>> +sched_group_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
>>  {
>> -       /* Ensure that the whole local core is idle, if applicable. */
>> -       if (!sched_use_asym_prio(env->sd, env->dst_cpu))
>> -               return false;
>> -
>>         /*
>> -        * CPU priorities does not make sense for SMT cores with more than one
>> +        * CPU priorities do not make sense for SMT cores with more than one
>>          * busy sibling.
>>          */
>> -       if (group->flags & SD_SHARE_CPUCAPACITY) {
>> -               if (sgs->group_weight - sgs->idle_cpus != 1)
>> -                       return false;
>> -       }
>> +       if ((group->flags & SD_SHARE_CPUCAPACITY) &&
>> +           (sgs->group_weight - sgs->idle_cpus != 1))
>> +               return false;
>>
>> -       return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
>> +       return sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
>>  }
>>
>>  /* One group has more than one SMT CPU while the other group does not */
>> @@ -9938,7 +9935,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>         /* Check if dst CPU is idle and preferred to this group */
>>         if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
>>             env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
>> -           sched_asym(env, sgs, group)) {
>> +           sched_group_asym(env, sgs, group)) {
>>                 sgs->group_asym_packing = 1;
>>         }
>>
>> @@ -11037,8 +11034,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>>                  * SMT cores with more than one busy sibling.
>>                  */
>>                 if ((env->sd->flags & SD_ASYM_PACKING) &&
>> -                   sched_use_asym_prio(env->sd, i) &&
>> -                   sched_asym_prefer(i, env->dst_cpu) &&
>> +                   sched_asym(env->sd, i, env->dst_cpu) &&
>>                     nr_running == 1)
>>                         continue;
>>
>> @@ -11908,8 +11904,7 @@ static void nohz_balancer_kick(struct rq *rq)
>>                  * preferred CPU must be idle.
>>                  */
>>                 for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
>> -                       if (sched_use_asym_prio(sd, i) &&
>> -                           sched_asym_prefer(i, cpu)) {
>> +                       if (sched_asym(sd, i, cpu)) {
>>                                 flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
>>                                 goto unlock;
>>                         }
>> --
>> 2.43.0
>>

