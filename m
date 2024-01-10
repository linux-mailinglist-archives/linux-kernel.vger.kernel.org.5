Return-Path: <linux-kernel+bounces-22591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A4082A022
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A32C28589B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDCF4D581;
	Wed, 10 Jan 2024 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sBlFWikV"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894E94CDE0;
	Wed, 10 Jan 2024 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=P5W+XAlOAJNlDZf97/sRKEcWMM8n4myFRv+RWU0uogg=; b=sBlFWikVsbCqtAgADtOuCnGoH4
	AxTBDxMZubyBoGX2ShmD+3I6g20CX7Sa9L7RRg7Za5/ElF9tutC3DN+twgSv4e69niS6m3dbcO1l+
	TvRJJ1fqh1PHT52GZxjsqkUox+k9rE1nQcglt5vHXJInVfN/kTZdMfV8TLgkifocSK5nKfX4pwY+5
	us825GDF1swrTKdL3epwGT9EABOtEaggge4V8T5tl1OJ7K0ckNK4H3PikqVE8FTa6wCKVji0xrXrF
	zD+oU4/pVJVtITj49/T7b1aUvIVSz11HnY0L+XpTqYY8Wp8txqp5d/hWwPvnBZTBszAX2avcAAzH5
	aSKoF8zQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNd7H-00DOoO-0n;
	Wed, 10 Jan 2024 18:15:51 +0000
Message-ID: <63046420-264a-4e7c-b45c-17f0486ba4d9@infradead.org>
Date: Wed, 10 Jan 2024 10:15:49 -0800
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
 palmer@dabbelt.com, aou@eecs.berkeley.edu, mathieu.desnoyers@efficios.com,
 paulmck@kernel.org, corbet@lwn.net
Cc: mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
 charlie@rivosinc.com, rehn@rivosinc.com, linux-riscv@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240110145533.60234-1-parri.andrea@gmail.com>
 <20240110145533.60234-3-parri.andrea@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240110145533.60234-3-parri.andrea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/10/24 06:55, Andrea Parri wrote:
> To gather the architecture requirements of the "private/global
> expedited" membarrier commands.  The file will be expanded to
> integrate further information about the membarrier syscall (as
> needed/desired in the future).  While at it, amend some related
> inline comments in the membarrier codebase.
> 
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  Documentation/scheduler/index.rst      |  1 +
>  Documentation/scheduler/membarrier.rst | 37 ++++++++++++++++++++++++++
>  MAINTAINERS                            |  1 +
>  kernel/sched/core.c                    |  7 ++++-
>  kernel/sched/membarrier.c              |  8 +++---
>  5 files changed, 49 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/scheduler/membarrier.rst
> 
> diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
> index 3170747226f6d..43bd8a145b7a9 100644
> --- a/Documentation/scheduler/index.rst
> +++ b/Documentation/scheduler/index.rst
> @@ -7,6 +7,7 @@ Scheduler
>  
>  
>      completion
> +    membarrier
>      sched-arch
>      sched-bwc
>      sched-deadline
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

What does "The command" refer to above and below, please?

Thanks.

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


-- 
#Randy

