Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1796978D24A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241797AbjH3DBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjH3DAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:00:39 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5C05185
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:00:33 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxJujPsO5kEvgcAA--.120S3;
        Wed, 30 Aug 2023 11:00:31 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF8zOsO5kVetmAA--.12565S2;
        Wed, 30 Aug 2023 11:00:31 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2] LoongArch: Define the symbol fault as a local label in fpu.S
Date:   Wed, 30 Aug 2023 11:00:30 +0800
Message-Id: <1693364430-11337-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxF8zOsO5kVetmAA--.12565S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF4ftF1fKw4rJw1UXFy7urX_yoW5uF1xpF
        yUZrWvgr4rW3Z7Aanrtw4q9rZ8Ga9rGF47u3WqyrWxCrWjg3WDta18tryDXF12qa15JF40
        qF4FqrWYq3Wqy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
        Ja73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial aim is to silence the following objtool warnings:

  arch/loongarch/kernel/fpu.o: warning: objtool: _save_fp_context() falls through to next function fault()
  arch/loongarch/kernel/fpu.o: warning: objtool: _restore_fp_context() falls through to next function fault()
  arch/loongarch/kernel/fpu.o: warning: objtool: _save_lsx_context() falls through to next function fault()
  arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lsx_context() falls through to next function fault()
  arch/loongarch/kernel/fpu.o: warning: objtool: _save_lasx_context() falls through to next function fault()
  arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lasx_context() falls through to next function fault()

Currently, SYM_FUNC_END() defines the symbol fault as SYM_T_FUNC which
is STT_FUNC, the objtool warnings are generated through the following
code:

tools/objtool/include/objtool/check.h
static inline struct symbol *insn_func(struct instruction *insn)
{
	struct symbol *sym = insn->sym;

	if (sym && sym->type != STT_FUNC)
		sym = NULL;

	return sym;
}

tools/objtool/check.c
static int validate_branch(struct objtool_file *file, struct symbol *func,
			   struct instruction *insn, struct insn_state state)
{
...
		if (func && insn_func(insn) && func != insn_func(insn)->pfunc) {
...
			WARN("%s() falls through to next function %s()",
			     func->name, insn_func(insn)->name);
			return 1;
		}
...
}

We can see that the fixup can be a local label in the following code:

arch/loongarch/include/asm/asm-extable.h
	.pushsection	__ex_table, "a";		\
	.balign		4;				\
	.long		((insn) - .);			\
	.long		((fixup) - .);			\
	.short		(type);				\
	.short		(data);				\
	.popsection;

	.macro		_asm_extable, insn, fixup
	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
	.endm

Like arch/loongarch/lib/*.S, just define the symbol fault as a local
label in fpu.S.

Before:

$ readelf -s arch/loongarch/kernel/fpu.o | awk -F: /fault/'{print $2}'
 000000000000053c     8 FUNC    GLOBAL DEFAULT    1 fault

After:

$ readelf -s arch/loongarch/kernel/fpu.o | awk -F: /fault/'{print $2}'
 000000000000053c     0 NOTYPE  LOCAL  DEFAULT    1 .L_fixup_fpu_fault

Co-developed-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

Add v2 tag in this patch, please ignore the previous patch, sorry for that.

There is a same issue in lbt.S, Huacai suggested to squash the changes
in the original patch:
"LoongArch: Add Loongson Binary Translation (LBT) extension support"

 arch/loongarch/kernel/fpu.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
index b4032de..3177725 100644
--- a/arch/loongarch/kernel/fpu.S
+++ b/arch/loongarch/kernel/fpu.S
@@ -22,7 +22,7 @@
 
 	.macro	EX insn, reg, src, offs
 .ex\@:	\insn	\reg, \src, \offs
-	_asm_extable .ex\@, fault
+	_asm_extable .ex\@, .L_fixup_fpu_fault
 	.endm
 
 	.macro sc_save_fp base
@@ -521,7 +521,6 @@ SYM_FUNC_START(_restore_lasx_context)
 	jr	ra
 SYM_FUNC_END(_restore_lasx_context)
 
-SYM_FUNC_START(fault)
+.L_fixup_fpu_fault:
 	li.w	a0, -EFAULT				# failure
 	jr	ra
-SYM_FUNC_END(fault)
-- 
2.1.0

