Return-Path: <linux-kernel+bounces-37764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC4683B4E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D5E1F262B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352BD13666A;
	Wed, 24 Jan 2024 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Fv5Wt0yK"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F8136651
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136206; cv=none; b=fbbfLyNTIFtbfzv1iwiG5AKLFIB8mUevu116teyzP8LuaLjL2+ChadtztgUtNDK8+yFEm56lzFLwKchpUOX7zc0z5G9J2c6KAWBoVnZG1DgOqMndrYUS+u+0qHNDnueX/fyFh266hWuBwGNvVHBrGAyeaE/hqRgOdT3+7mtLGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136206; c=relaxed/simple;
	bh=Rp0RmWkcE5sqUVpECDzofSazedEBCo+UBBZJepiFjyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odll4NfONVRpxkxBVt5aj1Ykc3Vgq8UHb5dxEtvLeQdtoeUos1KrRMCLFj5EsbJv9JRZpWSq/Y51RxpRnh52VizTbmuF4F+UCp4ZP8nx4jFUmk6cLo+InPgufZrP2ogzciqzyJxKPauQpjsQS39jZ88JcH0wb+4OCzGGUMbjLhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Fv5Wt0yK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so41011875e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706136202; x=1706741002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AYnCVCbMrpLGqSlOucD7Y7uf6J8uEMqcnn8xdzcRG4A=;
        b=Fv5Wt0yKrXKkJpoXOVg7/jAXV4aV7leiqYLSLV0y62hA5Cb/pxi4pFHzMIiLwZ1YGJ
         pHnbjlwKqdSM0+UxESIc2kgE4AoUqhvA2vHFUKgskJ+dMPcxMT1EOqJBSZZwRBETb2k4
         FeTcmow84bY+UrPT9t0fjFvkcervbyGJ7tRW76H9dyaYjW1G3cSaQzbHpyNuVuPYG9jU
         EwzWbOLYafUYurHYTH4qQcRe/todhhKt6cgEVhI/gKcZGe4Y1j91tIzCl7D/fmkE/OrD
         Q7TQfAYiyaZa/EJLmHXKuYynEkYbyrYNN3pDHaItS78McdI31W1AUorf/gUFTu7eM1oe
         CiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136202; x=1706741002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYnCVCbMrpLGqSlOucD7Y7uf6J8uEMqcnn8xdzcRG4A=;
        b=IxitbiLnonEBLaIIdbedxZPOLemgXY+BSBpXCsDfbYDPctbSEGZY8NM187x+/b0+Mr
         6qPKEeux7UUvZoXWKCQBMw6fPjOsbX8mK1HvfIXuRLzY64cRN3lGoTlCYM9UtzXEk0Tq
         Rb9+6ukEdocdkmKfhZgXqNldFuwmzwuqe9JTMhvoP+o1dddCsRaLjbJCcH9bIFaoc4e9
         ofZ2MnkMrqbFfT5I2bDKvTMfJyAEtKEZl/jLYmv61xpiJCORCiMtzLLgU+ZL+KCGAcN1
         6HTviQc/WUiepUPw0DLfCV2dyfu5+f1+jt75kMQWPzNAebkYpr4anLoeTo8n9u66aHsS
         v3WA==
X-Gm-Message-State: AOJu0YyEGhlliHpy907jqXGvhG2KRlGACV08W1tt0pd8RZBuQpx/EkLA
	xrg9rjRx430rO1uUc0u3evsNtm5mdXWpud4UJxqJMa1lx7KzXUEGSxvb4T5F2nQ=
X-Google-Smtp-Source: AGHT+IGjmfq+cWqhIijbahaCRDoP+Q55dQ7EGmo6WF4s345GKcazUAe/OzNkqxOUMRkWqzCSfOuopQ==
X-Received: by 2002:a05:600c:4707:b0:40e:aee6:e888 with SMTP id v7-20020a05600c470700b0040eaee6e888mr1683538wmo.119.1706136202516;
        Wed, 24 Jan 2024 14:43:22 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b0040e5945307esm449535wmo.40.2024.01.24.14.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:43:22 -0800 (PST)
Date: Wed, 24 Jan 2024 22:43:21 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240124224321.vn4tuwj53wfk6iyk@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <213f94df-cc36-4281-805d-9f56cbfef796@arm.com>
 <20240122180212.67csjrnsbs7vq57i@airbuntu>
 <ece7ce3f-17f3-42a5-90d7-d0410235059d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ece7ce3f-17f3-42a5-90d7-d0410235059d@arm.com>

