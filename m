Return-Path: <linux-kernel+bounces-16131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDCC82396A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5B5287F00
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14201DFD6;
	Thu,  4 Jan 2024 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gv0Or1Et"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E818E0A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 00:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9dbe1c62so12627276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 16:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704326575; x=1704931375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gj1perHxCj9XWVSejaCMqniNxeCWVEl0QQogffeEti4=;
        b=Gv0Or1EtkEvc6Vame+tNmaiIDDh1rMbLrSyp/RcmC2+ouSGdSJ5MNAxpNmhhR1BSVz
         q7mg8y22bTxxQ8OtuTNOzoCEogHUEa9CPJW91XPTeql08lJj3hBSyt8un5YedhXMf1fn
         hZjc4wn0GV/ogCzLLii3Kh/JK6xJupwpZKatPvg3ybyWgnwZ8TlXZZHbfzwdnEhV9pvC
         zd+lyTp+1Y7l7eVbqLzuF6c/iaHFntWL8DRYTBCWVYbCzrhLiKmMO3le1gQ4dvIg7sob
         hZBe3Y86JEDK+GAJyGSMnpI1gU9ga2cV/qLcBlmg3+GrSgQTD7nt6Mcnvq3UB5PuLSyn
         vIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704326575; x=1704931375;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gj1perHxCj9XWVSejaCMqniNxeCWVEl0QQogffeEti4=;
        b=tBw/DTbIO1aoSZwOpl8p/3woOSi0/40ZnBi/e5NNYAsi03ct856vHEdplGMRJP8MsW
         BdKIYVnmOUPDsmGLXXI6v4fkeMyaL3NPK98qYuui7lrJm3Ds2M1QInBNulDuP9tQ444M
         HSs13Bba2YWOu7htE5cpOheI+v4mzabM+DpLnC+ZKF9l05CLLADsyAo5chapU999p0cX
         pr/ewo3DU7OLrvhzrYYQpKDHbhV3weKlE8QAP2Ej9X4hApL7plsqsFcmmp/YV9ReYNpK
         jwEaAkcEm7Pwx0J40psbj7rHE7W4nTam9xTfAurG9MLitLbFG4X8po+wThxYvSer8LdZ
         i8MQ==
X-Gm-Message-State: AOJu0Yzmo2ufYEe9gXYDzfM6KXWq/v+PtoP78R+2LRhXx59aAQ2GOrAC
	554/RSDyyTDQ/69NXqYaxr9m2Q0ciNA1eSGb0l4=
X-Google-Smtp-Source: AGHT+IG5Nhz7Az572xVTvuubaJM26hrOAzEw0wT0vR5fwWihxB5UhmHz367tQpbHWeVQ1InNfr/d8V1Yljpv
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a25:7802:0:b0:dbe:5e4f:4d37 with SMTP id
 t2-20020a257802000000b00dbe5e4f4d37mr373536ybc.9.1704326574925; Wed, 03 Jan
 2024 16:02:54 -0800 (PST)
Date: Thu, 04 Jan 2024 00:02:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ/1lWUC/2WOQQrCMBBFr1JmbSSZxBJdeQ9xkaTTNlAbSUqol
 N7dtCAiLt9n3mMWSBQ9JbhUC0TKPvkwFsBDBa43Y0fMN4UBOUqBqBnNk7EDMaFbfj4RN2QNlOt
 npNbPe+l2L9z7NIX42sNZbOt/IwsmmEQjtKtrqxS/diF0Ax1deMAWyfgRFRdcfkUsIilr0cnyh m5+xHVd32fra87YAAAA
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704326573; l=1653;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=rmUPiVwkGCODq3/egSGtwu26EPITUG/LNDaJAgdewWU=; b=Ka49qwIXxJ3rMTect0iqGLS/61gkeZRZtx96d59gKHh3FN7KktncXEfpZuIKeJMJ1/WLyt9pz
 8hsjiTyt+vsBLE9MPgHDjMAFU44nbPOCf7A3jIOdb3F7bgdviq5z8rU
X-Mailer: b4 0.12.4
Message-ID: <20240104-extable-v2-1-6fdcb64abcb2@google.com>
Subject: [PATCH v2] x86/vdso: shrink vdso/extable.i via IWYU
From: Tanzir Hasan <tanzirh@google.com>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Nick Desaulniers <nnn@google.com>, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"

This diff uses an open source tool include-what-you-use (IWYU) to modify
the include list, changing indirect includes to direct includes. IWYU is
implemented using the IWYUScripts github repository which is a tool that
is currently undergoing development. These changes seek to improve build
times.

This change to vdso/extable.c resulted in a preprocessed size of
vdso/extable.i from 64332 lines to 25563 lines (-61%) for the x86
defconfig.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
Changes in v2:
- Removed struct forward declaration
- Removed linux/mm for a more aggressive cut
- Link to v1: https://lore.kernel.org/r/20231228-extable-v1-1-32a18c66b440@google.com
---
 arch/x86/entry/vdso/extable.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/extable.c b/arch/x86/entry/vdso/extable.c
index afcf5b65beef..85e3babdd976 100644
--- a/arch/x86/entry/vdso/extable.c
+++ b/arch/x86/entry/vdso/extable.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/err.h>
-#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/sched.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
 #include <asm/current.h>
-#include <asm/traps.h>
+#include <asm/ptrace.h>
+#include <asm/trapnr.h>
 #include <asm/vdso.h>
 
 struct vdso_exception_table_entry {

---
base-commit: f5837722ffecbbedf1b1dbab072a063565f0dad1
change-id: 20231228-extable-18f095e0aeba

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


