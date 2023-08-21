Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0416783493
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjHUU2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHUU2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:28:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA1123
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:28:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so4788229a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692649718; x=1693254518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ypTOlttmO9qqbmmzfV/SSOD9CPm3O5A8OgG4B0eFddk=;
        b=bMRQ0kzROXqg2RUFT1ECxbCN7VIAsmdxl1AXLcQb/IOUcX49zPoIRcPjFllUMxDJdu
         FC/XGCf2ToxMZKBcBuzEBnmI+0OzjsDs2Uftn+ap9cznywVa57usqgqmrYxe41Wfwd45
         x+ZvuPlbMGSVuyWwmAAvVRqWKebKXDNaO9sAwzis3OY23bQGxOrhafW+XCNbuRnekziE
         FuSgdSFiiDt+iAY8YF4cfSqawE2PdT7cUeCY96z8LC38HjiReykJYvihoLDvkyUy1Nk3
         6QTKTIUa0MKX03TM36cbQIs3g02J9tpjZHhNJgwNtN4FPHUTEzrdabbegQoCLsN7RuME
         z7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692649718; x=1693254518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypTOlttmO9qqbmmzfV/SSOD9CPm3O5A8OgG4B0eFddk=;
        b=M7unHZmz8bWADfThyrD29ztHOcWLkjSceyqjjkIBhtAQVybUAJIKsVITu6DQImfezH
         1hpKWKBBkysim5VdQM6of8IRC7Ai2XvfnSJV8WlINrsLhU8k+TIzdQmSFELUm+pIwYzH
         /N6ssV2PFXLd5acT2ajBq9wqcudvxJgCZ0RZ/11icgAxECtWvCKWfk9c/Do8F5MU7qCR
         GZj9RZwzJOowS/kwJ4DawVi+8V+b4IxabQm/Cq9yqEoX3U6yLYJEaVhWdbXKr3ghVSOy
         sO6Dn3+L7vrG3djvfQoaK43+iMjmALkB1PgQoMGNSuSdf9TqTBKpY4KuNomG0/iE68z4
         WqzA==
X-Gm-Message-State: AOJu0YxEyyy316Q8ETy2OYDfHbaX7Lq+g3Dw92GP1YLh5dziG9KxELn9
        URECXy8Q0Uv9wOAKu7/gdIY5PUD967o81g==
X-Google-Smtp-Source: AGHT+IHdO9dQo5jT6szR56qVdF48goDlysiNHz/4gKeh9UDB2o/hVZFIAh0E81l3pDLo2S/Luepx3g==
X-Received: by 2002:a17:906:5199:b0:9a1:b6e1:c2e with SMTP id y25-20020a170906519900b009a1b6e10c2emr209558ejk.33.1692649718268;
        Mon, 21 Aug 2023 13:28:38 -0700 (PDT)
Received: from f.. (cst-prg-85-121.cust.vodafone.cz. [46.135.85.121])
        by smtp.gmail.com with ESMTPSA id k26-20020a1709062a5a00b00997cce73cc7sm7084450eje.29.2023.08.21.13.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 13:28:37 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 0/2] execve scalability issues, part 1
Date:   Mon, 21 Aug 2023 22:28:27 +0200
Message-Id: <20230821202829.2163744-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To start I figured I'm going to bench about as friendly case as it gets
-- statically linked *separate* binaries all doing execve in a loop.

I borrowed the bench from found here:
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

Mateusz Guzik (2):
  pcpcntr: add group allocation/free
  fork: group allocation of per-cpu counters for mm struct

 include/linux/percpu_counter.h | 19 ++++++++---
 kernel/fork.c                  | 13 ++------
 lib/percpu_counter.c           | 61 ++++++++++++++++++++++++----------
 3 files changed, 60 insertions(+), 33 deletions(-)

-- 
2.39.2

