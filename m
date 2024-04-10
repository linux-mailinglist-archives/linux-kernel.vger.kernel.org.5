Return-Path: <linux-kernel+bounces-138324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9722889EFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8642824F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27551158D97;
	Wed, 10 Apr 2024 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNLA7Tdj"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B667154BEE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744841; cv=none; b=scIwZzCDqATOvR1xR3a38B5wHGJEOhy5mv7Xk52dOqx5jn90rvbnyLfO8p46/Wdcfrktu+jS7B2VxeNZv/U9Jl2SIZFQrXT8Gxd9tFCpc5bPycVE/r6v5b+CJhQY17ebwlibInwdiiOGtykHjxb37OyZANefDVOn1OPEVvzaYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744841; c=relaxed/simple;
	bh=0Lq08+IjLLZBrFtz4LDPMM4rFRn/yzENsF29mP27i0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UihgldLLC/MzzR4/7R4FkKFRNU10Go2+oQrB9mUtKVwsaQ3RC9/rVM8SvbPlC1PBxv5c1pEmtGKUHlWtyQkDHm1MXya6AMVj5IJkWqHMRP9DiLnkZ84bu263MQbcRlO3HnIR8s/6bYVjh8BpcsAdnFex0EH6X+BCi0UgqBxTpI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HNLA7Tdj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0bec01232so53654075ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712744839; x=1713349639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=opuo7Ydaxm/K6zjzo+nQLmHyUVs/0K11f0aTIiezFNo=;
        b=HNLA7TdjmFO5zl30T4NbKdsgeC6AuFMplmE1YVkdl81bf2vpLIxt4k11PCYosdKyEh
         K3W/RNvfT2h1WUZ4871qR7rAp4MJDfZjgRjRvEaydabMeA7vAudQXmJYnJ7b2iBtUH6q
         M0wL2qcsw32RPrq4JrDR5ab4l/xnLTi9Wqb6f0aSAzfiwlOZep9ZS/SrWypqfKM5HAes
         TDBFK+4Hp1KuylQ2le56xQpskyQHfrXOIP39cdcH1oTg0qkTa8hPdntKySlCuGvxlJMz
         mgAX6gT3lqAr75fBvvzFLUkWvEhyqs7DpQO/3b1XY/usVsCQfB2SxpU8IyyR/bkTbcmW
         JuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712744839; x=1713349639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opuo7Ydaxm/K6zjzo+nQLmHyUVs/0K11f0aTIiezFNo=;
        b=S6HmyHuYIb62MCJvRSpQOFJOgCih3Iv5+BSjynJp49ui3XC5vq++ufXqjXUvWtHf9i
         KHDL96DuYlra/giE64LKvgayu0bJLXJDrVB60ikWdcVjuftordW/VcaT8vWJ4BqtAFex
         5Nl8erGYNvfOOSmwVJref3rjJw5G2l8JqIpC5LGnima7pnRo1OUr57hhC/PsMOXQvcdK
         bCEyJji82a+br+Mqsf6NBq+J6DF9e3LIRn45hjmLKKHHfqKAfPYFtQwXeFeBwSc3v0Jh
         UiNbkdqGkhXJ3XBwoL8VK0IeprPeDTDQ/wBsbTuJlA8wyJE/Owbi9eOwfSDQzK6C+eQj
         AfJg==
X-Forwarded-Encrypted: i=1; AJvYcCUyxbBRUB0tWYCbf96PjTL+g6YKTkMdZtVhGkL9FdXN/mWVCqtxTY0DGC+lalZ0tpijQEwcg3wXooq2jjuGOLjain/DpJOsqHF5BTZP
X-Gm-Message-State: AOJu0YwgxADewehAalv4iL1x3y4830tqaCdtVx9vKh7ous9FqJ4KRQ4B
	cRHLSZbfPtTPJx5kf7h45wfu8QnwOMkqvpNQeCfozu5cd3NqaLv3Np0GIphPFg8=
