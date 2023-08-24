Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C287787B21
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243804AbjHXWCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243800AbjHXWCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:02:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F160172D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:02:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d746edab033so902580276.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692914523; x=1693519323;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ByfN+noqMCVkVscBGCrI7pkixl0yY22EjKSAxd2EZU=;
        b=FW2erCnLQgKayhTZ1wVW9bz0T67VsUF1CK5WHkoQqQxEE2KF0iRsarlccu1dyv2SGL
         eA5k6PLHdgB12BXIe/KZnfbdPEBplyPPBvqW++IQobq0vl+oNXUqJKppFVULGZE0DPnC
         3g+eS1qmuWPjegyzhjMFmsWzLgz+J37nt9Y1w+/fkP/AfLH0uuQSmtZSTzRu03AVWhzi
         nvnlRsplZuLFpnfFEhJX4YNJvBIYgECemDv+4hLueCKlO7oOHdPWI1udE7+FQ/8KyH/u
         0AUi8XQn2oZxt6Wmd6BVMmraFxPvWZR+Qkw/7gvYq1ZLMS3wWBWAu3u2jN2YuAPK1GWT
         BPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692914523; x=1693519323;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ByfN+noqMCVkVscBGCrI7pkixl0yY22EjKSAxd2EZU=;
        b=JAUVzW0yZ0u0dGgYeGKVPSl3duU48KY11e1J/mz/4KSp95YfhZlei2BSHBwEpOIiHI
         DLk5NVPty8lv+xqWpRrmB+tIfKQvWNb7zrVkevNY48/vZP8JFLBqacyEcoiJ7axKo8rs
         Err0Kc7h+E4cMJrBvISxhTJpIsScCG9X1numB/oxXRkp+CkFg1QAOZGCPuzATxNMymcb
         nZKg/zj9+2CI+4NfRsC/tyxauPlFkWlVV9LRZ92BkpMPUpPp7Rw3xcx/Og5adDPltO2B
         muTR/HZVTcPdavrI9c98eg9sTWOfQwLM20r5I8CmgRiJ7RcMpH0IbVfyBWlAITTeHOax
         tVEw==
X-Gm-Message-State: AOJu0YxFjr6tUV4/J/n+DOTTBS39EQUy1Z0DQBwC09U5s4URwySxtqDp
        c/2LIEdYSTts8djbEoei2TNzExLZuOPny9GZSg==
X-Google-Smtp-Source: AGHT+IEshr77Q7qNUIKJt/rqr0sZwkrC1oqkt+XoJDSjwXojBu49XkLcMiNAZ3o+agl+ciZNsen26PutIQ7eEzU2gw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:691:b0:bd5:dc2d:9d7f with
 SMTP id i17-20020a056902069100b00bd5dc2d9d7fmr353667ybt.4.1692914523292; Thu,
 24 Aug 2023 15:02:03 -0700 (PDT)
Date:   Thu, 24 Aug 2023 22:02:02 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFnT52QC/x3MPQqEQAxA4atI6g04P4XYCh7AdtliHKOmGYdEZ
 EW8u4PNg695FygJk0JbXSB0sPKWCsyngriGtBDyVAy2tq5urEfdJcV84iR8kCiGmPlNDOisCbO j0RtPUA5ZaOb/e//C0Hfwu+8HdjFd0XIAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692914522; l=3684;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=a9UsameJpI592QOpENgrhz3IgrWL7+TLPCUljbg60hc=; b=e3Pv4SmVInFuVIbTKSQXxLeqrBg7t0W4yh/+B4IXTVUNIyarAJtZGQqiq8TM2ro117RoQHQoX
 BrU6DwJ/4dmBFk6SNWPePeKezFEJP6lF76aWDrBPbEHYmyL328c6yOk
X-Mailer: b4 0.12.3
Message-ID: <20230824-strncpy-drivers-acpi-acpica-v1-1-d027ba183b66@google.com>
Subject: [PATCH RFC] ACPICA: remove acpi_ut_safe_strncpy in favor of strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to gather some thoughts on removing `acpi_ut_safe_strncpy` (and
potentially other `acpi...safe...()` interfaces) in favor of
pre-existing interfaces in the kernel (like strscpy).

