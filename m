Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518BD7ABF55
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjIWJcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjIWJcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:32:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDA4196;
        Sat, 23 Sep 2023 02:32:10 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rt3ks6Pzxz15NJV;
        Sat, 23 Sep 2023 17:29:57 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 23 Sep 2023 17:32:07 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 1/4] perf bench messaging: Fix coding style issues for sched-messaging
Date:   Sat, 23 Sep 2023 09:30:34 +0000
Message-ID: <20230923093037.961232-2-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923093037.961232-1-yangjihong1@huawei.com>
References: <20230923093037.961232-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.22]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed several code style issues in sched-messaging:
1. Use one space around "-" and "+" operators.
2. When a long line is broken, the operator is at the end of the line.

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/bench/sched-messaging.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index fa1f8f998814..6a33118c8f9b 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -98,7 +98,7 @@ static void *sender(struct sender_context *ctx)
 
 again:
 			ret = write(ctx->out_fds[j], data + done,
-				    sizeof(data)-done);
+				    sizeof(data) - done);
 			if (ret < 0)
 				err(EXIT_FAILURE, "SENDER: write");
 			done += ret;
@@ -201,8 +201,8 @@ static unsigned int group(pthread_t *pth,
 		int wakefd)
 {
 	unsigned int i;
-	struct sender_context *snd_ctx = malloc(sizeof(struct sender_context)
-			+ num_fds * sizeof(int));
+	struct sender_context *snd_ctx = malloc(sizeof(struct sender_context) +
+						num_fds * sizeof(int));
 
 	if (!snd_ctx)
 		err(EXIT_FAILURE, "malloc()");
@@ -239,7 +239,7 @@ static unsigned int group(pthread_t *pth,
 		snd_ctx->wakefd = wakefd;
 		snd_ctx->num_fds = num_fds;
 
-		pth[num_fds+i] = create_worker(snd_ctx, (void *)sender);
+		pth[num_fds + i] = create_worker(snd_ctx, (void *)sender);
 	}
 
 	/* Close the fds we have left */
@@ -288,7 +288,7 @@ int bench_sched_messaging(int argc, const char **argv)
 
 	total_children = 0;
 	for (i = 0; i < num_groups; i++)
-		total_children += group(pth_tab+total_children, num_fds,
+		total_children += group(pth_tab + total_children, num_fds,
 					readyfds[1], wakefds[0]);
 
 	/* Wait for everyone to be ready */
-- 
2.34.1

