Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E0D7C6370
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377096AbjJLDwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376855AbjJLDvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:51:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2C4E4;
        Wed, 11 Oct 2023 20:51:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9bca1d96cso4681665ad.3;
        Wed, 11 Oct 2023 20:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082688; x=1697687488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joIOSqpc9II33WD29wSpcJoIAVdTr/6RN8dGhdgNwvk=;
        b=chVFrLV1NWa2YvdYOoeVJ9VIF93RWLbhNFpxJBrsajGV2Bmekp1GNIWWoMD8JmINyk
         GDQsgWHV+E0wsqEABTpkzYt8Ol4we1tOGYCKp1gejphlSusMeeHlGegLrxB0VkBMLnwv
         Pksx3TKNywlc+BDTfq95dvNah0ILtKDYB14OkAIEGGpKDuPNkHhcWxnIsz2MQHlS3d4f
         QyMV8hmFMScD8cZ30Ki9TuRrtR0wKS2fgw41r3mrK/rw9SmC1ct5vPbhD2ox6WLIWDbW
         +kvu7AkwTdlfZ2mHQgvDexVPSJ9twoI6AvTGKYaXLTMzg66yclyixM/HPL2d0/6NAZcT
         4jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082688; x=1697687488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=joIOSqpc9II33WD29wSpcJoIAVdTr/6RN8dGhdgNwvk=;
        b=cDvYHcCrzu0CYTW9p+1Gst/q1a/iI2e3rc0lMxse5+f4+w2yz1GCF4Eq2qyL7Eh/op
         juOYN7bFWUPD29mwyz4u1OPGRwht+VVe2dDqiEPljzskPBsWS2Tu3aXqhwSPLVKZ4Cre
         uSpU82UWAK+rgV/4sD0D5hBlx/ghsI/vKsSRNY5u6FoxViYShSjlBFLrrKt4wrY6ifod
         /OUu7XtR+hlpoY/Af4BoHGG+odIFJR5q+y3Vdjd4vONS9tZ2yt85gu+6llTqZGBUEY73
         LA+vtUPxyaJrXGaSN0AHYiNCJT6ynTMzidPYsBbhFlE7IwNMrAQbMNrul8rqoDqx+4eN
         lSTA==
X-Gm-Message-State: AOJu0YxeI/dBvuz6fEiKVNCzqg/XZs4elQFx3I8/IuYNF4kcO6sVNULG
        nfUBbBcZT89ZeayV/DxgnqE=
X-Google-Smtp-Source: AGHT+IHalb1WJG4zXzhKmnak0iddX0Bstj3qdul4VTCIEj8EVCZxS4aVV6iIU+VyMBzv6NqBeSPmWQ==
X-Received: by 2002:a17:903:4307:b0:1c9:dbd3:94f7 with SMTP id jz7-20020a170903430700b001c9dbd394f7mr1326213plb.65.1697082687898;
        Wed, 11 Oct 2023 20:51:27 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:27 -0700 (PDT)
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
Subject: [PATCH 10/48] perf annotate-data: Add find_data_type()
Date:   Wed, 11 Oct 2023 20:50:33 -0700
Message-ID: <20231012035111.676789-11-namhyung@kernel.org>
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

The find_data_type() is to get a data type from the memory access at the
given address (IP) using a register and an offset.  It requires DWARF
debug info in the DSO and searches the list of variables and function
parameters in the scope.

