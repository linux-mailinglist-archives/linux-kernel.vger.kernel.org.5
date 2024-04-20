Return-Path: <linux-kernel+bounces-152104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121908AB92C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C12F1C20A97
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B7D8BEE;
	Sat, 20 Apr 2024 03:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlsWjBRt"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED46FB0
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 03:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713582813; cv=none; b=PgihnkfKueAIMVqHMIYZ/Unz3CXs7s6pBZUqw5/BnbtzZYm4fXxi+i90Z08pXxCaBFIQLV22J74CZwz1FJaU8astuUSfRAHEZAbidhDRzvY2j2oAwx46zgdNsfpmNv2j8TcfUMtulHCKghyeU0lgNTLnq2k9ALuux9fJqTrocP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713582813; c=relaxed/simple;
	bh=/dpma4zWRYaPxmptTn0LTEKFigYY6gjF9EOVz6vu4QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWhfZM7bN+fJJ10CsYegeo/iOZQjaOvgIoUkBWqf8FYUM5HB6pgosiaoIzuNDFgQL76J1+gi4hQMGR5gVxiapGLaTA9OBgYZZJElKqDScjshCZfZ1bDZh3Og5X0wnzgvJYy+VrMvzEv4udFq49wwqJLFhlk8aAwiVWf+cOw/Gus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlsWjBRt; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so1858131a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 20:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713582811; x=1714187611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/9y/VC3Dc30/RVanrfc5AQFNBCU94aBu39DJHj/ztg=;
        b=UlsWjBRt53eVs5nPJzbzO+h/gQETvDC/N5r0w/NZ9CQ1noaz4+twS84DCBFsUfpJHz
         NHfzm8EeRRkYuIGsKlvalE4OhQBw00dBT2f6NoXZ7KQP8VxiYTyZ28SQcMJIS/ngxagc
         SBDUlqPsK/BPxL7VNore6OuQy7GuXfPaxKZB4vuR3iVwJxu0Xt6r826bbT/qFpYmoIsn
         xpfIxfq7qhWduEKPk8gVWjeYWGMwgErSa3zAhNq6yiMqan4xuVPM4/VD0hjQ9QaI+b9Q
         Tspo5OKBuOAFiE5BVpQExtfKY/94EjZr/dd48Bw64BZWiKHsDU75BGiiZ928G474gDVK
         HIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713582811; x=1714187611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H/9y/VC3Dc30/RVanrfc5AQFNBCU94aBu39DJHj/ztg=;
        b=EIO/lJTZyEiUVLopCMV8ZjcrwWk8SeTd85UgynsPX2ojf3PR/IVDEbGXR0s7K23npj
         sBP90iuOLqifqtQ/jDtrSCQitWwNAM3IBKL3xxKMNEY6cVKzbeBIqPgQrwfrwEP9FTWr
         pDJIEN5aUy08d8F9vm7lGj87DlMHFoPVLhI3nEzRq4gxKuTXBcwNYp7w0x1nTO1zRWkV
         e5zwCRR17RhLPB2W8mfwDWGCxgmTkFbH5s9FEBsQyQdfqioeN2JWqpgFD7EkmIwhLzT2
         3Y+iM4rzLlmuIrFM10eLXUO5+d0tlVqusBfj8GJ/OnM/8jGzpaTmAuv6Un44+wLX2144
         nRVw==
X-Forwarded-Encrypted: i=1; AJvYcCUwfkTSuA+5MLcT618FTX6YVqyVOqaLGOqt0H/NosVrHD3dHRsaAs9snuEuP4Z4VbyctlyCECt08ou5eybLawyf1r8FF200xlSR5Lfw
X-Gm-Message-State: AOJu0YyhYDaaBfH3NFN6w0ygMOqKLmc1XFLIl8hZtnnDK9vprZm+PI8N
	jr5Udh98WZI+LxANDhekw00NC09x7VqtJb/5agRQH/csVc6xC8yD
