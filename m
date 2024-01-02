Return-Path: <linux-kernel+bounces-14919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E900E822475
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C031C20D42
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CC18EB3;
	Tue,  2 Jan 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NKqqWxPa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB461947A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28bc7155755so3952296a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704232906; x=1704837706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2cmoIK/tf9yPohv/YvO5QQvGunkgXtONjIGDQZEX58=;
        b=NKqqWxPaj9rcV1IWAEDEU5QgBO1QwiNOgePEN9zSk7nzNbpWa44amkz2NbAO6NLdHJ
         MLMvcUQ4n3FWjNLww45EzULW9lgASED1bsOKehFf9/sLOsXYlIsRRPLlMWQPAzz3pndL
         N3I9aLOTxJ+0sXdLCvpQlk6IuLCik+2236voMxhb8/Yz1qGbOIdAK34fcs8SFsBFW5VT
         xtncr81K2RPu27HOCTYsAS1XUumIxuNDtA78pj/zp/T45YydmbEu2OfyEOxCJ9S1a79i
         BdTjkNPY9HL72mdjFvJq4nMloRpUIfk37237cZfmt+vARzPch6FZxki2j+JN9RFiJmL8
         u8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232906; x=1704837706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2cmoIK/tf9yPohv/YvO5QQvGunkgXtONjIGDQZEX58=;
        b=g8Px5+hBA5tqkHUcGnjR9fbo46CrvGxSqphTEixYCDDbrzjj1hsJa1bgQ9y8syRDEA
         oEABHh3/UEyX/6+MwMmKuNEfTUxXY8ipUSMnjAL1O9lne2uke6DAP9LOx0B6ITyoGr6R
         3v8WWMfjCEpCkiVtjKJaARVaS8BDZwSxaOmelm1urKlqrDYnNxgH8H0/0sLaPIgnMoaJ
         s4T/+agPjWY+r+ne2+whoeHY6znjjNMwQzmo+BLT9YD0ad8FbpvWsTPNKI1+G1LZlvlc
         kzppI4BuycbVXGDfyXe1IC9CrmeW80VaipE2QThMweFL0hTSOcUgUGMEBEIiBKL9zq1C
         4wAw==
X-Gm-Message-State: AOJu0YzeX87//xDNABoytTYrZxNjDKgMmTXNCFCH+rxPpa3QuEjqfGJW
	ueRBvoI4y/AzGxHov0W/lfjSDaeBUU/EOw==
X-Google-Smtp-Source: AGHT+IG8w/0THQ/uqOPivBsiw22hWysSlz1giatwLj9QOMmwVtysp2KaHolkndd/R0ziY6DtdT9KEQ==
X-Received: by 2002:a17:90a:134f:b0:28c:b1bd:3c42 with SMTP id y15-20020a17090a134f00b0028cb1bd3c42mr2130687pjf.55.1704232906433;
        Tue, 02 Jan 2024 14:01:46 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id r59-20020a17090a43c100b0028ce507cd7dsm101724pjg.55.2024.01.02.14.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:01:46 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 09/12] riscv: mm: Use a fixed layout for the MM context ID
Date: Tue,  2 Jan 2024 14:00:46 -0800
Message-ID: <20240102220134.3229156-10-samuel.holland@sifive.com>
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

Currently, the size of the ASID field in the MM context ID dynamically
depends on the number of hardware-supported ASID bits. This requires
reading a global variable to extract either field from the context ID.
Instead, allocate the maximum possible number of bits to the ASID field,
so the layout of the context ID is known at compile-time.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/include/asm/mmu.h      | 4 ++--
 arch/riscv/include/asm/tlbflush.h | 2 --
 arch/riscv/mm/context.c           | 6 ++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index a550fbf770be..dc0273f7905f 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -26,8 +26,8 @@ typedef struct {
 #endif
 } mm_context_t;
 
-#define cntx2asid(cntx)		((cntx) & asid_mask)
-#define cntx2version(cntx)	((cntx) & ~asid_mask)
+#define cntx2asid(cntx)		((cntx) & SATP_ASID_MASK)
+#define cntx2version(cntx)	((cntx) & ~SATP_ASID_MASK)
 
 void __init create_pgd_mapping(pgd_t *pgdp, uintptr_t va, phys_addr_t pa,
 			       phys_addr_t sz, pgprot_t prot);
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index d9913590f82e..5bfd37cfd8c3 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -15,8 +15,6 @@
 #define FLUSH_TLB_NO_ASID       ((unsigned long)-1)
 
 #ifdef CONFIG_MMU
-extern unsigned long asid_mask;
-
 static inline void local_flush_tlb_all(void)
 {
 	__asm__ __volatile__ ("sfence.vma" : : : "memory");
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 43d005f63253..b5170ac1b742 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -22,7 +22,6 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 
 static unsigned long asid_bits;
 static unsigned long num_asids;
-unsigned long asid_mask;
 
 static atomic_long_t current_version;
 
@@ -128,7 +127,7 @@ static unsigned long __new_context(struct mm_struct *mm)
 		goto set_asid;
 
 	/* We're out of ASIDs, so increment current_version */
-	ver = atomic_long_add_return_relaxed(num_asids, &current_version);
+	ver = atomic_long_add_return_relaxed(BIT(SATP_ASID_BITS), &current_version);
 
 	/* Flush everything  */
 	__flush_context();
@@ -247,7 +246,6 @@ static int __init asids_init(void)
 	/* Pre-compute ASID details */
 	if (asid_bits) {
 		num_asids = 1 << asid_bits;
-		asid_mask = num_asids - 1;
 	}
 
 	/*
@@ -255,7 +253,7 @@ static int __init asids_init(void)
 	 * at-least twice more than CPUs
 	 */
 	if (num_asids > (2 * num_possible_cpus())) {
-		atomic_long_set(&current_version, num_asids);
+		atomic_long_set(&current_version, BIT(SATP_ASID_BITS));
 
 		context_asid_map = bitmap_zalloc(num_asids, GFP_KERNEL);
 		if (!context_asid_map)
-- 
2.42.0


