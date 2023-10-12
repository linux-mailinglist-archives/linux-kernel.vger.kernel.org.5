Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E597C6375
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377208AbjJLDww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377188AbjJLDwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:52:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54BD12C;
        Wed, 11 Oct 2023 20:51:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so465775b3a.0;
        Wed, 11 Oct 2023 20:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082694; x=1697687494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Mm0EFKSyzZeq7wlW+V5DIgnESjW48EHe3H1udzSRfI=;
        b=jTXr5cEDneyU68rbb5CNcqO+exc4TsJZFY/p/3whJSNmvknj3+pHapCkOkA/OHYoGD
         0xkbfyL29BVtoHIYmLHVkLxGas44IQwOO73o0gy+jYa+ebPO5z9Uqo8gzgXO1BFyOPtk
         1Iw6b8Fh/NUG33XVkc0qzdzcfrVBM9SK0wqd5mSIA50EcarvHs3qQGvZE+/EgcIMQvzn
         WlVtAufXGDMn5jTwIpbHUoAyzjbKojcgVhMG3emX1akdIKD6F8Wikldx3Rwe9Ww7NJzz
         Vmos4ZY+0oPDXwZhAk+0s777poBZL2z2z4AmNsrlemL+iO0yV9438gp4bND7dYMdvFG/
         EPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082694; x=1697687494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Mm0EFKSyzZeq7wlW+V5DIgnESjW48EHe3H1udzSRfI=;
        b=NO1Q7RqMWTh9Qy7DTMgaVDJnbDK+nkkVRR6VZKrntLStPyBkujyIjKLkxh9RMFeHPF
         /gkIFENsT28EOirtf+zwDTH+Eluxw8rsJ8SVj3/vREkrJ9cP5Fbx7flM2KL6nbNmJohM
         UDA/SVpEp39kAY0DOjtowDcLl18c4sCE4XW448M468n4nBOw/tIn5VZETQA6VSBzqEda
         mQhD0ieL4tH6y3GYvCrNBCRvt7TIldM8zhlSbti8nv9QTOOdO6M8PEFnDrOWVcBeB+X8
         8u6bL+5+pljyhVQm7Ae3RZHzLfUsDG53BGvzWlGJ4cG1UfxFbjBrxyovqPrY/NXL0zeZ
         WXZw==
X-Gm-Message-State: AOJu0YylcV8x9GCXGKki5jUrwoWvRvs7oZP71ST6MBegvVVfhq+PfAMF
        gmGXKYdY1JFAxKrtNZc4//g=
X-Google-Smtp-Source: AGHT+IFcT2BsO5as9+E/OMNGu003MjUidyOdjBLI4kMSG8Rqcj5UofTcT31NaKmciu8TxK3TKE2I+w==
X-Received: by 2002:a05:6a21:a5a3:b0:15b:c800:48af with SMTP id gd35-20020a056a21a5a300b0015bc80048afmr26689958pzc.23.1697082694569;
        Wed, 11 Oct 2023 20:51:34 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:34 -0700 (PDT)
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
Subject: [PATCH 15/48] perf report: Add 'type' sort key
Date:   Wed, 11 Oct 2023 20:50:38 -0700
Message-ID: <20231012035111.676789-16-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'type' sort key is to aggregate hist entries by data type they
access.  Add mem_type field to hist_entry struct to save the type.
If hist_entry__get_data_type() returns NULL, it'd use the
'unknown_type' instance.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/util/annotate-data.c          |  5 ++
 tools/perf/util/annotate-data.h          |  2 +
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 65 +++++++++++++++++++++++-
 tools/perf/util/sort.h                   |  4 ++
 6 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index af068b4f1e5a..aec34417090b 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -118,6 +118,7 @@ OPTIONS
 	- retire_lat: On X86, this reports pipeline stall of this instruction compared
 	  to the previous instruction in cycles. And currently supported only on X86
 	- simd: Flags describing a SIMD operation. "e" for empty Arm SVE predicate. "p" for partial Arm SVE predicate
+	- type: Data type of sample memory access.
 
 	By default, comm, dso and symbol keys are used.
 	(i.e. --sort comm,dso,symbol)
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 23381c0a5d38..3e3a561d73e3 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -17,6 +17,11 @@
 #include "strbuf.h"
 #include "symbol.h"
 
