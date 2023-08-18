Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2777804B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357688AbjHRDck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357745AbjHRDch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:32:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31BC3C29
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:31:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6887ccba675so400592b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692329447; x=1692934247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGmVVVsqzwRWxRE6503FAnRSrIWd/bwYCLw204IJRkI=;
        b=d3KZf/LTftZ96BtzQJ7G5aMZvlBFyFZufZy8+97TTPZ51ULQXtMq7+opwQWnmmFtOB
         CkBqM+KhcVBVcBiB23aUe4zidvc6AD/hvufabpiZdT90ibSHL60mQsIRImfqeQKvOjsR
         492Q4crEEjhHyZpoSVCZFAsWNfMs8L21n1LMdPl4RV6WaextVP29f3SlrKVyXULJaUCm
         aZ9p+6uoLkT8RCnNw5EKP+DA4R9o4wgPEuEvqGSKJIJyDBWW7jXsSwOV28s8tqeDpjMb
         vhNEJpoRCceWDokCh+/7SllUK+aHLUZ5SsaJob7b5o1EkKjz6XGeDFuz1OsI9vEHOEUQ
         IJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692329447; x=1692934247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SGmVVVsqzwRWxRE6503FAnRSrIWd/bwYCLw204IJRkI=;
        b=DNGytlqMjYWSOJ0B9vUQduMn/AbV2t86rAg30+qNkuEqA7ZFuv73YaXZN7ZAHFFn9B
         5TGZ4Ur9nphDyMT/4yNpsPTLCxRAoYUUiZF2BBLl9VfZqcGzyuTQF1ApyVAL96uAIvpN
         YBqdXyHaRUnEu5+tRqlMAGwReR7a18h8j6Zc1icOf7SAHjhal59xca6iXZjeASFaS3Qh
         5GPLJejNVL3QaIaMuZ0ZqqcpAAHtBf/yiCTt9SkEIpDjJXHSb8SUwR/P15HkAJi1P6by
         UohKn6QeVzKaJJ1cYk1NnNwH8a/t0yKPJScunqjs0qRbla/wp8CuHQVJzJPNaBcJZ9yO
         IihQ==
X-Gm-Message-State: AOJu0YwDSI+sK4OkCuSIS5e5nHeRjhhkRMwcBv7e3cpbF2cZzcnHqZ8M
        hRenRKg6VvS+Dsop2nsWE+SkFg==
X-Google-Smtp-Source: AGHT+IFjvYdd1gHzy3Dm/9XxgsdE9J5GYxTWj/2+yaApFf7YiPL2XuxffQUZO/c7Y93aoEgllYbq4A==
X-Received: by 2002:a05:6a00:812:b0:687:5415:7282 with SMTP id m18-20020a056a00081200b0068754157282mr1520138pfk.23.1692329447618;
        Thu, 17 Aug 2023 20:30:47 -0700 (PDT)
Received: from [10.255.89.48] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id a21-20020aa780d5000000b00689f10adef9sm495696pfn.67.2023.08.17.20.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 20:30:47 -0700 (PDT)
Message-ID: <a24fc514-38dd-c4bb-322f-08a6f46767f4@bytedance.com>
Date:   Fri, 18 Aug 2023 11:30:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 1/5] mm, oom: Introduce bpf_oom_evaluate_task
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Muchun Song <muchun.song@linux.dev>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, wuyun.abel@bytedance.com,
        robin.lu@bytedance.com, Michal Hocko <mhocko@suse.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-2-zhouchuyi@bytedance.com>
 <CAADnVQK=7NWbRtJyRJAqy5JwZHRB7s7hCNeGqixjLa4vB609XQ@mail.gmail.com>
 <93627e45-dc67-fd31-ef43-a93f580b0d6e@bytedance.com>
 <CAADnVQKThM=vL7qpR05Ky6ReDrtuUxz_0SEZ+Bsc+E4=_A_u+g@mail.gmail.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQKThM=vL7qpR05Ky6ReDrtuUxz_0SEZ+Bsc+E4=_A_u+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
在 2023/8/17 11:22, Alexei Starovoitov 写道:
> On Wed, Aug 16, 2023 at 7:51 PM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> Hello,
>>
>> 在 2023/8/17 10:07, Alexei Starovoitov 写道:
>>> On Thu, Aug 10, 2023 at 1:13 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>>>    static int oom_evaluate_task(struct task_struct *task, void *arg)
>>>>    {
>>>>           struct oom_control *oc = arg;
>>>> @@ -317,6 +339,26 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
>>>>           if (!is_memcg_oom(oc) && !oom_cpuset_eligible(task, oc))
>>>>                   goto next;
>>>>
>>>> +       /*
>>>> +        * If task is allocating a lot of memory and has been marked to be
>>>> +        * killed first if it triggers an oom, then select it.
>>>> +        */
>>>> +       if (oom_task_origin(task)) {
>>>> +               points = LONG_MAX;
>>>> +               goto select;
>>>> +       }
>>>> +
>>>> +       switch (bpf_oom_evaluate_task(task, oc)) {
>>>> +       case BPF_EVAL_ABORT:
>>>> +               goto abort; /* abort search process */
>>>> +       case BPF_EVAL_NEXT:
>>>> +               goto next; /* ignore the task */
>>>> +       case BPF_EVAL_SELECT:
>>>> +               goto select; /* select the task */
>>>> +       default:
>>>> +               break; /* No BPF policy */
>>>> +       }
>>>> +
>>>
>>> I think forcing bpf prog to look at every task is going to be limiting
>>> long term.
>>> It's more flexible to invoke bpf prog from out_of_memory()
>>> and if it doesn't choose a task then fallback to select_bad_process().
>>> I believe that's what Roman was proposing.
>>> bpf can choose to iterate memcg or it might have some side knowledge
>>> that there are processes that can be set as oc->chosen right away,
>>> so it can skip the iteration.
>>
>> IIUC, We may need some new bpf features if we want to iterating
>> tasks/memcg in BPF, sush as:
>> bpf_for_each_task
>> bpf_for_each_memcg
>> bpf_for_each_task_in_memcg
>> ...
>>
>> It seems we have some work to do first in the BPF side.
>> Will these iterating features be useful in other BPF scenario except OOM
>> Policy?
> 
> Yes.
> Use open coded iterators though.
> Like example in
> https://lore.kernel.org/all/20230810183513.684836-4-davemarchevsky@fb.com/
> 
> bpf_for_each(task_vma, vma, task, 0) { ... }
> will safely iterate vma-s of the task.
> Similarly struct css_task_iter can be hidden inside bpf open coded iterator.
OK. I think the following APIs whould be useful and I am willing to 
start with these in another bpf-next RFC patchset:

1. bpf_for_each(task). Just like for_each_process(p) in kernel to 
itearing all tasks in the system with rcu_read_lock().

2. bpf_for_each(css_task, task, css). It works like 
css_task_iter_{start, next, end} and would be used to iterating 
tasks/threads under a css.

3. bpf_for_each(descendant_css, css, root_css, {PRE, POST}). It works 
like css_next_descendant_{pre, post} to iterating all descendant.

If you have better ideas or any advice, please let me know.
Thanks.
