Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743917C63A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 06:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347081AbjJLECE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 00:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbjJLEBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 00:01:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF54170A;
        Wed, 11 Oct 2023 20:52:02 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9b1e3a809so4210645ad.2;
        Wed, 11 Oct 2023 20:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082722; x=1697687522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbNhx62mg3juSg8RKm4fZhibXLOkoCp5ZhYwVrAiyrk=;
        b=SDNCGD6Z8YSZP5/jdUJ5yPabXtGCym2OmFjSqx/xBRMhl1VBaJAuoIUSTqkUMP2+1w
         gZga+0/WK+cPL6LN1xsBYQCay0+ZiZ0gg2A+gg8k1o0iKUx/5I4USBCb55sW1ypIQboj
         mP8SvKbJaGBbfhhItRderUyR5A/q3NoeKweUKFVpOrl2Tsam+C+mi88le2hTWgvM2snE
         7XIAGOsgsi7OVxK7gJZNK5d0OsWYP22r0gAbs8KOfGOwYrX2XE+0FeQBM8BRiMHYsQFl
         9e8s3Gbt+R51vYk508d/df138LGC9DfKUoDCw6mIuAuOXQuuETTy6n5ossagmaMLa3Uy
         SpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082722; x=1697687522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QbNhx62mg3juSg8RKm4fZhibXLOkoCp5ZhYwVrAiyrk=;
        b=UuSyDLHnoFz45KfE38uVLz6SJBOfBl9orIXhRn/sCR0iAFWr7AoQbQzGo3vQbC7LRw
         q7OP1fTwe7Vxh4wxpfmC4Nl3mD5Rb2WJbOl28oVcv6eSpH/H+eyE3mjXFqE57yOCxUHV
         5zt3a5dwrZ7bhn7sRDq7sCbUr6Z/k4LgWDZA/x5gzFXqV89+As4dZZkdzXA+ZdNaZmnH
         Yc813nJscGjrGhIJDp6KQQ+IeGC8lwYtCf/UPuFn1SyXa+wUlhG8sE/XtkFUfwCRZ5KA
         vQz44/1QxPjgZUSy2hQ/vp6+R5lBoFsavWS7vObr8zfKC1cmHJAOKGuQH84obJzRvw/v
         67Vw==
X-Gm-Message-State: AOJu0YwgesxYPmcbz9yueC806G9eqa+AXtWYiMffzO30Z0YUnguenGnW
        f1FGKG9FWg1oqdRMcVBhK4s=
X-Google-Smtp-Source: AGHT+IHyazLbAAQ10RSjnGoc93S6UYpNyB3YIHV2vctgxFaPr2zkg/MZhi4HpqYeHLFvIyF/x+HQlw==
X-Received: by 2002:a17:903:2286:b0:1c5:d8a3:8789 with SMTP id b6-20020a170903228600b001c5d8a38789mr25769463plh.4.1697082721970;
        Wed, 11 Oct 2023 20:52:01 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:52:01 -0700 (PDT)
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
Subject: [PATCH 36/48] perf annotate-data: Introduce struct data_loc_info
Date:   Wed, 11 Oct 2023 20:50:59 -0700
Message-ID: <20231012035111.676789-37-namhyung@kernel.org>
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

The find_data_type() needs many information to describe the location of
the data.  Add the new struct data_loc_info to pass those information at
once.

No functional changes intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 83 +++++++++++++++++----------------
 tools/perf/util/annotate-data.h | 38 ++++++++++++---
 tools/perf/util/annotate.c      | 30 ++++++------
 3 files changed, 91 insertions(+), 60 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 39bbd56b2160..90793cbb6aa0 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -256,21 +256,28 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
 }
 
 /* The result will be saved in @type_die */
