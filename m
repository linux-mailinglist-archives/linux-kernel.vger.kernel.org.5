Return-Path: <linux-kernel+bounces-149400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38678A90A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8871F225E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5663839D;
	Thu, 18 Apr 2024 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bf02paVZ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6379F0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403722; cv=none; b=qNUc0Yen4f94Psma321sUB/1IlUds2Ck/JjNgb9eR3YmFYgrCFpxIK/iDWNWdnAe0NIJbuKDzK4LwSfQJFQemfGhLIZMGybMuQmwyW/1SJeR9CbiF2WNYb8383v85R3J4zKecL7mJZ18mMxXWM/vSbfsH+Z0K/n/nuuJvpuoZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403722; c=relaxed/simple;
	bh=IYIEDUiajRbItrVqaU3faDWLV/sZBb8UlE9k8eqdHpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fKvua5DcIUzeZTHNt7xrNJAAllRT8mLGSMkJAFrHw/X+wL4lIYHeufkJGeP9eyG4gzmGiiHvmfVHwd84iGctM+6mo6LYTrsax59kFK+Bga+G/0o1ubS1ksrLU5kTB3EbVdJUEskuBLpH2rA8D/de5oXYRWZvRkU+fEMC3fkKPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bf02paVZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcdc3db67f0so1898904276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713403720; x=1714008520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8iDG18ujjZI6cYwd6gK6QfWKPv05SJ9UjlFR07I8FE=;
        b=Bf02paVZRZjWcBGu/ODe2aEkwfInp/7esEk9obEf+9Yy4bztDhKEMUz5NHnd6N+8s5
         PZPvnvLWtaCQ1JeuzhIja3FpbgAQNulTAgE7fSdL+3pD0C22kNuJyHZ1M8QhB/sash8b
         CTg5PIzNtzzt2I5AbRP4tdWSr+Rf/IKpF6W/Wg33EjfMS3oTYPcQH1oPz/0Z16972pRp
         K3dFC3R9dXgPeYBeiWIpwv/ewuW/pSUMqp8h0qEIJYAD3sAfIRZz4F2rCxXtvuu7u7Xk
         Dq+XieM4qftDDWholBrraIrHisrNys6ndUM84197JPwhXt6paMoOSqeSoEG/YCI509la
         vdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713403720; x=1714008520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8iDG18ujjZI6cYwd6gK6QfWKPv05SJ9UjlFR07I8FE=;
        b=Nr0vkvd4dzZ877+nzJNjQtdjxbcCiKc1UvA732SicHVpQ93lf78DOgt3DPZtWSeggf
         NvBU1ZR1MuYDjW0dcyRa2GjRS0bOQQZlSDcsUINJ8RN7vXKbTPKCV94BgIevgyEkXqp/
         OMMOJ3XGpA9BCk+6YpYSiRSTUXWYiS4zWipOwif2nVFTCyGCLZmflKiIgcH0VUy7Oe8N
         dvtrDk7dJX4BW9inep5Pci0LKSAdR0LhXGYluEtw/QyJCJFw4IIZycjSyNyK6P2Iku8t
         QabeDshSfmSt9OKtBbULrvyMD15vYDosdrl2hdUZghv8MLeJOGgFJYyTkYumTQmGBFWJ
         rLVw==
X-Forwarded-Encrypted: i=1; AJvYcCU5WW5uKh3adHBeTQOlaUlnhfpBoOfW1H11L5ySVlTbS98lJRG0eBzm1huCnq0hXgbsGeYN9eqpwcmyajMASidR3CIiqeQn+NZx4taL
X-Gm-Message-State: AOJu0YyKOGXTK/U3xAc1UytnLShYo7m9PAGYOEtqYw2YheIMNgdHcqvz
	dI1K7xc37srwSCujOgA6GTpy2MD+BfhPqU2e3OKJRdo/+7ciTDnXJlY9vxlc1DlRHNQMSo9yrw1
	NgYp8v5MAphRwC8Dk2w==
X-Google-Smtp-Source: AGHT+IHowabqTIUQAhwGR6H3lDw/MbSxyXp0scJMwSRdUOmCkDeIF9VXDDt3wLoCkgZ1GCn8fBoG90voSyasNhI9
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2b86:b0:dbe:d0a9:2be3 with
 SMTP id fj6-20020a0569022b8600b00dbed0a92be3mr255747ybb.3.1713403720188; Wed,
 17 Apr 2024 18:28:40 -0700 (PDT)
Date: Thu, 18 Apr 2024 01:28:34 +0000
In-Reply-To: <20240418012835.3360429-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418012835.3360429-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418012835.3360429-2-yosryahmed@google.com>
Subject: [PATCH tip:x86/mm v3 2/3] x86/mm: Fix LAM inconsistency during
 context switch
From: Yosry Ahmed <yosryahmed@google.com>
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
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
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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
index c27798f23ef82..cda2918f88f99 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -801,10 +801,12 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
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
index a041d2ecd8380..1fe9ba33c5805 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -11,6 +11,7 @@
 #include <linux/sched/smt.h>
 #include <linux/task_work.h>
 #include <linux/mmu_notifier.h>
+#include <linux/mmu_context.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -632,7 +633,6 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	}
 
 	new_lam = mm_lam_cr3_mask(next);
-	set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
@@ -651,6 +651,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 
 	this_cpu_write(cpu_tlbstate.loaded_mm, next);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
+	cpu_tlbstate_update_lam(new_lam, mm_untag_mask(next));
 
 	if (next != prev) {
 		cr4_update_pce_mm(next);
@@ -697,6 +698,7 @@ void initialize_tlbstate_and_flush(void)
 	int i;
 	struct mm_struct *mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u64 tlb_gen = atomic64_read(&init_mm.context.tlb_gen);
+	unsigned long lam = mm_lam_cr3_mask(mm);
 	unsigned long cr3 = __read_cr3();
 
 	/* Assert that CR3 already references the right mm. */
@@ -704,7 +706,7 @@ void initialize_tlbstate_and_flush(void)
 
 	/* LAM expected to be disabled */
 	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
-	WARN_ON(mm_lam_cr3_mask(mm));
+	WARN_ON(lam);
 
 	/*
 	 * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initialization
@@ -723,7 +725,7 @@ void initialize_tlbstate_and_flush(void)
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
-	set_tlbstate_lam_mode(mm);
+	cpu_tlbstate_update_lam(lam, mm_untag_mask(mm));
 
 	for (i = 1; i < TLB_NR_DYN_ASIDS; i++)
 		this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);
-- 
2.44.0.683.g7961c838ac-goog


