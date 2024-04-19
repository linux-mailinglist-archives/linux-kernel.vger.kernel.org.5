Return-Path: <linux-kernel+bounces-150941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AA68AA6F5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11AE1F22066
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87EA4C85;
	Fri, 19 Apr 2024 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPQnPiqG"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E438D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713493831; cv=none; b=aG2VvsaJHBKChy1H5ivwQmW0SnWb5tDKCLz+fsMi/oFrM9njkGToxdqLLh3/ZoGLs58ZTyQ1gLlgN6LNoDW3rVaW4yXM/4UKUEjVowZS6a2wtH/KGIVhmnFVaSQd33fS4Jk06HH72mIJp8QAVeiWsLGXq/UW9cYbdppwyPtbBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713493831; c=relaxed/simple;
	bh=Am84cdqWSckmqHURuFlza9spRPGOczepohza8PmEVUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPYhzUiu9Bm7FlMT/3As+/ugykwrb31l+GZJVngUbzIgLIrrRevDWwp7lIpPMPTM53oK1lNTdHSg5erGVn8FZqu+9FW6XelorvdYtwNGjuRo9DjUbJlzLr3jxvBM0AI3aLxYRp3rXUzcCTb+q6dD/1d2mI/dy/DRx8lJvtAM/Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPQnPiqG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e65b29f703so13170595ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 19:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713493829; x=1714098629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqzqLAXxjHizAsgJ8y+IU6jvWunvLzLPi/Caa0cG/nw=;
        b=jPQnPiqG1oSkDK+r9a8cDETT5RRCUkq5ZYzYGqbmlU6egsD92JbipSynj29qS8Iuj+
         Vfb/TAjcz+qdSNVyeQiJjovKCtRmPDEu6MxfbQiLF8dbKdUDWb3SSuUovFZ1b9IXeDt1
         r6YssUuFjxvR8bpj/BDXTrALM2oz10N1AuvtVmMAtu6g48/pdGK3knydEFWYXJA1MhUd
         1wW0aiQltuwV52A5yRGbRBAJewYN6Sq+j79V4Vfm8JjXe1OSONs54i3YadLdFlqnAz35
         M+VpF4TG3qqL4occKZsfqmBYzGYsPKgMl7yaJI5hS/mDjkQ4iAS00/VIRtSNPQkFvwy0
         yJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713493829; x=1714098629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OqzqLAXxjHizAsgJ8y+IU6jvWunvLzLPi/Caa0cG/nw=;
        b=O6RDlRueo6zqE3nWChMI2GxPUsrGFSfPe3SmWsjBGZLKITmC0qc4q8N+jVctfSatnh
         LDS4XILOr6A4Odo3cqItxkN6mSWgGIH9KIpSHOEnYFdbvguKk+6ZyY3GCW4wVPS5r3oN
         Sh/tmZG6BG4DVlIrOMRjC7UZB10aH2Zhdv+UU+ed5ym1CEKdcnZQmZrBjmcdR1qZowR8
         9Esf2Y1XhHmxAOPJbcPvn7LlZJ4iy+UDVsEHOVnZmGNrn3CM3A85CFJMpt95ZGx/K5rq
         dMz6uGRGD5GtWYl46HZTDX9IOdP0HRYIwkdJtLVfT7A3JF3uzEhqjndPG/1hEifjdA7V
         9Jzg==
X-Forwarded-Encrypted: i=1; AJvYcCVfEKyxxLptmo0k82IUYEvag7XccQQ7XgRncfuqrxMfFPr3pKUUVwUViMQ0z3DmJV7w7GKg0LEijoO+LPWrxqEmh9Im/NjyF8vSF5hk
X-Gm-Message-State: AOJu0Yw6gNxxCDaEJrukHa63WGxGrBBNFzV2LR22gAsahuihOzYYkBIQ
	+3w6fO+7xCLJ9Rok1GUakcFWtpXqTW95mwQXjCksqevxkwM7gHV0
X-Google-Smtp-Source: AGHT+IEh3AxD9eCXwyzOo2QAfwekki2w8N44Hzo9DD9m6GmzMpcAsoKGxurQ2ONhYxx0b+cmPqN60w==
X-Received: by 2002:a17:902:7617:b0:1e2:bf94:487 with SMTP id k23-20020a170902761700b001e2bf940487mr761197pll.57.1713493829422;
        Thu, 18 Apr 2024 19:30:29 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b001e3cfb853a2sm2222893plr.183.2024.04.18.19.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 19:30:29 -0700 (PDT)
