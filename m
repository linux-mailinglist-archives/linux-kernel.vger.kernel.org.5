Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF20799ABB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244564AbjIIURj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjIIURi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:17:38 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8C11BC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 13:17:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 8DF853200805;
        Sat,  9 Sep 2023 16:17:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 09 Sep 2023 16:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694290653; x=
        1694377053; bh=9o/8XILCtdG4mXKommKnttfmvY+ZRjJhj3Lk+06yNt8=; b=o
        JKP/ccSB9pnH/lIQMaUwNjeMx4b0yKYX1T3YcLti7UShQ/qMN4NIAZHuIgnVE/0M
        jJ/Xf5DbTmoSXWsC3bgwqsNScEBW2b42gSESxEFIEwPt95leJISLNrcMcdx+bvIS
        PaqmQNrLlYZ3C6XRNZgaGpadzDgk4FsdQ/QGH3Ls9GLLcrFqTC3pqVOjJkZNjSm/
        2c03LXAroxyjMhbXuX8RO9u3jBqh46QtS6s4J4RQL/y8c+36SLen/y5+rHfG8anL
        GaJyzx1yFDuafoUFgAdVFBklTwVO8T7ljdOrm6ymmiK7qAd3UNTT2Oq+YmS2IwZ3
        FiX024vNMz5HVfNifNulw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694290653; x=
        1694377053; bh=9o/8XILCtdG4mXKommKnttfmvY+ZRjJhj3Lk+06yNt8=; b=O
        GuyNno8goMCmg0N6xXxvylW9yZdKkK0dhtII1fAqnR8EPO8WRSg3xTHFltHJfOtG
        xklZ7h25LOpDZ8Pdd8yEzVIDGiE3WlKqXZd4c4Mt8CeMOlJwiCEL8wMA0Wp++nB3
        diyEu5p5YyJ684tWQ9kj5y93p3dX0+k5sGlNSnYnhdJiVs3btWIxt2NtVHX9kr0F
        2MoIc3nT/Xaw7CbuTs8r5qeYH4iqxzJPyJjEZ45DgeEjeO5kY5E4xTs769xHSoPW
        r0qjpQK4YP7Pap2cj9ZTX2Ilzc09jZ269qNpRnrJgWgERWivIQrT7Em1Q85/Duuh
        DLCNFDBeLW4Gh3hKxfihw==
X-ME-Sender: <xms:3NL8ZI9k_Ypm8Zh1J7Nh1p-Zqg310stY56G3v3cth1guivsXEu8wmw>
    <xme:3NL8ZAtnBtQSm9zqeyZpLu6K-dfl32Q45yJ_X1Eusm80AXQkbwoz70owpIXSUsDkc
    qrUMKky-gC3OSO9kw>
X-ME-Received: <xmr:3NL8ZOAZ0oa22gwowkN-8qJxU82I0ewu5pDUTUzxmL-BeeFinrPhf-SNEWJb9-6ilFlhtzWijM8d3DaXF6afi4b5ip8I0uv60W2TmpvvUB8k8dqCPBAjZs4-PhxceZE8h7_Ctw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:3NL8ZIewF4rWlz0nKm8NfHgFefNj97wdObllrkn7tqdHZH4LT-Budw>
    <xmx:3NL8ZNM3Zx89yP-uO8ey1mTp3jWnv4KGlD5wa83KZJzupI9eKUjEMQ>
    <xmx:3NL8ZCnzhAxvk5lNsQH-8ZDjBJft00imkHUnvj1lmojU5vr6kZNVfA>
    <xmx:3dL8ZCpjPwRbXyC10MJReNB2XmvBQFDX8lYH6NJLuo8NMFcmDPtfFA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 16:17:32 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/7] riscv: mm: Introduce cntx2asid/cntx2version helper macros
Date:   Sat,  9 Sep 2023 15:16:30 -0500
Message-ID: <20230909201727.10909-3-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230909201727.10909-1-samuel@sholland.org>
References: <20230909201727.10909-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the ASID allocator, the MM context ID contains two values:
the ASID in the lower bits, and the allocator version number in the
remaining bits. Use macros to make this separation more obvious.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

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
index 115d617d16c9..54c3e70ccd81 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -73,7 +73,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 	/* check if the tlbflush needs to be sent to other CPUs */
 	broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
 	if (static_branch_unlikely(&use_asid_allocator)) {
-		unsigned long asid = atomic_long_read(&mm->context.id) & asid_mask;
+		unsigned long asid = cntx2asid(atomic_long_read(&mm->context.id));
 
 		if (broadcast) {
 			if (riscv_use_ipi_for_rfence()) {
-- 
2.41.0

