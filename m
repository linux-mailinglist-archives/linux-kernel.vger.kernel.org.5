Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC07898B3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 20:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjHZSdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 14:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjHZSdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 14:33:25 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F86109
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 11:33:22 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57354433a7dso648719eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693074802; x=1693679602;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n+z/gBamPq/Xr3Inj2gAsNhcxuw0UOxejNz9OQS7tcU=;
        b=hsYzgD0fMZYMgny5rOU+xzD6RP5D1s2F38QXvrhnvzRommZB7UmjeuTZIbZc2aSfBz
         Aensp5yuJEBH3NpZpRq+oVRHNvjMsi6e6cnr88VYHGMhKKwBC9ihO4KWCWECAC0eGqvC
         pUl+mQWkKFxB4f/9jiVAV2CYinGzLGXtwsUhOm3L77X2JNGt36/fI3mSE0Rua+7XSC6n
         jCqcD/bDSmjK7m1oqwWEJEAOKzbGLVGMW2cNsZ7yWSETZtuO1i8jv9mCXvqIVWWiqTgf
         MEVff+GyxVnlCLnXAdhSKpM+n6tFUIQ6Y98ruizZ5ZSHUCnmVUMlkfpm7DBq+1n0gGBn
         8HYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693074802; x=1693679602;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+z/gBamPq/Xr3Inj2gAsNhcxuw0UOxejNz9OQS7tcU=;
        b=jlM/8ucZZ0j49t+H+PjI40twks5fv8gEb8SiJivnwbjMJ0cbjxQ/1zIvdpyBhs9c3y
         r/uLoCJiXUdDWPdL0Axwir16xQSj6v4CUXuJ/hC/RVEuaIAtsO0BVd1n3w+NbP3y81I4
         JdFCJ5XiCfsk7yTsyW4ODjCwvXpOljI4ZZjImZjcaINv4mFeELZ6A6udWqqACUu3W7Ti
         QDrK4IW6NTkILpbj8nEA+lKrPhoybmn/uMy0yuSajCMDFd9By2giEgDwatIx06eYNU5Z
         tUHqbN8hRzflJNokT2Og8IjVgY1d6RheOzu0lOLGv5eK7eqqAIA0YdzQqCADlF50FaBq
         7kcg==
X-Gm-Message-State: AOJu0YwdUqpcyj6ZO9Si57zvL4c+U5g0Zt8ezaY/lS2fQ06D+WGXqktz
        76NKl4Vt5SVU6n5J8nJ2CLSq31saaWCcaZSwAmR35/My
X-Google-Smtp-Source: AGHT+IFOFXxE3hhZsvvuJJHkNUN5OCtKBU8Ou+XCUZnlS5M9mCThljAPJikRLCLTLXbgwiPMKWbmq28zOcFhFqXqecQ=
X-Received: by 2002:a05:6870:46a9:b0:1b3:ef56:270a with SMTP id
 a41-20020a05687046a900b001b3ef56270amr6121334oap.29.1693074801769; Sat, 26
 Aug 2023 11:33:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1141:0:b0:4f0:1250:dd51 with HTTP; Sat, 26 Aug 2023
 11:33:21 -0700 (PDT)
In-Reply-To: <20230821202829.2163744-1-mjguzik@gmail.com>
References: <20230821202829.2163744-1-mjguzik@gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sat, 26 Aug 2023 20:33:21 +0200
Message-ID: <CAGudoHEKYYmbJ+3SEHDeqi9TLoLjpFNf9HdAQXkuWSd2TKhJQw@mail.gmail.com>
Subject: Re: [PATCH 0/2] execve scalability issues, part 1
To:     linux-kernel@vger.kernel.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org,
        jack@suse.cz
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

On 8/21/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> To start I figured I'm going to bench about as friendly case as it gets
> -- statically linked *separate* binaries all doing execve in a loop.
>
> I borrowed the bench from found here:
> http://apollo.backplane.com/DFlyMisc/doexec.c
>
> $ cc -static -O2 -o static-doexec doexec.c
> $ ./static-doexec $(nproc)
>
> It prints a result every second (warning: first line is garbage).
>
> My test box is temporarily only 26 cores and even at this scale I run
> into massive lock contention stemming from back-to-back calls to
> percpu_counter_init (and _destroy later).
>
> While not a panacea, one simple thing to do here is to batch these ops.
> Since the term "batching" is already used in the file, I decided to
> refer to it as "grouping" instead.
>
> Even if this code could be patched to dodge these counters,  I would
> argue a high-traffic alloc/free consumer is only a matter of time so it
> makes sense to facilitate it.
>
> With the fix I get an ok win, to quote from the commit:
>> Even at a very modest scale of 26 cores (ops/s):
>> before: 133543.63
>> after:  186061.81 (+39%)
>

So to sum up, a v3 of the patchset is queued up here:
https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git/log/?h=for-next

For interested I temporarily got my hands on something exceeding the
hand watch scale benched above -- a 192-way AMD EPYC 7R13 box (2
sockets x 48 cores x 2 threads).

A 6.5 kernel + the patchset only gets south of 140k execs/s when
running ./static-doexec 192

According to perf top:
  51.04%  [kernel]           [k] osq_lock
   6.82%  [kernel]           [k] __raw_callee_save___kvm_vcpu_is_preempted
   2.98%  [kernel]           [k] _atomic_dec_and_lock_irqsave
   1.62%  [kernel]           [k] rcu_cblist_dequeue
   1.54%  [kernel]           [k] refcount_dec_not_one
   1.51%  [kernel]           [k] __mod_lruvec_page_state
   1.46%  [kernel]           [k] put_cred_rcu
   1.34%  [kernel]           [k] native_queued_spin_lock_slowpath
   0.94%  [kernel]           [k] srso_alias_safe_ret
   0.81%  [kernel]           [k] memset_orig
   0.77%  [kernel]           [k] unmap_page_range
   0.73%  [kernel]           [k] _compound_head
   0.72%  [kernel]           [k] kmem_cache_free

Then bpftrace -e 'kprobe:osq_lock { @[kstack()] = count(); }' shows:

@[
    osq_lock+1
    __mutex_lock_killable_slowpath+19
    mutex_lock_killable+62
    pcpu_alloc+1219
    __alloc_percpu_gfp+18
    __percpu_counter_init_many+43
    mm_init+727
    mm_alloc+78
    alloc_bprm+138
    do_execveat_common.isra.0+103
    __x64_sys_execve+55
    do_syscall_64+54
    entry_SYSCALL_64_after_hwframe+110
]: 637370

@[
    osq_lock+1
    __mutex_lock_killable_slowpath+19
    mutex_lock_killable+62
    pcpu_alloc+1219
    __alloc_percpu+21
    mm_init+577
    mm_alloc+78
    alloc_bprm+138
    do_execveat_common.isra.0+103
    __x64_sys_execve+55
    do_syscall_64+54
    entry_SYSCALL_64_after_hwframe+110
]: 638036

That is per-cpu allocation is still on top at this scale.

But more importantly there are *TWO* unrelated back-to-back per-cpu
allocs -- one by rss counters and one by mm_alloc_cid.

That is to say per-cpu alloc scalability definitely needs to get
fixed, I'll ponder about it.

-- 
Mateusz Guzik <mjguzik gmail.com>
