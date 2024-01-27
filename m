Return-Path: <linux-kernel+bounces-41034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06E383EA86
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A0E282762
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED7BD51B;
	Sat, 27 Jan 2024 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP2/HJ+i"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5033F6
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706325233; cv=none; b=IiQCiKIRgdrCL//npiEp2EsNCwAWxscU3gRUKewSr3lhNDrLHt+64rclG+tSC58sqwMmMGKLfjX8BEAdX6Y1ufYt6creOpFtw01b1oJcUi3gP0Om+V4K9xNM5dOpKHHXessPbUAgW+J7eEpjiwiQL6+6LEvpEp9+ZIC0EyvmU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706325233; c=relaxed/simple;
	bh=4SNdYzfNPyEvhWfg4axXyhN+pt43Y1+Dnb8yhhKKi7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYsNBvLvUzEhHulY1t1gPcOpwBfR2bK7O8QGuBJeeIIDcQRt6xYlAINpTHcdxf6lZPThCIB0ciLWLgcGnGfhqjG7T5kbiKgkRzJ1bYxTjzxjCYkJ0liX5ywFsQXXyZPk9iWh2nhcZHZTaZ5R7F2Ihl06pjyGCfNmqsAO4/uKvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lP2/HJ+i; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d2dfa80009so548143241.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706325230; x=1706930030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CKjMxETk2BjuzBJG7zK6cr0INEMyPnGweJsjK1w0ZWg=;
        b=lP2/HJ+irZl0KCvyvGMNJhxxSwakrVcYwib0Cl3XqSeTAeKs1o0dkQ5vKOnrlsPdeP
         tTmhW79E3uM16s28VUbwbCV1JrwwU6sH7VAssXa37+Gv62Xp8OperJmgjm6dYGT1kdBk
         k7a3sH63guuKTqif89+I5ftr0gqqP3ge2o+YUW+QqFtKwzkkEM+B9RZxXhuR6EIO3L95
         Y3REz7f0Zp4k0PMU0tSf65+07sJWf/GPYJwBW28Td4iY30uRSJpVG0XOseB1+32DFRi+
         pZJe2WsReWhdOElCpGW775C48GISRiT2QmFzzG8UCwCk7Y/WKcXX+MpChypSmesUeDg+
         eT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706325230; x=1706930030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKjMxETk2BjuzBJG7zK6cr0INEMyPnGweJsjK1w0ZWg=;
        b=PJ5DXb8U2RH2CLJWad4+kjk/iQ9jP0Dw+0xufxTUW0tG0Qui2O2+IaaBXLZqn5cHD4
         /F3xuLsJ7+DsZgfdQFYT44R/bAOBqjyWr+VIcLeUGwvqMI8/xh5VbOcG5HNzmlQrWyRb
         yo8jcOagJpO2J1x5OlEBjDRy1J7W5Go5eNHIxLqG4vzVYDYkYwyhW/LYPObAIwnz8kZl
         zU0X2DgAY9F7nGFxtCkN4ORhkJf16pszse4SfFzKTbzvfA4fKpmr0XKEkHlGSv6ZkP8p
         KXE7tKAorWb6Vu+xCf8FF8sWIt2nAinItwvJ4CLCQZbKmsB02TVB0y9rk52aJJtrRiKc
         4GSQ==
X-Gm-Message-State: AOJu0YyJ22/J5jMnK/XVCjhmo6jqJFNzNXq+/PcldJtyvCMWKJraJ4Rq
	cvx+GcBWHsgdgyZlHfPq0pp3Z3e6cxc+nTlW2JXHoaGZ4lrUm5WE/eUtdY5SGc2joHrQFQEP7SV
	Ouvt9JPFBi6ZTxNHMZXXlrjO19vg=
