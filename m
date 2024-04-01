Return-Path: <linux-kernel+bounces-126844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B2B893ED2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2381F21897
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC771CA8F;
	Mon,  1 Apr 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwJkdrvc"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC87947A5D;
	Mon,  1 Apr 2024 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987704; cv=none; b=dH5y/El147Ff4ZZLj9WU+U2QCLF0zeD4G2260ukxvBGBOU3TMtcHthv179aaw/vwmacFP1aTj73zIo9/ooYXhsMOUa0PjS/i7HzmioCyRQgxazq3k6YksKIYDBVzFuSv1qR7YyvGpCHWUd+t5PZsPxJHGKPWoJAtEFx4q6n+27U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987704; c=relaxed/simple;
	bh=9bITHKZ5rO+1vTGvp2y8QmNzKURvjczM+SpfxLPcY04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbD3+deRm2ol4LGKkO/12b9Sze6WQ6e2RibK+i/RiBHGxadM5yaxWg9lyNyQD0TZ0OASZG6NUoCrBSzgnp33Xxr+W5k1I1stP8etAs4Za/UlB70hPOdoJ5BvGoUt3TE2Eu/peGzNWNl3XbDO3Z6CQ5ApvFOAVBbv9JManyzprLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwJkdrvc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso2793745a12.3;
        Mon, 01 Apr 2024 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711987702; x=1712592502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5kTVCa0PGqApTZDHgKJ/qHVy7JMqS/3uydjX9OHDJj4=;
        b=iwJkdrvcqfnF1ConhAmI2zfmw2ksZLe+HSDYdnqo1ttHibuJcD4GLTjeMtMFi3l/U3
         5Dum/b8hYZ8SW2+i3NvV1qsZkocy2LIl6SSyrnpIA4queMtAjL4/01XYyg1GmVAFnzOX
         l57h7XGt7dd3VIB6acubDZ+shBFVkPJwVLz5MDexW/zu16FtqMAW4MipzeTLGLb1xIrl
         y/KgjCU6UdqkUDzsjtazZ8bPAHiUAIIs/ZmBKukjXdVk3D6tTWKZlRGyFwbOZKeRA+Ta
         XG0tfDp1Bu/hEA1XFEDzh7fXc/zZGkBn0L3u4JneYqoL4zh0kQ0zACz8FhuWdU48P8OT
         EB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711987702; x=1712592502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kTVCa0PGqApTZDHgKJ/qHVy7JMqS/3uydjX9OHDJj4=;
        b=MPL4fQT4mjwvpUe7+1MhX3+0syowr9D6VX99jQs99Tt+c5t2imc0HAepnCHSCLhTCD
         SLw3UXmeP76KGTKJ0LuZeHEf+EfeSkb9Fa8PYSMw1VsYHPxkh05gXJMOfP9ZmHCC5wOl
         jhSb/F7rMSABreSLO+pVCD18zdBP/nD60YTby050K0kM3RQnP1uQVWnXsWvUi5MtEZzp
         CIUr+Xv1a8yZSuvlqtZHVuR078DOUcvNVleFKZNGevCn7vepwS1vDBIWF5koFGQB4mbD
         YpbFvz7hgGOhDU4WuMQvsAA66BYv3QB1NMR8JzxLHAK00/TMbp+gbEjjHXi9lroCo2WZ
         cS0g==
X-Forwarded-Encrypted: i=1; AJvYcCWz/f/MoUY5fOm0jnTrkx8jDqQ9uBoLSlgFkaYhZ2zZFzdTqSLUIhyxqjth6jIL7pa1/eOyWem7grBaJOELBhRRLD8ScvFcK28u4lO3
X-Gm-Message-State: AOJu0Yx8LxVUeSVHNf7EaKRgglEanhGUJQguiGNJmh316yydt4nj3UY9
	wDJsBqgq8pvnRPgA81Wz7fWPXmzYHO4aVarZqHFm1/9T9vZvKFLW