On 01/23/24 18:07, Dietmar Eggemann wrote:
> On 22/01/2024 19:02, Qais Yousef wrote:
> > On 01/22/24 09:59, Dietmar Eggemann wrote:
> >> On 05/01/2024 23:20, Qais Yousef wrote:
> >>> From: Qais Yousef <qais.yousef@arm.com>
> 
> [...]
> 
> >>> +	/*
> >>> +	 * If the task affinity is not set to default, make sure it is not
> >>> +	 * restricted to a subset where no CPU can ever fit it. Triggering
> >>> +	 * misfit in this case is pointless as it has no where better to move
> >>> +	 * to. And it can lead to balance_interval to grow too high as we'll
> >>> +	 * continuously fail to move it anywhere.
> >>> +	 */
> >>> +	if (!cpumask_equal(p->cpus_ptr, cpu_possible_mask)) {
> >>
> >> Shouldn't this be cpu_active_mask ?
> > 
> > Hmm. So the intention was to check if the affinity was changed from default.
> > 
> > If we hotplug all but little we could end up with the same problem, yes you're
> > right.
> > 
> > But if the affinity is set to only to littles and cpu_active_mask is only for
> > littles too, then we'll also end up with the same problem as they both are
> > equal.
> 
> Yes, that's true.
> 
> > Better to drop this check then? With the sorted list the common case should be
> > quick to return as they'll have 1024 as a possible CPU.
> 
> Or you keep 'cpu_possible_mask' and rely on the fact that the
> asym_cap_list entries are removed if those CPUs are hotplugged out. In
> this case the !has_fitting_cpu path should prevent useless Misfit load
> balancing approaches.

IIUC this removal doesn't happen today as outlined below, but something we need
to do, right? Would be better, yes.

> 
> [...]
> 
> >> What happen when we hotplug out all CPUs of one CPU capacity value?
> >> IMHO, we don't call asym_cpu_capacity_scan() with !new_topology
> >> (partition_sched_domains_locked()).
> > 
> > Right. I missed that. We can add another intersection check against
> > cpu_active_mask.
> > 
> > I am assuming the skipping was done by design, not a bug that needs fixing?
> > I see for suspend (cpuhp_tasks_frozen) the domains are rebuilt, but not for
> > hotplug.
> 
> IMHO, it's by design. We setup asym_cap_list only when new_topology is
> set (update_topology_flags_workfn() from init_cpu_capacity_callback() or
> topology_init_cpu_capacity_cppc()). I.e. when the (max) CPU capacity can
> change.
> In all the other !new_topology cases we check `has_asym |= sd->flags &
> SD_ASYM_CPUCAPACITY` and set sched_asym_cpucapacity accordingly in
> build_sched_domains(). Before we always reset sched_asym_cpucapacity in
> detach_destroy_domains().
> But now we would have to keep asym_cap_list in sync with the active CPUs
> I guess.

Okay, so you suggest we need to update the code to keep it in sync. Let's see
first if Vincent is satisfied with this list traversal or we need to go another
way :-)

I think it is worth having this asym_capacity list available. It seemed several
times we needed it and just a little work is required to make it available for
potential future users. Even if we don't merge immediately.

> 
> [...]
> 
> >>>  #else /* CONFIG_SMP */
> >>> @@ -9583,9 +9630,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
> >>>   */
> >>>  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> >>>  {
> >>> -	return rq->misfit_task_load &&
> >>> -		(arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
> >>> -		 check_cpu_capacity(rq, sd));
> >>> +	return rq->misfit_task_load && check_cpu_capacity(rq, sd);
> >>
> >> You removed 'arch_scale_cpu_capacity(rq->cpu) <
> >> rq->rd->max_cpu_capacity' here. Why? I can see that with the standard
> > 
> > Based on Pierre review since we no longer trigger misfit for big cores.
> > I thought Pierre's remark was correct so did the change in v3
> 
> Ah, this is the replacement:
> 
> - if (task_fits_cpu(p, cpu_of(rq))) {  <- still MF for util > 0.8 * 1024
> -     rq->misfit_task_load = 0;
> -     return;
> + cpu_cap = arch_scale_cpu_capacity(cpu);
> +
> + /* If we can't fit the biggest CPU, that's the best we can ever get */
> +   if (cpu_cap == SCHED_CAPACITY_SCALE)
> +       goto out;

Yep.

> 
> > 
> > 	https://lore.kernel.org/lkml/bae88015-4205-4449-991f-8104436ab3ba@arm.com/
> > 
> >> setup (max CPU capacity equal 1024) which is what we probably use 100%
> >> of the time now. It might get useful again when Vincent will introduce
> >> his 'user space system pressure' implementation?
> > 
> > I don't mind putting it back if you think it'd be required again in the near
> > future. I still didn't get a chance to look at Vincent patches properly, but if
> > there's a clash let's reduce the work.
> 
> Vincent did already comment on this in this thread.
> 
> [...]
> 
> >>> @@ -1423,8 +1418,8 @@ static void asym_cpu_capacity_scan(void)
> >>>  
> >>>  	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
> >>>  		if (cpumask_empty(cpu_capacity_span(entry))) {
> >>> -			list_del(&entry->link);
> >>> -			kfree(entry);
> >>> +			list_del_rcu(&entry->link);
> >>> +			call_rcu(&entry->rcu, free_asym_cap_entry);
> >>
> >> Looks like there could be brief moments in which one CPU capacity group
> >> of CPUs could be twice in asym_cap_list. I'm thinking about initial
> >> startup + max CPU frequency related adjustment of CPU capacity
> >> (init_cpu_capacity_callback()) for instance. Not sure if this is really
> >> an issue?
> > 
> > I don't think so. As long as the reader sees a consistent value and no crashes
> > ensued, a momentarily wrong decision in transient or extra work is fine IMO.
> > I don't foresee a big impact.
> 
> OK.

Thanks!

--
Qais Yousef

