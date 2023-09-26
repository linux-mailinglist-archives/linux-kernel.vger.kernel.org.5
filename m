Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CF27AE3A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjIZCYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjIZCYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:24:40 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4F292BF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:24:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 53C2960520007;
        Tue, 26 Sep 2023 10:24:18 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     oleg@redhat.com, peterz@infradead.org, mcgrof@kernel.org,
        mathieu.desnoyers@efficios.com, elver@google.com,
        viro@zeniv.linux.org.uk, dvyukov@google.com,
        vincent.whitchurch@axis.com, michael.christie@oracle.com
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?kernel/signal:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=98NULL=E2=80=99=20values=20from=20ucounts?=
Date:   Tue, 26 Sep 2023 10:24:10 +0800
Message-Id: <20230926022410.4280-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ucounts is assigned first, so it does not need to initialize the
assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 09019017d669..27f6cd37ac4f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -415,7 +415,7 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 		 int override_rlimit, const unsigned int sigqueue_flags)
 {
 	struct sigqueue *q = NULL;
-	struct ucounts *ucounts = NULL;
+	struct ucounts *ucounts;
 	long sigpending;
 
 	/*
-- 
2.18.2

