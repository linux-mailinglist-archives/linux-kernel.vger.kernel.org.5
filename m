Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFBD7DA6B9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjJ1Lb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjJ1L2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:28:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7F7DE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 04:28:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso4894419a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 04:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698492496; x=1699097296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIG/E0j7il+FitUInBo8Z6Tz1lpvJUbD9aS0jo2XnTA=;
        b=A8lSlyVcWTq+FTXfdXYZiL+wytzIl9gx8c+L5XBeP+ATmzWgkHQmKGdpkvjzl5dqQR
         9qNoxeiiaO8U5PvCY0BflrkHaP0SUTBxr7VgYwbnoH1ZrR9tWU9QlU56RYjZM6lMxM66
         UETyWlALyvLO3ir85bYhByAtRGkUWucKx5AYzXCgAvP/6K8Y4wkLuig3C+IXMjlkasto
         5e2NxX6i4bgYSV0cbH824TVYiaTfHDaaND05r404CanRSk1akWf8AmXGFoEWGmsqrZHX
         mFGV+l0NAWB3HlUuLRCZbASw9+ezVT8LkmdcKjDTfdBgIfw+3qnYuge3dIY+XJOjQYtU
         yFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698492496; x=1699097296;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pIG/E0j7il+FitUInBo8Z6Tz1lpvJUbD9aS0jo2XnTA=;
        b=bPCsJH65V32CDmOZ6O9HbtQuEYVeSuvuVk2hp3ihzLTpdBjkQvk10HBZDkBcN8HJxb
         4pJNmnmmyZ3gG3bUvODi3WRI8A7MN0fBl6qvysoV12YeRoTcvYPfHxx/jhcIrDsmT86q
         1KBDrHrUE1E9w6MmKAcca1FJbGVA0fu+1eim7KuS6fSnYITUGcPkAKqh4QPHrk+T4Ghj
         AQmx6kjxieHvvMXgu1Ej9lHlEaeXWAnpLqrOwPt68iBatDhc+oXe7P4Q5jIKIyJ6zGs7
         n6AVXdUSpsVrM4Yr1C9AXp4t8s5Db7LT0mHKQxoGC7iy4rWTSnqR1S5Dm7zpsXS0GUgH
         nIIw==
X-Gm-Message-State: AOJu0YyOJz+uQaLJw6pCK37ZlJGiQWFXvyOw0vGryx7GLmhlsqVID6EP
        RN1TT1mMPYixHjNhNPidNXw=
X-Google-Smtp-Source: AGHT+IEUQqXKK8LAfMQbS+GlEuCIkArOJEdo07pdQKgO8xeCx5KDbCv0XX+p5bqYnqXAt2wUGWln4w==
X-Received: by 2002:a17:907:9629:b0:9c2:a072:78ca with SMTP id gb41-20020a170907962900b009c2a07278camr4936898ejc.28.1698492495982;
        Sat, 28 Oct 2023 04:28:15 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id sd2-20020a170906ce2200b009c762d89c76sm2612726ejb.0.2023.10.28.04.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 04:28:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 13:28:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] locking changes for v6.7
Message-ID: <ZTzwTaf1iTnCHwJM@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-10-28

   # HEAD: c73801ae4f22b390228ebf471d55668e824198b6 futex: Don't include process MM in futex key on no-MMU

Locking changes in this cycle are:

 - Futex improvements:

    - Add the 'futex2' syscall ABI, which is an attempt to get away from the
      multiplex syscall and adds a little room for extentions, while lifting
      some limitations.

    - Fix futex PI recursive rt_mutex waiter state bug

    - Fix inter-process shared futexes on no-MMU systems

    - Use folios instead of pages

 - Micro-optimizations of locking primitives:

    - Improve arch_spin_value_unlocked() on asm-generic ticket spinlock
      architectures, to improve lockref code generation.

    - Improve the x86-32 lockref_get_not_zero() main loop by adding
      build-time CMPXCHG8B support detection for the relevant lockref code,
      and by better interfacing the CMPXCHG8B assembly code with the compiler.

    - Introduce arch_sync_try_cmpxchg() on x86 to improve sync_try_cmpxchg()
      code generation. Convert some sync_cmpxchg() users to sync_try_cmpxchg().

    - Micro-optimize rcuref_put_slowpath()

 - Locking debuggability improvements:

    - Improve CONFIG_DEBUG_RT_MUTEXES=y to have a fast-path as well

    - Enforce atomicity of sched_submit_work(), which is de-facto atomic but
      was un-enforced previously.

    - Extend <linux/cleanup.h>'s no_free_ptr() with __must_check semantics

    - Fix ww_mutex self-tests

    - Clean up const-propagation in <linux/seqlock.h> and simplify
      the API-instantiation macros a bit.

 - RT locking improvements:

    - Provide the rt_mutex_*_schedule() primitives/helpers and use them
      in the rtmutex code to avoid recursion vs. rtlock on the PI state.

    - Add nested blocking lockdep asserts to rt_mutex_lock(), rtlock_lock()
      and rwbase_read_lock().

 - Plus misc fixes & cleanups

 Thanks,

	Ingo

------------------>
Atul Kumar Pant (1):
      locking/debug: Fix debugfs API return value checks to use IS_ERR()

Ben Wolsieffer (1):
      futex: Don't include process MM in futex key on no-MMU

Cuda-Chen (1):
      locking/seqlock: Fix grammar in comment

Guo Ren (1):
      asm-generic: ticket-lock: Optimize arch_spin_value_unlocked()

Ingo Molnar (1):
      locking/seqlock: Propagate 'const' pointers within read-only methods, remove forced type casts

