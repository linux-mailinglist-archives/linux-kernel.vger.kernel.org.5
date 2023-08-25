Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824FF788F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjHYT7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjHYT6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:58:38 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85911268A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:58:34 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56e0d6651fbso1205001eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692993514; x=1693598314;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S7SWZIZu/vGsfuMu4tEV7kAOgiYlEzMDxZEvJL1wnXc=;
        b=gF9J2eyOwoMCuVp30FTUR0yS681u96iZFMI9f2Da6uRZYNtW2lnMqhz6iI8LTHq90Y
         UfkObHf9wC68zh5FW3iizY1GMW6q+MUCne62Ur0f36UDj3ni0m+3b9uwuIpo4SnI/l54
         RH86FKLzHC/2mp/5jP59RgAwosr3rjEMyZ1tOBVymQylxilc3RINykhx1ftyFVMmopeo
         42GtoFjcqnG9nOyhP62WaLBF6eiBZs6IrPIKWURNUo8yi78q/IpdXga9XvdVDy9SgZ7M
         ru+eijQOpLNUI2SAG9NHq8zMF4IR5NgwNtdinebqjP1vb+5hOxm34OPcyTS3fWf6bff4
         cxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692993514; x=1693598314;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7SWZIZu/vGsfuMu4tEV7kAOgiYlEzMDxZEvJL1wnXc=;
        b=jqvaRtI1gvrQ+9gXlw3vU6p6IFl6FyMzgPZIRHRkgMCy5fTbmhmkdEf1BbINnJMUjE
         3wWutmCoqpuSaRMwHzJAhML2YVdIAl8y/ZGkH5GbSOvWcTe4vf+NQauOOlPfl3IBgram
         IqKxDgHCJqEqfJFon5DHX100lpWpu0lC58DbTHYyhYc925juD4IAUoa925/vN2M1UNvX
         Wlv0NPjLUrlN+HiRZe4R4v+/swcXEPaGNmOLQSLFEd1TMB3glKEHA2Fjw6eR8IpVBQaS
         DLh4NpP+d72dVbEG+pZYr1mnhnrHVhO9eQ/RXdLlTVeZNT1sBEmYwdEyXY1TmWuKH0oA
         SBQw==
X-Gm-Message-State: AOJu0Yzpiu/oUtrBwPumO4pvABHIN59b9YO9gc/YGE3ayQTTr6/Hi1hs
        RascdyMtQ+0URwLjLTzna1MQjH2Ir4X6VkU8Mb8=
X-Google-Smtp-Source: AGHT+IGl5JEpw1OBf31oSdx28jCoO/lRV3T1701bBfL4CFP0kCtXPIIzryxy9VS08TTfwtkft1rFI0JPNHMsvx9uB6A=
X-Received: by 2002:a4a:274a:0:b0:56e:9d63:9ac5 with SMTP id
 w10-20020a4a274a000000b0056e9d639ac5mr4207793oow.2.1692993513825; Fri, 25 Aug
 2023 12:58:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1141:0:b0:4f0:1250:dd51 with HTTP; Fri, 25 Aug 2023
 12:58:33 -0700 (PDT)
In-Reply-To: <20230823170556.2281747-1-mjguzik@gmail.com>
References: <20230823170556.2281747-1-mjguzik@gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Fri, 25 Aug 2023 21:58:33 +0200
Message-ID: <CAGudoHGveDS3rjLv90eAZQjroFRTOuyVj=mG=s-Z7OKjOGkFNg@mail.gmail.com>
Subject: Re: [PATCH] mm: remove remnants of SPLIT_RSS_COUNTING
To:     akpm@linux-foundation.org
Cc:     shakeelb@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

anyone in particular I should cc to get this reviewed?

this finishes a removal from an earlier commit, there is not much to
think about ;)

