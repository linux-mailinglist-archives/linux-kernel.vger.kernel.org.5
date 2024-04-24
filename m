Return-Path: <linux-kernel+bounces-157304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CAC8B0F93
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02A271C21E93
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66237161B7C;
	Wed, 24 Apr 2024 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="V6PWYMPf"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273FE15F406
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975733; cv=none; b=o3SRqW8oMjALb8Fkllp/oFyJjF7GNMWGvvsBDPSesE1oFmPDpa99tCWZmVurcjGh8hCT6qrwaRUMaB1Ax/s81xu4oe8zIgIrdcPoOIoocar6o9HL/b6dnL3GRNPNxawKaYVs1MC/tZhAiUfJRTBC4eHD3wwbaXqR2Za7J7iFwsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975733; c=relaxed/simple;
	bh=PYZfCtA79Xr5VNJKr9n7fy84USLuN54khgYv4wgcjQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLEecmOWsKF6lICfE2k2Y6O7B7CPY8J3+hnqVI7d7Dx9/4GhD0S/3zpdkZFGlBYvxtjhE2nAlir2wRXJuPnXF9AdWHtEQgSfR7zpeq2lVaJnLDWdUR1GFAIk8DqDkiWstLkFIUmgpD4FpmJZCvtgaVj76KjaGGuNDfC3VAghE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=V6PWYMPf; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a2e5d86254so861794a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713975731; x=1714580531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BENOyooeW2luxuF+LXOR9WbhBmtYhQIWC+pDPXsnnYI=;
        b=V6PWYMPfNH46EZidfUSbFHaXPTtOxx9BQsJvUUtj2QqBQjSlNac8dDyMoi63EuoBCQ
         wWDgCR0KO/3aT8XWKocm4Ls7XAx5g5RO/kGwlqE+fOhn1dXPrhj6303APj7qW0jRuAY7
         qEGwdibDAtPaSsgirxR5yFJRQ/QfSSHXRLQIAwJG9wSbN5vlumZ3EAX7lx+YDBQRMJzU
         40HxWudl+JM9vUHd+Ki2T0W7U+Ef1QNKnuLqTFBS3YfDzIONN+YXxEc+f0XfnOvoKkTP
         ysiu5wWsh+fLgZixPs91LS/DlrCh5eN4O6bcA1bWgP9EzNSN60zW7n//pLUjCeelBtJ8
         t3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975731; x=1714580531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BENOyooeW2luxuF+LXOR9WbhBmtYhQIWC+pDPXsnnYI=;
        b=wr0rG2xeZswY4B+APmWUf1qO7eJci2XjwgT0hMiWQcc5NFwTu9Gl07rQEsrVC3L6J+
         GGE77QXuKioTUuqPnb16wtO75Ey3P+d3oR9PNePWI6S+B/TXhsRk+LhEIxZilC/kUtPn
         4JE8nEwtFl8dsxPie6gla1kkSuRZemgzUxlAp1LAn7tQ5yb+uuwJETigaisxBIF19sGy
         x0suhO5kbTO2TPuSPDoWF/tLvTiobEGanLnesd3p1WetPli5Q4FAd0Bl/va3H7FiZv0x
         CfKRrLTSG8Gj9FO9prqHEBpi3hWjXEIP4H67GqlqxR8ZPSLNRUhZAMOy0sNn8Va/YbY7
         iJsw==
X-Forwarded-Encrypted: i=1; AJvYcCUKY0TlYd7uAPT/wECJMUWGoPCEhSfJN+lVzS6MZoHZxCdJol7Gl9IdlNBXWpqmQlrEB/sHoPdoqeCSu0fjMEeDWDKEMaePWcicvguo
X-Gm-Message-State: AOJu0Yz8eXjAtvbVJ+JaGfGnvF26v5Om+nvEVOUTdYRecP5nuKFqQp0l
	2V6TW+f9uM4hTdxX7aUj1IbCeB0LeuFcFaVuFVI8v3aYVb67Kz8AmXNSY1GsuEs=
X-Google-Smtp-Source: AGHT+IFy51HOVhIEM/eh7Cd29tDH1zvQ+lgJJc8nhhzkP5ryuB0/Bp+pR3o8++W2DQQ5jXJSvvIjwg==
X-Received: by 2002:a17:90b:3bd0:b0:2af:9d00:e84b with SMTP id ph16-20020a17090b3bd000b002af9d00e84bmr211653pjb.15.1713975731422;
        Wed, 24 Apr 2024 09:22:11 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090a1c0800b002a610ef880bsm14505760pjs.6.2024.04.24.09.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:22:10 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Apr 2024 09:19:54 -0700