Running a git blame shows these functions were implemented 10 years ago
and their implementations generally mirror the _newer_ and more robust
stuff in lib/string.h -- Let's just use these, right?

I appreciate any comments and whether or not I should stop at just
`strncpy`.

Thanks

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/acpi/acpica/acutils.h   | 2 --
 drivers/acpi/acpica/dbfileio.c  | 2 +-
 drivers/acpi/acpica/psutils.c   | 2 +-
 drivers/acpi/acpica/utnonansi.c | 8 --------
 drivers/acpi/acpica/uttrack.c   | 2 +-
 5 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index edfdbbef81c1..4d5c401a14b4 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -626,8 +626,6 @@ void acpi_ut_repair_name(char *name);
 #if defined (ACPI_DEBUGGER) || defined (ACPI_APPLICATION) || defined (ACPI_DEBUG_OUTPUT)
 u8 acpi_ut_safe_strcpy(char *dest, acpi_size dest_size, char *source);
 
-void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size);
-
 u8 acpi_ut_safe_strcat(char *dest, acpi_size dest_size, char *source);
 
 u8
diff --git a/drivers/acpi/acpica/dbfileio.c b/drivers/acpi/acpica/dbfileio.c
index e1b6e54a96ac..197e1ff1f72c 100644
--- a/drivers/acpi/acpica/dbfileio.c
+++ b/drivers/acpi/acpica/dbfileio.c
@@ -63,7 +63,7 @@ void acpi_db_open_debug_file(char *name)
 	}
 
 	acpi_os_printf("Debug output file %s opened\n", name);
-	acpi_ut_safe_strncpy(acpi_gbl_db_debug_filename, name,
+	strscpy(acpi_gbl_db_debug_filename, name,
 			     sizeof(acpi_gbl_db_debug_filename));
 	acpi_gbl_db_output_to_file = TRUE;
 }
diff --git a/drivers/acpi/acpica/psutils.c b/drivers/acpi/acpica/psutils.c
index d550c4af4702..95af2c74e00b 100644
--- a/drivers/acpi/acpica/psutils.c
+++ b/drivers/acpi/acpica/psutils.c
@@ -60,7 +60,7 @@ void acpi_ps_init_op(union acpi_parse_object *op, u16 opcode)
 	op->common.descriptor_type = ACPI_DESC_TYPE_PARSER;
 	op->common.aml_opcode = opcode;
 
-	ACPI_DISASM_ONLY_MEMBERS(acpi_ut_safe_strncpy(op->common.aml_op_name,
+	ACPI_DISASM_ONLY_MEMBERS(strscpy(op->common.aml_op_name,
 						      (acpi_ps_get_opcode_info
 						       (opcode))->name,
 						      sizeof(op->common.
diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnonansi.c
index ff0802ace19b..a465e5a1d309 100644
--- a/drivers/acpi/acpica/utnonansi.c
+++ b/drivers/acpi/acpica/utnonansi.c
@@ -164,12 +164,4 @@ acpi_ut_safe_strncat(char *dest,
 	return (FALSE);
 }
 
-void acpi_ut_safe_strncpy(char *dest, char *source, acpi_size dest_size)
-{
-	/* Always terminate destination string */
-
-	strncpy(dest, source, dest_size);
-	dest[dest_size - 1] = 0;
-}
-
 #endif
diff --git a/drivers/acpi/acpica/uttrack.c b/drivers/acpi/acpica/uttrack.c
index f5f5da441458..a96a86bc5781 100644
--- a/drivers/acpi/acpica/uttrack.c
+++ b/drivers/acpi/acpica/uttrack.c
@@ -368,7 +368,7 @@ acpi_ut_track_allocation(struct acpi_debug_mem_block *allocation,
 	allocation->component = component;
 	allocation->line = line;
 
-	acpi_ut_safe_strncpy(allocation->module, (char *)module,
+	strscpy(allocation->module, (char *)module,
 			     ACPI_MAX_MODULE_NAME);
 
 	if (!element) {

---
base-commit: f9604036a3fb6149badf346994b46b03f9292db7
change-id: 20230824-strncpy-drivers-acpi-acpica-321af3eb414e

Best regards,
--
Justin Stitt <justinstitt@google.com>

