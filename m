Return-Path: <linux-kernel+bounces-12300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8041481F28E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDCF2822AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30C49891;
	Wed, 27 Dec 2023 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLilDUA4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5691245940
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28be8ebaacaso4448328a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703716753; x=1704321553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PcqsBAd/aFOjWDJdLqM/yms60boSgfpp/VS6qzV9PX8=;
        b=WLilDUA4brpIZazN8NnJkOD7uO8DiPqxJoLZAuuH4TG5uwxhDX7Oc5MGsDFuIDN/xC
         RHi2kJJG1oMH4jp/lmMHjzKSdFU9OwFexnGwW1jvh/btWWHU+O9m+XQkcDh4mhUQEZDi
         v1qtMh2hO1OVVHeQlmQl8uRf3dOCFuKNDuDHHq8xUPRHmsvcFmEcMYgiVkl566044NaY
         AN23wDs+ZK6bJCVR1tNWB8cKn2LJo+8KhYLsL36L4HqPT+zuR6wdwSKU0SQPwG5e5ZTP
         jfPv/bGZ0LMor0Le5iT29nW1D8PO8+4X/qnqYEItDg1DmYhXcdpSl1qQQZVpZqQX1FyZ
         ovbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703716753; x=1704321553;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PcqsBAd/aFOjWDJdLqM/yms60boSgfpp/VS6qzV9PX8=;
        b=uywW7CoZt7Dp9NB8rUeAsvM5CQ4VFK2pnb7+yKvXzmq06aBzgVqJV8q+jVcmZdJmWX
         lQTqTtflSsPAITx9jhe66PO1AxeYwKMhdnEvcl9GO0+hVkr4uDO5ydzWCJysMxFOsc7D
         VT1VEH8Cn6+jgM5oTpN2q0JxUinVP0joGHxYUnZGqz2++IxyBQAfA7EASmcb72KRm613
         xbnahqOViNoWsKDNuUYzlXm4A86j9i7Npc6Q/rSYZ4ML0uYGWzHOJ4B96xH35uiTd1/I
         Pzu1rjqCUKxTvJ3rt8ZafSpzKmJjb7otGZmvap85K6NMmLK1GPb8qeXgUyY16EcXkkpz
         hiWQ==
X-Gm-Message-State: AOJu0Yx/Ckai8X6HQNAdXlpoy5iBEaakM+F0JuNwC9PTRCSvgFh264oK
	pFIYUAa8p/1lRwFetv8/W+2Ywr1g2OIy5vUe6jc=
X-Google-Smtp-Source: AGHT+IHBHOGTrFIM9xCHIaq04x3tQS/EO8nl5egEGsteat/TRJqgpNhJK04Rl5qcJHAWaGS15jFEgNEwp7Q1
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a17:90b:4f91:b0:28b:90a2:ab48 with SMTP id
 qe17-20020a17090b4f9100b0028b90a2ab48mr1648895pjb.2.1703716753557; Wed, 27
 Dec 2023 14:39:13 -0800 (PST)
Date: Wed, 27 Dec 2023 22:38:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHCnjGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIyNz3eLK4uTEnBxjI12jZLMUM6O0VFPDZEsloPqCotS0zAqwWdGxtbU AYk/4zFsAAAA=
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703716752; l=1368;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=HxKAmyTm/nk4+hwwhAFyn0XNoEbL4C9Ytf+CzB6ACzw=; b=zL8OW9jzRbFKTK5svkJAI83NDNAOi35xukG1rOC9sc4NnhwfxQcGcAARagC35FmVdegDqe2hm
 wew2kbQYd1mCeHe3q7DCpveGs2USaWyqJmk2Br7IUF/6KrICHgZSPJi
X-Mailer: b4 0.12.4
Message-ID: <20231227-syscall32-v1-1-9621140d33bd@google.com>
Subject: [PATCH] x86/syscalls: shrink entry/syscall_32.i via IWYU
From: Tanzir Hasan <tanzirh@google.com>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>, 
	Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

This diff uses an open source tool include-what-you-use (IWYU) to modify
the include list, changing indirect includes to direct includes. IWYU is
implemented using the IWYUScripts github repository which is a tool that
is currently undergoing development. These changes seek to improve build
times.

This change to entry/syscall_32.c resulted in a preprocessed size of
entry/syscall_32.i from 64002 lines to 47986 lines (-25%) for the x86
defconfig.

Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 arch/x86/entry/syscall_32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 8cfc9bc73e7f..66db11fe8a1c 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -4,7 +4,7 @@
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
-#include <linux/syscalls.h>
+#include <linux/ptrace.h>
 #include <asm/syscall.h>
 
 #ifdef CONFIG_IA32_EMULATION
@@ -16,6 +16,7 @@
 #define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
 
 #include <asm/syscalls_32.h>
+
 #undef __SYSCALL
 
 #define __SYSCALL(nr, sym) __ia32_##sym,

---
base-commit: fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
change-id: 20231227-syscall32-2c6d62fe51c9

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


