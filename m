Return-Path: <linux-kernel+bounces-21296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF38828D30
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936CD1F261C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D054E3D0C4;
	Tue,  9 Jan 2024 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIxF1vkJ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA53C07B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso15865ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704827792; x=1705432592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0MxYJLMx/j7nVI7tIcGuZe4UR14g+wqXYYC2XBeyLM=;
        b=QIxF1vkJoX8IazePtMx3/Z73eGAv7WkVtaRr2dbmziy9vw9eLm9CU153FfDck3PVQu
         mrhFVFfH4XVsvBsMXOlim0GC94IfSe5EejMFsbcklAcBf2K2klS4pOskq4hEWAl+v/fX
         NnqKJ5BzRmy9QLvJWqq9imqPzNXjzxC4VXx4DNXhS3YmaIqWI7BgPN3EjR+Bfc0QjKQF
         92DhAsW098fKpf2/NythfCAtp/0YD73G/WALhU+nlnYOj6B1QJdJB9YGSMsJz/GmyPrr
         K/zojx1i7Mn/KexV2fgV29NvRrlBbWjbogmT0Q7uSWuBtI0Xrm1THZH2CBAJHbAKMSmB
         ryeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704827792; x=1705432592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0MxYJLMx/j7nVI7tIcGuZe4UR14g+wqXYYC2XBeyLM=;
        b=BDjIVewl6hW/JoHlSsw/cwDGuZH6MwN/drYfM2W/BA5hoTtWJ0P0v+eMoEOs04SpKP
         IiG1GEj6wCI1IaJKpIeK6yRNavlN+65EFwZFbfsvJ4hsdFhxJNgvCeC+EY5Gmsjxy1gx
         niFPuXXREeD7LHfSSiBCi6WGdg2F24K+Lqto1kg534tkzRyUApihDq8+wHrMV9ZN9cSE
         EEIj9Ay2uBuBqGFeHsIvTZiMSzeKCUxLZbI8GTZsNO3Yi1D/2NMZOJp9gC/DmrQP7HIA
         cnQa6dKAx/LOCpJwftagRZS5SqRIjBGprKwKDW6EYlhLSigbNbYQ9azaFpl94rjihfJl
         pmgw==
X-Gm-Message-State: AOJu0YxkSqF9sIMUIC1MvAO4sE7YIw4eEhxXtV5hAuubzhwZf62bQt+v
	q/r/2tV50/UX4MhPkeE8HTuRULM+M2Mj
X-Google-Smtp-Source: AGHT+IHqpoM26wwZfHpAJyBJXjiY8iSUqpdu5z7uvV6yDFdd//fgvSmCGS5WfjEzW4RSi1x4WuEGzQ==
X-Received: by 2002:a17:902:6e08:b0:1cc:6fa6:fb4a with SMTP id u8-20020a1709026e0800b001cc6fa6fb4amr62623plk.22.1704827792111;
        Tue, 09 Jan 2024 11:16:32 -0800 (PST)
Received: from google.com ([2620:15c:211:201:c35c:511:8258:7aa2])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902969100b001d4974385d4sm2134731plp.250.2024.01.09.11.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 11:16:31 -0800 (PST)
Date: Tue, 9 Jan 2024 11:16:27 -0800
From: Kalesh Singh <kaleshsingh@google.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 1/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <ZZ2bi5iPwXLgjB-f@google.com>
References: <20240104162510.72773-1-urezki@gmail.com>
 <20240104162510.72773-2-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104162510.72773-2-urezki@gmail.com>