Subject: [PATCH 1/2] riscv: cpufeature: Fix thead vector hwcap removal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-cpufeature_fixes-v1-1-585e73d2226b@rivosinc.com>
References: <20240424-cpufeature_fixes-v1-0-585e73d2226b@rivosinc.com>
In-Reply-To: <20240424-cpufeature_fixes-v1-0-585e73d2226b@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713975728; l=4740;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=PYZfCtA79Xr5VNJKr9n7fy84USLuN54khgYv4wgcjQo=;
 b=rlVl8T/xGO1/2xV6GwKE/PvkrwKe/pC57MOBlWz8JPpE33mWa2+YfUXu+QONVTmwtYaEmjPaJ
 4/ZqnqEUBHKCCDC5PDpWOnN/B1tU8IeenzR0EJegRx6uMc6C9M5AhLm
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The riscv_cpuinfo struct that contains mvendorid and marchid is not
populated until all harts are booted which happens after the DT parsing.
Use the vendorid/archid values from the DT if available or assume all
harts have the same values as the boot hart as a fallback.

Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPUs")
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/sbi.h   |  2 ++
 arch/riscv/kernel/cpu.c        | 40 ++++++++++++++++++++++++++++++++++++----
 arch/riscv/kernel/cpufeature.c | 12 ++++++++++--
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6e68f8dff76b..0fab508a65b3 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -370,6 +370,8 @@ static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1
 static inline void sbi_init(void) {}
 #endif /* CONFIG_RISCV_SBI */
 
+unsigned long riscv_get_mvendorid(void);
+unsigned long riscv_get_marchid(void);
 unsigned long riscv_cached_mvendorid(unsigned int cpu_id);
 unsigned long riscv_cached_marchid(unsigned int cpu_id);
 unsigned long riscv_cached_mimpid(unsigned int cpu_id);
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index d11d6320fb0d..c1f3655238fd 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -139,6 +139,34 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
 	return -1;
 }
 
+unsigned long __init riscv_get_marchid(void)
+{
+	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
+
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
+#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
+	ci->marchid = csr_read(CSR_MARCHID);
+#else
+	ci->marchid = 0;
+#endif
+	return ci->marchid;
+}
+
+unsigned long __init riscv_get_mvendorid(void)
+{
+	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
+
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
+#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
+	ci->mvendorid = csr_read(CSR_MVENDORID);
+#else
+	ci->mvendorid = 0;
+#endif
+	return ci->mvendorid;
+}
+
 DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
 unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
@@ -170,12 +198,16 @@ static int riscv_cpuinfo_starting(unsigned int cpu)
 	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
 
 #if IS_ENABLED(CONFIG_RISCV_SBI)
-	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
-	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
+	if (!ci->mvendorid)
+		ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
+	if (!ci->marchid)
+		ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
 	ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
 #elif IS_ENABLED(CONFIG_RISCV_M_MODE)
-	ci->mvendorid = csr_read(CSR_MVENDORID);
-	ci->marchid = csr_read(CSR_MARCHID);
+	if (!ci->mvendorid)
+		ci->mvendorid = csr_read(CSR_MVENDORID);
+	if (!ci->marchid)
+		ci->marchid = csr_read(CSR_MARCHID);
 	ci->mimpid = csr_read(CSR_MIMPID);
 #else
 	ci->mvendorid = 0;
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3ed2359eae35..c6e27b45e192 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -490,6 +490,8 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 	struct acpi_table_header *rhct;
 	acpi_status status;
 	unsigned int cpu;
+	u64 boot_vendorid;
+	u64 boot_archid;
 
 	if (!acpi_disabled) {
 		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
@@ -497,6 +499,13 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			return;
 	}
 
+	/*
+	 * Naively assume that all harts have the same mvendorid/marchid as the
+	 * boot hart.
+	 */
+	boot_vendorid = riscv_get_mvendorid();
+	boot_archid = riscv_get_marchid();
+
 	for_each_possible_cpu(cpu) {
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
 		unsigned long this_hwcap = 0;
@@ -544,8 +553,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		 * CPU cores with the ratified spec will contain non-zero
 		 * marchid.
 		 */
-		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
-		    riscv_cached_marchid(cpu) == 0x0) {
+		if (acpi_disabled && boot_vendorid == THEAD_VENDOR_ID && boot_archid == 0x0) {
 			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
 			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
 		}

-- 
2.44.0


