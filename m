Return-Path: <linux-kernel+bounces-16972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D37EC8246A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814DE287C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA4B2555F;
	Thu,  4 Jan 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nB7EuRVq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAA12555A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6d9b09d1afaso754713b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 08:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704387082; x=1704991882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jm03zStryCFTp1W2rKj9MdI+DmDreeqJY40intfiH2Q=;
        b=nB7EuRVq2En87atEXYwjtB50SMO6hPyAs1aAcHACN3UPIhPTKKtv3V15XveEux5WlV
         unDvcOHpYEz5GUCPYAKuo1CxPLyY1TW/Vv9YyLgb9BDGC8JWCqxI8uS9dzQo/vA7rKlq
         MmDrVb7uH82PCTYLD9rPDdZEgY4l2j/e+DN9F5UuzCR0V37mbj3Uxy6wN6y7z6TZs3Jl
         4TfDDgNyqUEgsnEetIdwPWPAKjS9sY1Bkko5IfswQ1EMcbhgDg30ZxSJiERELU6LoBon
         OmvVDS2aNyKE6iGlHEiElhMPi5qMmQj2CqGsWIBntKeUqPsARNMwVy5y9+09e+vlIsme
         8u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704387082; x=1704991882;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jm03zStryCFTp1W2rKj9MdI+DmDreeqJY40intfiH2Q=;
        b=H606IrdKr3P7U+bNODhTK1AzDSpqiAuer1hCF7RmW0/tLsahUlhuH/WphcRwfh8mC5
         HNfv7FSuIuz622edAz7E9cySga7eNnq8vjAAxZz2+PWybq2tSr2lg4gD1nJ558m+JrY0
         0qUxqqhRaDlUS+g00JxYAYTpOJmdSJUAt7b2qhoCIEZO1ibz0g0Tj8ql1bDI8t3Wz/jg
         dMb4Ds1ChmE/vgX8udZ1lwUJt+nep35dxWiDTjkoBLaVIPvQRjiW5FPf3VKWcEPzV6n6
         fFdAA7U9jvqoZVPWi4OHyhCmiElgABelMyHxLY0grp2KN0T6ROok1VUBHI8Ri87UUp/0
         UX2Q==
X-Gm-Message-State: AOJu0Yzq+75Hd2MAn+AsgsKsIbH03OoKOG8zb+MMU90ZYZFL1ncJ1l8/
	f/2T4TNcJFk9SkgIuQkLTZb2zPRZBckPU2T+Qo4=
X-Google-Smtp-Source: AGHT+IHaq2tg9b+ZSO+41GnmDPjqzlyQxaLNcF9d++BmwHPOhBLGk84toxeuB2SWrpX1CA345pLKx6XrRDCl
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:6a00:2ea2:b0:6da:b304:fa80 with SMTP
 id fd34-20020a056a002ea200b006dab304fa80mr132704pfb.1.1704387082616; Thu, 04
 Jan 2024 08:51:22 -0800 (PST)
Date: Thu, 04 Jan 2024 16:51:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAATilmUC/x3MMQqAMAxA0auUzBZqAkW8ijiIjZqlLY0WQby7x
 fEN/z+gXIQVRvNA4SoqKTb0nYH1WOLOVkIzoEPqEQdbgyZC5fPKdmAiH7xbVmJoRS68yf3fpvl 9P66RotFdAAAA
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704387081; l=1392;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=/is5lhdNZtXktnfZ5VlFm0ZvdtEPTHkgA5XkZmmhysM=; b=iocZG2VYIQi9pT+WrIYNtkWlPJx6vb67gLVU7l5KtypTYg1iQfFKqA/K87tuYo9CS80S5Lwbx
 Vo6HkYnNEUaCiAaulfoPXJTSI/P6MraqIZfyDbPPE6M0vyta/gOcI9w
X-Mailer: b4 0.12.4
Message-ID: <20240104-vdso32setup-v1-1-1737147bc6ed@google.com>
Subject: [PATCH] x86/vdso: shrink vdso/vdso32-setup.i via IWYU
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

This change to vdso/vdso32-setup.c resulted in a preprocessed size of
vdso/vdso32-setup.i from 44009 lines to 18572 lines (-58%) for the x86
defconfig.

---


Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 arch/x86/entry/vdso/vdso32-setup.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index 76e4e74f35b5..8dbe022589a6 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -8,13 +8,11 @@
  */
 
 #include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/kernel.h>
-#include <linux/mm_types.h>
-#include <linux/elf.h>
+#include <linux/kstrtox.h>
+#include <linux/printk.h>
+#include <linux/stddef.h>
 
-#include <asm/processor.h>
-#include <asm/vdso.h>
+#include <asm/cache.h>
 
 #ifdef CONFIG_COMPAT_VDSO
 #define VDSO_DEFAULT	0

---
base-commit: f5837722ffecbbedf1b1dbab072a063565f0dad1
change-id: 20231228-vdso32setup-8e336d60ac3e

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


