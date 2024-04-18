Return-Path: <linux-kernel+bounces-149870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497ED8A9723
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05592284E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA0F15B96A;
	Thu, 18 Apr 2024 10:19:37 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9D15B57F;
	Thu, 18 Apr 2024 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713435576; cv=none; b=gr0HchD6ElpaIkVJcuSJr6Bubzj3gL+CJZWzD80cVuEf9CFrBrODJBaJNxDm88jAXcwfDWJ4LqKpJ+aacmpxmBFU830w81QYCWDYEcLgLE+w6soQ2QebfF0qgULPqtnT2dSTXjmh5EsN/VgUp8Mx2/+LWLTlHr0QVsF9miGfgpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713435576; c=relaxed/simple;
	bh=qbNvLZrXQEQZBcnSGokYUXRmXqLv6nHf87dpUDuMzpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALimlr9buR08x/EksvCPnEO/PfM8hD1LYUa3PrK814liSQCUZqsOr2CPz9fMyDcOPsqgOBgumsU/032/dNUApk578OrSpEgluRzXPfqTEy97Eo5nJ7yIYczrEiHJF7AJGAoVOjN10lxfeH54/tPwUvqUJDtQAruzkiWhUAGTU5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=none smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAAntRKo8yBmUeZgBA--.29090S2;
	Thu, 18 Apr 2024 18:19:20 +0800 (CST)
From: sunying@isrc.iscas.ac.cn
To: masahiroy@kernel.org
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn,
	zy21df106@buaa.edu.cn,
	Ying Sun <sunying@isrc.iscas.ac.cn>
Subject: [PATCHv4 next] kconfig: add dependency warning print about invalid values while KBUILD_EXTRA_WARN=c
Date: Thu, 18 Apr 2024 18:19:03 +0800
Message-ID: <20240418101903.11314-1-sunying@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAntRKo8yBmUeZgBA--.29090S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy8Kr48JFWrGw4fZrWkZwb_yoW5tr1fp3
	WrXay3Cr4DAF1fta9xtFy8Ga15tFWvyr17trsxuw17AFy5CFWIgrsrGw1agrWDGrW3A3yr
	CFyFgFWYkF4DKaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv214x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
	MxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
	7VUbvzutUUUUU==
X-CM-SenderInfo: 5vxq5x1qj6x21ufox2xfdvhtffof0/

From: Ying Sun <sunying@isrc.iscas.ac.cn>

The patch enhances kernel error messages, fixes problems with
 the previous version of v3, and has been thoroughly tested.
 We believe it will improve the clarity and usefulness
 of kconfig error messages, which will help developers better diagnose and
 resolve configuration issues.

----- v3 -> v4:
1. Fixed the dependency logic print error, distinguishing
 between unsatisfied dependencies and forced enable
 errors (related to the select keyword).
2. Add export KCONFIG_WARN_CHANGED_INPUT=1 to scripts/kconfig/Makefile,
 which can be enabled by setting KBUILD_EXTRA_WARN to -c.

Signed-off-by: Siyuan Guo <zy21df106@buaa.edu.cn>
Signed-off-by: Ying Sun <sunying@isrc.iscas.ac.cn>
---
 scripts/kconfig/Makefile   |  1 +
 scripts/kconfig/confdata.c | 60 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index ea1bf3b3dbde..b755246fe057 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -29,6 +29,7 @@ KCONFIG_DEFCONFIG_LIST += arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG)
 
 ifneq ($(findstring c, $(KBUILD_EXTRA_WARN)),)
 export KCONFIG_WARN_UNKNOWN_SYMBOLS=1
+export KCONFIG_WARN_CHANGED_INPUT=1
 endif
 
 ifneq ($(findstring e, $(KBUILD_EXTRA_WARN)),)
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 0e35c4819cf1..91c63bd1cedd 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -176,6 +176,41 @@ static void conf_warning(const char *fmt, ...)
 	conf_warnings++;
 }
 
+static void conf_warn_unmet_rev(struct symbol *sym)
+{
+	struct gstr gs = str_new();
+
+	str_printf(&gs,
+		"WARNING: unmet reverse dependencies detected for %s\n",
+		sym->name);
+
+	expr_gstr_print_revdep(sym->rev_dep.expr, &gs, yes,
+				" Selected by [y]:\n");
+	expr_gstr_print_revdep(sym->rev_dep.expr, &gs, mod,
+				" Selected by [m]:\n");
+
+	fputs(str_get(&gs), stderr);
+	str_free(&gs);
+}
+
+static void conf_warn_dep_error(struct symbol *sym)
+{
+	struct gstr gs = str_new();
+
+	str_printf(&gs,
+		"WARNING: unmet direct dependencies detected for %s\n",
+		sym->name);
+
+	str_printf(&gs,
+		" Depends on [%c]: ",
+		sym->dir_dep.tri == mod ? 'm' : 'n');
+	expr_gstr_print(sym->dir_dep.expr, &gs);
+
+	str_printf(&gs, "\n");
+	fputs(str_get(&gs), stderr);
+	str_free(&gs);
+}
+
 static void conf_default_message_callback(const char *s)
 {
 	printf("#\n# ");
@@ -522,6 +557,31 @@ int conf_read(const char *name)
 			continue;
 		conf_unsaved++;
 		/* maybe print value in verbose mode... */
+		if (getenv("KCONFIG_WARN_CHANGED_INPUT")) {
+			if (sym->prop) {
+				switch (sym->type) {
+				case S_BOOLEAN:
+				case S_TRISTATE:
+					if (sym->def[S_DEF_USER].tri != sym_get_tristate_value(sym)) {
+						if (sym->rev_dep.tri < sym->def[S_DEF_USER].tri &&
+							sym->dir_dep.tri < sym->def[S_DEF_USER].tri)
+								conf_warn_dep_error(sym);
+						if (sym->rev_dep.tri > sym->def[S_DEF_USER].tri &&
+							sym->dir_dep.tri >= sym->def[S_DEF_USER].tri)
+								conf_warn_unmet_rev(sym);
+					}
+					break;
+				case S_INT:
+				case S_HEX:
+				case S_STRING:
+					if (sym->dir_dep.tri == no && sym_has_value(sym))
+						conf_warn_dep_error(sym);
+					break;
+				default:
+					break;
+				}
+			}
+		}
 	}
 
 	for_all_symbols(sym) {
-- 
2.43.0