In a pseudo code, it does basically the following:

  find_data_type(dso, ip, reg, offset)
  {
      pc = map__rip_2objdump(ip);
      CU = dwarf_addrdie(dso->dwarf, pc);
      scopes = die_get_scopes(CU, pc);
      for_each_scope(S, scopes) {
          V = die_find_variable_by_reg(S, pc, reg);
          if (V && V.type == pointer_type) {
              T = die_get_real_type(V);
              if (offset < T.size)
                  return T;
          }
      }
      return NULL;
  }

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/Build           |   1 +
 tools/perf/util/annotate-data.c | 163 ++++++++++++++++++++++++++++++++
 tools/perf/util/annotate-data.h |  40 ++++++++
 3 files changed, 204 insertions(+)
 create mode 100644 tools/perf/util/annotate-data.c
 create mode 100644 tools/perf/util/annotate-data.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index a82122516720..cdc8a850859c 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -195,6 +195,7 @@ perf-$(CONFIG_DWARF) += probe-finder.o
 perf-$(CONFIG_DWARF) += dwarf-aux.o
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_DWARF) += debuginfo.o
+perf-$(CONFIG_DWARF) += annotate-data.o
 
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
new file mode 100644
index 000000000000..b3d519b7514b
--- /dev/null
+++ b/tools/perf/util/annotate-data.c
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Convert sample address to data type using DWARF debug info.
+ *
+ * Written by Namhyung Kim <namhyung@kernel.org>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "annotate-data.h"
+#include "debuginfo.h"
+#include "debug.h"
+#include "dso.h"
+#include "map.h"
+#include "map_symbol.h"
+#include "strbuf.h"
+#include "symbol.h"
+
+static bool find_cu_die(struct debuginfo *di, u64 pc, Dwarf_Die *cu_die)
+{
+	Dwarf_Off off, next_off;
+	size_t header_size;
+
+	if (dwarf_addrdie(di->dbg, pc, cu_die) != NULL)
+		return cu_die;
+
+	/*
+	 * There are some kernels don't have full aranges and contain only a few
+	 * aranges entries.  Fallback to iterate all CU entries in .debug_info
+	 * in case it's missing.
+	 */
+	off = 0;
+	while (dwarf_nextcu(di->dbg, off, &next_off, &header_size,
+			    NULL, NULL, NULL) == 0) {
+		if (dwarf_offdie(di->dbg, off + header_size, cu_die) &&
+		    dwarf_haspc(cu_die, pc))
+			return true;
+
+		off = next_off;
+	}
+	return false;
+}
+
+/* The type info will be saved in @type_die */
+static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
+{
+	Dwarf_Word size;
+
+	/* Get the type of the variable */
+	if (die_get_real_type(var_die, type_die) == NULL) {
+		pr_debug("variable has no type\n");
+		return -1;
+	}
+
+	/*
+	 * It expects a pointer type for a memory access.
+	 * Convert to a real type it points to.
+	 */
+	if (dwarf_tag(type_die) != DW_TAG_pointer_type ||
+	    die_get_real_type(type_die, type_die) == NULL) {
+		pr_debug("no pointer or no type\n");
+		return -1;
+	}
+
+	/* Get the size of the actual type */
+	if (dwarf_aggregate_size(type_die, &size) < 0) {
+		pr_debug("type size is unknown\n");
+		return -1;
+	}
+
+	/* Minimal sanity check */
+	if ((unsigned)offset >= size) {
+		pr_debug("offset: %d is bigger than size: %lu\n", offset, size);
+		return -1;
+	}
+
+	return 0;
+}
+
+/* The result will be saved in @type_die */
+static int find_data_type_die(struct debuginfo *di, u64 pc,
+			      int reg, int offset, Dwarf_Die *type_die)
+{
+	Dwarf_Die cu_die, var_die;
+	Dwarf_Die *scopes = NULL;
+	int ret = -1;
+	int i, nr_scopes;
+
+	/* Get a compile_unit for this address */
+	if (!find_cu_die(di, pc, &cu_die)) {
+		pr_debug("cannot find CU for address %lx\n", pc);
+		return -1;
+	}
+
+	/* Get a list of nested scopes - i.e. (inlined) functions and blocks. */
+	nr_scopes = die_get_scopes(&cu_die, pc, &scopes);
+
+	/* Search from the inner-most scope to the outer */
+	for (i = nr_scopes - 1; i >= 0; i--) {
+		/* Look up variables/parameters in this scope */
+		if (!die_find_variable_by_reg(&scopes[i], pc, reg, &var_die))
+			continue;
+
+		/* Found a variable, see if it's correct */
+		ret = check_variable(&var_die, type_die, offset);
+		break;
+	}
+
+	free(scopes);
+	return ret;
+}
+
+/**
+ * find_data_type - Return a data type at the location
+ * @ms: map and symbol at the location
+ * @ip: instruction address of the memory access
+ * @reg: register that holds the base address
+ * @offset: offset from the base address
+ *
+ * This functions searches the debug information of the binary to get the data
+ * type it accesses.  The exact location is expressed by (ip, reg, offset).
+ * It return %NULL if not found.
+ */
+struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
+					   int reg, int offset)
+{
+	struct annotated_data_type *result = NULL;
+	struct dso *dso = ms->map->dso;
+	struct debuginfo *di;
+	Dwarf_Die type_die;
+	struct strbuf sb;
+	u64 pc;
+
+	di = debuginfo__new(dso->long_name);
+	if (di == NULL) {
+		pr_debug("cannot get the debug info\n");
+		return NULL;
+	}
+
+	/*
+	 * IP is a relative instruction address from the start of the map, as
+	 * it can be randomized/relocated, it needs to translate to PC which is
+	 * a file address for DWARF processing.
+	 */
+	pc = map__rip_2objdump(ms->map, ip);
+	if (find_data_type_die(di, pc, reg, offset, &type_die) < 0)
+		goto out;
+
+	result = zalloc(sizeof(*result));
+	if (result == NULL)
+		goto out;
+
+	strbuf_init(&sb, 32);
+	if (__die_get_typename(&type_die, &sb) < 0)
+		strbuf_add(&sb, "(unknown type)", 14);
+
+	result->type_name = strbuf_detach(&sb, NULL);
+
+out:
+	debuginfo__delete(di);
+	return result;
+}
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
new file mode 100644
index 000000000000..633147f78ca5
--- /dev/null
+++ b/tools/perf/util/annotate-data.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _PERF_ANNOTATE_DATA_H
+#define _PERF_ANNOTATE_DATA_H
+
+#include <errno.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+struct map_symbol;
+
+/**
+ * struct annotated_data_type - Data type to profile
+ * @type_name: Name of the data type
+ * @type_size: Size of the data type
+ *
+ * This represents a data type accessed by samples in the profile data.
+ */
+struct annotated_data_type {
+	char *type_name;
+	int type_size;
+};
+
+#ifdef HAVE_DWARF_SUPPORT
+
+/* Returns data type at the location (ip, reg, offset) */
+struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
+					   int reg, int offset);
+
+#else /* HAVE_DWARF_SUPPORT */
+
+static inline struct annotated_data_type *
+find_data_type(struct map_symbol *ms __maybe_unused, u64 ip __maybe_unused,
+	       int reg __maybe_unused, int offset __maybe_unused)
+{
+	return NULL;
+}
+
+#endif /* HAVE_DWARF_SUPPORT */
+
+#endif /* _PERF_ANNOTATE_DATA_H */
-- 
2.42.0.655.g421f12c284-goog

