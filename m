Return-Path: <linux-kernel+bounces-37312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334883AE1E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02039289802
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B4B7CF39;
	Wed, 24 Jan 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="xY69iOjQ"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C57E594;
	Wed, 24 Jan 2024 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112807; cv=none; b=o7/fe5gzWsUEq3MXQBAPIV+D/g49LB3g9sInpzMtXXOQPt6kZ2QPW0Nh0+/L36zivlY5nW1qe9UdQHmF5FO/pu5wmcjeuT7Zub3m+hVvSyY609x4rt2oRQl7VHP9eNoTgenVCKxGnph971q2lNPA1MsJlir5BHEX3UyrFxpDPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112807; c=relaxed/simple;
	bh=CmL8wTtpgjbpskLlRLiCz6pU6cSsxxWnkQiC+ZyxVGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Io2nLHXd5bwrvfbkOZeBVGHYypYDYsfy5z3O8p4BcHt/KH/MKBirboVvfhsfkZQMx8Ty0J3HLtUgPHl9uJiJ7h302u2Ag/yKmgg40CQFExtCwr2MUX5LcndlXqrRIqgFWnTvEzqwrJgbe3l7TOhi/gJEe+FUo/OLEsQuqEKg0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=xY69iOjQ; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706112796;
	bh=CmL8wTtpgjbpskLlRLiCz6pU6cSsxxWnkQiC+ZyxVGk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xY69iOjQrXnkCBpDwyzUKhwkCE8wToyhDK/3oQtq3mno7+NJ9lS5u7bHrcvBOYXUp
	 W37jFqUB1RFPHkI9qvdTseGgeOoQqsvKNCMi18/sc+3xo3Be4DAeBkCJrD/do3lp5e
	 lkDinivWyTqeIDE+JM7Vesp97qHUE3ZQvzUtkvR5ooQk7auyVcTy2z9jKWbOU+jAP5
	 XCxnNL+qMU8ODg7V4xk09T3oQ1qxWTaQDWF8BKDZPQDKUP4lf0KzeC0khQ+gJEQmcg
	 mi6Sr6NaEslo+urKskjKEnh+1w0NaA01qiopSpNdRP+Hpg+lz3rpQTaejIHiUoBlZE
	 V6cSnQYLRYQgg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TKpsS3JvnzTt5;
	Wed, 24 Jan 2024 11:13:16 -0500 (EST)
Message-ID: <ff2cf636-e0cf-422e-9ad3-4cd8fc51e3b2@efficios.com>
Date: Wed, 24 Jan 2024 11:13:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] membarrier: Create
 Documentation/scheduler/membarrier.rst
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org, corbet@lwn.net
Cc: mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
 charlie@rivosinc.com, rehn@rivosinc.com, linux-riscv@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240110145533.60234-1-parri.andrea@gmail.com>
 <20240110145533.60234-3-parri.andrea@gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240110145533.60234-3-parri.andrea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-10 09:55, Andrea Parri wrote:
