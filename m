Return-Path: <linux-kernel+bounces-100481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B6787986E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009A01C20D30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5C47E58E;
	Tue, 12 Mar 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EClBwfqu"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940867D076
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259015; cv=none; b=E+vFukthgX1O+8BbuH6oqtN+6kJ1qmP0IafNaqvjJGqHILtpfZWgt3KuLDDj1LVnNjGjIfSauQsm+t7eEjbTjCSOOnEAv99V7wWSt/EVRnmAnFZtv0p6WXpqNwR5oH0eXTfMznpStD3NrQLQgLiZHrS9yXf8C4VOa8oo7P4ffmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259015; c=relaxed/simple;
	bh=cBU6IbDZCoUNgvNZgIk6OdD5MawDTelGS2xO4llaiPE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EuXXMdabiB44HSatiKtzQN+0sgDBA9Vgnz9hxMDPP1TAat58T4XFHfPLWVFAh63Qg+xejhqEhkwllRiiVmOk0GUJgOCuyRzDjbkUVPMzm3SvMY3kzZ96w9QrgSOhmt5PSfFrtXd5n2Y2P57F7pqHv0kI3xxKw7SvD3KHhpWPvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EClBwfqu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so10232529276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710259012; x=1710863812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dGVz1SMb2zVErgYS/f8v/LIvaYP5LVM/6U9nkrrlBVE=;
        b=EClBwfquJYn+ZSYcjfz8uGkvs4WWjE+hakmD05I4+hRDaIPwNIYi4L9u3WLauJS+io
         XRwqmUcp75srWtjJqzCz64QmWMH2Al/ZwWiqwTlWhLuuC7zBH46mHIsEZ9uvhEvbvxLj
         Fad7F9qDgeaFazCegNgU+T0sFDsCT1HHPCAyU4c22OLmNqz1ZszB2nuRWd1Dzvr9PER0
         MokY6op8MXmVxKTQATtvNOSAPXqnwR/DpAkU9NJl31KYBUFUluHFYuEB+d4ADvz9a7QI
         KbSlCsK6RLpw57dMgkWVwvgxfhL7ENvPzxanaKLETv0zUcEAzXfzo+v7gbfWirZ9dNbT
         X5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259012; x=1710863812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGVz1SMb2zVErgYS/f8v/LIvaYP5LVM/6U9nkrrlBVE=;
        b=gqKB4+iUFgKgTD1ko1nZTE/Jq/x9DcXxPN3hmxK4cNtKItpVce+rCam+6ti6q3EIhd
         bByi6eueEe0l7UJUmFdbYwkHJYq17TYl/ENUkpAX3ZSG+5nqORhEVcYEfInr4hBD9oXk
         dNVy5WnWl2EZ4BjYypCJ9kBSkoQxltVgu7bjT3316tFgjSwo0wf8hOu7i9rQ7df8W3+n
         9gwRkD8EH4VrZTUJE3A22RWR2QEwFC7mB2tnqFMSBfnEBPbqk29zFUriW9nexyXPjFnI
         dTSfimLzgt1SycOjmMs/1R26NhPE3oWfC356qAeXzxqmT4g8DtXG9JH/O46cIuXJS/Tg
         cKog==
X-Forwarded-Encrypted: i=1; AJvYcCWyiMHgbLJxuUf+73xYv+U3PCMDOcklrHjcBl8zbszoOXPdbvr22kLFVvymvbE6xjjXZ6FqB1OhjJq1OHSmUPGJqnDc0zwiVo77Sj9Z
X-Gm-Message-State: AOJu0YzjNGgtST4TQHuK+tNi81SXnQ0NY6g+70a2JT7lDOGkdHVzGA2v
	Pg95PIvsQNFnPvMXpnnwrVdk2AEEIaGtAVWGMZ5HV2ck6MqNUBxUys+jPO4l0USIM26d93GD/uD
	N6l+oavaqZxh4DSH4Pg==
X-Google-Smtp-Source: AGHT+IEWr4BUvfejWnq0y5OUGkVPSF87K17RjNhILNkA1XXGVsqD9DHHQ9r1YalvT3IW9/ZqycxovNLaT6NPWZZp
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:70a:b0:dc7:68b5:4f3d with SMTP
 id k10-20020a056902070a00b00dc768b54f3dmr2745152ybt.11.1710259012661; Tue, 12
 Mar 2024 08:56:52 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:56:40 +0000
In-Reply-To: <20240312155641.4003683-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240312155641.4003683-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240312155641.4003683-2-yosryahmed@google.com>
Subject: [PATCH v2 2/3] x86/mm: Fix LAM inconsistency during context switch
From: Yosry Ahmed <yosryahmed@google.com>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

LAM can only be enabled when a process is single-threaded.  But _kernel_
threads can temporarily use a single-threaded process's mm.  That means
that a context-switching kernel thread can race and observe the mm's LAM
metadata (mm->context.lam_cr3_mask) change.