X-Google-Smtp-Source: AGHT+IGm3n+Mqa4BLC3iAKPWt10ze4VMKaXtAR7PZV3YAWTIuLaSuAgIgaToGDRoBs/wJhNKC4ohEg==
X-Received: by 2002:a17:90a:db58:b0:29f:6a6f:c42 with SMTP id u24-20020a17090adb5800b0029f6a6f0c42mr7225599pjx.13.1711987702160;
        Mon, 01 Apr 2024 09:08:22 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090ac28b00b002a058af5e12sm10132244pjt.12.2024.04.01.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 09:08:21 -0700 (PDT)
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf srcline: Implement addr2line using libdw
Date: Mon,  1 Apr 2024 13:08:03 -0300
Message-ID: <20240401160805.51277-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`perf script` can be quite slow when inlines are enabled, by default it
spawns an `addr2line` process and communicates with it via pipes, that
comes with a certain overhead. The other option is to build perf with
libbfd enabled so that its methods are called directly instead, but due
to its licensing the resulting binary cannot be redistribuited.

This commit adds the ability for perf to use libdw to query the source
lines of binaries from the passed addresses. This avoids the process
spawn overhead and because libdw is licensed dually under
GPL-2.0-or-later and LGPL-3.0-or-later it can be distributed by
downstream packagers. Another thing to consider is that if libdebuginfod
was enabled for libdw then it's used to download debug info, it can be
switched off by unsetting the `DEBUGINFOD_URLS` envvar.

Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
---
 tools/perf/Makefile.config |   7 +-
 tools/perf/util/srcline.c  | 277 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 281 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1fe8df97fe88..ab6d41e7a6b6 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -947,13 +947,16 @@ ifdef BUILD_NONDISTRO
     $(call feature_check,disassembler-init-styled)
   endif
 
-  CFLAGS += -DHAVE_LIBBFD_SUPPORT
-  CXXFLAGS += -DHAVE_LIBBFD_SUPPORT
+  CFLAGS += -DHAVE_LIBBFD_SUPPORT -DHAVE_SYMBOLIZER_SUPPORT
+  CXXFLAGS += -DHAVE_LIBBFD_SUPPORT -DHAVE_SYMBOLIZER_SUPPORT
   ifeq ($(feature-libbfd-buildid), 1)
     CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
   else
     $(warning Old version of libbfd/binutils things like PE executable profiling will not be available)
   endif
