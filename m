Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8F278A3E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 03:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjH1B26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 21:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjH1B2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 21:28:36 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AEB2CCC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 18:28:32 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 3CB3D6049A9D7;
        Mon, 28 Aug 2023 09:28:19 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?kernel/workqueue:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20work=5Fflags?=
Date:   Wed, 30 Aug 2023 01:59:38 +0800
Message-Id: <20230829175938.3000-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 800b4208dba9..45213c74d391 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2988,7 +2988,7 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 			      struct wq_barrier *barr,
 			      struct work_struct *target, struct worker *worker)
 {
-	unsigned int work_flags = 0;
+	unsigned int work_flags;
 	unsigned int work_color;
 	struct list_head *head;
 
@@ -3006,7 +3006,7 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 	barr->task = current;
 
 	/* The barrier work item does not participate in pwq->nr_active. */
-	work_flags |= WORK_STRUCT_INACTIVE;
+	work_flags = WORK_STRUCT_INACTIVE;
 
 	/*
 	 * If @target is currently being executed, schedule the
-- 
2.18.2

