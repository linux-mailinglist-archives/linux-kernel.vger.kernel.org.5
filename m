Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138D17FEDAA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345103AbjK3LTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345004AbjK3LTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:19:51 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF31D54
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:19:57 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b4ff0f254so847755e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701343195; x=1701947995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xkg3D7dfeo+mWJRReRlSNv0FZynZ0tPFmMr3Kpg4FI=;
        b=GrnJWDObHcUogjBOngRofFMH9Ig8ey1Jy9vZJniVZDXuegnlm21xjGY83VE51fb4pP
         TqbtIRvgsDVlg80K1/YOjZmUZYV6RvKWPekEKkm+FlbxwOStn9e6+wg+vOqNyHTj/pEQ
         OoyExbXMfmxaGIiWHEojtd3qgTqVo0uRby2a7gI82S6SAB1b12OMqlTyYgDicaXvcB4+
         mzIAqLu0Wn4SuzttPmCyvwaFvCjJRW4+6uThU4oouHd4ZNiFMO/9QXZSvhgqKn0osule
         Yjc2ghkQFg3EFhVYvVpzGJgnxXQZtbwXWLZlhmom9cKLYjxxRju00mII5s3J6RmO5AW9
         6c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701343195; x=1701947995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xkg3D7dfeo+mWJRReRlSNv0FZynZ0tPFmMr3Kpg4FI=;
        b=suYFljXR1XtApdVmWib6gRJNA44VeAqq0gBRgivaCYjAOV9n0B8Xx2clfyHCRksiFp
         tnAxAYtnLTrI7jPDKA6mXkVJDtzeow7ZDXZDM+b/qSnpGdqAFfNi6haVD3lMWgpjcgZw
         YF7ab+VVZsKBFUdRdTMrA7FqdQ0w7fH3qgKc9cl0b4NKs7LTA9//n5zLyD46MZYu3czE
         LhHsuBAKQfOkVPHW/nJJZI/EucmJlUqDOKapwGZm88v1zGflkajZ8WAkbWQdSM123q7W
         nVudO8dpfCp6vR5Z+XNlnUp+V1g/NgOrlqiBE+0Me9rk+dJI2myhzJKmLVthJhtyWaNk
         ysKA==
X-Gm-Message-State: AOJu0Yz1gGzwywAoy2FJDWMaM6RmDHXJmXWBAikP/eX3VcTp7lHpGD2x
        kMROmXC+kwojSjBmcaFhU1PFpg==
X-Google-Smtp-Source: AGHT+IFfRRNQEO2XT8TyLZKIAq0sDnYFn0kJ8Z/ibitwXQYGOwIrgK+qTbFcYzc1pO4WH0/im53AAw==
X-Received: by 2002:a05:600c:4f43:b0:40b:3d6d:e46b with SMTP id m3-20020a05600c4f4300b0040b3d6de46bmr1021907wmq.4.1701343195571;
        Thu, 30 Nov 2023 03:19:55 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:1e3e:ecf4:f8d8:c45e])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b0040b5517ae31sm4537310wmb.6.2023.11.30.03.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 03:19:55 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Samuel Ortiz <sameo@rivosinc.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Subject: [PATCH v2] RISC-V: Implement archrandom when Zkr is available
Date:   Thu, 30 Nov 2023 12:17:02 +0100
Message-ID: <20231130111704.1319081-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Ortiz <sameo@rivosinc.com>

The Zkr extension is ratified and provides 16 bits of entropy seed when
reading the SEED CSR.

We can implement arch_get_random_seed_longs() by doing multiple csrrw to
that CSR and filling an unsigned long with valid entropy bits.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
Signed-off-by: Clément Léger <cleger@rivosinc.com>

---

This series depends on "riscv: report more ISA extensions through
hwprobe" series [1].

Link: https://lore.kernel.org/lkml/20231114141256.126749-1-cleger@rivosinc.com/ [1]

Changes in V2:
 - Add cpu_relax() in BIST/WAIT/default cases.
 - Remove From: from commit description
 - Remove "by" from copyright mention
---
 arch/riscv/include/asm/archrandom.h | 72 +++++++++++++++++++++++++++++
 arch/riscv/include/asm/csr.h        |  9 ++++
 2 files changed, 81 insertions(+)
 create mode 100644 arch/riscv/include/asm/archrandom.h

diff --git a/arch/riscv/include/asm/archrandom.h b/arch/riscv/include/asm/archrandom.h
new file mode 100644
index 000000000000..5345360adfb9
--- /dev/null
+++ b/arch/riscv/include/asm/archrandom.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Kernel interface for the RISCV arch_random_* functions
+ *
+ * Copyright (c) 2023 Rivos Inc.
+ *
+ */
+
+#ifndef ASM_RISCV_ARCHRANDOM_H
+#define ASM_RISCV_ARCHRANDOM_H
+
+#include <asm/csr.h>
+#include <asm/processor.h>
+
+#define SEED_RETRY_LOOPS 100
+
+static inline bool __must_check csr_seed_long(unsigned long *v)
+{
+	unsigned int retry = SEED_RETRY_LOOPS, valid_seeds = 0;
+	const int needed_seeds = sizeof(long) / sizeof(u16);
+	u16 *entropy = (u16 *)v;
+
+	do {
+		/*
+		 * The SEED CSR must be accessed with a read-write instruction.
+		 */
+		unsigned long csr_seed = csr_swap(CSR_SEED, 0);
+		unsigned long opst = csr_seed & SEED_OPST_MASK;
+
+		switch (opst) {
+		case SEED_OPST_ES16:
+			entropy[valid_seeds++] = csr_seed & SEED_ENTROPY_MASK;
+			if (valid_seeds == needed_seeds)
+				return true;
+			break;
+
+		case SEED_OPST_DEAD:
+			pr_err_once("archrandom: Unrecoverable error\n");
+			return false;
+
+		case SEED_OPST_BIST:
+		case SEED_OPST_WAIT:
+		default:
+			cpu_relax();
+			continue;
+		}
+	} while (--retry);
+
+	return false;
+}
+
+static inline size_t __must_check arch_get_random_longs(unsigned long *v, size_t max_longs)
+{
+	return 0;
+}
+
+static inline size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
+{
+	if (!max_longs)
+		return 0;
+
+	/*
+	 * If Zkr is supported and csr_seed_long succeeds, we return one long
+	 * worth of entropy.
+	 */
+	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZKR) && csr_seed_long(v))
+		return 1;
+
+	return 0;
+}
+
+#endif /* ASM_RISCV_ARCHRANDOM_H */
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 306a19a5509c..510014051f5d 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -411,6 +411,15 @@
 #define CSR_VTYPE		0xc21
 #define CSR_VLENB		0xc22
 
+/* Scalar Crypto Extension - Entropy */
+#define CSR_SEED		0x015
+#define SEED_OPST_MASK		_AC(0xC0000000, UL)
+#define SEED_OPST_BIST		_AC(0x00000000, UL)
+#define SEED_OPST_WAIT		_AC(0x40000000, UL)
+#define SEED_OPST_ES16		_AC(0x80000000, UL)
+#define SEED_OPST_DEAD		_AC(0xC0000000, UL)
+#define SEED_ENTROPY_MASK	_AC(0xFFFF, UL)
+
 #ifdef CONFIG_RISCV_M_MODE
 # define CSR_STATUS	CSR_MSTATUS
 # define CSR_IE		CSR_MIE
-- 
2.43.0

