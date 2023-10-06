Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CF97BBA8A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjJFOlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjJFOlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:41:25 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8ADEA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:41:21 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5e53:403c:300c:38ca])
        by albert.telenet-ops.be with bizsmtp
        id uehJ2A0020nPCdM06ehJGo; Fri, 06 Oct 2023 16:41:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qom10-005X4e-33;
        Fri, 06 Oct 2023 16:41:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qom10-006v2U-0f;
        Fri, 06 Oct 2023 16:41:18 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/5] m68k: kernel: Fix indentation by 7 spaces in traps.c
Date:   Fri,  6 Oct 2023 16:41:12 +0200
Message-Id: <d1b38c9d389c1135f7856cf5f90852c2f1584c50.1696602993.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696602993.git.geert@linux-m68k.org>
References: <cover.1696602993.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indentation should use TABs, not spaces.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/kernel/traps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 8ee773d29954921c..53d0cf343d90f9b2 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -486,10 +486,10 @@ static inline void bus_error030 (struct frame *fp)
 	if (buserr_type & SUN3_BUSERR_INVALID) {
 		if (!mmu_emu_handle_fault(addr, 1, 0))
 			do_page_fault (&fp->ptregs, addr, 0);
-       } else {
+	} else {
 		pr_debug("protection fault on insn access (segv).\n");
 		force_sig (SIGSEGV);
-       }
+	}
 }
 #else
 #if defined(CPU_M68020_OR_M68030)
@@ -850,9 +850,9 @@ void show_registers(struct pt_regs *regs)
 	pr_info("PC: [<%08lx>] %pS\n", regs->pc, (void *)regs->pc);
 	pr_info("SR: %04x  SP: %p  a2: %08lx\n", regs->sr, regs, regs->a2);
 	pr_info("d0: %08lx    d1: %08lx    d2: %08lx    d3: %08lx\n",
-	       regs->d0, regs->d1, regs->d2, regs->d3);
+		regs->d0, regs->d1, regs->d2, regs->d3);
 	pr_info("d4: %08lx    d5: %08lx    a0: %08lx    a1: %08lx\n",
-	       regs->d4, regs->d5, regs->a0, regs->a1);
+		regs->d4, regs->d5, regs->a0, regs->a1);
 
 	pr_info("Process %s (pid: %d, task=%p)\n",
 		current->comm, task_pid_nr(current), current);
-- 
2.34.1

