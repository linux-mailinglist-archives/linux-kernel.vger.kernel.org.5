Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393B77C6381
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377248AbjJLDyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347042AbjJLDwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAD8D6E;
        Wed, 11 Oct 2023 20:51:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdf4752c3cso4013015ad.2;
        Wed, 11 Oct 2023 20:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082709; x=1697687509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YslnAGV70/iCzljD98XKB9HW4v1DXAU/2DmY3k4p+M=;
        b=fa2vT/oPA/nUjf/S/ehEoCnJyQzPyrKz9Kbm9t061bdpSFbqi+ldLWyJxybR80pBIa
         2gjGg01A8ju5nrCdMkAg4yzitg4km9D6hTvAaqZAzGjiVJ8tk0Xv2pWDfVRB0vK1Tjcg
         DFUcMgPRUkumEGgW/RCdp4jVGjP68pSR+ylGkZnHKAMnRdPmAC1bUspLC2LG1Ty7hPti
         R2j5NCDYxXMKcozHmlCD1P8OiaCFvPHGlekpq5NAIu61bZ8rEXaiZ51pNDwUQ1hjgIBH
         pTtlu0uQcfpoJp5PJjlIvVxNZUVFr3NQ9Yt4RIiW37VAd0VOZGELmdyzqFn0hFQvOnEl
         IILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082709; x=1697687509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9YslnAGV70/iCzljD98XKB9HW4v1DXAU/2DmY3k4p+M=;
        b=TO12gZR2RGpRM6sDvzxzEG4IG7uZY1L3hhMncx3zlIAYx7xMJvbLTAd7E00MMurB1N
         4WDqYfnnw76wT62irdB8OnPNZALOo4s5K0PMMNQNdG7DvnqAExoydvfII8uVNuWHoThz
         Vpw3LpYgAcxhWJqqeV0EoCVKf+cvANiBmJrHqhjivDojpDvxE3ra+rn/6dI/2eS8fc9V
         BBU8WdvU0dFyWDsCil7HBwppe8jzx2NPsjj4YCMl6muHAD2LOusNZldK2xlxBU8yHy4X
         uWTqH06lrfd69yHO/1HCq9BpFHVSlteV3cZQr6x8RxLx6N/ZXK9kd3HQ2a0RfaNIvme6
         +00w==
X-Gm-Message-State: AOJu0YzdT1iBD3sSGwjx9BbSN/0fkmUAPGHIuY+IiaKX39DQamu3Oxbr
        TcqwwhEWDPaSqGGIP0A3g54=
X-Google-Smtp-Source: AGHT+IEaWi167GBHPv1nwrBVuPUR2vxZsylelf3TI9D8iFDlsKWOCjsCS4AOVFxBIToZDB8WrA+Iww==
X-Received: by 2002:a17:903:18a:b0:1c8:91d8:d5ca with SMTP id z10-20020a170903018a00b001c891d8d5camr14796339plg.42.1697082708952;
        Wed, 11 Oct 2023 20:51:48 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:48 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 26/48] perf annotate-data: Handle array style accesses
Date:   Wed, 11 Oct 2023 20:50:49 -0700
Message-ID: <20231012035111.676789-27-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86, instructions for array access often looks like below.

  mov  0x1234(%rax,%rbx,8), %rcx

Usually the first register holds the type information and the second one
has the index.  And the current code only looks up a variable for the
first register.  But it's possible to be in the other way around so it
needs to check the second register if the first one failed.

The stat changed like this.

  Annotate data type stats:
  total 294, ok 148 (50.3%), bad 146 (49.7%)
  -----------------------------------------------------------
          30 : no_sym
          32 : no_mem_ops
          66 : no_var
          10 : no_typeinfo
           8 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 24 +++++++++++++-----
 tools/perf/util/annotate-data.h |  5 ++--
 tools/perf/util/annotate.c      | 43 ++++++++++++++++++++++++++-------
 tools/perf/util/annotate.h      |  8 ++++--
 4 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 3e30e6855ba8..bf6d53705af3 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 
+#include "annotate.h"
 #include "annotate-data.h"
 #include "debuginfo.h"
 #include "debug.h"
