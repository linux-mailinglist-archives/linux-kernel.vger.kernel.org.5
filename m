Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4B799ABD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244897AbjIIURq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244597AbjIIURk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:17:40 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FB91BC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 13:17:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DBC32320090E;
        Sat,  9 Sep 2023 16:17:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 09 Sep 2023 16:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694290655; x=
        1694377055; bh=u+R27fQSLabNs20twvWYROSpY1egJDSSJ6jgm8OSGJ4=; b=r
        E1qegEdZ8OH3AdJXRXbJ/3z8lj+sZPmBGODILRCdn0bGZqET9HOPF/BLhEBOPWJE
        UB3KaCLKmFAO7lp8BrUybwd5JEtyvovEXTUm/VmGk42tvImQ/h1auBQeBtI4ZrhT
        aDxPkcjwdxS/Vx/1vXS24IxBeW3VY7w+Pir/r9JlSvgmzjjel8UR77T7I/WxZ5Qy
        WrsZdAs+ZtD9Fx0mBj+WYsGrqz2QPzxb4fBSdpKTbxGaX3m+avHeZx/UaSJ8ifMk
        VNKZKqZ4blwejANEGo7AjjYSBsVnQrjxPdzkX67JnSHX3Bmx4vGTU9gt/tIia9MH
        rdbMvtWfLFRnhZcL2DsnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694290655; x=
        1694377055; bh=u+R27fQSLabNs20twvWYROSpY1egJDSSJ6jgm8OSGJ4=; b=t
        3ES3w7Sl5IIg4IQUHFQ3gL5Ri8nvST3n+1Ut3ygOL3N7iqih9+T6xLJwRv5Wjyjs
        wOqv7gl99t7WiQf7lzZ5RWiiA5iUoIK5P6RX2tIHpx/nyo4TMG+QSDWnJeJEABei
        JGombEGeOD8hwPZglBCGnCYNSGzA+F0isXNVK+jhUOz/VZLGQpBIpp7Dr5Dz6/A3
        gz5mpQIc2RCL634Iz+BnysxVcZmKDJyr3B8pNnuP5JA65ewDofu+t8isLrYema1z
        HMbTfqUFykfl/O7GcJVhKD53ou+LN47Z5/r9H3gRi5/sutIF1k/lOm3kTXKS7tRB
        b0j2F6Y/wxhM0WBRYj0Kg==
X-ME-Sender: <xms:39L8ZI9pcJZmdGzqshYKE6i-T8r-QlGL39ou0XMTon4uYHFZQgzrUw>
    <xme:39L8ZAuIfaYTEiiJuJUy_0M0wkTlRBWxrXi7iqpl2G2WX0VYNp60FUsn3SHCEFzv7
    Am9yoSPrdNYO7tBdQ>
X-ME-Received: <xmr:39L8ZOAmMZddsp0r0ls7eiB0bZYFDuODP39s-ohv__b1CK7eJan6DkrJ-VOS0u78XGCcid1oKHdoIf1PCVxHcNkn_xpULONlVrJPAWPA7veDzh8l0UJbYmFvzG_Oi6OvBzz6TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:39L8ZIc5PuTe2FD0uIFV55PscRf91ILHQNwAb1DcVHRbCTdx2fr-VA>
    <xmx:39L8ZNOM5WwBC-9gy7RMylHNppMTLKRzSkKmhYd9Ni_v9ACOQnfe5Q>
    <xmx:39L8ZCkkrednBI7LLwdL98AUonvfaeMPyBHU9zYMPrKhAe--kerlHg>
    <xmx:39L8ZCrgADnRmVS4jxExQyZwu8KkAi2YR7u7H859x6oixTYxwz-FbQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 16:17:34 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/7] riscv: mm: Use a fixed layout for the MM context ID
Date:   Sat,  9 Sep 2023 15:16:31 -0500
Message-ID: <20230909201727.10909-4-samuel@sholland.org>
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

Currently, the size of the ASID field in the MM context ID dynamically
depends on the number of hardware-supported ASID bits. This requires
reading a global variable to extract either field from the context ID.
Instead, allocate the maximum possible number of bits to the ASID field,
so the layout of the context ID is known at compile-time.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

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
index e2960c9c16e8..e55831edfc19 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -12,8 +12,6 @@
 #include <asm/errata_list.h>
 
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
2.41.0

