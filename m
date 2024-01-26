Return-Path: <linux-kernel+bounces-39521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E4B83D249
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F140AB244F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C957491;
	Fri, 26 Jan 2024 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyIJ7w3k"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051716FBD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706234268; cv=none; b=rX9sxIQPqfq+JZQl/wJWQ49fJvsCln4xGeq7zhOOz0FVG8xACYkAReaJ17mFGj9Aim/PqrYfYlszqcyT2Xj3zCAv80VI4zt30SRZZ8kQgL0B5mJv9Camc1ISuNORHJh799v9JIDpYjMQYq8sW/ZOpZyU4SaGf+LaiNjw57/xQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706234268; c=relaxed/simple;
	bh=QwOfFi7uxXP0mjFXSuRVhlJKwrlGM6kOX5RaZUiwRtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtXUnzA/eHRlnvwoUXAr9jLFjywZ3LCAlC5v4U0x2VT81fK9kGYrJxMfN7OofCHHOE7fEQawkS5sKwozSE2AYaUPiivGvxFo0GbVNTOF0sF3N5O9hSSaCjcfzUYadYzi6IJa+BPR9a68VHb1OFkhMbJrJ3spI/zgUt7nxWDQhOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyIJ7w3k; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-598bcccca79so4137863eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706234266; x=1706839066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sH7NYQKA7zHFiyblZ4Yztw4GpXH2Wfw1vTl8EvlpNxw=;
        b=SyIJ7w3k+oaLjx/i9Osxs79xBtQCsXuBZIOFSTcwAXRxhlgRR7HLZPANLpL7xOnUcn
         xeeRgNgY0A7xxG2v5d9Ld/o6jzQWva6yJ3rXqDh5H5oVwHF7BTcFwrRhfgdkvlm5MgLk
         44bSeXbM/KpLswk+a7VEzNabLtfisWk3Rqd5a6lE8pedSZgodUaZcfaF/rBc/Jy4NDKL
         0/caT8zP3kiKVO0c6lQgLOxwhFyR9dwTHaOgTuK2p6TDwqzOd8LTocWaEKIh935N9j/V
         xXTn1YE+VcHL8/9b3en+f1Km2aSrYla8wYr9esn5fgwqpP8X3i5ogv6yPxg4BKB4lvs3
         G3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706234266; x=1706839066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sH7NYQKA7zHFiyblZ4Yztw4GpXH2Wfw1vTl8EvlpNxw=;
        b=rp2QGGCUZTGl0ONrvHX80sv9FpMVSH7mkTGi2e12KA5OJ16FRM1A+xFT2nY9vs9zl8
         oj7oJ1YqmW1aLI0oPHKaQfQQu34TClrRvUvekDp34EekRXC+//pgrAb+tcCpVNMv0Fj9
         wPpCR6MHPR7MqYZjAmqR6+clUB94b0q0gjhd290uMDs/HYkzqtaYbhDkQ2ugM2HfVldi
         MdHCJzWUU+1Y2D/2LI6pl+SNsB8MTBsoGou1mMbpV6M4gshe+MiHFGhAJPFj/SkIxwja
         HmpDbRis7mUIpmKmYnfePqmbhTH5A/bU0tKW4BpTEYKev5hPRwhSnTIR3WyVaL302Pxr
         ZXXA==
X-Gm-Message-State: AOJu0YxwYNpN5ck9sF/+R/UPLGLGUqEXOgd6K234xRcGq8KdYoo7tL0F
	u4H7b9wgRhUstswxKBA852t9H39G5mVzSJ8wK7dzI/YSpM+K9ReN
X-Google-Smtp-Source: AGHT+IF58Or1XqyK99pEF/M4VdUrr9hjun9TuOZa0V1LVFDN6Fp6d4n2TAO6xoFPtfDpgUz5Rv2uuQ==
X-Received: by 2002:a05:6358:15c5:b0:176:82e9:fd3b with SMTP id t5-20020a05635815c500b0017682e9fd3bmr753788rwh.57.1706234265685;
        Thu, 25 Jan 2024 17:57:45 -0800 (PST)
Received: from [192.168.255.10] ([43.132.141.27])
        by smtp.gmail.com with ESMTPSA id b7-20020aa78ec7000000b006dde305b92csm176632pfr.118.2024.01.25.17.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 17:57:45 -0800 (PST)
