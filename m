Return-Path: <linux-kernel+bounces-14918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9134A822474
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F4828549E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB35918C35;
	Tue,  2 Jan 2024 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bfZ/XZFv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E8619471
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce2170b716so4730641a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704232905; x=1704837705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7sRColwM16ZDpkHsKhbx/H1UjX1V2ZP/gk6hKZVk/k=;
        b=bfZ/XZFvnuIlbRaPhiMl3TU27P/xztx2cS1Kj3kl7/uEFDQZZurqnQ7s5bw2wKOnts
         EnnRARcDRCwsp1t0lPh/w3kOVUQ4wm3Hx6w2VbuBDZLSO1tJqkqgm65OVRk3jsXb4J5K
         3bp3foZ24OKfppgCAsSRyyj0zx1SMWtrD/sdH7EgHQdwKNgI+AKhKQDeL0lBLjBnALX8
         05mhfIeLGkoP519SliEsfudgx3id0R2pYdMK8dumUCCU9u33jNZGrvKewxWtDJ6vx4Mt
         9KI+Cy0mY9j6YvYVbRnNgty3tyzrf75iSVY6xQwb+4cbzVDAlWs9nh5890ZpAKZSIvSB
         Fx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232905; x=1704837705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7sRColwM16ZDpkHsKhbx/H1UjX1V2ZP/gk6hKZVk/k=;
        b=GYHt4aHlJpW+vD6HieHAqP160JSB2b8xLci43pfadxe4Exd/2lxcVaIaoFei2kxqAO
         earJhVHLT8SVGYWzpytPjOPlAdk50o0QLI/EE91sV93SGHhUZKlUQ+3CVZ0WtPgPjnPI
         kTqw8t2SRxMLoJ4SFe3ichrk1qipcvOsOgUksQelpRH8xYTEEu3s2ebv0zvnr6c3zY9I
         mHJFpNuH6l7qQi1XHMeUTXNJ6qXi2PcdzbYuc2m51ViA/b3kYS8aOrAe8b15cvl4FSr2
         ZXOrz1LbVZ5H3dp0f4swlEwCvJ7cmNYMDWPmoBjtksDNvJtdql80zISiUrK60IUmFSWT
         t4OA==
X-Gm-Message-State: AOJu0YwHMJpX88ccFdCAwTO9ta2UntQQsaIisRTbZFwMcwc8EOw4NlTp
	LcLMyK+VQetkz2ZH5ShSo4flF+QvkfrT7ft940nhVjaDtoU=
X-Google-Smtp-Source: AGHT+IEo3bZM2aLuSMOGwMaVus9GR4XwWujHLJvE5N9ecURPZ+yptZqxQ7nXUllBGYAXlfndapu+WA==
X-Received: by 2002:a05:6a20:a107:b0:197:2fc0:7e25 with SMTP id q7-20020a056a20a10700b001972fc07e25mr2866566pzk.3.1704232905452;
        Tue, 02 Jan 2024 14:01:45 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id r59-20020a17090a43c100b0028ce507cd7dsm101724pjg.55.2024.01.02.14.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:01:45 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 08/12] riscv: mm: Introduce cntx2asid/cntx2version helper macros
Date: Tue,  2 Jan 2024 14:00:45 -0800
Message-ID: <20240102220134.3229156-9-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240102220134.3229156-1-samuel.holland@sifive.com>
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using the ASID allocator, the MM context ID contains two values:
the ASID in the lower bits, and the allocator version number in the
remaining bits. Use macros to make this separation more obvious.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/include/asm/mmu.h |  3 +++
 arch/riscv/mm/context.c      | 12 ++++++------
 arch/riscv/mm/tlbflush.c     |  2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 355504b37f8e..a550fbf770be 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -26,6 +26,9 @@ typedef struct {
 #endif
 } mm_context_t;
 
+#define cntx2asid(cntx)		((cntx) & asid_mask)
+#define cntx2version(cntx)	((cntx) & ~asid_mask)
+
 void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
 			       phys_addr_t sz, pgprot_t prot);
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 217fd4de6134..43d005f63253 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -81,7 +81,7 @@ static void __flush_context(void)
 		if (cntx == 0)
 			cntx = per_cpu(reserved_context, i);
 
-		__set_bit(cntx & asid_mask, context_asid_map);
+		__set_bit(cntx2asid(cntx), context_asid_map);
 		per_cpu(reserved_context, i) = cntx;
 	}
 
@@ -102,7 +102,7 @@ static unsigned long __new_context(struct mm_struct *mm)
 	lockdep_assert_held(&context_lock);
 
 	if (cntx != 0) {
-		unsigned long newcntx = ver | (cntx & asid_mask);
+		unsigned long newcntx = ver | cntx2asid(cntx);
 
 		/*
 		 * If our current CONTEXT was active during a rollover, we
@@ -115,7 +115,7 @@ static unsigned long __new_context(struct mm_struct *mm)
 		 * We had a valid CONTEXT in a previous life, so try to
 		 * re-use it if possible.
 		 */
-		if (!__test_and_set_bit(cntx & asid_mask, context_asid_map))
+		if (!__test_and_set_bit(cntx2asid(cntx), context_asid_map))
 			return newcntx;
 	}
 
@@ -168,7 +168,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 	 */
 	old_active_cntx = atomic_long_read(&per_cpu(active_context, cpu));
 	if (old_active_cntx &&
-	    ((cntx & ~asid_mask) == atomic_long_read(&current_version)) &&
+	    (cntx2version(cntx) == atomic_long_read(&current_version)) &&
 	    atomic_long_cmpxchg_relaxed(&per_cpu(active_context, cpu),
 					old_active_cntx, cntx))
 		goto switch_mm_fast;
@@ -177,7 +177,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 
 	/* Check that our ASID belongs to the current_version. */
 	cntx = atomic_long_read(&mm->context.id);
-	if ((cntx & ~asid_mask) != atomic_long_read(&current_version)) {
+	if (cntx2version(cntx) != atomic_long_read(&current_version)) {
 		cntx = __new_context(mm);
 		atomic_long_set(&mm->context.id, cntx);
 	}
@@ -191,7 +191,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 
 switch_mm_fast:
 	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) |
-		  ((cntx & asid_mask) << SATP_ASID_SHIFT) |
+		  (cntx2asid(cntx) << SATP_ASID_SHIFT) |
 		  satp_mode);
 
 	if (need_flush_tlb)
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 76b24d4ed4ab..5ec621545c69 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -85,7 +85,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 			return;
 
 		if (static_branch_unlikely(&use_asid_allocator))
-			asid = atomic_long_read(&mm->context.id) & asid_mask;
+			asid = cntx2asid(atomic_long_read(&mm->context.id));
 	} else {
 		cmask = cpu_online_mask;
 	}
-- 
2.42.0


