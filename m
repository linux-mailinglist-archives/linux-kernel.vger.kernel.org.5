Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC1C78F958
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjIAHwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244609AbjIAHwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:52:09 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8AA10D5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:52:06 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RcVc10HnWz4f3m7Z
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 15:52:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgDnw6YfmPFk1Z5cCA--.13825S7;
        Fri, 01 Sep 2023 15:52:02 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] mm/compaction: improve comment of is_via_compact_memory
Date:   Fri,  1 Sep 2023 23:51:40 +0800
Message-Id: <20230901155141.249860-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230901155141.249860-1-shikemeng@huaweicloud.com>
References: <20230901155141.249860-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnw6YfmPFk1Z5cCA--.13825S7
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1kKr13AF4DXry7try8uFg_yoWDKwb_Jr
        4IvFnYyr1Yvry8uFs3Ar43ZrykCa1rZrnrZan2gr4Yyas2yF4ktFWDZry7Xr4YgFZ2gr9I
        kwn7Jr1qy3W2yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
        xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
        64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM2
        8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
        3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
        Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
        14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jstxDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do proactive compaction with order == -1 via
1. /proc/sys/vm/compact_memory
2. /sys/devices/system/node/nodex/compact
3. /proc/sys/vm/compaction_proactiveness
Add missed situation in which order == -1.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/compaction.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index c377d78e0f15..ff3426a0d9c5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2065,8 +2065,10 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 }
 
 /*
- * order == -1 is expected when compacting via
- * /proc/sys/vm/compact_memory
+ * order == -1 is expected when compacting proactively via
+ * 1. /proc/sys/vm/compact_memory
+ * 2. /sys/devices/system/node/nodex/compact
+ * 3. /proc/sys/vm/compaction_proactiveness
  */
 static inline bool is_via_compact_memory(int order)
 {
-- 
2.30.0

