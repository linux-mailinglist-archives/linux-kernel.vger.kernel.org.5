Return-Path: <linux-kernel+bounces-96818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD488761CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C61AB21B25
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FAC537FC;
	Fri,  8 Mar 2024 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="H6hdl/LO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0CB53E38;
	Fri,  8 Mar 2024 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893164; cv=none; b=uq2rF+Wa4ZhiRDDtj9DGFmrh6sysMIcW4uowhCsg2RV3e2nBg9exwOWX0i3flkMZQ1qFwL7+wXJCB4qIl4kLXz7UEsAso/EHqDh/44ild6qzPz2Ol3q3OhHL+KZESeOD4Xud/dkQLCPR1njphXpj2I+hDiz9dyMwWEh21pbzftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893164; c=relaxed/simple;
	bh=R5gaARdNsRmM69c5HgWPDtEZ+UQVlNygoacJUf6ucTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDdJ8kPu7+JvFNOPG5JPtOmro5XYQZyg9KM6hqnCqh9nqMwAkUvPy0TFi4PfTGvLtUd7YsLMixxsR9SM8j8OfagFwL6sgsQQbD/EyTjMWOHO8S+vQXE9n32keoS4xlCjRBpmWpIGbchRy3Z6riTT2IAP5DuJcSrvXDRbMCAJ8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=H6hdl/LO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9EE8240E016C;
	Fri,  8 Mar 2024 10:19:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ruZKQR_-Iw_R; Fri,  8 Mar 2024 10:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709893155; bh=y77t4200yTQouMTgjVRR5xGyTOTtJKOA/I+puU2K3Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6hdl/LOCtM16GhjDYZN9SDiUSP84YGd0MMZhv89JKdmmQUDFS9wWsLlwLe7zOlm8
	 kt/3Ts1rNR/ra5fXsjBUCT9fgqVDSgQ4G56PgGI/NInAjgu+gkEXXimjKBwSM81XS/
	 QqWLkMRGNY1Y/rdp18vAhLw39y66cdfcYLnrR9N30Kqyy26pzx5f/GnvKeRpQxdMem
	 bjcVr2rN+dOQEhjoEUGbPoF7Aw6B9+5cfY9KoI/mzgkCvqisE8s+jHMUjbnO7Wr8YE
	 gGxkcbm21c+Ml3EsXzXKvg1tMHKzUzm/Msd/epIpCTTLw12N/4TSfGhR+4CxoG8BXZ
	 N4I9lmImAjH3+gFa0U99H5UkJQcwMg8S7/9Ayo/U1485XU349KJ3qNzsa7QUTC2dKa
	 y9HzuFioKBDxO/zIaH7pQsr24DBg0n6eUbMTmOOTL3RGNNZBnjnW9VMJbG0UA4YOcW
	 CAKQi96BHFTyZC1fD0iChfAxPx2Sz8nxoDTZcozmqhJbHNb6nqdNKULendIOSc/Bdm
	 i6mt/+LV1J6mtw+viyRqpe2QNA+te3oOrKVRvAebaPSMdxA1DRsW+s8vy6SQBTdn3d
	 jQa9XePuPRxpFzm9cvQ/B7RLWUW0op6gseeN4lIWW19ZwpgeOgXlddT+dj7AcK3mB0
	 Vc3l4KAgt5FV+Fou4h/mpzE4=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1961540E016B;
	Fri,  8 Mar 2024 10:18:43 +0000 (UTC)
Date: Fri, 8 Mar 2024 11:18:36 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
	mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
	naoya.horiguchi@nec.com, james.morse@arm.com,
	gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
	ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v11 3/3] ACPI: APEI: handle synchronous exceptions in
 task work to send correct SIGBUS si_code
Message-ID: <20240308101836.GDZerl_IXIkWt8VuZN@fat_crate.local>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-4-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204080144.7977-4-xueshuai@linux.alibaba.com>

