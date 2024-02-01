Return-Path: <linux-kernel+bounces-47996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87318455EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3CA1C23725
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BC215CD4F;
	Thu,  1 Feb 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB5XT/Wb"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B33B282;
	Thu,  1 Feb 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785361; cv=none; b=Wg9OnFpHNhk8T3f5SpppwefQgXkqN8i8T2etP0dYkoeTHYW/z+ShBiwkVqBU94/NFNeayFSEzJ8Y/5cdnF20kfeizQLBcxifXeDMLbTCRsbWjN1gkXuabHHE2/Jl8jOAWdgeYa6ZEJ4r0kuNoTXB1Ke4KEPlRNN0oDo51jZmlmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785361; c=relaxed/simple;
	bh=2dmWPDQ5R9c2LqdULlWOzHh+4gSCveh9QCyYtMdRJ/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYPLpqXTYuCEUZSqH5ihe29AHwFHiWvtP739asksJmH9tu+8hewJzU+PS1uT8SqBR52u+3J4//sgyIhZHhVdxsA3BcdhVLPssV9Rjm34hgyPuytSeF9ozskCzxFSH1QMj1+SRXgxwbVIHWFg1U5Q/biLl5hMFqTID7P8PySP0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eB5XT/Wb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-295a7fd8eecso543843a91.0;
        Thu, 01 Feb 2024 03:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706785359; x=1707390159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pusx3ThehDtkCFeS2uzDn/v0Hqy5t7nRhzEa+erThAA=;
        b=eB5XT/WbD9WQB38Vw5Q7Ne5/yysdUc5sagPHFUUvTJ8z0SyaS51hLjGyW4FasDOc5/
         +ZMe1l8U9SDm0QOaIX5Iyub3ilZ07WJ23gRc7dmhAjg1dYnu18WO0q+H6c5poyb8qJV3
         W5D+K4WJ5eqCbDRkx0caChnvGEZ1ZYX6z8DEur7JqC4lQPkm6ElM8yvDbYP/8tlKx3nP
         jaoIAFph0qxN6AyIdTKgt15sDdu4YQpBo3GealFYWWnsSH0NrsyXy4YHywTImpXDgJYA
         C6vFEfzwAfWV/A1m8wVyti4ZmkEIZbCk73jElTinglBeGPc+ok+I7t4hzSknWyLDQsVl
         9jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706785359; x=1707390159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pusx3ThehDtkCFeS2uzDn/v0Hqy5t7nRhzEa+erThAA=;
        b=EMmO331+VCmLtKknNApzw3M+NzS94z9S5CXmri6XMgIO4d6YO+NNgJhutxndPZTya5
         tKca+59gdquOKdkmSotpIp4XEh9h1Xfzeg59Jtq/77aDsF7omvx6mE/3aflgRHD2fKfH
         yzJrndqBjzlgZExvaOfJHfmBquHMWcA0VqTfEv05lijjA8h28eDM9t2iUvEBGs4bc0mm
         GYG9+jYwivdTxIAlyoU0Z4lIDqEHDml77kkUOWtk7FUCAqzHEWP43XSrh/jZudiprv/X
         sKqupSGPSnS0V5psP6PmCK1uL9I41kcEcYFTJcXfabK9I/eNyxQ0zdx2joqTrT9ukYKu
         mp4w==
X-Gm-Message-State: AOJu0Yx+TCniFesTrnpyd58TSFvWURJVGLZT9DhHCTF9tySjNu4Ugziu
	xpPlOyUZyB3ORc3Q7zh/KgGhQDrscsgWHLiruj6tbYc8n0Xblz3jv6mAwbraZqWFZNU41DELr/2
	aUzJ3sx4B92DAW7raPi62TRRjtGg=
X-Google-Smtp-Source: AGHT+IEyOBR5rhazGcXT0AFdr/77EP9PwleE87hbxB6CnvNhsXAa3JubOu6hYljwx9jkzhREXz4N6POR/eedfM/ufao=
X-Received: by 2002:a17:90a:f0c4:b0:296:2578:a54c with SMTP id
 fa4-20020a17090af0c400b002962578a54cmr305349pjb.38.1706785358686; Thu, 01 Feb
 2024 03:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-4-tj@kernel.org>
In-Reply-To: <20240130091300.2968534-4-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 1 Feb 2024 19:02:27 +0800
Message-ID: <CAJhGHyCk_cjD-Ex_OAd=DrBkTEe0Xvs81=On65Sp7sS8zNBfGQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] workqueue: Implement BH workqueues to eventually
 replace tasklets
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	ignat@cloudflare.com, damien.lemoal@wdc.com, bob.liu@oracle.com, 
	houtao1@huawei.com, peterz@infradead.org, mingo@kernel.org, 
	netdev@vger.kernel.org, allen.lkml@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Tejun

On Tue, Jan 30, 2024 at 5:16=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:

> @@ -1184,6 +1211,14 @@ static bool kick_pool(struct worker_pool *pool)
>         if (!need_more_worker(pool) || !worker)
>                 return false;
>
> +       if (pool->flags & POOL_BH) {
> +               if (pool->attrs->nice =3D=3D HIGHPRI_NICE_LEVEL)
> +                       tasklet_hi_schedule(&worker->bh_tasklet);
> +               else
> +                       tasklet_schedule(&worker->bh_tasklet);
> +               return true;
> +       }

