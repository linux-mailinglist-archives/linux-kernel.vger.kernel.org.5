Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB388753025
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjGNDrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbjGNDrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:47:14 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D3D26BB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:47:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R2HV54lCsz4f3kKR
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:47:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgBnTbE8xbBk4HW0Nw--.17751S5;
        Fri, 14 Jul 2023 11:47:10 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 3/3] mm/page_ext: move functions around for minor cleanups to page_ext
Date:   Fri, 14 Jul 2023 19:47:49 +0800
Message-Id: <20230714114749.1743032-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230714114749.1743032-1-shikemeng@huaweicloud.com>
References: <20230714114749.1743032-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnTbE8xbBk4HW0Nw--.17751S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWkJF4xJw47Aw13Zr45Awb_yoW5KFyfpr
        1akw17tw15J3Wagwn7Ja1kCr15Grn5G3y7Jr17Kw1Fv3WYkr40gry7Kr90vryvgrW8Xry5
        Xr4ktr1qk3WkJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
        CS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
        WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7s
        RNBT5UUUUUU==
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

1. move page_ext_get and page_ext_put down to remove forward declaration
of lookup_page_ext.
2. move page_ext_init_flatmem_late down to existing non SPARS block
to remove a new non SPARS block and to keep code for non SPARS tight.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page_ext.c | 96 ++++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index f052397dc70f..4548fcc66d74 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -90,7 +90,6 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
 unsigned long page_ext_size;
 
 static unsigned long total_usage;
-static struct page_ext *lookup_page_ext(const struct page *page);
 
 bool early_page_ext __meminitdata;
 static int __init setup_early_page_ext(char *str)
@@ -137,62 +136,16 @@ static void __init invoke_init_callbacks(void)
 	}
 }
 
-#ifndef CONFIG_SPARSEMEM
-void __init page_ext_init_flatmem_late(void)
-{
-	invoke_init_callbacks();
-}
-#endif
-
 static inline struct page_ext *get_entry(void *base, unsigned long index)
 {
 	return base + page_ext_size * index;
 }
 
-/**
- * page_ext_get() - Get the extended information for a page.
- * @page: The page we're interested in.
- *
- * Ensures that the page_ext will remain valid until page_ext_put()
- * is called.
- *
- * Return: NULL if no page_ext exists for this page.
- * Context: Any context.  Caller may not sleep until they have called
- * page_ext_put().
- */
-struct page_ext *page_ext_get(struct page *page)
-{
-	struct page_ext *page_ext;
-
-	rcu_read_lock();
-	page_ext = lookup_page_ext(page);
-	if (!page_ext) {
-		rcu_read_unlock();
-		return NULL;
-	}
-
-	return page_ext;
-}
-
-/**
- * page_ext_put() - Working with page extended information is done.
- * @page_ext: Page extended information received from page_ext_get().
- *
- * The page extended information of the page may not be valid after this
- * function is called.
- *
- * Return: None.
- * Context: Any context with corresponding page_ext_get() is called.
- */
-void page_ext_put(struct page_ext *page_ext)
+#ifndef CONFIG_SPARSEMEM
+void __init page_ext_init_flatmem_late(void)
 {
-	if (unlikely(!page_ext))
-		return;
-
-	rcu_read_unlock();
+	invoke_init_callbacks();
 }
-#ifndef CONFIG_SPARSEMEM
-
 
 void __meminit pgdat_page_ext_init(struct pglist_data *pgdat)
 {
@@ -536,3 +489,46 @@ void __meminit pgdat_page_ext_init(struct pglist_data *pgdat)
 }
 
 #endif
+
+/**
+ * page_ext_get() - Get the extended information for a page.
+ * @page: The page we're interested in.
+ *
+ * Ensures that the page_ext will remain valid until page_ext_put()
+ * is called.
+ *
+ * Return: NULL if no page_ext exists for this page.
+ * Context: Any context.  Caller may not sleep until they have called
+ * page_ext_put().
+ */
+struct page_ext *page_ext_get(struct page *page)
+{
+	struct page_ext *page_ext;
+
+	rcu_read_lock();
+	page_ext = lookup_page_ext(page);
+	if (!page_ext) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	return page_ext;
+}
+
+/**
+ * page_ext_put() - Working with page extended information is done.
+ * @page_ext: Page extended information received from page_ext_get().
+ *
+ * The page extended information of the page may not be valid after this
+ * function is called.
+ *
+ * Return: None.
+ * Context: Any context with corresponding page_ext_get() is called.
+ */
+void page_ext_put(struct page_ext *page_ext)
+{
+	if (unlikely(!page_ext))
+		return;
+
+	rcu_read_unlock();
+}
-- 
2.30.0

