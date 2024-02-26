Return-Path: <linux-kernel+bounces-80390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF58667B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3888281894
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ADBEAC2;
	Mon, 26 Feb 2024 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLBT/MWI"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3832AD26A;
	Mon, 26 Feb 2024 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708912888; cv=none; b=R/KSslxdSZhR1UPcXYeI0LNqTlqFGMaP5/HZho4z5Atiw6IEIMC2LuFJRwCJPbccAwuuD3XO8jLWRJ+PgAjB4o/Lbk/hGnH+NBzRZ6yuwuHEJRtxMlTm44daEfIYBOU3dAGhZdqwBPkX66ltXmkMdyIwmoqfVq4iDwKWre/miJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708912888; c=relaxed/simple;
	bh=iVqmRkKdh+Tvr8bR28kLrWzoPSMBRaonI185ojO42Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7RFs42iGd9b7ss+kERf3WdAynE25VVzobUqLAuNccGEDnYEc8TUol+0cDfzWiPqyEn1pUDSxNC4gYWvMN6zm5mauqgm/bB0M9Iv8W5IENdIoxc6rbsqXMx0LHMHpTOIoUQSGE7NW/VYjPUtK1AjdtoOjGHyt4f5CGoAEY/9zSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLBT/MWI; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68ff93c5a15so9834506d6.1;
        Sun, 25 Feb 2024 18:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708912885; x=1709517685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhs12sRCem2cYqp63Q2x/u+BS3vh24Dd8PCAqKWiEco=;
        b=CLBT/MWIIg0PL8PnCvSBjNuohM0japwlVT5uF+KtL8q7eoR2MIfJG6dk5qJIL9Wx73
         /r7q8tPlFu63fgUHBT6HcNG8RkmxHDY0xR4Ro/y+zjL3tXJXxUUPY6xj6ahrihyuxT3O
         9ApY+wgJr6Rno45UDiZeolAPyMUMFbIayVhslG9RhB3s115BvPQI0eZHZQo1kRujzZLK
         zabK4QWAL/n4c3RMRw3lmIY3n5TwQyVEKCf/tmeiaOVVAZqPHxJtSoptSLMu7cxBZTZs
         4N5ClVgyR2lNhHvhpBmZUQ16e9+2QIUwybtRJu3pQ609X0ofxgANvj5tFEQkpMjAhU01
         +CQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708912885; x=1709517685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhs12sRCem2cYqp63Q2x/u+BS3vh24Dd8PCAqKWiEco=;
        b=kxq7SBiYn5mG9tu9RNu5J7pFva/02QvVxk8RMcI0hnv3eCbWoYDfcLoc/jF/KWV4RI
         Ww9Lu6RR6o6g6UjhEckhTizjI8ME7F7ba6Scic+qVkglCS6dIX0gelOOYDIHbeDJXLJc
         EjVFMniJljfZSkQIb1l/sxyD0pb3nSn1TwrKZ4iLG/7BDzY8f2YrDWlf1EG3pya0AxOv
         JhzxEMj2NiuYbz9LPaMv07C7/D6JHFDopL6b0VZ3ypVwSj7TdJ4SFHKwf8R0PkFtf5JU
         Hw/MaFGQYkwC4qq+IHqRl+eU/DbILzogD0Y6WvxvZtbVAE4DI5i6S9lEd6qIFwDK0EKZ
         GqTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEHe/w63+Nw86RzxLqybDLe1wTx3AcTNe7jdr2QqN2CPNMZUQIAuyG/6mzKNTYixrY8do7XFDGni2MaZ5eSw7lQkti11mJr0KJYm3E4wN3OlI2x+hcMQFPoTAhIW9ja7w54SwA
X-Gm-Message-State: AOJu0YxnWVL5XZcVl4SQCxDJxYOQqa5cNtXQfmMF1dZq7gqUo4YI6E1R
	fJcHL2DvXGiUho6pzaDKHK7QMqZcTJsSQFxhYGGtkXQSnlTi3MSk