> To gather the architecture requirements of the "private/global
> expedited" membarrier commands.  The file will be expanded to
> integrate further information about the membarrier syscall (as
> needed/desired in the future).  While at it, amend some related
> inline comments in the membarrier codebase.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>   Documentation/scheduler/index.rst      |  1 +
>   Documentation/scheduler/membarrier.rst | 37 ++++++++++++++++++++++++++
>   MAINTAINERS                            |  1 +
>   kernel/sched/core.c                    |  7 ++++-
>   kernel/sched/membarrier.c              |  8 +++---
>   5 files changed, 49 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/scheduler/membarrier.rst
> 
> diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
> index 3170747226f6d..43bd8a145b7a9 100644
> --- a/Documentation/scheduler/index.rst
> +++ b/Documentation/scheduler/index.rst
> @@ -7,6 +7,7 @@ Scheduler
>   
>   
>       completion
> +    membarrier
>       sched-arch
>       sched-bwc
>       sched-deadline
> diff --git a/Documentation/scheduler/membarrier.rst b/Documentation/scheduler/membarrier.rst
> new file mode 100644
> index 0000000000000..ab7ee3824b407
> --- /dev/null
> +++ b/Documentation/scheduler/membarrier.rst
> @@ -0,0 +1,37 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================
> +membarrier() System Call
> +========================
> +
> +MEMBARRIER_CMD_{PRIVATE,GLOBAL}_EXPEDITED - Architecture requirements
> +=====================================================================
> +
> +Memory barriers before updating rq->curr
> +----------------------------------------
> +
> +The command requires each architecture to have a full memory barrier after
> +coming from user-space, before updating rq->curr.  This barrier is implied
> +by the sequence rq_lock(); smp_mb__after_spinlock() in __schedule().  The
> +barrier matches a full barrier in the proximity of the membarrier system
> +call exit, cf. membarrier_{private,global}_expedited().
> +
> +Memory barriers after updating rq->curr
> +---------------------------------------
> +
> +The command requires each architecture to have a full memory barrier after
> +updating rq->curr, before returning to user-space.  The schemes providing
> +this barrier on the various architectures are as follows.
> +
> + - alpha, arc, arm, hexagon, mips rely on the full barrier implied by
> +   spin_unlock() in finish_lock_switch().
> +
> + - arm64 relies on the full barrier implied by switch_to().
> +
> + - powerpc, riscv, s390, sparc, x86 rely on the full barrier implied by
> +   switch_mm(), if mm is not NULL; they rely on the full barrier implied
> +   by mmdrop(), otherwise.  On powerpc and riscv, switch_mm() relies on
> +   membarrier_arch_switch_mm().
> +
> +The barrier matches a full barrier in the proximity of the membarrier system
> +call entry, cf. membarrier_{private,global}_expedited().
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0f8cec504b2ba..6bce0aeecb4f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13815,6 +13815,7 @@ M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>   M:	"Paul E. McKenney" <paulmck@kernel.org>
>   L:	linux-kernel@vger.kernel.org
>   S:	Supported
> +F:	Documentation/scheduler/membarrier.rst
>   F:	arch/*/include/asm/membarrier.h
>   F:	include/uapi/linux/membarrier.h
>   F:	kernel/sched/membarrier.c
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 711dc753f7216..b51bc86f8340c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6599,7 +6599,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>   	 *     if (signal_pending_state())	    if (p->state & @state)
>   	 *
>   	 * Also, the membarrier system call requires a full memory barrier
> -	 * after coming from user-space, before storing to rq->curr.
> +	 * after coming from user-space, before storing to rq->curr; this
> +	 * barrier matches a full barrier in the proximity of the membarrier
> +	 * system call exit.
>   	 */
>   	rq_lock(rq, &rf);
>   	smp_mb__after_spinlock();
> @@ -6677,6 +6679,9 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>   		 *   architectures where spin_unlock is a full barrier,
>   		 * - switch_to() for arm64 (weakly-ordered, spin_unlock
>   		 *   is a RELEASE barrier),
> +		 *
> +		 * The barrier matches a full barrier in the proximity of
> +		 * the membarrier system call entry.
>   		 */
>   		++*switch_count;
>   
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 2ad881d07752c..f3d91628d6b8a 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -251,7 +251,7 @@ static int membarrier_global_expedited(void)
>   		return 0;
>   
>   	/*
> -	 * Matches memory barriers around rq->curr modification in
> +	 * Matches memory barriers after rq->curr modification in
>   	 * scheduler.
>   	 */
>   	smp_mb();	/* system call entry is not a mb. */
> @@ -300,7 +300,7 @@ static int membarrier_global_expedited(void)
>   
>   	/*
>   	 * Memory barrier on the caller thread _after_ we finished
> -	 * waiting for the last IPI. Matches memory barriers around
> +	 * waiting for the last IPI. Matches memory barriers before
>   	 * rq->curr modification in scheduler.
>   	 */
>   	smp_mb();	/* exit from system call is not a mb */
> @@ -339,7 +339,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
>   		return 0;
>   
>   	/*
> -	 * Matches memory barriers around rq->curr modification in
> +	 * Matches memory barriers after rq->curr modification in
>   	 * scheduler.
>   	 */
>   	smp_mb();	/* system call entry is not a mb. */
> @@ -415,7 +415,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
>   
>   	/*
>   	 * Memory barrier on the caller thread _after_ we finished
> -	 * waiting for the last IPI. Matches memory barriers around
> +	 * waiting for the last IPI. Matches memory barriers before
>   	 * rq->curr modification in scheduler.
>   	 */
>   	smp_mb();	/* exit from system call is not a mb */

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


