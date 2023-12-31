Return-Path: <linux-kernel+bounces-13736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA730820BCE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D701C21408
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAABD2E0;
	Sun, 31 Dec 2023 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QvHNBoU3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF832847D
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3e05abcaeso37332705ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 07:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704036493; x=1704641293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkFJu6wbfKrNvlCJDFW6tY4AkgVd3nqkM4USIeuwRmw=;
        b=QvHNBoU3nXTJAH53jVLmKL6DT3HJ8/NOiocXHShiiF6LnZZIgmCrqvPXYkb0ecLXxl
         lyCHIrgREI+K7IwPhsZFnN3f3XoF7A04FXKub+9eMZPjeZI4Fbhk3/KojpieyyOoqMrV
         17CpHnyDdtYYkZ/2kiAZLAKIwVfz7ZpmmRdOu+sQ1eLSaP/U7JSr/ScW/CC4hmOxviCH
         AShYxEUSGF+ONdCzWQz0u6nwqh7PkZ/aWaOwRKCfkS18joLvZ6Hffq4QRe3rUUQ5sfVv
         +t5dbuXynf3aiguNp8wwtnRIGkqtkL/6YDZDabINDlECZkPkKdEoivZO3ZBj7q9STn74
         WS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704036493; x=1704641293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkFJu6wbfKrNvlCJDFW6tY4AkgVd3nqkM4USIeuwRmw=;
        b=WBEI3sdO/E3JtMMLkXav1TgGwigVkjgmgxzuiNz540c9MQsiPV6nJHI52qnjG+Mr4x
         sh7Hqge4YMVoS+7IM33xAVwbktrwWeLGL8lbik7iVDW1oIYjt9PsbsxJ0bqgEP6TQDmr
         Hr/g/d6YvutnS2QjFCEKtIf2h0aoTuEOtCnSmn9wn8OQJTD3BuxaKbzFP7RjDrSTZ7Fs
         Uk8IS2+v6f4aXnZi6dFHfZcuvJ0nHN5Gq9FSO9/Ux7jmOojUsGXLjzXdVpXVdghdpQIm
         fD4RG7C9JAfO4X5QqmU5Ciyf9MzLiTOgUM2A/MgMN9pGtsKgzU5g+IVglVjPuKCUkeov
         mKEg==
X-Gm-Message-State: AOJu0Yzupk7wvptQjBa937Eeogb1vYXl9/028uyErZwXuefmNEha8bzo
	C0Xi7xA3iEL3ZFkui14F8Efkdykogd+LtQ==
X-Google-Smtp-Source: AGHT+IHIPKMRiqbavN1oME66IycwcLAtZ7yhnlsI4BJbgS3NesqNBwv7KKtpU/UoQkmQzm9DzCAALA==
X-Received: by 2002:a17:903:32cc:b0:1d4:cae:9a05 with SMTP id i12-20020a17090332cc00b001d40cae9a05mr7664302plr.2.1704036493285;
        Sun, 31 Dec 2023 07:28:13 -0800 (PST)
Received: from localhost.localdomain ([49.216.222.63])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001cc3c521affsm18624430plf.300.2023.12.31.07.28.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Dec 2023 07:28:12 -0800 (PST)
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
Subject: [PATCH v4 06/11] RISC-V: crypto: add Zvkg accelerated GCM GHASH implementation
Date: Sun, 31 Dec 2023 23:27:38 +0800
Message-Id: <20231231152743.6304-7-jerry.shih@sifive.com>
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

