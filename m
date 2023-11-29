Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8587FD154
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjK2IsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjK2IsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:48:10 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04511BDF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:48:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VxNaVWc_1701247654;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VxNaVWc_1701247654)
          by smtp.aliyun-inc.com;
          Wed, 29 Nov 2023 16:48:11 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, liusong@linux.alibaba.com
Subject: [PATCH] sched/fair: code style adjustment
Date:   Wed, 29 Nov 2023 16:47:34 +0800
Message-Id: <20231129084734.20877-1-liusong@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In "__assign_cfs_rq_runtime", since the else uses {}, corresponding if
should also use {} for a more consistent look.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 34e23a8984ac..8bcb85ee7a21 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5581,9 +5581,9 @@ static int __assign_cfs_rq_runtime(struct cfs_bandwidth *cfs_b,
 	/* note: this is a positive sum as runtime_remaining <= 0 */
 	min_amount = target_runtime - cfs_rq->runtime_remaining;
 
-	if (cfs_b->quota == RUNTIME_INF)
+	if (cfs_b->quota == RUNTIME_INF) {
 		amount = min_amount;
-	else {
+	} else {
 		start_cfs_bandwidth(cfs_b);
 
 		if (cfs_b->runtime > 0) {
-- 
2.19.1.6.gb485710b