On Thu, Jan 04, 2024 at 05:25:07PM +0100, Uladzislau Rezki (Sony) wrote:
> A call to a synchronize_rcu() can be optimized from a latency
> point of view. Workloads which depend on this can benefit of it.
> 
> The delay of wakeme_after_rcu() callback, which unblocks a waiter,
> depends on several factors:
> 
> - how fast a process of offloading is started. Combination of:
>     - !CONFIG_RCU_NOCB_CPU/CONFIG_RCU_NOCB_CPU;
>     - !CONFIG_RCU_LAZY/CONFIG_RCU_LAZY;
>     - other.
> - when started, invoking path is interrupted due to:
>     - time limit;
>     - need_resched();
>     - if limit is reached.
> - where in a nocb list it is located;
> - how fast previous callbacks completed;
> 
> Example:
> 
> 1. On our embedded devices i can easily trigger the scenario when
> it is a last in the list out of ~3600 callbacks:
> 
> <snip>
>   <...>-29      [001] d..1. 21950.145313: rcu_batch_start: rcu_preempt CBs=3613 bl=28
> ...
>   <...>-29      [001] ..... 21950.152578: rcu_invoke_callback: rcu_preempt rhp=00000000b2d6dee8 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152579: rcu_invoke_callback: rcu_preempt rhp=00000000a446f607 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152580: rcu_invoke_callback: rcu_preempt rhp=00000000a5cab03b func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152581: rcu_invoke_callback: rcu_preempt rhp=0000000013b7e5ee func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152582: rcu_invoke_callback: rcu_preempt rhp=000000000a8ca6f9 func=__free_vm_area_struct.cfi_jt
>   <...>-29      [001] ..... 21950.152583: rcu_invoke_callback: rcu_preempt rhp=000000008f162ca8 func=wakeme_after_rcu.cfi_jt
>   <...>-29      [001] d..1. 21950.152625: rcu_batch_end: rcu_preempt CBs-invoked=3612 idle=....
> <snip>
> 
> 2. We use cpuset/cgroup to classify tasks and assign them into
> different cgroups. For example "backgrond" group which binds tasks
> only to little CPUs or "foreground" which makes use of all CPUs.
> Tasks can be migrated between groups by a request if an acceleration
> is needed.
> 
> See below an example how "surfaceflinger" task gets migrated.
> Initially it is located in the "system-background" cgroup which
> allows to run only on little cores. In order to speed it up it
> can be temporary moved into "foreground" cgroup which allows
> to use big/all CPUs:
> 
> cgroup_attach_task():
>  -> cgroup_migrate_execute()
>    -> cpuset_can_attach()
>      -> percpu_down_write()
>        -> rcu_sync_enter()
>          -> synchronize_rcu()
>    -> now move tasks to the new cgroup.
>  -> cgroup_migrate_finish()
> 
> <snip>
>          rcuop/1-29      [000] .....  7030.528570: rcu_invoke_callback: rcu_preempt rhp=00000000461605e0 func=wakeme_after_rcu.cfi_jt
>     PERFD-SERVER-1855    [000] d..1.  7030.530293: cgroup_attach_task: dst_root=3 dst_id=22 dst_level=1 dst_path=/foreground pid=1900 comm=surfaceflinger
>    TimerDispatch-2768    [002] d..5.  7030.537542: sched_migrate_task: comm=surfaceflinger pid=1900 prio=98 orig_cpu=0 dest_cpu=4
> <snip>
> 
> "Boosting a task" depends on synchronize_rcu() latency:
> 
> - first trace shows a completion of synchronize_rcu();
> - second shows attaching a task to a new group;
> - last shows a final step when migration occurs.
> 
> 3. To address this drawback, maintain a separate track that consists
> of synchronize_rcu() callers only. After completion of a grace period
> users are deferred to a dedicated worker to process requests.
> 
> 4. This patch reduces the latency of synchronize_rcu() approximately
> by ~30-40% on synthetic tests. The real test case, camera launch time,
> shows(time is in milliseconds):
> 
> 1-run 542 vs 489 improvement 9%
> 2-run 540 vs 466 improvement 13%
> 3-run 518 vs 468 improvement 9%
> 4-run 531 vs 457 improvement 13%
> 5-run 548 vs 475 improvement 13%
> 6-run 509 vs 484 improvement 4%
> 
> Synthetic test(no "noise" from other callbacks):
> Hardware: x86_64 64 CPUs, 64GB of memory
> Linux-6.6
> 
> - 10K tasks(simultaneous);
> - each task does(1000 loops)
>      synchronize_rcu();
>      kfree(p);
> 
> default: CONFIG_RCU_NOCB_CPU: takes 54 seconds to complete all users;
> patch: CONFIG_RCU_NOCB_CPU: takes 35 seconds to complete all users.
> 
> Running 60K gives approximately same results on my setup. Please note
> it is without any interaction with another type of callbacks, otherwise
> it will impact a lot a default case.
> 
> 5. An extra CONFIG_RCU_SR_NORMAL_DEBUG_GP kernel option is added
> which enables additional debugging for detecting a grace period
> incompletion for synchronize_rcu() users. If a GP is not fully
> passed for any user, the warning message is emitted.
> 
> 6. By default it is disabled. To enable this perform one of the
> below sequence:
> 
> echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Hi Uladzislau,

