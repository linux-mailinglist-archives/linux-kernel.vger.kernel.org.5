Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606A87E758A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbjKJADP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345678AbjKJACj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:02:39 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49B7526B;
        Thu,  9 Nov 2023 16:01:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28014fed9efso1389320a91.0;
        Thu, 09 Nov 2023 16:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574468; x=1700179268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TirQszoov6JDdd3RJseoTrT5O03ly6KXmzpIjweuds=;
        b=L/QDVr0kzQq9LFND7WQdh6Xuo1ObER688a3szWzxSn8yZCRVkApS+01eM1WYPBa/Jr
         OxtelX3RM9WQf6mcMjx8dT1fqtYg74UzDVGJ1x0aqlrun+KAUD0xTFBbOdcKHsX2mDLV
         cJ0ppXNwojjeTt1Fwv5vrWG28RXs6pJI5n7cs+WZh4b1842VIR7bh/ZVi80tyqgMrrtT
         jgwfpT+U493Zc2db1UlMAj+xhl6nXdq08McNsB85XbqO4doRADMyfxVLRUqYcMga77Bb
         U8J5JvSoX466eid2dJTK82uTsKBYqpuOHFm3EatCr7p6OMsDnl7DCRFRafMcnYb6iO2l
         2V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574468; x=1700179268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2TirQszoov6JDdd3RJseoTrT5O03ly6KXmzpIjweuds=;
        b=c+ZtG8FoRNExRLBdvzX8wuYZW04p2mmxyTAUCDp9VJY012EkrL0wA4iOPKJfxA49kh
         XrpbPNg7AHVx1oi9jcw/6XtYvv+8YG+YwUuTNpTi6rhRVaas3GoOITKwekGpy8WJjkmE
         EGdCC3rlSFJPp8GHZot8wTyiZ+hWlkLUK3TR6zTdr0FXjxu/fwicVvRugtbW2fDp9w8Z
         93i/bTWf4Kq7PEXeeNAUgfWViNG6kVMY+umThLGhw+jc+JTy8l/79/9G22WC8EnD5EHe
         1kSlMgc97QbUo584NhbvTwr1mJVUBv3fTCYb1IsiVeXnDzUwsF3RUIG0POEk6AFU+l0o
         mvtQ==
X-Gm-Message-State: AOJu0YxHDFUBgtKw/nl8ayg1DaVwRaQk4cj+0pTDipD0+Rrxel4GWhHT
        B+ZfGAGdAvEtw2qqgBoPaklKhzWNfdo=
X-Google-Smtp-Source: AGHT+IEssv0pWffhmUk+ug7fFo5ER9HZljsxKpaAjJ3cgiGCv86TG9hxJffxveYqLUFjUHmqX0PGEg==
X-Received: by 2002:a17:90b:350a:b0:27f:fe79:eb6c with SMTP id ls10-20020a17090b350a00b0027ffe79eb6cmr2885865pjb.29.1699574467991;
        Thu, 09 Nov 2023 16:01:07 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:07 -0800 (PST)
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 34/52] perf annotate-data: Support global variables
Date:   Thu,  9 Nov 2023 15:59:53 -0800
Message-ID: <20231110000012.3538610-35-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Global variables are accessed using PC-relative address so it needs to
be handled separately.  The PC-rel addressing is detected by using
DWARF_REG_PC.  On x86, %rip register would be used.

The address can be calculated using the ip and offset in the
instruction.  But it should start from the next instruction so add
calculate_pcrel_addr() to do it properly.

But global variables defined in a different file would only have a
declaration which doesn't include a location list.  So it first tries
to get the type info using the address, and then looks up the variable
declarations using name.  The name of global variables should be get
from the symbol table.  The declaration would have the type info.

So extend find_var_type() to take both address and name for global
variables.

