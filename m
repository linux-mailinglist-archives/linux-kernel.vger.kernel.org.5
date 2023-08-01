Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5262076A703
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjHACfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjHACfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:35:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD11BEE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:35:15 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RFK1c1PT4zrRs3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:34:12 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 10:35:12 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <tglx@linutronix.de>
CC:     <liaoyu15@huawei.com>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>
Subject: [PATCH -next] timer: Replace del_timer() in comments
Date:   Tue, 1 Aug 2023 10:32:01 +0800
Message-ID: <20230801023201.2915257-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust del_timer() to the new preferred function name timer_delete().

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 kernel/time/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..4864fc4c7b91 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1165,10 +1165,10 @@ EXPORT_SYMBOL(mod_timer_pending);
  *
  * mod_timer(timer, expires) is equivalent to:
  *
- *     del_timer(timer); timer->expires = expires; add_timer(timer);
+ *     timer_delete(timer); timer->expires = expires; add_timer(timer);
  *
  * mod_timer() is more efficient than the above open coded sequence. In
- * case that the timer is inactive, the del_timer() part is a NOP. The
+ * case that the timer is inactive, the timer_delete() part is a NOP. The
  * timer is in any case activated with the new expiry time @expires.
  *
  * Note that if there are multiple unserialized concurrent users of the
-- 
2.25.1

