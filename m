Return-Path: <linux-kernel+bounces-4096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CAA8177E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4A71C23AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B69498A2;
	Mon, 18 Dec 2023 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dyym2sDt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808524FF66
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d32c5ce32eso31538295ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702918131; x=1703522931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jMaYOj60MeA1wo8ZfKzowtN5dTe49uBMZepjxPs8KMA=;
        b=Dyym2sDteFnWUXd8OrDZDuaCrPPWMK6SFcTFQ9hT0S546nsI/R73g1U1j5wVgKUNSq
         lryO73tPsAhNOt8D9Sfu7983Mx0uMrw9Uz0Jxg9M9JXofmr9SiMp1tYXDxd/7Yvb7dAV
         9V/+eAZ9PlxUW8ncCaniYoaQnULCz7xLF1DrkJzLM6oJap3NM3FJUMqxZYu2eQJ9jHk+
         lE/Um5TLqAMr0L9Q8XIzxPwdEZVzjcmTiDtlr20hHb+ftiVsb+21iPGL2Viq23LxUpFn
         X2Y0K6VhrH5UxQx5HBcT9jnmnoxkHU4IGEaM1o1FoIDaJ3xQklgKpv0rA/cySxYvg7ik
         7D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702918131; x=1703522931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jMaYOj60MeA1wo8ZfKzowtN5dTe49uBMZepjxPs8KMA=;
        b=IX6jwwNS7ahpSmAA8kvAIqTML0qbkoy6668NE3NPZDzJOh7hacc6kj/XRi26PuuEIe
         7Hoq6KHKE7vIOCYjAxh6k+Wk266kVfTLCk5eNZgBVJzXbzA1cULdnNa/jp137seJqWyP
         9csGKMOrk2oDH4R0aI4iJddFMYKuADIXhqHkUMZ3Gt2hkR4XEjFY7R+rKx7alAZQv2wk
         EL2eQhqXrEONKypkjjezA/ei2V2/u0/cDrVevwZIGA9GHbs5ojZ3yZlwhRuS4JL/cBWs
         jxEjVHBEAAuPl6iOZaI61fYHhzSD45WZaAEaGmr8n0BKq3X7uyvsdUt+iVl7CUk6hX9l
         pqhw==
X-Gm-Message-State: AOJu0Yxp7g1bZzDghfkfaOpY/lbkJiisbwsgZkdXE60s6JnNWhj7WOGk
	8BNb91V5a7oBMDjEmXS+VY7Sg2LOBHPj70/Yoxv2ew==
X-Google-Smtp-Source: AGHT+IH/8sbNZzhWaYmnYMwm88uEZmBMPtY16kgSNicniac5INBPCupxnLP2b7xwFu7EcHbopxuWFo5CYGaX1Jmmf/0=
X-Received: by 2002:a17:90a:d143:b0:286:6cd8:ef04 with SMTP id
 t3-20020a17090ad14300b002866cd8ef04mr21128337pjw.28.1702918130794; Mon, 18
 Dec 2023 08:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214144204.2179345-1-khorenko@virtuozzo.com>
In-Reply-To: <20231214144204.2179345-1-khorenko@virtuozzo.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 18 Dec 2023 17:48:39 +0100
Message-ID: <CAKfTPtAqkY+attpekOyjeY10dcwgK0eND5_385cH6+wjR3EkTw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Do not scan non-movable tasks several times
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Alexander Atanasov <alexander.atanasov@virtuozzo.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Dec 2023 at 15:42, Konstantin Khorenko
<khorenko@virtuozzo.com> wrote:
>
> If busiest rq is small, nr_running < SCHED_NR_MIGRATE_BREAK and all
> tasks are not movable, detach_tasks() should not iterate more than tasks
> available in the busiest rq.
>
> Previously the (env->loop > env->loop_max) condition prevented us from

It's usually better to give the commit directly when we know it :
Before commit : b0defa7ae03e ("sched/fair: Make sure to try to detach
at least one movable task"),
the (env->loop > env->loop_max) condition prevented us from ...

> scanning non-movable tasks more than rq size times, but after we start
> checking the LBF_ALL_PINNED flag, the "all tasks are not movable" case
> is under threat.
>

Fixes: b0defa7ae03e ("sched/fair: Make sure to try to detach at least
one movable task")

> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  kernel/sched/fair.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d7a3c63a2171..faa2a765e899 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11219,7 +11219,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                 .dst_rq         = this_rq,
>                 .dst_grpmask    = group_balance_mask(sd->groups),
>                 .idle           = idle,
> -               .loop_break     = SCHED_NR_MIGRATE_BREAK,
>                 .cpus           = cpus,
>                 .fbq_type       = all,
>                 .tasks          = LIST_HEAD_INIT(env.tasks),
> @@ -11265,6 +11264,12 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                  * correctly treated as an imbalance.
>                  */
>                 env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
> +               /*
> +                * If busiest rq is small, nr_running < SCHED_NR_MIGRATE_BREAK
> +                * and all tasks are not movable, detach_tasks() should not
> +                * iterate more than tasks available in rq.
> +                */
> +               env.loop_break = min(SCHED_NR_MIGRATE_BREAK, busiest->nr_running);

Should it be after more_balance: ?
In case we do "more_balance:" on a new_dst_cpu and it ends up that
finally there is no more movable task as we released the lock of
busiest rq in the meantime ?

Also you can remove one more superfluous init of loop_break:

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11361,7 +11361,6 @@ static int load_balance(int this_cpu, struct
rq *this_rq,
                         */
                        if (!cpumask_subset(cpus, env.dst_grpmask)) {
                                env.loop = 0;
-                               env.loop_break = SCHED_NR_MIGRATE_BREAK;
                                goto redo;
                        }
                        goto out_all_pinned;

>
>  more_balance:
>                 rq_lock_irqsave(busiest, &rf);
> --
> 2.39.3
>

