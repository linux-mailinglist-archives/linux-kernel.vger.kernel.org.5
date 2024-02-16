Return-Path: <linux-kernel+bounces-69314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A235858724
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB2C1C250A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D2B150998;
	Fri, 16 Feb 2024 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YVIPWyKN"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A649614E2F5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115611; cv=none; b=Qa12Vf/kMeSF9943pXSd4p7mH5Op2R4QUTsx3mNrDrbvYbsVxBEofjsG0N/EQ7ap1h+gBfvj0hO/Xixsdm5ouMPLcASCcMYoUzY4xiz6+nNIgB7jKIkIb16SatUmRVcozvMYImlgZfItkVoEYG2ueuW4qxmopa2PFPZK5F2f8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115611; c=relaxed/simple;
	bh=T8LMOzu9nHFuhW9wH9M9lyPtW0uvmulpUpoeoDk93nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jkMEjbpS0Yazkjdrk/Ee2VdsCFOEd76AVaMtPzWloh7XwGXbD9Xq0QsbebmG66v1ElgvQP0gBPOC+9nTYWJE6k8K9uswNk/sL/TRTmL+bRjIHpwYPZyuCA4V6nId9EHBMGs63WZFCLthjbsRyrLojQo8gij2x2ZNWB8N3uq0Yfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YVIPWyKN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso1689967b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708115608; x=1708720408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Zm8eYFzkCy2fo8YTnXRxd26L7cmwWO4QztMTfO2g44=;
        b=YVIPWyKNH/yv0q2Wzs1bQY/uU0afe4THM76hliu5A516OA/5PYhthrzlkpfS8rks8z
         PoNPVVxtJwDLJwDFCr2THrAfs79bxaY0l5hpxAOqD6BKoIChXZ048XiPTKcwO23jGNPH
         AOdY1vzXLuHK4/Yg73/OfdNLU1j3GnB7mYX/acMUbkVTiYjxCjTsr171lCaFFHton14q
         VOQyIVkHSY3O6yMoLIzECGEOYfDS4DgOdk4YA2OPAKxNA6puZ799A5oOULJAyxc1yNnP
         XDeoOqG/5nYcrTBnh915YhZyWM/KWP5c/Vp8Ta29FIlBVESb5R/ZUF7+SbStpHsip492
         8hAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115608; x=1708720408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Zm8eYFzkCy2fo8YTnXRxd26L7cmwWO4QztMTfO2g44=;
        b=ohbZqxmL1M81NYw1WR0HZY+ZUMn76f/sS9VapuDca0Xp2QnqsAd5mJCNEjZ/FI18gY
         jxt9jOYBjI4hEVN5u/PZvRffOFXi+V7tplwHR86m0hfXBB88rK6dYb9fjj5ecUwTPjB/
         6LF+3YiKiH+VNOSqfH7XYnmC4LBhe5XkKkpCKaoIyye4+y/cDQ9Ptu4DuT91vxnlMdUb
         asmeZ0U0jl60NBirHGhED1W6Y3XZml0zQuu08g5CdxTgmoDovbjJLuDyqQtF+WxPH5IW
         wgmaeVK2D2ueNF8ZyZWjnSV1o6D8eoN2qcanOBpPvRhqVe5VpWHCmIe8oex0uLCjV4iq
         BPDw==
X-Forwarded-Encrypted: i=1; AJvYcCXvzTq4/+BrLeEoI/S0IuAEaPSl6RH/jgIT6CaIhxZapHkDGyvfrLVGScaBDAA5cL2qKYXeFTUOYpYcvxMa3kQ89uYImtSgegVe8R1t
X-Gm-Message-State: AOJu0YxgzLHeiJ1bmpWQOmctSduXvqT4V8B3adTPcpLNm/vZvjLXvTdK
	znCaI2frq2zofwpJxT55Ulatzh/XY9Qi5Ao8zz/+s1FY682gsgOG767cLZY5iHPrwB7eDEAm1Qe
	6
X-Google-Smtp-Source: AGHT+IEE+9Rd2cRZiKFG//TBC6A5MVnz4PILwOrfl9W9HSLIQgriikVS1s20Act5uHkKuWl8Niuu8A==
X-Received: by 2002:a05:6a00:2190:b0:6dd:839a:b070 with SMTP id h16-20020a056a00219000b006dd839ab070mr7424707pfi.34.1708115607225;
        Fri, 16 Feb 2024 12:33:27 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id s32-20020a056a0017a000b006e091489776sm369918pfg.92.2024.02.16.12.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:26 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 16 Feb 2024 12:33:18 -0800
Subject: [PATCH v4 1/2] riscv: lib: Introduce has_fast_misaligned_access
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-disable_misaligned_probe_config-v4-1-dc01e581c0ac@rivosinc.com>
References: <20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com>
In-Reply-To: <20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr <lohr85@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708115604; l=2683;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=T8LMOzu9nHFuhW9wH9M9lyPtW0uvmulpUpoeoDk93nw=;
 b=7Z+H3hr0K9ilHDGmJqtDgek8qNy9Awetiw6Ny/gJ+In8L9mHa7UCmYXxVvrHClWXiNWwcuPXb
 K1XoWmZBrhWC+w962RzV4XLb4sUNyxBe846G8yUAdaQFcIBdIZcGO1j
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Create has_fast_misaligned_access to avoid needing to explicitly check
the fast_misaligned_access_speed_key static key.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 15 ++++++++++-----
 arch/riscv/lib/csum.c               |  7 ++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 5a626ed2c47a..eb3ac304fc42 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright 2022-2023 Rivos, Inc
+ * Copyright 2022-2024 Rivos, Inc
  */
 
 #ifndef _ASM_CPUFEATURE_H
@@ -28,8 +28,6 @@ struct riscv_isainfo {
 
 DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
-DECLARE_PER_CPU(long, misaligned_access_speed);
-
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
@@ -53,6 +51,15 @@ static inline bool check_unaligned_access_emulated(int cpu)
 static inline void unaligned_emulation_finish(void) {}
 #endif
 
+DECLARE_PER_CPU(long, misaligned_access_speed);
+
+DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
+static __always_inline bool has_fast_misaligned_accesses(void)
+{
+	return static_branch_likely(&fast_misaligned_access_speed_key);
+}
+
 unsigned long riscv_get_elf_hwcap(void);
 
 struct riscv_isa_ext_data {
@@ -135,6 +142,4 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
-DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
-
 #endif
diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index af3df5274ccb..47392a83239d 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -3,7 +3,7 @@
  * Checksum library
  *
  * Influenced by arch/arm64/lib/csum.c
- * Copyright (C) 2023 Rivos Inc.
+ * Copyright (C) 2023-2024 Rivos Inc.
  */
 #include <linux/bitops.h>
 #include <linux/compiler.h>
@@ -318,10 +318,7 @@ unsigned int do_csum(const unsigned char *buff, int len)
 	 * branches. The largest chunk of overlap was delegated into the
 	 * do_csum_common function.
 	 */
-	if (static_branch_likely(&fast_misaligned_access_speed_key))
-		return do_csum_no_alignment(buff, len);
-
-	if (((unsigned long)buff & OFFSET_MASK) == 0)
+	if (has_fast_misaligned_accesses() || (((unsigned long)buff & OFFSET_MASK) == 0))
 		return do_csum_no_alignment(buff, len);
 
 	return do_csum_with_alignment(buff, len);

-- 
2.43.0


