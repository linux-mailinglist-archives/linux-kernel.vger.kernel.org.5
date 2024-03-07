Return-Path: <linux-kernel+bounces-96052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3D9875699
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D544A281B83
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE61136664;
	Thu,  7 Mar 2024 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dujvQ+Dx"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995E135A70
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838357; cv=none; b=ILOPiHbg6Jv7wZd7UXEldnMH28zGF7lii9viHFUp720DEBIytmbssoAhY+VQzqUhwbe9mJRy3o5g6BH4t3cl7pshG4s81rguErPrNk9JWXucxQRXaiMjQFfZdZdpe4nLRaRbPEQu0crDvX+rNpY7GS0NJIZfVRkdbY8PFyrCp8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838357; c=relaxed/simple;
	bh=ejS3FVJ1L+bLL4KR96q6ZNDMwke6NlmAthP91enITHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVuGV85IGJZmaWdmecB3Ok8EhAY6qqt+7+fa2PjCev0fjOzfGzP4Hb1kYU97XwGPpVSuKdz0TiSR0O0jnQl/M/Oq4aaS/L2ztvciw0IqJXfagH6Ct5H0qlzTNoqmqBQAPzcVlrTBTJe6sSp6amALRhAaPxx4aOuTjMAzqsBW8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dujvQ+Dx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc139ed11fso17380105ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709838354; x=1710443154; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akMpdDedBfqF60/fNsk+O8npKk5JqF+ySZ0f9xW5/1M=;
        b=dujvQ+DxU34MhBGlPTDIDAFHkrNwj9MtYn0Ax1IeSFCWd3bNyW2JK1Zd+wNfw6HGUu
         bIfkxDeR3jck8obEXRIjHRJiE3hAoZMUU/yaq3RawGkzVXwnY1Lu84AIyInA3WOSBdHu
         8gupKEsg/VUnUOygxFg9npMrpgkIQxNB/5T18Ayg/JK4PTI/ZIEFHeHSj/CNEhOPDMq6
         Iiat10KKEvaXBTYzY4mbcR7ocufh4h/yxfvQCyzNSQI0RE+4VyYwb8lj8duILEtVyh6+
         zcfEXwxZssxOEf/sfoKbFVwqeQN1Cp+uBJFJ1tR8iRXQm+z323AI0fVMSMSRxXcCl+sM
         Rimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838354; x=1710443154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akMpdDedBfqF60/fNsk+O8npKk5JqF+ySZ0f9xW5/1M=;
        b=cLZKRurao/ykEm5rVe7/BC7mEnyOzMEyhGUlteW/ZxPHRkG5isTbL+dZIoBuZtCnJ+
         eucVtG+IePaKyaYbEjbz7vmB18DdAslNDI1IHl4yLvAJyRLtvXmAJ+cDTwnj55dhjSPE
         2q0tTn7WWyPCM1i04hSO8+XAiJ0ycy/zrF7L80TVoqpjA5l1ox7j14sp5uT5tKo4bGcs
         5mgKDiEihK3IaPjv44yozHXm9+lJmOpMEeb1UTBAnCLq5MvqUV8WGdVxFCYS4dYvQnxY
         +C/cpRiOZ2c56aXRjjhOwNU9yzLVDwhZM2GTZR+YNo10em8XMnWA8dYQ+JRcK2S11S+Z
         7FZw==
X-Forwarded-Encrypted: i=1; AJvYcCUJswkDLdQE1Auh7iqpWXvGteLpj2lye8z8Xn4ldfCUOgCNmA8a4QY5Yr+2Tpi7+u7hzQZLfHGMHCHP82d6Xt9bMNEBU+y4FtQ2n55c
X-Gm-Message-State: AOJu0YxxBPVTIGLBGPZRT9VccWEfKDqx0ASg+HwDfdCuC8ktHp3WXy2k
	ZysuuVDbDZiJ5Gdcj+XOFCwI13XTGuwOm6gdxfq3hZKxavmLtU/xJ0+PTdpBR3A=
X-Google-Smtp-Source: AGHT+IGIkFO9XVaeP/1tKPmqCILvLsJZGaZz9P1TWEAdnDzXM5s2KMdvUPij6lw/K5WrTNkXwn1yVg==
X-Received: by 2002:a17:902:fa90:b0:1dc:c161:bce6 with SMTP id lc16-20020a170902fa9000b001dcc161bce6mr2666593plb.15.1709838354594;
        Thu, 07 Mar 2024 11:05:54 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001dd526af36csm1747338plk.295.2024.03.07.11.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:05:53 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 07 Mar 2024 11:05:45 -0800
Subject: [PATCH v8 1/4] riscv: lib: Introduce has_fast_unaligned_access()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-disable_misaligned_probe_config-v8-1-55d696cb398b@rivosinc.com>
References: <20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com>
In-Reply-To: <20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709838351; l=3428;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=ejS3FVJ1L+bLL4KR96q6ZNDMwke6NlmAthP91enITHI=;
 b=QSgWXU48WzSbKsbVl21l4yUMXYbuR79AfVXchsjcwshH/vOtpegFqmabEpCqdScNEvHiGhn1R
 dUTNhTVGbssD6hYxGOAUgt/afIDbNbpK0lhR5laE9KWUauYvQHlnj1x
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Create has_fast_unaligned_access to avoid needing to explicitly check
the fast_misaligned_access_speed_key static key.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Evan Green <evan@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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


