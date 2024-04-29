Return-Path: <linux-kernel+bounces-163104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D37118B65BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031901C210AF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEAF194C93;
	Mon, 29 Apr 2024 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wBxvFWbF"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F3194C6A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429805; cv=none; b=gsFQRBThUUER5ILE8dO+bdMU8A5XSBUBAPc1V+C+lo4i905QEQmdZXuG88sfmpX0gGeSlBYPAKKk5SkeDgjWst3A7EfIsGkfQP+CNyrFslBzsvjyqlztF8ombX+S8gw7y6DqVwaIjcf2MTJnQDMHtgPI9T1BECs1fAkFrzsYUFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429805; c=relaxed/simple;
	bh=7Qk+r0hY+lSGzO4QuKkjhPXKa0g3xMDQRnHfBKCgIOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaGqU5ZxHiSGDAfpKpy/gptDQ2WUSD9kB255oCuQcnx92QFHI6lgeN4PjVkAXU/Dvrk5ulQDUBeZD/3MFaGo/9W+NjpAQzFs6G/vWqOmZpTkYFqIL/DziAMCKur+MloawUGZgKVAo/isNERS/cIqa7LArjDM+LU8jfniaPztXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wBxvFWbF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e65a1370b7so46957905ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714429803; x=1715034603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRzF3Dpp7TOSCdwhyYociPGfChYhZSWehQ64aWjvABY=;
        b=wBxvFWbFxDZkIEKb29Hv+3KXdBjC7tiXgbsFGiW1XyyI7AO4dQI1G6+2EI9vg6YEom
         5koinf+VQIeyaDJtzM1AIo7+7Utp0EstnmeYtMUXYOIXpVpDvDFROFjdWIBMG8AMNgMU
         c0i1OpFmtlJa2wGghnGvWTZZBSUJiJaFKETLjJ9ITtYQMGEg8uewCNCqsOygUBa6WXuZ
         siqGDWsyb151+GFZYKzPLGEXj5t9FOwYEIbZw++hfXxXGEoQ87XPWUtQDP9oKvKXMQnr
         l2kqa8rKyYqunOGkgowJ2r/NcbHtapJQO+JftbUlMPo3qAupomOnYsbaVe+9sNG32HQ4
         GiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714429803; x=1715034603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRzF3Dpp7TOSCdwhyYociPGfChYhZSWehQ64aWjvABY=;
        b=SnzrSBTUzS0q8oeeJwv4wBN+9wmwN56xYyyJzQgrCcUuT6eTpzRk75HUt4Q+V+JWO6
         t5c1VQPg39uibWX0ABBICdK8ougV1RftlISSdlqWGLgRWaS7u3JcLmwQ+eyQl83z7H6B
         1aBnnQ4rsJxab8loQNG22Z0F5faZn809qbxuizqUzTg2+BEZTYQAUU1u5Wdnbuhy1wkZ
         ASlU9kvC3EjXu2hGEtkOIc6B1j/eak8rO+NYvXGFt9MxU0Q/0NK4MGSR9aNBTsonjKMY
         DxjwOORHs1qT1lsYhmSpS/1rG88KOXBRx+9jaljOa5RDOWDsPPOAQj85bwUrPKNMuvup
         IbAw==
X-Forwarded-Encrypted: i=1; AJvYcCVoooQyfsW0KFOkwReUFNzrJY+GCVtyC6/spP+/kmihZnhP6VfXgg/ir/FgtA16pUl3Wmf9FQlRF0xmtyvi9lkk56Spj1H8ES83gqil
X-Gm-Message-State: AOJu0YytZ+nUvVdefBvsr8lsgn5IeiVxgLtENQC/ZVMNyNK0wQ7E8tfs
	5+vaFkcJ07eQi01GJ1EpDdElQRcJvQEYyIdd4aecTG3ql/IjUp+FforeHdYiTjfgoPyJm45jWWf
	G
X-Google-Smtp-Source: AGHT+IGvF6Fs5X7wWRHrAZ4q9rMZSGzKF0F3AdiwvZC6YzRP1CWCMI35w17jpWoXNnf7Yw5MIY3CzA==
X-Received: by 2002:a17:902:d4cd:b0:1eb:77ed:8fba with SMTP id o13-20020a170902d4cd00b001eb77ed8fbamr8414418plg.17.1714429802983;
        Mon, 29 Apr 2024 15:30:02 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001e0942da6c7sm20794013pls.284.2024.04.29.15.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 15:30:01 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 29 Apr 2024 15:29:51 -0700
Subject: [PATCH v3 1/2] riscv: cpufeature: Fix thead vector hwcap removal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240429-cpufeature_fixes-v3-1-6aa11dde513b@rivosinc.com>
References: <20240429-cpufeature_fixes-v3-0-6aa11dde513b@rivosinc.com>
In-Reply-To: <20240429-cpufeature_fixes-v3-0-6aa11dde513b@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Evan Green <evan@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714429799; l=4794;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=7Qk+r0hY+lSGzO4QuKkjhPXKa0g3xMDQRnHfBKCgIOw=;
 b=+2nEFf9AqjedtM6uvaTMr19dbCCI+Az5OGT9+vcdmI1d4cqQUSYea4mKCVpZSYhyl1fUVl/jV
 ozmKSOUV/cKB0UXVlhKJzLI6/qMfiKqgBNPTdHb/BQU2vIcQCbykLve
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The riscv_cpuinfo struct that contains mvendorid and marchid is not
populated until all harts are booted which happens after the DT parsing.
Use the mvendorid/marchid from the boot hart to determine if the DT
contains an invalid V.

Fixes: d82f32202e0d ("RISC-V: Ignore V from the riscv,isa DT property on older T-Head CPUs")
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/sbi.h   |  2 ++
 arch/riscv/kernel/cpu.c        | 40 ++++++++++++++++++++++++++++++++++++----
 arch/riscv/kernel/cpufeature.c | 10 ++++++++--
 3 files changed, 46 insertions(+), 6 deletions(-)

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
index 3ed2359eae35..818adb0d388e 100644
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
@@ -497,6 +499,9 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			return;
 	}
 
+	boot_vendorid = riscv_get_mvendorid();
+	boot_archid = riscv_get_marchid();
+
 	for_each_possible_cpu(cpu) {
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
 		unsigned long this_hwcap = 0;
@@ -543,9 +548,10 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		 * version of the vector specification put "v" into their DTs.
 		 * CPU cores with the ratified spec will contain non-zero
 		 * marchid.
+		 *
+		 * Disable vector if the boot hart has a T-Head mvendorid and an marchid of 0.
 		 */
-		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
-		    riscv_cached_marchid(cpu) == 0x0) {
+		if (acpi_disabled && boot_vendorid == THEAD_VENDOR_ID && boot_archid == 0x0) {
 			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
 			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
 		}

-- 
2.44.0


