Return-Path: <linux-kernel+bounces-97110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 205B68765A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08A6B23E0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C9D3BBE2;
	Fri,  8 Mar 2024 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2YZ2Vzo"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8634B1DA5F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905899; cv=none; b=LuHgdi5LQZZUGlDKmkYLsqi+M2PfdZQzIk9rSscEqOEoBPy83zU5uSrEJMUhAuqqy9CL9ba9RKZDXEmLxlDW7jJuw5nDYIMvYnUm9RQ8IC8rY+PwJSu4vmPzNnzRyiZ/7DT4N6ELX90rps6I6IVNjBFkwCw5Sy/PUR2TFjq87Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905899; c=relaxed/simple;
	bh=fpCZR4rQ2J6Pr3xdEHAvWdNU8uAsOPMHv9VX7UNruME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6nzsNGUnMifbM7A90OAiyQ3YCngHh6Ixg3I34hXvDX/PgHiuCiaM6nc+CpYsG4m+RwKYSAhbWx0EPQhFLVE23v2vdWCXnzAGlpZmhc+fvtsu3Mpi2+AcWUQw8+vZ+LNQE9eazQPDvTfl6AgCFcdZWFgFpfs0LnVWpC9h9a/aQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o2YZ2Vzo; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29a61872f4eso1414136a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 05:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709905897; x=1710510697; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DpV9YsqnFyjGRKSCwJ7zfP8TTh2blHV+LYzWEaymKFU=;
        b=o2YZ2VzoCZXLs1zU/6T9+KDeQunoiU6/wpwWxiOV881TFm+GsfwyLeRJ3unkM+zwf4
         0VfCLqhPvd9xoxL4CT9y+S2HblxbZLMA3QX6W1X/W2mwSgaV+Md7/CIR2se/G1XozPcx
         l8HvKcs3Yw+P3zFwbIvJ6UXRrdXJT1d+ZX5BBiFnTWotVUrBxMJVXdfZ4zQYZ+OtVX5q
         rxwL4zOBDhph69f0F8yLFafhV0ngEk3tWFRe++a1nB3ohDUUT1VvfcQuMwSpCh11xWGk
         NXVfIEjQZLV3pPvcTr1GZFUBZV/LeCuH9l1pwr2LZLh8qNoNeSZs4eIRHMq9lY1Y7rcs
         ATTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709905897; x=1710510697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpV9YsqnFyjGRKSCwJ7zfP8TTh2blHV+LYzWEaymKFU=;
        b=krZ0Vyume0FzxeG+rCstFfrXFbNdQ1bTHujeWqN0IByxfJcOP7BrQI2VnKqjXCfuEL
         q201TGy306NsT/XSKg9zbhkjEFJxTNW4+jcQqyhEct2g6cZbZw4p34gMajmDBrVSGxEC
         lVUdjfiVR1ROcw+XPGnqv4OQpZLOJIlnczoZTRk531E+ZdWrUgr0L7bjvQbY5I3F/i2k
         zpkpEs9AMYY5bveQXmR55x3gC0GY3SVCqwMdHcAc+BOmZitKaQK5fIRTZyq69GORTXxJ
         8QF9JEM90urcsn+aOiGdHSyIxNoi5VlBWjGhPBFfg30QhjcuCae6bLZ2N/doe+zLVQ27
         B6eQ==
X-Gm-Message-State: AOJu0YwKocZnxCtBDOYj2f2NgTYJkaij1sezwshs2JN5790eULEWMU6o
	IzOVyOBk1rMgw/6OEDOAT6vytmhRn9QGNd9HrFiLEbw7eNeSnvK9F7VN5Ijdbt6pVBKV7fJ+keo
	Ow8JPMEpfJq2GANSHTZKruno3mI8c5vI7jKQOeP3kKXk/G8MfqBE=
X-Google-Smtp-Source: AGHT+IGVKW/ocUOOwSvwyOHU9Rxey7wety35rSyG0N10eLnr2nqFdD0b2p/N65OHV8eMhvJPELY4pCkFGhgiYUYplwQ=
X-Received: by 2002:a17:90b:154:b0:29a:998a:cdf1 with SMTP id
 em20-20020a17090b015400b0029a998acdf1mr29844pjb.35.1709905896862; Fri, 08 Mar
 2024 05:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308111819.1101550-1-mingo@kernel.org> <20240308111819.1101550-8-mingo@kernel.org>
In-Reply-To: <20240308111819.1101550-8-mingo@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 8 Mar 2024 14:51:25 +0100
Message-ID: <CAKfTPtAdoZJEWB=ty-uNiPESCgk3wD_GR6mW+ABMGcWthAwNGQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] sched/balancing: Rename find_src_rq() => sched_balance_find_src_rq()
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 12:18, Ingo Molnar <mingo@kernel.org> wrote:
>
> Standardize scheduler load-balancing function names on the
> sched_balance_() prefix.

This patch renames the renaming done by the previous one. They could
be merged in one

sched/balancing: Rename find_busiest_queue() => find_src_rq()
sched/balancing: Rename find_src_rq() => sched_balance_find_src_rq()



>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e600cac7806d..1cd9a18b35e0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10959,9 +10959,9 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  }
>
>  /*
> - * find_src_rq - find the busiest runqueue among the CPUs in the group.
> + * sched_balance_find_src_rq - find the busiest runqueue among the CPUs in the group.
>   */
> -static struct rq *find_src_rq(struct lb_env *env,
> +static struct rq *sched_balance_find_src_rq(struct lb_env *env,
>                                      struct sched_group *group)
>  {
>         struct rq *busiest = NULL, *rq;
> @@ -11280,7 +11280,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>                 goto out_balanced;
>         }
>
> -       busiest = find_src_rq(&env, group);
> +       busiest = sched_balance_find_src_rq(&env, group);
>         if (!busiest) {
>                 schedstat_inc(sd->lb_nobusyq[idle]);
>                 goto out_balanced;
> --
> 2.40.1
>