@@ -217,7 +218,8 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
 	 * It expects a pointer type for a memory access.
 	 * Convert to a real type it points to.
 	 */
-	if (dwarf_tag(type_die) != DW_TAG_pointer_type ||
+	if ((dwarf_tag(type_die) != DW_TAG_pointer_type &&
+	     dwarf_tag(type_die) != DW_TAG_array_type) ||
 	    die_get_real_type(type_die, type_die) == NULL) {
 		pr_debug("no pointer or no type\n");
 		ann_data_stat.no_typeinfo++;
@@ -243,10 +245,11 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
 
 /* The result will be saved in @type_die */
 static int find_data_type_die(struct debuginfo *di, u64 pc,
-			      int reg, int offset, Dwarf_Die *type_die)
+			      struct annotated_op_loc *loc, Dwarf_Die *type_die)
 {
 	Dwarf_Die cu_die, var_die;
 	Dwarf_Die *scopes = NULL;
+	int reg, offset;
 	int ret = -1;
 	int i, nr_scopes;
 
@@ -260,6 +263,10 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
 	/* Get a list of nested scopes - i.e. (inlined) functions and blocks. */
 	nr_scopes = die_get_scopes(&cu_die, pc, &scopes);
 
+	reg = loc->reg1;
+	offset = loc->offset;
+
+retry:
 	/* Search from the inner-most scope to the outer */
 	for (i = nr_scopes - 1; i >= 0; i--) {
 		/* Look up variables/parameters in this scope */
@@ -270,6 +277,12 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
 		ret = check_variable(&var_die, type_die, offset);
 		goto out;
 	}
+
+	if (loc->multi_regs && reg == loc->reg1 && loc->reg1 != loc->reg2) {
+		reg = loc->reg2;
+		goto retry;
+	}
+
 	if (ret < 0)
 		ann_data_stat.no_var++;
 
@@ -282,15 +295,14 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
  * find_data_type - Return a data type at the location
  * @ms: map and symbol at the location
  * @ip: instruction address of the memory access
- * @reg: register that holds the base address
- * @offset: offset from the base address
+ * @loc: instruction operand location
  *
  * This functions searches the debug information of the binary to get the data
  * type it accesses.  The exact location is expressed by (ip, reg, offset).
  * It return %NULL if not found.
  */
 struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   int reg, int offset)
+					   struct annotated_op_loc *loc)
 {
 	struct annotated_data_type *result = NULL;
 	struct dso *dso = ms->map->dso;
@@ -310,7 +322,7 @@ struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
 	 * a file address for DWARF processing.
 	 */
 	pc = map__rip_2objdump(ms->map, ip);
-	if (find_data_type_die(di, pc, reg, offset, &type_die) < 0)
+	if (find_data_type_die(di, pc, loc, &type_die) < 0)
 		goto out;
 
 	result = dso__findnew_data_type(dso, &type_die);
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 8e73096c01d1..65ddd839850f 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -7,6 +7,7 @@
 #include <linux/rbtree.h>
 #include <linux/types.h>
 
+struct annotated_op_loc;
 struct evsel;
 struct map_symbol;
 
@@ -105,7 +106,7 @@ extern struct annotated_data_stat ann_data_stat;
 
 /* Returns data type at the location (ip, reg, offset) */
 struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   int reg, int offset);