The stat is now looks like:

  Annotate data type stats:
  total 294, ok 153 (52.0%), bad 141 (48.0%)
  -----------------------------------------------------------
          30 : no_sym
          32 : no_mem_ops
          61 : no_var
          10 : no_typeinfo
           8 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 38 ++++++++++++++++------
 tools/perf/util/annotate-data.h |  6 ++--
 tools/perf/util/annotate.c      | 57 +++++++++++++++++++++++++++++++--
 tools/perf/util/annotate.h      |  4 +++
 4 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 61d2a17044c0..99ecf4b3665c 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -239,7 +239,8 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
 
 /* The result will be saved in @type_die */
 static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
-			      struct annotated_op_loc *loc, Dwarf_Die *type_die)
+			      const char *var_name, struct annotated_op_loc *loc,
+			      Dwarf_Die *type_die)
 {
 	Dwarf_Die cu_die, var_die;
 	Dwarf_Die *scopes = NULL;
@@ -257,11 +258,21 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 	reg = loc->reg1;
 	offset = loc->offset;
 
-	if (reg == DWARF_REG_PC &&
-	    die_find_variable_by_addr(&cu_die, pc, addr, &var_die, &offset)) {
-		ret = check_variable(&var_die, type_die, offset,
-				     /*is_pointer=*/false);
-		goto out;
+	if (reg == DWARF_REG_PC) {
+		if (die_find_variable_by_addr(&cu_die, pc, addr, &var_die, &offset)) {
+			ret = check_variable(&var_die, type_die, offset,
+					     /*is_pointer=*/false);
+			loc->offset = offset;
+			goto out;
+		}
+
+		if (var_name && die_find_variable_at(&cu_die, var_name, pc,
+						     &var_die)) {
+			ret = check_variable(&var_die, type_die, 0,
+					     /*is_pointer=*/false);
+			/* loc->offset will be updated by the caller */
+			goto out;
+		}
 	}
 
 	/* Get a list of nested scopes - i.e. (inlined) functions and blocks. */
@@ -284,6 +295,7 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 		/* Found a variable, see if it's correct */
 		ret = check_variable(&var_die, type_die, offset,
 				     reg != DWARF_REG_PC);
+		loc->offset = offset;
 		goto out;
 	}
 
@@ -305,13 +317,21 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
  * @ms: map and symbol at the location
  * @ip: instruction address of the memory access
  * @loc: instruction operand location
+ * @addr: data address of the memory access
+ * @var_name: global variable name
  *
  * This functions searches the debug information of the binary to get the data
- * type it accesses.  The exact location is expressed by (ip, reg, offset).
+ * type it accesses.  The exact location is expressed by (@ip, reg, offset)
+ * for pointer variables or (@ip, @addr) for global variables.  Note that global
+ * variables might update the @loc->offset after finding the start of the variable.
+ * If it cannot find a global variable by address, it tried to fine a declaration
+ * of the variable using @var_name.  In that case, @loc->offset won't be updated.
+ *
  * It return %NULL if not found.
  */
 struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   struct annotated_op_loc *loc)
+					   struct annotated_op_loc *loc, u64 addr,
+					   const char *var_name)
 {
 	struct annotated_data_type *result = NULL;
 	struct dso *dso = ms->map->dso;
@@ -331,7 +351,7 @@ struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
 	 * a file address for DWARF processing.
 	 */
 	pc = map__rip_2objdump(ms->map, ip);
-	if (find_data_type_die(di, pc, 0, loc, &type_die) < 0)
+	if (find_data_type_die(di, pc, addr, var_name, loc, &type_die) < 0)
 		goto out;
 
 	result = dso__findnew_data_type(dso, &type_die);
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 214c625e7bc9..1b0db8e8c40e 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -107,7 +107,8 @@ extern struct annotated_data_stat ann_data_stat;
 
 /* Returns data type at the location (ip, reg, offset) */
 struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   struct annotated_op_loc *loc);
