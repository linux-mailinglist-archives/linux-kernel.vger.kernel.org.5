Return-Path: <linux-kernel+bounces-95630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D6187507E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AAB1F21A46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4BB12FF6A;
	Thu,  7 Mar 2024 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zx7Vkg3g"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7815E130ACA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818763; cv=none; b=PZJhLjV9UzE2QjU9di1x7CFtRztREER5IJ7J0daRJB70TG3K6xfsT+eWedl8bWD6hotaF4GN530qQM9u8ceLInvG7VFVGGvqJrQuNmfhQ3sQgR/gefvaGwLngsqrR2Vf27glATI6N3Ax/NY7OIb4t/b2vtjYYxgXdcA6CDPcuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818763; c=relaxed/simple;
	bh=CkGUu5iKOB4hylFvKrOuEk3Gf3BVrPIfJ9cEZ1Ss+zQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QO/umQXE+zXQX0PO3zUffG1PhwwQWfZPXlCjH4fjvpFI1BvolrGOnx+ds3iM5U20JA9eOlnu0DEwUu/ht4VFEDKt+/rYFhK6LF1ee7+/5uS6xCMIDtg64uZTS9jm38+n5iBccx69kIXlG15UtXUfkE6ETHghVmP3YDWdeKPy1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zx7Vkg3g; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ad239f8fso16024317b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 05:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709818760; x=1710423560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XhRtgDTyBtYE/TCEGVA0Jcde7nXTTPmxFYt2TI6fczU=;
        b=Zx7Vkg3gmuEvcOqF1894NQ6GziMBnQ41Z9vHnavu53R1t2SDMajOaaAvs+kUGZJTPC
         E6sJHx4yuKhUUWeqsmPEHdU1+41KjwVI4i4XWyrKwuyRW8HMcqrj5G7ci34r4P8GiqhL
         AB77D58MNlMP+49FiEnSCMQ6rBxSz3YJk9IXmRxEFJoeYfiTmQjjFckxRinL6/S+9ifk
         lZsDFkVmF2hB62Y+Xcr3zKyXyjecrziksgLWzjJi4A3/PP9Uxn5VW5nSDISeuOGuJgsp
         RlLpSgMw0agYfO7GaxQfBUFxu18Otve4lZnPmXH0ALc81nLTnjqbtt7J9D+u0kl4a/fg
         RnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709818760; x=1710423560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhRtgDTyBtYE/TCEGVA0Jcde7nXTTPmxFYt2TI6fczU=;
        b=Sx19m53/tMXQT0jkOUmVQLI2/NVzwiKW7hCAOg0QvgeIZM2xrHSodXFHEdfwpWLYUX
         1shQ4Vyo+0ZvSBQhBNHwRcCYEL2EKerMpLz2zQYgCmYx1EHoJ5CIfdknJCifVa6RSmBd
         nT7TqCIEFgedkrmXZlzDlQdctFQ249GSrERldmqZkVJwn2R4tGr55RdYI4CzdXxaO6AD
         lYR22D6f6tw/ChgYkuFG50X4YCNcDnjispERaX0hhIUEJVgsvzX04q5OKBpO8goSzmR0
         8mNKcTIO4cqtYULvFKvICmsY8K7m5p1EbUlpGULzYfm2VwdLbtFfIeYPv36oye8zUldy
         +FvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwkdlYQsnIcLlWKSWQggIa64a7YR+EpL1W5CcT8ru+wHYoB4T8s27Sa0By1IXZcuOGcKKLk2+JRaEq9ghwdVca1H51oswZd/blZOvV
X-Gm-Message-State: AOJu0YyDCELUDFn7pHf9VB5vp2aFdgcZGNqYSJUII/ube3E7DCn1kGde
	Cix3r2ooa53Ga0eyEOEoqaL6iqhtFFfgzaQQnGgWt0fnmWJUi0I+TSIPDqElmMJWWPKSEZq9TRB
	456TKiiZU01hPEgmREw==
X-Google-Smtp-Source: AGHT+IFRqFk4oamlQows6KoGWBh8WrwoJ8kNbWyjPiHy+1cnclmprEIfJ2rYatkNe3gWdYcqZi/b1yYDg6XF3ZIA
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:ab0e:0:b0:dc6:519b:5425 with SMTP
 id u14-20020a25ab0e000000b00dc6519b5425mr4354682ybi.11.1709818760421; Thu, 07
 Mar 2024 05:39:20 -0800 (PST)
Date: Thu,  7 Mar 2024 13:39:14 +0000
In-Reply-To: <20240307133916.3782068-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307133916.3782068-2-yosryahmed@google.com>
Subject: [RFC PATCH 1/3] x86/mm: fix LAM cr3 mask inconsistency during context switch
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