I think it is more straightforward to call bh_worker_taskletfn[_hi]()
in tasklet_action() and tasklet_hi_action() rather than add a
worker->bh_tasklet.

raise_softirq_irqoff() can be used here (kick_pool()) instead.

As the changelog said, once the conversion is complete, tasklet can be
removed and BH workqueues can directly take over the tasklet softirqs,
in which case, then, bh_worker_taskletfn[_hi]() can directly take over
the tasklet_action() and tasklet_hi_action().


> +
>         p =3D worker->task;
>
>  #ifdef CONFIG_SMP
> @@ -1663,8 +1698,16 @@ static bool pwq_tryinc_nr_active(struct pool_workq=
ueue *pwq, bool fill)
>         lockdep_assert_held(&pool->lock);
>
>         if (!nna) {
> -               /* per-cpu workqueue, pwq->nr_active is sufficient */
> -               obtained =3D pwq->nr_active < READ_ONCE(wq->max_active);
> +               /*
> +                * BH workqueues always share a single execution context =
per CPU
> +                * and don't impose any max_active limit, so tryinc alway=
s
> +                * succeeds. For a per-cpu workqueue, checking pwq->nr_ac=
tive is
> +                * sufficient.
> +                */
> +               if (wq->flags & WQ_BH)
> +                       obtained =3D true;
> +               else
> +                       obtained =3D pwq->nr_active < READ_ONCE(wq->max_a=
ctive);

I think wq->max_active can be forced to be UINT_MAX or ULONG_MAX
in the max_active management code to avoid a branch here.

>                 goto out;
>         }
>
> @@ -2599,27 +2642,31 @@ static struct worker *create_worker(struct worker=
_pool *pool)
>
>         worker->id =3D id;
>
> -       if (pool->cpu >=3D 0)
> -               snprintf(id_buf, sizeof(id_buf), "%d:%d%s", pool->cpu, id=
,
> -                        pool->attrs->nice < 0  ? "H" : "");
> -       else
> -               snprintf(id_buf, sizeof(id_buf), "u%d:%d", pool->id, id);
> -
> -       worker->task =3D kthread_create_on_node(worker_thread, worker, po=
ol->node,
> -                                             "kworker/%s", id_buf);
> -       if (IS_ERR(worker->task)) {
> -               if (PTR_ERR(worker->task) =3D=3D -EINTR) {
> -                       pr_err("workqueue: Interrupted when creating a wo=
rker thread \"kworker/%s\"\n",
> -                              id_buf);
> -               } else {
> -                       pr_err_once("workqueue: Failed to create a worker=
 thread: %pe",
> -                                   worker->task);
> +       if (pool->flags & POOL_BH) {
> +               tasklet_setup(&worker->bh_tasklet, bh_worker_taskletfn);
> +       } else {
> +               if (pool->cpu >=3D 0)
> +                       snprintf(id_buf, sizeof(id_buf), "%d:%d%s", pool-=
>cpu, id,
> +                                pool->attrs->nice < 0  ? "H" : "");
> +               else
> +                       snprintf(id_buf, sizeof(id_buf), "u%d:%d", pool->=
id, id);
> +
> +               worker->task =3D kthread_create_on_node(worker_thread, wo=
rker,
> +                                       pool->node, "kworker/%s", id_buf)=
;
> +               if (IS_ERR(worker->task)) {
> +                       if (PTR_ERR(worker->task) =3D=3D -EINTR) {
> +                               pr_err("workqueue: Interrupted when creat=
ing a worker thread \"kworker/%s\"\n",
> +                                      id_buf);
> +                       } else {
> +                               pr_err_once("workqueue: Failed to create =
a worker thread: %pe",
> +                                           worker->task);
> +                       }
> +                       goto fail;
>                 }
> -               goto fail;
> -       }
>
> -       set_user_nice(worker->task, pool->attrs->nice);
> -       kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
> +               set_user_nice(worker->task, pool->attrs->nice);
> +               kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
> +       }
>
>         /* successful, attach the worker to the pool */
>         worker_attach_to_pool(worker, pool);

worker_attach_to_pool() and worker_detach_from_pool also access to
worker->task with kthread_set_per_cpu() and luckily to_kthread()
checks the NULL pointer for it.

IMO, it is better to avoid calling kthread_set_per_cpu() for bh workers.




> @@ -5605,7 +5731,12 @@ static void pr_cont_pool_info(struct worker_pool *=
pool)
>         pr_cont(" cpus=3D%*pbl", nr_cpumask_bits, pool->attrs->cpumask);
>         if (pool->node !=3D NUMA_NO_NODE)
>                 pr_cont(" node=3D%d", pool->node);
> -       pr_cont(" flags=3D0x%x nice=3D%d", pool->flags, pool->attrs->nice=
);
> +       pr_cont(" flags=3D0x%x", pool->flags);
> +       if (pool->flags & POOL_BH)
> +               pr_cont(" bh%s",
> +                       pool->attrs->nice =3D=3D HIGHPRI_NICE_LEVEL ? "-h=
i" : "");
> +       else
> +               pr_cont(" nice=3D%d", pool->attrs->nice);

There are also some "worker->task" in show_pwq(), show_one_worker_pool(),
and show_cpu_pool_hog() needing taking care of.

Thanks
Lai

