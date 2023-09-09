Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F422799ABC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244325AbjIIURh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjIIURg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:17:36 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A22E19E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 13:17:32 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 53337320090E;
        Sat,  9 Sep 2023 16:17:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 09 Sep 2023 16:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694290650; x=
        1694377050; bh=7NXnmFYFmr6Y8hhtV6LxTtgTAxVz99Y/He8EwBOMTPo=; b=v
        MGC/yqEpNIdjgRMas1jOpQX+RGuER3w1a9LX7DRtbX3YU/zuvaZQ6lNCqgC5uN3u
        +WX7QnEdXIsb6GU2zk0Fq6WqIhS9vF4GMjrvaQthRv21wcMpyMuogSqMZpRH65A4
        ikNYD/4Ya6H3nKwcWxOFq2m2+CIOhkHPIOMUEMAaQaEQzmBDjk3eYR2Cm9lxdwAM
        Bf0Y4WrP+rxWWli4eqa0N2OMzHBwgJIIb06Z4fHo0Wjt0pjAhXAclM5363cBvuIJ
        dVIyEreE8ynOQTiWVp73D9Vlp/vxjklgg+hjVQKJNpBN1zOzdmXUfuj28u3zFde6
        0ARU84BJ1h6BjreTvI7hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694290650; x=
        1694377050; bh=7NXnmFYFmr6Y8hhtV6LxTtgTAxVz99Y/He8EwBOMTPo=; b=V
        /6PtmbbrFsuIPtof2CD8rYJbN8SW8zFJs5B3F1yVaeB/EqxlRcGpakegQduTcXFf
        wSIkvVrmCEmsjz84lWiez9t8xrXMOpE+l7K5d3o8XLvRcEmDlcZKlRmF+IfGUFtT
        QDFb0L7Pm0baBvnwqSvUn5jhoeJjGS6ifeXG1Am8mpFsnshwMkgfruTNH/7INHdC
        hSgmCO+CZdE0Mvud4b5FpStlebpmjkVmy4FMOZtL0k2pgsXO1EjAXQDSHEtgAzNv
        P5xxWSFJfWyEDjXDo+0/euINs2raDRN16uSY1G907a004+eyFYLMVowcmZMDaK7m
        sUNogkSv3rR3eNzMLMXRw==
X-ME-Sender: <xms:2tL8ZOS0S8gzUZb1nSVGgXTA_wYBwUsqPha8JE1s_nhed-yNjMQ_Vg>
    <xme:2tL8ZDz55g6kmJoGy47HPnlT-VWKWlF795VVI9MDzXQd50XPCyjR2O1aVhB_peWUn
    pys4dCSDKsujHd-tQ>
X-ME-Received: <xmr:2tL8ZL1e9J7u1L7789PJ94sAY2VDn_hq9ZM62IAA_1NPlG8EBVVILVaVTslgllnivEmfLvRlq-N1lCyAFhKefPHFIqib2Y4Eedh2cE_rynkuuXQWfHvt8qz2UKnuRNcmguUzEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:2tL8ZKCQSbx8PdzECm48aNv_5_p9_2Y8AeoPd86rRUmyb33aZP0lpA>
    <xmx:2tL8ZHgYBpN8fhzGMggYtPrbTjQokxXHbROdxck-vedtLIG9FCUygQ>
    <xmx:2tL8ZGrXGjMTl9x85VcF394-J5EFRbM4-T2n1ByYUx89FD9RuGPvCQ>
    <xmx:2tL8ZHchGuMCebprQzFSxf9plUY72WwThGvKPF6yuar978JNMXwJwA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 16:17:30 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/7] riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma
Date:   Sat,  9 Sep 2023 15:16:29 -0500
Message-ID: <20230909201727.10909-2-samuel@sholland.org>
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

commit 3f1e782998cd ("riscv: add ASID-based tlbflushing methods") added
calls to the sfence.vma instruction with rs2 != x0. These single-ASID
instruction variants are also affected by SiFive errata CIP-1200.

Until now, the errata workaround was not needed for the single-ASID
sfence.vma variants, because they were only used when the ASID allocator
was enabled, and the affected SiFive platforms do not support multiple
ASIDs. However, we are going to start using those sfence.vma variants
regardless of ASID support, so now we need alternatives covering them.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/include/asm/errata_list.h | 12 +++++++++++-
 arch/riscv/include/asm/tlbflush.h    | 13 ++++++++++++-
 arch/riscv/mm/tlbflush.c             | 17 -----------------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index fb1a810f3d8c..6e416297847c 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -39,11 +39,21 @@ ALTERNATIVE(__stringify(RISCV_PTR do_page_fault),			\
 	    CONFIG_ERRATA_SIFIVE_CIP_453)
 #else /* !__ASSEMBLY__ */
 
-#define ALT_FLUSH_TLB_PAGE(x)						\
+#define ALT_SFENCE_VMA_ASID(asid)					\
+asm(ALTERNATIVE("sfence.vma x0, %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
+		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
+		: : "r" (asid) : "memory")
+
+#define ALT_SFENCE_VMA_ADDR(addr)					\
 asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
 		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
 		: : "r" (addr) : "memory")
 
+#define ALT_SFENCE_VMA_ADDR_ASID(addr, asid)				\
+asm(ALTERNATIVE("sfence.vma %0, %1", "sfence.vma", SIFIVE_VENDOR_ID,	\
+		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
+		: : "r" (addr), "r" (asid) : "memory")
+
 /*
  * _val is marked as "will be overwritten", so need to set it to 0
  * in the default case.
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index a09196f8de68..e2960c9c16e8 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -19,10 +19,21 @@ static inline void local_flush_tlb_all(void)
 	__asm__ __volatile__ ("sfence.vma" : : : "memory");
 }
 
+static inline void local_flush_tlb_all_asid(unsigned long asid)
+{
+	ALT_SFENCE_VMA_ASID(asid);
+}
+
 /* Flush one page from local TLB */
 static inline void local_flush_tlb_page(unsigned long addr)
 {
-	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
+	ALT_SFENCE_VMA_ADDR(addr);
+}
+
+static inline void local_flush_tlb_page_asid(unsigned long addr,
+					     unsigned long asid)
+{
+	ALT_SFENCE_VMA_ADDR_ASID(addr, asid);
 }
 #else /* CONFIG_MMU */
 #define local_flush_tlb_all()			do { } while (0)
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 77be59aadc73..115d617d16c9 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -6,23 +6,6 @@
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
-static inline void local_flush_tlb_all_asid(unsigned long asid)
-{
-	__asm__ __volatile__ ("sfence.vma x0, %0"
-			:
-			: "r" (asid)
-			: "memory");
-}
-
-static inline void local_flush_tlb_page_asid(unsigned long addr,
-		unsigned long asid)
-{
-	__asm__ __volatile__ ("sfence.vma %0, %1"
-			:
-			: "r" (addr), "r" (asid)
-			: "memory");
-}
-
 static inline void local_flush_tlb_range(unsigned long start,
 		unsigned long size, unsigned long stride)
 {
-- 
2.41.0

