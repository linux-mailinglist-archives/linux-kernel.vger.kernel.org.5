Return-Path: <linux-kernel+bounces-84183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7A486A36B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9C31C25867
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E94457886;
	Tue, 27 Feb 2024 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="w1O03XbF"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04457867
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075686; cv=none; b=nzgq+2EDwue9RRt30u9yf1wWshZtPSYtQytn19zGKGNy7NrTlQ0BhWzrTFDiZi//Ecgwt/J3lpVv4UZboGdga7qbjk1/IsKT9VwO0mpR788gMXVlw/u9y9/fUlSC5tlJqPVOAviNaGMw+mnWlbbMzzGwtRHN6urD2l8zXnkXgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075686; c=relaxed/simple;
	bh=FzR0GpkIwoZRYWxFyEryVlUwRX7agq76vtFdOU7VZ+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6cE1mmQlzd1XBlML8xThrnWLmCg47t3OWvza3k/facTrNXiyHCYGCSsTp5B2Kcro43lbApkZie6fSul/VcJgB8eS7Bx5ALpiyRJxK/ByKaLcKjLwbbCsCO10naG1j1waRidzR43ZhhA+ty5ymZGan9vvXoM/YaI8/mPTJVhGCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=w1O03XbF; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bb9d54575cso3809075b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709075684; x=1709680484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EVtHtZkQ3gl1JI+EwyEBrvg+iHnnWLYEsQB5N3MR4A=;
        b=w1O03XbFtiSXk9gDaVzpnV/Zi299K0dSwlNNXPTkRm9NmBIMJN04TgoCYw9MVhRVBT
         D3Th3WOp62N7CGL3/XRCmUnz+xd6XBkSunhQx7E5ecCSJRWxvv4ANGgR4UaAUYqhw2oy
         CPnCbWakCbaujQHAaDEIfLu9FwbxxCr+ipf4DQ1zTuxb/ww6are/bSpxRoTX9fErpfLE
         8rLvYbP7Kij0pD/N/YIpzfofjM5pJlEYL+xI18BmfBAEZZvOxsyA4Kmq+cgdhjJ+4Y8b
         ZTvzteC+akfaQWAHMULM63zEueZsy2RPjMwUX4TXa+9zjg+5H9YCvdvYUnOUHZuhtXGP
         RGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709075684; x=1709680484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EVtHtZkQ3gl1JI+EwyEBrvg+iHnnWLYEsQB5N3MR4A=;
        b=C4CdTREOLAIgtWFNUiT13rxTLDBUbUS/wQYF8RZ5XN2b8uDlE1/nIJjINRsu3E9vXZ
         FSoE2Bf+jylZGdtve39a6xa4i7G+zwZtXzKuv6AB2H/JLBUci1tGYUAqKgF6dQ7o7VSz
         VZ+5QEaOLRyCy7+EPyHOovwOK/1NzfTsGRWEX9TULVf2EuXOv2aB+/Pbe4gzSUzgR2Yv
         EciUOV+rKtVlbxlrSADTXDWTkULFsMEff+eQrd4GRTyoD9pvsjTNT6a4cxFTlPfbmJK/
         AHZ14ctCEoR4M6vR7p4spEGgfRvJ4bQrKvvJsx0DMZdnJlylh8SoyjpYpJP9IZuCqWsh
         S6ww==
X-Forwarded-Encrypted: i=1; AJvYcCVwT62Z30bNbDVfD3toIGZdXya+2lUoNiatj/V4TG2elRZJ2dn5ZZTvLW858D+IikBqktPuk61KXVqxP2SPqtP1Smjy8uRooXHIY+zS
X-Gm-Message-State: AOJu0Yzhe8BuiND1uf9i8zUN7sOkB/LLE8Poroz50vR4KW4M6NCmOVVF
	PHojVt93cmXxl0t+wokzsp/7i379nNqQm70wNt3k7eimkBW1LV82f3O+yuNK/bY=
X-Google-Smtp-Source: AGHT+IEauNl6WIPyiM20fdRy7YKnnW9sZ9a46d4rbs0aUU30IGxqJuZ//IpFXEdYF60LR7VnmeBLsQ==
X-Received: by 2002:a05:6808:13c9:b0:3c1:7c22:c62c with SMTP id d9-20020a05680813c900b003c17c22c62cmr4524328oiw.40.1709075684262;
        Tue, 27 Feb 2024 15:14:44 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id l9-20020a635709000000b005ce998b9391sm5455645pgb.67.2024.02.27.15.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:14:43 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Feb 2024 15:13:13 -0800
Subject: [PATCH v5 1/2] riscv: lib: Introduce has_fast_unaligned_access
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-disable_misaligned_probe_config-v5-1-b6853846e27a@rivosinc.com>
References: <20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com>
In-Reply-To: <20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709075681; l=3372;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FzR0GpkIwoZRYWxFyEryVlUwRX7agq76vtFdOU7VZ+M=;
 b=5y5R/N2D/Izd61qDhY+QzsoZDbkw4sD+B7NwvE2jC4w/xh3hOu1ij8PyYt+mXFR/AYxl45x0n
 pT8slOgGASxDYjzi7bPNXDa+gv/FdP5MbL/e/2C3zZR8eBhTPoT66Fi
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


