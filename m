Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B214780394
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357144AbjHRB5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357163AbjHRB5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:57:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7A93AA4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:56:57 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRlLH6JpmzVk8m;
        Fri, 18 Aug 2023 09:54:47 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 09:56:55 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] sched: Remove duplicated includes in sched.h
Date:   Fri, 18 Aug 2023 09:56:33 +0800
Message-ID: <20230818015633.18370-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Remove duplicated includes of linux/cgroup.h and linux/psi.h. Both of
these includes are included regardless of the config and they are all
protected by ifndef, so no point including them again.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 kernel/sched/sched.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 04846272409c..91ee1aaf845a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -74,15 +74,6 @@
 
 #include "../workqueue_internal.h"
 
-#ifdef CONFIG_CGROUP_SCHED
-#include <linux/cgroup.h>
-#include <linux/psi.h>
-#endif
-
-#ifdef CONFIG_SCHED_DEBUG
-# include <linux/static_key.h>
-#endif
-
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
 # include <asm/paravirt_api_clock.h>
-- 
2.17.1

