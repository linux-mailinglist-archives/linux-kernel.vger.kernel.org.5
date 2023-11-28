Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD4B7FB28B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343807AbjK1HSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343790AbjK1HSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:18:42 -0500
X-Greylist: delayed 381 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 23:18:48 PST
Received: from mail.linx-info.com (unknown [121.69.130.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1F56B7;
        Mon, 27 Nov 2023 23:18:48 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.linx-info.com (Postfix) with ESMTP id 1771B3211A9;
        Tue, 28 Nov 2023 15:12:27 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at linx-info.com
Received: from mail.linx-info.com ([127.0.0.1])
        by localhost (mail.linx-info.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CQQD6n4os8vE; Tue, 28 Nov 2023 15:12:26 +0800 (CST)
Received: from linx.. (unknown [172.16.0.253])
        by mail.linx-info.com (Postfix) with ESMTP id A6E683211A2;
        Tue, 28 Nov 2023 15:12:26 +0800 (CST)
From:   Wujie Duan <wjduan@linx-info.com>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wujie Duan <wjduan@linx-info.com>
Subject: [PATCH] Mark symbols static where possible for mips/kernel
Date:   Tue, 28 Nov 2023 15:12:25 +0800
Message-Id: <20231128071225.801111-1-wjduan@linx-info.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_20,RCVD_IN_DNSWL_BLOCKED,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get 1 error when building kernel with -Werror=missing-prototypes

Signed-off-by: Wujie Duan <wjduan@linx-info.com>
---
 arch/mips/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 479999b7f2de..b99c0e9bb5c6 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -435,7 +435,7 @@ int protected_restore_fp_context(void __user *sc)
 	return err ?: sig;
 }
 
-int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
+static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 {
 	int err = 0;
 	int i;
-- 
2.34.1

