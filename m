Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E957FD785
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjK2NHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjK2NHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:07:03 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3791210E4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:07:07 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bxyep6N2dlaqc9AA--.47585S3;
        Wed, 29 Nov 2023 21:07:06 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axzy91N2dlVtNPAA--.45987S6;
        Wed, 29 Nov 2023 21:07:06 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/8] objtool/LoongArch: Enable orc to be built
Date:   Wed, 29 Nov 2023 21:06:57 +0800
Message-ID: <20231129130701.27744-5-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129130701.27744-1-yangtiezhu@loongson.cn>
References: <20231129130701.27744-1-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axzy91N2dlVtNPAA--.45987S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuw1ruF15Cw1ktFykZrWDGFX_yoWfJFyDpF
        1UC3yDJr48XF13Aw1xKa1fWrW5Kws7WF1vyrnxu34jyrWIqw1rJrs7KryqqF98Wws3W3y7
        ZFWYgF4Y9a1DJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU8EeHDUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement arch-specific init_orc_entry(), write_orc_entry(), reg_name(),
orc_type_name(), print_reg() and orc_print_dump(), then set BUILD_ORC as
y to build the orc related files.

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Co-developed-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/arch/loongarch/include/asm/orc_types.h |  58 +++++++
 tools/objtool/Makefile                       |   4 +
 tools/objtool/arch/loongarch/Build           |   1 +
 tools/objtool/arch/loongarch/decode.c        |  16 ++
 tools/objtool/arch/loongarch/orc.c           | 171 +++++++++++++++++++
 5 files changed, 250 insertions(+)
 create mode 100644 tools/arch/loongarch/include/asm/orc_types.h
 create mode 100644 tools/objtool/arch/loongarch/orc.c

diff --git a/tools/arch/loongarch/include/asm/orc_types.h b/tools/arch/loongarch/include/asm/orc_types.h
new file mode 100644
index 000000000000..caf1f71a1057
--- /dev/null
+++ b/tools/arch/loongarch/include/asm/orc_types.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ORC_TYPES_H
+#define _ORC_TYPES_H
+
+#include <linux/types.h>
+
+/*
+ * The ORC_REG_* registers are base registers which are used to find other
+ * registers on the stack.
+ *
+ * ORC_REG_PREV_SP, also known as DWARF Call Frame Address (CFA), is the
+ * address of the previous frame: the caller's SP before it called the current
+ * function.
+ *
+ * ORC_REG_UNDEFINED means the corresponding register's value didn't change in
+ * the current frame.
+ *
+ * The most commonly used base registers are SP and FP -- which the previous SP
+ * is usually based on -- and PREV_SP and UNDEFINED -- which the previous FP is
+ * usually based on.
+ *
+ * The rest of the base registers are needed for special cases like entry code
+ * and GCC realigned stacks.
+ */
+#define ORC_REG_UNDEFINED		0
+#define ORC_REG_PREV_SP			1
+#define ORC_REG_SP			2
+#define ORC_REG_FP			3
+#define ORC_REG_MAX			4
+
+#define ORC_TYPE_UNDEFINED		0
+#define ORC_TYPE_END_OF_STACK		1
+#define ORC_TYPE_CALL			2
+#define ORC_TYPE_REGS			3
+#define ORC_TYPE_REGS_PARTIAL		4
+
+#ifndef __ASSEMBLY__
+/*
+ * This struct is more or less a vastly simplified version of the DWARF Call
+ * Frame Information standard.  It contains only the necessary parts of DWARF
+ * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
+ * unwinder how to find the previous SP and FP (and sometimes entry regs) on
+ * the stack for a given code address.  Each instance of the struct corresponds
+ * to one or more code locations.
+ */
+struct orc_entry {
+	s16		sp_offset;
+	s16		fp_offset;
+	s16		ra_offset;
+	unsigned int	sp_reg:4;
+	unsigned int	fp_reg:4;
+	unsigned int	ra_reg:4;
+	unsigned int	type:3;
+	unsigned int	signal:1;
+};
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ORC_TYPES_H */
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 83b100c1e7f6..bf7f7f84ac62 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -57,6 +57,10 @@ ifeq ($(SRCARCH),x86)
 	BUILD_ORC := y
 endif
 
+ifeq ($(SRCARCH),loongarch)
+	BUILD_ORC := y
+endif
+
 export BUILD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
diff --git a/tools/objtool/arch/loongarch/Build b/tools/objtool/arch/loongarch/Build
index d24d5636a5b8..1d4b784b6887 100644
--- a/tools/objtool/arch/loongarch/Build
+++ b/tools/objtool/arch/loongarch/Build
@@ -1,2 +1,3 @@
 objtool-y += decode.o
 objtool-y += special.o
+objtool-y += orc.o
diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loongarch/decode.c
index ff0b53144d12..aee479d2191c 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -3,6 +3,8 @@
 #include <objtool/check.h>
 #include <objtool/warn.h>
 #include <asm/inst.h>
+#include <asm/orc_types.h>
+#include <linux/objtool_types.h>
 
 #ifndef EM_LOONGARCH
 #define EM_LOONGARCH	258
@@ -42,6 +44,20 @@ bool arch_callee_saved_reg(unsigned char reg)
 
 int arch_decode_hint_reg(u8 sp_reg, int *base)
 {
+	switch (sp_reg) {
+	case ORC_REG_UNDEFINED:
+		*base = CFI_UNDEFINED;
+		break;
+	case ORC_REG_SP:
+		*base = CFI_SP;
+		break;
+	case ORC_REG_FP:
+		*base = CFI_FP;
+		break;
+	default:
+		return -1;
+	}
+
 	return 0;
 }
 
