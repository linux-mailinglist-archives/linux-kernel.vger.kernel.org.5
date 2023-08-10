Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D837777BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjHJMDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHJMDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:03:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95B810E9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:03:07 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RM59c0WfMzTmb4;
        Thu, 10 Aug 2023 20:01:08 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 20:03:04 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] sched: Remove duplicated includes
Date:   Thu, 10 Aug 2023 20:02:39 +0800
Message-ID: <20230810120239.26173-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated includes in kernel/sched/fair.c, kernel/sched/core.c
and kernel/sched/build_utility.c. Resolves checkincludes message.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 kernel/sched/build_utility.c | 1 -
 kernel/sched/core.c          | 2 --
 kernel/sched/fair.c          | 2 --
 3 files changed, 5 deletions(-)

diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index 99bdd96f454f..80a3df49ab47 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -34,7 +34,6 @@
 #include <linux/nospec.h>
 #include <linux/proc_fs.h>
 #include <linux/psi.h>
-#include <linux/psi.h>
 #include <linux/ptrace_api.h>
 #include <linux/sched_clock.h>
 #include <linux/security.h>
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 979ed6b40e65..73b61ed8988f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -87,10 +87,8 @@
 #include "stats.h"
 #include "autogroup.h"
 
-#include "autogroup.h"
 #include "pelt.h"
 #include "smp.h"
-#include "stats.h"
 
 #include "../workqueue_internal.h"
 #include "../../io_uring/io-wq.h"
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8db197b8f10d..4efe3039bfa1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -51,8 +51,6 @@
 
 #include <asm/switch_to.h>
 
-#include <linux/sched/cond_resched.h>
-
 #include "sched.h"
 #include "stats.h"
 #include "autogroup.h"
-- 
2.17.1