X-Google-Smtp-Source: AGHT+IGpXvX+Sm/8qPjE7Cr+uYa96QyYXD6PCaayGX9DzQKjZRv4bmhxRKn424Ye0aeER0kT46Kx+w==
X-Received: by 2002:a0c:ab1b:0:b0:68f:e972:f2c5 with SMTP id h27-20020a0cab1b000000b0068fe972f2c5mr5165169qvb.5.1708912885011;
        Sun, 25 Feb 2024 18:01:25 -0800 (PST)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id pc16-20020a056214489000b006900040146asm1030577qvb.132.2024.02.25.18.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 18:01:24 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id B76C71200068;
	Sun, 25 Feb 2024 21:01:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 25 Feb 2024 21:01:23 -0500
X-ME-Sender: <xms:8_DbZbW8Hmpz56PQOPiJ-f3VYGOCrZN_ymvJbujWcnxfCL7dMXXCyw>
    <xme:8_DbZTkTcwGhB4yLCDbpSEuyljO0xTeuB8OGuFWRP1wZMdWklw3q4o9Yw8EHe-x9N
    5RF3uBoITSOzaXXKQ>
X-ME-Received: <xmr:8_DbZXa9MB-jWS-1I8eWRpfN7Eg2pwqEIqNSnbEdqigfk_5Z_YcKxD7ZmHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetje
    eihedvteehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:8_DbZWUbpFOgcUMA1EA8Uf91cVmX8D0cq8FImpZTdTb5Og8atEE19w>
    <xmx:8_DbZVks3CDxNcsubZ4HoEPh1Uw5kN3QH-gfRyt3cmBF5AFANF7Eng>
    <xmx:8_DbZTd0iV4y_GSL5OEbsH1Bv-gGhkwrFC4LzGSK2AqG3KRMux-rXw>
    <xmx:8_DbZX2L29JsyssgdoQa6BbkaorrEc8wPfKlNSuAcjMIKgjO97MUr3AJGVw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Feb 2024 21:01:22 -0500 (EST)
Date: Sun, 25 Feb 2024 18:00:48 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 3/8] workqueue: Implement BH workqueues to eventually
 replace tasklets
Message-ID: <Zdvw0HdSXcU3JZ4g@boqun-archlinux>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-4-tj@kernel.org>
 <ZcABypwUML6Osiec@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcABypwUML6Osiec@slm.duckdns.org>

