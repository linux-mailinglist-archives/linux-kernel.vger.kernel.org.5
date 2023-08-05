Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B073A770D64
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjHEDHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjHEDHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:07:08 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DE14EED
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:07:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHnYb3BWKz4f3n6L
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 11:06:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHvrHQvM1k6A5ePg--.23962S8;
        Sat, 05 Aug 2023 11:07:00 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 6/9] mm/compaction: rename is_via_compact_memory to compaction_with_allocation_order
Date:   Sat,  5 Aug 2023 19:07:08 +0800
Message-Id: <20230805110711.2975149-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
References: <20230805110711.2975149-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvrHQvM1k6A5ePg--.23962S8
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1fKF1fKryxJw4ktry5Jwb_yoW8Xw15pF
        10yw1xZ3WvqFy3GF4Iya18C3W5Gw4xKFyUJrs29w48Xw1ak3WFk3ZrtFyFvryUX3sakrWY
        vFZ8K3WUt39xA3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
        rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
        IIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xv
        wVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
        Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2
        IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRvJPtU
        UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have order = -1 via proactive compaction, the is_via_compact_memory is
not proper name anymore.
As cc->order informs the compaction to satisfy a allocation with that
order, so rename it to compaction_with_allocation_order.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index d8416d3dd445..b5a699ed526b 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2055,12 +2055,11 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 }
 
 /*
- * order == -1 is expected when compacting via
- * /proc/sys/vm/compact_memory
+ * compact to satisfy allocation with target order
  */
-static inline bool is_via_compact_memory(int order)
+static inline bool compaction_with_allocation_order(int order)
 {
-	return order == -1;
+	return order != -1;
 }
 
 /*
@@ -2200,7 +2199,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 		goto out;
 	}
 
-	if (is_via_compact_memory(cc->order))
+	if (!compaction_with_allocation_order(cc->order))
 		return COMPACT_CONTINUE;
 
 	/*
@@ -2390,7 +2389,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	cc->migratetype = gfp_migratetype(cc->gfp_mask);
 
-	if (!is_via_compact_memory(cc->order)) {
+	if (compaction_with_allocation_order(cc->order)) {
 		unsigned long watermark;
 
 		/* Allocation can already succeed, nothing to do */
-- 
2.30.0

