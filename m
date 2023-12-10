Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B39180BABC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 13:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjLJMxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 07:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJMxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 07:53:33 -0500
X-Greylist: delayed 318 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Dec 2023 04:53:37 PST
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC70FA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:53:37 -0800 (PST)
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 8F1AF2FC96D6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 13:48:17 +0100 (CET)
Received: from s979.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id 7FB4F2E274E8;
        Sun, 10 Dec 2023 13:48:17 +0100 (CET)
Received: from s473.loopia.se (unknown [172.22.191.6])
        by s979.loopia.se (Postfix) with ESMTP id 7C14710BC4C7;
        Sun, 10 Dec 2023 13:48:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Score: -1.01
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from s981.loopia.se ([172.22.191.5])
        by s473.loopia.se (s473.loopia.se [172.22.190.13]) (amavisd-new, port 10024)
        with LMTP id JvZZ6xxqkSUo; Sun, 10 Dec 2023 13:48:17 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: fredrik@frelon.se
X-Loopia-Originating-IP: 81.233.40.252
Received: from localhost.localdomain (81-233-40-252-no600.tbcn.telia.com [81.233.40.252])
        (Authenticated sender: fredrik@frelon.se)
        by s981.loopia.se (Postfix) with ESMTPSA id 0BA2122B17C2;
        Sun, 10 Dec 2023 13:48:17 +0100 (CET)
From:   =?UTF-8?q?Fredrik=20L=C3=B6nnegren?= <fredrik@frelon.se>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, fredrik.lonnegren@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Fredrik=20L=C3=B6nnegren?= <fredrik@frelon.se>
Subject: [PATCH 1/2] RISC-V: fix include warning in smpboot.c
Date:   Sun, 10 Dec 2023 13:42:24 +0100
Message-ID: <20231210124811.26204-1-fredrik@frelon.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes a warning about duplicate includes of
"asm/cpufeatures.h" found using scripts/checkincludes.pl

Signed-off-by: Fredrik Lönnegren <fredrik@frelon.se>
---
 arch/riscv/kernel/smpboot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index d162bf339beb..1b461570d456 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -26,7 +26,6 @@
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
 
-#include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
 #include <asm/cpufeature.h>
 #include <asm/irq.h>
-- 
2.43.0

