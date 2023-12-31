Return-Path: <linux-kernel+bounces-13740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA13820BD6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05BE1C2161E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDCBA953;
	Sun, 31 Dec 2023 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="h5HmoMRJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C2810A08
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9f9689195so1525259b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 07:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704036506; x=1704641306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4btUclgL8prP5a5xsfbrxrrvqeEp8OCXhpchFT4JJow=;
        b=h5HmoMRJnW2icHN7jazJlhEZJ7fRKwffHWbcqqAF1zfaVmpjkMDrUr4AEaPsu+A2e5
         kRt9U3abkI3mazF3cFbJcikg9VwhdOe2xjVxKCfh5YhDIZ7QYKeZWT6GXlF5h7yDC58s
         P4+asGXCclcIfB+dELpdmB4EWir7kcvlwu+ibQncxYXPsLYYUfNX4Y6+dPoQMfNYy0Na
         Vju3tsYkjzSsX9BX1H+r4FN5fJy1CFLbufx430oXEGsX7AUz1ZfxK/2rohMpfz5zcFFg
         pZKfk660qdXpx5UkXmgcW0SiOFUYfZgV2SjNDNk6DrwcjIxz1fi3tNy70M5SgBu3Yxwd
         GZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704036506; x=1704641306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4btUclgL8prP5a5xsfbrxrrvqeEp8OCXhpchFT4JJow=;
        b=nkeLZjjlROBrl8rSB0SUGniQvnMgLNOoaRzJZqpCLt9u+hPyJZcuaEMISJg+XFX1oW
         lPnnWdioRCvZcKKszm81vA+mYAocPeCo31HDqd7SX0RdEtfNJ7fSPIKX3BW4szIXcRqa
         Abjb8KZd6cu3YdhaAdJjQrzY9I14ko1ZHCKSWJQHjC3IIuc+kIQsY+uvdNCWwzwJ92C1
         jrpou53ozrpYgDEjLaMgQuaBzpRXAoxBFlN+UN9F8Zxqh09w4PSGJNbAdIrWpFxx5Vnw
         wSOA8PDR71J25/cqAcb45mzEujC0WkDhM1E4NyRjpZtfU68ooDCGCsCH7PH1OL74wQiL
         eiXg==
X-Gm-Message-State: AOJu0Yxxx0nlJqrJxjqVTpVX8UJtH+tYBc6PcPabn3FXL9lGaGPNP1Di
	iqzM23SqZEdegtXV068wYGXAv4/veSxGAQ==
X-Google-Smtp-Source: AGHT+IGs+2VkVLO9wT3XYs3ZUo/QaAslGvl/LI9b9+V4HNtX175e8ul7UJLbAGqZqbTBd5UyWRSFTA==
X-Received: by 2002:a05:6a20:5294:b0:196:5929:dcdd with SMTP id o20-20020a056a20529400b001965929dcddmr1930861pzg.6.1704036506477;
        Sun, 31 Dec 2023 07:28:26 -0800 (PST)
Received: from localhost.localdomain ([49.216.222.63])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001cc3c521affsm18624430plf.300.2023.12.31.07.28.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Dec 2023 07:28:26 -0800 (PST)
From: Jerry Shih <jerry.shih@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	conor.dooley@microchip.com,
	ebiggers@kernel.org,
	ardb@kernel.org
Cc: heiko@sntech.de,
	phoebe.chen@sifive.com,
	hongrong.hsu@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v4 10/11] RISC-V: crypto: add Zvksh accelerated SM3 implementation