The context switch code does two logical things with that metadata:
populate CR3 and populate 'cpu_tlbstate.lam'.  If it hits this race,
'cpu_tlbstate.lam' and CR3 can end up out of sync.

This de-synchronization is currently harmless.  But it is confusing and
might lead to warnings or real bugs.

Update set_tlbstate_lam_mode() to take in the LAM mask and untag mask
instead of an mm_struct pointer, and while we are at it, rename it to
cpu_tlbstate_update_lam(). This should also make it clearer that we are
updating cpu_tlbstate. In switch_mm_irqs_off(), read the LAM mask once
and use it for both the cpu_tlbstate update and the CR3 update.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/include/asm/mmu_context.h | 8 +++++++-
 arch/x86/include/asm/tlbflush.h    | 9 ++++-----
 arch/x86/kernel/process_64.c       | 6 ++++--
 arch/x86/mm/tlb.c                  | 8 +++++---
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 8dac45a2c7fcf..19091ebb86338 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -88,7 +88,13 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 #ifdef CONFIG_ADDRESS_MASKING
 static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
 {
-	return mm->context.lam_cr3_mask;
+	/*
+	 * When switch_mm_irqs_off() is called for a kthread, it may race with
+	 * LAM enablement. switch_mm_irqs_off() uses the LAM mask to do two
+	 * things: populate CR3 and populate 'cpu_tlbstate.lam'. Make sure it
+	 * reads a single value for both.
+	 */
+	return READ_ONCE(mm->context.lam_cr3_mask);
 }
 
 static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 25726893c6f4d..69e79fff41b80 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -399,11 +399,10 @@ static inline  u64 tlbstate_lam_cr3_mask(void)
 	return lam << X86_CR3_LAM_U57_BIT;
 }
 
-static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+static inline void cpu_tlbstate_update_lam(unsigned long lam, u64 untag_mask)
 {
-	this_cpu_write(cpu_tlbstate.lam,
-		       mm->context.lam_cr3_mask >> X86_CR3_LAM_U57_BIT);
-	this_cpu_write(tlbstate_untag_mask, mm->context.untag_mask);
+	this_cpu_write(cpu_tlbstate.lam, lam >> X86_CR3_LAM_U57_BIT);
+	this_cpu_write(tlbstate_untag_mask, untag_mask);
 }
 
 #else
@@ -413,7 +412,7 @@ static inline u64 tlbstate_lam_cr3_mask(void)
 	return 0;
 }
 
-static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+static inline void cpu_tlbstate_update_lam(unsigned long lam, u64 untag_mask)
 {
 }
 #endif
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 76e91fc68c5f3..3dd8c1f51e45c 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -753,10 +753,12 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 static void enable_lam_func(void *__mm)
 {
 	struct mm_struct *mm = __mm;
+	unsigned long lam;
 
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm) {
-		write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
-		set_tlbstate_lam_mode(mm);
+		lam = mm_lam_cr3_mask(mm);
+		write_cr3(__read_cr3() | lam);
+		cpu_tlbstate_update_lam(lam, mm_untag_mask(mm));
 	}
 }
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e8feb2e154db2..b2f74c451b3d7 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -11,6 +11,7 @@
 #include <linux/sched/smt.h>
 #include <linux/task_work.h>
 #include <linux/mmu_notifier.h>
+#include <linux/mmu_context.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -635,7 +636,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	}
 
 	new_lam = mm_lam_cr3_mask(next);
-	set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
@@ -654,6 +654,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 	this_cpu_write(cpu_tlbstate.loaded_mm, next);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
+	cpu_tlbstate_update_lam(new_lam, mm_untag_mask(next));
 
 	if (next != real_prev) {
 		cr4_update_pce_mm(next);
@@ -700,6 +701,7 @@ void initialize_tlbstate_and_flush(void)
 	int i;
 	struct mm_struct *mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u64 tlb_gen = atomic64_read(&init_mm.context.tlb_gen);
+	unsigned long lam = mm_lam_cr3_mask(mm);
 	unsigned long cr3 = __read_cr3();
 
 	/* Assert that CR3 already references the right mm. */
@@ -707,7 +709,7 @@ void initialize_tlbstate_and_flush(void)
 
 	/* LAM expected to be disabled */
 	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
-	WARN_ON(mm_lam_cr3_mask(mm));
+	WARN_ON(lam);
 
 	/*
 	 * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initialization
@@ -726,7 +728,7 @@ void initialize_tlbstate_and_flush(void)
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
-	set_tlbstate_lam_mode(mm);
+	cpu_tlbstate_update_lam(lam, mm_untag_mask(mm));
 
 	for (i = 1; i < TLB_NR_DYN_ASIDS; i++)
 		this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);
-- 
2.44.0.278.ge034bb2e1d-goog


