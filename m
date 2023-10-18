Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B027CD46D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjJRGYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjJRGYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:24:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BC21BD7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:21:20 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b20a48522fso4128090b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697610078; x=1698214878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ygh6e4WwpciuAym8ohi+pEGWxAd4q6l+qZbqHeReRLY=;
        b=awnFfa4swzG55hSP5I78A89D9zkzcui4PaycC8K3QZL/MSVASdppz9sVHZlti5NCar
         ERTHTNxAtxqm3fBqk6B0sOf32oEatrhopyW7fnMLpo9F7itUc9Kq6S5OyI8rSINAh7uE
         jzfWHO2vyG3xhS1HJj4EUfchytW20YibnR16gCz8k+x03+E0JiRHexxSrzX1rLKFemAn
         aIJ1ysDD6GJeCaDkn2AwEBnfgDjJp1oM5N5Eeq1juH20++LuCsZ1+xKx0Ym893Gnk2eR
         LmpzSOoG0958HH2Bnm2ah4UBHBVPTWfcSg40n10M2INjYyrki+UFngf7vt/NH/6+eR/6
         eKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697610078; x=1698214878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ygh6e4WwpciuAym8ohi+pEGWxAd4q6l+qZbqHeReRLY=;
        b=SbnUebFI3jl8DciZ5CSs2SnkdenFKwL7KZ6S112IAcnfIxwtPnTx+DJnjNmBCLCoJS
         04ZqnD8lp1g8OwFaYIO6d0REwyePqNBI46TnniThR/sjFjJtMQNdxbAS1jMc5XLRDi59
         BWL4FciPW3TUfu5CiIXNKmMvfMxuzs3JMgq2hqBECLRrbtOLlNbYKENVIkpNPz5gfuA3
         EveU5uXktmep8iAPfpON6CpHs98Hw46VVNNhH3QjVerVxn8hIosxD7Z/A7PgOynYGaTH
         BMyhs7CAwrHZAdIQgKdQWKIWmQS1t2BWiS95BOReamSYkwMzFPXBAOBOGtJ0a++iMEAu
         5UNg==
X-Gm-Message-State: AOJu0Yzc+DpmjF1/IppJjylDzPKjB67pqP4ezIZ4p/7+LTKHkUCm5OUi
        vpicMSN3Vc+yIme8rVhG3vkIcA==
X-Google-Smtp-Source: AGHT+IFTiAyCc8sJKZOQpGe4wNF4hy+oK4JaBOKmdbkhIlznNss2EFm0xFw2I9KMRCWDZAov7ckDQQ==
X-Received: by 2002:a05:6a00:2395:b0:6b3:55fd:d851 with SMTP id f21-20020a056a00239500b006b355fdd851mr3979376pfc.10.1697610078373;
        Tue, 17 Oct 2023 23:21:18 -0700 (PDT)
Received: from [10.254.248.11] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7998f000000b00690bd3c0723sm2541846pfh.99.2023.10.17.23.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 23:21:18 -0700 (PDT)
Message-ID: <d7f1b762-0a59-4f3a-8370-deba06f91c46@bytedance.com>
Date:   Wed, 18 Oct 2023 14:21:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH bpf-next v6 0/8] Add Open-coded task, css_task and
 css iters
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <20231018061746.111364-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/18 14:17, Chuyi Zhou 写道:
> This is version 6 of task, css_task and css iters support.
> 

I resend this patchset since my network broken when I sent it first time.

