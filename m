Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5AD8076BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379706AbjLFRhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379719AbjLFRhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:37:02 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48DDD40
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:37:07 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58d5979c676so4462754eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701884227; x=1702489027; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8r+v6tMeUDCVlJaWSk9+hoM+kWRX7cXcWkYHpDL0vQ=;
        b=m9awIHJbuXZdlC2WQz593Dy9S6gXrBkf4JMMeqkJPhbn5PtIlXvrS3m/va+zmYL7WT
         rMydSRMfn+37OfdRq1zw5VEocB68uy1kTWt5yX1lDWA/etC8xp4eqkGfo/fF7znB93hk
         npGfhzoTYWMJsukxgjCgnB5DPHkQYzNiLgoKLlYZPsdbb4/tVBntUq0VtBf20jwxzthY
         8fa3XjR5nZ/9d2m1igWXpmPeK/cU0m9Kb6J/86QlhUfTes07F3LnLsuo85orwiQQhvE/
         2P0XYzd6YiQo8//Lf+f+5gvi9+wT/Hc3Lt1kg4HmiHujpGQOUto5Pw17pUBp5qe4Y/nK
         yn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701884227; x=1702489027;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8r+v6tMeUDCVlJaWSk9+hoM+kWRX7cXcWkYHpDL0vQ=;
        b=jSjuQ3EbSjWomMOo6uqUeiXBL+hc4M4sBYWZN5Hj/8k6TqQMwku0ptxp9NmFf9eemW
         hmkpeSRQtn8xad/agGLQbnpruO9qHnlevZORbogvVjmz94WN3owbIG6Rc3cXRgiLvQBS
         x6FSSRKmaj5fCvWrlxaVTLK9r+MOafLTLEgNJ06NS6rXYF3a0o02/wbs+RfD3PKO7DbA
         ZFtdQ47oX8Xn5VW7DDn0cbaEJlY6b2XT4N6Zijx0xvTH2t8JlHQa9q2MnPavUauoQivP
         wG1Q/rAb+eS6THMcYmYX6q34Ng7DMssRJiA9GPKx03/osbRBr+8ERNeOo/EbOIRijO01
         /8ZA==
X-Gm-Message-State: AOJu0YyJDGSjuXBuKJzfepC3NI0YmYm4C08cQuHhjui+4WxWR7zIkZht
        0VCnGBBdp4KhjHznlmsAcpk=
X-Google-Smtp-Source: AGHT+IEcMG1ujmNbsAkgAGFMm3Dqk6uL+Gee6W1iN+ec3nLV0x0pzvSwek5MJNSKRawI6CUz4TMiBA==
X-Received: by 2002:a05:6358:e49f:b0:16f:eb57:af02 with SMTP id by31-20020a056358e49f00b0016feb57af02mr1610911rwb.16.1701884226626;
        Wed, 06 Dec 2023 09:37:06 -0800 (PST)
Received: from Mahakal ([2401:4900:1f29:c257:c420:b0b9:2714:1ae5])
        by smtp.gmail.com with ESMTPSA id s28-20020a63af5c000000b0059d34fb9ccasm175837pgo.2.2023.12.06.09.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 09:37:06 -0800 (PST)
Date:   Wed, 6 Dec 2023 23:07:00 +0530
From:   "<Vishal Badole>" <badolevishal1116@gmail.com>
To:     peterz@infradead.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mintu Patel <mintupatel89@gmail.com>,
        chinmoyghosh2001@gmail.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, vimal.kumar32@gmail.com,
        will@kernel.org
Subject: Re: [PATCH v2] rt_spin_lock: To list the correct owner of
 rt_spin_lock
Message-ID: <20231206173659.GA8874@Mahakal>
References: <20220619142038.1274-1-mintupatel89@gmail.com>
 <20220627161136.3468-1-mintupatel89@gmail.com>
 <20220708162158.03c82f47@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708162158.03c82f47@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_MISSP_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,TO_NO_BRKTS_FROM_MSSP,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 04:21:58PM -0400, Steven Rostedt wrote:
> On Mon, 27 Jun 2022 21:41:38 +0530
> Mintu Patel <mintupatel89@gmail.com> wrote:
> 
> Hi Mintu,
> 
> FYI, a v2 should never be a reply to the v1. It should always start its own
> thread, otherwise tooling and such will miss it.
> 
> >    rt_spin_lock is actually mutex on RT Kernel so it goes for contention
> >    for lock. Currently owners of rt_spin_lock are decided before actual
> >    acquiring of lock. This patch would depict the correct owner of
> >    rt_spin_lock. The patch would help in solving crashes and deadlock
> >    due to race condition of lock
> > 
> > acquiring rt_spin_lock        acquired the lock       released the lock
> >                     <-------->                <------->
> >                     contention period         Held period
> > 
> > Thread1                             Thread2
> > _try_to_take_rt_mutex+0x95c+0x74    enqueue_task_dl+0x8cc/0x8dc
> > rt_spin_lock_slowlock_locked+0xac+2 rt_mutex_setprio+0x28c/0x574
> > rt_spin_lock_slowlock+0x5c/0x90     task_blocks_rt_mutex+0x240/0x310
> > rt_spin_lock+0x58/0x5c              rt_spin_lock_slowlock_locked+0xac/0x2
> > driverA_acquire_lock+0x28/0x56      rt_spin_lock_slowlock+0x5c/0x90
> > 				    rt_spin_lock+0x58/0x5c
> >                                     driverB_acquire_lock+0x48/0x6c
> > 
> > As per above call traces sample, Thread1 acquired the rt_spin_lock and
> > went to critical section on the other hand Thread2 kept trying to acquire
> > the same rt_spin_lock held by Thread1 ie contention period is too high.
> > Finally Thread2 entered to dl queue due to high held time of the lock by
> > Thread1. The below patch would help us to know the correct owner of
> > rt_spin_lock and point us the driver's critical section. Respective
> > driver need to be debugged for longer held period of lock.
> > 
> >    ex: cat /sys/kernel/debug/tracing/trace
> > 
> >    kworker/u13:0-150   [003] .....11   202.761025: rt_spinlock_acquire:
> > Process: kworker/u13:0 is acquiring lock: &kbdev->hwaccess_lock
> >    kworker/u13:0-150   [003] .....11   202.761039: rt_spinlock_acquired:
> > Process: kworker/u13:0 has acquired lock: &kbdev->hwaccess_lock
> >    kworker/u13:0-150   [003] .....11   202.761042: rt_spinlock_released:
> > Process: kworker/u13:0 has released lock: &kbdev->hwaccess_lock
> > 
> > Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> > Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> > Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> > Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
> > ---
> >  include/trace/events/lock.h     | 38 +++++++++++++++++++++++++++++++++
> >  kernel/locking/rtmutex.c        |  4 ++++
> >  kernel/locking/rtmutex_common.h | 14 ++++++++++++
> >  3 files changed, 56 insertions(+)
> > 
> > diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
> > index d7512129a324..0564474341c8 100644
> > --- a/include/trace/events/lock.h
> > +++ b/include/trace/events/lock.h
> > @@ -36,6 +36,44 @@ TRACE_EVENT(lock_acquire,
> >  		  __get_str(name))
> >  );
> >  
> > +DECLARE_EVENT_CLASS(rt_lock_class,
> > +
> > +	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
> > +
> > +	TP_ARGS(lock, pname),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(name, lock->name)
> > +		__string(process_name, pname->comm)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(name, lock->name);
> > +		__assign_str(process_name, pname->comm);
> > +	),
> > +
> > +	TP_printk("Process: %s is acquiring lock: %s", __get_str(process_name),
> > +		__get_str(name))
> > +);
> > +
> > +DEFINE_EVENT(rt_lock_class, rt_spinlock_acquire,
> > +	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
> > +	TP_ARGS(lock, pname));
> > +
> > +DEFINE_EVENT_PRINT(rt_lock_class, rt_spinlock_acquired,
> > +	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
> > +	TP_ARGS(lock, pname),
> > +	TP_printk("Process: %s has acquired lock: %s", __get_str(process_name),
> > +		__get_str(name))
> > +	);
> > +
> > +DEFINE_EVENT_PRINT(rt_lock_class, rt_spinlock_released,
> > +	TP_PROTO(struct lockdep_map *lock, struct task_struct *pname),
> > +	TP_ARGS(lock, pname),
> > +	TP_printk("Process: %s has released lock: %s", __get_str(process_name),
> > +		__get_str(name))
> > +	);
> > +
> >  DECLARE_EVENT_CLASS(lock,
> >  
> >  	TP_PROTO(struct lockdep_map *lock, unsigned long ip),
> > diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> > index 602eb7821a1b..80ba2c0d7923 100644
> > --- a/kernel/locking/rtmutex.c
> > +++ b/kernel/locking/rtmutex.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/timer.h>
> >  #include <linux/ww_mutex.h>
> >  #include <linux/blkdev.h>
> > +#include <trace/events/lock.h>
> >  
> >  #include "rtmutex_common.h"
> >  
> > @@ -1144,7 +1145,9 @@ void __lockfunc rt_spin_lock(spinlock_t *lock)
> >  	rcu_read_lock();
> >  	migrate_disable();
> >  	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
> > +	do_trace_rt_spinlock_acquire(lock, current);
> >  	rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);
> > +	do_trace_rt_spinlock_acquired(lock, current);
> >  }
> >  EXPORT_SYMBOL(rt_spin_lock);
> >  
> > @@ -1169,6 +1172,7 @@ void __lockfunc rt_spin_unlock(spinlock_t *lock)
> >  {
> >  	/* NOTE: we always pass in '1' for nested, for simplicity */
> >  	spin_release(&lock->dep_map, 1, _RET_IP_);
> > +	do_trace_rt_spinlock_released(lock, current);
> >  	rt_spin_lock_fastunlock(&lock->lock, rt_spin_lock_slowunlock);
> >  	migrate_enable();
> >  	rcu_read_unlock();
> > diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
> > index 546aaf058b9e..185ffc1e7015 100644
> > --- a/kernel/locking/rtmutex_common.h
> > +++ b/kernel/locking/rtmutex_common.h
> > @@ -25,6 +25,20 @@
> >   * @pi_tree_entry:	pi node to enqueue into the mutex owner waiters tree
> >   * @task:		task reference to the blocked task
> >   */
> > +
> > +#ifdef CONFIG_RT_SPIN_LOCK_TRACING
> > +#define do_trace_rt_spinlock_acquire(lock, task) \
> > +	trace_rt_spinlock_acquire(&lock->dep_map, task)
> > +#define do_trace_rt_spinlock_acquired(lock, task) \
> > +	trace_rt_spinlock_acquired(&lock->dep_map, task)
> > +#define do_trace_rt_spinlock_released(lock, task) \
> > +	trace_rt_spinlock_released(&lock->dep_map, task)
> > +#else
> > +#define do_trace_rt_spinlock_acquire(lock, task) do {} while(0)
> > +#define do_trace_rt_spinlock_acquired(lock, task) do {} while(0)
> > +#define do_trace_rt_spinlock_released(lock, task) do {} while(0)
> > +#endif
> > +
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Although it will need to be accepted by Peter Zijlstra.
> 
> -- Steve
> 
> 
> >  struct rt_mutex_waiter {
> >  	struct rb_node          tree_entry;
> >  	struct rb_node          pi_tree_entry;
>
Hi Peter,
Could you please review this patch.

Regards,
Vishal Badole