X-Google-Smtp-Source: AGHT+IGymrwXrC0s7Kh9tYzFjuOvOcYPakBzBbjYI83c5zjY7JdMawKXD2X7cb4iLr41hnS8FONxdKDOzpGzbQHIiiA=
X-Received: by 2002:a67:f888:0:b0:468:90e:2c88 with SMTP id
 h8-20020a67f888000000b00468090e2c88mr530178vso.35.1706325230337; Fri, 26 Jan
 2024 19:13:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com>
 <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com> <ZbRDnSyiSE93puQL@slm.duckdns.org>
In-Reply-To: <ZbRDnSyiSE93puQL@slm.duckdns.org>
From: Allen <allen.lkml@gmail.com>
Date: Fri, 26 Jan 2024 19:13:39 -0800
Message-ID: <CAOMdWSLZVXap0Lz7p7aFitFbmcornmSM0w+cuO1GMhiZ-OwzHg@mail.gmail.com>
Subject: Re: [PATCH] softirq: fix memory corruption when freeing tasklet_struct
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
	Mike Snitzer <msnitzer@redhat.com>, Ignat Korchagin <ignat@cloudflare.com>, 
	Damien Le Moal <damien.lemoal@wdc.com>, Bob Liu <bob.liu@oracle.com>, Hou Tao <houtao1@huawei.com>, 
	Nathan Huckleberry <nhuck@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain; charset="UTF-8"

>
> The following is a draft patch which implements atomic workqueues and
> convert dm-crypt to use it instead of tasklet. It's an early draft and very
> lightly tested but seems to work more or less. It's on top of wq/for6.9 + a
> pending patchset. The following git branch can be used for testing.
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git wq-atomic-draft
>
> I'll go over it to make sure all the pieces work. While it adds some
> complications, it doesn't seem too bad and conversion from tasklet should be
> straightforward too.
>
> - It hooks into tasklet[_hi] for now but if we get to update all of tasklet
>   users, we can just repurpose the tasklet softirq slots directly.
>
> - I thought about allowing busy-waits for flushes and cancels but it didn't
>   seem necessary. Keeping them blocking has the benefit of avoiding possible
>   nasty deadlocks. We can revisit if there's need.
>
> - Compared to tasklet, each work item goes through a bit more management
>   code because I wanted to keep the code as unified as possible to regular
>   threaded workqueues. That said, it's not a huge amount and my bet is that
>   the difference is unlikely to be noticeable.
>

Tejun,

  Thank you very much. I really like the approach you have taken in
this patchset.
My design/thought was very similar to the idea you have, tocreate a
new workqueue specifically for bottom half execution.
I missed this bit,   WQ_ATOMIC | WQ_HIGHPRI and many other cases that
you have covered in your patch.

  Here's a partial diff of the idea:

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 2cc0a9606175..3eaa80826b8d 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -348,6 +348,7 @@ static inline unsigned int work_static(struct
work_struct *work) { return 0; }
  * Documentation/core-api/workqueue.rst.
  */
 enum {
+       WQ_IRQ                  = 1 << 0, /* for bottom half */
        WQ_UNBOUND              = 1 << 1, /* not bound to any cpu */
        WQ_FREEZABLE            = 1 << 2, /* freeze during suspend */
        WQ_MEM_RECLAIM          = 1 << 3, /* may be used for memory reclaim */
@@ -426,6 +427,7 @@ extern struct workqueue_struct *system_highpri_wq;
 extern struct workqueue_struct *system_long_wq;
 extern struct workqueue_struct *system_unbound_wq;
 extern struct workqueue_struct *system_freezable_wq;
+extern struct workqueue_struct *system_irq_wq;
 extern struct workqueue_struct *system_power_efficient_wq;
 extern struct workqueue_struct *system_freezable_power_efficient_wq;

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed892..64db4fc0d0c7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -436,6 +436,8 @@ struct workqueue_struct *system_unbound_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_unbound_wq);
 struct workqueue_struct *system_freezable_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_freezable_wq);
