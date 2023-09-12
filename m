Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6E879C7C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjILHL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjILHL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:11:57 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49547C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:11:53 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-57759a5bc17so1606994a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694502713; x=1695107513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t0udRiXjhYOvxVMqfWNiG3ptcHFZyJFhFtiEzZwrt0=;
        b=D2kAnvjrk5S2aNnzZkan5+RoAtPLlXFSmjA+pxy+7UzMyFJ/OHo8M6176VaGL1nWCK
         zC4jZhbIjyu/sm8n4+as7AGzu2sXWJyvRUSTbtaKWdNw1sUVcSsOKFzIxqI/mCkKjuN3
         MjspG489auun8Eaxb5ifKcGbY/0XFpSiIhr+DoMYrFKt7o9sWsAf14HW3aTtyYq6VDDp
         N8Hg0Xs16YSlmDca3ZL7aUzjEizkapJPoyRyKvCHPuZbiLXweCBW4G3oeG65TOuZa0kA
         RIGB4Xf9gOtO2QXN/3RmcHl/PakJqPKPs+Ep7POAzz+8EPFSHQolDJIF1Esk82KofDfH
         bD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502713; x=1695107513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9t0udRiXjhYOvxVMqfWNiG3ptcHFZyJFhFtiEzZwrt0=;
        b=ioyZjktYk4voEJKvHP3NNHNd1/bWcs0ICkMt1FxQ6xBjO2+lXYQWMqnj5nR41fbywz
         vUGQmwEVPcUov7AhQWqfdbMkSz5nZVSXW1GLX0Xx5h2mkw5Zy8AOM5BgKF5gqZnmJts6
         lAWJ6LRMp5HY3Pyshl1+FBv+CQEYNfRBdLi9yuLxLGqdFG2w10EQfMDJYynh2fcEkurr
         mk8gjWeXOlXaMwSt2rGrOseeXKoRz/QCIBFTnUit6rXZrXlrPuKNhym9xkgJ6bBcy7m8
         pCRHH4EKW8hHNF7Eu02P0WAfFIfIMwz+uYYv8oiQpt/XsaJMiGIy/Jw/arpbbYD74Lou
         Hyng==
X-Gm-Message-State: AOJu0YwPzrsgQxPUgwHI1lZiZkcjvZb+LY8+vrPmsDnWB8ZblVokTblR
        QrDaKqEwAZdWGF/RNYzQ7QF1ruy7Mn3lLHR54fc=
X-Google-Smtp-Source: AGHT+IHXPZ3Bxyk/SMdB9Cb7Z0JxPDyUlTQsQ3eM9jNpudKNWZJy+jqIlCyTMQDEa3+ucZSY+po2rg==
X-Received: by 2002:a05:6a20:12c4:b0:133:be9d:a8d3 with SMTP id v4-20020a056a2012c400b00133be9da8d3mr11252087pzg.14.1694502712756;
        Tue, 12 Sep 2023 00:11:52 -0700 (PDT)
Received: from [10.254.144.32] ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id v21-20020aa78515000000b0068a414858bdsm6681307pfn.118.2023.09.12.00.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:11:52 -0700 (PDT)
Message-ID: <09a0a33a-57c5-a81d-1b5b-982aa0e0441d@bytedance.com>
Date:   Tue, 12 Sep 2023 15:11:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH bpf-next v2 0/6] Add Open-coded process and css iters
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <20230912070149.969939-1-zhouchuyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/12 15:01, Chuyi Zhou 写道:
> Hi,
> 
> This is version 2 of process and css iters support. All the changes were
> suggested by Alexei.
> 
> Thanks for your review!
> 
> --- Changelog ---
> Changes from v1:
> - Add a pre-patch to make some preparations before supporting css_task
>    iters.
> - Add an allowlist for css_task iters
> - Let bpf progs do explicit bpf_rcu_read_lock() when using process iters
> and css_descendant iters.

Sorry for missing the link to v1 
(https://lore.kernel.org/lkml/20230827072057.1591929-1-zhouchuyi@bytedance.com/).


> ---------------------
> 
> In some BPF usage scenarios, it will be useful to iterate the process and
> css directly in the BPF program. One of the expected scenarios is
> customizable OOM victim selection via BPF[1].
> 
> Inspired by Dave's task_vma iter[2], this patchset adds three types of
> open-coded iterator kfuncs:
> 
> 1. bpf_for_each(process, p). Just like for_each_process(p) in kernel to
> itearing all tasks in the system.
> 
> 2. bpf_for_each(css_task, task, css). It works like
> css_task_iter_{start, next, end} and would be used to iterating
> tasks/threads under a css.
> 
> 3. bpf_for_each(css_{post, pre}, pos, root_css). It works like
> css_next_descendant_{pre, post} to iterating all descendant css.
> 
> BPF programs can use these kfuncs directly or through bpf_for_each macro.
> 
> link[1]: https://lore.kernel.org/lkml/20230810081319.65668-1-zhouchuyi@bytedance.com/
> link[2]: https://lore.kernel.org/all/20230810183513.684836-1-davemarchevsky@fb.com/
> 
> Chuyi Zhou (6):
>    cgroup: Prepare for using css_task_iter_*() in BPF
>    bpf: Introduce css_task open-coded iterator kfuncs
>    bpf: Introduce process open coded iterator kfuncs
>    bpf: Introduce css_descendant open-coded iterator kfuncs
>    bpf: teach the verifier to enforce css_iter and process_iter in RCU CS
>    selftests/bpf: Add tests for open-coded task and css iter
> 
>   include/linux/cgroup.h                        |  12 +-
>   include/uapi/linux/bpf.h                      |  16 ++
>   kernel/bpf/helpers.c                          |  12 ++
>   kernel/bpf/task_iter.c                        | 130 +++++++++++++++++
>   kernel/bpf/verifier.c                         |  53 ++++++-
>   kernel/cgroup/cgroup.c                        |  18 ++-
>   tools/include/uapi/linux/bpf.h                |  16 ++
>   tools/lib/bpf/bpf_helpers.h                   |  24 +++
>   .../testing/selftests/bpf/prog_tests/iters.c  | 138 ++++++++++++++++++
>   .../testing/selftests/bpf/progs/iters_task.c  | 104 +++++++++++++
>   10 files changed, 508 insertions(+), 15 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task.c
> 
