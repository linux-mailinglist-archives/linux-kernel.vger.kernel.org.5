Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C295751D23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjGMJ0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjGMJ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:26:06 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DCE2115
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:25:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R1q3Q0R7Tz4f3sxG
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:25:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHu+khw69kr7cmNw--.13397S7;
        Thu, 13 Jul 2023 17:25:56 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 5/8] mm/page_table_check: remove unused parameter in [__]page_table_check_pud_clear
Date:   Fri, 14 Jul 2023 01:26:33 +0800
Message-Id: <20230713172636.1705415-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230713172636.1705415-1-shikemeng@huaweicloud.com>
References: <20230713172636.1705415-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHu+khw69kr7cmNw--.13397S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW5Jw45WF17XrWfWrW5Awb_yoWrXFy5pF
        15X34vqr45W34Y9r1j9Fs0yryIqrs8GayxWry5Ga1Fvw13Kry0qF1DJr9rZas5Gry8Aw1f
        GFWYqrnrGr4IgrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
        xVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
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

Remove unused addr in __page_table_check_pud_clear and
page_table_check_pud_clear.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 arch/x86/include/asm/pgtable.h   |  2 +-
 include/linux/page_table_check.h | 11 ++++-------
 include/linux/pgtable.h          |  2 +-
 mm/page_table_check.c            |  5 ++---
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5d71f933d933..f07c610c3458 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1144,7 +1144,7 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 {
 	pud_t pud = native_pudp_get_and_clear(pudp);
 
-	page_table_check_pud_clear(mm, addr, pud);
+	page_table_check_pud_clear(mm, pud);
 
 	return pud;
 }
diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
index 0f777bca5283..5c9dc848a1bc 100644
--- a/include/linux/page_table_check.h
+++ b/include/linux/page_table_check.h
@@ -16,8 +16,7 @@ extern struct page_ext_operations page_table_check_ops;
 void __page_table_check_zero(struct page *page, unsigned int order);
 void __page_table_check_pte_clear(struct mm_struct *mm, pte_t pte);
 void __page_table_check_pmd_clear(struct mm_struct *mm, pmd_t pmd);
-void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
-				  pud_t pud);
+void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud);
 void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte);
 void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
@@ -60,13 +59,12 @@ static inline void page_table_check_pmd_clear(struct mm_struct *mm, pmd_t pmd)
 	__page_table_check_pmd_clear(mm, pmd);
 }
 
-static inline void page_table_check_pud_clear(struct mm_struct *mm,
-					      unsigned long addr, pud_t pud)
+static inline void page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
 {
 	if (static_branch_likely(&page_table_check_disabled))
 		return;
 
-	__page_table_check_pud_clear(mm, addr, pud);
+	__page_table_check_pud_clear(mm, pud);
 }
 
 static inline void page_table_check_pte_set(struct mm_struct *mm,
@@ -127,8 +125,7 @@ static inline void page_table_check_pmd_clear(struct mm_struct *mm, pmd_t pmd)
 {
 }
 
-static inline void page_table_check_pud_clear(struct mm_struct *mm,
-					      unsigned long addr, pud_t pud)
+static inline void page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
 {
 }
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 3edef5ed008f..5f36c055794b 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -438,7 +438,7 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 	pud_t pud = *pudp;
 
 	pud_clear(pudp);
-	page_table_check_pud_clear(mm, address, pud);
+	page_table_check_pud_clear(mm, pud);
 
 	return pud;
 }
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 51f2274c0a20..2643135bf45c 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -171,8 +171,7 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, pmd_t pmd)
 }
 EXPORT_SYMBOL(__page_table_check_pmd_clear);
 
-void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
-				  pud_t pud)
+void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
 {
 	if (&init_mm == mm)
 		return;
@@ -217,7 +216,7 @@ void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
 	if (&init_mm == mm)
 		return;
 
-	__page_table_check_pud_clear(mm, addr, *pudp);
+	__page_table_check_pud_clear(mm, *pudp);
 	if (pud_user_accessible_page(pud)) {
 		page_table_check_set(pud_pfn(pud), PUD_SIZE >> PAGE_SHIFT,
 				     pud_write(pud));
-- 
2.30.0