Date: Sun, 31 Dec 2023 23:27:42 +0800
Message-Id: <20231231152743.6304-11-jerry.shih@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20231231152743.6304-1-jerry.shih@sifive.com>
References: <20231231152743.6304-1-jerry.shih@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add SM3 implementation using Zvksh vector crypto extension from OpenSSL
(openssl/openssl#21923).

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
Changelog v4:
 - Use asm mnemonics for the instructions in vector crypto 1.0 extension.

Changelog v3:
 - Use `SYM_TYPED_FUNC_START` for sm3 indirect-call asm symbol.
 - Use asm mnemonics for the instructions in RVV 1.0 extension.

Changelog v2:
 - Do not turn on kconfig `SM3_RISCV64` option by default.
 - Add `asmlinkage` qualifier for crypto asm function.
 - Rename sm3-riscv64-zvkb-zvksh to sm3-riscv64-zvksh-zvkb.
 - Reorder structure sm3_alg members initialization in the order declared.
---
 arch/riscv/crypto/Kconfig              |  12 ++
 arch/riscv/crypto/Makefile             |   7 +
 arch/riscv/crypto/sm3-riscv64-glue.c   | 124 ++++++++++++++
 arch/riscv/crypto/sm3-riscv64-zvksh.pl | 227 +++++++++++++++++++++++++
 4 files changed, 370 insertions(+)
 create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index cdf7fead0636..81dcae72c477 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -66,6 +66,18 @@ config CRYPTO_SHA512_RISCV64
 	  - Zvknhb vector crypto extension
 	  - Zvkb vector crypto extension
 
+config CRYPTO_SM3_RISCV64
+	tristate "Hash functions: SM3 (ShangMi 3)"
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	select CRYPTO_HASH
+	select CRYPTO_SM3
+	help
+	  SM3 (ShangMi 3) secure hash function (OSCCA GM/T 0004-2012)
+
+	  Architecture: riscv64 using:
+	  - Zvksh vector crypto extension
+	  - Zvkb vector crypto extension
+
 config CRYPTO_SM4_RISCV64
 	tristate "Ciphers: SM4 (ShangMi 4)"
 	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 8e34861bba34..b1f857695c1c 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -18,6 +18,9 @@ sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
 obj-$(CONFIG_CRYPTO_SHA512_RISCV64) += sha512-riscv64.o
 sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvknhb-zvkb.o
 
+obj-$(CONFIG_CRYPTO_SM3_RISCV64) += sm3-riscv64.o
+sm3-riscv64-y := sm3-riscv64-glue.o sm3-riscv64-zvksh.o
+
 obj-$(CONFIG_CRYPTO_SM4_RISCV64) += sm4-riscv64.o
 sm4-riscv64-y := sm4-riscv64-glue.o sm4-riscv64-zvksed.o
 
@@ -42,6 +45,9 @@ $(obj)/sha256-riscv64-zvknha_or_zvknhb-zvkb.S: $(src)/sha256-riscv64-zvknha_or_z
 $(obj)/sha512-riscv64-zvknhb-zvkb.S: $(src)/sha512-riscv64-zvknhb-zvkb.pl
 	$(call cmd,perlasm)
 
+$(obj)/sm3-riscv64-zvksh.S: $(src)/sm3-riscv64-zvksh.pl
+	$(call cmd,perlasm)
+
 $(obj)/sm4-riscv64-zvksed.S: $(src)/sm4-riscv64-zvksed.pl
 	$(call cmd,perlasm)
 
@@ -51,4 +57,5 @@ clean-files += aes-riscv64-zvkned-zvkb.S
 clean-files += ghash-riscv64-zvkg.S
 clean-files += sha256-riscv64-zvknha_or_zvknhb-zvkb.S
 clean-files += sha512-riscv64-zvknhb-zvkb.S
+clean-files += sm3-riscv64-zvksh.S
 clean-files += sm4-riscv64-zvksed.S
diff --git a/arch/riscv/crypto/sm3-riscv64-glue.c b/arch/riscv/crypto/sm3-riscv64-glue.c
new file mode 100644
index 000000000000..0e5a2b84c930
--- /dev/null
+++ b/arch/riscv/crypto/sm3-riscv64-glue.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Linux/riscv64 port of the OpenSSL SM3 implementation for RISC-V 64
+ *
+ * Copyright (C) 2023 VRULL GmbH
+ * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
+ *
+ * Copyright (C) 2023 SiFive, Inc.
+ * Author: Jerry Shih <jerry.shih@sifive.com>
+ */
+
+#include <asm/simd.h>
+#include <asm/vector.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/simd.h>
+#include <crypto/sm3_base.h>
+
+/*
+ * sm3 using zvksh vector crypto extension
+ *
+ * This asm function will just take the first 256-bit as the sm3 state from
+ * the pointer to `struct sm3_state`.
+ */
+asmlinkage void ossl_hwsm3_block_data_order_zvksh(struct sm3_state *digest,
+						  u8 const *o, int num);
+
+static int riscv64_sm3_update(struct shash_desc *desc, const u8 *data,
+			      unsigned int len)
+{
+	int ret = 0;
+
+	/*
+	 * Make sure struct sm3_state begins directly with the SM3 256-bit internal
+	 * state, as this is what the asm function expect.
+	 */
+	BUILD_BUG_ON(offsetof(struct sm3_state, state) != 0);
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		ret = sm3_base_do_update(desc, data, len,
+					 ossl_hwsm3_block_data_order_zvksh);
+		kernel_vector_end();
+	} else {
+		sm3_update(shash_desc_ctx(desc), data, len);
+	}
+
+	return ret;
+}
+
+static int riscv64_sm3_finup(struct shash_desc *desc, const u8 *data,
+			     unsigned int len, u8 *out)
+{
+	struct sm3_state *ctx;
+
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		if (len)
+			sm3_base_do_update(desc, data, len,
+					   ossl_hwsm3_block_data_order_zvksh);
+		sm3_base_do_finalize(desc, ossl_hwsm3_block_data_order_zvksh);
+		kernel_vector_end();
+
+		return sm3_base_finish(desc, out);
+	}
+
+	ctx = shash_desc_ctx(desc);
+	if (len)
+		sm3_update(ctx, data, len);
+	sm3_final(ctx, out);
+
+	return 0;
+}
+
+static int riscv64_sm3_final(struct shash_desc *desc, u8 *out)
+{
+	return riscv64_sm3_finup(desc, NULL, 0, out);
+}
+
+static struct shash_alg sm3_alg = {
+	.init = sm3_base_init,
+	.update = riscv64_sm3_update,
+	.final = riscv64_sm3_final,
+	.finup = riscv64_sm3_finup,
+	.descsize = sizeof(struct sm3_state),
+	.digestsize = SM3_DIGEST_SIZE,
+	.base = {
+		.cra_blocksize = SM3_BLOCK_SIZE,
+		.cra_priority = 150,
+		.cra_name = "sm3",
+		.cra_driver_name = "sm3-riscv64-zvksh-zvkb",
+		.cra_module = THIS_MODULE,
+	},
+};
+
+static inline bool check_sm3_ext(void)
+{
+	return riscv_isa_extension_available(NULL, ZVKSH) &&
+	       riscv_isa_extension_available(NULL, ZVKB) &&
+	       riscv_vector_vlen() >= 128;
+}
+
+static int __init riscv64_sm3_mod_init(void)
+{
+	if (check_sm3_ext())
+		return crypto_register_shash(&sm3_alg);
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_sm3_mod_fini(void)
+{
+	crypto_unregister_shash(&sm3_alg);
+}
+
+module_init(riscv64_sm3_mod_init);
+module_exit(riscv64_sm3_mod_fini);
+
+MODULE_DESCRIPTION("SM3 (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("sm3");
diff --git a/arch/riscv/crypto/sm3-riscv64-zvksh.pl b/arch/riscv/crypto/sm3-riscv64-zvksh.pl
new file mode 100644
index 000000000000..c94c99111a71
--- /dev/null
+++ b/arch/riscv/crypto/sm3-riscv64-zvksh.pl
@@ -0,0 +1,227 @@
+#! /usr/bin/env perl
+# SPDX-License-Identifier: Apache-2.0 OR BSD-2-Clause
+#
+# This file is dual-licensed, meaning that you can use it under your
+# choice of either of the following two licenses:
+#
+# Copyright 2023 The OpenSSL Project Authors. All Rights Reserved.
+#
+# Licensed under the Apache License 2.0 (the "License"). You can obtain
+# a copy in the file LICENSE in the source distribution or at
+# https://www.openssl.org/source/license.html
+#
+# or
+#
+# Copyright (c) 2023, Christoph Müllner <christoph.muellner@vrull.eu>
+# Copyright (c) 2023, Jerry Shih <jerry.shih@sifive.com>
+# All rights reserved.
+#
+# Redistribution and use in source and binary forms, with or without
+# modification, are permitted provided that the following conditions
+# are met:
+# 1. Redistributions of source code must retain the above copyright
+#    notice, this list of conditions and the following disclaimer.
+# 2. Redistributions in binary form must reproduce the above copyright
+#    notice, this list of conditions and the following disclaimer in the
+#    documentation and/or other materials provided with the distribution.
+#
+# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+
+# The generated code of this file depends on the following RISC-V extensions:
+# - RV64I
+# - RISC-V Vector ('V') with VLEN >= 128
+# - RISC-V Vector SM3 Secure Hash extension ('Zvksh')
+# - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
+
+use strict;
+use warnings;
+
+use FindBin qw($Bin);
+use lib "$Bin";
+use lib "$Bin/../../perlasm";
+
+# $output is the last argument if it looks like a file (it has an extension)
+# $flavour is the first argument if it doesn't look like a file
+my $output = $#ARGV >= 0 && $ARGV[$#ARGV] =~ m|\.\w+$| ? pop : undef;
+my $flavour = $#ARGV >= 0 && $ARGV[0] !~ m|\.| ? shift : undef;
+
+$output and open STDOUT,">$output";
+
+my $code=<<___;
+#include <linux/cfi_types.h>
+
+.text
+.option arch, +zvksh, +zvkb
+___
+
+################################################################################
+# ossl_hwsm3_block_data_order_zvksh(SM3_CTX *c, const void *p, size_t num);
+{
+my ($CTX, $INPUT, $NUM) = ("a0", "a1", "a2");
+my ($V0, $V1, $V2, $V3, $V4, $V5, $V6, $V7,
+    $V8, $V9, $V10, $V11, $V12, $V13, $V14, $V15,
+    $V16, $V17, $V18, $V19, $V20, $V21, $V22, $V23,
+    $V24, $V25, $V26, $V27, $V28, $V29, $V30, $V31,
+) = map("v$_",(0..31));
+
+$code .= <<___;
+SYM_TYPED_FUNC_START(ossl_hwsm3_block_data_order_zvksh)
+    vsetivli zero, 8, e32, m2, ta, ma
+
+    # Load initial state of hash context (c->A-H).
+    vle32.v $V0, ($CTX)
+    vrev8.v $V0, $V0
+
+L_sm3_loop:
+    # Copy the previous state to v2.
+    # It will be XOR'ed with the current state at the end of the round.
+    vmv.v.v $V2, $V0
+
+    # Load the 64B block in 2x32B chunks.
+    vle32.v $V6, ($INPUT) # v6 := {w7, ..., w0}
+    addi $INPUT, $INPUT, 32
+
+    vle32.v $V8, ($INPUT) # v8 := {w15, ..., w8}
+    addi $INPUT, $INPUT, 32
+
+    addi $NUM, $NUM, -1
+
+    # As vsm3c consumes only w0, w1, w4, w5 we need to slide the input
+    # 2 elements down so we process elements w2, w3, w6, w7
+    # This will be repeated for each odd round.
+    vslidedown.vi $V4, $V6, 2 # v4 := {X, X, w7, ..., w2}
+
+    vsm3c.vi $V0, $V6, 0
+    vsm3c.vi $V0, $V4, 1
+
+    # Prepare a vector with {w11, ..., w4}
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, X, X, w7, ..., w4}
+    vslideup.vi $V4, $V8, 4   # v4 := {w11, w10, w9, w8, w7, w6, w5, w4}
+
+    vsm3c.vi $V0, $V4, 2
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, w11, w10, w9, w8, w7, w6}
+    vsm3c.vi $V0, $V4, 3
+
+    vsm3c.vi $V0, $V8, 4
+    vslidedown.vi $V4, $V8, 2 # v4 := {X, X, w15, w14, w13, w12, w11, w10}
+    vsm3c.vi $V0, $V4, 5
+
+    vsm3me.vv $V6, $V8, $V6   # v6 := {w23, w22, w21, w20, w19, w18, w17, w16}
+
+    # Prepare a register with {w19, w18, w17, w16, w15, w14, w13, w12}
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, X, X, w15, w14, w13, w12}
+    vslideup.vi $V4, $V6, 4   # v4 := {w19, w18, w17, w16, w15, w14, w13, w12}
+
+    vsm3c.vi $V0, $V4, 6
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, w19, w18, w17, w16, w15, w14}
+    vsm3c.vi $V0, $V4, 7
+
+    vsm3c.vi $V0, $V6, 8
+    vslidedown.vi $V4, $V6, 2 # v4 := {X, X, w23, w22, w21, w20, w19, w18}
+    vsm3c.vi $V0, $V4, 9
+
+    vsm3me.vv $V8, $V6, $V8   # v8 := {w31, w30, w29, w28, w27, w26, w25, w24}
+
+    # Prepare a register with {w27, w26, w25, w24, w23, w22, w21, w20}
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, X, X, w23, w22, w21, w20}
+    vslideup.vi $V4, $V8, 4   # v4 := {w27, w26, w25, w24, w23, w22, w21, w20}
+
+    vsm3c.vi $V0, $V4, 10
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, w27, w26, w25, w24, w23, w22}
+    vsm3c.vi $V0, $V4, 11
+
+    vsm3c.vi $V0, $V8, 12
+    vslidedown.vi $V4, $V8, 2 # v4 := {x, X, w31, w30, w29, w28, w27, w26}
+    vsm3c.vi $V0, $V4, 13
+
+    vsm3me.vv $V6, $V8, $V6   # v6 := {w32, w33, w34, w35, w36, w37, w38, w39}
+
+    # Prepare a register with {w35, w34, w33, w32, w31, w30, w29, w28}
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, X, X, w31, w30, w29, w28}
+    vslideup.vi $V4, $V6, 4   # v4 := {w35, w34, w33, w32, w31, w30, w29, w28}
+
+    vsm3c.vi $V0, $V4, 14
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, w35, w34, w33, w32, w31, w30}
+    vsm3c.vi $V0, $V4, 15
+
+    vsm3c.vi $V0, $V6, 16
+    vslidedown.vi $V4, $V6, 2 # v4 := {X, X, w39, w38, w37, w36, w35, w34}
+    vsm3c.vi $V0, $V4, 17
+
+    vsm3me.vv $V8, $V6, $V8   # v8 := {w47, w46, w45, w44, w43, w42, w41, w40}
+
+    # Prepare a register with {w43, w42, w41, w40, w39, w38, w37, w36}
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, X, X, w39, w38, w37, w36}
+    vslideup.vi $V4, $V8, 4   # v4 := {w43, w42, w41, w40, w39, w38, w37, w36}
+
+    vsm3c.vi $V0, $V4, 18
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, w43, w42, w41, w40, w39, w38}
+    vsm3c.vi $V0, $V4, 19
+
+    vsm3c.vi $V0, $V8, 20
+    vslidedown.vi $V4, $V8, 2 # v4 := {X, X, w47, w46, w45, w44, w43, w42}
+    vsm3c.vi $V0, $V4, 21
+
+    vsm3me.vv $V6, $V8, $V6   # v6 := {w55, w54, w53, w52, w51, w50, w49, w48}
+
+    # Prepare a register with {w51, w50, w49, w48, w47, w46, w45, w44}
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, X, X, w47, w46, w45, w44}
+    vslideup.vi $V4, $V6, 4   # v4 := {w51, w50, w49, w48, w47, w46, w45, w44}
+
+    vsm3c.vi $V0, $V4, 22
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, w51, w50, w49, w48, w47, w46}
+    vsm3c.vi $V0, $V4, 23
+
+    vsm3c.vi $V0, $V6, 24
+    vslidedown.vi $V4, $V6, 2 # v4 := {X, X, w55, w54, w53, w52, w51, w50}
+    vsm3c.vi $V0, $V4, 25
+
+    vsm3me.vv $V8, $V6, $V8   # v8 := {w63, w62, w61, w60, w59, w58, w57, w56}
+
+    # Prepare a register with {w59, w58, w57, w56, w55, w54, w53, w52}
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, X, X, w55, w54, w53, w52}
+    vslideup.vi $V4, $V8, 4   # v4 := {w59, w58, w57, w56, w55, w54, w53, w52}
+
+    vsm3c.vi $V0, $V4, 26
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, w59, w58, w57, w56, w55, w54}
+    vsm3c.vi $V0, $V4, 27
+
+    vsm3c.vi $V0, $V8, 28
+    vslidedown.vi $V4, $V8, 2 # v4 := {X, X, w63, w62, w61, w60, w59, w58}
+    vsm3c.vi $V0, $V4, 29
+
+    vsm3me.vv $V6, $V8, $V6   # v6 := {w71, w70, w69, w68, w67, w66, w65, w64}
+
+    # Prepare a register with {w67, w66, w65, w64, w63, w62, w61, w60}
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, X, X, w63, w62, w61, w60}
+    vslideup.vi $V4, $V6, 4   # v4 := {w67, w66, w65, w64, w63, w62, w61, w60}
+
+    vsm3c.vi $V0, $V4, 30
+    vslidedown.vi $V4, $V4, 2 # v4 := {X, X, w67, w66, w65, w64, w63, w62}
+    vsm3c.vi $V0, $V4, 31
+
+    # XOR in the previous state.
+    vxor.vv $V0, $V0, $V2
+
+    bnez $NUM, L_sm3_loop     # Check if there are any more block to process
+L_sm3_end:
+    vrev8.v $V0, $V0
+    vse32.v $V0, ($CTX)
+    ret
+SYM_FUNC_END(ossl_hwsm3_block_data_order_zvksh)
+___
+}
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.28.0


