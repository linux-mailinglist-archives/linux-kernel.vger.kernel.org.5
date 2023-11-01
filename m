Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D828C7DDDAD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 09:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjKAIUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 04:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjKAIUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 04:20:16 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 03904B4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 01:20:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 433AC6059605E;
        Wed,  1 Nov 2023 16:19:47 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     akpm@linux-foundation.org, michael.christie@oracle.com,
        brauner@kernel.org, mst@redhat.com, npiggin@gmail.com,
        qiang1.zhang@intel.com, arve@android.com,
        gregkh@linuxfoundation.org, quic_pbaronia@quicinc.com
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] kthread: Modify the ret variable type to bool
Date:   Wed,  1 Nov 2023 16:19:40 +0800
Message-Id: <20231101081940.6147-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of ret  assigned as bool type, and when combined with the
function return type ret, it should be defined as bool.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/kthread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1eea53050babc..9204693e07c68 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1241,7 +1241,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
 {
 	struct kthread_work *work = &dwork->work;
 	unsigned long flags;
-	int ret;
+	bool ret;
 
 	raw_spin_lock_irqsave(&worker->lock, flags);
 
@@ -1286,7 +1286,7 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
 {
 	struct kthread_worker *worker = work->worker;
 	unsigned long flags;
-	int ret = false;
+	bool ret = false;
 
 	if (!worker)
 		goto out;
-- 
2.18.2