+struct workqueue_struct *system_irq_wq __ro_after_init;
+EXPORT_SYMBOL_GPL(irq_bh_wq);
 struct workqueue_struct *system_power_efficient_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_power_efficient_wq);
 struct workqueue_struct *system_freezable_power_efficient_wq __ro_after_init;
@@ -6689,13 +6691,15 @@ void __init workqueue_init_early(void)
                                            WQ_MAX_ACTIVE);
        system_freezable_wq = alloc_workqueue("events_freezable",
                                              WQ_FREEZABLE, 0);
+       system_irq_wq = alloc_workqueue("events_irq",
+                                       WQ_IRQ, 0);
        system_power_efficient_wq = alloc_workqueue("events_power_efficient",
                                              WQ_POWER_EFFICIENT, 0);
        system_freezable_power_efficient_wq =
alloc_workqueue("events_freezable_power_efficient",
                                              WQ_FREEZABLE | WQ_POWER_EFFICIENT,
                                              0);
        BUG_ON(!system_wq || !system_highpri_wq || !system_long_wq ||
-              !system_unbound_wq || !system_freezable_wq ||
+              !system_unbound_wq || !system_freezable_wq || !system_irq_wq ||
               !system_power_efficient_wq ||
               !system_freezable_power_efficient_wq);


 This patchset makes a lot more sense to use as a base to list of
patches that I have that move away
from tasklets. I will rebase my work on top of your branch and test it.

Thanks.

