Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499DE80A595
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573971AbjLHOee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573958AbjLHOed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:34:33 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1272A173B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702046076;
        bh=JBuEodv1vKk4aXJXB85bNo4KPkCVTL7QiclIOUK/ZT8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=q30EWXZb53v4IPcevMif+xHpd8veWDf4RwdfANyyBNuhVFxeCU795yPqXgv58TTqb
         TPRYRmu78MqXXQrPy5xASzmUZiRM4N6+LY232SoRymVKNf3E539CSwPS1ejK/263jj
         RZj53hEC6sDvYSxs8NrlodbbSThJpmt5Io7nc2DXh+7wsJLxnrPooRsUxc7CH507q/
         NR+DFrlNSOe0iJ2rYHqCuQFjNas/gY8u95aUtvJxG8kAoi7ETmsHzaiHwQwoVDDC7A
         exMb1vMF/nGulCkCoFqSwPia1HdYVpYYvzpUR7P0EN7JA47Ye7gAnYGTEt3no89Z6/
         hAyLld2yZ1FiQ==
Received: from [132.207.210.125] (Sansfil-Eduroam-Externe-210-125.polymtl.ca [132.207.210.125])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SmtvJ6WcRzG3q;
        Fri,  8 Dec 2023 09:34:36 -0500 (EST)
Message-ID: <203f8ab5-7728-40fe-bd31-d48440fb0726@efficios.com>
Date:   Fri, 8 Dec 2023 09:34:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init/Kconfig: move more items into the EXPERT menu
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
References: <20231208045819.2922-1-rdunlap@infradead.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231208045819.2922-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-07 23:58, Randy Dunlap wrote:
> KCMP, RSEQ, CACHESTAT_SYSCALL, and PC104 depend on EXPERT but not shown
> in the EXPERT menu. Move some lines around so that they are displayed
> in the EXPERT menu.
> 
> Drop one useless comment.
> 
> Change "enabled" to "enable" for DEBUG_RSEQ.

Thanks!

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>   init/Kconfig |  102 ++++++++++++++++++++++++-------------------------
>   1 file changed, 50 insertions(+), 52 deletions(-)
> 
> diff -- a/init/Kconfig b/init/Kconfig
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1688,6 +1688,56 @@ config MEMBARRIER
>   
>   	  If unsure, say Y.
>   
> +config KCMP
> +	bool "Enable kcmp() system call" if EXPERT
> +	help
> +	  Enable the kernel resource comparison system call. It provides
> +	  user-space with the ability to compare two processes to see if they
> +	  share a common resource, such as a file descriptor or even virtual
> +	  memory space.
> +
> +	  If unsure, say N.
> +
> +config RSEQ
> +	bool "Enable rseq() system call" if EXPERT
> +	default y
> +	depends on HAVE_RSEQ
> +	select MEMBARRIER
> +	help
> +	  Enable the restartable sequences system call. It provides a
> +	  user-space cache for the current CPU number value, which
> +	  speeds up getting the current CPU number from user-space,
> +	  as well as an ABI to speed up user-space operations on
> +	  per-CPU data.
> +
> +	  If unsure, say Y.
> +
> +config DEBUG_RSEQ
> +	default n
> +	bool "Enable debugging of rseq() system call" if EXPERT
> +	depends on RSEQ && DEBUG_KERNEL
> +	help
> +	  Enable extra debugging checks for the rseq system call.
> +
> +	  If unsure, say N.
> +
> +config CACHESTAT_SYSCALL
> +	bool "Enable cachestat() system call" if EXPERT
> +	default y
> +	help
> +	  Enable the cachestat system call, which queries the page cache
> +	  statistics of a file (number of cached pages, dirty pages,
> +	  pages marked for writeback, (recently) evicted pages).
> +
> +	  If unsure say Y here.
> +
> +config PC104
> +	bool "PC/104 support" if EXPERT
> +	help
> +	  Expose PC/104 form factor device drivers and options available for
> +	  selection and configuration. Enable this option if your target
> +	  machine has a PC/104 bus.
> +
>   config KALLSYMS
>   	bool "Load all symbols for debugging/ksymoops" if EXPERT
>   	default y
> @@ -1752,57 +1802,12 @@ config KALLSYMS_BASE_RELATIVE
>   
>   # end of the "standard kernel features (expert users)" menu
>   
> -# syscall, maps, verifier
> -
>   config ARCH_HAS_MEMBARRIER_CALLBACKS
>   	bool
>   
>   config ARCH_HAS_MEMBARRIER_SYNC_CORE
>   	bool
>   
> -config KCMP
> -	bool "Enable kcmp() system call" if EXPERT
> -	help
> -	  Enable the kernel resource comparison system call. It provides
> -	  user-space with the ability to compare two processes to see if they
> -	  share a common resource, such as a file descriptor or even virtual
> -	  memory space.
> -
> -	  If unsure, say N.
> -
> -config RSEQ
> -	bool "Enable rseq() system call" if EXPERT
> -	default y
> -	depends on HAVE_RSEQ
> -	select MEMBARRIER
> -	help
> -	  Enable the restartable sequences system call. It provides a
> -	  user-space cache for the current CPU number value, which
> -	  speeds up getting the current CPU number from user-space,
> -	  as well as an ABI to speed up user-space operations on
> -	  per-CPU data.
> -
> -	  If unsure, say Y.
> -
> -config CACHESTAT_SYSCALL
> -	bool "Enable cachestat() system call" if EXPERT
> -	default y
> -	help
> -	  Enable the cachestat system call, which queries the page cache
> -	  statistics of a file (number of cached pages, dirty pages,
> -	  pages marked for writeback, (recently) evicted pages).
> -
> -	  If unsure say Y here.
> -
> -config DEBUG_RSEQ
> -	default n
> -	bool "Enabled debugging of rseq() system call" if EXPERT
> -	depends on RSEQ && DEBUG_KERNEL
> -	help
> -	  Enable extra debugging checks for the rseq system call.
> -
> -	  If unsure, say N.
> -
>   config HAVE_PERF_EVENTS
>   	bool
>   	help
> @@ -1817,13 +1822,6 @@ config PERF_USE_VMALLOC
>   	help
>   	  See tools/perf/design.txt for details
>   
> -config PC104
> -	bool "PC/104 support" if EXPERT
> -	help
> -	  Expose PC/104 form factor device drivers and options available for
> -	  selection and configuration. Enable this option if your target
> -	  machine has a PC/104 bus.
> -
>   menu "Kernel Performance Events And Counters"
>   
>   config PERF_EVENTS

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

