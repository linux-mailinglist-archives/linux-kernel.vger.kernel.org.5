Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CEB7C6369
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376909AbjJLDvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376803AbjJLDvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:51:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20875BA;
        Wed, 11 Oct 2023 20:51:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9a1762b43so4585915ad.1;
        Wed, 11 Oct 2023 20:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082678; x=1697687478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njf9+BFlR0XFy6rQJ5ULpIMs5FEvIamhr8EAIYtLlEc=;
        b=gwYQjkFohXFsbXdbf1Zf8x4x5d+KwEv7/bxRXWBO8gPLiCUD0CxS2LRU6yO4K/9Owk
         6+gJ2ma5o0+s2FLlW+TOpyXzW2g9Gs2cdi20oSyhLwNGtgEiK1lgwiVg8CsTazjR+daR
         wVnAxbTSFSArFUXk++aJ3PHQX81XWg2PLR9h5S8wL0U4ph+pg/xyGzNbv05uc6oMFdjv
         A5sX0D7Lz9ZagcQSTM4CLc9jlMWY2EKv6cXqfMwAoHnF2KZH/4szD5qd2rAL7Dji4OFI
         8BidAkJafi7uooaKFP8Wbi60uTFwPGWhE7uRRsZ16kFIqU/cECREQhXmftXysuKhE/v7
         V4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082678; x=1697687478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=njf9+BFlR0XFy6rQJ5ULpIMs5FEvIamhr8EAIYtLlEc=;
        b=frQbvgj0agOXbInXx1GBmFux/DT5nTp1AeIhGpN4+la3jpXZlhvau9ldfCUxJyD41Q
         dbCedi0BgwXAqv/VoX5+Mi1Zx0ry/+MhwFK8kQGQcUGKf8u1yWWqGGWyfb9JrkYKYVCk
         k/xEsrwDO5HszLz1RKso9ja+qUVuihLJuTbdSPNmlgOKk4ZbZ+Qs31gOhf8jEc0c7B/N
         Q0zRgY33ruDE01q+vuXO6jPUggfs5gqZboXKygob/07tBUdzc6T1XUAJcsHoHP5B4n1y
         BwwkUHsuidw0BwzIj5Yg+3Vzi2boR0bw9IaN9t8fea2uXh5qJG0W/xRgZujpe35Fd1KY
         oLXg==
X-Gm-Message-State: AOJu0YxhmKvxIgtdISS5UAk8KgPfA0i19nYPYJ43Rfrlb0gd1aIqYNwL
        F0cJoAF3nSioAG+WDGia2ys=
X-Google-Smtp-Source: AGHT+IEFeYhSWOXUIpZzRiUuBOT7G3Jw7zns/6jfrMxORHATP7ab0I3DApTwhqXFu4WoAtei9FNIoQ==
X-Received: by 2002:a17:902:d4c2:b0:1c8:a68e:7ff with SMTP id o2-20020a170902d4c200b001c8a68e07ffmr13594550plg.60.1697082678415;
        Wed, 11 Oct 2023 20:51:18 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:18 -0700 (PDT)
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
Subject: [PATCH 03/48] perf tools: Add util/debuginfo.[ch] files
Date:   Wed, 11 Oct 2023 20:50:26 -0700
Message-ID: <20231012035111.676789-4-namhyung@kernel.org>
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