diff --git a/tools/objtool/arch/loongarch/orc.c b/tools/objtool/arch/loongarch/orc.c
new file mode 100644
index 000000000000..873536d009d9
--- /dev/null
+++ b/tools/objtool/arch/loongarch/orc.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/objtool_types.h>
+#include <asm/orc_types.h>
+
+#include <objtool/check.h>
+#include <objtool/orc.h>
+#include <objtool/warn.h>
+#include <objtool/endianness.h>
+
+int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi, struct instruction *insn)
+{
+	struct cfi_reg *fp = &cfi->regs[CFI_FP];
+	struct cfi_reg *ra = &cfi->regs[CFI_RA];
+
+	memset(orc, 0, sizeof(*orc));
+
+	if (!cfi) {
+		/*
+		 * This is usually either unreachable nops/traps (which don't
+		 * trigger unreachable instruction warnings), or
+		 * STACK_FRAME_NON_STANDARD functions.
+		 */
+		orc->type = ORC_TYPE_UNDEFINED;
+		return 0;
+	}
+
+	switch (cfi->type) {
+	case UNWIND_HINT_TYPE_UNDEFINED:
+		orc->type = ORC_TYPE_UNDEFINED;
+		return 0;
+	case UNWIND_HINT_TYPE_END_OF_STACK:
+		orc->type = ORC_TYPE_END_OF_STACK;
+		return 0;
+	case UNWIND_HINT_TYPE_CALL:
+		orc->type = ORC_TYPE_CALL;
+		break;
+	case UNWIND_HINT_TYPE_REGS:
+		orc->type = ORC_TYPE_REGS;
+		break;
+	case UNWIND_HINT_TYPE_REGS_PARTIAL:
+		orc->type = ORC_TYPE_REGS_PARTIAL;
+		break;
+	default:
+		WARN_INSN(insn, "unknown unwind hint type %d", cfi->type);
+		return -1;
+	}
+
+	orc->signal = cfi->signal;
+
+	switch (cfi->cfa.base) {
+	case CFI_SP:
+		orc->sp_reg = ORC_REG_SP;
+		break;
+	case CFI_FP:
+		orc->sp_reg = ORC_REG_FP;
+		break;
+	default:
+		WARN_INSN(insn, "unknown CFA base reg %d", cfi->cfa.base);
+		return -1;
+	}
+
+	switch (fp->base) {
+	case CFI_UNDEFINED:
+		orc->fp_reg = ORC_REG_UNDEFINED;
+		orc->fp_offset = 0;
+		break;
+	case CFI_CFA:
+		orc->fp_reg = ORC_REG_PREV_SP;
+		orc->fp_offset = fp->offset;
+		break;
+	case CFI_FP:
+		orc->fp_reg = ORC_REG_FP;
+		break;
+	default:
+		WARN_INSN(insn, "unknown FP base reg %d", fp->base);
+		return -1;
+	}
+
+	switch (ra->base) {
+	case CFI_UNDEFINED:
+		orc->ra_reg = ORC_REG_UNDEFINED;
+		orc->ra_offset = 0;
+		break;
+	case CFI_CFA:
+		orc->ra_reg = ORC_REG_PREV_SP;
+		orc->ra_offset = ra->offset;
+		break;
+	case CFI_FP:
+		orc->ra_reg = ORC_REG_FP;
+		break;
+	default:
+		WARN_INSN(insn, "unknown RA base reg %d", ra->base);
+		return -1;
+	}
+
+	orc->sp_offset = cfi->cfa.offset;
+
+	return 0;
+}
+
+int write_orc_entry(struct elf *elf, struct section *orc_sec,
+		    struct section *ip_sec, unsigned int idx,
+		    struct section *insn_sec, unsigned long insn_off,
+		    struct orc_entry *o)
+{
+	struct orc_entry *orc;
+
+	/* populate ORC data */
+	orc = (struct orc_entry *)orc_sec->data->d_buf + idx;
+	memcpy(orc, o, sizeof(*orc));
+
+	/* populate reloc for ip */
+	if (!elf_init_reloc_text_sym(elf, ip_sec, idx * sizeof(int), idx,
+				     insn_sec, insn_off))
+		return -1;
+
+	return 0;
+}
+
+static const char *reg_name(unsigned int reg)
+{
+	switch (reg) {
+	case ORC_REG_SP:
+		return "sp";
+	case ORC_REG_FP:
+		return "fp";
+	case ORC_REG_PREV_SP:
+		return "prevsp";
+	default:
+		return "?";
+	}
+}
+
+static const char *orc_type_name(unsigned int type)
+{
+	switch (type) {
+	case UNWIND_HINT_TYPE_CALL:
+		return "call";
+	case UNWIND_HINT_TYPE_REGS:
+		return "regs";
+	case UNWIND_HINT_TYPE_REGS_PARTIAL:
+		return "regs (partial)";
+	default:
+		return "?";
+	}
+}
+
+static void print_reg(unsigned int reg, int offset)
+{
+	if (reg == ORC_REG_UNDEFINED)
+		printf(" (und) ");
+	else
+		printf("%s + %3d", reg_name(reg), offset);
+
+}
+
+void orc_print_dump(struct elf *dummy_elf, struct orc_entry *orc, int i)
+{
+	printf("type:%s", orc_type_name(orc[i].type));
+
+	printf(" sp:");
+	print_reg(orc[i].sp_reg, orc[i].sp_offset);
+
+	printf(" fp:");
+	print_reg(orc[i].fp_reg, orc[i].fp_offset);
+
+	printf(" ra:");
+	print_reg(orc[i].ra_reg, orc[i].ra_offset);
+
+	printf(" signal:%d\n", orc[i].signal);
+}
-- 
2.42.0

