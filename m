Return-Path: <linux-kernel+bounces-39737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCBF83D591
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78978288529
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB40D125AB;
	Fri, 26 Jan 2024 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bk+TCGZZ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C759664B0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256410; cv=none; b=FuFi52Z1VMuQk/Z8K2S9GrkXLNxn8T6t+lcRnVcR0uxijMR+GA2KLFwRoJTwsudAJPd5fZZnfzc8K1zoviPG+yCcyyIFTRHJ3e37NmS+0xJkKZ77g1V8fyN69oqUiYTmiV0LLJSkIfrciZCUbItyk04cG7WClUZZ81fGvMwU7PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256410; c=relaxed/simple;
	bh=f5YIcX20Bh0LYJB3yql1WUvlZJIPSskbM4xvKEI0BGA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pCHr/1wSvR3P6zbLcmwG6qErXyOnU1sZRVBqh48DWhFtBCiSvGfQv9zJzdWK9SKtxu2bxxjOdgB5DmZGn4tp72hkXTPkb9mCQStOUGQ15bnJ4S4MqOQduJWzJJfiGEuDOxOcT5VC9WJiYNkldrQlJLOUOkUsjnxyZRknFSYZb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bk+TCGZZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-602d22a54caso449407b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706256407; x=1706861207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q+MkK7elkwozxtf29PmL54XsONOmn3SLZnF2nfqAuzw=;
        b=Bk+TCGZZcIKiUI6L21LTRdWZ3Y8J0MSUHlKP0394Z/Zm32xvdKtoeOdALe+NaM8/rw
         LENwrS8WOq/fkYwbQPODKRcZW+YHrVp5AClattn4Lz6nlc6TJroxDx22TMwu6saTGuE0
         LE4FQR8vuM/ojC8etjnMxwnk4oYyWyTd6kyg5hAhaXw9Pat2MFFHiidZcYKFe+X0CbOC
         6sVfryMv9fUhiR6l13fpWGedN6WrEOxG/iV1Mm25LJGXv1Ukv44N0PaSXnD7a84EX5C2
         4lm4/G6gwoc/GBTabmyd3SEHw9nS5Fumo/2KLLwKOrAcj7bq2Odkr8Y2Qlf5MG2a1YF/
         SqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706256407; x=1706861207;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+MkK7elkwozxtf29PmL54XsONOmn3SLZnF2nfqAuzw=;
        b=PoYz7m7sRuu00Qz7conO7YenN+G+naDtpQpROYXK88QAnnL8xgY2s+utbGjXKmdlJC
         WRfFthN84Dyl955DaRDNFFdgtc9RZKGtZUudYy9vDDJL5I+pKwP0iLXax68XxFYTrzb3
         14L4M/v2RNOk5m6+JRyO1ckE7lETDRL/HdhuE5IJY0mBH8L+/VVs/D2tP5BunPN7UgzW
         Ivd9I+Fbs4UVSzoLGA6lfJkqrqGDJUTG4mVfgC/wsKtqn0MK+gmyo4uHSrIwm2NTmONk
         lqmnFxd9y+BoQtOvMkjZaXZvYshpsgXrLObO9rQ54hubAHH+U1E0LIxWyUoIefq9uOL9
         31Ww==
X-Gm-Message-State: AOJu0YzTkh66ODFyQORedsODTDJB86xebgGF6M9pKcl8i1yyV5yy3Nxw
	paHajU0pjFa1L/zC/5TSgU6fawyFWyb0qNm3dH10ue5F9C+2bYuzeAtB8Owa6phI4HyC8eZugaX
	CLtRjA6keE6STpwISXQ==
X-Google-Smtp-Source: AGHT+IGU5QcjnbH97KOXGogNkkBb9OokhEIyAYw9IuZL/21fWEaWMGFuIPPbGaaXup7UnihTrxa26iMXfIYaPd+W
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:99cc:0:b0:5e7:12cc:a60f with SMTP
 id q195-20020a8199cc000000b005e712cca60fmr380957ywg.6.1706256407325; Fri, 26
 Jan 2024 00:06:47 -0800 (PST)
Date: Fri, 26 Jan 2024 08:06:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126080644.1714297-1-yosryahmed@google.com>
Subject: [PATCH 1/2] x86/mm: delete unused cpu argument to leave_mm()
From: Yosry Ahmed <yosryahmed@google.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

The argument is unused since commit 3d28ebceaffa ("x86/mm: Rework lazy
TLB to track the actual loaded mm"), delete it.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/include/asm/mmu.h    | 2 +-
 arch/x86/kernel/alternative.c | 2 +-
 arch/x86/mm/tlb.c             | 2 +-
 arch/x86/xen/mmu_pv.c         | 2 +-
 drivers/cpuidle/cpuidle.c     | 2 +-
 include/linux/mmu_context.h   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 0da5c227f490c..ce4677b8b7356 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -75,7 +75,7 @@ typedef struct {
 		.lock = __MUTEX_INITIALIZER(mm.context.lock),		\
 	}
 
-void leave_mm(int cpu);
+void leave_mm(void);
 #define leave_mm leave_mm
 
 #endif /* _ASM_X86_MMU_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index cc130b57542ac..66bd265c7a587 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1805,7 +1805,7 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	 * restoring the previous mm.
 	 */
 	if (this_cpu_read(cpu_tlbstate_shared.is_lazy))
-		leave_mm(smp_processor_id());
+		leave_mm();
 
 	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	switch_mm_irqs_off(NULL, mm, current);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5768d386efab6..80b0caa82a91b 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -299,7 +299,7 @@ static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, unsigned long lam,
 	write_cr3(new_mm_cr3);
 }
 
-void leave_mm(int cpu)
+void leave_mm(void)
 {
 	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 72af496a160c8..218773cfb009f 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -913,7 +913,7 @@ static void drop_mm_ref_this_cpu(void *info)
 	struct mm_struct *mm = info;
 
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm)
-		leave_mm(smp_processor_id());
+		leave_mm();
 
 	/*
 	 * If this cpu still has a stale cr3 reference, then make sure
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 737a026ef58a3..02e40fd7d948c 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -237,7 +237,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 	}
 
 	if (target_state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
-		leave_mm(dev->cpu);
+		leave_mm();
 
 	/* Take note of the planned idle state. */
 	sched_idle_set_state(target_state);
diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index f2b7a3f040999..bbaec80c78c50 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -11,7 +11,7 @@
 #endif
 
 #ifndef leave_mm
-static inline void leave_mm(int cpu) { }
+static inline void leave_mm(void) { }
 #endif
 
 /*
-- 
2.43.0.429.g432eaa2c6b-goog


