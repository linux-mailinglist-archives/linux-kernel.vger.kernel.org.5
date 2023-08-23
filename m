Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E6784FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjHWFGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjHWFGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:06:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3033E4A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:06:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99bf1f632b8so696489466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 22:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692767174; x=1693371974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sqKYKpOEi3Kr9hF/miWkxFJLPX34bcvccfAOYoYKAjI=;
        b=g4+9g8UxCOKkr8I5LirgjBpbjHT1YjvTGeuZbCsizGhtiHgqGXdLhrnlUSB/a8t1Vt
         8HFt1WMDsL31KSg9V2XLPJlNV7UzY0oOEJI2q3f2SeGRBq2Jc3dhPG5UhBxePEGfQ/C7
         vrItswwQFtDe0wYnN2i2dFpvch2hJkZKyXDxRcxBskbzFFGFEZgdpatn5q1rIVWMS+Lg
         ES/uQy/WvB9ojP8suJplWSUeTYHIh4/bGZ85GwhZ4eLCaZaf8raGPALw9dX8GLa0wTd4
         M1QJemsoj+rfBlhPw4kNYP8UIc32yFU4tRoNOwF1OE12Fd/6vNmT3lpyPatZnEXMlE45
         GlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692767174; x=1693371974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqKYKpOEi3Kr9hF/miWkxFJLPX34bcvccfAOYoYKAjI=;
        b=YiLJ9LhDkmMajuz/gaWp0nWJZesxYqZNcaEBNMyKzWFdWH0x38WjbgyZ37lxaLvgZ3
         SwovkxqK6VV/cjkoNNDa92ZM8E0wsz6gC6G42yv+w/fHatQoTOMvxjzCoyVwUW1d82UO
         MaIfDV+sHHi+koBvQrUoJm4aWL5n6NwvaN+quoB4tnlKv+6JDmQGDJ9XKeZnWSJDj7Gr
         JKCaJTJeuUTAb44OKTpDYd3Rz7j4DnRabqY+dyEOQhPKq2SrebhFEJhXUsMRz6R67cY7
         oQ15Fp7vjIolzbbJLARmQAbBhha5qRRKHNhdb+NXSLq9Xy/x8K8LZ98/+ZMaByjz2IGe
         W/Pw==
X-Gm-Message-State: AOJu0Yy2gqDqV1onEbJlG7sMsGRJjrdovtrHzdi6gAaKr6uOEaNFiD2f
        GoFz88MWdaU9r/9O92v9eU7EryZ/yu8m6Q==
X-Google-Smtp-Source: AGHT+IF8JRl9gwD6rVjqyqMT4L6TPhIzI+CuO/MXDsiX8e0PGSfkLPonABmt6rEwYqFMXWLE1mOpaw==
X-Received: by 2002:a17:907:b15:b0:99d:e858:4160 with SMTP id h21-20020a1709070b1500b0099de8584160mr8958916ejl.49.1692767174224;
        Tue, 22 Aug 2023 22:06:14 -0700 (PDT)
Received: from f.. (cst-prg-85-121.cust.vodafone.cz. [46.135.85.121])
        by smtp.gmail.com with ESMTPSA id q16-20020a170906b29000b0099ddc81903asm9267401ejz.221.2023.08.22.22.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 22:06:13 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com,
        vegard.nossum@oracle.com, linux-mm@kvack.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 0/2] execve scalability issues, part 1
Date:   Wed, 23 Aug 2023 07:06:07 +0200
Message-Id: <20230823050609.2228718-1-mjguzik@gmail.com>
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

It prints a result every second.

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

While with the patch these allocations remain a significant problem,
the primary bottleneck shifts to:

    __pv_queued_spin_lock_slowpath+1
    _raw_spin_lock_irqsave+57
    folio_lruvec_lock_irqsave+91
    release_pages+590
    tlb_batch_pages_flush+61
    tlb_finish_mmu+101
    exit_mmap+327
    __mmput+61
    begin_new_exec+1245
    load_elf_binary+712
    bprm_execve+644
    do_execveat_common.isra.0+429
    __x64_sys_execve+50
    do_syscall_64+46
    entry_SYSCALL_64_after_hwframe+110

I intend to do more work on the area to mostly sort it out, but I would
not mind if someone else took the hammer to folio. :)

With this out of the way I'll be looking at some form of caching to
eliminate these allocs as a problem.

v3:
- fix !CONFIG_SMP build
- drop the backtrace from fork commit message

v2:
- force bigger alignment on alloc
- rename "counters" to "nr_counters" and pass prior to lock key
- drop {}'s for single-statement loops


Mateusz Guzik (2):
  pcpcntr: add group allocation/free
  fork: group allocation of per-cpu counters for mm struct

 include/linux/percpu_counter.h | 39 ++++++++++++++++++----
 kernel/fork.c                  | 14 ++------
 lib/percpu_counter.c           | 61 +++++++++++++++++++++++-----------
 3 files changed, 77 insertions(+), 37 deletions(-)

-- 
2.41.0

