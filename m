Return-Path: <linux-kernel+bounces-14947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DDD8224D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FE71F2366E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968CF179AA;
	Tue,  2 Jan 2024 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujHfzMfv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F1717982
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5edbad6f4d6so78625907b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704234895; x=1704839695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bo7QnJ2Rocmy2dSFhGJFTCBO4Oo0tkg71fjYXvrgsY0=;
        b=ujHfzMfvBZ50Q+Bp3bDIogB9YltoUOQgigr5oZgLs5qeFJt3m4YreGagCvykx4NHvF
         9ZcEEaxKanyXf2XNM/qrC1zuGmvPnqsh2lhtdQzr92q4CYTLlbkG6mFyjniPdIda4Mj7
         RU0wR7AbdLPW/vVWtFWql0do6hP7I5XAYDt7zbdLL9OqevnTeJbwgWsw7AXt36g+8vMf
         v0DTS0f4HJPioDz+F6AIeGUX17hATzS1Qb2MYyXQcGbG4iJ1wKpeIuk8JZufyJLF7EuL
         eiP3c/ILJ1Muy+2f7NCAcba8gxFJTXq4rKw5YmBaio//HhZGxXQRfpcPK02ofBjCUo1T
         smXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704234895; x=1704839695;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bo7QnJ2Rocmy2dSFhGJFTCBO4Oo0tkg71fjYXvrgsY0=;
        b=uC62q/r/ic/u3xGhZog1y41tIYAMk6auRBpdeAu9dZReq+K7rO21nBFaG3ut92QdCA
         mf8717dHtTJrsayGFge/oz9IqTFrsF351QtBkrBXDGi7TXp2Rn1xOJ0POhsnqnRlkO4B
         yu1lDXVbk4OmXRvP6VETSbrmIVkzyZH7FwuMiM1ugd344Rz+g8dZ4VQ1+VeXq41Wl49i
         xoZcrfTO+SOlHiYrKVajHgMw6bMyUGk7kG/BGhWu4BXlVG88XrQmsMNRo9CF1UiijQN7
         7IsoFjSROMAzlOdwVkYU4M9sYrpqMu6tH6xsRSMClxU3cEid4V48nMElTY5YKQtPAXN1
         JA4g==
X-Gm-Message-State: AOJu0YziSPHrNkNdtd1OtAft+uMyITzHV/SYG2M373PU/UsYgHJkHI+G
	pukf8K09Oc8TOCI5Sn1UqnUizSoMjMGFGVQQI0c=
X-Google-Smtp-Source: AGHT+IEt2KYMYv1F84l0yFuKsv5yQvjZc0k5FR21Z0K3N5a4xwMUvtTc3Zr5GXzJGyS9v6M+nbfEdLL94w0N
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:690c:4803:b0:5d4:263e:c819 with SMTP
 id hc3-20020a05690c480300b005d4263ec819mr7284133ywb.8.1704234895579; Tue, 02
 Jan 2024 14:34:55 -0800 (PST)
Date: Tue, 02 Jan 2024 22:34:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIqPlGUC/23MQQrCMBCF4auUWRvpTDRSV95DuqjJNA3URjISL
 CV3N3bt8n88vg2EU2CBa7NB4hwkxKUGHRqw07B4VsHVBmpJI9FFySp2mGdNiqxxhkY+o+2g/l+ Jx/DZrXtfewryjmnd6Yy/9Z+SUaHqDCGeWqf1w918jH7mo41P6EspX43KKMCjAAAA
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704234893; l=2072;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=g1lyrYe5iUrxOeOVHuYgApDsJo+p/V5kUf9hpYVUvWY=; b=JQXFucON0Vh1vkjrwEcZXwa27kofFiu4GPCfV6PFgwzKa/WIh92rtQjQS5Fqnk/hGOSk5JHST
 xwfy8pNPvGdBEsm9tISCrde2vaPATvlZnq0DCBXZQaFg1302JoyY7HF
X-Mailer: b4 0.12.4
Message-ID: <20240102-syscall32-v2-1-d24f70d7647c@google.com>
Subject: [PATCH v2] x86/syscalls: shrink entry/syscall_32.i via IWYU
From: Tanzir Hasan <tanzirh@google.com>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

This diff uses an open source tool include-what-you-use (IWYU) to modify
the include list, changing indirect includes to direct includes. IWYU is
implemented using the IWYUScripts github repository which is a tool that
is currently undergoing development. These changes seek to improve build
times.

pt_regs has been used because it is the only part of ptrace that is
necessary for the build of this file.

This change to entry/syscall_32.c resulted in a preprocessed size of
entry/syscall_32.i from 64002 lines to 24506 lines (-62%) for the x86
defconfig.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
Changes in v2:
- added pt_regs which was all that was needed from ptrace
- Link to v1: https://lore.kernel.org/r/20231227-syscall32-v1-1-9621140d33bd@google.com
---
 arch/x86/entry/syscall_32.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 8cfc9bc73e7f..6ed862eb3b80 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -1,12 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0
 /* System call table for i386. */
 
-#include <linux/linkage.h>
-#include <linux/sys.h>
-#include <linux/cache.h>
-#include <linux/syscalls.h>
 #include <asm/syscall.h>
 
+struct pt_regs;
+typedef long (*sys_call_ptr_t)(const struct pt_regs *);
+extern const sys_call_ptr_t sys_call_table[];
+#if defined(CONFIG_X86_32)
+#define ia32_sys_call_table sys_call_table
+#else
+/*
+ * These may not exist, but still put the prototypes in so we
+ * can use IS_ENABLED().
+ */
+extern const sys_call_ptr_t ia32_sys_call_table[];
+extern const sys_call_ptr_t x32_sys_call_table[];
+#endif
+
 #ifdef CONFIG_IA32_EMULATION
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
 #else

---
base-commit: fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
change-id: 20231227-syscall32-2c6d62fe51c9

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


