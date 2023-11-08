Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74F7E5976
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjKHOst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjKHOsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:48:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C576619A5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:48:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD32C433C8;
        Wed,  8 Nov 2023 14:48:44 +0000 (UTC)
Date:   Wed, 8 Nov 2023 09:48:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Waiman Long <longman@redhat.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        dri-devel@lists.freedesktop.org
Subject: Re: kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <20231108094847.236d04b2@gandalf.local.home>
In-Reply-To: <202311081340.3k72KKdg-lkp@intel.com>
References: <202311081340.3k72KKdg-lkp@intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 13:55:21 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   305230142ae0637213bf6e04f6d9f10bbcb74af8
> commit: c0a581d7126c0bbc96163276f585fd7b4e4d8d0e tracing: Disable interrupt or preemption before acquiring arch_spinlock_t
> date:   1 year, 1 month ago
> config: loongarch-randconfig-r123-20231107 (https://download.01.org/0day-ci/archive/20231108/202311081340.3k72KKdg-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231108/202311081340.3k72KKdg-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311081340.3k72KKdg-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>    kernel/trace/trace.c:406:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
>    kernel/trace/trace.c:406:28: sparse:     expected struct trace_export **list
>    kernel/trace/trace.c:406:28: sparse:     got struct trace_export [noderef] __rcu **
>    kernel/trace/trace.c:420:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct trace_export **list @@     got struct trace_export [noderef] __rcu ** @@
>    kernel/trace/trace.c:420:33: sparse:     expected struct trace_export **list
>    kernel/trace/trace.c:420:33: sparse:     got struct trace_export [noderef] __rcu **
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got unsigned int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got unsigned int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got unsigned int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got unsigned int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@  
>    kernel/trace/trace.c:2430:9: sparse:     expected void *ptr
>    kernel/trace/trace.c:2430:9: sparse:     got int [noderef] __percpu *
> >> kernel/trace/trace.c:2430:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@  


> 
> vim +2430 kernel/trace/trace.c
> 
>   2410	
>   2411	static int trace_save_cmdline(struct task_struct *tsk)
>   2412	{
>   2413		unsigned tpid, idx;
>   2414	
>   2415		/* treat recording of idle task as a success */
>   2416		if (!tsk->pid)
>   2417			return 1;
>   2418	
>   2419		tpid = tsk->pid & (PID_MAX_DEFAULT - 1);
>   2420	
>   2421		/*
>   2422		 * It's not the end of the world if we don't get
>   2423		 * the lock, but we also don't want to spin
>   2424		 * nor do we want to disable interrupts,
>   2425		 * so if we miss here, then better luck next time.
>   2426		 *
>   2427		 * This is called within the scheduler and wake up, so interrupts
>   2428		 * had better been disabled and run queue lock been held.
>   2429		 */
> > 2430		lockdep_assert_preemption_disabled();  

The above is a generic lockdep utility. Sounds to me that this is a bug in
the loongarch code that doesn't handle this properly.

-- Steve


>   2431		if (!arch_spin_trylock(&trace_cmdline_lock))
>   2432			return 0;
>   2433	
>   2434		idx = savedcmd->map_pid_to_cmdline[tpid];
>   2435		if (idx == NO_CMDLINE_MAP) {
>   2436			idx = (savedcmd->cmdline_idx + 1) % savedcmd->cmdline_num;
>   2437	
>   2438			savedcmd->map_pid_to_cmdline[tpid] = idx;
>   2439			savedcmd->cmdline_idx = idx;
>   2440		}
>   2441	
>   2442		savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
>   2443		set_cmdline(idx, tsk->comm);
>   2444	
>   2445		arch_spin_unlock(&trace_cmdline_lock);
>   2446	
>   2447		return 1;
>   2448	}
>   2449	
> 