I've tried your patches (v3) on Android with 6.1.43 kernel.

The test cycles 10 apps (including camera) sequentially for 100
iterations.

I've set rcu_normal to override the rcu_expedited in the boot
parameters:

adb shell cat /proc/cmdline | tr ' ' '\n' | grep rcu

rcupdate.rcu_normal=1
rcupdate.rcu_expedited=1
rcu_nocbs=0-7


The configurations are:

A - echo 0 >/sys/module/rcutree/parameters/rcu_normal_wake_from_gp
B - echo 1 >/sys/module/rcutree/parameters/rcu_normal_wake_from_gp

Results:

= APP LAUNCH TIME =
                                delta (B-A)    ratio(%)
   overall_app_launch_time(ms)    -11399.00       -6.65


== camera_launch_time
      type  delta(B-A %)  A_count  B_count
       HOT         -7.05       99       99
      COLD         -6.33        1        1


=== Function Latencies ===

Tracing synchronize_rcu_expedited.  Hit Ctrl-C to exit                              Tracing synchronize_rcu_expedited.  Hit Ctrl-C to exit

     nsec                : count    distribution                                         nsec                : count    distribution
         0 -> 1          : 0        |                                        |               0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |               2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |               4 -> 7          : 0        |                                        |
         8 -> 15         : 0        |                                        |               8 -> 15         : 0        |                                        |
        16 -> 31         : 0        |                                        |              16 -> 31         : 0        |                                        |
        32 -> 63         : 0        |                                        |              32 -> 63         : 0        |                                        |
        64 -> 127        : 0        |                                        |              64 -> 127        : 0        |                                        |
       128 -> 255        : 0        |                                        |             128 -> 255        : 0        |                                        |
       256 -> 511        : 0        |                                        |             256 -> 511        : 0        |                                        |
       512 -> 1023       : 0        |                                        |             512 -> 1023       : 0        |                                        |
      1024 -> 2047       : 0        |                                        |            1024 -> 2047       : 0        |                                        |
      2048 -> 4095       : 0        |                                        |            2048 -> 4095       : 0        |                                        |
      4096 -> 8191       : 0        |                                        |            4096 -> 8191       : 0        |                                        |
      8192 -> 16383      : 0        |                                        |            8192 -> 16383      : 0        |                                        |
     16384 -> 32767      : 0        |                                        |           16384 -> 32767      : 0        |                                        |
     32768 -> 65535      : 0        |                                        |           32768 -> 65535      : 0        |                                        |
     65536 -> 131071     : 0        |                                        |           65536 -> 131071     : 0        |                                        |
    131072 -> 262143     : 0        |                                        |          131072 -> 262143     : 0        |                                        |
    262144 -> 524287     : 0        |                                        |          262144 -> 524287     : 0        |                                        |
    524288 -> 1048575    : 0        |                                        |          524288 -> 1048575    : 0        |                                        |
   1048576 -> 2097151    : 0        |                                        |         1048576 -> 2097151    : 0        |                                        |
   2097152 -> 4194303    : 0        |                                        |         2097152 -> 4194303    : 0        |                                        |
   4194304 -> 8388607    : 871      |**                                      |         4194304 -> 8388607    : 1180     |****                                    |
   8388608 -> 16777215   : 3204     |********                                |         8388608 -> 16777215   : 7020     |*************************               |
  16777216 -> 33554431   : 15013    |****************************************|        16777216 -> 33554431   : 10952    |****************************************|
