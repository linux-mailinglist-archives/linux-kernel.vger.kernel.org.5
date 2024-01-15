Return-Path: <linux-kernel+bounces-26409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C1D82E034
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73571F22A79
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CCC18E17;
	Mon, 15 Jan 2024 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="un6jVyla"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFE18E08
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db3a09e96daso7066148276.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705344255; x=1705949055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4m4gB/6U6iSk2UBQBIzj25m3xBLtEoo62CJDhDqEPKY=;
        b=un6jVylalABgDX8fXUiwep1uaiRkeX7c7TdbELWVXCy+f2ZXpGALluovMYUEEhU15o
         Z+UVScl5I+hQZ0v83uLr4VAYF46GQ532zMKtbl6yHDzgMy9Ux1GkAGhyQZ0bLELQCPfR
         ZDmfyvlO2nKuumUAhnCi1uzFme+9SOJKK/gwm47Tvo/pd0VSiJrwOJPYk7mw3HbhmFLT
         AZ7Luxx7qzA5rggUGq1leZ47C8qP728LxyXDr2HDEs0abvfvOtUO5VvM3i/fIqWVbyMZ
         anRuVWctHnG8uEz2ahQq7jbS5SpPfn7qgYcEJONHULaNUGdeCGpLkub2/rS6fPCeamvi
         DxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705344255; x=1705949055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4m4gB/6U6iSk2UBQBIzj25m3xBLtEoo62CJDhDqEPKY=;
        b=NYK4FFQtSoC0IGSeYP01LHcQo+EiiQA4DcMocQ9xUiHWKJcT0CamS8J12uOp8JnvTR
         4wtXUPodGU04k5BlS8gh81wrNe8hJwl+NC1y2070mo7Fh4nE9TzW2CdAeY7GPNq3pEzk
         ML2IoaeBykFE8c4L2fFggbh8BLoew8FXS7O1p1OoAsWvV1FBK5If6To4ePcLrMAONIQm
         4xZVsvXBfWZ62C20C09J/I+vEnpyFh4EgwMr0DrVoF5F8SNNH6VN9/SRKJaHs3cPfD8q
         vX16/eajHBDYz6bKD4X7XDy6OCJOXb/EXN268z3pxozJfC+e8HKJlnB+4WbM4XPDlx1h
         Kkcg==
X-Gm-Message-State: AOJu0YyAP4NNSXFm5bOt2wWXcNYQVx+3UuSxxXXJWs1tjVFsPW0q13dd
	dQcLMNh6M6ELMz5Jh2Tc5xO8Iv/rnIYFHT5qsBRuf7cBlMf9
X-Google-Smtp-Source: AGHT+IEFNmCBXmar5PfoP//g/48aUSuK1GrUG9FFQRC4FgyNEr6OwVriT4rMrcV0vTrBcRR759IQIOTbsV8EWEr4ZfQ=
X-Received: by 2002:a05:6902:1891:b0:dbd:b319:f90e with SMTP id
 cj17-20020a056902189100b00dbdb319f90emr3838991ybb.58.1705344254861; Mon, 15
 Jan 2024 10:44:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ1+ZicgN8dZ3zj3@casper.infradead.org>
In-Reply-To: <ZZ1+ZicgN8dZ3zj3@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 15 Jan 2024 10:44:02 -0800
Message-ID: <CAJuCfpHpGyiXePsQNWuGwfYAC64jtrJmp5kZBeQwYwD1p+SkAg@mail.gmail.com>
Subject: Re: [RFC] Sleep waiting for an rwsem to be unlocked
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
	"Liam R. Howlett" <liam.howlett@oracle.com>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 9:12=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> The problem we're trying to solve is a lock-free walk of
> /proc/$pid/maps. If the process is modifying the VMAs at the same time
> the reader is walking them, it can see garbage.  For page faults, we
> handle this by taking the mmap_lock for read and retrying the page fault
> (excluding any further modifications).
>
> We don't want to take that approach for the maps file.  The monitoring
> task may have a significantly lower process priority, and so taking
> the mmap_lock for read can block it for a significant period of time.
> The obvious answer is to do some kind of backoff+sleep.  But we already
> have a wait queue, so why not use it?
>
> I haven't done the rwbase version; this is just a demonstration of what
> we could do.  It's also untested other than by compilation.  It might
> well be missing something.

I just posted an RFC for lock-less /proc/$pid/maps reading at [1]. The
rwsem_wait() function proposed by Matthew here would be useful in that
patchset to replace mmap_read_lock/mmap_read_unlock sequence I have to
use to wait for mmap_lock writer to finish.