Split debuginfo data structure and related functions into a separate
file so that it can be used other than the probe-finder.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/Build          |   1 +
 tools/perf/util/debuginfo.c    | 205 +++++++++++++++++++++++++++++++++
 tools/perf/util/debuginfo.h    |  64 ++++++++++
 tools/perf/util/probe-finder.c | 193 +------------------------------
 tools/perf/util/probe-finder.h |  19 +--
 5 files changed, 272 insertions(+), 210 deletions(-)
 create mode 100644 tools/perf/util/debuginfo.c
 create mode 100644 tools/perf/util/debuginfo.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 0ea5a9d368d4..a82122516720 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -194,6 +194,7 @@ endif
 perf-$(CONFIG_DWARF) += probe-finder.o
 perf-$(CONFIG_DWARF) += dwarf-aux.o
 perf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-$(CONFIG_DWARF) += debuginfo.o
 
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
new file mode 100644
index 000000000000..19acf4775d35
--- /dev/null
+++ b/tools/perf/util/debuginfo.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DWARF debug information handling code.  Copied from probe-finder.c.
+ *
+ * Written by Masami Hiramatsu <mhiramat@redhat.com>
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/zalloc.h>
+
+#include "build-id.h"
+#include "dso.h"
+#include "debug.h"
+#include "debuginfo.h"
+#include "symbol.h"
+
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+#include <elfutils/debuginfod.h>
+#endif
+
+/* Dwarf FL wrappers */
+static char *debuginfo_path;	/* Currently dummy */
+
+static const Dwfl_Callbacks offline_callbacks = {
+	.find_debuginfo = dwfl_standard_find_debuginfo,
+	.debuginfo_path = &debuginfo_path,
+
+	.section_address = dwfl_offline_section_address,
+
+	/* We use this table for core files too.  */
+	.find_elf = dwfl_build_id_find_elf,
+};
+
+/* Get a Dwarf from offline image */
+static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
+					 const char *path)
+{
+	GElf_Addr dummy;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	dbg->dwfl = dwfl_begin(&offline_callbacks);
+	if (!dbg->dwfl)
+		goto error;
+
+	dwfl_report_begin(dbg->dwfl);
+	dbg->mod = dwfl_report_offline(dbg->dwfl, "", "", fd);
+	if (!dbg->mod)
+		goto error;
+
+	dbg->dbg = dwfl_module_getdwarf(dbg->mod, &dbg->bias);
+	if (!dbg->dbg)
+		goto error;
+
+	dwfl_module_build_id(dbg->mod, &dbg->build_id, &dummy);
+
+	dwfl_report_end(dbg->dwfl, NULL, NULL);
+
+	return 0;
+error:
+	if (dbg->dwfl)
+		dwfl_end(dbg->dwfl);
+	else
+		close(fd);
+	memset(dbg, 0, sizeof(*dbg));
+
+	return -ENOENT;
+}
+
+static struct debuginfo *__debuginfo__new(const char *path)
+{
+	struct debuginfo *dbg = zalloc(sizeof(*dbg));
+	if (!dbg)
+		return NULL;
+
+	if (debuginfo__init_offline_dwarf(dbg, path) < 0)
+		zfree(&dbg);
+	if (dbg)
+		pr_debug("Open Debuginfo file: %s\n", path);
+	return dbg;
+}
+
+enum dso_binary_type distro_dwarf_types[] = {
+	DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
+	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
+	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
+	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
+	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
+	DSO_BINARY_TYPE__NOT_FOUND,
+};
+
+struct debuginfo *debuginfo__new(const char *path)
+{
+	enum dso_binary_type *type;
+	char buf[PATH_MAX], nil = '\0';
+	struct dso *dso;
+	struct debuginfo *dinfo = NULL;
+	struct build_id bid;
+
+	/* Try to open distro debuginfo files */
+	dso = dso__new(path);
+	if (!dso)
+		goto out;
+
+	/* Set the build id for DSO_BINARY_TYPE__BUILDID_DEBUGINFO */
+	if (is_regular_file(path) && filename__read_build_id(path, &bid) > 0)
+		dso__set_build_id(dso, &bid);
+
+	for (type = distro_dwarf_types;
+	     !dinfo && *type != DSO_BINARY_TYPE__NOT_FOUND;
+	     type++) {
+		if (dso__read_binary_type_filename(dso, *type, &nil,
+						   buf, PATH_MAX) < 0)
+			continue;
+		dinfo = __debuginfo__new(buf);
+	}
+	dso__put(dso);
+
+out:
+	/* if failed to open all distro debuginfo, open given binary */
+	return dinfo ? : __debuginfo__new(path);
+}
+
+void debuginfo__delete(struct debuginfo *dbg)
+{
+	if (dbg) {
+		if (dbg->dwfl)
+			dwfl_end(dbg->dwfl);
+		free(dbg);
+	}
+}
+
+/* For the kernel module, we need a special code to get a DIE */
+int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
+				bool adjust_offset)
+{
+	int n, i;
+	Elf32_Word shndx;
+	Elf_Scn *scn;
+	Elf *elf;
+	GElf_Shdr mem, *shdr;
+	const char *p;
+
+	elf = dwfl_module_getelf(dbg->mod, &dbg->bias);
+	if (!elf)
+		return -EINVAL;
+
+	/* Get the number of relocations */
+	n = dwfl_module_relocations(dbg->mod);
+	if (n < 0)
+		return -ENOENT;
+	/* Search the relocation related .text section */
+	for (i = 0; i < n; i++) {
+		p = dwfl_module_relocation_info(dbg->mod, i, &shndx);
+		if (strcmp(p, ".text") == 0) {
+			/* OK, get the section header */
+			scn = elf_getscn(elf, shndx);
+			if (!scn)
+				return -ENOENT;
+			shdr = gelf_getshdr(scn, &mem);
+			if (!shdr)
+				return -ENOENT;
+			*offs = shdr->sh_addr;
+			if (adjust_offset)
+				*offs -= shdr->sh_offset;
+		}
+	}
+	return 0;
+}
+
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+int get_source_from_debuginfod(const char *raw_path,
+			       const char *sbuild_id, char **new_path)
+{
+	debuginfod_client *c = debuginfod_begin();
+	const char *p = raw_path;
+	int fd;
+
+	if (!c)
+		return -ENOMEM;
+
+	fd = debuginfod_find_source(c, (const unsigned char *)sbuild_id,
+				0, p, new_path);
+	pr_debug("Search %s from debuginfod -> %d\n", p, fd);
+	if (fd >= 0)
+		close(fd);
+	debuginfod_end(c);
+	if (fd < 0) {
+		pr_debug("Failed to find %s in debuginfod (%s)\n",
+			raw_path, sbuild_id);
+		return -ENOENT;
+	}
+	pr_debug("Got a source %s\n", *new_path);
+
+	return 0;
+}
+#endif /* HAVE_DEBUGINFOD_SUPPORT */
diff --git a/tools/perf/util/debuginfo.h b/tools/perf/util/debuginfo.h
new file mode 100644
index 000000000000..4d65b8c605fc
--- /dev/null
+++ b/tools/perf/util/debuginfo.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _PERF_DEBUGINFO_H
+#define _PERF_DEBUGINFO_H
+
+#include <errno.h>
+#include <linux/compiler.h>
+
+#ifdef HAVE_DWARF_SUPPORT
+
+#include "dwarf-aux.h"
+
+/* debug information structure */
+struct debuginfo {
+	Dwarf		*dbg;
+	Dwfl_Module	*mod;
+	Dwfl		*dwfl;
+	Dwarf_Addr	bias;
+	const unsigned char	*build_id;
+};
+
+/* This also tries to open distro debuginfo */
+struct debuginfo *debuginfo__new(const char *path);
+void debuginfo__delete(struct debuginfo *dbg);
+
+int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
+			       bool adjust_offset);
+
+#else /* HAVE_DWARF_SUPPORT */
+
+/* dummy debug information structure */
+struct debuginfo {
+};
+
+static inline struct debuginfo *debuginfo__new(const char *path __maybe_unused)
+{
+	return NULL;
+}
+
+static inline void debuginfo__delete(struct debuginfo *dbg __maybe_unused)
+{
+}
+
+static inline int debuginfo__get_text_offset(struct debuginfo *dbg __maybe_unused,
+					     Dwarf_Addr *offs __maybe_unused,
+					     bool adjust_offset __maybe_unused)
+{
+	return -EINVAL;
+}
+
+#endif /* HAVE_DWARF_SUPPORT */
+
+#ifdef HAVE_DEBUGINFOD_SUPPORT
+int get_source_from_debuginfod(const char *raw_path, const char *sbuild_id,
+			       char **new_path);
+#else /* HAVE_DEBUGINFOD_SUPPORT */
+static inline int get_source_from_debuginfod(const char *raw_path __maybe_unused,
+					     const char *sbuild_id __maybe_unused,
+					     char **new_path __maybe_unused)
+{
+	return -ENOTSUP;
+}
+#endif /* HAVE_DEBUGINFOD_SUPPORT */
+
+#endif /* _PERF_DEBUGINFO_H */
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index f171360b0ef4..8d3dd85f9ff4 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -23,6 +23,7 @@
 #include "event.h"
 #include "dso.h"
 #include "debug.h"