> Thanks.
>
> From 8224d2602ef454ca164f4added765dc4dddd5e16 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Fri, 26 Jan 2024 13:21:42 -1000
> Subject: [PATCH] workqueue: DRAFT: Implement atomic workqueue and convert
>  dmcrypt to use it
>
> ---
>  drivers/md/dm-crypt.c       |  36 +-----
>  include/linux/workqueue.h   |   6 +
>  kernel/workqueue.c          | 234 +++++++++++++++++++++++++++---------
>  kernel/workqueue_internal.h |   3 +
>  4 files changed, 186 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 855b482cbff1..d375285db202 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -73,11 +73,8 @@ struct dm_crypt_io {
>         struct bio *base_bio;
>         u8 *integrity_metadata;
>         bool integrity_metadata_from_pool:1;
> -       bool in_tasklet:1;
>
>         struct work_struct work;
> -       struct tasklet_struct tasklet;
> -
>         struct convert_context ctx;
>
>         atomic_t io_pending;
> @@ -1762,7 +1759,6 @@ static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
>         io->ctx.r.req = NULL;
>         io->integrity_metadata = NULL;
>         io->integrity_metadata_from_pool = false;
> -       io->in_tasklet = false;
>         atomic_set(&io->io_pending, 0);
>  }
>
> @@ -1771,13 +1767,6 @@ static void crypt_inc_pending(struct dm_crypt_io *io)
>         atomic_inc(&io->io_pending);
>  }
>
> -static void kcryptd_io_bio_endio(struct work_struct *work)
> -{
> -       struct dm_crypt_io *io = container_of(work, struct dm_crypt_io, work);
> -
> -       bio_endio(io->base_bio);
> -}
> -
>  /*
>   * One of the bios was finished. Check for completion of
>   * the whole request and correctly clean up the buffer.
> @@ -1800,21 +1789,6 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
>                 kfree(io->integrity_metadata);
>
>         base_bio->bi_status = error;
> -
> -       /*
> -        * If we are running this function from our tasklet,
> -        * we can't call bio_endio() here, because it will call
> -        * clone_endio() from dm.c, which in turn will
> -        * free the current struct dm_crypt_io structure with
> -        * our tasklet. In this case we need to delay bio_endio()
> -        * execution to after the tasklet is done and dequeued.
> -        */
> -       if (io->in_tasklet) {
> -               INIT_WORK(&io->work, kcryptd_io_bio_endio);
> -               queue_work(cc->io_queue, &io->work);
> -               return;
> -       }
> -
>         bio_endio(base_bio);
>  }
>
> @@ -2246,11 +2220,6 @@ static void kcryptd_crypt(struct work_struct *work)
>                 kcryptd_crypt_write_convert(io);
>  }
>
> -static void kcryptd_crypt_tasklet(unsigned long work)
> -{
> -       kcryptd_crypt((struct work_struct *)work);
> -}
> -
>  static void kcryptd_queue_crypt(struct dm_crypt_io *io)
>  {
>         struct crypt_config *cc = io->cc;
> @@ -2263,9 +2232,8 @@ static void kcryptd_queue_crypt(struct dm_crypt_io *io)
>                  * it is being executed with irqs disabled.
>                  */
>                 if (in_hardirq() || irqs_disabled()) {
> -                       io->in_tasklet = true;
> -                       tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
> -                       tasklet_schedule(&io->tasklet);
> +                       INIT_WORK(&io->work, kcryptd_crypt);
> +                       queue_work(system_atomic_wq, &io->work);
>                         return;
>                 }
>
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 232baea90a1d..1e4938b5b176 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -353,6 +353,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
>   * Documentation/core-api/workqueue.rst.
>   */
>  enum wq_flags {
> +       WQ_ATOMIC               = 1 << 0, /* execute in softirq context */
>         WQ_UNBOUND              = 1 << 1, /* not bound to any cpu */
>         WQ_FREEZABLE            = 1 << 2, /* freeze during suspend */
>         WQ_MEM_RECLAIM          = 1 << 3, /* may be used for memory reclaim */
> @@ -392,6 +393,9 @@ enum wq_flags {
>         __WQ_ORDERED            = 1 << 17, /* internal: workqueue is ordered */
>         __WQ_LEGACY             = 1 << 18, /* internal: create*_workqueue() */
>         __WQ_ORDERED_EXPLICIT   = 1 << 19, /* internal: alloc_ordered_workqueue() */
> +
> +       /* atomic wq only allows the following flags */
> +       __WQ_ATOMIC_ALLOWS      = WQ_ATOMIC | WQ_HIGHPRI,
>  };
>
>  enum wq_consts {
> @@ -442,6 +446,8 @@ extern struct workqueue_struct *system_unbound_wq;
>  extern struct workqueue_struct *system_freezable_wq;
>  extern struct workqueue_struct *system_power_efficient_wq;
>  extern struct workqueue_struct *system_freezable_power_efficient_wq;
> +extern struct workqueue_struct *system_atomic_wq;
> +extern struct workqueue_struct *system_atomic_highpri_wq;
>
>  /**
>   * alloc_workqueue - allocate a workqueue
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 23740c9ed57a..2a8f21494676 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -73,7 +73,8 @@ enum worker_pool_flags {
>          * wq_pool_attach_mutex to avoid changing binding state while
>          * worker_attach_to_pool() is in progress.
>          */
> -       POOL_MANAGER_ACTIVE     = 1 << 0,       /* being managed */
> +       POOL_ATOMIC             = 1 << 0,       /* is an atomic pool */
> +       POOL_MANAGER_ACTIVE     = 1 << 1,       /* being managed */
>         POOL_DISASSOCIATED      = 1 << 2,       /* cpu can't serve workers */
>  };
>
> @@ -115,6 +116,14 @@ enum wq_internal_consts {
>         WQ_NAME_LEN             = 32,
>  };
>
> +/*
> + * We don't want to trap softirq for too long. See MAX_SOFTIRQ_TIME and
> + * MAX_SOFTIRQ_RESTART in kernel/softirq.c. These are macros because
> + * msecs_to_jiffies() can't be an initializer.
> + */
> +#define ATOMIC_WORKER_JIFFIES  msecs_to_jiffies(2)
> +#define ATOMIC_WORKER_RESTARTS 10
> +
>  /*
>   * Structure fields follow one of the following exclusion rules.
>   *
> @@ -441,8 +450,13 @@ static bool wq_debug_force_rr_cpu = false;
>  #endif
>  module_param_named(debug_force_rr_cpu, wq_debug_force_rr_cpu, bool, 0644);
>
> +/* the atomic worker pools */
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS],
> +                                    atomic_worker_pools);
> +
>  /* the per-cpu worker pools */
> -static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS], cpu_worker_pools);
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS],
> +                                    cpu_worker_pools);
>
>  static DEFINE_IDR(worker_pool_idr);    /* PR: idr of all pools */
>
> @@ -476,8 +490,13 @@ struct workqueue_struct *system_power_efficient_wq __ro_after_init;
>  EXPORT_SYMBOL_GPL(system_power_efficient_wq);
>  struct workqueue_struct *system_freezable_power_efficient_wq __ro_after_init;
>  EXPORT_SYMBOL_GPL(system_freezable_power_efficient_wq);
> +struct workqueue_struct *system_atomic_wq;
> +EXPORT_SYMBOL_GPL(system_atomic_wq);
> +struct workqueue_struct *system_atomic_highpri_wq;
> +EXPORT_SYMBOL_GPL(system_atomic_highpri_wq);
>
>  static int worker_thread(void *__worker);
> +static void atomic_worker_taskletfn(struct tasklet_struct *tasklet);
>  static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
>  static void show_pwq(struct pool_workqueue *pwq);
>  static void show_one_worker_pool(struct worker_pool *pool);
> @@ -496,6 +515,11 @@ static void show_one_worker_pool(struct worker_pool *pool);
>                          !lockdep_is_held(&wq_pool_mutex),              \
>                          "RCU, wq->mutex or wq_pool_mutex should be held")
>
> +#define for_each_atomic_worker_pool(pool, cpu)                         \
> +       for ((pool) = &per_cpu(atomic_worker_pools, cpu)[0];            \
> +            (pool) < &per_cpu(atomic_worker_pools, cpu)[NR_STD_WORKER_POOLS]; \
> +            (pool)++)
> +
>  #define for_each_cpu_worker_pool(pool, cpu)                            \
>         for ((pool) = &per_cpu(cpu_worker_pools, cpu)[0];               \
>              (pool) < &per_cpu(cpu_worker_pools, cpu)[NR_STD_WORKER_POOLS]; \
> @@ -1184,6 +1208,14 @@ static bool kick_pool(struct worker_pool *pool)
>         if (!need_more_worker(pool) || !worker)
>                 return false;
>
> +       if (pool->flags & POOL_ATOMIC) {
> +               if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
> +                       tasklet_hi_schedule(&worker->atomic_tasklet);
> +               else
> +                       tasklet_schedule(&worker->atomic_tasklet);
> +               return true;
> +       }
> +
>         p = worker->task;
>
>  #ifdef CONFIG_SMP
> @@ -1663,8 +1695,15 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
>         lockdep_assert_held(&pool->lock);
>
>         if (!nna) {
> -               /* per-cpu workqueue, pwq->nr_active is sufficient */
> -               obtained = pwq->nr_active < READ_ONCE(wq->max_active);
> +               /*
> +                * An atomic workqueue always have a single worker per-cpu and
> +                * doesn't impose additional max_active limit. For a per-cpu
> +                * workqueue, checking pwq->nr_active is sufficient.
> +                */
> +               if (wq->flags & WQ_ATOMIC)
> +                       obtained = true;
> +               else
> +                       obtained = pwq->nr_active < READ_ONCE(wq->max_active);
>                 goto out;
>         }
>
> @@ -2591,27 +2630,31 @@ static struct worker *create_worker(struct worker_pool *pool)
>
>         worker->id = id;
>
> -       if (pool->cpu >= 0)
> -               snprintf(id_buf, sizeof(id_buf), "%d:%d%s", pool->cpu, id,
> -                        pool->attrs->nice < 0  ? "H" : "");
> -       else
> -               snprintf(id_buf, sizeof(id_buf), "u%d:%d", pool->id, id);
> -
> -       worker->task = kthread_create_on_node(worker_thread, worker, pool->node,
> -                                             "kworker/%s", id_buf);
> -       if (IS_ERR(worker->task)) {
> -               if (PTR_ERR(worker->task) == -EINTR) {
> -                       pr_err("workqueue: Interrupted when creating a worker thread \"kworker/%s\"\n",
> -                              id_buf);
> -               } else {
> -                       pr_err_once("workqueue: Failed to create a worker thread: %pe",
> -                                   worker->task);
> +       if (pool->flags & POOL_ATOMIC) {
> +               tasklet_setup(&worker->atomic_tasklet, atomic_worker_taskletfn);
> +       } else {
> +               if (pool->cpu >= 0)
> +                       snprintf(id_buf, sizeof(id_buf), "%d:%d%s", pool->cpu, id,
> +                                pool->attrs->nice < 0  ? "H" : "");
> +               else
> +                       snprintf(id_buf, sizeof(id_buf), "u%d:%d", pool->id, id);
> +
> +               worker->task = kthread_create_on_node(worker_thread, worker,
> +                                       pool->node, "kworker/%s", id_buf);
> +               if (IS_ERR(worker->task)) {
> +                       if (PTR_ERR(worker->task) == -EINTR) {
> +                               pr_err("workqueue: Interrupted when creating a worker thread \"kworker/%s\"\n",
> +                                      id_buf);
> +                       } else {
> +                               pr_err_once("workqueue: Failed to create a worker thread: %pe",
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
> @@ -2627,7 +2670,8 @@ static struct worker *create_worker(struct worker_pool *pool)
>          * check if not woken up soon. As kick_pool() is noop if @pool is empty,
>          * wake it up explicitly.
>          */
> -       wake_up_process(worker->task);
> +       if (worker->task)
> +               wake_up_process(worker->task);
>
>         raw_spin_unlock_irq(&pool->lock);
>
> @@ -3043,25 +3087,35 @@ __acquires(&pool->lock)
>         lock_map_release(&lockdep_map);
>         lock_map_release(&pwq->wq->lockdep_map);
>
> -       if (unlikely(in_atomic() || lockdep_depth(current) > 0 ||
> -                    rcu_preempt_depth() > 0)) {
> -               pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d/%d\n"
> -                      "     last function: %ps\n",
> -                      current->comm, preempt_count(), rcu_preempt_depth(),
> -                      task_pid_nr(current), worker->current_func);
> -               debug_show_held_locks(current);
> -               dump_stack();
> -       }
> +       if (worker->task) {
> +               if (unlikely(in_atomic() || lockdep_depth(current) > 0 ||
> +                            rcu_preempt_depth() > 0)) {
> +                       pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d/%d\n"
> +                              "     last function: %ps\n",
> +                              current->comm, preempt_count(),
> +                              rcu_preempt_depth(), task_pid_nr(current),
> +                              worker->current_func);
> +                       debug_show_held_locks(current);
> +                       dump_stack();
> +               }
>
> -       /*
> -        * The following prevents a kworker from hogging CPU on !PREEMPTION
> -        * kernels, where a requeueing work item waiting for something to
> -        * happen could deadlock with stop_machine as such work item could
> -        * indefinitely requeue itself while all other CPUs are trapped in
> -        * stop_machine. At the same time, report a quiescent RCU state so
> -        * the same condition doesn't freeze RCU.
> -        */
> -       cond_resched();
> +               /*
> +                * The following prevents a kworker from hogging CPU on
> +                * !PREEMPTION kernels, where a requeueing work item waiting for
> +                * something to happen could deadlock with stop_machine as such
> +                * work item could indefinitely requeue itself while all other
> +                * CPUs are trapped in stop_machine. At the same time, report a
> +                * quiescent RCU state so the same condition doesn't freeze RCU.
> +                */
> +               if (worker->task)
> +                       cond_resched();
> +       } else {
> +               if (unlikely(lockdep_depth(current) > 0)) {
> +                       pr_err("BUG: atomic workqueue leaked lock: last function: %ps\n",
> +                              worker->current_func);
> +                       debug_show_held_locks(current);
> +               }
> +       }
>
>         raw_spin_lock_irq(&pool->lock);
>
> @@ -3344,6 +3398,44 @@ static int rescuer_thread(void *__rescuer)
>         goto repeat;
>  }
>
> +void atomic_worker_taskletfn(struct tasklet_struct *tasklet)
> +{
> +       struct worker *worker =
> +               container_of(tasklet, struct worker, atomic_tasklet);
> +       struct worker_pool *pool = worker->pool;
> +       int nr_restarts = ATOMIC_WORKER_RESTARTS;
> +       unsigned long end = jiffies + ATOMIC_WORKER_JIFFIES;
> +
> +       raw_spin_lock_irq(&pool->lock);
> +       worker_leave_idle(worker);
> +
> +       /*
> +        * This function follows the structure of worker_thread(). See there for
> +        * explanations on each step.
> +        */
> +       if (need_more_worker(pool))
> +               goto done;
> +
> +       WARN_ON_ONCE(!list_empty(&worker->scheduled));
> +       worker_clr_flags(worker, WORKER_PREP | WORKER_REBOUND);
> +
> +       do {
> +               struct work_struct *work =
> +                       list_first_entry(&pool->worklist,
> +                                        struct work_struct, entry);
> +
> +               if (assign_work(work, worker, NULL))
> +                       process_scheduled_works(worker);
> +       } while (--nr_restarts && time_before(jiffies, end) &&
> +                keep_working(pool));
> +
> +       worker_set_flags(worker, WORKER_PREP);
> +done:
> +       worker_enter_idle(worker);
> +       kick_pool(pool);
> +       raw_spin_unlock_irq(&pool->lock);
> +}
> +
>  /**
>   * check_flush_dependency - check for flush dependency sanity
>   * @target_wq: workqueue being flushed
> @@ -5149,6 +5241,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>         size_t wq_size;
>         int name_len;
>
> +       if (flags & WQ_ATOMIC) {
> +               if (WARN_ON_ONCE(flags & ~__WQ_ATOMIC_ALLOWS))
> +                       return NULL;
> +               if (WARN_ON_ONCE(max_active))
> +                       return NULL;
> +       }
> +
>         /*
>          * Unbound && max_active == 1 used to imply ordered, which is no longer
>          * the case on many machines due to per-pod pools. While
> @@ -7094,6 +7193,22 @@ static void __init restrict_unbound_cpumask(const char *name, const struct cpuma
>         cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, mask);
>  }
>
> +static void __init init_cpu_worker_pool(struct worker_pool *pool, int cpu, int nice)
> +{
> +       BUG_ON(init_worker_pool(pool));
> +       pool->cpu = cpu;
> +       cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
> +       cpumask_copy(pool->attrs->__pod_cpumask, cpumask_of(cpu));
> +       pool->attrs->nice = nice;
> +       pool->attrs->affn_strict = true;
> +       pool->node = cpu_to_node(cpu);
> +
> +       /* alloc pool ID */
> +       mutex_lock(&wq_pool_mutex);
> +       BUG_ON(worker_pool_assign_id(pool));
> +       mutex_unlock(&wq_pool_mutex);
> +}
> +
>  /**
>   * workqueue_init_early - early init for workqueue subsystem
>   *
> @@ -7149,25 +7264,19 @@ void __init workqueue_init_early(void)
>         pt->pod_node[0] = NUMA_NO_NODE;
>         pt->cpu_pod[0] = 0;
>
> -       /* initialize CPU pools */
> +       /* initialize atomic and CPU pools */
>         for_each_possible_cpu(cpu) {
>                 struct worker_pool *pool;
>
>                 i = 0;
> -               for_each_cpu_worker_pool(pool, cpu) {
> -                       BUG_ON(init_worker_pool(pool));
> -                       pool->cpu = cpu;
> -                       cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
> -                       cpumask_copy(pool->attrs->__pod_cpumask, cpumask_of(cpu));
> -                       pool->attrs->nice = std_nice[i++];
> -                       pool->attrs->affn_strict = true;
> -                       pool->node = cpu_to_node(cpu);
> -
> -                       /* alloc pool ID */
> -                       mutex_lock(&wq_pool_mutex);
> -                       BUG_ON(worker_pool_assign_id(pool));
> -                       mutex_unlock(&wq_pool_mutex);
> +               for_each_atomic_worker_pool(pool, cpu) {
> +                       init_cpu_worker_pool(pool, cpu, std_nice[i++]);
> +                       pool->flags |= POOL_ATOMIC;
>                 }
> +
> +               i = 0;
> +               for_each_cpu_worker_pool(pool, cpu)
> +                       init_cpu_worker_pool(pool, cpu, std_nice[i++]);
>         }
>
>         /* create default unbound and ordered wq attrs */
> @@ -7200,10 +7309,14 @@ void __init workqueue_init_early(void)
>         system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_pwr_efficient",
>                                               WQ_FREEZABLE | WQ_POWER_EFFICIENT,
>                                               0);
> +       system_atomic_wq = alloc_workqueue("system_atomic_wq", WQ_ATOMIC, 0);
> +       system_atomic_highpri_wq = alloc_workqueue("system_atomic_highpri_wq",
> +                                                  WQ_ATOMIC | WQ_HIGHPRI, 0);
>         BUG_ON(!system_wq || !system_highpri_wq || !system_long_wq ||
>                !system_unbound_wq || !system_freezable_wq ||
>                !system_power_efficient_wq ||
> -              !system_freezable_power_efficient_wq);
> +              !system_freezable_power_efficient_wq ||
> +              !system_atomic_wq || !system_atomic_highpri_wq);
>  }
>
>  static void __init wq_cpu_intensive_thresh_init(void)
> @@ -7269,9 +7382,10 @@ void __init workqueue_init(void)
>          * up. Also, create a rescuer for workqueues that requested it.
>          */
>         for_each_possible_cpu(cpu) {
> -               for_each_cpu_worker_pool(pool, cpu) {
> +               for_each_atomic_worker_pool(pool, cpu)
> +                       pool->node = cpu_to_node(cpu);
> +               for_each_cpu_worker_pool(pool, cpu)
>                         pool->node = cpu_to_node(cpu);
> -               }
>         }
>
>         list_for_each_entry(wq, &workqueues, list) {
> @@ -7284,6 +7398,8 @@ void __init workqueue_init(void)
>
>         /* create the initial workers */
>         for_each_online_cpu(cpu) {
> +               for_each_atomic_worker_pool(pool, cpu)
> +                       BUG_ON(!create_worker(pool));
>                 for_each_cpu_worker_pool(pool, cpu) {
>                         pool->flags &= ~POOL_DISASSOCIATED;
>                         BUG_ON(!create_worker(pool));
> diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
> index f6275944ada7..f65f204f38ea 100644
> --- a/kernel/workqueue_internal.h
> +++ b/kernel/workqueue_internal.h
> @@ -10,6 +10,7 @@
>
>  #include <linux/workqueue.h>
>  #include <linux/kthread.h>
> +#include <linux/interrupt.h>
>  #include <linux/preempt.h>
>
>  struct worker_pool;
> @@ -42,6 +43,8 @@ struct worker {
>         struct list_head        scheduled;      /* L: scheduled works */
>
>         struct task_struct      *task;          /* I: worker task */
> +       struct tasklet_struct   atomic_tasklet; /* I: tasklet for atomic pool */
> +
>         struct worker_pool      *pool;          /* A: the associated pool */
>                                                 /* L: for rescuers */
>         struct list_head        node;           /* A: anchored at pool->workers */
> --
> 2.43.0
>
>


-- 
       - Allen

