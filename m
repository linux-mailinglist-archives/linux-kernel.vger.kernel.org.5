Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EAF7F2239
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjKUAi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjKUAi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:38:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7BDBA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:38:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70DFC433CB;
        Tue, 21 Nov 2023 00:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700527132;
        bh=Rdi3fgN5bNqPzN6X1N6jg3BAkEwpO3di158/L11Dhe4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cY3Az4cqVXdlbO3a0lOi4XTNvTFTfbfh1P5F6QRWXyiiNzxF5v1+jF0NZfqE9tCz0
         N2XUMaazXkK1d1/nxObrUEXy463/lN04GDVmVj28lEH87XS3ufDkjiPo68xMvYLr+V
         tT2IjO+eV+ANYQzT8tH+RG+LWCin+oOkRpIZ6n4hFO2HoMeW0jvVbYUc7afqqWkla5
         CHSd0AASfPmk/u3wFkbzFBQ6o2hNgahnnqNOPxo2ATqMSrMOPdh8Ns0Ue8k8pBjKVX
         gLXcTB62uqw3ig2kOSBW8q6K/rX092i/67JEidzY1Ak7uqm1RVUWrPoiOsU/NKBJVh
         SS9W2jvJG013Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9E905CE1390; Mon, 20 Nov 2023 16:38:52 -0800 (PST)
Date:   Mon, 20 Nov 2023 16:38:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 50/86] rcu: TASKS_RCU does not need to depend on
 PREEMPTION
Message-ID: <71b83b93-dc68-4c71-972a-5f0ccc3a59da@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-51-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-51-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:57:36PM -0800, Ankur Arora wrote:
> With PREEMPTION being always enabled, we don't need TASKS_RCU
> to be explicitly conditioned on it.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  arch/Kconfig             | 4 ++--
>  include/linux/rcupdate.h | 4 ----
>  kernel/bpf/Kconfig       | 2 +-
>  kernel/trace/Kconfig     | 4 ++--
>  4 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 05ce60036ecc..f5179b24072c 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -55,7 +55,7 @@ config KPROBES
>  	depends on MODULES
>  	depends on HAVE_KPROBES
>  	select KALLSYMS
> -	select TASKS_RCU if PREEMPTION
> +	select TASKS_RCU
>  	help
>  	  Kprobes allows you to trap at almost any kernel address and
>  	  execute a callback function.  register_kprobe() establishes
> @@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
>  config OPTPROBES
>  	def_bool y
>  	depends on KPROBES && HAVE_OPTPROBES
> -	select TASKS_RCU if PREEMPTION
> +	select TASKS_RCU
>  
>  config KPROBES_ON_FTRACE
>  	def_bool y
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 5e5f920ade90..7246ee602b0b 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -171,10 +171,6 @@ static inline void rcu_nocb_flush_deferred_wakeup(void) { }
>  	} while (0)
>  void call_rcu_tasks(struct rcu_head *head, rcu_callback_t func);
>  void synchronize_rcu_tasks(void);
> -# else
> -# define rcu_tasks_classic_qs(t, preempt) do { } while (0)
> -# define call_rcu_tasks call_rcu
> -# define synchronize_rcu_tasks synchronize_rcu
>  # endif
>  
>  # ifdef CONFIG_TASKS_TRACE_RCU
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index 6a906ff93006..e3231b28e2a0 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -27,7 +27,7 @@ config BPF_SYSCALL
>  	bool "Enable bpf() system call"
>  	select BPF
>  	select IRQ_WORK
> -	select TASKS_RCU if PREEMPTION
> +	select TASKS_RCU
>  	select TASKS_TRACE_RCU
>  	select BINARY_PRINTF
>  	select NET_SOCK_MSG if NET
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 61c541c36596..e090387b1c2d 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -163,7 +163,7 @@ config TRACING
>  	select BINARY_PRINTF
>  	select EVENT_TRACING
>  	select TRACE_CLOCK
> -	select TASKS_RCU if PREEMPTION
> +	select TASKS_RCU
>  
>  config GENERIC_TRACER
>  	bool
> @@ -204,7 +204,7 @@ config FUNCTION_TRACER
>  	select GENERIC_TRACER
>  	select CONTEXT_SWITCH_TRACER
>  	select GLOB
> -	select TASKS_RCU if PREEMPTION
> +	select TASKS_RCU
>  	select TASKS_RUDE_RCU
>  	help
>  	  Enable the kernel to trace every kernel function. This is done
> -- 
> 2.31.1
> 