+					   struct annotated_op_loc *loc);
 
 /* Update type access histogram at the given offset */
 int annotated_data_type__update_samples(struct annotated_data_type *adt,
@@ -119,7 +120,7 @@ void annotated_data_type__tree_delete(struct rb_root *root);
 
 static inline struct annotated_data_type *
 find_data_type(struct map_symbol *ms __maybe_unused, u64 ip __maybe_unused,
-	       int reg __maybe_unused, int offset __maybe_unused)
+	       struct annotated_op_loc *loc __maybe_unused)
 {
 	return NULL;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b0893d8f2ae3..ccd1200746dd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3527,8 +3527,22 @@ static int extract_reg_offset(struct arch *arch, const char *str,
 	if (regname == NULL)
 		return -1;
 
-	op_loc->reg = get_dwarf_regnum(regname, 0);
+	op_loc->reg1 = get_dwarf_regnum(regname, 0);
 	free(regname);
+
+	/* Get the second register */
+	if (op_loc->multi_regs) {
+		p = strchr(p + 1, arch->objdump.register_char);
+		if (p == NULL)
+			return -1;
+
+		regname = strdup(p);
+		if (regname == NULL)
+			return -1;
+
+		op_loc->reg2 = get_dwarf_regnum(regname, 0);
+		free(regname);
+	}
 	return 0;
 }
 
@@ -3541,14 +3555,20 @@ static int extract_reg_offset(struct arch *arch, const char *str,
  * Get detailed location info (register and offset) in the instruction.
  * It needs both source and target operand and whether it accesses a
  * memory location.  The offset field is meaningful only when the
- * corresponding mem flag is set.
+ * corresponding mem flag is set.  The reg2 field is meaningful only
+ * when multi_regs flag is set.
  *
  * Some examples on x86:
  *
- *   mov  (%rax), %rcx   # src_reg = rax, src_mem = 1, src_offset = 0
- *                       # dst_reg = rcx, dst_mem = 0
+ *   mov  (%rax), %rcx   # src_reg1 = rax, src_mem = 1, src_offset = 0
+ *                       # dst_reg1 = rcx, dst_mem = 0
  *
- *   mov  0x18, %r8      # src_reg = -1, dst_reg = r8
+ *   mov  0x18, %r8      # src_reg1 = -1, src_mem = 0
+ *                       # dst_reg1 = r8, dst_mem = 0
+ *
+ *   mov  %rsi, 8(%rbx,%rcx,4)  # src_reg1 = rsi, src_mem = 0, dst_multi_regs = 0
+ *                              # dst_reg1 = rbx, dst_reg2 = rcx, dst_mem = 1
+ *                              # dst_multi_regs = 1, dst_offset = 8
  */
 int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 			       struct annotated_insn_loc *loc)
@@ -3569,24 +3589,29 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 
 	for_each_insn_op_loc(loc, i, op_loc) {
 		const char *insn_str = ops->source.raw;
+		bool multi_regs = ops->source.multi_regs;
 
-		if (i == INSN_OP_TARGET)
+		if (i == INSN_OP_TARGET) {
 			insn_str = ops->target.raw;
+			multi_regs = ops->target.multi_regs;
+		}
 
 		/* Invalidate the register by default */
-		op_loc->reg = -1;
+		op_loc->reg1 = -1;
+		op_loc->reg2 = -1;
 
 		if (insn_str == NULL)
 			continue;
 
 		if (strchr(insn_str, arch->objdump.memory_ref_char)) {
 			op_loc->mem_ref = true;
+			op_loc->multi_regs = multi_regs;
 			extract_reg_offset(arch, insn_str, op_loc);
 		} else {
 			char *s = strdup(insn_str);
 
 			if (s) {
-				op_loc->reg = get_dwarf_regnum(s, 0);
+				op_loc->reg1 = get_dwarf_regnum(s, 0);
 				free(s);
 			}
 		}
@@ -3730,7 +3755,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		/* Recalculate IP because of LOCK prefix or insn fusion */
 		ip = ms->sym->start + dl->al.offset;
 
-		mem_type = find_data_type(ms, ip, op_loc->reg, op_loc->offset);
+		mem_type = find_data_type(ms, ip, op_loc);
 		if (mem_type)
 			istat->good++;
 		else
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 5bb831445cbe..18a81faeb44b 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -440,14 +440,18 @@ int annotate_check_args(struct annotation_options *args);
 
 /**
  * struct annotated_op_loc - Location info of instruction operand
- * @reg: Register in the operand
+ * @reg1: First register in the operand
+ * @reg2: Second register in the operand
  * @offset: Memory access offset in the operand
  * @mem_ref: Whether the operand accesses memory
+ * @multi_regs: Whether the second register is used
  */
 struct annotated_op_loc {
-	int reg;
+	int reg1;
+	int reg2;
 	int offset;
 	bool mem_ref;
+	bool multi_regs;
 };
 
 enum annotated_insn_ops {
-- 
2.42.0.655.g421f12c284-goog