John Stultz (3):
      locking/ww_mutex/test: Use prng instead of rng to avoid hangs at bootup
      locking/ww_mutex/test: Fix potential workqueue corruption
      locking/ww_mutex/test: Make sure we bail out instead of livelock

Li zeming (1):
      futex/requeue: Remove unnecessary ‘NULL’ initialization from futex_proxy_trylock_atomic()

Lucy Mielke (1):
      locking/lockdep: Fix string sizing bug that triggers a format-truncation compiler-warning

Matthew Wilcox (Oracle) (1):
      futex: Use a folio instead of a page

Oleg Nesterov (2):
      locking/seqlock: Simplify SEQCOUNT_LOCKNAME()
      locking/seqlock: Change __seqprop() to return the function pointer

Peter Zijlstra (5):
      cleanup: Make no_free_ptr() __must_check
      sched: Constrain locks in sched_submit_work()
      sched: Provide rt_mutex specific scheduler helpers
      futex/pi: Fix recursive rt_mutex waiter state
      alpha: Fix up new futex syscall numbers

Sebastian Andrzej Siewior (2):
      locking/rtmutex: Avoid unconditional slowpath for DEBUG_RT_MUTEXES
      locking/rtmutex: Use rt_mutex specific scheduler helpers

Thomas Gleixner (2):
      sched: Extract __schedule_loop()
      locking/rtmutex: Add a lockdep assert to catch potential nested blocking

Uros Bizjak (6):
      locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF for X86_CMPXCHG64
      locking/local, arch: Rewrite local_add_unless() as a static inline function
      locking/atomic: Add generic support for sync_try_cmpxchg() and its fallback
      locking/atomic/x86: Introduce arch_sync_try_cmpxchg()
      locking/atomic, xen: Use sync_try_cmpxchg() instead of sync_cmpxchg()
      locking/atomics: Use atomic_try_cmpxchg_release() to micro-optimize rcuref_put_slowpath()

pangzizhen001@208suo.com (1):
      locking/seqlock: Fix typo in comment

peterz@infradead.org (10):
      futex: Clarify FUTEX2 flags
      futex: Extend the FUTEX2 flags
      futex: Flag conversion
      futex: Validate futex value against futex size
      futex: Add sys_futex_wake()
      futex: FLAGS_STRICT
      futex: Add sys_futex_wait()
      futex: Propagate flags into get_futex_key()
      futex: Add flags2 argument to futex_requeue()
      futex: Add sys_futex_requeue()


 arch/alpha/include/asm/local.h              |  33 ++---
 arch/alpha/kernel/syscalls/syscall.tbl      |   4 +
 arch/arm/tools/syscall.tbl                  |   3 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   6 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   3 +
 arch/loongarch/include/asm/local.h          |  27 ++--
 arch/m68k/kernel/syscalls/syscall.tbl       |   3 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   3 +
 arch/mips/include/asm/local.h               |  27 ++--
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   3 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   3 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   3 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   3 +
 arch/powerpc/include/asm/local.h            |  12 +-
 arch/powerpc/kernel/syscalls/syscall.tbl    |   3 +
 arch/s390/kernel/syscalls/syscall.tbl       |   3 +
 arch/sh/kernel/syscalls/syscall.tbl         |   3 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   3 +
 arch/x86/Kconfig                            |   2 +-
 arch/x86/entry/syscalls/syscall_32.tbl      |   3 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   3 +
 arch/x86/include/asm/cmpxchg.h              |   6 +
 arch/x86/include/asm/local.h                |  33 ++---
 arch/xtensa/kernel/syscalls/syscall.tbl     |   3 +
 drivers/xen/events/events_fifo.c            |  26 ++--
 drivers/xen/grant-table.c                   |  10 +-
 include/asm-generic/spinlock.h              |  16 +-
 include/linux/atomic/atomic-arch-fallback.h |  15 +-
 include/linux/atomic/atomic-instrumented.h  |  10 +-
 include/linux/cleanup.h                     |  39 ++++-
 include/linux/sched.h                       |   3 +
 include/linux/sched/rt.h                    |   4 +
 include/linux/seqlock.h                     |  52 ++++---
 include/linux/syscalls.h                    |  10 ++
 include/uapi/asm-generic/unistd.h           |   8 +-
 include/uapi/linux/futex.h                  |  31 +++-
 kernel/futex/core.c                         |  86 ++++++-----
 kernel/futex/futex.h                        |  86 ++++++++++-
 kernel/futex/pi.c                           |  91 ++++++++----
 kernel/futex/requeue.c                      |  22 +--
 kernel/futex/syscalls.c                     | 221 ++++++++++++++++++++++------
 kernel/futex/waitwake.c                     |  80 +++++-----
 kernel/locking/lock_events.c                |  10 +-
 kernel/locking/lockdep_proc.c               |   2 +-
 kernel/locking/rtmutex.c                    |  37 ++++-
 kernel/locking/rwbase_rt.c                  |   8 +
 kernel/locking/rwsem.c                      |   8 +-
 kernel/locking/spinlock_rt.c                |   6 +
 kernel/locking/test-ww_mutex.c              |  48 ++++--
 kernel/locking/ww_rt_mutex.c                |   2 +-
 kernel/sched/core.c                         |  64 ++++++--
 kernel/sys_ni.c                             |   3 +
 lib/rcuref.c                                |   2 +-
 scripts/atomic/gen-atomic-fallback.sh       |  33 +++--
 scripts/atomic/gen-atomic-instrumented.sh   |   3 +-
 56 files changed, 895 insertions(+), 338 deletions(-)