On Sun, Feb 04, 2024 at 04:01:44PM +0800, Shuai Xue wrote:
> Hardware errors could be signaled by asynchronous interrupt, e.g. when an
> error is detected by a background scrubber, or signaled by synchronous
> exception, e.g. when a CPU tries to access a poisoned cache line. Since
> commit a70297d22132 ("ACPI: APEI: set memory failure flags as
> MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRED
> could be used to determine whether a synchronous exception occurs on ARM64
> platform. When a synchronous exception is detected, the kernel should
> terminate the current process which accessing the poisoned page. This is

"which has accessed poison data"

> done by sending a SIGBUS signal with an error code BUS_MCEERR_AR,
> indicating an action-required machine check error on read.
> 
> However, the memory failure recovery is incorrectly sending a SIGBUS
> with wrong error code BUS_MCEERR_AO for synchronous errors in early kill
> mode, even MF_ACTION_REQUIRED is set. The main problem is that

"even if"

> synchronous errors are queued as a memory_failure() work, and are
> executed within a kernel thread context, not the user-space process that
> encountered the corrupted memory on ARM64 platform. As a result, when
> kill_proc() is called to terminate the process, it sends the incorrect
> SIGBUS error code because the context in which it operates is not the
> one where the error was triggered.
> 
> To this end, queue memory_failure() as a task_work so that it runs in
> the context of the process that is actually consuming the poisoned data,
> and it will send SIBBUS with si_code BUS_MCEERR_AR.

SIGBUS

> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c | 77 +++++++++++++++++++++++-----------------
>  include/acpi/ghes.h      |  3 --
>  mm/memory-failure.c      | 13 -------
>  3 files changed, 44 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0892550732d4..e5086d795bee 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -465,28 +465,41 @@ static void ghes_clear_estatus(struct ghes *ghes,
>  }
>  
>  /*
> - * Called as task_work before returning to user-space.
> - * Ensure any queued work has been done before we return to the context that
> - * triggered the notification.
> + * struct sync_task_work - for synchronous RAS event

What's so special about it being a "sync_"?

task_work is just fine and something else could use it too.

> + *
> + * @twork:                callback_head for task work
> + * @pfn:                  page frame number of corrupted page
> + * @flags:                fine tune action taken

s/fine tune action taken/work control flags/

> + *
> + * Structure to pass task work to be handled before
> + * ret_to_user via task_work_add().

What is "ret_to_user"?

If this is an ARM thing, then make sure you explain stuff properly and
detailed. This driver is used by multiple architectures.

>   */
> -static void ghes_kick_task_work(struct callback_head *head)
> +struct sync_task_work {
> +	struct callback_head twork;
> +	u64 pfn;
> +	int flags;
> +};
> +
> +static void memory_failure_cb(struct callback_head *twork)
>  {
> -	struct acpi_hest_generic_status *estatus;
> -	struct ghes_estatus_node *estatus_node;
> -	u32 node_len;
> +	int ret;
> +	struct sync_task_work *twcb =
> +		container_of(twork, struct sync_task_work, twork);

Ugly linebreak - no need for it.

> -	estatus_node = container_of(head, struct ghes_estatus_node, task_work);
> -	if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
> -		memory_failure_queue_kick(estatus_node->task_work_cpu);
> +	ret = memory_failure(twcb->pfn, twcb->flags);
> +	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
>  
> -	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
> -	node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
> -	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
> +	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
> +		return;
> +
> +	pr_err("Sending SIGBUS to current task due to memory error not recovered");
> +	force_sig(SIGBUS);
>  }
>  
>  static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>  {
>  	unsigned long pfn;
> +	struct sync_task_work *twcb;
>  
>  	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>  		return false;
> @@ -499,6 +512,18 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>  		return false;
>  	}
>  
> +	if (flags == MF_ACTION_REQUIRED && current->mm) {
> +		twcb = (void *)gen_pool_alloc(ghes_estatus_pool, sizeof(*twcb));
> +		if (!twcb)
> +			return false;
> +
> +		twcb->pfn = pfn;
> +		twcb->flags = flags;
> +		init_task_work(&twcb->twork, memory_failure_cb);
> +		task_work_add(current, &twcb->twork, TWA_RESUME);
> +		return true;
> +	}
> +
>  	memory_failure_queue(pfn, flags);
>  	return true;
>  }
> @@ -746,7 +771,7 @@ int cxl_cper_unregister_callback(cxl_cper_callback callback)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_callback, CXL);
>  
> -static bool ghes_do_proc(struct ghes *ghes,
> +static void ghes_do_proc(struct ghes *ghes,
>  			 const struct acpi_hest_generic_status *estatus)
>  {
>  	int sev, sec_sev;
> @@ -814,8 +839,6 @@ static bool ghes_do_proc(struct ghes *ghes,
>  		pr_err("Sending SIGBUS to current task due to memory error not recovered");
>  		force_sig(SIGBUS);
>  	}
> -
> -	return queued;
>  }
>  
>  static void __ghes_print_estatus(const char *pfx,
> @@ -1117,9 +1140,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>  	struct ghes_estatus_node *estatus_node;
>  	struct acpi_hest_generic *generic;
>  	struct acpi_hest_generic_status *estatus;
> -	bool task_work_pending;
>  	u32 len, node_len;
> -	int ret;
>  
>  	llnode = llist_del_all(&ghes_estatus_llist);
>  	/*
> @@ -1134,25 +1155,16 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>  		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>  		len = cper_estatus_len(estatus);
>  		node_len = GHES_ESTATUS_NODE_LEN(len);
> -		task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
> +
> +		ghes_do_proc(estatus_node->ghes, estatus);
> +
>  		if (!ghes_estatus_cached(estatus)) {
>  			generic = estatus_node->generic;
>  			if (ghes_print_estatus(NULL, generic, estatus))
>  				ghes_estatus_cache_add(generic, estatus);
>  		}
> -
> -		if (task_work_pending && current->mm) {
> -			estatus_node->task_work.func = ghes_kick_task_work;
> -			estatus_node->task_work_cpu = smp_processor_id();
> -			ret = task_work_add(current, &estatus_node->task_work,
> -					    TWA_RESUME);
> -			if (ret)
> -				estatus_node->task_work.func = NULL;
> -		}
> -
> -		if (!estatus_node->task_work.func)
> -			gen_pool_free(ghes_estatus_pool,
> -				      (unsigned long)estatus_node, node_len);

I have no clue why this is being removed.

Why doesn't a synchronous exception on ARM call into ghes_proc_in_irq()?

That SDEI thing certainly does.

Well looka here:

  7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous errors")

that thing does exactly what you're trying to "fix". So why doesn't that
work for you?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

