Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041E7775085
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjHIBtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjHIBtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:49:05 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2409FF3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:49:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RLCdl1Yycz4f3pqr
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:48:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnCW6M8NJk7QYSAQ--.39503S2;
        Wed, 09 Aug 2023 09:49:01 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH] mm/compaction: remove unused parameter pgdata of fragmentation_score_wmark
Date:   Wed,  9 Aug 2023 17:49:10 +0800
Message-Id: <20230809094910.3092446-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnCW6M8NJk7QYSAQ--.39503S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryfGw18Zw43WFW7urWxWFg_yoW8Gryrpw
        10qFWFq3WYq3W5GryFvw4IgayrAF4Iqay7Xw4qqrZ7JF15KanYvFy7try293y8X34jgryx
        ta9Fga45Jay7AFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7sRi
        Pl1DUUUUU==
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

Parameter pgdat is not used in fragmentation_score_wmark. Just remove it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/compaction.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index ea61922a1619..38c8d216c6a3 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2142,7 +2142,7 @@ static unsigned int fragmentation_score_node(pg_data_t *pgdat)
 	return score;
 }
 
-static unsigned int fragmentation_score_wmark(pg_data_t *pgdat, bool low)
+static unsigned int fragmentation_score_wmark(bool low)
 {
 	unsigned int wmark_low;
 
@@ -2162,7 +2162,7 @@ static bool should_proactive_compact_node(pg_data_t *pgdat)
 	if (!sysctl_compaction_proactiveness || kswapd_is_running(pgdat))
 		return false;
 
-	wmark_high = fragmentation_score_wmark(pgdat, false);
+	wmark_high = fragmentation_score_wmark(false);
 	return fragmentation_score_node(pgdat) > wmark_high;
 }
 
@@ -2201,7 +2201,7 @@ static enum compact_result __compact_finished(struct compact_control *cc)
 			return COMPACT_PARTIAL_SKIPPED;
 
 		score = fragmentation_score_zone(cc->zone);
-		wmark_low = fragmentation_score_wmark(pgdat, true);
+		wmark_low = fragmentation_score_wmark(true);
 
 		if (score > wmark_low)
 			ret = COMPACT_CONTINUE;
-- 
2.30.0

