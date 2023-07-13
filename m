Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0C2751D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjGMJ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjGMJ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:26:02 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E34F1FE1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:25:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R1q3Q3Xlkz4f3nbp
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:25:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDHu+khw69kr7cmNw--.13397S3;
        Thu, 13 Jul 2023 17:25:55 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 1/8] mm/page_table_check: remove unused parameters in page_table_check_clear()
Date:   Fri, 14 Jul 2023 01:26:29 +0800
Message-Id: <20230713172636.1705415-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230713172636.1705415-1-shikemeng@huaweicloud.com>
References: <20230713172636.1705415-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHu+khw69kr7cmNw--.13397S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1UJr17GF4UWFy8GrW8Crg_yoW8ZFyxp3
        W5X34vqr4Yg345Wr1S9Fs8AryUtrs8WayxXr17GayYv3Way34fKFyUJwn8Za95GrykXay3
        GFWSqr17CF4xJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRiDGYDUUUUU=
        =
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

Remove unused mm and addr in function page_table_check_clear().

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page_table_check.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 93ec7690a0d8..9477b93d8463 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -58,8 +58,7 @@ static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
  * An entry is removed from the page table, decrement the counters for that page
  * verify that it is of correct type and counters do not become negative.
  */
-static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
-				   unsigned long pfn, unsigned long pgcnt)
+static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
 {
 	struct page_ext *page_ext;
 	struct page *page;
@@ -158,8 +157,7 @@ void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
 		return;
 
 	if (pte_user_accessible_page(pte)) {
-		page_table_check_clear(mm, addr, pte_pfn(pte),
-				       PAGE_SIZE >> PAGE_SHIFT);
+		page_table_check_clear(pte_pfn(pte), PAGE_SIZE >> PAGE_SHIFT);
 	}
 }
 EXPORT_SYMBOL(__page_table_check_pte_clear);
@@ -171,8 +169,7 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
 		return;
 
 	if (pmd_user_accessible_page(pmd)) {
-		page_table_check_clear(mm, addr, pmd_pfn(pmd),
-				       PMD_SIZE >> PAGE_SHIFT);
+		page_table_check_clear(pmd_pfn(pmd), PMD_SIZE >> PAGE_SHIFT);
 	}
 }
 EXPORT_SYMBOL(__page_table_check_pmd_clear);
@@ -184,8 +181,7 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
 		return;
 
 	if (pud_user_accessible_page(pud)) {
-		page_table_check_clear(mm, addr, pud_pfn(pud),
-				       PUD_SIZE >> PAGE_SHIFT);
+		page_table_check_clear(pud_pfn(pud), PUD_SIZE >> PAGE_SHIFT);
 	}
 }
 EXPORT_SYMBOL(__page_table_check_pud_clear);
-- 
2.30.0

