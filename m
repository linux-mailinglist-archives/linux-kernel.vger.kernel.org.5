Return-Path: <linux-kernel+bounces-12858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E916581FB42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA13285E09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1660107BB;
	Thu, 28 Dec 2023 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w1sBAIFd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFB710787
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6d9b082bb80so4965965b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703796997; x=1704401797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t78hDBrUy2r/v4jKJBjn31weh0NRCJxOqGE4NBHPluI=;
        b=w1sBAIFdwJrNyBUxKWmubxn7zTWWgDNnoVO8C59AA3AmGQTbOrT/nUKIl2XNjbSPLm
         uyq8zueLsATzEj3gI5oAgGryStoLljL0uhjcu+iniptc9jW+owH1hg2XEgzjPEqvRah8
         vNoeAaGrHlKVNmsYlXaMYGvtaAAFXYREzeHWoN9dcyEWi+1BX0Uvivcug3x1WTmZgohc
         1oW+Krt3DlXNKpJJLzmdt+N7LvzgnWMgkf9yFYtBLthZ/FtP0JED4NMBPP7K0Wwx4HMS
         /D0id/h1ixCmcehD+hzq+9HU3sxsHPXBfxHXcA4SF2QPGaK9NpKZJn/LuQMSnI7W5Y5y
         Fi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703796997; x=1704401797;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t78hDBrUy2r/v4jKJBjn31weh0NRCJxOqGE4NBHPluI=;
        b=Z89nbpnq2uHpeiVAEGnIfMfUGPTqdCeEa+7uv2v4EiaegHZgnZkvcxOtypuas/HIy0
         mAYDYZ6JNmf5mz4BU18akkoFkfT/8ka72H4VTRaj080lEicQQEODBDb7f+yOMCCfj9HO
         yE+wQBU4I0ADkyFcyu4DeKTW93R0R6WpzGQwv33qGyNf5hueUkv+lsxWPeZQjp/UCZKX
         9dQkVoOiK5Bq5te7npwRDybhowQd7/XQuK2qMGVDiGz1cNNXfm3pTGtyAYfHgiRmXM4d
         gEMKJiXsRKxaqZErx4bcAz6AnagD2Ss0YGM6AYspbFOJXYjfbrE6A9JdLl6gf71/e2Qv
         WsOg==
X-Gm-Message-State: AOJu0YzAQ54D6C8xgNoyrozoQYlu0hVVR+Ev0J+X0Z+xBAOQRjoR/iuk
	hBZs2PihwYbA5g0pwvBzvBseTPaCV+1maO6iyYc=
X-Google-Smtp-Source: AGHT+IGiO0t4snAjRG1yLuyS5d/NOaZO8at8Abzneb1Hg2bheA9CKjAERnPAP6Zpoa1kFQT/Fi3/5qOQwzM0
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a62:6386:0:b0:6d9:8a94:e0d with SMTP id
 x128-20020a626386000000b006d98a940e0dmr474300pfb.5.1703796997142; Thu, 28 Dec
 2023 12:56:37 -0800 (PST)
Date: Thu, 28 Dec 2023 20:56:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAALhjWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIyML3dSKksSknFRdQ4s0A0vTVIPE1KREJaDqgqLUtMwKsEnRsbW1ALZ mBnlZAAAA
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703796995; l=1334;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=qhMqheLdJU1VM1OLVkQtPBRBCwKZDC1Q/0SWaAx4u+0=; b=BD9Q3nkFn2wtF6zpV3w01mM4zCm8MM5HRaJxDkY7ofpa9hym+GTTKAk+DFyIE37NSEEV5BOyj
 30PZnIux5Y4DuYgV8D/apJ7zr4daOa63euP1TMUKZcHzx2qpUD04QN6
X-Mailer: b4 0.12.4
Message-ID: <20231228-extable-v1-1-32a18c66b440@google.com>
Subject: [PATCH] x86/vdso: shrink vdso/extable.i via IWYU
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

This change to vdso/extable.c resulted in a preprocessed size of
vdso/extable.i from 64332 lines to 45377 lines (-27%) for the x86
defconfig.

Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
 arch/x86/entry/vdso/extable.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/extable.c b/arch/x86/entry/vdso/extable.c
index afcf5b65beef..8221231917ec 100644
--- a/arch/x86/entry/vdso/extable.c
+++ b/arch/x86/entry/vdso/extable.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/err.h>
 #include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 #include <asm/current.h>
-#include <asm/traps.h>
+#include <asm/trapnr.h>
 #include <asm/vdso.h>
 
+struct pt_regs;
+
 struct vdso_exception_table_entry {
 	int insn, fixup;
 };

---
base-commit: f5837722ffecbbedf1b1dbab072a063565f0dad1
change-id: 20231228-extable-18f095e0aeba

Best regards,
-- 
Tanzir Hasan <tanzirh@google.com>