-static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
-			      const char *var_name, struct annotated_op_loc *loc,
-			      Dwarf_Die *type_die)
+static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 {
+	struct annotated_op_loc *loc = dloc->op;
 	Dwarf_Die cu_die, var_die;
 	Dwarf_Die *scopes = NULL;
 	int reg, offset;
 	int ret = -1;
 	int i, nr_scopes;
 	int fbreg = -1;
-	bool is_fbreg = false;
 	int fb_offset = 0;
+	bool is_fbreg = false;
+	u64 pc;
+
+	/*
+	 * IP is a relative instruction address from the start of the map, as
+	 * it can be randomized/relocated, it needs to translate to PC which is
+	 * a file address for DWARF processing.
+	 */
+	pc = map__rip_2objdump(dloc->ms->map, dloc->ip);
 
 	/* Get a compile_unit for this address */
-	if (!find_cu_die(di, pc, &cu_die)) {
+	if (!find_cu_die(dloc->di, pc, &cu_die)) {
 		pr_debug("cannot find CU for address %lx\n", pc);
 		ann_data_stat.no_cuinfo++;
 		return -1;
@@ -280,18 +287,19 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 	offset = loc->offset;
 
 	if (reg == DWARF_REG_PC) {
-		if (die_find_variable_by_addr(&cu_die, pc, addr, &var_die, &offset)) {
+		if (die_find_variable_by_addr(&cu_die, pc, dloc->var_addr,
+					      &var_die, &offset)) {
 			ret = check_variable(&var_die, type_die, offset,
 					     /*is_pointer=*/false);
-			loc->offset = offset;
+			dloc->type_offset = offset;
 			goto out;
 		}
 
-		if (var_name && die_find_variable_at(&cu_die, var_name, pc,
-						     &var_die)) {
-			ret = check_variable(&var_die, type_die, 0,
+		if (dloc->var_name &&
+		    die_find_variable_at(&cu_die, dloc->var_name, pc, &var_die)) {
+			ret = check_variable(&var_die, type_die, dloc->type_offset,
 					     /*is_pointer=*/false);
-			/* loc->offset will be updated by the caller */
+			/* dloc->type_offset was updated by the caller */
 			goto out;
 		}
 	}
@@ -308,10 +316,11 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 		    dwarf_formblock(&attr, &block) == 0 && block.length == 1) {
 			switch (*block.data) {
 			case DW_OP_reg0 ... DW_OP_reg31:
-				fbreg = *block.data - DW_OP_reg0;
+				fbreg = dloc->fbreg = *block.data - DW_OP_reg0;
 				break;
 			case DW_OP_call_frame_cfa:
-				if (die_get_cfa(di->dbg, pc, &fbreg,
+				dloc->fb_cfa = true;
+				if (die_get_cfa(dloc->di->dbg, pc, &fbreg,
 						&fb_offset) < 0)
 					fbreg = -1;
 				break;
@@ -329,7 +338,7 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 	/* Search from the inner-most scope to the outer */
 	for (i = nr_scopes - 1; i >= 0; i--) {
 		if (reg == DWARF_REG_PC) {
-			if (!die_find_variable_by_addr(&scopes[i], pc, addr,
+			if (!die_find_variable_by_addr(&scopes[i], pc, dloc->var_addr,
 						       &var_die, &offset))
 				continue;
 		} else {
@@ -342,7 +351,7 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 		/* Found a variable, see if it's correct */
 		ret = check_variable(&var_die, type_die, offset,
 				     reg != DWARF_REG_PC && !is_fbreg);
-		loc->offset = offset;
+		dloc->type_offset = offset;
 		goto out;
 	}
 
@@ -361,50 +370,46 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 
 /**
  * find_data_type - Return a data type at the location
- * @ms: map and symbol at the location
- * @ip: instruction address of the memory access
- * @loc: instruction operand location
- * @addr: data address of the memory access
- * @var_name: global variable name
+ * @dloc: data location
  *
  * This functions searches the debug information of the binary to get the data
- * type it accesses.  The exact location is expressed by (@ip, reg, offset)
- * for pointer variables or (@ip, @addr) for global variables.  Note that global
- * variables might update the @loc->offset after finding the start of the variable.
- * If it cannot find a global variable by address, it tried to fine a declaration
- * of the variable using @var_name.  In that case, @loc->offset won't be updated.
+ * type it accesses.  The exact location is expressed by (ip, reg, offset)
+ * for pointer variables or (ip, addr) for global variables.  Note that global
+ * variables might update the @dloc->type_offset after finding the start of the
+ * variable.  If it cannot find a global variable by address, it tried to find
+ * a declaration of the variable using var_name.  In that case, @dloc->offset
+ * won't be updated.
  *
  * It return %NULL if not found.
  */
-struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   struct annotated_op_loc *loc, u64 addr,
-					   const char *var_name)
+struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 {
 	struct annotated_data_type *result = NULL;
-	struct dso *dso = ms->map->dso;
-	struct debuginfo *di;
+	struct dso *dso = dloc->ms->map->dso;
 	Dwarf_Die type_die;
-	u64 pc;
 
-	di = debuginfo__new(dso->long_name);
-	if (di == NULL) {
+	dloc->di = debuginfo__new(dso->long_name);
+	if (dloc->di == NULL) {
 		pr_debug("cannot get the debug info\n");
 		return NULL;
 	}
 
 	/*
-	 * IP is a relative instruction address from the start of the map, as
-	 * it can be randomized/relocated, it needs to translate to PC which is
-	 * a file address for DWARF processing.
+	 * The type offset is the same as instruction offset by default.
+	 * But when finding a global variable, the offset won't be valid.
 	 */
-	pc = map__rip_2objdump(ms->map, ip);
-	if (find_data_type_die(di, pc, addr, var_name, loc, &type_die) < 0)
+	if (dloc->var_name == NULL)
+		dloc->type_offset = dloc->op->offset;
+
+	dloc->fbreg = -1;
+
+	if (find_data_type_die(dloc, &type_die) < 0)
 		goto out;
 
 	result = dso__findnew_data_type(dso, &type_die);
 
 out:
-	debuginfo__delete(di);
+	debuginfo__delete(dloc->di);
 	return result;
 }
 
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 1b0db8e8c40e..ad6493ea2c8e 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 
 struct annotated_op_loc;
+struct debuginfo;
 struct evsel;
 struct map_symbol;
 
@@ -72,6 +73,35 @@ struct annotated_data_type {
 extern struct annotated_data_type unknown_type;
 extern struct annotated_data_type stackop_type;
 
+/**
+ * struct data_loc_info - Data location information
+ * @ms: Map and Symbol info
+ * @ip: Instruction address
+ * @var_addr: Data address (for global variables)
+ * @var_name: Variable name (for global variables)
+ * @op: Instruction operand location (regs and offset)
+ * @di: Debug info
+ * @fbreg: Frame base register
+ * @fb_cfa: Whether the frame needs to check CFA
+ * @type_offset: Final offset in the type
+ */
+struct data_loc_info {
+	/* These are input field, should be filled by caller */
+	struct map_symbol *ms;
+	u64 ip;
+	u64 var_addr;
+	const char *var_name;
+	struct annotated_op_loc *op;
+
+	/* These are used internally */
+	struct debuginfo *di;
+	int fbreg;
+	bool fb_cfa;
+
+	/* This is for the result */
+	int type_offset;
+};
+
 /**
  * struct annotated_data_stat - Debug statistics
  * @total: Total number of entry
@@ -106,9 +136,7 @@ extern struct annotated_data_stat ann_data_stat;
 #ifdef HAVE_DWARF_SUPPORT
 
 /* Returns data type at the location (ip, reg, offset) */
-struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   struct annotated_op_loc *loc, u64 addr,
-					   const char *var_name);
+struct annotated_data_type *find_data_type(struct data_loc_info *dloc);
 
 /* Update type access histogram at the given offset */
 int annotated_data_type__update_samples(struct annotated_data_type *adt,
@@ -121,9 +149,7 @@ void annotated_data_type__tree_delete(struct rb_root *root);
 #else /* HAVE_DWARF_SUPPORT */
 
 static inline struct annotated_data_type *
-find_data_type(struct map_symbol *ms __maybe_unused, u64 ip __maybe_unused,
-	       struct annotated_op_loc *loc __maybe_unused,
-	       u64 addr __maybe_unused, const char *var_name __maybe_unused)
+find_data_type(struct data_loc_info *dloc __maybe_unused)
 {
 	return NULL;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index fe0074bb98f0..1cf55f903ee4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3744,9 +3744,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct annotated_op_loc *op_loc;
 	struct annotated_data_type *mem_type;
 	struct annotated_item_stat *istat;
-	u64 ip = he->ip, addr = 0;
-	const char *var_name = NULL;
-	int var_offset;
+	u64 ip = he->ip;
 	int i;
 
 	ann_data_stat.total++;
@@ -3794,51 +3792,53 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	}
 
 	for_each_insn_op_loc(&loc, i, op_loc) {
+		struct data_loc_info dloc = {
+			.ms = ms,
+			/* Recalculate IP for LOCK prefix or insn fusion */
+			.ip = ms->sym->start + dl->al.offset,
+			.op = op_loc,
+		};
+
 		if (!op_loc->mem_ref)
 			continue;
 
 		/* Recalculate IP because of LOCK prefix or insn fusion */
 		ip = ms->sym->start + dl->al.offset;
 
-		var_offset = op_loc->offset;
-
 		/* PC-relative addressing */
 		if (op_loc->reg1 == DWARF_REG_PC) {
 			struct addr_location al;
 			struct symbol *var;
 			u64 map_addr;
 
-			addr = annotate_calc_pcrel(ms, ip, op_loc->offset, dl);
+			dloc.var_addr = annotate_calc_pcrel(ms, ip, op_loc->offset, dl);
 			/* Kernel symbols might be relocated */
-			map_addr = addr + map__reloc(ms->map);
+			map_addr = dloc.var_addr + map__reloc(ms->map);
 
 			addr_location__init(&al);
 			var = thread__find_symbol_fb(he->thread, he->cpumode,
 						     map_addr, &al);
 			if (var) {
-				var_name = var->name;
+				dloc.var_name = var->name;
 				/* Calculate type offset from the start of variable */
-				var_offset = map_addr - map__unmap_ip(al.map, var->start);
+				dloc.type_offset = map_addr - map__unmap_ip(al.map, var->start);
 			}
 			addr_location__exit(&al);
 		}
 
-		mem_type = find_data_type(ms, ip, op_loc, addr, var_name);
+		mem_type = find_data_type(&dloc);
 		if (mem_type)
 			istat->good++;
 		else
 			istat->bad++;
 
-		if (mem_type && var_name)
-			op_loc->offset = var_offset;
-
 		if (symbol_conf.annotate_data_sample) {
 			annotated_data_type__update_samples(mem_type, evsel,
-							    op_loc->offset,
+							    dloc.type_offset,
 							    he->stat.nr_events,
 							    he->stat.period);
 		}
-		he->mem_type_off = op_loc->offset;
+		he->mem_type_off = dloc.type_offset;
 		return mem_type;
 	}
 
-- 
2.42.0.655.g421f12c284-goog

