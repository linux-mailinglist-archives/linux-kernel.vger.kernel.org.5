Return-Path: <linux-kernel+bounces-9485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4688D81C65A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A741F25FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7E2C8EE;
	Fri, 22 Dec 2023 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPUpsh6a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7AC8C8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7810b3c4fa9so196044285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703233034; x=1703837834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S6moS5fUEbpU3V4mVGtVmKqgvh+EeCGS0mmx/z+0do=;
        b=VPUpsh6aXTY9fqxFX3gv4pPwjRaaEjjn8fQcgYIpT6XUbEV0RPMMhpmlgJrDmj6UhC
         RXSkEZsP0G11s0yYT6LSv7mdWup/BPzpJLQKJKHx1zDhMhY+1JvBiC6KuZRh3yBJNgBN
         59ALu3myApBfHbqTcZ1dCosc8YwGEVNwCQ/iWR9TFmk/R0F65Rfgo5wykVnBTAhhXrGU
         K+0k3OWnR6T72ef7/G84W9hKzr9+HVj2EZroVOgamumD8blS+SGHJylnErV1nI6hCXqJ
         qLa5iDeINHVNHsHaDVFAlOp5LlxnECuLFDVSBwMKaYeLv2EjcfikGCBMJ0KqPhCL5K1Q
         +sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703233034; x=1703837834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3S6moS5fUEbpU3V4mVGtVmKqgvh+EeCGS0mmx/z+0do=;
        b=geuDa526LGPAY+tz1JoYWf+rZn6ub81gUFmjgd1n1LQQg0lm6hjyBQt6qdeCfIV9ZF
         A/PYwH6G9vLhdYwoOgOXPM/DfIsWwlx3eCZYv4TXRWSVXGPcFUt52QM/3IrbjI8znbJi
         J4KACozdoSZ15SpVzRXeZONk8deZuEU4y8+gEFk6ifrnkJ9AgpZLcc/2iefgL4mLIHlW
         F8LlcY0il3ewDG6keaFSQhVJDNdOZ3BmGTQc4M5awuuKQKsDbfkW2/ZgTqfL/k8quzn1
         9Mm6DCFmW9AjD++cMs5DW4ZhZzxGjqO6Eh98W/r0rPlRD6z618Is5iLrSHLuQGapwan8
         cQ9A==
X-Gm-Message-State: AOJu0YxQFjGsZJcDRLEQTJI5JNtT4ZGbbndiNsSN1goLQIlLVdoaXGV1
	6UK0w0MuBt6Se6RKUNoa1M/usCPIcYGhi+fByhVyM2Tlxs+lRg==
X-Google-Smtp-Source: AGHT+IHicUPplRT50ajFFPKTlF1yo8bqZ797EyG7Oxzsptk4kzJFCMA3MBXiC3EBcn1Ud0ULrAk5QylRuN9EFNaHNWI=
X-Received: by 2002:a05:620a:39a:b0:77f:737e:edaf with SMTP id
 q26-20020a05620a039a00b0077f737eedafmr2616467qkm.16.1703233033964; Fri, 22
 Dec 2023 00:17:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221150238.856960-1-wudaemon@163.com>
In-Reply-To: <20231221150238.856960-1-wudaemon@163.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 22 Dec 2023 16:16:37 +0800
Message-ID: <CALOAHbDXWNbxeQEOhGW5m6bd3cLW_jnE2q6XgSpRBHzxt1GOeg@mail.gmail.com>
Subject: Re: [PATCH v2] sched/rt: Fix rt task's sched latency statistics error
 in sched_stat_wait trace_point
To: Junwen Wu <wudaemon@163.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:03=E2=80=AFPM Junwen Wu <wudaemon@163.com> wrote=
:
>
> When enable sched_stat_wait trace_point, some rt tasks sched latency
> so long, like this:
> sched_stat_wait: comm=3Drcu_preempt pid=3D14 delay=3D4936139545261 [ns]
> Rt task has low latency, it must have a bug. When rt task balance off
> source cpu, dequeue operation not update the sched_statistics, so follow
> update_stats_wait_end_fair update method.
>
> Signed-off-by: Junwen Wu <wudaemon@163.com>
> ---
> Changes since v1:
> https://lore.kernel.org/all/20231218150322.788382-1-wudaemon@163.com/
>
>  kernel/sched/rt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 6aaf0a3d6081..6a2600213991 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1360,12 +1360,19 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, stru=
ct sched_rt_entity *rt_se,
>                         int flags)
>  {
>         struct task_struct *p =3D NULL;
> +       struct rq *rq =3D rq_of_rt_se(rt_se);
>
>         if (!schedstat_enabled())
>                 return;
>
>         if (rt_entity_is_task(rt_se))
>                 p =3D rt_task_of(rt_se);
> +        /*
> +         * Mark the end of the wait period
> +         * if dequeueing a waiting task.
> +         */
> +       if (p && (p !=3D rq->curr))
> +               update_stats_wait_end_rt(rt_rq, rt_se);

It seems DL has the same issue. Pls. also fix it in update_stats_dequeue_dl=
().
And add the Fixes tag in the commit log:
Fixes: 57a5c2dafca8 ("sched/rt: Support schedstats for RT sched class")
Fixes: b5eb4a5f6521 ("sched/dl: Support schedstats for deadline sched class=
")

>
>         if ((flags & DEQUEUE_SLEEP) && p) {
>                 unsigned int state;
> --
> 2.34.1
>


--=20
Regards
Yafang