Exiting trace of synchronize_rcu_expedited                                          Exiting trace of synchronize_rcu_expedited


Tracing synchronize_rcu.  Hit Ctrl-C to exit                                        Tracing synchronize_rcu.  Hit Ctrl-C to exit

     nsec                : count    distribution                                         nsec                : count    distribution
         0 -> 1          : 0        |                                        |               0 -> 1          : 0        |                                        |
         2 -> 3          : 0        |                                        |               2 -> 3          : 0        |                                        |
         4 -> 7          : 0        |                                        |               4 -> 7          : 0        |                                        |
         8 -> 15         : 0        |                                        |               8 -> 15         : 0        |                                        |
        16 -> 31         : 0        |                                        |              16 -> 31         : 0        |                                        |
        32 -> 63         : 0        |                                        |              32 -> 63         : 0        |                                        |
        64 -> 127        : 0        |                                        |              64 -> 127        : 0        |                                        |
       128 -> 255        : 0        |                                        |             128 -> 255        : 0        |                                        |
       256 -> 511        : 0        |                                        |             256 -> 511        : 0        |                                        |
       512 -> 1023       : 0        |                                        |             512 -> 1023       : 0        |                                        |
      1024 -> 2047       : 0        |                                        |            1024 -> 2047       : 0        |                                        |
      2048 -> 4095       : 0        |                                        |            2048 -> 4095       : 0        |                                        |
      4096 -> 8191       : 0        |                                        |            4096 -> 8191       : 0        |                                        |
      8192 -> 16383      : 0        |                                        |            8192 -> 16383      : 0        |                                        |
     16384 -> 32767      : 0        |                                        |           16384 -> 32767      : 0        |                                        |
     32768 -> 65535      : 0        |                                        |           32768 -> 65535      : 0        |                                        |
     65536 -> 131071     : 0        |                                        |           65536 -> 131071     : 0        |                                        |
    131072 -> 262143     : 0        |                                        |          131072 -> 262143     : 0        |                                        |
    262144 -> 524287     : 0        |                                        |          262144 -> 524287     : 0        |                                        |
    524288 -> 1048575    : 0        |                                        |          524288 -> 1048575    : 0        |                                        |
   1048576 -> 2097151    : 0        |                                        |         1048576 -> 2097151    : 0        |                                        |
   2097152 -> 4194303    : 0        |                                        |         2097152 -> 4194303    : 0        |                                        |
   4194304 -> 8388607    : 861      |**                                      |         4194304 -> 8388607    : 1136     |****                                    |
   8388608 -> 16777215   : 3111     |********                                |         8388608 -> 16777215   : 6320     |************************                |
  16777216 -> 33554431   : 13901    |****************************************|        16777216 -> 33554431   : 10484    |****************************************|
Exiting trace of synchronize_rcu                                                    Exiting trace of synchronize_rcu


Interestingly I tried the same experiment without rcu_normal=1 (leaving rcu_expedited=1):

adb shell cat /proc/cmdline | tr ' ' '\n' | grep rcu
rcupdate.rcu_expedited=1
rcu_nocbs=0-7

In this case I also saw the -6 to -7% decrease in the app launch times
but I don't have a good explanation why that would be? (The fucntion
latency histograms in this case didn't show any significant difference).
Do you have any insight why this may happen?

Thanks,
Kalesh