[1] https://lore.kernel.org/all/20240115183837.205694-1-surenb@google.com/
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/rwsem.h  |   6 +++
>  kernel/locking/rwsem.c | 104 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 108 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index 4f1c18992f76..e7bf9dfc471a 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -250,6 +250,12 @@ DEFINE_GUARD_COND(rwsem_write, _try, down_write_tryl=
ock(_T))
>   */
>  extern void downgrade_write(struct rw_semaphore *sem);
>
> +/*
> + * wait for current writer to be finished
> + */
> +void rwsem_wait(struct rw_semaphore *sem);
> +int __must_check rwsem_wait_killable(struct rw_semaphore *sem);
> +
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  /*
>   * nested locking. NOTE: rwsems are not allowed to recurse
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 2340b6d90ec6..7c8096c5586f 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -332,7 +332,8 @@ EXPORT_SYMBOL(__init_rwsem);
>
>  enum rwsem_waiter_type {
>         RWSEM_WAITING_FOR_WRITE,
> -       RWSEM_WAITING_FOR_READ
> +       RWSEM_WAITING_FOR_READ,
> +       RWSEM_WAITING_FOR_RELEASE,
>  };
>
>  struct rwsem_waiter {
> @@ -511,7 +512,8 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>                 if (waiter->type =3D=3D RWSEM_WAITING_FOR_WRITE)
>                         continue;
>
> -               woken++;
> +               if (waiter->type =3D=3D RWSEM_WAITING_FOR_READ)
> +                       woken++;
>                 list_move_tail(&waiter->list, &wlist);
>
>                 /*
> @@ -1401,6 +1403,67 @@ static inline void __downgrade_write(struct rw_sem=
aphore *sem)
>         preempt_enable();
>  }
>
> +static inline int __wait_read_common(struct rw_semaphore *sem, int state=
)
> +{
> +       int ret =3D 0;
> +       long adjustment =3D 0;
> +       struct rwsem_waiter waiter;
> +       DEFINE_WAKE_Q(wake_q);
> +
> +       waiter.task =3D current;
> +       waiter.type =3D RWSEM_WAITING_FOR_RELEASE;
> +       waiter.timeout =3D jiffies + RWSEM_WAIT_TIMEOUT;
> +       waiter.handoff_set =3D false;
> +
> +       preempt_disable();
> +       raw_spin_lock_irq(&sem->wait_lock);
> +       if (list_empty(&sem->wait_list)) {
> +               if (!(atomic_long_read(&sem->count) & RWSEM_WRITER_MASK))=
 {
> +                       /* Provide lock ACQUIRE */
> +                       smp_acquire__after_ctrl_dep();
> +                       raw_spin_unlock_irq(&sem->wait_lock);
> +                       goto done;
> +               }
> +               adjustment =3D RWSEM_FLAG_WAITERS;
> +       }
> +       rwsem_add_waiter(sem, &waiter);
> +       if (adjustment) {
> +               long count =3D atomic_long_add_return(adjustment, &sem->c=
ount);
> +               rwsem_cond_wake_waiter(sem, count, &wake_q);
> +       }
> +       raw_spin_unlock_irq(&sem->wait_lock);
> +
> +       if (!wake_q_empty(&wake_q))
> +               wake_up_q(&wake_q);
> +
> +       for (;;) {
> +               set_current_state(state);
> +               if (!smp_load_acquire(&waiter.task)) {
> +                       /* Matches rwsem_mark_wake()'s smp_store_release(=
). */
> +                       break;
> +               }
> +               if (signal_pending_state(state, current)) {
> +                       raw_spin_lock_irq(&sem->wait_lock);
> +                       if (waiter.task)
> +                               goto out_nolock;
> +                       raw_spin_unlock_irq(&sem->wait_lock);
> +                       /* Ordered by sem->wait_lock against rwsem_mark_w=
ake(). */
> +                       break;
> +               }
> +               schedule_preempt_disabled();
> +       }
> +
> +       __set_current_state(TASK_RUNNING);
> +done:
> +       preempt_enable();
> +       return ret;
> +out_nolock:
> +       rwsem_del_wake_waiter(sem, &waiter, &wake_q);
> +       __set_current_state(TASK_RUNNING);
> +       ret =3D -EINTR;
> +       goto done;
> +}
> +
>  #else /* !CONFIG_PREEMPT_RT */
>
>  #define RT_MUTEX_BUILD_MUTEX
> @@ -1500,6 +1563,11 @@ static inline void __downgrade_write(struct rw_sem=
aphore *sem)
>         rwbase_write_downgrade(&sem->rwbase);
>  }
>
> +static inline int __wait_read_killable(struct rw_semaphore *sem)
> +{
> +       return rwbase_wait_lock(&sem->rwbase, TASK_KILLABLE);
> +}
> +
>  /* Debug stubs for the common API */
>  #define DEBUG_RWSEMS_WARN_ON(c, sem)
>
> @@ -1643,6 +1711,38 @@ void downgrade_write(struct rw_semaphore *sem)
>  }
>  EXPORT_SYMBOL(downgrade_write);
>
> +/**
> + * rwsem_wait_killable - Wait for current write lock holder to release l=
ock
> + * @sem: The semaphore to wait on.
> + *
> + * This is equivalent to calling down_read(); up_read() but avoids the
> + * possibility that the thread will be preempted while holding the lock
> + * causing threads that want to take the lock for writes to block.  The
> + * intended use case is for lockless readers who notice an inconsistent
> + * state and want to wait for the current writer to finish.
> + */
> +int rwsem_wait_killable(struct rw_semaphore *sem)
> +{
> +       might_sleep();
> +
> +       rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> +       rwsem_release(&sem->dep_map, _RET_IP_);
> +
> +       return __wait_read_common(sem, TASK_KILLABLE);
> +}
> +EXPORT_SYMBOL(rwsem_wait_killable);
> +
> +void rwsem_wait(struct rw_semaphore *sem)
> +{
> +       might_sleep();
> +
> +       rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
> +       rwsem_release(&sem->dep_map, _RET_IP_);
> +
> +       __wait_read_common(sem, TASK_UNINTERRUPTIBLE);
> +}
> +EXPORT_SYMBOL(rwsem_wait);
> +
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>
>  void down_read_nested(struct rw_semaphore *sem, int subclass)
> --
> 2.43.0
>