On 8/23/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> The feature got retired in f1a7941243c1 ("mm: convert mm's rss stats
> into percpu_counter"), but the patch failed to fully clean it up.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/exec.c          | 2 --
>  include/linux/mm.h | 8 --------
>  kernel/exit.c      | 4 ----
>  kernel/fork.c      | 4 ----
>  kernel/kthread.c   | 1 -
>  mm/madvise.c       | 5 +----
>  mm/memory.c        | 2 --
>  7 files changed, 1 insertion(+), 25 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 1a827d55ba94..8d31d5fc658f 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -985,8 +985,6 @@ static int exec_mmap(struct mm_struct *mm)
>  	tsk = current;
>  	old_mm = current->mm;
>  	exec_mm_release(tsk, old_mm);
> -	if (old_mm)
> -		sync_mm_rss(old_mm);
>
>  	ret = down_write_killable(&tsk->signal->exec_update_lock);
>  	if (ret)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 406ab9ea818f..08402054767a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2606,14 +2606,6 @@ static inline void setmax_mm_hiwater_rss(unsigned
> long *maxrss,
>  		*maxrss = hiwater_rss;
>  }
>
> -#if defined(SPLIT_RSS_COUNTING)
> -void sync_mm_rss(struct mm_struct *mm);
> -#else
> -static inline void sync_mm_rss(struct mm_struct *mm)
> -{
> -}
> -#endif
> -
>  #ifndef CONFIG_ARCH_HAS_PTE_SPECIAL
>  static inline int pte_special(pte_t pte)
>  {
> diff --git a/kernel/exit.c b/kernel/exit.c
> index edb50b4c9972..3cdbe797008f 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -539,7 +539,6 @@ static void exit_mm(void)
>  	exit_mm_release(current, mm);
>  	if (!mm)
>  		return;
> -	sync_mm_rss(mm);
>  	mmap_read_lock(mm);
>  	mmgrab_lazy_tlb(mm);
>  	BUG_ON(mm != current->active_mm);
> @@ -829,9 +828,6 @@ void __noreturn do_exit(long code)
>  	io_uring_files_cancel();
>  	exit_signals(tsk);  /* sets PF_EXITING */
>
> -	/* sync mm's RSS info before statistics gathering */
> -	if (tsk->mm)
> -		sync_mm_rss(tsk->mm);
>  	acct_update_integrals(tsk);
>  	group_dead = atomic_dec_and_test(&tsk->signal->live);
>  	if (group_dead) {
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d2e12b6d2b18..1ac1d850f7ab 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2409,10 +2409,6 @@ __latent_entropy struct task_struct *copy_process(
>  	p->io_uring = NULL;
>  #endif
>
> -#if defined(SPLIT_RSS_COUNTING)
> -	memset(&p->rss_stat, 0, sizeof(p->rss_stat));
> -#endif
> -
>  	p->default_timer_slack_ns = current->timer_slack_ns;
>
>  #ifdef CONFIG_PSI
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 4fff7df17a68..0cf5582122b3 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1470,7 +1470,6 @@ void kthread_unuse_mm(struct mm_struct *mm)
>  	 * clearing tsk->mm.
>  	 */
>  	smp_mb__after_spinlock();
> -	sync_mm_rss(mm);
>  	local_irq_disable();
>  	tsk->mm = NULL;
>  	membarrier_update_current_mm(NULL);
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 886f06066622..39bed9e4b08b 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -741,11 +741,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned
> long addr,
>  		folio_mark_lazyfree(folio);
>  	}
>
> -	if (nr_swap) {
> -		if (current->mm == mm)
> -			sync_mm_rss(mm);
> +	if (nr_swap)
>  		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
> -	}
>  	if (start_pte) {
>  		arch_leave_lazy_mmu_mode();
>  		pte_unmap_unlock(start_pte, ptl);
> diff --git a/mm/memory.c b/mm/memory.c
> index cdc4d4c1c858..b72d90ece7fe 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -474,8 +474,6 @@ static inline void add_mm_rss_vec(struct mm_struct *mm,
> int *rss)
>  {
>  	int i;
>
> -	if (current->mm == mm)
> -		sync_mm_rss(mm);
>  	for (i = 0; i < NR_MM_COUNTERS; i++)
>  		if (rss[i])
>  			add_mm_counter(mm, i, rss[i]);
> --
> 2.39.2
>
>


-- 
Mateusz Guzik <mjguzik gmail.com>
