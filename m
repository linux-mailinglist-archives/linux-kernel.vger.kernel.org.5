Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9837B7FD781
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjK2NHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjK2NHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:07:02 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71DD010E2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:07:07 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxY_B5N2dlXqc9AA--.56988S3;
        Wed, 29 Nov 2023 21:07:05 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axzy91N2dlVtNPAA--.45987S3;
        Wed, 29 Nov 2023 21:07:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] objtool/LoongArch: Enable objtool to be built
Date:   Wed, 29 Nov 2023 21:06:54 +0800
Message-ID: <20231129130701.27744-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129130701.27744-1-yangtiezhu@loongson.cn>
References: <20231129130701.27744-1-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axzy91N2dlVtNPAA--.45987S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtr47ur1kJF13ZF1rAw1fuFX_yoWxZw15pF
        4Du3sxGF48WFyfuw1xt3W5WrW3Jan7WryIqFy2qry8ZFZrX3s7tr4Skr4DAFy8Xws5KFyx
        XFnag3WjvFsFyabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU8q2NtUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the minimal changes to enable objtool build on LoongArch,
most of the functions are stubs to only fix the build errors
when make -C tools/objtool.

This is similar with commit e52ec98c5ab1 ("objtool/powerpc:
Enable objtool to be built on ppc").

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Co-developed-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/loongarch/Build            |  2 +
 tools/objtool/arch/loongarch/decode.c         | 71 +++++++++++++++++++
 .../arch/loongarch/include/arch/cfi_regs.h    | 22 ++++++
 .../objtool/arch/loongarch/include/arch/elf.h | 30 ++++++++
 .../arch/loongarch/include/arch/special.h     | 33 +++++++++
 tools/objtool/arch/loongarch/special.c        | 15 ++++
 6 files changed, 173 insertions(+)
 create mode 100644 tools/objtool/arch/loongarch/Build
 create mode 100644 tools/objtool/arch/loongarch/decode.c
 create mode 100644 tools/objtool/arch/loongarch/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/loongarch/include/arch/elf.h
 create mode 100644 tools/objtool/arch/loongarch/include/arch/special.h
 create mode 100644 tools/objtool/arch/loongarch/special.c

diff --git a/tools/objtool/arch/loongarch/Build b/tools/objtool/arch/loongarch/Build
new file mode 100644
index 000000000000..d24d5636a5b8
--- /dev/null
+++ b/tools/objtool/arch/loongarch/Build
@@ -0,0 +1,2 @@
+objtool-y += decode.o
+objtool-y += special.o
diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
new file mode 100644
index 000000000000..cc74ba4e0f54
--- /dev/null
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <string.h>
+#include <objtool/check.h>
+
+int arch_ftrace_match(char *name)
+{
+	return !strcmp(name, "_mcount");
+}
+
+unsigned long arch_jump_destination(struct instruction *insn)
+{
+	return insn->offset + (insn->immediate << 2);
+}
+
+unsigned long arch_dest_reloc_offset(int addend)
+{
+	return addend;
+}
+
+bool arch_pc_relative_reloc(struct reloc *reloc)
+{
+	return false;
+}
+
+bool arch_callee_saved_reg(unsigned char reg)
+{
+	switch (reg) {
+	case CFI_RA:
+	case CFI_FP:
+	case CFI_S0 ... CFI_S8:
+		return true;
+	default:
+		return false;
+	}
+}
+
+int arch_decode_hint_reg(u8 sp_reg, int *base)
+{
+	return 0;
+}
+
+int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
+			    unsigned long offset, unsigned int maxlen,
+			    struct instruction *insn)
+{
+	return 0;
+}
+
+const char *arch_nop_insn(int len)
+{
+	return NULL;
+}
+
+const char *arch_ret_insn(int len)
+{
+	return NULL;
+}
+
+void arch_initial_func_cfi_state(struct cfi_init_state *state)
+{
+	int i;
+
+	for (i = 0; i < CFI_NUM_REGS; i++) {
+		state->regs[i].base = CFI_UNDEFINED;
+		state->regs[i].offset = 0;
+	}
+
+	/* initial CFA (call frame address) */
+	state->cfa.base = CFI_SP;
+	state->cfa.offset = 0;
+}
diff --git a/tools/objtool/arch/loongarch/include/arch/cfi_regs.h b/tools/objtool/arch/loongarch/include/arch/cfi_regs.h
new file mode 100644
index 000000000000..d183cc8f43bf
--- /dev/null
+++ b/tools/objtool/arch/loongarch/include/arch/cfi_regs.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _OBJTOOL_ARCH_CFI_REGS_H
+#define _OBJTOOL_ARCH_CFI_REGS_H
+
+#define CFI_RA		1
+#define CFI_SP		3
+#define CFI_A0		4
+#define CFI_FP		22
+#define CFI_S0		23
+#define CFI_S1		24
+#define CFI_S2		25
+#define CFI_S3		26
+#define CFI_S4		27
+#define CFI_S5		28
+#define CFI_S6		29
+#define CFI_S7		30
+#define CFI_S8		31
+#define CFI_NUM_REGS	32
+
+#define CFI_BP		CFI_FP
+
+#endif /* _OBJTOOL_ARCH_CFI_REGS_H */
diff --git a/tools/objtool/arch/loongarch/include/arch/elf.h b/tools/objtool/arch/loongarch/include/arch/elf.h
new file mode 100644
index 000000000000..9623d663220e
--- /dev/null
+++ b/tools/objtool/arch/loongarch/include/arch/elf.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _OBJTOOL_ARCH_ELF_H
+#define _OBJTOOL_ARCH_ELF_H
+
+/*
+ * See the following link for more info about ELF Relocation types:
+ * https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.html#_relocations
+ */
+#ifndef R_LARCH_NONE
+#define R_LARCH_NONE		0
+#endif
+#ifndef R_LARCH_32
+#define R_LARCH_32		1
+#endif
+#ifndef R_LARCH_64
+#define R_LARCH_64		2
+#endif
+#ifndef R_LARCH_32_PCREL
+#define R_LARCH_32_PCREL	99
+#endif
+
+#define R_NONE			R_LARCH_NONE
+#define R_ABS32			R_LARCH_32
+#define R_ABS64			R_LARCH_64
+#define R_DATA32		R_LARCH_32_PCREL
+#define R_DATA64		R_LARCH_32_PCREL
+#define R_TEXT32		R_LARCH_32_PCREL
+#define R_TEXT64		R_LARCH_32_PCREL
+
+#endif /* _OBJTOOL_ARCH_ELF_H */
diff --git a/tools/objtool/arch/loongarch/include/arch/special.h b/tools/objtool/arch/loongarch/include/arch/special.h
new file mode 100644
index 000000000000..35fc979b550a
--- /dev/null
+++ b/tools/objtool/arch/loongarch/include/arch/special.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _OBJTOOL_ARCH_SPECIAL_H
+#define _OBJTOOL_ARCH_SPECIAL_H
+
+/*
+ * See more info about struct exception_table_entry
+ * in arch/loongarch/include/asm/extable.h
+ */
+#define EX_ENTRY_SIZE		12
+#define EX_ORIG_OFFSET		0
+#define EX_NEW_OFFSET		4
+
+/*
+ * See more info about struct jump_entry
+ * in include/linux/jump_label.h
+ */
+#define JUMP_ENTRY_SIZE		16
+#define JUMP_ORIG_OFFSET	0
+#define JUMP_NEW_OFFSET		4
+#define JUMP_KEY_OFFSET		8
+
+/*
+ * See more info about struct alt_instr
+ * in arch/loongarch/include/asm/alternative.h
+ */
+#define ALT_ENTRY_SIZE		12
+#define ALT_ORIG_OFFSET		0
+#define ALT_NEW_OFFSET		4
+#define ALT_FEATURE_OFFSET	8
+#define ALT_ORIG_LEN_OFFSET	10
+#define ALT_NEW_LEN_OFFSET	11
+
+#endif /* _OBJTOOL_ARCH_SPECIAL_H */
diff --git a/tools/objtool/arch/loongarch/special.c b/tools/objtool/arch/loongarch/special.c
new file mode 100644
index 000000000000..9bba1e9318e0
--- /dev/null
+++ b/tools/objtool/arch/loongarch/special.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <objtool/special.h>
+
+bool arch_support_alt_relocation(struct special_alt *special_alt,
+				 struct instruction *insn,
+				 struct reloc *reloc)
+{
+	return false;
+}
+
+struct reloc *arch_find_switch_table(struct objtool_file *file,
+				     struct instruction *insn)
+{
+	return NULL;
+}
-- 
2.42.0

