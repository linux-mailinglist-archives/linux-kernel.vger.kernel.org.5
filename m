Return-Path: <linux-kernel+bounces-12228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F2681F19E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315F8B21A50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FEE47783;
	Wed, 27 Dec 2023 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKqzoTRn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514844C94
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdb14f811cso6498458276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 11:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703705770; x=1704310570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x/ThKy08dAX7RrEKVD7KhsQu3ictNFmWXD3vtZ7e4Tg=;
        b=WKqzoTRnckjS414vpORgulBMvNowrjOvm7jNxMY96Kz1b0144JHw/3ihSHH9VdT+NM
         Ua9xbcEZvHcYygnMeLiwtG9VKcKyjEqNettbXeLAkA0hHCQWUkNK0f2u8lohY54wReLP
         sIe4SxHN0D+HZXIEsTJZtL6Ia2AHsQ0Ogk8hYdkuZnUfAcv54cPRI9ghohKzgMIqzWhS
         h6P1nBhnjYE2IuA+X+s87Pxde84F867Gs6dbCifnDxvXgddvH5cXrTqXKlyMBsbLyzh8
         pYXD7TUa7pEF9OGPHRqiNMXyN42xKUgx17G+HAHr4kjx46nuKKpUPFYWCCNQicqBAH0P
         AVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703705770; x=1704310570;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/ThKy08dAX7RrEKVD7KhsQu3ictNFmWXD3vtZ7e4Tg=;
        b=TmmHcbmZTcFvzILZ/QgkMnBanNStcGEPIE+i9b6HCvhUD2nDTQ4icbj+qVtP6RQRTY
         XqmeLKEGGZWor731damgnw+POFP4n0wblIxNNv+IE2aJJbH50wvYFtOGs/JgL5+w8bjl
         JyZVizg4FygE3oe1QTkSqzverdkOtxvW4KHP2X4hMkKkUntGuTV+oK9ZMrgJS0NKso1O
         gg0lfSAvuY2FVqw5+VZVMRNH6ndQrKkhWy/BekmfKpU0jQPvbGcmoIFZ6A3LWNbb4PL3
         4bfjuXDuqqaymxmJNJA8E+x1nVJ36EwpIIia282pPfGVmsdQainiWrxZdRd3dJG7u+S3
         1HtA==
X-Gm-Message-State: AOJu0YzClFGpGr+rZ3tTNvq+OJY5f/KGShHyW70OSj5dE2D4hWFYzWn9
	yMbfiphyCr4m8unYSxtNctrDyABo16AEOj+yg0k=
X-Google-Smtp-Source: AGHT+IEnR5iCTlWA9t9gJQznTmXxFYuyouA6WQsNSewS+Yi7VXzqygHc/8mxfOHC/KHZwphEam/fb6SB0ptK
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:6902:1366:b0:db5:41e9:aa1c with SMTP
 id bt6-20020a056902136600b00db541e9aa1cmr3672945ybb.11.1703705769840; Wed, 27
 Dec 2023 11:36:09 -0800 (PST)
Date: Wed, 27 Dec 2023 19:36:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKV8jGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIyMz3bKyxCLdNMu0NAMDI8PUZAszJaDSgqLUtMwKsDHRsbW1ADPxVEd WAAAA
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703705768; l=2394;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=YYOS+rg4MrrHOITm+EcUL4mypN0hMEPdxC8NbfelIpQ=; b=DiawcQGLgjpTFfTk9TNt560wSfiOIuKafQrpSwZnJDDrCbjM6ID4yqX9ji3LYZPkj+EidFO4B
 SToX4Jb65DlC0tKhWY0JgYIZyAximZIXJVWm0R4iz/Zr6bL5mybcEe5
X-Mailer: b4 0.12.4
Message-ID: <20231227-vvar-v1-1-d2396e789179@google.com>
Subject: [PATCH] x86/vdso: shrink vdso/vma.i via IWYU
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

This change to vdso/vma.c resulted in a preprocessed size of
lib/string.i from 66348 lines to 54596 lines (-19%) for the x86
defconfig.

Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 arch/x86/entry/vdso/vma.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 7645730dc228..fa601437b2c5 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -4,27 +4,32 @@
  *
  * This contains most of the x86 vDSO kernel-side code.
  */
-#include <linux/mm.h>
+#include <linux/bug.h>
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
+#include <linux/elf.h>
+#include <linux/errno.h>
 #include <linux/err.h>
-#include <linux/sched.h>
-#include <linux/sched/task_stack.h>
-#include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/random.h>
-#include <linux/elf.h>
-#include <linux/cpu.h>
+#include <linux/kstrtox.h>
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/mmap_lock.h>
 #include <linux/ptrace.h>
+#include <linux/random.h>
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/stddef.h>
+#include <linux/thread_info.h>
 #include <linux/time_namespace.h>
+#include <linux/types.h>
 
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
-#include <asm/proto.h>
 #include <asm/vdso.h>
 #include <asm/vvar.h>
-#include <asm/tlb.h>
 #include <asm/page.h>
-#include <asm/desc.h>
-#include <asm/cpufeature.h>
+#include <asm/mmu.h>
 #include <clocksource/hyperv_timer.h>
 
 #undef _ASM_X86_VVAR_H
@@ -57,7 +62,6 @@ int __init init_vdso_image(const struct vdso_image *image)
 }
 
 static const struct vm_special_mapping vvar_mapping;
-struct linux_binprm;
 
 static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)

---
base-commit: fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
change-id: 20231226-vvar-f9ff0021ec86

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