+					   struct annotated_op_loc *loc, u64 addr,
+					   const char *var_name);
 
 /* Update type access histogram at the given offset */
 int annotated_data_type__update_samples(struct annotated_data_type *adt,
@@ -121,7 +122,8 @@ void annotated_data_type__tree_delete(struct rb_root *root);
 
 static inline struct annotated_data_type *
 find_data_type(struct map_symbol *ms __maybe_unused, u64 ip __maybe_unused,
-	       struct annotated_op_loc *loc __maybe_unused)
+	       struct annotated_op_loc *loc __maybe_unused,
+	       u64 addr __maybe_unused, const char *var_name __maybe_unused)
 {
 	return NULL;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4ea32c2dee4b..4f74db1d3256 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -37,6 +37,7 @@
 #include "util/sharded_mutex.h"
 #include "arch/common.h"
 #include "namespaces.h"
+#include "thread.h"
 #include <regex.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
@@ -3748,6 +3749,30 @@ static bool is_stack_operation(struct arch *arch, struct disasm_line *dl)
 	return false;
 }
 
+u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
+			struct disasm_line *dl)
+{
+	struct annotation *notes;
+	struct disasm_line *next;
+	u64 addr;
+
+	notes = symbol__annotation(ms->sym);
+	/*
+	 * PC-relative addressing starts from the next instruction address
+	 * But the IP is for the current instruction.  Since disasm_line
+	 * doesn't have the instruction size, calculate it using the next
+	 * disasm_line.  If it's the last one, we can use symbol's end
+	 * address directly.
+	 */
+	if (&dl->al.node == notes->src->source.prev)
+		addr = ms->sym->end + offset;
+	else {
+		next = list_next_entry(dl, al.node);
+		addr = ip + (next->al.offset - dl->al.offset) + offset;
+	}
+	return map__rip_2objdump(ms->map, addr);
+}
+
 /**
  * hist_entry__get_data_type - find data type for given hist entry
  * @he: hist entry
@@ -3767,7 +3792,9 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct annotated_op_loc *op_loc;
 	struct annotated_data_type *mem_type;
 	struct annotated_item_stat *istat;
-	u64 ip = he->ip;
+	u64 ip = he->ip, addr = 0;
+	const char *var_name = NULL;
+	int var_offset;
 	int i;
 
 	ann_data_stat.total++;
@@ -3821,12 +3848,38 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		/* Recalculate IP because of LOCK prefix or insn fusion */
 		ip = ms->sym->start + dl->al.offset;
 
-		mem_type = find_data_type(ms, ip, op_loc);
+		var_offset = op_loc->offset;
+
+		/* PC-relative addressing */
+		if (op_loc->reg1 == DWARF_REG_PC) {
+			struct addr_location al;
+			struct symbol *var;
+			u64 map_addr;
+
+			addr = annotate_calc_pcrel(ms, ip, op_loc->offset, dl);
+			/* Kernel symbols might be relocated */
+			map_addr = addr + map__reloc(ms->map);
+
+			addr_location__init(&al);
+			var = thread__find_symbol_fb(he->thread, he->cpumode,
+						     map_addr, &al);
+			if (var) {
+				var_name = var->name;
+				/* Calculate type offset from the start of variable */
+				var_offset = map_addr - map__unmap_ip(al.map, var->start);
+			}
+			addr_location__exit(&al);
+		}
+
+		mem_type = find_data_type(ms, ip, op_loc, addr, var_name);
 		if (mem_type)
 			istat->good++;
 		else
 			istat->bad++;
 
+		if (mem_type && var_name)
+			op_loc->offset = var_offset;
+
 		if (symbol_conf.annotate_data_sample) {
 			annotated_data_type__update_samples(mem_type, evsel,
 							    op_loc->offset,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index f5a6c3227757..79ccc65c9ff9 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -497,4 +497,8 @@ struct annotated_item_stat {
 };
 extern struct list_head ann_insn_stat;
 
+/* Calculate PC-relative address */
+u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
+			struct disasm_line *dl);
+
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.42.0.869.gea05f2083d-goog

