Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926D379F62F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbjINBPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjINBPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:15:46 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D67B1724;
        Wed, 13 Sep 2023 18:15:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RmKBb04DHz4f3jYS;
        Thu, 14 Sep 2023 09:15:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgB3gAW6XgJl1RSfAQ--.51414S2;
        Thu, 14 Sep 2023 09:15:38 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: correct stale comment in rq_qos_wait
Date:   Thu, 14 Sep 2023 17:15:08 +0800
Message-Id: <20230914091508.36232-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3gAW6XgJl1RSfAQ--.51414S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyxXr45KrWxXFyUGrW8tFb_yoW3uFcEvF
        s7Jr1I9Fn8Wrsakw18GFWIgFn7K34UGF48CryfWay3Gw1ftanrAa1vkws0qFsxG3W3Kw4a
        qw45ZFnxJw4I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
        AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWD
        JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oV
        Cq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG
        8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2js
        IE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY
        0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUI-eoUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rq_qos_wait calls common wake-up function rq_qos_wake_function to get
token. Just replace stale wbt_wake_function with rq_qos_wake_function in
comment.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 block/blk-rq-qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 167be74df4ee..dd7310c94713 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -270,7 +270,7 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 			finish_wait(&rqw->wait, &data.wq);
 
 			/*
-			 * We raced with wbt_wake_function() getting a token,
+			 * We raced with rq_qos_wake_function() getting a token,
 			 * which means we now have two. Put our local token
 			 * and wake anyone else potentially waiting for one.
 			 */
-- 
2.30.0

