Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2EC757154
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGRBVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGRBVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:21:06 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA102A6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 18:21:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R4h3b6t13z4f3nJy
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:20:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgCnxzH76LVkVp7ZNQ--.10531S2;
        Tue, 18 Jul 2023 09:21:00 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH] mm/rmap: correct stale comment of rmap_walk_anon and rmap_walk_file
Date:   Tue, 18 Jul 2023 17:21:36 +0800
Message-Id: <20230718092136.1935789-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCnxzH76LVkVp7ZNQ--.10531S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWfCF4kuw17Kw43Aw1fZwb_yoW8WF48pr
        4qgwnxJ3yDWF1Y9F4vya1093WSv34kXayqkrWfGasrA3WDJrn7KFyjka4xXryUCrs3XF4f
        KrsYga1j9F13CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRE
        SoGDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. update page to folio in comment
2. add comment of new added @locked

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/rmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 2668f5ea3534..1c0538fbb8f2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2402,11 +2402,12 @@ static struct anon_vma *rmap_walk_anon_lock(struct folio *folio,
 /*
  * rmap_walk_anon - do something to anonymous page using the object-based
  * rmap method
- * @page: the page to be handled
+ * @folio: the folio to be handled
  * @rwc: control variable according to each walk type
+ * @locked: caller holds relevant rmap lock
  *
- * Find all the mappings of a page using the mapping pointer and the vma chains
- * contained in the anon_vma struct it points to.
+ * Find all the mappings of a folio using the mapping pointer and the vma
+ * chains contained in the anon_vma struct it points to.
  */
 static void rmap_walk_anon(struct folio *folio,
 		struct rmap_walk_control *rwc, bool locked)
@@ -2450,10 +2451,11 @@ static void rmap_walk_anon(struct folio *folio,
 
 /*
  * rmap_walk_file - do something to file page using the object-based rmap method
- * @page: the page to be handled
+ * @folio: the folio to be handled
  * @rwc: control variable according to each walk type
+ * @locked: caller holds relevant rmap lock
  *
- * Find all the mappings of a page using the mapping pointer and the vma chains
+ * Find all the mappings of a folio using the mapping pointer and the vma chains
  * contained in the address_space struct it points to.
  */
 static void rmap_walk_file(struct folio *folio,
-- 
2.30.0