+#include "debuginfo.h"
 #include "intlist.h"
 #include "strbuf.h"
 #include "strlist.h"
@@ -31,128 +32,9 @@
 #include "probe-file.h"
 #include "string2.h"
 
-#ifdef HAVE_DEBUGINFOD_SUPPORT
-#include <elfutils/debuginfod.h>
-#endif
-
 /* Kprobe tracer basic type is up to u64 */
 #define MAX_BASIC_TYPE_BITS	64
 
-/* Dwarf FL wrappers */
-static char *debuginfo_path;	/* Currently dummy */
-
-static const Dwfl_Callbacks offline_callbacks = {
-	.find_debuginfo = dwfl_standard_find_debuginfo,
-	.debuginfo_path = &debuginfo_path,
-
-	.section_address = dwfl_offline_section_address,
-
-	/* We use this table for core files too.  */
-	.find_elf = dwfl_build_id_find_elf,
-};
-
-/* Get a Dwarf from offline image */
-static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
-					 const char *path)
-{
-	GElf_Addr dummy;
-	int fd;
-
-	fd = open(path, O_RDONLY);
-	if (fd < 0)
-		return fd;
-
-	dbg->dwfl = dwfl_begin(&offline_callbacks);
-	if (!dbg->dwfl)
-		goto error;
-
-	dwfl_report_begin(dbg->dwfl);
-	dbg->mod = dwfl_report_offline(dbg->dwfl, "", "", fd);
-	if (!dbg->mod)
-		goto error;
-
-	dbg->dbg = dwfl_module_getdwarf(dbg->mod, &dbg->bias);
-	if (!dbg->dbg)
-		goto error;
-
-	dwfl_module_build_id(dbg->mod, &dbg->build_id, &dummy);
-
-	dwfl_report_end(dbg->dwfl, NULL, NULL);
-
-	return 0;
-error:
-	if (dbg->dwfl)
-		dwfl_end(dbg->dwfl);
-	else
-		close(fd);
-	memset(dbg, 0, sizeof(*dbg));
-
-	return -ENOENT;
-}
-
-static struct debuginfo *__debuginfo__new(const char *path)
-{
-	struct debuginfo *dbg = zalloc(sizeof(*dbg));
-	if (!dbg)
-		return NULL;
-
-	if (debuginfo__init_offline_dwarf(dbg, path) < 0)
-		zfree(&dbg);
-	if (dbg)
-		pr_debug("Open Debuginfo file: %s\n", path);
-	return dbg;
-}
-
-enum dso_binary_type distro_dwarf_types[] = {
-	DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
-	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
-	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
-	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
-	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
-	DSO_BINARY_TYPE__NOT_FOUND,
-};
-
-struct debuginfo *debuginfo__new(const char *path)
-{
-	enum dso_binary_type *type;
-	char buf[PATH_MAX], nil = '\0';
-	struct dso *dso;
-	struct debuginfo *dinfo = NULL;
-	struct build_id bid;
-
-	/* Try to open distro debuginfo files */
-	dso = dso__new(path);
-	if (!dso)
-		goto out;
-
-	/* Set the build id for DSO_BINARY_TYPE__BUILDID_DEBUGINFO */
-	if (is_regular_file(path) && filename__read_build_id(path, &bid) > 0)
-		dso__set_build_id(dso, &bid);
-
-	for (type = distro_dwarf_types;
-	     !dinfo && *type != DSO_BINARY_TYPE__NOT_FOUND;
-	     type++) {
-		if (dso__read_binary_type_filename(dso, *type, &nil,
-						   buf, PATH_MAX) < 0)
-			continue;
-		dinfo = __debuginfo__new(buf);
-	}
-	dso__put(dso);
-
-out:
-	/* if failed to open all distro debuginfo, open given binary */
-	return dinfo ? : __debuginfo__new(path);
-}
-
-void debuginfo__delete(struct debuginfo *dbg)
-{
-	if (dbg) {
-		if (dbg->dwfl)
-			dwfl_end(dbg->dwfl);
-		free(dbg);
-	}
-}
-
 /*
  * Probe finder related functions
  */
