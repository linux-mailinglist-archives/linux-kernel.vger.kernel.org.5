Return-Path: <linux-kernel+bounces-89296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CFC86EDEE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DE8B24385
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DACC79F5;
	Sat,  2 Mar 2024 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gQAD+KNE"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B265CAC
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709343943; cv=none; b=bgmIWkWwp7UcRldJI4cAq1qB/+/zZrofvqX3TOxCRbWW41QUXC6a0sKtU3tmLIxonjWzrsThFAVHYG+KFBvBoI2SaMFXogdaezuLWgN1gKDikm5+ATAyUGDd1ekrILjLXycQr6iC2XoQ/TjJrg0wxAJthiMsLOmE+5cUu/VqTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709343943; c=relaxed/simple;
	bh=FzR0GpkIwoZRYWxFyEryVlUwRX7agq76vtFdOU7VZ+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IrZ0Eut2jcI9mmXwDmeQUma9jhDQD0AlPMPjlSOrvyPYGqY5INMeSDaYZTL5p9t5X4ABkcFVG6tTBV8t7QX1l2KStlhI4F2ZFUTTa8glbJMY0ILhsklgSEIDCcOfs1QV9COB8RwRfZeUkg2cICrIPuWsenf/srVWhtibe47eaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gQAD+KNE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc1ff3ba1aso23309165ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709343941; x=1709948741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EVtHtZkQ3gl1JI+EwyEBrvg+iHnnWLYEsQB5N3MR4A=;
        b=gQAD+KNEyN72R2i8qUXlDiPXK1T4h8PMbtJ6G+je0YEhEHwIt+PYRg/vkbcfB4Vs7r
         mugN3Fnp0PEEglWl4h+g3tQCB8uEGLeYA+7jRapx7QcgcfsDkJDrmEHCQdiH5m6Oq1nu
         WaaWsTzJB4vwH9gCwY06W0bFlcRJf4r4EQeO459Bg00/Kj+DEyqL5Qco7gYMbTPk4W4a
         c4jrLZx4uUYp4jdgvzEf9+RtQklV3hL0uDJciODMyycAI1nX5r9mh+uK199asSQpcWMD
         ONVYFVb5lqO0mRxV1eJdAsuovJfeCYUtRS/e9baSLt/S/9wuC2BOJXHNBdngW0KBL1xd
         XWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709343941; x=1709948741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EVtHtZkQ3gl1JI+EwyEBrvg+iHnnWLYEsQB5N3MR4A=;
        b=ofqqmCmc/ThOgHMmfROfqPBV6IgthPMnI7TvZ0SzRxAaZHOlcVB0PyFViPqssh1WSv
         JhXpUEG7KtpdqtLQ2HXf/yJqC9MidCTiGnSmaZVyYmTiy5Ht0gUXLTrjghzf/vXB2RVE
         j2IUshpCeTl436y0P5agqgK0VEVAtKEB2MHnY9UNE4ffcCMJe1byLAUTCSD8yJtd5CSf
         xNYwYCCxTnxSXEwwHq51D6ZL0X/3BJOD59GGrO4kEnwko0ThyUPUKX87S3iqTD4u/S2i
         9dKR92mgXBTd59xMVHdj4Jfq/ie7tnm6UPVvw2GuHCVHluycti/e6ThRkEXjv3fjLYMS
         P1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiPvtEO2Ua9ihjfgGLwSh4eZ0cdabhY/tlomn34y899Opaspf6UA5uGeP02RjQkBG//mD0LpHRSzUAHKLAIhcOuLSNB7S8HTflEDey
X-Gm-Message-State: AOJu0YzQLHlUyBEnqkjPvYW3ftVbT0SeAfnFNsPloc4S1qtxQ57DuIJo
	CnqUTeeSY0zLBMLFAKT5OAr7TZoli7mlBi0lg3b8O049DmlklYZNGaGsTkfoyYxsHcApV2JZhC3
	K
X-Google-Smtp-Source: AGHT+IEFOA+Mva/UJNgDW5MD4NNeIEjYKDh0h2SpSm1kLIc6+lPYL79pNCt/9xrF9nmKlJSwzwIR8Q==
X-Received: by 2002:a17:902:e841:b0:1dc:c93e:f5f5 with SMTP id t1-20020a170902e84100b001dcc93ef5f5mr4725296plg.12.1709343941118;
        Fri, 01 Mar 2024 17:45:41 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001d71729ec9csm4129039plj.188.2024.03.01.17.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:45:40 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 01 Mar 2024 17:45:32 -0800
Subject: [PATCH v6 1/4] riscv: lib: Introduce has_fast_unaligned_access
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-disable_misaligned_probe_config-v6-1-612ebd69f430@rivosinc.com>
References: <20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com>
In-Reply-To: <20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr <lohr85@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709343937; l=3372;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FzR0GpkIwoZRYWxFyEryVlUwRX7agq76vtFdOU7VZ+M=;
 b=MTe+OzVOyEChCkgWAjVjTKJ1KGldjB3X8XOlTPihrud5sPuCHjpapts64+9B/jDdMiVP4tKOR
 9wf0fy4i0KRBUiNT07bmPtNKyvrHOeVYeniuqlbOHRIcZCWcU6fLy9n
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Create has_fast_unaligned_access to avoid needing to explicitly check
the fast_misaligned_access_speed_key static key.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 11 ++++++++---
 arch/riscv/kernel/cpufeature.c      |  6 +++---
 arch/riscv/lib/csum.c               |  7 ++-----
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 5a626ed2c47a..466e1f591919 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright 2022-2023 Rivos, Inc
+ * Copyright 2022-2024 Rivos, Inc
  */
 
 #ifndef _ASM_CPUFEATURE_H
@@ -53,6 +53,13 @@ static inline bool check_unaligned_access_emulated(int cpu)
 static inline void unaligned_emulation_finish(void) {}
 #endif
 
+DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
+
+static __always_inline bool has_fast_unaligned_accesses(void)
+{
+	return static_branch_likely(&fast_unaligned_access_speed_key);
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
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 89920f84d0a3..7878cddccc0d 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -810,14 +810,14 @@ static void check_unaligned_access_nonboot_cpu(void *param)
 		check_unaligned_access(pages[cpu]);
 }
 
-DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+DEFINE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
 
 static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
 {
 	if (cpumask_weight(mask) == weight)
-		static_branch_enable_cpuslocked(&fast_misaligned_access_speed_key);
+		static_branch_enable_cpuslocked(&fast_unaligned_access_speed_key);
 	else
-		static_branch_disable_cpuslocked(&fast_misaligned_access_speed_key);
+		static_branch_disable_cpuslocked(&fast_unaligned_access_speed_key);
 }
 
 static void set_unaligned_access_static_branches_except_cpu(int cpu)
diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index af3df5274ccb..7178e0acfa22 100644
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
+	if (has_fast_unaligned_accesses() || (((unsigned long)buff & OFFSET_MASK) == 0))
 		return do_csum_no_alignment(buff, len);
 
 	return do_csum_with_alignment(buff, len);

-- 
2.43.2