On Sun, Feb 04, 2024 at 11:29:46AM -1000, Tejun Heo wrote:
> >From 4cb1ef64609f9b0254184b2947824f4b46ccab22 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Sun, 4 Feb 2024 11:28:06 -1000
> 
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws such as
> the execution code accessing the tasklet item after the execution is
> complete which can lead to subtle use-after-free in certain usage scenarios
> and less-developed flush and cancel mechanisms.
> 
> This patch implements BH workqueues which share the same semantics and
> features of regular workqueues but execute their work items in the softirq
> context. As there is always only one BH execution context per CPU, none of
> the concurrency management mechanisms applies and a BH workqueue can be
> thought of as a convenience wrapper around softirq.
> 
> Except for the inability to sleep while executing and lack of max_active
> adjustments, BH workqueues and work items should behave the same as regular
> workqueues and work items.
> 
> Currently, the execution is hooked to tasklet[_hi]. However, the goal is to
> convert all tasklet users over to BH workqueues. Once the conversion is
> complete, tasklet can be removed and BH workqueues can directly take over
> the tasklet softirqs.
> 
> system_bh[_highpri]_wq are added. As queue-wide flushing doesn't exist in
> tasklet, all existing tasklet users should be able to use the system BH
> workqueues without creating their own workqueues.
> 
> v3: - Add missing interrupt.h include.
> 
> v2: - Instead of using tasklets, hook directly into its softirq action
>       functions - tasklet[_hi]_action(). This is slightly cheaper and closer
>       to the eventual code structure we want to arrive at. Suggested by Lai.
> 
>     - Lai also pointed out several places which need NULL worker->task
>       handling or can use clarification. Updated.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: http://lkml.kernel.org/r/CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com
> Tested-by: Allen Pais <allen.lkml@gmail.com>
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
> ---
>  Documentation/core-api/workqueue.rst |  29 ++-
>  include/linux/workqueue.h            |  11 +
>  kernel/softirq.c                     |   3 +
>  kernel/workqueue.c                   | 291 ++++++++++++++++++++++-----
>  tools/workqueue/wq_dump.py           |  11 +-
>  5 files changed, 285 insertions(+), 60 deletions(-)
> 
> diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
> index 33c4539155d9..2d6af6c4665c 100644
> --- a/Documentation/core-api/workqueue.rst
> +++ b/Documentation/core-api/workqueue.rst
> @@ -77,10 +77,12 @@ wants a function to be executed asynchronously it has to set up a work
>  item pointing to that function and queue that work item on a
>  workqueue.
>  
> -Special purpose threads, called worker threads, execute the functions
> -off of the queue, one after the other.  If no work is queued, the
> -worker threads become idle.  These worker threads are managed in so
> -called worker-pools.
> +A work item can be executed in either a thread or the BH (softirq) context.
> +
> +For threaded workqueues, special purpose threads, called [k]workers, execute
> +the functions off of the queue, one after the other. If no work is queued,
> +the worker threads become idle. These worker threads are managed in
> +worker-pools.
>  
>  The cmwq design differentiates between the user-facing workqueues that
>  subsystems and drivers queue work items on and the backend mechanism
> @@ -91,6 +93,12 @@ for high priority ones, for each possible CPU and some extra
>  worker-pools to serve work items queued on unbound workqueues - the
>  number of these backing pools is dynamic.
>  
> +BH workqueues use the same framework. However, as there can only be one
> +concurrent execution context, there's no need to worry about concurrency.
> +Each per-CPU BH worker pool contains only one pseudo worker which represents
> +the BH execution context. A BH workqueue can be considered a convenience
> +interface to softirq.
> +
>  Subsystems and drivers can create and queue work items through special
>  workqueue API functions as they see fit. They can influence some
>  aspects of the way the work items are executed by setting flags on the
> @@ -106,7 +114,7 @@ unless specifically overridden, a work item of a bound workqueue will
>  be queued on the worklist of either normal or highpri worker-pool that
>  is associated to the CPU the issuer is running on.
>  
> -For any worker pool implementation, managing the concurrency level
> +For any thread pool implementation, managing the concurrency level
>  (how many execution contexts are active) is an important issue.  cmwq
>  tries to keep the concurrency at a minimal but sufficient level.
>  Minimal to save resources and sufficient in that the system is used at
> @@ -164,6 +172,17 @@ resources, scheduled and executed.
>  ``flags``
>  ---------
>  
> +``WQ_BH``
> +  BH workqueues can be considered a convenience interface to softirq. BH
> +  workqueues are always per-CPU and all BH work items are executed in the
> +  queueing CPU's softirq context in the queueing order.
> +
> +  All BH workqueues must have 0 ``max_active`` and ``WQ_HIGHPRI`` is the
> +  only allowed additional flag.
> +
> +  BH work items cannot sleep. All other features such as delayed queueing,
> +  flushing and canceling are supported.
> +
>  ``WQ_UNBOUND``
>    Work items queued to an unbound wq are served by the special
>    worker-pools which host workers which are not bound to any
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index 232baea90a1d..283d7891b4c4 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -353,6 +353,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
>   * Documentation/core-api/workqueue.rst.
>   */
>  enum wq_flags {
> +	WQ_BH			= 1 << 0, /* execute in bottom half (softirq) context */
>  	WQ_UNBOUND		= 1 << 1, /* not bound to any cpu */
>  	WQ_FREEZABLE		= 1 << 2, /* freeze during suspend */
>  	WQ_MEM_RECLAIM		= 1 << 3, /* may be used for memory reclaim */
> @@ -392,6 +393,9 @@ enum wq_flags {
>  	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
>  	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
>  	__WQ_ORDERED_EXPLICIT	= 1 << 19, /* internal: alloc_ordered_workqueue() */
> +
> +	/* BH wq only allows the following flags */
> +	__WQ_BH_ALLOWS		= WQ_BH | WQ_HIGHPRI,
>  };
>  
>  enum wq_consts {
> @@ -434,6 +438,9 @@ enum wq_consts {
>   * they are same as their non-power-efficient counterparts - e.g.
>   * system_power_efficient_wq is identical to system_wq if
>   * 'wq_power_efficient' is disabled.  See WQ_POWER_EFFICIENT for more info.
> + *
> + * system_bh[_highpri]_wq are convenience interface to softirq. BH work items
> + * are executed in the queueing CPU's BH context in the queueing order.
>   */
>  extern struct workqueue_struct *system_wq;
>  extern struct workqueue_struct *system_highpri_wq;
> @@ -442,6 +449,10 @@ extern struct workqueue_struct *system_unbound_wq;
>  extern struct workqueue_struct *system_freezable_wq;
>  extern struct workqueue_struct *system_power_efficient_wq;
>  extern struct workqueue_struct *system_freezable_power_efficient_wq;
> +extern struct workqueue_struct *system_bh_wq;
> +extern struct workqueue_struct *system_bh_highpri_wq;
> +
> +void workqueue_softirq_action(bool highpri);
>  
>  /**
>   * alloc_workqueue - allocate a workqueue
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 210cf5f8d92c..547d282548a8 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -27,6 +27,7 @@
>  #include <linux/tick.h>
>  #include <linux/irq.h>
>  #include <linux/wait_bit.h>
> +#include <linux/workqueue.h>
>  
>  #include <asm/softirq_stack.h>
>  
> @@ -802,11 +803,13 @@ static void tasklet_action_common(struct softirq_action *a,
>  
>  static __latent_entropy void tasklet_action(struct softirq_action *a)
>  {
> +	workqueue_softirq_action(false);
>  	tasklet_action_common(a, this_cpu_ptr(&tasklet_vec), TASKLET_SOFTIRQ);
>  }
>  
>  static __latent_entropy void tasklet_hi_action(struct softirq_action *a)
>  {
> +	workqueue_softirq_action(true);
>  	tasklet_action_common(a, this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
>  }
>  
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 767971a29c7a..78b4b992e1a3 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -29,6 +29,7 @@
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
>  #include <linux/signal.h>
>  #include <linux/completion.h>
>  #include <linux/workqueue.h>
> @@ -72,8 +73,12 @@ enum worker_pool_flags {
>  	 * Note that DISASSOCIATED should be flipped only while holding
>  	 * wq_pool_attach_mutex to avoid changing binding state while
>  	 * worker_attach_to_pool() is in progress.
> +	 *
> +	 * As there can only be one concurrent BH execution context per CPU, a
> +	 * BH pool is per-CPU and always DISASSOCIATED.
>  	 */
> -	POOL_MANAGER_ACTIVE	= 1 << 0,	/* being managed */
> +	POOL_BH			= 1 << 0,	/* is a BH pool */
> +	POOL_MANAGER_ACTIVE	= 1 << 1,	/* being managed */
>  	POOL_DISASSOCIATED	= 1 << 2,	/* cpu can't serve workers */
>  };
>  
> @@ -115,6 +120,14 @@ enum wq_internal_consts {
>  	WQ_NAME_LEN		= 32,
>  };
>  
> +/*
> + * We don't want to trap softirq for too long. See MAX_SOFTIRQ_TIME and
> + * MAX_SOFTIRQ_RESTART in kernel/softirq.c. These are macros because
> + * msecs_to_jiffies() can't be an initializer.
> + */
> +#define BH_WORKER_JIFFIES	msecs_to_jiffies(2)
> +#define BH_WORKER_RESTARTS	10

Sorry, late to the party, but I wonder how this play along with cpu
hotplug? Say we've queued a lot BH_WORK on a CPU, and we offline that
cpu, wouldn't that end up with a few BH_WORK left on that CPU not being
executed?

[Cc Thomas]

Regards,
Boqun

> +
[..]

