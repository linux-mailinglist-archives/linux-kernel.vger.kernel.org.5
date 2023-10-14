Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CEB7C9243
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 04:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjJNCCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 22:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJNCCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 22:02:46 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB5EA9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 19:02:22 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6c4b9e09521so1743086a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 19:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697248941; x=1697853741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/9xntF7NQRktEnNlVPSxsX7DcTtnPDN6Z3uDy3X8cE=;
        b=DFL/VHgvrQ4PiggesiTKDsuK6Jwi80IRZqducJxABmbgITk978iRwALCriswU00GrY
         IUm4R1Keo42KktBqBCgyuh51q+QUePUFqonEQBmfEqVnZ6K79SkVgt02R0YrRCdR5Bks
         wzmz3jffaUrEVzjQTgLnNbeJXR8CRhrhEYC+REEoSABo4Gk8QwJm/JRGm3xRzFg5adMA
         Dmui0/tMFaBN03GZLbrvep+Wub5AGZ+b4/LFSVK0FxKgq+5PRzejRhTK0RgonM6jAazz
         iABQdY1KlGQZHjrtetLGtCD/ws/CGAiFAtEPyLd1Adsa3pPyhG9PtInM4C+KtPQabJvp
         HDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697248941; x=1697853741;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z/9xntF7NQRktEnNlVPSxsX7DcTtnPDN6Z3uDy3X8cE=;
        b=hktXB9OVWhqHPYhDv2WN1IOUKFgk1+mW+9qQxO1mphkIVurbtmwd9jNmECIDyzLYzT
         Y22gW0VUjJckfqKWQ9S5c9S3v+J5nQvD3KrXPS3045fq5SuL0iBTbjw/5butKWGDdOGx
         AjqUNFMdqOWxDDxPEPd1PC/KFdYqKcFrQLEQFdRn/pGqVTaSo8wL6Tupbsn8cWayhqD0
         ADbSzJ3jlB4Y4DVNFLA4DC7aZa1yioHCG/0IA2Dlg74Hv6wh7giMvugRUgAsYyOeodPd
         42VOKobi84Egg0BV0e/swTtNSKsXzOwDpfdjqi9aSqlwnb99wkjYNeA9ccyP63i4Plz/
         HDVw==
X-Gm-Message-State: AOJu0YxENWzZZZ3pG01tBLb8KydXMlegqbfgQRn+oL/Kq3NxjLS88Ck0
        g1aARM5QqNMloOKUxG4ao9bQIQ==
X-Google-Smtp-Source: AGHT+IEm5UCdDnQTxK8hT2J1CXog9kh0EJ4tm1rti9OlHhOv12C/m3o1L00p8P5OCXJIeJG91EO6Hg==
X-Received: by 2002:a05:6870:3329:b0:1e1:3ac9:bc14 with SMTP id x41-20020a056870332900b001e13ac9bc14mr33507553oae.30.1697248941197;
        Fri, 13 Oct 2023 19:02:21 -0700 (PDT)
Received: from [10.4.221.75] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id p15-20020a63950f000000b0057825bd3448sm3951690pgd.51.2023.10.13.19.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 19:02:20 -0700 (PDT)
Message-ID: <0dc492a8-7fc8-4cb4-a770-95906b1f311f@bytedance.com>
Date:   Sat, 14 Oct 2023 10:02:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/8] bpf: Introduce task open coded iterator
 kfuncs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
References: <20231011120857.251943-1-zhouchuyi@bytedance.com>
 <20231011120857.251943-4-zhouchuyi@bytedance.com>
 <CAEf4BzYGZiTUHPkjuF81vWZWPH-x4rxz1s9+T0rh-dsrO5ZwDg@mail.gmail.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAEf4BzYGZiTUHPkjuF81vWZWPH-x4rxz1s9+T0rh-dsrO5ZwDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