@@ -1677,44 +1559,6 @@ int debuginfo__find_available_vars_at(struct debuginfo *dbg,
 	return (ret < 0) ? ret : af.nvls;
 }
 
-/* For the kernel module, we need a special code to get a DIE */
-int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
-				bool adjust_offset)
-{
-	int n, i;
-	Elf32_Word shndx;
-	Elf_Scn *scn;
-	Elf *elf;
-	GElf_Shdr mem, *shdr;
-	const char *p;
-
-	elf = dwfl_module_getelf(dbg->mod, &dbg->bias);
-	if (!elf)
-		return -EINVAL;
-
-	/* Get the number of relocations */
-	n = dwfl_module_relocations(dbg->mod);
-	if (n < 0)
-		return -ENOENT;
-	/* Search the relocation related .text section */
-	for (i = 0; i < n; i++) {
-		p = dwfl_module_relocation_info(dbg->mod, i, &shndx);
-		if (strcmp(p, ".text") == 0) {
-			/* OK, get the section header */
-			scn = elf_getscn(elf, shndx);
-			if (!scn)
-				return -ENOENT;
-			shdr = gelf_getshdr(scn, &mem);
-			if (!shdr)
-				return -ENOENT;
-			*offs = shdr->sh_addr;
-			if (adjust_offset)
-				*offs -= shdr->sh_offset;
-		}
-	}
-	return 0;
-}
-
 /* Reverse search */
 int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
 				struct perf_probe_point *ppt)
