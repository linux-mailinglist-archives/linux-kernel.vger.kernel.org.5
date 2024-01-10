Return-Path: <linux-kernel+bounces-22518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88806829EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395F41F22289
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DA54CE13;
	Wed, 10 Jan 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m5ikuyqK"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B22A482DC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cedfc32250so2051851a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704907002; x=1705511802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VXsgZeZk30dEfxW3tPiQAYJjaj/9MuHpTHNgKt9eeeE=;
        b=m5ikuyqKoHuz4dT0u5bmme3wuGBzecE0n57tf7RQHELo7EaiZi0RJUCumdEfwrxF3C
         Ic+pKGoADUceK6y3tmIvTNB8ktPc/TjF5HFBa0wvfPbTC5tQXTwZsXJz3yB3FhwsKor+
         H7Y814cQaFWh1nRXaRMjEpAVYgeQOvi+EG3Lz8Tv0Jg16HDMtUxswsRBlacOUrgMBbqM
         c+EeZNLoBHwjjGHTeM37kfZAzuuvveNwGM8MdXRM2JlaVwOm8Pa1zZZ90ftJf1FCwVKp
         2gnSxUYoOU5xVocXCd5HY7OP0llc4FwLevHIlXqGlgWMpZxu60hvkmyUdnXGglMwFl/B
         Atvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704907002; x=1705511802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXsgZeZk30dEfxW3tPiQAYJjaj/9MuHpTHNgKt9eeeE=;
        b=pjko8Vah3R+3mqH642FtpwgWvkChppmBdMWucDcT+MYCFYtwghRGp5m+ChT2K9zTRs
         VT09/OyV8cqsDx2aEOUe96vyTlxUqm1QvPQRhoFS5qc+KyvvYrHGL1DcR/uWsxj09+OY
         lUzyIWGKbdfR2jhyQTH6kuKSSICBC8rkv/W7cpgH9KIFRvrlX6tmFc9JS71pUdIjROpy
         2Egey3+VtLAWNTEXm22Pf7ZZpXVsuSdSK14OLGZAIMdW41GSh1YKKEmQbHJ5MnrMxIcK
         Sr/X/AgclGWfRL2wg33NeoNLe+rfSFdduRfvF+shOt08GrB9bhKsHUMc/jdIXasvaQkZ
         TxXg==
X-Gm-Message-State: AOJu0YyRrJWpK+EY0UTxWtjfZ7ACnxVJ9zb3cmPCsVbE4jy7ivkQIxOl
	9bMUZN7IN6OkA+n7Ttp0KrapHt5hWUWJ6n6bUJtv9HB0+ydQmg==
X-Google-Smtp-Source: AGHT+IFBT9QzKLS0KB+KvNjaxxTca/gF9GRfN2coCvArMm5ZJVazlS1qXaFEe9/EiKmvfzHpJstCw5pvdq8FPhCqAcg=
X-Received: by 2002:a05:6a20:7da0:b0:199:c888:2af4 with SMTP id
 v32-20020a056a207da000b00199c8882af4mr1156814pzj.90.1704907002226; Wed, 10
 Jan 2024 09:16:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110131707.437301-1-keisuke.nishimura@inria.fr> <20240110131707.437301-2-keisuke.nishimura@inria.fr>
In-Reply-To: <20240110131707.437301-2-keisuke.nishimura@inria.fr>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 10 Jan 2024 18:16:30 +0100
Message-ID: <CAKfTPtAVBv3aaev+X0Nx3TZGYK1X4f+qyfUX2z_oehQg6yPx-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2 RESEND] sched/fair: take into account scheduling
 domain in select_idle_core()
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Julia Lawall <julia.lawall@inria.fr>, 
	Xunlei Pang <xlpang@linux.alibaba.com>, Abel Wu <wuyun.abel@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 14:19, Keisuke Nishimura
<keisuke.nishimura@inria.fr> wrote:
>
> When picking out a CPU on a task wakeup, select_idle_core() has to take
> into account the scheduling domain where the function looks for the CPU.
> This is because the "isolcpus" kernel command line option can remove CPUs
> from the domain to isolate them from other SMT siblings.
>
> This change replaces the set of CPUs allowed to run the task from
> p->cpus_ptr by the intersection of p->cpus_ptr and sched_domain_span(sd)
> which is stored in the cpus argument provided by select_idle_cpu.
>
> Fixes: 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> Signed-off-by: Julia Lawall <julia.lawall@inria.fr>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> v2: - Changed the log message to mention only isolcpus
>
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 66457d4b8965..e2b4e0396af8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7289,7 +7289,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>                 if (!available_idle_cpu(cpu)) {
>                         idle = false;
>                         if (*idle_cpu == -1) {
> -                               if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +                               if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
>                                         *idle_cpu = cpu;
>                                         break;
>                                 }
> @@ -7297,7 +7297,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>                         }
>                         break;
>                 }
> -               if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
> +               if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
>                         *idle_cpu = cpu;
>         }
>
> --
> 2.34.1
>