在 2023/10/14 05:27, Andrii Nakryiko 写道:
> On Wed, Oct 11, 2023 at 5:09 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> This patch adds kfuncs bpf_iter_task_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_task in open-coded iterator
>> style. BPF programs can use these kfuncs or through bpf_for_each macro to
>> iterate all processes in the system.
>>
>> The API design keep consistent with SEC("iter/task"). bpf_iter_task_new()
>> accepts a specific task and iterating type which allows:
>>
>> 1. iterating all process in the system(BPF_TASK_ITER_ALL_PROCS)
>>
>> 2. iterating all threads in the system(BPF_TASK_ITER_ALL_THREADS)
>>
>> 3. iterating all threads of a specific task(BPF_TASK_ITER_PROC_THREADS)
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   kernel/bpf/helpers.c                          |  3 +
>>   kernel/bpf/task_iter.c                        | 82 +++++++++++++++++++
>>   .../testing/selftests/bpf/bpf_experimental.h  |  5 ++
>>   3 files changed, 90 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index cb24c4a916df..690763751f6e 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2555,6 +2555,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
>> +BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
>> +BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index 2cfcb4dd8a37..caeddad3d2f1 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -856,6 +856,88 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
>>          bpf_mem_free(&bpf_global_ma, kit->css_it);
>>   }
>>
>> +struct bpf_iter_task {
>> +       __u64 __opaque[3];
>> +} __attribute__((aligned(8)));
>> +
>> +struct bpf_iter_task_kern {
>> +       struct task_struct *task;
>> +       struct task_struct *pos;
>> +       unsigned int flags;
>> +} __attribute__((aligned(8)));
>> +
>> +enum {
>> +       BPF_TASK_ITER_ALL_PROCS,
>> +       BPF_TASK_ITER_ALL_THREADS,
>> +       BPF_TASK_ITER_PROC_THREADS
>> +};
>> +
>> +__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
>> +               struct task_struct *task, unsigned int flags)
>> +{
>> +       struct bpf_iter_task_kern *kit = (void *)it;
>> +
>> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) > sizeof(struct bpf_iter_task));
>> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=
>> +                                       __alignof__(struct bpf_iter_task));
>> +
>> +       kit->task = kit->pos = NULL;
>> +       switch (flags) {
>> +       case BPF_TASK_ITER_ALL_THREADS:
>> +       case BPF_TASK_ITER_ALL_PROCS:
>> +       case BPF_TASK_ITER_PROC_THREADS:
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (flags == BPF_TASK_ITER_PROC_THREADS)
>> +               kit->task = task;
>> +       else
>> +               kit->task = &init_task;
>> +       kit->pos = kit->task;
>> +       kit->flags = flags;
>> +       return 0;
>> +}
>> +
>> +__bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it)
>> +{
>> +       struct bpf_iter_task_kern *kit = (void *)it;
>> +       struct task_struct *pos;
>> +       unsigned int flags;
>> +
>> +       flags = kit->flags;
>> +       pos = kit->pos;
>> +
>> +       if (!pos)
>> +               goto out;
>> +
>> +       if (flags == BPF_TASK_ITER_ALL_PROCS)
>> +               goto get_next_task;
>> +
>> +       kit->pos = next_thread(kit->pos);
>> +       if (kit->pos == kit->task) {
>> +               if (flags == BPF_TASK_ITER_PROC_THREADS) {
>> +                       kit->pos = NULL;
>> +                       goto out;
>> +               }
>> +       } else
>> +               goto out;
> 
> nit: this should have {} around it to match the other if branch
> 
> but actually, why goto out instead of return pos? same above, return
> pos instead of goto out?
> 

Thanks for the review.


IIUC, do you mean:

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 0772545568f1..b35debf19edb 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -913,7 +913,7 @@ __bpf_kfunc struct task_struct 
*bpf_iter_task_next(struct bpf_iter_task *it)
         pos = kit->pos;

         if (!pos)
-               goto out;
+               return pos;

         if (flags == BPF_TASK_ITER_ALL_PROCS)
                 goto get_next_task;
@@ -922,18 +922,22 @@ __bpf_kfunc struct task_struct 
*bpf_iter_task_next(struct bpf_iter_task *it)
         if (kit->pos == kit->task) {
                 if (flags == BPF_TASK_ITER_PROC_THREADS) {
                         kit->pos = NULL;
-                       goto out;
+                       return pos;
                 }
         } else
-               goto out;
+               return pos;

+       /*
+        * goto get_next_task means:
+        * case 1: flags == BPF_TASK_ITER_ALL_PROCS
+        * case 2: kit->pos == kit->task && flags == 
BPF_TASK_ITER_ALL_THREADS
+        */
  get_next_task:
         kit->pos = next_task(kit->pos);
         kit->task = kit->pos;
         if (kit->pos == &init_task)
                 kit->pos = NULL;

-out:
         return pos;



BTW, do you have some comments on patch-8 ? or I should send next 
version and pass all the CI first ?

Thanks.

> 
>> +
>> +get_next_task:
>> +       kit->pos = next_task(kit->pos);
>> +       kit->task = kit->pos;
>> +       if (kit->pos == &init_task)
>> +               kit->pos = NULL;
>> +
>> +out:
>> +       return pos;
>> +}
>> +
>> +__bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
>> +{
>> +}
>> +
>>   DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
>>
>>   static void do_mmap_read_unlock(struct irq_work *entry)
>> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
>> index 8b53537e0f27..1ec82997cce7 100644
>> --- a/tools/testing/selftests/bpf/bpf_experimental.h
>> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>> @@ -457,5 +457,10 @@ extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
>>   extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it) __weak __ksym;
>>   extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __weak __ksym;
>>
>> +struct bpf_iter_task;
>> +extern int bpf_iter_task_new(struct bpf_iter_task *it,
>> +               struct task_struct *task, unsigned int flags) __weak __ksym;
>> +extern struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it) __weak __ksym;
>> +extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __ksym;
>>
>>   #endif
>> --
>> 2.20.1
>>
