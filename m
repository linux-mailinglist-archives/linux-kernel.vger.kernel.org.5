Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25567CBA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjJQGIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQGIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:08:41 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CFCC5AB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:08:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id C5CC46027B14C;
        Tue, 17 Oct 2023 14:08:25 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     gor@linux.ibm.com, mark.rutland@arm.com, hca@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?stackleak:=20Remove=20unnecessary=20=E2=80=980?= =?UTF-8?q?=E2=80=99=20values=20from=20ret?=
Date:   Tue, 17 Oct 2023 14:08:24 +0800
Message-Id: <20231017060824.10434-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/stackleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index 34c9d81eea940..3faf863593846 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -24,7 +24,7 @@ static DEFINE_STATIC_KEY_FALSE(stack_erasing_bypass);
 static int stack_erasing_sysctl(struct ctl_table *table, int write,
 			void __user *buffer, size_t *lenp, loff_t *ppos)
 {
-	int ret = 0;
+	int ret;
 	int state = !static_branch_unlikely(&stack_erasing_bypass);
 	int prev_state = state;
 
-- 
2.18.2

