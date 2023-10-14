Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949E87C952C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 17:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjJNPbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 11:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjJNPbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 11:31:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F267BF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=tdEgVbIWnUYm0+EJkAezgqgXQSgHD915mBt/ie3kCzo=; b=MIlDt1FMU2p5UQSajpDIh2vXL+
        yY4qnasGEDBC7RayjAXyDihez0m4fhx6lRBdrvQkLTmRArFD1/j55sLqbGesy9Ge+yyqrGDXWKVjg
        2UkbuCU+F+EMIPdTP3NSLkGVIjvEFxnpECaIDuQ5Uj4EFFzHRWDTtjfTOVlUSbJfhtprbvckTsf/m
        hng/DgZEJ/VM/z9iClFizBrYayW2shwzdbWTH2jKoXYAkaS1As29EUxtH13n1nMR4KvBfsU3rDu8U
        YFC5PSuNM1rrBK58YIXoR0Mm/fyGPb9okmXTUVMuQtHmDgikE2zOz2/yTRId2Jyms1tP7Uo5dgNa9
        1Y06DNTw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qrgc5-005WxY-3C;
        Sat, 14 Oct 2023 15:31:38 +0000
Message-ID: <b72324e4-75d2-4d90-9e6d-342d10bb947b@infradead.org>
Date:   Sat, 14 Oct 2023 08:31:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fixed multiple typos in multiple files
Content-Language: en-US
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20231014123349.11294-1-m.muzzammilashraf@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231014123349.11294-1-m.muzzammilashraf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/14/23 05:33, Muhammad Muzammil wrote:
> debug_vm_pgtable.c: Fixed typo
> internal.h: Fixed typo
> memcontrol.c: Fixed typo
> mmap.c: Fixed typo
> 
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>

These all look good to me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


One comment below:

> ---
>  mm/debug_vm_pgtable.c | 4 ++--
>  mm/internal.h         | 2 +-
>  mm/memcontrol.c       | 4 ++--
>  mm/mmap.c             | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 48e329ea5ba3..e651500e597a 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -1322,8 +1322,8 @@ static int __init debug_vm_pgtable(void)
>  	 * true irrespective of the starting protection value for a
>  	 * given page table entry.
>  	 *
> -	 * Protection based vm_flags combinatins are always linear
> -	 * and increasing i.e starting from VM_NONE and going upto
> +	 * Protection based vm_flags combinations are always linear
> +	 * and increasing i.e starting from VM_NONE and going up to
>  	 * (VM_SHARED | READ | WRITE | EXEC).
>  	 */
>  #define VM_FLAGS_START	(VM_NONE)
> diff --git a/mm/internal.h b/mm/internal.h
> index b52a526d239d..b61034bd50f5 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -601,7 +601,7 @@ extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>   * range.
>   * "fully mapped" means all the pages of folio is associated with the page
>   * table of range while this function just check whether the folio range is
> - * within the range [start, end). Funcation caller nees to do page table
> + * within the range [start, end). Function caller needs to do page table
>   * check if it cares about the page table association.
>   *
>   * Typical usage (like mlock or madvise) is:
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index be2ad117515e..7987a092e530 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -842,7 +842,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  	memcg = pn->memcg;
>  
>  	/*
> -	 * The caller from rmap relay on disabled preemption becase they never
> +	 * The caller from rmap relay on disabled preemption because they never
>  	 * update their counter from in-interrupt context. For these two

I don't know what that (partial) sentence is trying to say...
Maybe someone else does.

>  	 * counters we check that the update is never performed from an
>  	 * interrupt context while other caller need to have disabled interrupt.
> @@ -8104,7 +8104,7 @@ static struct cftype memsw_files[] = {
>   *
>   * This doesn't check for specific headroom, and it is not atomic
>   * either. But with zswap, the size of the allocation is only known
> - * once compression has occured, and this optimistic pre-check avoids
> + * once compression has occurred, and this optimistic pre-check avoids
>   * spending cycles on compression when there is already no room left
>   * or zswap is disabled altogether somewhere in the hierarchy.
>   */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b59f5e26b6fb..27539ffe2048 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1223,7 +1223,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  	 * Does the application expect PROT_READ to imply PROT_EXEC?
>  	 *
>  	 * (the exception is when the underlying filesystem is noexec
> -	 *  mounted, in which case we dont add PROT_EXEC.)
> +	 *  mounted, in which case we don't add PROT_EXEC.)
>  	 */
>  	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
>  		if (!(file && path_noexec(&file->f_path)))

-- 
~Randy
