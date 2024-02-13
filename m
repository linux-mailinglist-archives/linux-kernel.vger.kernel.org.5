Return-Path: <linux-kernel+bounces-63924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C694585366D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052151C225A4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8115F866;
	Tue, 13 Feb 2024 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kl0wmfEC"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18157B66F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842772; cv=none; b=FIYjuZU6TaC73oc2XZWLtrp7YDowA0oUc1o7miOwytryr5/MhEDG+rpJ+hOE4j63ZqFbh2EwPXDjj/iQ5ZfTLaGD2pbx2Rr/KqbPGL0cx2Cvw3TyhjcnjrNZqUeYxlMoOs5xY9zKBKt2ulOBWcdNBrKe7n6wxsFTlY2hGFY2QE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842772; c=relaxed/simple;
	bh=dn9xvrODsMtdNt7D5BsjaJyTHoozjPJrfT0LPmLNoCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qH9qc8EKLYPKeLG+CFPWoUsBW0BSDQYIIOQBjDVljiKXJeGfdJFqqD4IZkTvFotPcgKFhedB0XcarFfAgRvTmXbehCQAoVb4+akiy9IJPXoWKGxhNnvjOd0vT0uty5jT9zRuh9tNcAAyhIbtxu4jCpfGeMPUcu1MmObRUk017ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kl0wmfEC; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-59a9a737273so984955eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707842770; x=1708447570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=blHijTqV+dWK7bVb7BBxgbNCbSH5xuQhPd5l3+vTo8s=;
        b=kl0wmfECNAWvGKWnjT1653ej1p6PP3SKZKPwjRF120R2AOcGPbtv8cQ75a/LBi0+Y5
         BxDVqYy2hknhFN7h+MBW5QUw+5jtncgbsTTCMFuY72++FBFvJEKjOMp/Q0BkNafEOnpv
         vWDuz44Le/1Fe0Lbx1WKgz4Wx5evcsAtSVSBFo49aByGDPxm7kbEZ/dQbvEh6U5lr+hL
         MVVqZaSQsXTmVfo7UNsRHOLOapoNpjM1Te561twUkT08MmAKhi/MzN+k7twWI22ar1uG
         gMFLCV/330ImXeMvIms9oRMfb3RdZOp1NM2cs5apK5Zo4PGATFyPbuPpG1AjolNbfSy0
         FOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842770; x=1708447570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blHijTqV+dWK7bVb7BBxgbNCbSH5xuQhPd5l3+vTo8s=;
        b=gXTHbhAITFB/JkUrQT/si9JVm2iRIXsSYUr919ADDsYnds27QYEF1I0BcMCJupU/SK
         xxuaJ5OJz8TkKSePcMgqxPKexRhD1BwlebgFYFH89rJxCMM4b+/D8rp8kXNhS8pCPW4X
         iD7x/SRsYKrJ2raXw8XBFT9yXM9QT/zkL21o7+gto+5njwZEuaVaSPk9kXXAEp4Z4USl
         riTdTJ5RZ8hnOK2lvtIvXwr4BmqmI63xs8ld6aY+0yowD8c5uOMVJxyinTbvv9gU1AGE
         WS2KHJz7jsuTLJHlu/HAZIxv5lkNfD2KnrL7NxqN7YwfD6q6LFcBRBE5rcNveZLCCg57
         BsQw==
X-Forwarded-Encrypted: i=1; AJvYcCXX8MkvUFrJ9v4zk3hazzxGzSHmxwCHZv1yNIo1cnBiLw30osr/cS3X+jsB3eOy5+kOZARFuwNHW8fnxJdgavQ+GyotlkMbcLQeNOJL
X-Gm-Message-State: AOJu0Ywp16/w2CECdmdz72zERn6XH57YZM7nDVBabaZDB3CCs1WS9xU+
	N/jFO18IzC7k8GrRLqIMouK3rFrf1JbaVAOx3ls6+6ncdw+Y+CjtqM/vTTMu3JcJO1WP3kTQoH8
	l4kOjI5hNl3V1v5a0tZPkrzctsZI9Um5pKk61Bw==
X-Google-Smtp-Source: AGHT+IEYmb9PezEYNe3vvnpJ3QkU0aNAaoI5ocAGxOGYXy7jmxYgqpyh2bLZYykYnPppDnSxPWREE1gxvKpXzpcY3P8=
X-Received: by 2002:a05:6358:d392:b0:178:6363:5c60 with SMTP id
 mp18-20020a056358d39200b0017863635c60mr6173066rwb.5.1707842770028; Tue, 13
 Feb 2024 08:46:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210113924.1130448-1-alexs@kernel.org> <20240210113924.1130448-2-alexs@kernel.org>
In-Reply-To: <20240210113924.1130448-2-alexs@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 13 Feb 2024 17:45:58 +0100
Message-ID: <CAKfTPtAN6w0yLor2Qtm84eZo-5cRBeMAFvr4KqSqrvpevCZ-xA@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] sched/fair: Remove unused parameters
To: alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Feb 2024 at 12:36, <alexs@kernel.org> wrote:
>
> From: Alex Shi <alexs@kernel.org>
>
> The argument sds is not used in function sched_asym(). Remove it.
>
> Fixes: c9ca07886aaa ("sched/fair: Do not even the number of busy CPUs via asym_packing")
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..607dc310b355 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9749,7 +9749,6 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>  /**
>   * sched_asym - Check if the destination CPU can do asym_packing load balance
>   * @env:       The load balancing environment
> - * @sds:       Load-balancing data with statistics of the local group
>   * @sgs:       Load-balancing statistics of the candidate busiest group
>   * @group:     The candidate busiest group
>   *
> @@ -9768,8 +9767,7 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
>   * otherwise.
>   */
>  static inline bool
> -sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
> -          struct sched_group *group)
> +sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
>  {
>         /* Ensure that the whole local core is idle, if applicable. */
>         if (!sched_use_asym_prio(env->sd, env->dst_cpu))
> @@ -9940,7 +9938,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>         /* Check if dst CPU is idle and preferred to this group */
>         if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
>             env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> -           sched_asym(env, sds, sgs, group)) {
> +           sched_asym(env, sgs, group)) {
>                 sgs->group_asym_packing = 1;
>         }
>
> --
> 2.43.0
>