X-Google-Smtp-Source: AGHT+IGvzWg3OcsdlV+PuYJDV5K2XtH1kMIFCR3N5/l1CMWKVb74rw8WBNvqRMoI3WKueRWlumuslA==
X-Received: by 2002:a17:903:2d2:b0:1e4:7ca3:8a33 with SMTP id s18-20020a17090302d200b001e47ca38a33mr2096315plk.17.1712744838634;
        Wed, 10 Apr 2024 03:27:18 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c00c:2308:dfb0:469d:eb46:b70f])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902d50700b001e27c404922sm2695814plg.130.2024.04.10.03.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 03:27:17 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: lkft-triage@lists.linaro.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	anders.roxell@linaro.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	linux@roeck-us.net,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq next-20240410
Date: Wed, 10 Apr 2024 15:57:10 +0530
Message-Id: <20240410102710.35911-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following kernel crash noticed on Linux next-20240410 tag while running
kunit testing on qemu-arm64 and qemu-x86_64.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Crash log on qemu-arm64:
----------------
<3>[ 30.465716] BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq (include/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
<3>[   30.467097] Write of size 4 at addr 0000000000000008 by task swapper/0/1
<3>[   30.468059]
<3>[   30.468393] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B            N 6.9.0-rc3-next-20240410 #1
<3>[   30.469209] Hardware name: linux,dummy-virt (DT)
<3>[   30.469645] Call trace:
<3>[ 30.469919] dump_backtrace (arch/arm64/kernel/stacktrace.c:319) 
<3>[ 30.471622] show_stack (arch/arm64/kernel/stacktrace.c:326) 
<3>[ 30.472124] dump_stack_lvl (lib/dump_stack.c:117) 
<3>[ 30.472947] print_report (mm/kasan/report.c:493) 
<3>[ 30.473755] kasan_report (mm/kasan/report.c:603) 
<3>[ 30.474524] kasan_check_range (mm/kasan/generic.c:175 mm/kasan/generic.c:189) 
<3>[ 30.475094] __kasan_check_write (mm/kasan/shadow.c:38) 
<3>[ 30.475683] _raw_spin_lock_irq (include/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
<3>[ 30.476257] wait_for_completion_timeout (kernel/sched/completion.c:84 kernel/sched/completion.c:116 kernel/sched/completion.c:127 kernel/sched/completion.c:167) 
<3>[ 30.476909] kunit_try_catch_run (lib/kunit/try-catch.c:86) 
<3>[ 30.477628] kunit_run_case_catch_errors (lib/kunit/test.c:544) 
<3>[ 30.478311] kunit_run_tests (lib/kunit/test.c:635) 
<3>[ 30.478865] __kunit_test_suites_init (lib/kunit/test.c:729 (discriminator 1)) 
<3>[ 30.479482] kunit_run_all_tests (lib/kunit/executor.c:276 lib/kunit/executor.c:392) 
<3>[ 30.480079] kernel_init_freeable (init/main.c:1578) 
<3>[ 30.480747] kernel_init (init/main.c:1465) 
<3>[ 30.481474] ret_from_fork (arch/arm64/kernel/entry.S:861) 
<3>[   30.482080] ==================================================================
<1>[   30.484503] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
<1>[   30.485369] Mem abort info:
<1>[   30.485923]   ESR = 0x000000009600006b
<1>[   30.486943]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[   30.487540]   SET = 0, FnV = 0
<1>[   30.488007]   EA = 0, S1PTW = 0
<1>[   30.488509]   FSC = 0x2b: level -1 translation fault
<1>[   30.489150] Data abort info:
<1>[   30.489610]   ISV = 0, ISS = 0x0000006b, ISS2 = 0x00000000
<1>[   30.490360]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
<1>[   30.491057]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[   30.491822] [0000000000000008] user address but active_mm is swapper
<0>[   30.493008] Internal error: Oops: 000000009600006b [#1] PREEMPT SMP
<4>[   30.494105] Modules linked in:
<4>[   30.496244] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B            N 6.9.0-rc3-next-20240410 #1
<4>[   30.497171] Hardware name: linux,dummy-virt (DT)
<4>[   30.497905] pstate: 224000c9 (nzCv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
<4>[ 30.498895] pc : _raw_spin_lock_irq (arch/arm64/include/asm/atomic_lse.h:271 arch/arm64/include/asm/cmpxchg.h:120 arch/arm64/include/asm/cmpxchg.h:169 include/linux/atomic/atomic-arch-fallback.h:2055 include/linux/atomic/atomic-arch-fallback.h:2173 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
<4>[ 30.499542] lr : _raw_spin_lock_irq (include/linux/atomic/atomic-arch-fallback.h:2172 (discriminator 1) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 1) include/asm-generic/qspinlock.h:111 (discriminator 1) include/linux/spinlock.h:187 (discriminator 1) include/linux/spinlock_api_smp.h:120 (discriminator 1) kernel/locking/spinlock.c:170 (discriminator 1)) 

<trim>

<4>[   30.511022] Call trace:
<4>[ 30.511437] _raw_spin_lock_irq (arch/arm64/include/asm/atomic_lse.h:271 arch/arm64/include/asm/cmpxchg.h:120 arch/arm64/include/asm/cmpxchg.h:169 include/linux/atomic/atomic-arch-fallback.h:2055 include/linux/atomic/atomic-arch-fallback.h:2173 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
<4>[ 30.512013] wait_for_completion_timeout (kernel/sched/completion.c:84 kernel/sched/completion.c:116 kernel/sched/completion.c:127 kernel/sched/completion.c:167) 
<4>[ 30.512627] kunit_try_catch_run (lib/kunit/try-catch.c:86) 
<4>[ 30.513188] kunit_run_case_catch_errors (lib/kunit/test.c:544) 
<4>[ 30.513801] kunit_run_tests (lib/kunit/test.c:635) 
<4>[ 30.514674] __kunit_test_suites_init (lib/kunit/test.c:729 (discriminator 1)) 
<4>[ 30.515259] kunit_run_all_tests (lib/kunit/executor.c:276 lib/kunit/executor.c:392) 
<4>[ 30.515831] kernel_init_freeable (init/main.c:1578) 
<4>[ 30.516384] kernel_init (init/main.c:1465) 
<4>[ 30.516900] ret_from_fork (arch/arm64/kernel/entry.S:861) 
<0>[ 30.518151] Code: 93407c02 d503201f 2a0003e1 52800022 (88e17e62)
All code
========
   0:	93407c02 	sxtw	x2, w0
   4:	d503201f 	nop
   8:	2a0003e1 	mov	w1, w0
   c:	52800022 	mov	w2, #0x1                   	// #1
  10:*	88e17e62 	casa	w1, w2, [x19]		<-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:	88e17e62 	casa	w1, w2, [x19]
<4>[   30.519501] ---[ end trace 0000000000000000 ]---
<6>[   30.520317] note: swapper/0[1] exited with irqs disabled
<6>[   30.521355] note: swapper/0[1] exited with preempt_count 1
<0>[   30.523129] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
<2>[   30.524397] SMP: stopping secondary CPUs
<0>[   30.525553] Kernel Offset: 0x25148d400000 from 0xffff800080000000
<0>[   30.528341] PHYS_OFFSET: 0x40000000
<0>[   30.529003] CPU features: 0x0,00000006,8f17bd7c,6766773f
<0>[   30.530313] Memory Limit: none
<0>[   30.531319] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Steps to reproduce:
---
https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2etdCz631GU6PILJzs8reteba8i/reproducer

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240410/testrun/23381881/suite/log-parser-test/tests/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2etdCz631GU6PILJzs8reteba8i
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2etdDjlx3eRFhhK9cy2UsEHAXTr

--
Linaro LKFT
https://lkft.linaro.org

