Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E6A792B96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbjIEQzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354122AbjIEJn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:43:29 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940671AD;
        Tue,  5 Sep 2023 02:43:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.141.245])
        by APP-05 (Coremail) with SMTP id zQCowACnrWE1+PZkgCnQCg--.20711S2;
        Tue, 05 Sep 2023 17:43:17 +0800 (CST)
From:   sunying@nj.iscas.ac.cn
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        senozhatsky@chromium.org, mr.bossman075@gmail.com,
        Ying Sun <sunying@nj.iscas.ac.cn>,
        Siyuan Guo <zy21df106@buaa.edu.cn>
Subject: [PATCHv2 -next] kconfig: add dependency warning print about invalid values in verbose mode
Date:   Tue,  5 Sep 2023 17:43:13 +0800
Message-Id: <20230905094313.11609-1-sunying@nj.iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230809002436.18079-1-sunying@nj.iscas.ac.cn>
References: <20230809002436.18079-1-sunying@nj.iscas.ac.cn>
X-CM-TRANSID: zQCowACnrWE1+PZkgCnQCg--.20711S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWxXw4UCFy8WF4kGr18AFb_yoW3XrW5pa
        18uayUKrsrAFySvw17KF18Cw1rJ3yvgr4xCwsxCw17ZFy3ta92vw47Gr1Yqa15Cr48ArWj
        ka4F9FWFkF4xJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUva14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
        F24lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
        uYvjfUOrWrDUUUU
X-Originating-IP: [124.16.141.245]
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ying Sun <sunying@nj.iscas.ac.cn>

Add warning about the configuration option's invalid value in verbose mode,
 including error causes, mismatch dependency, old and new values,
 to help users correct them.

Detailed error messages are printed only when the environment variable
 is set like "KCONFIG_VERBOSE=1".
By default, the current behavior is not changed.

Signed-off-by: Siyuan Guo <zy21df106@buaa.edu.cn>
Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>
---
v1 -> v2:
* Reduced the number of code lines by refactoring and simplifying the logic.
* Changed the print "ERROR" to "WARNING".
* Focused on handling dependency errors: dir_dep and rev_dep, and range error.
  - A downgrade from 'y' to 'm' has be warned.
  - A new CONFIG option should not be warned.
  - Overwriting caused by default value is not an error and is no longer printed.
* Fixed style issues.
---
 scripts/kconfig/confdata.c | 100 +++++++++++++++++++++++++++++++++++--
 scripts/kconfig/lkc.h      |   7 +++
 scripts/kconfig/symbol.c   |  24 +++++++--
 3 files changed, 121 insertions(+), 10 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 4a6811d77d18..86794ab39d7d 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -154,6 +154,56 @@ static void conf_message(const char *fmt, ...)
 
 static const char *conf_filename;
 static int conf_lineno, conf_warnings;
