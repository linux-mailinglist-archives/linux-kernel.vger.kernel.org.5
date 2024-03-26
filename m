Return-Path: <linux-kernel+bounces-118904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D388C0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4571C3CCBA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44DA5810C;
	Tue, 26 Mar 2024 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pTGGxrBD"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3E454911
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453118; cv=none; b=QLDtFmRrTmMhghuLpMSUGErGxGNtzWxPIPOwMGMmzT0OcCe6buxUaEtdos8M+E72Ysdh4UtUILWpyD5fJRCI5/NjZtgdRlkoWODmv+vDUglxG06XsnAplJH4th/FPHFVOr9c9Dy/QNrX3X2sJr9Gujh8M1MeWQkElk+vAcySedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453118; c=relaxed/simple;
	bh=wOm4Q/tKXJuhEmsv3n8GubKMk0nO5wQwHzwUQUGlcL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jh5yP83Z2S5HLr3grq1uvTYP5M9VimaPd47afODn/Bx7uk91pWYhYTb8I53m4HAkMCeA58kS7y0JzmA+1pQhkSOn6pff9kfINNyxe0v/g3ZvNAXspL2m3wnxFK2iHrIthMVjP46TlcqSsLwKZcrveWcKcoJcctZ0EXFTcD/VIvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pTGGxrBD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4148c2a3a3fso8653135e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711453113; x=1712057913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B4DQoBiWf/BkzkccPmSjgU6K6Hqbqo4RwUCXEAIRgf4=;
        b=pTGGxrBDT9jSNrgUBbuMOclGUTKbZI8hI98eeBS9Q6dxPBqj2kQxiyiLAiRI7Gj5Oa
         eqT4NZx6Lbuh8wOvIdEb3qmaoPxFwtho8rQpFGU8j8bjdFOomnUe7lqtoO0lmjDeZh/X
         vmvPVDSK8rjY8pl/x581suBXMz2K/YsG1laMy7sNjKa/ZUd/mi9+fmtTf17OTjzaQgJM
         B8Oq0m6sjA6MmInbqv1dqAglJWpKVKUkMQqFihnofhWA4RoUn/09QIbP9ZRtLy1V/81W
         pZUIW1ZolbiYFvRwr9BPk/JiKP7r1UEinuu6fcmqJsu/kXSQtr7wqyDw1PIpQMc0tTwB
         Wa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711453113; x=1712057913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4DQoBiWf/BkzkccPmSjgU6K6Hqbqo4RwUCXEAIRgf4=;
        b=bouJ15XX6oXs29jD91YfyCQj6qiZg+No0gcfcx+tBgjtdI0+FBOoMvYqNPlW4ply3k
         gV1iDEziLvSdWEDJlp5uo6RnfEP4dEaCC2w3+1Xj1rCGeQl3OxEFkCdNuPQ8ICKGsa4Z
         Nf/T7Xn8p1vcwx9mkVHEDFtBp794K/7wiCR9ZFzLEl6Cu2G7UJR7tHUcL4gHQniIlVw6
         OjHUuw0AYK0ZGIlX5O0Ikyjlum3+0GeLxw+EQzedod+uBh2MbdwvrvBbrO5hsxNH6qyv
         rByoxCO5Yx0vYZ1Gl67zA6TGjE8OPqiRIxF8cDl2cYja9scPH+Rk1KaiCYyic6rPrBSV
         ImFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYjQLb1YFfKv4bPFPsGvXiqoOiyu6fVVpdxOqxiQVbjAxVdmSxlaveW9gVA1OXAHqMdFDUe7ntQ++CjGfGu/CnKz1aMXLAVUmXiYXK
X-Gm-Message-State: AOJu0YyxEM1TXoMcru6wBFHAkcPeaASFWCOWvv9W650lssCBVoNfy/TK
	H/r/1bZ2Qh6Qc14lbVZz0WqLpkLajkp3142h2KCyrXeFZt80hXLhcwL1TMHMO4s=
X-Google-Smtp-Source: AGHT+IHIA4FG4O7jwVP+ONy4VLO/b2zyf1K6Fncbj3wE/pKbtfVJFeYSYeSda8MGMT9Kbbyf0H9Y3Q==
X-Received: by 2002:a05:600c:1987:b0:414:8675:513a with SMTP id t7-20020a05600c198700b004148675513amr4673999wmq.16.1711453113422;
        Tue, 26 Mar 2024 04:38:33 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id je14-20020a05600c1f8e00b00414688af147sm11319966wmb.20.2024.03.26.04.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 04:38:33 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Vladimir Isaev <vladimir.isaev@syntacore.com>,
	Roman Artemev <roman.artemev@syntacore.com>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Check that vdso does not contain any dynamic relocations
Date: Tue, 26 Mar 2024 12:38:31 +0100
Message-Id: <20240326113831.283025-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other architectures, use the common cmd_vdso_check to make sure of
that.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/vdso/Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 9b517fe1b8a8..dd4877f25928 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -49,7 +49,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
 
 # link rule for the .so file, .lds has to be first
 $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
-	$(call if_changed,vdsold)
+	$(call if_changed,vdsold_and_check)
 LDFLAGS_vdso.so.dbg = -shared -S -soname=linux-vdso.so.1 \
 	--build-id=sha1 --hash-style=both --eh-frame-hdr
 
@@ -69,7 +69,8 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 # actual build commands
 # The DSO images are built using a special linker script
 # Make sure only to export the intended __vdso_xxx symbol offsets.
-quiet_cmd_vdsold = VDSOLD  $@
-      cmd_vdsold = $(LD) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
+quiet_cmd_vdsold_and_check = VDSOLD  $@
+      cmd_vdsold_and_check = $(LD) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
                    $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
-                   rm $@.tmp
+                   rm $@.tmp && \
+                   $(cmd_vdso_check)
-- 
2.39.2