Message-ID: <ec2b110b-fb85-4af2-942b-645511a32297@gmail.com>
Date: Fri, 19 Apr 2024 10:30:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] mm: convert mm's rss stats to use atomic mode
To: Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, dennisszhou@gmail.com, shakeelb@google.com,
 jack@suse.cz, surenb@google.com, kent.overstreet@linux.dev, mhocko@suse.cz,
 vbabka@suse.cz, yuzhao@google.com, yu.ma@intel.com,
 wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
 <20240418142008.2775308-3-zhangpeng362@huawei.com>
From: Rongwei Wang <rongwei.wrw@gmail.com>
In-Reply-To: <20240418142008.2775308-3-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/18 22:20, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
>
> Since commit f1a7941243c1 ("mm: convert mm's rss stats into
> percpu_counter"), the rss_stats have converted into percpu_counter,
> which convert the error margin from (nr_threads * 64) to approximately
> (nr_cpus ^ 2). However, the new percpu allocation in mm_init() causes a
> performance regression on fork/exec/shell. Even after commit 14ef95be6f55
> ("kernel/fork: group allocation/free of per-cpu counters for mm struct"),
> the performance of fork/exec/shell is still poor compared to previous
> kernel versions.
>
> To mitigate performance regression, we delay the allocation of percpu
> memory for rss_stats. Therefore, we convert mm's rss stats to use
> percpu_counter atomic mode. For single-thread processes, rss_stat is in
> atomic mode, which reduces the memory consumption and performance
> regression caused by using percpu. For multiple-thread processes,
> rss_stat is switched to the percpu mode to reduce the error margin.
> We convert rss_stats from atomic mode to percpu mode only when the
> second thread is created.
Hi, Zhang Peng

This regression we also found it in lmbench these days. I have not test 
your patch, but it seems will solve a lot for it.
And I see this patch not fix the regression in multi-threads, that's 
because of the rss_stat switched to percpu mode?
(If I'm wrong, please correct me.) And It seems percpu_counter also has 
a bad effect in exit_mmap().

If so, I'm wondering if we can further improving it on the exit_mmap() 
path in multi-threads scenario, e.g. to determine which CPUs the process 
has run on (mm_cpumask()? I'm not sure).

>
> After lmbench test, we can get 2% ~ 4% performance improvement
> for lmbench fork_proc/exec_proc/shell_proc and 6.7% performance
> improvement for lmbench page_fault (before batch mode[1]).
>
> The test results are as follows:
>
>               base           base+revert        base+this patch
>
> fork_proc    416.3ms        400.0ms  (3.9%)    398.6ms  (4.2%)
> exec_proc    2095.9ms       2061.1ms (1.7%)    2047.7ms (2.3%)
> shell_proc   3028.2ms       2954.7ms (2.4%)    2961.2ms (2.2%)
> page_fault   0.3603ms       0.3358ms (6.8%)    0.3361ms (6.7%)
I think the regression will becomes more obvious if more cores. How 
about your test machine?

Thanks,
-wrw
>
> [1] https://lore.kernel.org/all/20240412064751.119015-1-wangkefeng.wang@huawei.com/
>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   include/linux/mm.h          | 50 +++++++++++++++++++++++++++++++------
>   include/trace/events/kmem.h |  4 +--
>   kernel/fork.c               | 18 +++++++------
>   3 files changed, 56 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d261e45bb29b..8f1bfbd54697 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2631,30 +2631,66 @@ static inline bool get_user_page_fast_only(unsigned long addr,
>    */
>   static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
>   {
> -	return percpu_counter_read_positive(&mm->rss_stat[member]);
> +	struct percpu_counter *fbc = &mm->rss_stat[member];
> +
> +	if (percpu_counter_initialized(fbc))
> +		return percpu_counter_read_positive(fbc);
> +
> +	return percpu_counter_atomic_read(fbc);
>   }
>   
>   void mm_trace_rss_stat(struct mm_struct *mm, int member);
>   
>   static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
>   {
> -	percpu_counter_add(&mm->rss_stat[member], value);
> +	struct percpu_counter *fbc = &mm->rss_stat[member];
> +
> +	if (percpu_counter_initialized(fbc))
> +		percpu_counter_add(fbc, value);
> +	else
> +		percpu_counter_atomic_add(fbc, value);
>   
>   	mm_trace_rss_stat(mm, member);
>   }
>   
>   static inline void inc_mm_counter(struct mm_struct *mm, int member)
>   {
> -	percpu_counter_inc(&mm->rss_stat[member]);
> -
> -	mm_trace_rss_stat(mm, member);
> +	add_mm_counter(mm, member, 1);
>   }
>   
>   static inline void dec_mm_counter(struct mm_struct *mm, int member)
>   {
> -	percpu_counter_dec(&mm->rss_stat[member]);
> +	add_mm_counter(mm, member, -1);
> +}
>   
> -	mm_trace_rss_stat(mm, member);
> +static inline s64 mm_counter_sum(struct mm_struct *mm, int member)
> +{
> +	struct percpu_counter *fbc = &mm->rss_stat[member];
> +
> +	if (percpu_counter_initialized(fbc))
> +		return percpu_counter_sum(fbc);
> +
> +	return percpu_counter_atomic_read(fbc);
> +}
> +
> +static inline s64 mm_counter_sum_positive(struct mm_struct *mm, int member)
> +{
> +	struct percpu_counter *fbc = &mm->rss_stat[member];
> +
> +	if (percpu_counter_initialized(fbc))
> +		return percpu_counter_sum_positive(fbc);
> +
> +	return percpu_counter_atomic_read(fbc);
> +}
> +
> +static inline int mm_counter_switch_to_pcpu_many(struct mm_struct *mm)
> +{
> +	return percpu_counter_switch_to_pcpu_many(mm->rss_stat, NR_MM_COUNTERS);
> +}
> +
> +static inline void mm_counter_destroy_many(struct mm_struct *mm)
> +{
> +	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
>   }
>   
>   /* Optimized variant when folio is already known not to be anon */
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index 6e62cc64cd92..a4e40ae6a8c8 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -399,8 +399,8 @@ TRACE_EVENT(rss_stat,
>   		__entry->mm_id = mm_ptr_to_hash(mm);
>   		__entry->curr = !!(current->mm == mm);
>   		__entry->member = member;
> -		__entry->size = (percpu_counter_sum_positive(&mm->rss_stat[member])
> -							    << PAGE_SHIFT);
> +		__entry->size = (mm_counter_sum_positive(mm, member)
> +							<< PAGE_SHIFT);
>   	),
>   
>   	TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 99076dbe27d8..0214273798c5 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -823,7 +823,7 @@ static void check_mm(struct mm_struct *mm)
>   			 "Please make sure 'struct resident_page_types[]' is updated as well");
>   
>   	for (i = 0; i < NR_MM_COUNTERS; i++) {
> -		long x = percpu_counter_sum(&mm->rss_stat[i]);
> +		long x = mm_counter_sum(mm, i);
>   
>   		if (unlikely(x))
>   			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
> @@ -1301,16 +1301,10 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>   	if (mm_alloc_cid(mm))
>   		goto fail_cid;
>   
> -	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT,
> -				     NR_MM_COUNTERS))
> -		goto fail_pcpu;
> -
>   	mm->user_ns = get_user_ns(user_ns);
>   	lru_gen_init_mm(mm);
>   	return mm;
>   
> -fail_pcpu:
> -	mm_destroy_cid(mm);
>   fail_cid:
>   	destroy_context(mm);
>   fail_nocontext:
> @@ -1730,6 +1724,16 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
>   	if (!oldmm)
>   		return 0;
>   
> +	/*
> +	 * For single-thread processes, rss_stat is in atomic mode, which
> +	 * reduces the memory consumption and performance regression caused by
> +	 * using percpu. For multiple-thread processes, rss_stat is switched to
> +	 * the percpu mode to reduce the error margin.
> +	 */
> +	if (clone_flags & CLONE_THREAD)
> +		if (mm_counter_switch_to_pcpu_many(oldmm))
> +			return -ENOMEM;
> +
>   	if (clone_flags & CLONE_VM) {
>   		mmget(oldmm);
>   		mm = oldmm;