In switch_mm_irqs_off(), we read the 'mm->context.lam_cr3_mask' into
'new_lam', which is later passed to load_new_mm_cr3(). However, there is
a call to set_tlbstate_lam_mode() in between which will read
'mm->context.lam_cr3_mask' again and set 'cpu_tlbstate.lam' accordingly.
If we race with another thread updating 'mm->context.lam_cr3_mask', the
value in 'cpu_tlbstate.lam' could end up being different from CR3.

Fix the problem by updating set_tlbstate_lam_mode() to return the LAM
mask that was set to 'cpu_tlbstate.lam', and use that mask in
switch_mm_irqs_off() when writing CR3. Use READ_ONCE to make sure we
read the mask once and use it consistenly.

No practical problems have been observed from this, but it's a recipe
for future problems (e.g. debug warnings in switch_mm_irqs_off() or
__get_current_cr3_fast() could fire). It is unlikely that this can cause
any real issues since only a single-threaded process can update its own
LAM mask, so the race here could happen when context switching between
kthreads using a borrowed MM. In this case, it's unlikely that LAM is
important. If it is, then we would need to ensure all CPUs using the mm
are updated before returning to userspace when LAM is enabled -- but we
don't do that.

While we are at it, remove the misguiding comment that states that
'new_lam' may not match tlbstate_lam_cr3_mask() if a race occurs. This
can happen without a race, a different thread could have just enabled
LAM since the last context switch on the current CPU. Replace it with a
hopefully clearer comment above set_tlbstate_lam_mode().

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 arch/x86/include/asm/tlbflush.h | 11 +++++++----
 arch/x86/mm/tlb.c               | 17 ++++++++---------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 25726893c6f4d..a4ddb20f84fe7 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -399,11 +399,13 @@ static inline  u64 tlbstate_lam_cr3_mask(void)
 	return lam << X86_CR3_LAM_U57_BIT;
 }
 
-static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+static inline unsigned long set_tlbstate_lam_mode(struct mm_struct *mm)
 {
-	this_cpu_write(cpu_tlbstate.lam,
-		       mm->context.lam_cr3_mask >> X86_CR3_LAM_U57_BIT);
+	unsigned long lam = READ_ONCE(mm->context.lam_cr3_mask);
+
+	this_cpu_write(cpu_tlbstate.lam, lam >> X86_CR3_LAM_U57_BIT);
 	this_cpu_write(tlbstate_untag_mask, mm->context.untag_mask);
+	return lam;
 }
 
 #else
@@ -413,8 +415,9 @@ static inline u64 tlbstate_lam_cr3_mask(void)
 	return 0;
 }
 
-static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+static inline unsigned long set_tlbstate_lam_mode(struct mm_struct *mm)
 {
+	return 0;
 }
 #endif
 #endif /* !MODULE */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 51f9f56941058..2975d3f89a5de 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -503,9 +503,9 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 {
 	struct mm_struct *prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	unsigned long new_lam = mm_lam_cr3_mask(next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
+	unsigned long new_lam;
 	u64 next_tlb_gen;
 	bool need_flush;
 	u16 new_asid;
@@ -561,11 +561,6 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
 
-		/*
-		 * If this races with another thread that enables lam, 'new_lam'
-		 * might not match tlbstate_lam_cr3_mask().
-		 */
-
 		/*
 		 * Even in lazy TLB mode, the CPU should stay set in the
 		 * mm_cpumask. The TLB shootdown code can figure out from
@@ -633,7 +628,12 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		barrier();
 	}
 
-	set_tlbstate_lam_mode(next);
+	/*
+	 * Even if we are not actually switching mm's, another thread could have
+	 * updated mm->context.lam_cr3_mask. Make sure tlbstate_lam_cr3_mask()
+	 * and the loaded CR3 use the up-to-date mask.
+	 */
+	new_lam = set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
@@ -705,7 +705,6 @@ void initialize_tlbstate_and_flush(void)
 
 	/* LAM expected to be disabled */
 	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
-	WARN_ON(mm_lam_cr3_mask(mm));
 
 	/*
 	 * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initialization
@@ -724,7 +723,7 @@ void initialize_tlbstate_and_flush(void)
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
-	set_tlbstate_lam_mode(mm);
+	WARN_ON(set_tlbstate_lam_mode(mm));
 
 	for (i = 1; i < TLB_NR_DYN_ASIDS; i++)
 		this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);
-- 
2.44.0.278.ge034bb2e1d-goog


