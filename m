Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE61F76B2AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjHALGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjHALGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:06:09 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC43C59CF;
        Tue,  1 Aug 2023 04:00:02 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxXOqx5chk6wwOAA--.5918S3;
        Tue, 01 Aug 2023 19:00:01 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLCOv5chkAd9DAA--.26809S2;
        Tue, 01 Aug 2023 19:00:00 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH] MIPS: Remove noreturn attribute for die()
Date:   Tue,  1 Aug 2023 18:59:59 +0800
Message-Id: <1690887599-11442-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxLCOv5chkAd9DAA--.26809S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4DZF1xuw1rCFWDJF1rKrX_yoW5WFyDpa
        yqkasrGrW8CFs8u3s8Jr4kCrWayrZ5t3yjkw18KwnaywnIv3yrJF4kJFyjvw4rKry0ga4U
        XFWjqwn5AFs3ZabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcrWFUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If notify_die() returns NOTIFY_STOP, there is no need to call
make_task_dead(), we can remove noreturn attribute for die(),
this is similar with arm64, riscv and csky.

While at it, modify the die() declaration in ptrace.h to fix
the following checkpatch warnings:

  WARNING: function definition argument 'const char *' should also have an identifier name
  WARNING: function definition argument 'struct pt_regs *' should also have an identifier name

Additionally, also remove noreturn attribute for nmi_exception_handler
due to it calls die(), otherwise there exists the following build error:

  arch/mips/kernel/traps.c:2001:1: error: 'noreturn' function does return [-Werror]

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/mips/include/asm/ptrace.h |  2 +-
 arch/mips/kernel/traps.c       | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index daf3cf2..14d2ee9 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -159,7 +159,7 @@ static inline long regs_return_value(struct pt_regs *regs)
 extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall);
 extern asmlinkage void syscall_trace_leave(struct pt_regs *regs);
 
-extern void die(const char *, struct pt_regs *) __noreturn;
+void die(const char *str, struct pt_regs *regs);
 
 static inline void die_if_kernel(const char *str, struct pt_regs *regs)
 {
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 246c6a6..4f5140f 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -391,16 +391,15 @@ void show_registers(struct pt_regs *regs)
 
 static DEFINE_RAW_SPINLOCK(die_lock);
 
-void __noreturn die(const char *str, struct pt_regs *regs)
+void die(const char *str, struct pt_regs *regs)
 {
 	static int die_counter;
-	int sig = SIGSEGV;
+	int ret;
 
 	oops_enter();
 
-	if (notify_die(DIE_OOPS, str, regs, 0, current->thread.trap_nr,
-		       SIGSEGV) == NOTIFY_STOP)
-		sig = 0;
+	ret = notify_die(DIE_OOPS, str, regs, 0,
+			 current->thread.trap_nr, SIGSEGV);
 
 	console_verbose();
 	raw_spin_lock_irq(&die_lock);
@@ -422,7 +421,8 @@ void __noreturn die(const char *str, struct pt_regs *regs)
 	if (regs && kexec_should_crash(current))
 		crash_kexec(regs);
 
-	make_task_dead(sig);
+	if (ret != NOTIFY_STOP)
+		make_task_dead(SIGSEGV);
 }
 
 extern struct exception_table_entry __start___dbe_table[];
@@ -1986,7 +1986,7 @@ int register_nmi_notifier(struct notifier_block *nb)
 	return raw_notifier_chain_register(&nmi_chain, nb);
 }
 
-void __noreturn nmi_exception_handler(struct pt_regs *regs)
+void nmi_exception_handler(struct pt_regs *regs)
 {
 	char str[100];
 
-- 
2.1.0

