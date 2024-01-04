Return-Path: <linux-kernel+bounces-16134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545BA823977
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A1C1F26080
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B15380;
	Thu,  4 Jan 2024 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1u+bgblV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E1F36B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28bd4766346so4928088a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 16:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704327232; x=1704932032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZrYKMRYWxzzexZEQAQsei+WMO0cgaz4RM/iguewDCCg=;
        b=1u+bgblV+VRtKAQw07+6uwGwJbW11fUfrye6JpUjfUy/ElJOjAC8iXgUMPbPXJCY8D
         IdAUpUjnJgUjQt8SfQo2INAhhJ+oU0ZUDBqisBZIs4SrDvZguWvkOT/h9TdWPWTn6vJ5
         JvMRtMPSnAjgYYqoNs/n18NzylwHf3HMikGnHBQbhuX0IVEjuQkHMwJd53FJkAQPvn7M
         5DRVyPKVLVjETIeUJ7PlmUwvMXPD9rvFm2uoVGOIyf5XKhY6E3KdXW5KoTq6Qmy3Kery
         sf1hImrxax97eRWCjIniI7Y607b9Y1p6/TIktQip1fBGycoiyb7L84wYj2NYAe9qEnuE
         LzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704327232; x=1704932032;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZrYKMRYWxzzexZEQAQsei+WMO0cgaz4RM/iguewDCCg=;
        b=ANUqpvYsJfknJ/DbUHLvbVRMjbCrpMn76UZgFQtx1Obn//+1b6hPOYXv4kxig0FGWQ
         J3qnE+ReMMX2Xr9tFm2oEYJtY1dDDtY4735j327YjWT9jXW3YYFzOh/fL/ulaDF7Zrwp
         OdBLy7Px5ocIT3u5ulv1pGeB3lkpI9lKfxarQcqq73fj4i7CyXVO1sXDWi5D2Sj7nKoW
         nt/6nkRvWHnGN8MCPduTNiknGewKeJTq2QBpz+8O2Vz/hlvR81X9ebzsGSNhdsvl6Vof
         fnh96tAOOQgjZ/My7p4b6Hls/b6T0H+kaxPEtvQeLbvneYIEHEaAGmOlxtOWEtAnWmN4
         HQWA==
X-Gm-Message-State: AOJu0Yy3YeyrjLqW1UT0s33xDzMbVuv5uYkkgS2uDXawZHugxKDeuNKO
	Hfmz+ZUktyahOWAnlTwqO4v/YYLR9nR+iWWD6D8=
X-Google-Smtp-Source: AGHT+IFVhjicK/lXt14KFgDRYzuoOxUiwllwck9FzmcrecVJDKU+3CcieWs8nKzr4RAqro0wCok5jb7YnKth
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a17:90a:d244:b0:28c:b501:4013 with SMTP id
 o4-20020a17090ad24400b0028cb5014013mr281753pjw.0.1704327232145; Wed, 03 Jan
 2024 16:13:52 -0800 (PST)
Date: Thu, 04 Jan 2024 00:13:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACj4lWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIyML3eLK4uTEnJx4MxNdY4OkRDMLExODRAtTJaCGgqLUtMwKsGHRsbW 1AI0o7YZcAAAA
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704327230; l=1811;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=KIRnAIDqB/9IT/v6wGV20l5BPvyrftk9tX9O9bSqqsw=; b=NJ3Xoui4SapQN88UhXV40CgJ3K58ze56NgyzydWfamU+h7BkElq3u5DS4C1Don4AASiNz99R8
 JP3mY9njTznAUsp5sM7myTvolvj/RNMcyYtHWju4tZzQtuvsD9AF3Vt
X-Mailer: b4 0.12.4
Message-ID: <20240104-syscall_64-v1-1-57fe392ef565@google.com>
Subject: [PATCH] x86/syscalls: shrink entry/syscall_64.i via IWYU
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

This change to entry/syscall_64.c resulted in a preprocessed size of
entry/syscall_64.i from 64003 lines to 24509 lines (-62%) for the x86
defconfig.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 arch/x86/entry/syscall_64.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index be120eec1fc9..9e4a3d8957f3 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -1,12 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0
 /* System call table for x86-64. */
 
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
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL

---
base-commit: f5837722ffecbbedf1b1dbab072a063565f0dad1
change-id: 20231228-syscall_64-30ba68440a85

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