> ---
>  .../admin-guide/kernel-parameters.txt         |  14 ++
>  kernel/rcu/Kconfig.debug                      |  12 ++
>  kernel/rcu/tree.c                             | 138 +++++++++++++++++-
>  kernel/rcu/tree_exp.h                         |   2 +-
>  4 files changed, 164 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 17a454909ab4..2cca75e4f0c6 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5047,6 +5047,20 @@
>  			delay, memory pressure or callback list growing too
>  			big.
>  
> +	rcutree.rcu_normal_wake_from_gp= [KNL]
> +			Reduces a latency of synchronize_rcu() call. This approach
> +			maintains its own track of synchronize_rcu() callers, so it
> +			does not interact with regular callbacks because it does not
> +			use a call_rcu[_hurry]() path. Please note, this is for a
> +			normal grace period.
> +
> +			How to enable it:
> +
> +			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> +			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
> +
> +			Default is 0.
> +
>  	rcuscale.gp_async= [KNL]
>  			Measure performance of asynchronous
>  			grace-period primitives such as call_rcu().
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index 9b0b52e1836f..4812c6249185 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -168,4 +168,16 @@ config RCU_STRICT_GRACE_PERIOD
>  	  when looking for certain types of RCU usage bugs, for example,
>  	  too-short RCU read-side critical sections.
>  
> +config RCU_SR_NORMAL_DEBUG_GP
> +	bool "Debug synchronize_rcu() callers for a grace period completion"
> +	depends on DEBUG_KERNEL && RCU_EXPERT
> +	default n
> +	help
> +	  This option enables additional debugging for detecting a grace
> +	  period incompletion for synchronize_rcu() users. If a GP is not
> +	  fully passed for any user, the warning message is emitted.
> +
> +	  Say Y here if you want to enable such debugging
> +	  Say N if you are unsure.
> +
>  endmenu # "RCU Debugging"
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 499803234176..b756c40e4960 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1422,6 +1422,106 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  }
>  
> +/*
> + * There are three lists for handling synchronize_rcu() users.
> + * A first list corresponds to new coming users, second for users
> + * which wait for a grace period and third is for which a grace
> + * period is passed.
> + */
> +static struct sr_normal_state {
> +	struct llist_head srs_next;	/* request a GP users. */
> +	struct llist_head srs_wait;	/* wait for GP users. */
> +	struct llist_head srs_done;	/* ready for GP users. */
> +
> +	/*
> +	 * In order to add a batch of nodes to already
> +	 * existing srs-done-list, a tail of srs-wait-list
> +	 * is maintained.
> +	 */
> +	struct llist_node *srs_wait_tail;
> +} sr;
> +
> +/* Disabled by default. */
> +static int rcu_normal_wake_from_gp;
> +module_param(rcu_normal_wake_from_gp, int, 0644);
> +
> +static void rcu_sr_normal_complete(struct llist_node *node)
> +{
> +	struct rcu_synchronize *rs = container_of(
> +		(struct rcu_head *) node, struct rcu_synchronize, head);
> +	unsigned long oldstate = (unsigned long) rs->head.func;
> +
> +	WARN_ONCE(IS_ENABLED(CONFIG_RCU_SR_NORMAL_DEBUG_GP) &&
> +		!poll_state_synchronize_rcu(oldstate),
> +		"A full grace period is not passed yet: %lu",
> +		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
> +
> +	/* Finally. */
> +	complete(&rs->completion);
> +}
> +
> +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> +{
> +	struct llist_node *done, *rcu, *next;
> +
> +	done = llist_del_all(&sr.srs_done);
> +	if (!done)
> +		return;
> +
> +	llist_for_each_safe(rcu, next, done)
> +		rcu_sr_normal_complete(rcu);
> +}
> +static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
> +
> +/*
> + * Helper function for rcu_gp_cleanup().
> + */
> +static void rcu_sr_normal_gp_cleanup(void)
> +{
> +	struct llist_node *head, *tail;
> +
> +	if (llist_empty(&sr.srs_wait))
> +		return;
> +
> +	tail = READ_ONCE(sr.srs_wait_tail);
> +	head = __llist_del_all(&sr.srs_wait);
> +
> +	if (head) {
> +		/* Can be not empty. */
> +		llist_add_batch(head, tail, &sr.srs_done);
> +		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
> +	}
> +}
> +
> +/*
> + * Helper function for rcu_gp_init().
> + */
> +static void rcu_sr_normal_gp_init(void)
> +{
> +	struct llist_node *head, *tail;
> +
> +	if (llist_empty(&sr.srs_next))
> +		return;
> +
> +	tail = llist_del_all(&sr.srs_next);
> +	head = llist_reverse_order(tail);
> +
> +	/*
> +	 * A waiting list of GP should be empty on this step,
> +	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> +	 * rolls it over. If not, it is a BUG, warn a user.
> +	 */
> +	WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
> +
> +	WRITE_ONCE(sr.srs_wait_tail, tail);
> +	__llist_add_batch(head, tail, &sr.srs_wait);
> +}
> +
> +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> +{
> +	llist_add((struct llist_node *) &rs->head, &sr.srs_next);
> +}
> +
>  /*
>   * Initialize a new grace period.  Return false if no grace period required.
>   */
> @@ -1456,6 +1556,7 @@ static noinline_for_stack bool rcu_gp_init(void)
>  	/* Record GP times before starting GP, hence rcu_seq_start(). */
>  	rcu_seq_start(&rcu_state.gp_seq);
>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> +	rcu_sr_normal_gp_init();
>  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
>  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
>  	raw_spin_unlock_irq_rcu_node(rnp);
> @@ -1825,6 +1926,9 @@ static noinline void rcu_gp_cleanup(void)
>  	}
>  	raw_spin_unlock_irq_rcu_node(rnp);
>  
> +	// Make synchronize_rcu() users aware of the end of old grace period.
> +	rcu_sr_normal_gp_cleanup();
> +
>  	// If strict, make all CPUs aware of the end of the old grace period.
>  	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
>  		on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
> @@ -3561,6 +3665,38 @@ static int rcu_blocking_is_gp(void)
>  	return true;
>  }
>  
> +/*
> + * Helper function for the synchronize_rcu() API.
> + */
> +static void synchronize_rcu_normal(void)
> +{
> +	struct rcu_synchronize rs;
> +
> +	if (!READ_ONCE(rcu_normal_wake_from_gp)) {
> +		wait_rcu_gp(call_rcu_hurry);
> +		return;
> +	}
> +
> +	init_rcu_head_on_stack(&rs.head);
> +	init_completion(&rs.completion);
> +
> +	/*
> +	 * This code might be preempted, therefore take a GP
> +	 * snapshot before adding a request.
> +	 */
> +	if (IS_ENABLED(CONFIG_RCU_SR_NORMAL_DEBUG_GP))
> +		rs.head.func = (void *) get_state_synchronize_rcu();
> +
> +	rcu_sr_normal_add_req(&rs);
> +
> +	/* Kick a GP and start waiting. */
> +	(void) start_poll_synchronize_rcu();
> +
> +	/* Now we can wait. */
> +	wait_for_completion(&rs.completion);
> +	destroy_rcu_head_on_stack(&rs.head);
> +}
> +
>  /**
>   * synchronize_rcu - wait until a grace period has elapsed.
>   *
> @@ -3612,7 +3748,7 @@ void synchronize_rcu(void)
>  		if (rcu_gp_is_expedited())
>  			synchronize_rcu_expedited();
>  		else
> -			wait_rcu_gp(call_rcu_hurry);
> +			synchronize_rcu_normal();
>  		return;
>  	}
>  
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 014ddf672165..bdc30d972d32 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -985,7 +985,7 @@ void synchronize_rcu_expedited(void)
>  
>  	/* If expedited grace periods are prohibited, fall back to normal. */
>  	if (rcu_gp_is_normal()) {
> -		wait_rcu_gp(call_rcu_hurry);
> +		synchronize_rcu_normal();
>  		return;
>  	}
>  
> -- 
> 2.39.2
> 

