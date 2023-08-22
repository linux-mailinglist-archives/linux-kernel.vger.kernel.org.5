Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322E378497E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjHVSmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHVSmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:42:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115D4CD1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:41:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52683b68c2fso5874960a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692729717; x=1693334517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yu3d85yUXP65X99ohouSmmyW99HdJOlkw3Nlk8oie+k=;
        b=DquBV+MaulAYeXqzDJNWyLcMhNY1odGn3wbffM0pB7q60mM6Q1AFjg2nWFA9j7TV2o
         ESktdLx6R11am/xbdEDR/zqImsXWkNHPljCOuoc7KCZ7TLoNHmAahiETvv254aQ9714s
         azpnPe/0REeGoNCCRlI5zQQMGfX5qvF3Vn2Mn97KTVvbBuy7bOAdbvPBV+MJdA8OXV2M
         wMhVVL1iovf+PGc/qbxdqA6FYwK8oVk5s1pcXEVmqYFzpWkWN+U9Y7/C3hS4a596z/px
         X1jYooKZBgy4E4LoxQM5Xe/E1mhJZIN3N66prNg1dE30kdWh6o4A/mEmAZn91z8h3zke
         0ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692729717; x=1693334517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yu3d85yUXP65X99ohouSmmyW99HdJOlkw3Nlk8oie+k=;
        b=CMyCIWgsciT6qvge80Eq/rkY+P8R62ubJQyfAD4rf9yFbvDzHFP6btChMTBirUaR7P
         ZZFLV9ZSY1z5pLygwZbpTfar2ffS9lrg5CSZ5qv4AclDL/R+fGjfQEFUiI6cUp93xWk+
         D4490zLoy2MmUwdHpm3oQ9U5NfDc4b39TxX0LOnwi7CwcotZlE35LpjT1WUdXVM89vK8
         1Ru9UCVOGTIh+v4PhXiad9IYZdiSiU+EdOayVK8Fsk6epJiu3VxnVUBzaiPu3yn7nDnQ
         D/nF0ed4xdRII28MCW1UiyDFaS4oKhccaOA0CrjmNpCcrV28dVs9u6K7OokXNVQLk47G
         6M+A==
X-Gm-Message-State: AOJu0YyifTzlAXtnpVPVDqx4fNU0Uxccbn2pEYM0F/BDJtNgKKK1yDAs
        HGFv6jaBxzmy6Lh5nb8Mi9t5jPD8el7aMw==
X-Google-Smtp-Source: AGHT+IGAtV9+SDFXM8ZMZxI9O5Ai6l1RAuNVNGE1XAnZ4CZCcHzbgYuXwQd4FZEhqYS9Vq0qTkxm7w==
X-Received: by 2002:a05:6402:b29:b0:523:aef9:3b7b with SMTP id bo9-20020a0564020b2900b00523aef93b7bmr8719672edb.4.1692729717338;
        Tue, 22 Aug 2023 11:41:57 -0700 (PDT)
Received: from f.. (cst-prg-85-121.cust.vodafone.cz. [46.135.85.121])
        by smtp.gmail.com with ESMTPSA id w9-20020a056402070900b00525683f9b2fsm7945317edx.5.2023.08.22.11.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:41:56 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 0/2] execve scalability issues, part 1
Date:   Tue, 22 Aug 2023 20:41:50 +0200
Message-Id: <20230822184152.2194558-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To start I figured I'm going to bench about as friendly case as it gets
-- statically linked *separate* binaries all doing execve in a loop.

I borrowed the bench from here:
http://apollo.backplane.com/DFlyMisc/doexec.c

$ cc -static -O2 -o static-doexec doexec.c
$ ./static-doexec $(nproc)

It prints a result every second (warning: first line is garbage).

My test box is temporarily only 26 cores and even at this scale I run
into massive lock contention stemming from back-to-back calls to
percpu_counter_init (and _destroy later).

While not a panacea, one simple thing to do here is to batch these ops.
Since the term "batching" is already used in the file, I decided to
refer to it as "grouping" instead.

Even if this code could be patched to dodge these counters,  I would
argue a high-traffic alloc/free consumer is only a matter of time so it
makes sense to facilitate it.

With the fix I get an ok win, to quote from the commit:
> Even at a very modest scale of 26 cores (ops/s):
> before: 133543.63
> after:  186061.81 (+39%)

> While with the patch these allocations remain a significant problem,
> the primary bottleneck shifts to:
> 
>     __pv_queued_spin_lock_slowpath+1
>     _raw_spin_lock_irqsave+57
>     folio_lruvec_lock_irqsave+91
>     release_pages+590
>     tlb_batch_pages_flush+61
>     tlb_finish_mmu+101
>     exit_mmap+327
>     __mmput+61
>     begin_new_exec+1245
>     load_elf_binary+712
>     bprm_execve+644
>     do_execveat_common.isra.0+429
>     __x64_sys_execve+50
>     do_syscall_64+46
>     entry_SYSCALL_64_after_hwframe+110

I intend to do more work on the area to mostly sort it out, but I would
not mind if someone else took the hammer to folio. :)

With this out of the way I'll be looking at some form of caching to
eliminate these allocs as a problem.

Thoughts?

v2:
- force bigger alignment on alloc
- rename "counters" to "nr_counters" and pass prior to lock key
- drop {}'s for single-statement loops

Mateusz Guzik (2):
  pcpcntr: add group allocation/free
  fork: group allocation of per-cpu counters for mm struct

 include/linux/percpu_counter.h | 20 ++++++++---
 kernel/fork.c                  | 14 ++------
 lib/percpu_counter.c           | 61 +++++++++++++++++++++++-----------
 3 files changed, 60 insertions(+), 35 deletions(-)

-- 
2.39.2