+const char *verbose;
+
+void conf_error_log(enum error_type type, struct symbol *sym, char *log, ...)
+{
+	static char *const tristate2str[3] = {"n", "m", "y"};
+	struct gstr gs = str_new();
+	char s[100];
+	char *oldval = NULL;
+	va_list args;
+
+	va_start(args, log);
+	vsnprintf(s, sizeof(s), log, args);
+	va_end(args);
+
+	switch (sym->type) {
+	case S_BOOLEAN:
+	case S_TRISTATE:
+		oldval = tristate2str[sym->def[S_DEF_USER].tri];
+		break;
+	case S_INT:
+	case S_HEX:
+	case S_STRING:
+		oldval = sym->def[S_DEF_USER].val;
+	default:
+		break;
+	}
+
+	str_printf(&gs,
+		"\nWARNING : %s [%s] value is invalid\n",
+		sym->name, oldval);
+	str_printf(&gs, s);
+	switch (type) {
+	case DIR_DEP:
+		str_printf(&gs,
+			"  Depends on [%c]: ",
+			sym->dir_dep.tri == mod ? 'm' : 'n');
+		expr_gstr_print(sym->dir_dep.expr, &gs);
+		str_printf(&gs, "\n");
+		break;
+	case REV_DEP:
+		expr_gstr_print_revdep(sym->rev_dep.expr, &gs, yes,
+					"  Selected by [y]:\n");
+		expr_gstr_print_revdep(sym->rev_dep.expr, &gs, mod,
+					"  Selected by [m]:\n");
+		break;
+	default:
+		break;
+	}
+	fputs(str_get(&gs), stderr);
+}
 
 static void conf_warning(const char *fmt, ...)
 {
@@ -226,11 +276,14 @@ static const char *conf_get_rustccfg_name(void)
 static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 {
 	char *p2;
+	static const char * const type[] = {"unknown", "bool", "tristate", "int", "hex", "string"};
 
 	switch (sym->type) {
 	case S_TRISTATE:
 		if (p[0] == 'm') {
 			sym->def[def].tri = mod;
+
+
 			sym->flags |= def_flags;
 			break;
 		}
@@ -246,9 +299,14 @@ static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 			sym->flags |= def_flags;
 			break;
 		}
-		if (def != S_DEF_AUTO)
-			conf_warning("symbol value '%s' invalid for %s",
+		if (def != S_DEF_AUTO) {
+			if (verbose)
+				conf_warning("symbol value '%s' invalid for %s\n due to its type is %s",
+				     p, sym->name, type[sym->type]);
+			else
+				conf_warning("symbol value '%s' invalid for %s",
 				     p, sym->name);
+		}
 		return 1;
 	case S_STRING:
 		/* No escaping for S_DEF_AUTO (include/config/auto.conf) */
@@ -274,9 +332,14 @@ static int conf_set_sym_val(struct symbol *sym, int def, int def_flags, char *p)
 			sym->def[def].val = xstrdup(p);
 			sym->flags |= def_flags;
 		} else {
-			if (def != S_DEF_AUTO)
-				conf_warning("symbol value '%s' invalid for %s",
-					     p, sym->name);
+			if (def != S_DEF_AUTO) {
+				if (verbose)
+					conf_warning("symbol value '%s' invalid for %s\n due to its type is %s",
+						p, sym->name, type[sym->type]);
+				else
+					conf_warning("symbol value '%s' invalid for %s",
+						p, sym->name);
+			}
 			return 1;
 		}
 		break;
@@ -545,6 +608,7 @@ int conf_read(const char *name)
 	int conf_unsaved = 0;
 	int i;
 
+	verbose = getenv("KCONFIG_VERBOSE");
 	conf_set_changed(false);
 
 	if (conf_read_simple(name, S_DEF_USER)) {
@@ -576,6 +640,32 @@ int conf_read(const char *name)
 			continue;
 		conf_unsaved++;
 		/* maybe print value in verbose mode... */
+		if (verbose) {
+			switch (sym->type) {
+			case S_BOOLEAN:
+			case S_TRISTATE:
+				if (sym->def[S_DEF_USER].tri != sym->curr.tri) {
+					if (sym->dir_dep.tri < sym->def[S_DEF_USER].tri)
+						conf_error_log(DIR_DEP, sym,
+							"  due to unmet direct dependencies\n",
+							NULL);
+					if (sym->rev_dep.tri > sym->def[S_DEF_USER].tri)
+						conf_error_log(REV_DEP, sym,
+							"  due to it is selected\n", NULL);
+				}
+				break;
+			case S_INT:
+			case S_HEX:
+			case S_STRING:
+				if (sym->dir_dep.tri == no &&
+					strcmp((char *)(sym->def[S_DEF_USER].val), "") != 0)
+					conf_error_log(DIR_DEP, sym,
+						"  due to unmet direct dependencies\n", NULL);
+				break;
+			default:
+				break;
+			}
+		}
 	}
 
 	for_all_symbols(i, sym) {
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 471a59acecec..242b24650f47 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -38,10 +38,17 @@ void zconf_initscan(const char *name);
 void zconf_nextfile(const char *name);
 int zconf_lineno(void);
 const char *zconf_curname(void);
+extern const char *verbose;
+enum error_type {
+	DIR_DEP,
+	REV_DEP,
+	RANGE
+};
 
 /* confdata.c */
 const char *conf_get_configname(void);
 void set_all_choice_values(struct symbol *csym);
+void conf_error_log(enum error_type type, struct symbol *sym, char *log, ...);
 
 /* confdata.c and expr.c */
 static inline void xfwrite(const void *str, size_t len, size_t count, FILE *out)
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 0572330bf8a7..a78f7eb64f40 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -600,7 +600,7 @@ bool sym_string_valid(struct symbol *sym, const char *str)
 bool sym_string_within_range(struct symbol *sym, const char *str)
 {
 	struct property *prop;
-	long long val;
+	long long val, left, right;
 
 	switch (sym->type) {
 	case S_STRING:
@@ -612,8 +612,15 @@ bool sym_string_within_range(struct symbol *sym, const char *str)
 		if (!prop)
 			return true;
 		val = strtoll(str, NULL, 10);
-		return val >= sym_get_range_val(prop->expr->left.sym, 10) &&
-		       val <= sym_get_range_val(prop->expr->right.sym, 10);
+		left = sym_get_range_val(prop->expr->left.sym, 10);
+		right = sym_get_range_val(prop->expr->right.sym, 10);
+		if (val >= left && val <= right)
+			return true;
+		if (verbose)
+			conf_error_log(RANGE, sym,
+				"  symbol value is %lld, the range is (%lld %lld)\n",
+				val, left, right);
+		return false;
 	case S_HEX:
 		if (!sym_string_valid(sym, str))
 			return false;
@@ -621,8 +628,15 @@ bool sym_string_within_range(struct symbol *sym, const char *str)
 		if (!prop)
 			return true;
 		val = strtoll(str, NULL, 16);
-		return val >= sym_get_range_val(prop->expr->left.sym, 16) &&
-		       val <= sym_get_range_val(prop->expr->right.sym, 16);
+		left = sym_get_range_val(prop->expr->left.sym, 16);
+		right = sym_get_range_val(prop->expr->right.sym, 16);
+		if (val >= left && val <= right)
+			return true;
+		if (verbose)
+			conf_error_log(RANGE, sym,
+				"  symbol value is 0x%llx, the range is (0x%llx 0x%llx)\n",
+				val, left, right);
+		return false;
 	case S_BOOLEAN:
 	case S_TRISTATE:
 		switch (str[0]) {
-- 
2.17.1