+else ifndef NO_LIBDW_DWARF_UNWIND
+  CFLAGS += -DHAVE_SYMBOLIZER_SUPPORT
+  CXXFLAGS += -DHAVE_SYMBOLIZER_SUPPORT
 endif
 
 ifndef NO_DEMANGLE
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 7addc34afcf5..8117424137cc 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -130,6 +130,8 @@ static struct symbol *new_inline_sym(struct dso *dso,
 
 #define MAX_INLINE_NEST 1024
 
+#ifdef HAVE_SYMBOLIZER_SUPPORT
+
 #ifdef HAVE_LIBBFD_SUPPORT
 
 /*
@@ -372,6 +374,279 @@ void dso__free_a2l(struct dso *dso)
 
 #else /* HAVE_LIBBFD_SUPPORT */
 
+#include <elfutils/libdwfl.h>
+#include <dwarf.h>
+
+static char *debuginfo_path = NULL;
+
+static const Dwfl_Callbacks offline_callbacks = {
+	/* We use this table for core files too.  */
+	.find_elf = dwfl_build_id_find_elf,
+	.find_debuginfo = dwfl_standard_find_debuginfo,
+	.section_address = dwfl_offline_section_address,
+	.debuginfo_path = &debuginfo_path,
+
+};
+
+struct a2l_data {
+	const char *input;
+	Dwarf_Addr addr;
+	Dwarf_Addr bias;
+
+	bool found;
+	const char *filename;
+	const char *funcname;
+	int line;
+
+	Dwfl *dwfl;
+	Dwfl_Module *mod;
+	GElf_Sym **syms;
+};
+
+static const char *get_diename(Dwarf_Die *die)
+{
+	Dwarf_Attribute attr;
+	const char *name;
+
+	name = dwarf_formstring(
+		dwarf_attr_integrate(die, DW_AT_MIPS_linkage_name, &attr) ?:
+			dwarf_attr_integrate(die, DW_AT_linkage_name, &attr));
+
+	if (name == NULL)
+		name = dwarf_diename(die) ?: "??";
+
+	return name;
+}
+
+static void find_address_in_section(struct a2l_data *a2l)
+{
+	Dwarf_Addr addr;
+	Dwfl_Line *line;
+
+	if (a2l->found)
+		return;
+
+	a2l->mod = dwfl_addrmodule(a2l->dwfl, a2l->addr);
+	if (!a2l->mod)
+		return;
+
+	dwfl_module_getdwarf(a2l->mod, &a2l->bias);
+	addr = a2l->addr + a2l->bias;
+
+	line = dwfl_module_getsrc(a2l->mod, addr);
+	if (!line)
+		line = dwfl_getsrc(a2l->dwfl, addr);
+	if (!line)
+		return;
+
+	a2l->filename = dwfl_lineinfo(line, NULL, &a2l->line, NULL, NULL, NULL);
+	a2l->funcname = dwfl_module_addrname(a2l->mod, addr);
+
+	if (a2l->filename && !strlen(a2l->filename))
+		a2l->filename = NULL;
+	else
+		a2l->found = true;
+}
+
+static struct a2l_data *addr2line_init(const char *path)
+{
+	Dwfl *dwfl;
+	struct a2l_data *a2l = NULL;
+
+	dwfl = dwfl_begin(&offline_callbacks);
+	if (!dwfl)
+		goto out;
+
+	if (dwfl_report_offline(dwfl, "", path, -1) == NULL)
+		return NULL;
+
+	a2l = zalloc(sizeof(*a2l));
+	if (a2l == NULL)
+		goto out;
+
+	a2l->dwfl = dwfl;
+	a2l->input = strdup(path);
+	if (a2l->input == NULL)
+		goto out;
+
+	if (dwfl_report_end(dwfl, NULL, NULL))
+		goto out;
+
+	return a2l;
+
+out:
+	if (a2l) {
+		zfree((char **)&a2l->input);
+		free(a2l);
+	}
+	dwfl_end(dwfl);
+	return NULL;
+}
+
+static void addr2line_cleanup(struct a2l_data *a2l)
+{
+	if (a2l->dwfl)
+		dwfl_end(a2l->dwfl);
+	zfree((char **)&a2l->input);
+	zfree(&a2l->syms);
+	free(a2l);
+}
+
+static int inline_list__append_dso_a2l(struct dso *dso,
+				       struct inline_node *node,
+				       struct symbol *sym)
+{
+	struct a2l_data *a2l = dso->a2l;
+	struct symbol *inline_sym = new_inline_sym(dso, sym, a2l->funcname);
+	char *srcline = NULL;
+
+	if (a2l->filename)
+		srcline = srcline_from_fileline(a2l->filename, a2l->line);
+
+	return inline_list__append(inline_sym, srcline, node);
+}
+
+static int get_inline_function(struct dso *dso, struct inline_node *node,
+			       struct symbol *sym)
+{
+	struct a2l_data *a2l = dso->a2l;
+	Dwarf_Addr addr = a2l->addr + a2l->bias;
+	Dwarf_Addr bias = 0;
+	Dwarf_Die *cudie = dwfl_module_addrdie(a2l->mod, addr, &bias);
+
+	Dwarf_Die *scopes = NULL;
+	int nscopes = dwarf_getscopes(cudie, addr - bias, &scopes);
+	if (nscopes < 0)
+		return 0;
+
+	if (nscopes > 0) {
+		Dwarf_Die subroutine;
+		Dwarf_Off dieoff = dwarf_dieoffset(&scopes[0]);
+		dwarf_offdie(dwfl_module_getdwarf(a2l->mod, &bias), dieoff,
+			     &subroutine);
+		free(scopes);
+		scopes = NULL;
+
+		nscopes = dwarf_getscopes_die(&subroutine, &scopes);
+		if (nscopes > 1) {
+			Dwarf_Die cu;
+			Dwarf_Files *files;
+			if (dwarf_diecu(&scopes[0], &cu, NULL, NULL) != NULL &&
+			    dwarf_getsrcfiles(cudie, &files, NULL) == 0) {
+				for (int i = 0; i < nscopes - 1; i++) {
+					Dwarf_Word val;
+					Dwarf_Attribute attr;
+					Dwarf_Die *die = &scopes[i];
+					if (dwarf_tag(die) !=
+					    DW_TAG_inlined_subroutine)
+						continue;
+
+					for (int j = i + 1; j < nscopes; j++) {
+						Dwarf_Die *parent = &scopes[j];
+						int tag = dwarf_tag(parent);
+						if (tag == DW_TAG_inlined_subroutine ||
+						    tag == DW_TAG_entry_point ||
+						    tag == DW_TAG_subprogram) {
+							a2l->funcname =
+								get_diename(
+									parent);
+							break;
+						}
+					}
+
+					a2l->filename = NULL;
+					a2l->line = 0;
+					if (dwarf_formudata(
+						    dwarf_attr(die,
+							       DW_AT_call_file,
+							       &attr),
+						    &val) == 0)
+						a2l->filename = dwarf_filesrc(
+							files, val, NULL, NULL);
+
+					if (dwarf_formudata(
+						    dwarf_attr(die,
+							       DW_AT_call_line,
+							       &attr),
+						    &val) == 0)
+						a2l->line = val;
+
+					if (a2l->filename != NULL)
+						if (inline_list__append_dso_a2l(
+							dso, node, sym))
+							return 0;
+				}
+			}
+		}
+	}
+	free(scopes);
+
+	return 1;
+}
+
+static int addr2line(const char *dso_name, u64 addr, char **file,
+		     unsigned int *line, struct dso *dso, bool unwind_inlines,
+		     struct inline_node *node, struct symbol *sym)
+{
+	int ret = 0;
+	struct a2l_data *a2l = dso->a2l;
+
+	if (!a2l) {
+		dso->a2l = addr2line_init(dso_name);
+		a2l = dso->a2l;
+	}
+
+	if (a2l == NULL) {
+		if (!symbol_conf.disable_add2line_warn)
+			pr_warning("addr2line_init failed for %s\n", dso_name);
+		return 0;
+	}
+
+	a2l->addr = addr;
+	a2l->found = false;
+
+	find_address_in_section(a2l);
+
+	if (!a2l->found)
+		return 0;
+
+	if (unwind_inlines) {
+		if (node && inline_list__append_dso_a2l(dso, node, sym))
+			return 0;
+
+		if (node && !get_inline_function(dso, node, sym))
+			return 0;
+
+		ret = 1;
+	}
+
+	if (file) {
+		*file = a2l->filename ? strdup(a2l->filename) : NULL;
+		ret = *file ? 1 : 0;
+	}
+
+	if (line)
+		*line = (unsigned int)a2l->line;
+
+	return ret;
+}
+
+void dso__free_a2l(struct dso *dso)
+{
+	struct a2l_data *a2l = dso->a2l;
+
+	if (!a2l)
+		return;
+
+	addr2line_cleanup(a2l);
+
+	dso->a2l = NULL;
+}
+
+#endif /* HAVE_LIBBFD_SUPPORT */
+
+#else /* HAVE_SYMBOLIZER_SUPPORT */
+
 static int filename_split(char *filename, unsigned int *line_nr)
 {
 	char *sep;
@@ -788,7 +1063,7 @@ void dso__free_a2l(struct dso *dso)
 	dso->a2l = NULL;
 }
 
-#endif /* HAVE_LIBBFD_SUPPORT */
+#endif /* HAVE_SYMBOLIZER_SUPPORT */
 
 static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 					struct dso *dso, struct symbol *sym)
-- 
2.44.0