> --- Changelog ---
> 
> v5 -> v6:
> 
> Patch #3:
>   * In bpf_iter_task_next, return pos rather than goto out. (Andrii)
> Patch #2, #3, #4:
>   * Add the missing __diag_ignore_all to avoid kernel build warning
> Patch #5, #6, #7:
>   * Add Andrii's ack
> 
> Patch #8:
>   * In BPF prog iter_css_task_for_each, return -EPERM rather than 0, and
>     ensure stack_mprotect() in iters.c not success. If not, it would cause
>     the subsequent 'test_lsm' fail, since the 'is_stack' check in
>     test_int_hook(lsm.c) would not be guaranteed.
>     (https://github.com/kernel-patches/bpf/actions/runs/6489662214/job/17624665086?pr=5790)
> 
> v4 -> v5:https://lore.kernel.org/lkml/20231007124522.34834-1-zhouchuyi@bytedance.com/
> 
> Patch 3~4:
>   * Relax the BUILD_BUG_ON check in bpf_iter_task_new and bpf_iter_css_new to avoid
>     netdev/build_32bit CI error.
>     (https://netdev.bots.linux.dev/static/nipa/790929/13412333/build_32bit/stderr)
> Patch 8:
>   * Initialize skel pointer to fix the LLVM-16 build CI error
>     (https://github.com/kernel-patches/bpf/actions/runs/6462875618/job/17545170863)
> 
> v3 -> v4:https://lore.kernel.org/all/20230925105552.817513-1-zhouchuyi@bytedance.com/
> 
> * Address all the comments from Andrii in patch-3 ~ patch-6
> * Collect Tejun's ack
> * Add a extra patch to rename bpf_iter_task.c to bpf_iter_tasks.c
> * Seperate three BPF program files for selftests (iters_task.c iters_css_task.c iters_css.c)
> 
> v2 -> v3:https://lore.kernel.org/lkml/20230912070149.969939-1-zhouchuyi@bytedance.com/
> 
> Patch 1 (cgroup: Prepare for using css_task_iter_*() in BPF)
>    * Add tj's ack and Alexei's suggest-by.
> Patch 2 (bpf: Introduce css_task open-coded iterator kfuncs)
>    * Use bpf_mem_alloc/bpf_mem_free rather than kzalloc()
>    * Add KF_TRUSTED_ARGS for bpf_iter_css_task_new (Alexei)
>    * Move bpf_iter_css_task's definition from uapi/linux/bpf.h to
>      kernel/bpf/task_iter.c and we can use it from vmlinux.h
>    * Move bpf_iter_css_task_XXX's declaration from bpf_helpers.h to
>      bpf_experimental.h
> Patch 3 (Introduce task open coded iterator kfuncs)
>    * Change th API design keep consistent with SEC("iter/task"), support
>      iterating all threads(BPF_TASK_ITERATE_ALL) and threads of a
>      specific task (BPF_TASK_ITERATE_THREAD).（Andrii)
>    * Move bpf_iter_task's definition from uapi/linux/bpf.h to
>      kernel/bpf/task_iter.c and we can use it from vmlinux.h
>    * Move bpf_iter_task_XXX's declaration from bpf_helpers.h to
>      bpf_experimental.h
> Patch 4 (Introduce css open-coded iterator kfuncs)
>    * Change th API design keep consistent with cgroup_iters, reuse
>      BPF_CGROUP_ITER_DESCENDANTS_PRE/BPF_CGROUP_ITER_DESCENDANTS_POST
>      /BPF_CGROUP_ITER_ANCESTORS_UP(Andrii)
>    * Add KF_TRUSTED_ARGS for bpf_iter_css_new
>    * Move bpf_iter_css's definition from uapi/linux/bpf.h to
>      kernel/bpf/task_iter.c and we can use it from vmlinux.h
>    * Move bpf_iter_css_XXX's declaration from bpf_helpers.h to
>      bpf_experimental.h
> Patch 5 (teach the verifier to enforce css_iter and task_iter in RCU CS)
>    * Add KF flag KF_RCU_PROTECTED to maintain kfuncs which need RCU CS.(Andrii)
>    * Consider STACK_ITER when using bpf_for_each_spilled_reg.
> Patch 6 (Let bpf_iter_task_new accept null task ptr)
>    * Add this extra patch to let bpf_iter_task_new accept a 'nullable'
>    * task pointer(Andrii)
> Patch 7 (selftests/bpf: Add tests for open-coded task and css iter)
>    * Add failure testcase(Alexei)
> 
> 
> Changes from v1(https://lore.kernel.org/lkml/20230827072057.1591929-1-zhouchuyi@bytedance.com/):
> - Add a pre-patch to make some preparations before supporting css_task
>    iters.(Alexei)
> - Add an allowlist for css_task iters(Alexei)
> - Let bpf progs do explicit bpf_rcu_read_lock() when using process
>    iters and css_descendant iters.(Alexei)
> ---------------------
> 
> In some BPF usage scenarios, it will be useful to iterate the process and
> css directly in the BPF program. One of the expected scenarios is
> customizable OOM victim selection via BPF[1].
> 
> Inspired by Dave's task_vma iter[2], this patchset adds three types of
> open-coded iterator kfuncs:
> 
> 1. bpf_task_iters. It can be used to
> 1) iterate all process in the system, like for_each_forcess() in kernel.
> 2) iterate all threads in the system.
> 3) iterate all threads of a specific task
> 
> 2. bpf_css_iters. It works like css_task_iter_{start, next, end} and would
> be used to iterating tasks/threads under a css.
> 
> 3. css_iters. It works like css_next_descendant_{pre, post} to iterating all
> descendant css.
> 
> BPF programs can use these kfuncs directly or through bpf_for_each macro.
> 
> link[1]: https://lore.kernel.org/lkml/20230810081319.65668-1-zhouchuyi@bytedance.com/
> link[2]: https://lore.kernel.org/all/20230810183513.684836-1-davemarchevsky@fb.com/
> 
> Chuyi Zhou (8):
>    cgroup: Prepare for using css_task_iter_*() in BPF
>    bpf: Introduce css_task open-coded iterator kfuncs
>    bpf: Introduce task open coded iterator kfuncs
>    bpf: Introduce css open-coded iterator kfuncs
>    bpf: teach the verifier to enforce css_iter and task_iter in RCU CS
>    bpf: Let bpf_iter_task_new accept null task ptr
>    selftests/bpf: rename bpf_iter_task.c to bpf_iter_tasks.c
>    selftests/bpf: Add tests for open-coded task and css iter
> 
>   include/linux/bpf_verifier.h                  |  19 ++-
>   include/linux/btf.h                           |   1 +
>   include/linux/cgroup.h                        |  12 +-
>   kernel/bpf/cgroup_iter.c                      |  65 ++++++++
>   kernel/bpf/helpers.c                          |   9 ++
>   kernel/bpf/task_iter.c                        | 151 ++++++++++++++++++
>   kernel/bpf/verifier.c                         |  86 ++++++++--
>   kernel/cgroup/cgroup.c                        |  18 ++-
>   .../testing/selftests/bpf/bpf_experimental.h  |  19 +++
>   .../selftests/bpf/prog_tests/bpf_iter.c       |  18 +--
>   .../testing/selftests/bpf/prog_tests/iters.c  | 150 +++++++++++++++++
>   .../{bpf_iter_task.c => bpf_iter_tasks.c}     |   0
>   tools/testing/selftests/bpf/progs/iters_css.c |  72 +++++++++
>   .../selftests/bpf/progs/iters_css_task.c      |  47 ++++++
>   .../testing/selftests/bpf/progs/iters_task.c  |  41 +++++
>   .../selftests/bpf/progs/iters_task_failure.c  | 105 ++++++++++++
>   16 files changed, 771 insertions(+), 42 deletions(-)
>   rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c => bpf_iter_tasks.c} (100%)
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_css.c
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_css_task.c
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task_failure.c
> 