Message-ID: <63c456be-f7a5-4dbd-8398-fccf619bb538@gmail.com>
Date: Fri, 26 Jan 2024 09:57:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] sched/fair: add a func _sched_asym
Content-Language: en-US
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240117085715.2614671-1-alexs@kernel.org>
 <20240117085715.2614671-4-alexs@kernel.org>
 <20240125215622.GA17237@ranerica-svr.sc.intel.com>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240125215622.GA17237@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 5:56 AM, Ricardo Neri wrote:
> On Wed, Jan 17, 2024 at 04:57:14PM +0800, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
>>
>> Use this func in sched_asym and other path to simply code.
>> No function change.
>>
>> Signed-off-by: Alex Shi <alexs@kernel.org>
>> To: Valentin Schneider <vschneid@redhat.com>
>> To: Vincent Guittot <vincent.guittot@linaro.org>
>> To: Peter Zijlstra <peterz@infradead.org>
>> To: Ingo Molnar <mingo@redhat.com>
>> ---
>>  kernel/sched/fair.c | 27 +++++++++++++--------------
>>  1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index ebd659af2d78..96163ab69ae0 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9745,6 +9745,14 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>>  		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
>>  }
>>  
>> +static inline bool _sched_asym(struct sched_domain *sd,
>> +			int dst_cpu, int repl_cpu)
> 
> What does repl_cpu mean? Maybe renaming to src_cpu?

Uh, src_cpu is better than a 'replacing' cpu. Thanks!

> 
>> +{
>> +	/* Ensure that the whole local core is idle, if applicable. */
>> +	return sched_use_asym_prio(sd, dst_cpu) &&
>> +			sched_asym_prefer(dst_cpu, repl_cpu);
> 
> The comment no longer applies to the whole expression. Perhaps rewording is
> in order. First we check for the whole idle core if applicable (i.e., when
> not balancing among SMT siblings). Then we check priorities.

Right will fix this by v2.
> 
> Also, indentation should be aligned with `return`, IMO.
> 
>> +}
>> +
>>  /**
>>   * sched_asym - Check if the destination CPU can do asym_packing load balance
>>   * @env:	The load balancing environment
>> @@ -9768,20 +9776,13 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>>  static inline bool
>>  sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
>>  {
>> -	/* Ensure that the whole local core is idle, if applicable. */
>> -	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
>> -		return false;
>> -
>>  	/*
>>  	 * CPU priorities does not make sense for SMT cores with more than one
>>  	 * busy sibling.
> 
> While here, it might be good to fix a syntax error above: s/does/do/.
> 

Yes, thanks

>>  	 */
>> -	if (group->flags & SD_SHARE_CPUCAPACITY) {
>> -		if (sgs->group_weight - sgs->idle_cpus != 1)
>> -			return false;
>> -	}
>> -
>> -	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
>> +	return !(group->flags & SD_SHARE_CPUCAPACITY &&
>> +			sgs->group_weight - sgs->idle_cpus != 1) &&
>> +		_sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
> 
> Perhaps we can come up with a better name than _sched_asym(). After this
> patch the difference between sched_asym() and _sched_asym() is that the
> former considers the stats of the source group. Maybe sched_asym() can be
> renamed as sched_group_asym(); it is only used in update_sg_lb_stats().
> Your _sched_asym() can become sched_asym().

Thanks for good suggestion! will send v2 according your suggestion. 

Alex
> 
>>  }
>>  
>>  /* One group has more than one SMT CPU while the other group does not */
>> @@ -11036,8 +11037,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>>  		 * SMT cores with more than one busy sibling.
>>  		 */
>>  		if ((env->sd->flags & SD_ASYM_PACKING) &&
>> -		    sched_use_asym_prio(env->sd, i) &&
>> -		    sched_asym_prefer(i, env->dst_cpu) &&
>> +		    _sched_asym(env->sd, i, env->dst_cpu) &&
>>  		    nr_running == 1)
>>  			continue;
>>  
>> @@ -11907,8 +11907,7 @@ static void nohz_balancer_kick(struct rq *rq)
>>  		 * preferred CPU must be idle.
>>  		 */
>>  		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
>> -			if (sched_use_asym_prio(sd, i) &&
>> -			    sched_asym_prefer(i, cpu)) {
>> +			if (_sched_asym(sd, i, cpu)) {
>>  				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
>>  				goto unlock;
>>  			}
>> -- 
>> 2.43.0
>>

