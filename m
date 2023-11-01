Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5007DDDCF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 09:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjKAIl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjKAIl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 04:41:26 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BF470103
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 01:41:23 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 600026059607D;
        Wed,  1 Nov 2023 16:41:20 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     brauner@kernel.org, viro@zeniv.linux.org.uk, dwindsor@gmail.com,
        keescook@chromium.org, elena.reshetova@intel.com
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?nsproxy:=20Remove=20unnecessary=20=E2=80=980?= =?UTF-8?q?=E2=80=99=20values=20from=20ret?=
Date:   Wed,  1 Nov 2023 16:41:18 +0800
Message-Id: <20231101084118.6954-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ret variable can be defined without assigning a value, as it is
assigned before use.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/nsproxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 15781acaac1ce..b7e398d954b09 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -374,12 +374,12 @@ static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
  */
 static int validate_nsset(struct nsset *nsset, struct pid *pid)
 {
-	int ret = 0;
 	unsigned flags = nsset->flags;
 	struct user_namespace *user_ns = NULL;
 	struct pid_namespace *pid_ns = NULL;
 	struct nsproxy *nsp;
 	struct task_struct *tsk;
+	int ret;
 
 	/* Take a "snapshot" of the target task's namespaces. */
 	rcu_read_lock();
-- 
2.18.2