Add a gcm hash implementation using the Zvkg extension from OpenSSL
(openssl/openssl#21923).

The perlasm here is different from the original implementation in OpenSSL.
The OpenSSL assumes that the H is stored in little-endian. Thus, it needs
to convert the H to big-endian for Zvkg instructions. In kernel, we have
the big-endian H directly. There is no need for endian conversion.

Co-developed-by: Christoph Müllner <christoph.muellner@vrull.eu>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Co-developed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
---
Changelog v4:
 - Use asm mnemonics for the instructions in vector crypto 1.0 extension.

Changelog v3:
 - Use asm mnemonics for the instructions in RVV 1.0 extension.

Changelog v2:
 - Do not turn on kconfig `GHASH_RISCV64` option by default.
 - Add `asmlinkage` qualifier for crypto asm function.
 - Update the ghash fallback path in ghash_blocks().
 - Rename structure riscv64_ghash_context to riscv64_ghash_tfm_ctx.
 - Fold ghash_update_zvkg() and ghash_final_zvkg().
 - Reorder structure riscv64_ghash_alg_zvkg members initialization in the
   order declared.
---
 arch/riscv/crypto/Kconfig               |  10 ++
 arch/riscv/crypto/Makefile              |   7 +
 arch/riscv/crypto/ghash-riscv64-glue.c  | 175 ++++++++++++++++++++++++
 arch/riscv/crypto/ghash-riscv64-zvkg.pl | 100 ++++++++++++++
 4 files changed, 292 insertions(+)
 create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
 create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.pl

diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
index 2cee0f68f0c7..d73b89ceb1a3 100644
--- a/arch/riscv/crypto/Kconfig
+++ b/arch/riscv/crypto/Kconfig
@@ -34,4 +34,14 @@ config CRYPTO_AES_BLOCK_RISCV64
 	  - Zvkb vector crypto extension (CTR/XTS)
 	  - Zvkg vector crypto extension (XTS)
 
+config CRYPTO_GHASH_RISCV64
+	tristate "Hash functions: GHASH"
+	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
+	select CRYPTO_GCM
+	help
+	  GCM GHASH function (NIST SP 800-38D)
+
+	  Architecture: riscv64 using:
+	  - Zvkg vector crypto extension
+
 endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
index 9574b009762f..94a7f8eaa8a7 100644
--- a/arch/riscv/crypto/Makefile
+++ b/arch/riscv/crypto/Makefile
@@ -9,6 +9,9 @@ aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o
 obj-$(CONFIG_CRYPTO_AES_BLOCK_RISCV64) += aes-block-riscv64.o
 aes-block-riscv64-y := aes-riscv64-block-mode-glue.o aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
 
+obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
+ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $(<) void $(@)
 
@@ -21,6 +24,10 @@ $(obj)/aes-riscv64-zvkned-zvbb-zvkg.S: $(src)/aes-riscv64-zvkned-zvbb-zvkg.pl
 $(obj)/aes-riscv64-zvkned-zvkb.S: $(src)/aes-riscv64-zvkned-zvkb.pl
 	$(call cmd,perlasm)
 
+$(obj)/ghash-riscv64-zvkg.S: $(src)/ghash-riscv64-zvkg.pl
+	$(call cmd,perlasm)
+
 clean-files += aes-riscv64-zvkned.S
 clean-files += aes-riscv64-zvkned-zvbb-zvkg.S
 clean-files += aes-riscv64-zvkned-zvkb.S
+clean-files += ghash-riscv64-zvkg.S
diff --git a/arch/riscv/crypto/ghash-riscv64-glue.c b/arch/riscv/crypto/ghash-riscv64-glue.c
new file mode 100644
index 000000000000..b01ab5714677
--- /dev/null
+++ b/arch/riscv/crypto/ghash-riscv64-glue.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V optimized GHASH routines
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
+#include <crypto/ghash.h>
+#include <crypto/internal/hash.h>
+#include <crypto/internal/simd.h>
+#include <linux/crypto.h>
+#include <linux/linkage.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+/* ghash using zvkg vector crypto extension */
+asmlinkage void gcm_ghash_rv64i_zvkg(be128 *Xi, const be128 *H, const u8 *inp,
+				     size_t len);
+
+struct riscv64_ghash_tfm_ctx {
+	be128 key;
+};
+
+struct riscv64_ghash_desc_ctx {
+	be128 shash;
+	u8 buffer[GHASH_BLOCK_SIZE];
+	u32 bytes;
+};
+
+static inline void ghash_blocks(const struct riscv64_ghash_tfm_ctx *tctx,
+				struct riscv64_ghash_desc_ctx *dctx,
+				const u8 *src, size_t srclen)
+{
+	/* The srclen is nonzero and a multiple of 16. */
+	if (crypto_simd_usable()) {
+		kernel_vector_begin();
+		gcm_ghash_rv64i_zvkg(&dctx->shash, &tctx->key, src, srclen);
+		kernel_vector_end();
+	} else {
+		do {
+			crypto_xor((u8 *)&dctx->shash, src, GHASH_BLOCK_SIZE);
+			gf128mul_lle(&dctx->shash, &tctx->key);
+			srclen -= GHASH_BLOCK_SIZE;
+			src += GHASH_BLOCK_SIZE;
+		} while (srclen);
+	}
+}
+
+static int ghash_init(struct shash_desc *desc)
+{
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	*dctx = (struct riscv64_ghash_desc_ctx){};
+
+	return 0;
+}
+
+static int ghash_update_zvkg(struct shash_desc *desc, const u8 *src,
+			     unsigned int srclen)
+{
+	size_t len;
+	const struct riscv64_ghash_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+
+	if (dctx->bytes) {
+		if (dctx->bytes + srclen < GHASH_BLOCK_SIZE) {
+			memcpy(dctx->buffer + dctx->bytes, src, srclen);
+			dctx->bytes += srclen;
+			return 0;
+		}
+		memcpy(dctx->buffer + dctx->bytes, src,
+		       GHASH_BLOCK_SIZE - dctx->bytes);
+
+		ghash_blocks(tctx, dctx, dctx->buffer, GHASH_BLOCK_SIZE);
+
+		src += GHASH_BLOCK_SIZE - dctx->bytes;
+		srclen -= GHASH_BLOCK_SIZE - dctx->bytes;
+		dctx->bytes = 0;
+	}
+	len = srclen & ~(GHASH_BLOCK_SIZE - 1);
+
+	if (len) {
+		ghash_blocks(tctx, dctx, src, len);
+		src += len;
+		srclen -= len;
+	}
+
+	if (srclen) {
+		memcpy(dctx->buffer, src, srclen);
+		dctx->bytes = srclen;
+	}
+
+	return 0;
+}
+
+static int ghash_final_zvkg(struct shash_desc *desc, u8 *out)
+{
+	const struct riscv64_ghash_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
+	struct riscv64_ghash_desc_ctx *dctx = shash_desc_ctx(desc);
+	int i;
+
+	if (dctx->bytes) {
+		for (i = dctx->bytes; i < GHASH_BLOCK_SIZE; i++)
+			dctx->buffer[i] = 0;
+
+		ghash_blocks(tctx, dctx, dctx->buffer, GHASH_BLOCK_SIZE);
+	}
+
+	memcpy(out, &dctx->shash, GHASH_DIGEST_SIZE);
+
+	return 0;
+}
+
+static int ghash_setkey(struct crypto_shash *tfm, const u8 *key,
+			unsigned int keylen)
+{
+	struct riscv64_ghash_tfm_ctx *tctx = crypto_shash_ctx(tfm);
+
+	if (keylen != GHASH_BLOCK_SIZE)
+		return -EINVAL;
+
+	memcpy(&tctx->key, key, GHASH_BLOCK_SIZE);
+
+	return 0;
+}
+
+static struct shash_alg riscv64_ghash_alg_zvkg = {
+	.init = ghash_init,
+	.update = ghash_update_zvkg,
+	.final = ghash_final_zvkg,
+	.setkey = ghash_setkey,
+	.descsize = sizeof(struct riscv64_ghash_desc_ctx),
+	.digestsize = GHASH_DIGEST_SIZE,
+	.base = {
+		.cra_blocksize = GHASH_BLOCK_SIZE,
+		.cra_ctxsize = sizeof(struct riscv64_ghash_tfm_ctx),
+		.cra_priority = 303,
+		.cra_name = "ghash",
+		.cra_driver_name = "ghash-riscv64-zvkg",
+		.cra_module = THIS_MODULE,
+	},
+};
+
+static inline bool check_ghash_ext(void)
+{
+	return riscv_isa_extension_available(NULL, ZVKG) &&
+	       riscv_vector_vlen() >= 128;
+}
+
+static int __init riscv64_ghash_mod_init(void)
+{
+	if (check_ghash_ext())
+		return crypto_register_shash(&riscv64_ghash_alg_zvkg);
+
+	return -ENODEV;
+}
+
+static void __exit riscv64_ghash_mod_fini(void)
+{
+	crypto_unregister_shash(&riscv64_ghash_alg_zvkg);
+}
+
+module_init(riscv64_ghash_mod_init);
+module_exit(riscv64_ghash_mod_fini);
+
+MODULE_DESCRIPTION("GCM GHASH (RISC-V accelerated)");
+MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CRYPTO("ghash");
diff --git a/arch/riscv/crypto/ghash-riscv64-zvkg.pl b/arch/riscv/crypto/ghash-riscv64-zvkg.pl
new file mode 100644
index 000000000000..f18824496573
--- /dev/null
+++ b/arch/riscv/crypto/ghash-riscv64-zvkg.pl
@@ -0,0 +1,100 @@
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
+# - RV64I
+# - RISC-V Vector ('V') with VLEN >= 128
+# - RISC-V Vector GCM/GMAC extension ('Zvkg')
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
+.text
+.option arch, +zvkg
+___
+
+###############################################################################
+# void gcm_ghash_rv64i_zvkg(be128 *Xi, const be128 *H, const u8 *inp, size_t len)
+#
+# input: Xi: current hash value
+#        H: hash key
+#        inp: pointer to input data
+#        len: length of input data in bytes (multiple of block size)
+# output: Xi: Xi+1 (next hash value Xi)
+{
+my ($Xi,$H,$inp,$len) = ("a0","a1","a2","a3");
+my ($vXi,$vH,$vinp,$Vzero) = ("v1","v2","v3","v4");
+
+$code .= <<___;
+.p2align 3
+.globl gcm_ghash_rv64i_zvkg
+.type gcm_ghash_rv64i_zvkg,\@function
+gcm_ghash_rv64i_zvkg:
+    vsetivli zero, 4, e32, m1, ta, ma
+    vle32.v $vH, ($H)
+    vle32.v $vXi, ($Xi)
+
+Lstep:
+    vle32.v $vinp, ($inp)
+    add $inp, $inp, 16
+    add $len, $len, -16
+    vghsh.vv $vXi, $vH, $vinp
+    bnez $len, Lstep
+
+    vse32.v $vXi, ($Xi)
+    ret
+
+.size gcm_ghash_rv64i_zvkg,.-gcm_ghash_rv64i_zvkg
+___
+}
+
+print $code;
+
+close STDOUT or die "error closing STDOUT: $!";
-- 
2.28.0