X-Google-Smtp-Source: AGHT+IE1ytvOp+FFdm1hhpZfFSXMC9hQ10r+tkTweJ86bG3b16fC587eKptWDDJegFa/ZwAzsGclyw==
X-Received: by 2002:a17:903:244e:b0:1e4:3dd0:8ce0 with SMTP id l14-20020a170903244e00b001e43dd08ce0mr4927396pls.20.1713582810536;
        Fri, 19 Apr 2024 20:13:30 -0700 (PDT)
Received: from [192.168.255.10] ([115.171.244.168])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902b21400b001e3e081dea1sm4104671plr.0.2024.04.19.20.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 20:13:30 -0700 (PDT)
Message-ID: <6a3b8095-8f49-47e0-a347-9e4a51806bf8@gmail.com>
Date: Sat, 20 Apr 2024 11:13:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/2] mm: convert mm's rss stats to use atomic mode
To: "zhangpeng (AS)" <zhangpeng362@huawei.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, dennisszhou@gmail.com, shakeelb@google.com,
 jack@suse.cz, surenb@google.com, kent.overstreet@linux.dev, mhocko@suse.cz,
 vbabka@suse.cz, yuzhao@google.com, yu.ma@intel.com,
 wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
 <20240418142008.2775308-3-zhangpeng362@huawei.com>
 <ec2b110b-fb85-4af2-942b-645511a32297@gmail.com>
 <c1c79eb5-4d48-40e5-6f17-f8bc42f2d274@huawei.com>