@@ -2009,41 +1853,6 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
 	return (ret < 0) ? ret : lf.found;
 }
 
-#ifdef HAVE_DEBUGINFOD_SUPPORT
-/* debuginfod doesn't require the comp_dir but buildid is required */
-static int get_source_from_debuginfod(const char *raw_path,
-				const char *sbuild_id, char **new_path)
-{
-	debuginfod_client *c = debuginfod_begin();
-	const char *p = raw_path;
-	int fd;
-
-	if (!c)
-		return -ENOMEM;
-
-	fd = debuginfod_find_source(c, (const unsigned char *)sbuild_id,
-				0, p, new_path);
-	pr_debug("Search %s from debuginfod -> %d\n", p, fd);
-	if (fd >= 0)
-		close(fd);
-	debuginfod_end(c);
-	if (fd < 0) {
-		pr_debug("Failed to find %s in debuginfod (%s)\n",
-			raw_path, sbuild_id);
-		return -ENOENT;
-	}
-	pr_debug("Got a source %s\n", *new_path);
-
-	return 0;
-}
-#else
-static inline int get_source_from_debuginfod(const char *raw_path __maybe_unused,
-				const char *sbuild_id __maybe_unused,
-				char **new_path __maybe_unused)
-{
-	return -ENOTSUP;
-}
-#endif
 /*
  * Find a src file from a DWARF tag path. Prepend optional source path prefix
  * and chop off leading directories that do not exist. Result is passed back as
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index 8bc1c80d3c1c..3add5ff516e1 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -24,21 +24,7 @@ static inline int is_c_varname(const char *name)
 #ifdef HAVE_DWARF_SUPPORT
 
 #include "dwarf-aux.h"
-
-/* TODO: export debuginfo data structure even if no dwarf support */
-
-/* debug information structure */
-struct debuginfo {
-	Dwarf		*dbg;
-	Dwfl_Module	*mod;
-	Dwfl		*dwfl;
-	Dwarf_Addr	bias;
-	const unsigned char	*build_id;
-};
-
-/* This also tries to open distro debuginfo */
-struct debuginfo *debuginfo__new(const char *path);
-void debuginfo__delete(struct debuginfo *dbg);
+#include "debuginfo.h"
 
 /* Find probe_trace_events specified by perf_probe_event from debuginfo */
 int debuginfo__find_trace_events(struct debuginfo *dbg,
@@ -49,9 +35,6 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
 int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
 				struct perf_probe_point *ppt);
 
-int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
-			       bool adjust_offset);
-
 /* Find a line range */
 int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr);
 
-- 
2.42.0.655.g421f12c284-goog

