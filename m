Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0792751D22
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjGMJ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjGMJ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:26:03 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C895A2117
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:25:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R1q3S1R9jz4f3prd
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:25:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHu+khw69kr7cmNw--.13397S9;
        Thu, 13 Jul 2023 17:25:56 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 7/8] mm/page_table_check: remove unused parameter in [__]page_table_check_pmd_set
Date:   Fri, 14 Jul 2023 01:26:35 +0800
Message-Id: <20230713172636.1705415-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230713172636.1705415-1-shikemeng@huaweicloud.com>
References: <20230713172636.1705415-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHu+khw69kr7cmNw--.13397S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww13XFW7JFW7AF4kJF1rtFb_yoW7ur1xpF
        s8t3ZYqr45W34Yq3yrArsYvryftFs8GFWftry3GanYv3W5Kr48XFyDJ39xZa95Ga48u393
        GFWYqF9xGw12grUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
        xVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
        xhVjvjDU0xZFpf9x0pRvJPtUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused addr in __page_table_check_pmd_set and
page_table_check_pmd_set.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 arch/arm64/include/asm/pgtable.h |  4 ++--
 arch/riscv/include/asm/pgtable.h |  4 ++--
 arch/x86/include/asm/pgtable.h   |  4 ++--
 include/linux/page_table_check.h | 11 ++++-------
 mm/page_table_check.c            |  3 +--
 5 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f0a8dcbca04a..1fbf8d3f42b1 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -524,7 +524,7 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			      pmd_t *pmdp, pmd_t pmd)
 {
-	page_table_check_pmd_set(mm, addr, pmdp, pmd);
+	page_table_check_pmd_set(mm, pmdp, pmd);
 	return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
 }
 
@@ -976,7 +976,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
-	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
+	page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
 	return __pmd(xchg_relaxed(&pmd_val(*pmdp), pmd_val(pmd)));
 }
 #endif
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 90063afe8d36..a30658b2611b 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -687,7 +687,7 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
 {
-	page_table_check_pmd_set(mm, addr, pmdp, pmd);
+	page_table_check_pmd_set(mm, pmdp, pmd);
 	return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
 }
 
@@ -758,7 +758,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 				unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
-	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
+	page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
 	return __pmd(atomic_long_xchg((atomic_long_t *)pmdp, pmd_val(pmd)));
 }
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index d14f0d92f04b..9cc26cb0bc9f 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1030,7 +1030,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			      pmd_t *pmdp, pmd_t pmd)
 {
-	page_table_check_pmd_set(mm, addr, pmdp, pmd);
+	page_table_check_pmd_set(mm, pmdp, pmd);
 	set_pmd(pmdp, pmd);
 }
 
@@ -1167,7 +1167,7 @@ static inline int pud_write(pud_t pud)
 static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
 {
-	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
+	page_table_check_pmd_set(vma->vm_mm, pmdp, pmd);
 	if (IS_ENABLED(CONFIG_SMP)) {
 		return xchg(pmdp, pmd);
 	} else {
diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
index 63ebd9fcf28b..dd58dfb0e643 100644
--- a/include/linux/page_table_check.h
+++ b/include/linux/page_table_check.h
@@ -18,8 +18,7 @@ void __page_table_check_pte_clear(struct mm_struct *mm, pte_t pte);
 void __page_table_check_pmd_clear(struct mm_struct *mm, pmd_t pmd);
 void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud);
 void __page_table_check_pte_set(struct mm_struct *mm, pte_t *ptep, pte_t pte);
-void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
-				pmd_t *pmdp, pmd_t pmd);
+void __page_table_check_pmd_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd);
 void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
 				pud_t *pudp, pud_t pud);
 void __page_table_check_pte_clear_range(struct mm_struct *mm,
@@ -75,14 +74,13 @@ static inline void page_table_check_pte_set(struct mm_struct *mm, pte_t *ptep,
 	__page_table_check_pte_set(mm, ptep, pte);
 }
 
-static inline void page_table_check_pmd_set(struct mm_struct *mm,
-					    unsigned long addr, pmd_t *pmdp,
+static inline void page_table_check_pmd_set(struct mm_struct *mm, pmd_t *pmdp,
 					    pmd_t pmd)
 {
 	if (static_branch_likely(&page_table_check_disabled))
 		return;
 
-	__page_table_check_pmd_set(mm, addr, pmdp, pmd);
+	__page_table_check_pmd_set(mm, pmdp, pmd);
 }
 
 static inline void page_table_check_pud_set(struct mm_struct *mm,
@@ -132,8 +130,7 @@ static inline void page_table_check_pte_set(struct mm_struct *mm, pte_t *ptep,
 {
 }
 
-static inline void page_table_check_pmd_set(struct mm_struct *mm,
-					    unsigned long addr, pmd_t *pmdp,
+static inline void page_table_check_pmd_set(struct mm_struct *mm, pmd_t *pmdp,
 					    pmd_t pmd)
 {
 }
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index fc20ddc3a63e..033956704a64 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -195,8 +195,7 @@ void __page_table_check_pte_set(struct mm_struct *mm, pte_t *ptep, pte_t pte)
 }
 EXPORT_SYMBOL(__page_table_check_pte_set);
 
-void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
-				pmd_t *pmdp, pmd_t pmd)
+void __page_table_check_pmd_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd)
 {
 	if (&init_mm == mm)
 		return;
-- 
2.30.0

