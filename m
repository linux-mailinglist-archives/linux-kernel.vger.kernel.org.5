Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8576C2C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjHBCSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjHBCSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:18:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C77D1B1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:17:59 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RFwbC6cKGzrRyM;
        Wed,  2 Aug 2023 10:16:55 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 10:17:57 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <mingo@redhat.com>
CC:     <liaoyu15@huawei.com>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, <peterz@infradead.org>
Subject: [PATCH -next] sched/headers: Remove duplicate header inclusion
Date:   Wed, 2 Aug 2023 10:15:01 +0800
Message-ID: <20230802021501.2511569-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/psi.h and autogroup.h are included twice, remove the duplicate header
inclusion.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 kernel/sched/build_utility.c | 1 -
 kernel/sched/core.c          | 1 -
 2 files changed, 2 deletions(-)

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
index c52c2eba7c73..db6bbf7da4a9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -85,7 +85,6 @@
 
 #include "sched.h"
 #include "stats.h"
-#include "autogroup.h"
 
 #include "autogroup.h"
 #include "pelt.h"
-- 
2.25.1