+/* Pseudo data types */
+struct annotated_data_type unknown_type = {
+	.type_name = (char *)"(unknown)",
+};
+
 /*
  * Compare type name and size to maintain them in a tree.
  * I'm not sure if DWARF would have information of a single type in many
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index ab9f187bd7f1..6efdd7e21b28 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -22,6 +22,8 @@ struct annotated_data_type {
 	int type_size;
 };
 
+extern struct annotated_data_type unknown_type;
+
 #ifdef HAVE_DWARF_SUPPORT
 
 /* Returns data type at the location (ip, reg, offset) */
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index afc9f1c7f4dc..9bfed867f288 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -82,6 +82,7 @@ enum hist_column {
 	HISTC_ADDR_TO,
 	HISTC_ADDR,
 	HISTC_SIMD,
+	HISTC_TYPE,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 6aa1c7f2b444..c79564c1d5df 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -24,6 +24,7 @@
 #include "strbuf.h"
 #include "mem-events.h"
 #include "annotate.h"
+#include "annotate-data.h"
 #include "event.h"
 #include "time-utils.h"
 #include "cgroup.h"
@@ -2094,7 +2095,7 @@ struct sort_entry sort_dso_size = {
 	.se_width_idx	= HISTC_DSO_SIZE,
 };
 
-/* --sort dso_size */
+/* --sort addr */
 
 static int64_t
 sort__addr_cmp(struct hist_entry *left, struct hist_entry *right)
@@ -2131,6 +2132,65 @@ struct sort_entry sort_addr = {
 	.se_width_idx	= HISTC_ADDR,
 };
 
+/* --sort type */
+
+static int64_t
+sort__type_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return sort__addr_cmp(left, right);
+}
+
+static void sort__type_init(struct hist_entry *he)
+{
+	if (he->mem_type)
+		return;
+
+	he->mem_type = hist_entry__get_data_type(he);
+	if (he->mem_type == NULL)
+		he->mem_type = &unknown_type;
+}
+
+static int64_t
+sort__type_collapse(struct hist_entry *left, struct hist_entry *right)
+{
+	struct annotated_data_type *left_type = left->mem_type;
+	struct annotated_data_type *right_type = right->mem_type;
+
+	if (!left_type) {
+		sort__type_init(left);
+		left_type = left->mem_type;
+	}
+
+	if (!right_type) {
+		sort__type_init(right);
+		right_type = right->mem_type;
+	}
+
+	return strcmp(left_type->type_name, right_type->type_name);
+}
+
+static int64_t
+sort__type_sort(struct hist_entry *left, struct hist_entry *right)
+{
+	return sort__type_collapse(left, right);
+}
+
+static int hist_entry__type_snprintf(struct hist_entry *he, char *bf,
+				     size_t size, unsigned int width)
+{
+	return repsep_snprintf(bf, size, "%-*s", width, he->mem_type->type_name);
+}
+
+struct sort_entry sort_type = {
+	.se_header	= "Data Type",
+	.se_cmp		= sort__type_cmp,
+	.se_collapse	= sort__type_collapse,
+	.se_sort	= sort__type_sort,
+	.se_init	= sort__type_init,
+	.se_snprintf	= hist_entry__type_snprintf,
+	.se_width_idx	= HISTC_TYPE,
+};
+
 
 struct sort_dimension {
 	const char		*name;
@@ -2185,7 +2245,8 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_ADDR, "addr", sort_addr),
 	DIM(SORT_LOCAL_RETIRE_LAT, "local_retire_lat", sort_local_p_stage_cyc),
 	DIM(SORT_GLOBAL_RETIRE_LAT, "retire_lat", sort_global_p_stage_cyc),
-	DIM(SORT_SIMD, "simd", sort_simd)
+	DIM(SORT_SIMD, "simd", sort_simd),
+	DIM(SORT_ANNOTATE_DATA_TYPE, "type", sort_type),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index ecfb7f1359d5..aabf0b8331a3 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -15,6 +15,7 @@
 
 struct option;
 struct thread;
+struct annotated_data_type;
 
 extern regex_t parent_regex;
 extern const char *sort_order;
@@ -34,6 +35,7 @@ extern struct sort_entry sort_dso_to;
 extern struct sort_entry sort_sym_from;
 extern struct sort_entry sort_sym_to;
 extern struct sort_entry sort_srcline;
+extern struct sort_entry sort_type;
 extern const char default_mem_sort_order[];
 extern bool chk_double_cl;
 
@@ -154,6 +156,7 @@ struct hist_entry {
 	struct perf_hpp_list	*hpp_list;
 	struct hist_entry	*parent_he;
 	struct hist_entry_ops	*ops;
+	struct annotated_data_type *mem_type;
 	union {
 		/* this is for hierarchical entry structure */
 		struct {
@@ -243,6 +246,7 @@ enum sort_type {
 	SORT_LOCAL_RETIRE_LAT,
 	SORT_GLOBAL_RETIRE_LAT,
 	SORT_SIMD,
+	SORT_ANNOTATE_DATA_TYPE,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.42.0.655.g421f12c284-goog