From: Rongwei Wang <rongwei.wrw@gmail.com>
In-Reply-To: <c1c79eb5-4d48-40e5-6f17-f8bc42f2d274@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/19 11:32, zhangpeng (AS) wrote:
> On 2024/4/19 10:30, Rongwei Wang wrote:
>
>> On 2024/4/18 22:20, Peng Zhang wrote:
>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>
>>> Since commit f1a7941243c1 ("mm: convert mm's rss stats into
>>> percpu_counter"), the rss_stats have converted into percpu_counter,
>>> which convert the error margin from (nr_threads * 64) to approximately
>>> (nr_cpus ^ 2). However, the new percpu allocation in mm_init() causes a
>>> performance regression on fork/exec/shell. Even after commit 
>>> 14ef95be6f55
>>> ("kernel/fork: group allocation/free of per-cpu counters for mm 
>>> struct"),
>>> the performance of fork/exec/shell is still poor compared to previous
>>> kernel versions.
>>>
>>> To mitigate performance regression, we delay the allocation of percpu
>>> memory for rss_stats. Therefore, we convert mm's rss stats to use
>>> percpu_counter atomic mode. For single-thread processes, rss_stat is in
>>> atomic mode, which reduces the memory consumption and performance
>>> regression caused by using percpu. For multiple-thread processes,
>>> rss_stat is switched to the percpu mode to reduce the error margin.
>>> We convert rss_stats from atomic mode to percpu mode only when the
>>> second thread is created.
>> Hi, Zhang Peng
>>
>> This regression we also found it in lmbench these days. I have not 
>> test your patch, but it seems will solve a lot for it.
>> And I see this patch not fix the regression in multi-threads, that's 
>> because of the rss_stat switched to percpu mode?
>> (If I'm wrong, please correct me.) And It seems percpu_counter also 
>> has a bad effect in exit_mmap().
>>
>> If so, I'm wondering if we can further improving it on the 
>> exit_mmap() path in multi-threads scenario, e.g. to determine which 
>> CPUs the process has run on (mm_cpumask()? I'm not sure).
>>
> Hi, Rongwei,
>
> Yes, this patch only fixes the regression in single-thread processes. How
> much bad effect does percpu_counter have in exit_mmap()? IMHO, the 
> addition
Actually, I not sure, just found a little free percpu hotspot in 
exit_mmap() path when comparing 4 core vs 32 cores.

I can test more next.
> of mm counter is already in batch mode, maybe I miss something?
>
>>>
>>> After lmbench test, we can get 2% ~ 4% performance improvement
>>> for lmbench fork_proc/exec_proc/shell_proc and 6.7% performance
>>> improvement for lmbench page_fault (before batch mode[1]).
>>>
>>> The test results are as follows:
>>>
>>>               base           base+revert        base+this patch
>>>
>>> fork_proc    416.3ms        400.0ms  (3.9%)    398.6ms  (4.2%)
>>> exec_proc    2095.9ms       2061.1ms (1.7%)    2047.7ms (2.3%)
>>> shell_proc   3028.2ms       2954.7ms (2.4%)    2961.2ms (2.2%)
>>> page_fault   0.3603ms       0.3358ms (6.8%)    0.3361ms (6.7%)
>> I think the regression will becomes more obvious if more cores. How 
>> about your test machine?
>>
> Maybe multi-core is not a factor in the performance of the lmbench 
> test here.
> Both of my test machines have 96 cores.
>
>> Thanks,
>> -wrw
>>>
>>> [1] 
>>> https://lore.kernel.org/all/20240412064751.119015-1-wangkefeng.wang@huawei.com/
>>>
>>> Suggested-by: Jan Kara <jack@suse.cz>
>>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>   include/linux/mm.h          | 50 
>>> +++++++++++++++++++++++++++++++------
>>>   include/trace/events/kmem.h |  4 +--
>>>   kernel/fork.c               | 18 +++++++------
>>>   3 files changed, 56 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index d261e45bb29b..8f1bfbd54697 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -2631,30 +2631,66 @@ static inline bool 
>>> get_user_page_fast_only(unsigned long addr,
>>>    */
>>>   static inline unsigned long get_mm_counter(struct mm_struct *mm, 
>>> int member)
>>>   {
>>> -    return percpu_counter_read_positive(&mm->rss_stat[member]);
>>> +    struct percpu_counter *fbc = &mm->rss_stat[member];
>>> +
>>> +    if (percpu_counter_initialized(fbc))
>>> +        return percpu_counter_read_positive(fbc);
>>> +
>>> +    return percpu_counter_atomic_read(fbc);
>>>   }
>>>     void mm_trace_rss_stat(struct mm_struct *mm, int member);
>>>     static inline void add_mm_counter(struct mm_struct *mm, int 
>>> member, long value)
>>>   {
>>> -    percpu_counter_add(&mm->rss_stat[member], value);
>>> +    struct percpu_counter *fbc = &mm->rss_stat[member];
>>> +
>>> +    if (percpu_counter_initialized(fbc))
>>> +        percpu_counter_add(fbc, value);
>>> +    else
>>> +        percpu_counter_atomic_add(fbc, value);
>>>         mm_trace_rss_stat(mm, member);
>>>   }
>>>     static inline void inc_mm_counter(struct mm_struct *mm, int member)
>>>   {
>>> -    percpu_counter_inc(&mm->rss_stat[member]);
>>> -
>>> -    mm_trace_rss_stat(mm, member);
>>> +    add_mm_counter(mm, member, 1);
>>>   }
>>>     static inline void dec_mm_counter(struct mm_struct *mm, int member)
>>>   {
>>> -    percpu_counter_dec(&mm->rss_stat[member]);
>>> +    add_mm_counter(mm, member, -1);
>>> +}
>>>   -    mm_trace_rss_stat(mm, member);
>>> +static inline s64 mm_counter_sum(struct mm_struct *mm, int member)
>>> +{
>>> +    struct percpu_counter *fbc = &mm->rss_stat[member];
>>> +
>>> +    if (percpu_counter_initialized(fbc))
>>> +        return percpu_counter_sum(fbc);
>>> +
>>> +    return percpu_counter_atomic_read(fbc);
>>> +}
>>> +
>>> +static inline s64 mm_counter_sum_positive(struct mm_struct *mm, int 
>>> member)
>>> +{
>>> +    struct percpu_counter *fbc = &mm->rss_stat[member];
>>> +
>>> +    if (percpu_counter_initialized(fbc))
>>> +        return percpu_counter_sum_positive(fbc);
>>> +
>>> +    return percpu_counter_atomic_read(fbc);
>>> +}
>>> +
>>> +static inline int mm_counter_switch_to_pcpu_many(struct mm_struct *mm)
>>> +{
>>> +    return percpu_counter_switch_to_pcpu_many(mm->rss_stat, 
>>> NR_MM_COUNTERS);
>>> +}
>>> +
>>> +static inline void mm_counter_destroy_many(struct mm_struct *mm)
>>> +{
>>> +    percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
>>>   }
>>>     /* Optimized variant when folio is already known not to be anon */
>>> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
>>> index 6e62cc64cd92..a4e40ae6a8c8 100644
>>> --- a/include/trace/events/kmem.h
>>> +++ b/include/trace/events/kmem.h
>>> @@ -399,8 +399,8 @@ TRACE_EVENT(rss_stat,
>>>           __entry->mm_id = mm_ptr_to_hash(mm);
>>>           __entry->curr = !!(current->mm == mm);
>>>           __entry->member = member;
>>> -        __entry->size = 
>>> (percpu_counter_sum_positive(&mm->rss_stat[member])
>>> -                                << PAGE_SHIFT);
>>> +        __entry->size = (mm_counter_sum_positive(mm, member)
>>> +                            << PAGE_SHIFT);
>>>       ),
>>>         TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
>>> diff --git a/kernel/fork.c b/kernel/fork.c
>>> index 99076dbe27d8..0214273798c5 100644
>>> --- a/kernel/fork.c
>>> +++ b/kernel/fork.c
>>> @@ -823,7 +823,7 @@ static void check_mm(struct mm_struct *mm)
>>>                "Please make sure 'struct resident_page_types[]' is 
>>> updated as well");
>>>         for (i = 0; i < NR_MM_COUNTERS; i++) {
>>> -        long x = percpu_counter_sum(&mm->rss_stat[i]);
>>> +        long x = mm_counter_sum(mm, i);
>>>             if (unlikely(x))
>>>               pr_alert("BUG: Bad rss-counter state mm:%p type:%s 
>>> val:%ld\n",
>>> @@ -1301,16 +1301,10 @@ static struct mm_struct *mm_init(struct 
>>> mm_struct *mm, struct task_struct *p,
>>>       if (mm_alloc_cid(mm))
>>>           goto fail_cid;
>>>   -    if (percpu_counter_init_many(mm->rss_stat, 0, 
>>> GFP_KERNEL_ACCOUNT,
>>> -                     NR_MM_COUNTERS))
>>> -        goto fail_pcpu;
>>> -
>>>       mm->user_ns = get_user_ns(user_ns);
>>>       lru_gen_init_mm(mm);
>>>       return mm;
>>>   -fail_pcpu:
>>> -    mm_destroy_cid(mm);
>>>   fail_cid:
>>>       destroy_context(mm);
>>>   fail_nocontext:
>>> @@ -1730,6 +1724,16 @@ static int copy_mm(unsigned long clone_flags, 
>>> struct task_struct *tsk)
>>>       if (!oldmm)
>>>           return 0;
>>>   +    /*
>>> +     * For single-thread processes, rss_stat is in atomic mode, which
>>> +     * reduces the memory consumption and performance regression 
>>> caused by
>>> +     * using percpu. For multiple-thread processes, rss_stat is 
>>> switched to
>>> +     * the percpu mode to reduce the error margin.
>>> +     */
>>> +    if (clone_flags & CLONE_THREAD)
>>> +        if (mm_counter_switch_to_pcpu_many(oldmm))
>>> +            return -ENOMEM;
>>> +
>>>       if (clone_flags & CLONE_VM) {
>>>           mmget(oldmm);
>>>           mm = oldmm;
>>
>>


