Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEF8769012
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGaI0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGaI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:26:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9611FA0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:26:26 -0700 (PDT)
Received: from dggpeml500018.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RDrsF6cDQz1GDH1;
        Mon, 31 Jul 2023 16:25:21 +0800 (CST)
Received: from huawei.com (10.67.174.191) by dggpeml500018.china.huawei.com
 (7.185.36.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 16:26:20 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        Zhang Qiao <zhangqiao22@huawei.com>
Subject: [PATCH] sched: Update comment of try_invoke_on_locked_down_task()
Date:   Mon, 31 Jul 2023 16:57:59 +0800
Message-ID: <20230731085759.11443-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9b3c4ab3045e ("sched,rcu: Rework
try_invoke_on_locked_down_task()") renamed
try_invoke_on_locked_down_task() to task_call_func().
Now, update some comment about it.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d18c3969f90..540ac33ddb80 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4186,7 +4186,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
 	 * __schedule().  See the comment for smp_mb__after_spinlock().
 	 *
-	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
+	 * A similar smb_rmb() lives in task_call_func().
 	 */
 	smp_rmb();
 	if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
-- 
2.25.1

