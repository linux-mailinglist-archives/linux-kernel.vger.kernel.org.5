Return-Path: <linux-kernel+bounces-48994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417CC846475
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC79283F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580F147F62;
	Thu,  1 Feb 2024 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oY5LwgLG"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6FF47F42
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706830252; cv=none; b=DUjCj/nvU18l5rsb7hVb/hkYdzFoGnlHYvPRbdgINyCYazp1C6EeWWzEuJAi90yVy9jpvURfQFW6CGEZ25X+RYm/9meXRko3LYzqo8pfUxANDqMhDarm1lTMfa00lbVHJMwSreAOVDlYQM4Aa/CDYmQ5Efhm24pkCdD718ug+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706830252; c=relaxed/simple;
	bh=1uo2wJRuP0cOhYLucx9knuEwY0at2TKxxPAsRqVzTVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pPJe6v96AmqrwtTYbx0QOmyXCDR3SEfUoL3AyLYWLTOl3jvxSg4LXaZlLj0NiaLGcg5sKBITQJHvacdpfLCg/GOCtebCXrcRrCv77YzClHMgeQrMdobmdVUrMkoRyhOeOQJdgDcZzTQcsC7dLChFy0ql/Rn2a49eP8fkhwlNPqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oY5LwgLG; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1462917a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 15:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706830250; x=1707435050; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYLbS2tqTt3y9/rBcMPJwW0rTrdOJiUg4wOkRn5dCzg=;
        b=oY5LwgLGX6R+vIv0rWsDSeAhHKMeeCj+tmJM6VJqZ0G6nRzobEL6vM6qck4OJ5k6Sl
         7ziM67tIe3odisbwRD5fbQOLuYl/7/mRNHKw61/pUy3nSan2xsaspcRlg2R7EZdpbauu
         RDdpbX4KvZbPhnHBiAZD4fs/PpE+22jZKIWfGW/Jz4bWN8b4dJ5qwoul1A8EMO0ENMh1
         cwQ7u6pA8G0JkSMfdpsGA1BIAwKa14L7NxfvhNRvSLF17wv9zyuA1lPlevcsBxEne6Dt
         2uiuCsla2A7t0xn2lS34SiB0UzknIdhVfww9Hh+BC3Lg5Z+Z4IF5eSCDv5N6PCeDk+u1
         KNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706830250; x=1707435050;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYLbS2tqTt3y9/rBcMPJwW0rTrdOJiUg4wOkRn5dCzg=;
        b=v6t19w67lA9ueEbk8Zbgv2yXGnlvOvMXBbBW7KtgvYXM2FYEN0+MtlnMQj9Gf+YIVH
         dD4TCG+xZ/uPTPbJApokiQhWrHl41LvmtkC9hLH/SJjepqt5ZCTDXsuUHksY7qXcAOjE
         anJIaXTYCxVntO11+zI7PlX+Hz0QdiUm0Txl7wMRWEqd9xw0yiKlOU06HjHDTAvqipyI
         EEsuAE8zC/Gx+am3V0IgVZApkH5qqOWL36Ctr8/+gObhzEby1/ZEJT8X8sSXzqUEApjI
         3OrMiHVUD/UYVwsUikQGmK21r4wM23XCAHeoSnFvDtChPszJVmPLHZR+DcUk1ugQOZZF
         7lqg==
X-Gm-Message-State: AOJu0YwFlIjbDgy86J/My7Bsz9E1MbEKJJKwxlH0v+fCQrehS3cgI7kj
	EabjUdMmDb2lpMMkHvuEi26gC5nlGuEY5nDuHbCKMjuUQ1fzqnJE52Riu4XTc4g=
X-Google-Smtp-Source: AGHT+IGU4e20A5H2cqtnSW5mhi4F21ib+OdbT2cjHxXIHr/pgI38p1vAdWCnwydtDJykjCQae1bXQw==
X-Received: by 2002:a05:6a21:2d85:b0:19c:aaee:bb1b with SMTP id ty5-20020a056a212d8500b0019caaeebb1bmr408931pzb.7.1706830250291;
        Thu, 01 Feb 2024 15:30:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXrPr/NLHFlskYHFmrbSw5TuH6tCYPXpCSodI+pn8DDMHKntmqGmwobMaJHB3HBnS1uinXFAsm+UAR/4MPIfLy1RQvNE/bc/7xCEEGlZS2roZbAi5uQV5FOoL/qn70gYI8hiYahxwrkl4a3JdlBHYCy5pmE2hKI1qHu8NnX7Zkkxf/wqcmFgOn1CFl/+5QtLNdLjwKHkkK1tc+Ufr1uYwXq0n5w0rDuTI/Aj8FufxJyiesr+sXXvzHIk6EJbDhB5M/RAj+5Z++L6DA=
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id y9-20020a62ce09000000b006db85b12036sm309673pfg.137.2024.02.01.15.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 15:30:49 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 01 Feb 2024 15:30:45 -0800
Subject: [PATCH v2 1/2] riscv: lib: Introduce has_fast_misaligned_access
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-disable_misaligned_probe_config-v2-1-77c368bed7b2@rivosinc.com>
References: <20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com>
In-Reply-To: <20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706830247; l=2642;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=1uo2wJRuP0cOhYLucx9knuEwY0at2TKxxPAsRqVzTVs=;
 b=/GVxyTwgomTdVjJfsMJQL8duFxtcbDwkmrjXW1K7NOOEbw5flZcVOyyyihOjT+qWhBpAkICnz
 xZBD89qWs/GDbbwP0FmWHPjS3OI9TrlMHKE1LeJuIigzSiOkn/sZGcL
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Create has_fast_misaligned_access to avoid needing to explicitly check
the fast_misaligned_access_speed_key static key.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
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
index af3df5274ccb..ea2f668fab71 100644
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
+	if (has_fast_misaligned_accesses() || (((unsigned long)buff & OFFSET_MASK) == 0b101))
 		return do_csum_no_alignment(buff, len);
 
 	return do_csum_with_alignment(buff, len);

-- 
2.43.0


