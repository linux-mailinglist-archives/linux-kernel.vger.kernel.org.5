Return-Path: <linux-kernel+bounces-13976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE8082165E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B98A281BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF42EC4;
	Tue,  2 Jan 2024 02:11:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDA0A3C;
	Tue,  2 Jan 2024 02:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAD3_yMvb5Nl+tHCAg--.20282S2;
	Tue, 02 Jan 2024 10:04:31 +0800 (CST)
From: sunying@isrc.iscas.ac.cn
To: masahiroy@kernel.org
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn,
	Ying Sun <sunying@isrc.iscas.ac.cn>,
	Siyuan Guo <zy21df106@buaa.edu.cn>
Subject: [PATCHv3 next] kconfig: add dependency warning print about invalid values in verbose mode
Date: Tue,  2 Jan 2024 10:04:05 +0800
Message-ID: <20240102020405.32701-1-sunying@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3_yMvb5Nl+tHCAg--.20282S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFy7Zw48XrW5Zr47Kr4fGrg_yoWrJr4fpa
	yrWa43JF4DAryayanxt3W8Kw1Fka4kXr17trsxCw17AFyaya97tr47Kw15trWUCrWIyw45
	CFnIgrZ5KanrWaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv214x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
	c2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7VUjI38UUUUUU==
X-CM-SenderInfo: 5vxq5x1qj6x21ufox2xfdvhtffof0/

From: Ying Sun <sunying@isrc.iscas.ac.cn>

Warning in verbose mode about incorrect causes and
 mismatch dependency of invalid values to help users correct them.

Detailed warning messages are printed only when the environment variable
 is set like "KCONFIG_WARN_CHANGED_INPUT=1".
By default, the current behavior is not changed.

Signed-off-by: Siyuan Guo <zy21df106@buaa.edu.cn>
Signed-off-by: Ying Sun <sunying@isrc.iscas.ac.cn>
---
v2 -> v3:
* Fixed warning message that mess up the ncurses display.
* Fixed memory leak where str_new() was called but str_free() was not used.
* Integrated the code to avoid excessive dispersion.
* Use the environment variable KCONFIG_WARN_CHANGED_INPUT as the switch

v1 -> v2:
* Reduced the number of code lines by refactoring and simplifying the logic.
* Changed the print "ERROR" to "WARNING".
* Focused on handling dependency errors: dir_dep and rev_dep, and range error.
  - A downgrade from 'y' to 'm' has be warned.
  - A new CONFIG option should not be warned.
  - Overwriting caused by default value is not an error and is no longer printed.
* Fixed style issues.
---
---
 scripts/kconfig/confdata.c | 76 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index f1197e672431..352774928558 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -195,6 +195,52 @@ static void conf_message(const char *fmt, ...)
 	va_end(ap);
 }
 
+static void conf_warn_unmet_rev_dep(struct symbol *sym)
+{
+	struct gstr gs = str_new();
+	char value = 'n';
+
+	switch (sym->curr.tri) {
+	case no:
+		value = 'n';
+		break;
+	case mod:
+		sym_calc_value(modules_sym);
+		value = (modules_sym->curr.tri == no) ? 'n' : 'm';
+		break;
+	case yes:
+		value = 'y';
+	}
+
+	str_printf(&gs,
+		"'%s' set to %c for it is selected\n",
+		sym->name, value);
+	expr_gstr_print_revdep(sym->rev_dep.expr, &gs, yes,
+				" Selected by [y]:\n");
+	expr_gstr_print_revdep(sym->rev_dep.expr, &gs, mod,
+				" Selected by [m]:\n");
+
+	conf_warning("%s", str_get(&gs));
+	str_free(&gs);
+}
+
+static void conf_warn_dep_error(struct symbol *sym)
+{
+	struct gstr gs = str_new();
+
+	str_printf(&gs,
+		"'%s' set to n for it unmet direct dependencies\n",
+		sym->name);
+
+	str_printf(&gs,
+		" Depends on [%c]: ",
+		sym->dir_dep.tri == mod ? 'm' : 'n');
+	expr_gstr_print(sym->dir_dep.expr, &gs);
+
+	conf_warning("%s\n", str_get(&gs));
+	str_free(&gs);
+}
+
 const char *conf_get_configname(void)
 {
 	char *name = getenv("KCONFIG_CONFIG");
@@ -568,6 +614,36 @@ int conf_read(const char *name)
 			continue;
 		conf_unsaved++;
 		/* maybe print value in verbose mode... */
+		if (getenv("KCONFIG_WARN_CHANGED_INPUT") && (sym->prop)) {
+			conf_filename = sym->prop->file->name;
+			conf_lineno = sym->prop->menu->lineno;
+
+			switch (sym->type) {
+			case S_BOOLEAN:
+			case S_TRISTATE:
+				if (sym->def[S_DEF_USER].tri != sym_get_tristate_value(sym)) {
+					if (sym->dir_dep.tri < sym->def[S_DEF_USER].tri)
+						conf_warn_dep_error(sym);
+					else if (sym->rev_dep.tri > sym->def[S_DEF_USER].tri)
+						conf_warn_unmet_rev_dep(sym);
+					else
+						conf_warning("'%s' set to %s due to option constraints\n",
+							sym->name, sym_get_string_value(sym));
+				}
+				break;
+			case S_INT:
+			case S_HEX:
+			case S_STRING:
+				if (sym->dir_dep.tri == no && sym_has_value(sym))
+					conf_warn_dep_error(sym);
+				else
+					conf_warning("'%s' set to %s due to option constraints\n",
+							sym->name, sym_get_string_value(sym));
+				break;
+			default:
+				break;
+			}
+		}
 	}
 
 	for_all_symbols(i, sym) {
-- 
2.43.0


