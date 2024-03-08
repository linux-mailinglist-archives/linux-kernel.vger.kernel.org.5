Return-Path: <linux-kernel+bounces-97452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FCF876AB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DA01C213CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9A757880;
	Fri,  8 Mar 2024 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EfsJ06ds"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D6A54792
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922363; cv=none; b=DNn+/lcDUJKDxGRWxkGprCd6xMPNg2ZYgnEBuyl+V+erzvz2sgAID1UPVGTWD9P3JxTZxKRcQuVlEyxVoV2zF0i2+Oe+DthWs6IwjkgRqfW8kpv5KEQ0p4SshYDO612RpIhPPAoWEPZ57r+xJS525v3U1711zslLDrqXw6AgX4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922363; c=relaxed/simple;
	bh=ejS3FVJ1L+bLL4KR96q6ZNDMwke6NlmAthP91enITHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EYYn7z42yA6KqQfursfS5uasJ11PufP5+s+Od8Wz9mIuutGai0JXEzTINre1Jroz7swBj3Vr5TTTYQHnbxOj5QXIRCI9qLQHliJDzwqoVI8abhYvD5NS+Ak97sDj+85tZ/cxYh4nHS3+NfeDDtZV/XedmvmU46Q2Q9D/GeUFPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EfsJ06ds; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29acdf99d5aso1648288a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 10:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709922361; x=1710527161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akMpdDedBfqF60/fNsk+O8npKk5JqF+ySZ0f9xW5/1M=;
        b=EfsJ06dstPNrOk7teIsWGrajE3Mqrn9DvcSIz2pJAW9T8/G9kuFyP7CzEVm49oglU/
         ZGvvqgA8Naem9Ui1EivntfUF7/RXijfucg83Z+r1+JWYcxtKww1oDnvNvb+sjv/xO5nR
         Syg2J120NptFpv34britAGMftaZPk3jvbbSXSbL7VEdH82ngOjZEy/27Y1t7omziZmsD
         M5Uxe7hvUi+2aUQHl09D6KtpTOPGRfQU7gijeI4wHmVMVEZ3g407RffvhWIFTgX88DsH
         vPiH6JoZBH/iV8VbiGefrRMDdGOJWDYWHbsyhGAdMLD5/Fj1uMQ7/XFvVu8rIjFNdgFQ
         6Adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709922361; x=1710527161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akMpdDedBfqF60/fNsk+O8npKk5JqF+ySZ0f9xW5/1M=;
        b=hXRQ8aF/M5IR0nQeT1BYJWtEJfBncq8rrvFlyaVw6Eouo8I6y42KAsXNlSK7E5szBN
         cedrL2J6zlTdt0X7IG94mEGql65Q36oMniX/RzhkH7YHncl7WNld7SLhmHunVIqxW3Zs
         JfxPTaoQNrhWg4bSbTJHOHb8dgRN9zjP7ifauDIR02ym7tHS2fG/itFpTNXGQHxNGuw7
         FgY2CdvgUPC9hmIGl65gMHXD2hHuecBGNEEOVoZIXWG6zScJ3iL8FhiI1e/VSN5uKG7l
         4pMbv4xdpXFhPFOYUjYjev81SK+sWA05Pp+3zFuxPreGJkWBPXVCvVUfdAQFHT7HO9ES
         wcfA==
X-Forwarded-Encrypted: i=1; AJvYcCWaSF0pujNO1/PLuvkRrnUHuT8lHBfcOjSiNvt9XygKVHshtNsANvMWIF6Bzi/ILVMLimfXiOi/jN7gc8/1w9BvpA5Ehqo3oNF3/DTb
X-Gm-Message-State: AOJu0YxpexLvD5v/KPkKcafghNZSbytktuOhrRjSfJUHHsNPC/27wEht
	quaReEoV3ZzZNEYRwYihkGyt4UoA3YbwTuJR3bFMjNm/x8cmId+q8KluO/9Vyx8=
X-Google-Smtp-Source: AGHT+IHedflOqFeHEwgfr854USwwC55wJSFS3hsQJ1T3yn5ygm4BiYm2PUImp7bGuhG8F7kabsskTg==
X-Received: by 2002:a17:90b:216:b0:29b:c179:9ba with SMTP id fy22-20020a17090b021600b0029bc17909bamr730495pjb.47.1709922361463;
        Fri, 08 Mar 2024 10:26:01 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090ac20d00b0029bb1bb298dsm44821pjt.35.2024.03.08.10.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:26:00 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 08 Mar 2024 10:25:55 -0800
Subject: [PATCH v9 1/4] riscv: lib: Introduce has_fast_unaligned_access()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-disable_misaligned_probe_config-v9-1-a388770ba0ce@rivosinc.com>
References: <20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com>
In-Reply-To: <20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709922358; l=3428;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=ejS3FVJ1L+bLL4KR96q6ZNDMwke6NlmAthP91enITHI=;
 b=SJMPynNndVY7EsAyEorrdTi5vigiwbschT4Hh2s6NWRzNuKQv7kmdQH1jlqRP0WwxvdIrlvD5
 dLhky32sTVtCvLuntQiohAff3ZBkbKDJ0Ms+9YYieJh871kgkrrcG6J
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


