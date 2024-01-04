Return-Path: <linux-kernel+bounces-17205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 335568249C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 634E5B21619
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4974921A02;
	Thu,  4 Jan 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+g0e3Kf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2891E519
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tanzirh.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe868fdc33so1339037276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 12:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704401193; x=1705005993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NITyRopo7Y40R0nr2zp14Z4yBh/ruIkhsiCAnP45ZGU=;
        b=E+g0e3Kf3CHRsdvrDTzWd+4pXvLyIytjaBSHZcQ1e8gsJ+1GSpWbPrcmRhts3IrS8U
         drBD4elU3sDuDp2mx8fzgaXloJmjvhqPl0RbFJbj3oBQ+MqRvAx6RrJ/4GPM9u1qEsv6
         7BTOPlK42eo8nJfP5BMPjYhZRQsK90SyaCdBvLbe/4xiIemGWbcCXHfjpunF19DrVRA7
         CN0sLdFSXKvXZGLe5s2VRqBxPRV84RToT0xfjMTr8Yog+NRezKZYSnHxRH3Ypy8qcall
         dq8hwGIndM7y2glzValJnRz0PcHMIpU43f96nBZRmrjGyAShNpJO9h9UVdJ5/EuKmNfR
         4Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704401193; x=1705005993;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NITyRopo7Y40R0nr2zp14Z4yBh/ruIkhsiCAnP45ZGU=;
        b=Q8HMQuTu+twVJGJgbBdLD+c1mwIxfEv3WrRVkNqZmZpmOGBLp90iPNk6EaSFNqPOYF
         rZ7jwPlrnlAazddc0xG8omA5cD67Yk95WXTI9LaC5S/kruTzfVluPfDR4wVRFzXo58ic
         MiYWEYmV3RUn4ihOTxkOmeOpWuYh+4LpsBSdLxmpRILqTZUVHeJLYh4GkGDW1Kw2rlr4
         f9llmoR0bq9AUYl0sUMIIjv3W1HTWK6AKhro6nUyaurSNGe4TLungMOxW0F2S8Q8+Ktm
         9HtXPxXvRT+/AxZ7OkRibIhORK24DyFGDEp/nNgMdSZ1rAbti76Gojmqe/lnDiHLxyjq
         75AA==
X-Gm-Message-State: AOJu0YwgWibvY/GJUYD5ueBHqBOFep57S9m72wKpq0hwHyi1N8Ftnn0M
	iX/izSC9MZPFNEn6SDImD3Hdrww2CXhHt8yfGvw=
X-Google-Smtp-Source: AGHT+IHyj3cs/mQrHZHDmEifEqt9bLnp96wGHVW7I5WH1p32gaRvIKRMS8w4XGG260gOKc4E21xYWY4grkzI
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a05:6902:546:b0:dbc:fb31:e5f with SMTP id
 z6-20020a056902054600b00dbcfb310e5fmr411831ybs.10.1704401193179; Thu, 04 Jan
 2024 12:46:33 -0800 (PST)
Date: Thu, 04 Jan 2024 20:46:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACAZl2UC/32Myw6CMBBFf4XM2pp2Wstj5X8YF9gO0EQpabHRE
 P7dwo6Nuatzk3MWiBQcRWiKBQIlF50fM+CpADO0Y0/M2cyAHKVArFiy0UuMNL8nVpGU2mreGkm
 QjSlQ5z577XbPPLg4+/Dd40ls79ZRXHB16CTB8kpZClU+jCZ77b3vn3Q2/gVbKOEfGbOMWF90T bUx2B3kdV1//pZjYuQAAAA=
X-Developer-Key: i=tanzirh@google.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704401191; l=1644;
 i=tanzirh@google.com; s=20231204; h=from:subject:message-id;
 bh=7gCna5XwQbAFpgNexqiBSU+7+4EeGk2SxjmCUATV/rE=; b=NuA2qbiKKgnq5hkUjtMHwg9dQ1/QrVpNQyJKgpIvw/HK3nEPgfoGDgnXtd9qz3UybHC+BJjo/
 0ndy/OD6qBxD8cUZskqQjprqrxmCm78UWqwHR2xo3UmjS5jP+wqu45g
X-Mailer: b4 0.12.4
Message-ID: <20240104-vdso32setup-v2-1-dc9b76c7d06f@google.com>
Subject: [PATCH v2] x86/vdso: shrink vdso/vdso32-setup.i via IWYU
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

This change to vdso/vdso32-setup.c resulted in a preprocessed size of
vdso/vdso32-setup.i from 44009 lines to 18572 lines (-58%) for the x86
defconfig.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---
Changes in v2:
- Fixed messed up signed-off-by tag
- Link to v1: https://lore.kernel.org/r/20240104-vdso32setup-v1-1-1737147bc6ed@google.com
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


