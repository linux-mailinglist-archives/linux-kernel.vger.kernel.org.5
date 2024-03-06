Return-Path: <linux-kernel+bounces-94537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A79A874121
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E25B1C21E23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4330B142908;
	Wed,  6 Mar 2024 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="V9wFoDoi"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092431419BA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755473; cv=none; b=XqVGdmQLdrEYdOsU+voPmG0vyMZnZDFVkyFvhJXHcsSIdAsWm2RBeDqkwu5LxCec95JRQDF4OY0A+C+NeVhmd8dhDVZSDwD44HlV1lZJ7ErBU/Z+o81FhQxeypMcNXOxGqNn1c8+TAjT/6ftXylWHNEYVSlYvr1Dc4veDpoWShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755473; c=relaxed/simple;
	bh=FzR0GpkIwoZRYWxFyEryVlUwRX7agq76vtFdOU7VZ+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qC5ftjw+i1jnPs3ttj0Oxgq5A+K11Uk09fPfOsLtSaF/FDLSYyND00FSu8RTcPa5snh2/L5CUHss09/UfPqIvWDajbEPgavQH2sKiOIHbuXa1sUOYiRREOG+HwDWZ7v1LOpJ37BqL6QvGJW0qJ2TvPNKDGr6r4vzdX/kiqOG/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=V9wFoDoi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc09556599so1125815ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709755470; x=1710360270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EVtHtZkQ3gl1JI+EwyEBrvg+iHnnWLYEsQB5N3MR4A=;
        b=V9wFoDoiP/cf9Uzw/mSWEm4mfj0nlN1hIM7ax8t38JCs7eQ/12Ghw7wV0xuHtU8FcA
         ysEgzVYbEkZmgCdvqICp5AC7ipTttao8e3xo95n0GayFwzp6sxaKFsX6fh09rKPvp7u0
         NiSKNhiWGZoq5+vlMfj94hJlsU+8S/gaA4F1xNXbX9BRZLUexnri/yJI9tUzVh2nmoVH
         18ydarOF85hmsBPrypesM20P6DfWbWiWj2ngtMOo8v2yu2hADuKNKyn58gqidkO0XmiI
         CuJTU5WsW46mb9QiF7qFPSM4HfPbahbgiPcDcT4OqsR8krEeKDAoMVP7vNWDfGG9Lrki
         FxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755470; x=1710360270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EVtHtZkQ3gl1JI+EwyEBrvg+iHnnWLYEsQB5N3MR4A=;
        b=eJthXVETFN1UGM1MIfzTR7WqfLpT0fhPgCIJJV8jPnwGLr15G0rBjp1+qjIrv+vNyz
         x+z5d/DC0fVu9/F844mmpZ7dYv8Mr9PIH+r01hhSfaJ1LlqwjgFLqzgYUQL1rsDZ9bth
         NLJUExh+85D7TwlQOifkVX49BG/DwnwOT3v4cpyuaOuqMEai4zgCibGZz/QrGI+bm6o7
         GUMOTHi8xb0ClywVuLNg1uVcC+mdS8pnCxE61MEPdG/xlaCbPPCIYAUfpCC+HliQE5Al
         70cHSjhjZfw7oX07JQvSiOQcHPzxKtIjrpVOQRWxHxYO3yKsnUptCqD4P1MlCZppEAdX
         QgZg==
X-Forwarded-Encrypted: i=1; AJvYcCW7AjgzrML+KBMjHdtONT8grlrCkGlx4LZxnfchuNCaE3qpkghxpp9qkXku5At/K0f2qb/gOP1b0JqtaTTRnbDNFlspncsGyW/QlyNP
X-Gm-Message-State: AOJu0Yxj7+Y38REc5fsJEPOj1DU/qKEmq1ypg2G8vHZ3X6Pj+AB2jfFD
	r0C82L6VToJBPMis+c3A5E+kfALl74/XjmZ4UlLneJu5oHzmIIs78S8M5kMvhOY=
X-Google-Smtp-Source: AGHT+IH7qCYemZ9Fv29kGH+ngcAW1wIPaHrs6Rzhtk+olBLCSYpKDmZzT/TWRu2OtakOAUqT9RbrtQ==
X-Received: by 2002:a17:902:e892:b0:1dc:744f:5317 with SMTP id w18-20020a170902e89200b001dc744f5317mr7603710plg.50.1709755470277;
        Wed, 06 Mar 2024 12:04:30 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001dd42bbb08asm874913plx.253.2024.03.06.12.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:04:29 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 06 Mar 2024 12:00:01 -0800
Subject: [PATCH v7 1/4] riscv: lib: Introduce has_fast_unaligned_access
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-disable_misaligned_probe_config-v7-1-6c90419e7a96@rivosinc.com>
References: <20240306-disable_misaligned_probe_config-v7-0-6c90419e7a96@rivosinc.com>
In-Reply-To: <20240306-disable_misaligned_probe_config-v7-0-6c90419e7a96@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709755467; l=3372;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FzR0GpkIwoZRYWxFyEryVlUwRX7agq76vtFdOU7VZ+M=;
 b=j5FrAhWN5NKWo/uoDCnKRVwC+pEcmVZD3Ik3AEgIdvZs2qy2QlaslIBnPi0QfAYB7of1L9SiA
 U1GUl1BflS1CjE+0hvYkkMgQbTVzvSCa3r0QvML215SYBVyiy3Wja5q
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


