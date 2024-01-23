Return-Path: <linux-kernel+bounces-34637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4902283857F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F035028A31D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3B24B5A6;
	Tue, 23 Jan 2024 02:29:08 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37C29408
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705976947; cv=none; b=S8Eh54ATCIXh12/wONW08XKsqU8+MT/pshRGZbITXFntAhmFJEYIJz8Lbkr9HW+cHNSjmk2GCNEj9CAecDtjA8Rvx6xLJ0m0tn0r7yombkHm5G6cu1sDmSvYvn8MlnhDje2zVuqzTEcGUq+ujHlc0bUmYze37bpkzz2vaHORLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705976947; c=relaxed/simple;
	bh=aKNudZURXkE0eh5I39W+olvacmX+u5O7V8geqBn7LkI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrAO5IOfhHaX5myFUDgMkb+WZU8uQeiPE1GcW7WNIiBQkdrYc3WYNgy/1bVFrDd+U6ln3XcaKwSrRlDqwQe4UFRIP/TH1rq2esyPv5kJT3sE/8ZU4G9+UIW/cQEX9PI2A3J1gRfZQA0ocCUvHLBTE8tLLtSYpUiougNaMP49y9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1705976941-1eb14e0c7e27290001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id TupZt8Zh9ZMPwTOL (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 23 Jan 2024 10:29:01 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 23 Jan
 2024 10:29:01 +0800
Received: from localhost.localdomain (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 23 Jan
 2024 10:28:58 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<seanjc@google.com>, <kim.phillips@amd.com>,
	<kirill.shutemov@linux.intel.com>, <jmattson@google.com>,
	<babu.moger@amd.com>, <kai.huang@intel.com>, <TonyWWang-oc@zhaoxin.com>,
	<acme@redhat.com>, <aik@amd.com>, <namhyung@kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	<GeorgeXue@zhaoxin.com>
Subject: [PATCH v2 3/3] crypto: Zhaoxin: Hardware Engine Driver for SHA1/256/384/512
Date: Tue, 23 Jan 2024 10:28:52 +0800
X-ASG-Orig-Subj: [PATCH v2 3/3] crypto: Zhaoxin: Hardware Engine Driver for SHA1/256/384/512
Message-ID: <20240123022852.2475-4-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123022852.2475-1-TonyWWang-oc@zhaoxin.com>
References: <20240123022852.2475-1-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1705976941
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 18963
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.119809
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

Zhaoxin CPUs have implemented the SHA(Secure Hash Algorithm) as its CPU
instructions, including SHA1, SHA256, SHA384 and SHA512, which conform
to the Secure Hash Algorithms specified by FIPS 180-3.

With the help of implementation of SHA in hardware instead of software,
can develop applications with higher performance, more security and more
flexibility.

Below table gives a summary of test using the driver tcrypt with different
crypt algorithm drivers on Zhaoxin KH-40000 platform:
---------------------------------------------------------------------------
tcrypt     driver   16*    64      256     1024    2048    4096    8192
---------------------------------------------------------------------------
           zhaoxin** 442.80 1309.21 3257.53 5221.56 5813.45 6136.39 6264.50***
403:SHA1   generic** 341.44 813.27  1458.98 1818.03 1896.60 1940.71 1939.06
           ratio    1.30   1.61    2.23    2.87    3.07    3.16    3.23
---------------------------------------------------------------------------
           zhaoxin  451.70 1313.65 2958.71 4658.55 5109.16 5359.08 5459.13
404:SHA256 generic  202.62 463.55  845.01  1070.50 1117.51 1144.79 1155.68
           ratio    2.23   2.83    3.50    4.35    4.57    4.68    4.72
---------------------------------------------------------------------------
           zhaoxin  350.90 1406.42 3166.16 5736.39 6627.77 7182.01 7429.18
405:SHA384 generic  161.76 654.88  979.06  1350.56 1423.08 1496.57 1513.12
           ratio    2.17   2.15    3.23    4.25    4.66    4.80    4.91
---------------------------------------------------------------------------
           zhaoxin  334.49 1394.71 3159.93 5728.86 6625.33 7169.23 7407.80
406:SHA512 generic  161.80 653.84  979.42  1351.41 1444.14 1495.35 1518.43
           ratio    2.07   2.13    3.23    4.24    4.59    4.79    4.88
---------------------------------------------------------------------------
*: The length of each data block to be processed by one complete SHA
   sequence, namely one INIT, multi UPDATEs and one FINAL.
**: Crypt algorithm driver used by tcrypt, "zhaoxin" represents zhaoxin-sha
   while "generic" represents the generic software SHA driver.
***: The speed of each crypt algorithm driver processing different length
   of data blocks, unit is Mb/s.

The ratio in the table implies the performance of SHA implemented by
zhaoxin-sha driver is much higher than the ones implemented by the generic
software driver of sha1/sha256/sha384/sha512.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 MAINTAINERS                  |   6 +
 drivers/crypto/Kconfig       |  16 ++
 drivers/crypto/Makefile      |   1 +
 drivers/crypto/zhaoxin-sha.c | 500 +++++++++++++++++++++++++++++++++++
 drivers/crypto/zhaoxin-sha.h |  17 ++
 5 files changed, 540 insertions(+)
 create mode 100644 drivers/crypto/zhaoxin-sha.c
 create mode 100644 drivers/crypto/zhaoxin-sha.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5e1049921..7d2bb64ea196 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24329,6 +24329,12 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	arch/x86/kernel/cpu/zhaoxin.c
 
+ZHAOXIN SHA SUPPORT
+M:	<TonyWWang-oc@zhaoxin.com>
+M:	<GeorgeXue@zhaoxin.com>
+S:	Maintained
+F:	drivers/crypto/zhaoxin-sha.c
+
 ZONEFS FILESYSTEM
 M:	Damien Le Moal <dlemoal@kernel.org>
 M:	Naohiro Aota <naohiro.aota@wdc.com>
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 0991f026cb07..97716b90e180 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -799,4 +799,20 @@ config CRYPTO_DEV_SA2UL
 source "drivers/crypto/aspeed/Kconfig"
 source "drivers/crypto/starfive/Kconfig"
 
+config CRYPTO_DEV_ZHAOXIN_SHA
+	tristate "Support for Zhaoxin SHA1/SHA256/SHA384/SHA512 algorithms"
+	depends on X86 && !UML
+	select CRYPTO_HASH
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	select CRYPTO_SHA384
+	select CRYPTO_SHA512
+	help
+	  Use Zhaoxin HW engine for SHA1/SHA256/SHA384/SHA512 algorithms.
+
+	  Available in ZX-C+ and newer processors.
+
+	  If unsure say M. The compiled module will be
+	  called zhaoxin-sha.
+
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index d859d6a5f3a4..b77c02d6dab7 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -51,3 +51,4 @@ obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += intel/
 obj-y += starfive/
+obj-$(CONFIG_CRYPTO_DEV_ZHAOXIN_SHA) += zhaoxin-sha.o
diff --git a/drivers/crypto/zhaoxin-sha.c b/drivers/crypto/zhaoxin-sha.c
new file mode 100644
index 000000000000..17242239edf2
--- /dev/null
+++ b/drivers/crypto/zhaoxin-sha.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Cryptographic API.
+ *
+ * Support for Zhaoxin hardware crypto engine.
+ *
+ * Copyright (c) 2023  George Xue <georgexue@zhaoxin.com>
+ */
+
+#include <crypto/internal/hash.h>
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/scatterlist.h>
+#include <asm/cpu_device_id.h>
+#include "zhaoxin-sha.h"
+
+static inline void zhaoxin_output_block(uint32_t *src, uint32_t *dst, size_t count)
+{
+	while (count--)
+		*dst++ = swab32(*src++);
+}
+
+static int zhaoxin_sha1_init(struct shash_desc *desc)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+
+	*sctx = (struct sha1_state){
+		.state = { SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4 },
+	};
+
+	return 0;
+}
+
+static int zhaoxin_sha1_update(struct shash_desc *desc, const u8 *data, unsigned int len)
+{
+	struct sha1_state *sctx = shash_desc_ctx(desc);
+	unsigned int partial, done;
+	const u8 *src;
+	u8 buf[SHA1_BLOCK_SIZE * 2];
+	u8 *dst = &buf[0];
+
+	partial = sctx->count & (SHA1_BLOCK_SIZE - 1);
+	sctx->count += len;
+	done = 0;
+	src = data;
+	memcpy(dst, sctx->state, SHA1_DIGEST_SIZE);
+
+	if ((partial + len) >= SHA1_BLOCK_SIZE) {
+
+		/* Append the bytes in state's buffer to a block to handle */
+		if (partial) {
+			done = -partial;
+			memcpy(sctx->buffer + partial, data, done + SHA1_BLOCK_SIZE);
+			src = sctx->buffer;
+
+			asm volatile (".byte 0xf3,0x0f,0xa6,0xc8"
+			: "+S"(src), "+D"(dst)
+			: "a"(-1L), "c"(1UL));
+
+			done += SHA1_BLOCK_SIZE;
+			src = data + done;
+		}
+
+		/* Process the left bytes from the input data */
+		if (len - done >= SHA1_BLOCK_SIZE) {
+			asm volatile (".byte 0xf3,0x0f,0xa6,0xc8"
+			: "+S"(src), "+D"(dst)
+			: "a"(-1L),
+			"c"((unsigned long)((len - done) / SHA1_BLOCK_SIZE)));
+
+			done += ((len - done) - (len - done) % SHA1_BLOCK_SIZE);
+			src = data + done;
+		}
+		partial = 0;
+	}
+	memcpy(sctx->state, dst, SHA1_DIGEST_SIZE);
+	memcpy(sctx->buffer + partial, src, len - done);
+
+	return 0;
+}
+
+static int zhaoxin_sha1_final(struct shash_desc *desc, u8 *out)
+{
+	struct sha1_state *state = shash_desc_ctx(desc);
+	unsigned int partial, padlen;
+	__be64 bits;
+	static const u8 padding[SHA1_BLOCK_SIZE] = {SHA_PADDING_BYTE, };
+	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
+
+	bits = cpu_to_be64(state->count << 3);
+
+	/* Padding */
+	partial = state->count & (SHA1_BLOCK_SIZE - 1);
+	padlen = (partial < bit_offset) ? (bit_offset - partial) :
+		((SHA1_BLOCK_SIZE + bit_offset) - partial);
+	zhaoxin_sha1_update(desc, padding, padlen);
+
+	/* Append length field bytes */
+	zhaoxin_sha1_update(desc, (const u8 *)&bits, sizeof(bits));
+
+	/* Swap to output */
+	zhaoxin_output_block(state->state, (uint32_t *)out, SHA1_DIGEST_SIZE/sizeof(uint32_t));
+
+	return 0;
+}
+
+static int zhaoxin_sha256_init(struct shash_desc *desc)
+{
+	struct sha256_state *sctx = shash_desc_ctx(desc);
+
+	*sctx = (struct sha256_state){
+		.state = { SHA256_H0, SHA256_H1, SHA256_H2, SHA256_H3,
+				SHA256_H4, SHA256_H5, SHA256_H6, SHA256_H7},
+	};
+
+	return 0;
+}
+
+static int zhaoxin_sha256_update(struct shash_desc *desc, const u8 *data,
+			  unsigned int len)
+{
+	struct sha256_state *sctx = shash_desc_ctx(desc);
+	unsigned int partial, done;
+	const u8 *src;
+	u8 buf[SHA256_BLOCK_SIZE*2];
+	u8 *dst = &buf[0];
+
+	partial = sctx->count & (SHA256_BLOCK_SIZE - 1);
+	sctx->count += len;
+	done = 0;
+	src = data;
+	memcpy(dst, sctx->state, SHA256_DIGEST_SIZE);
+
+	if ((partial + len) >= SHA256_BLOCK_SIZE) {
+
+		/* Append the bytes in state's buffer to a block to handle */
+		if (partial) {
+			done = -partial;
+			memcpy(sctx->buf + partial, data, done + SHA256_BLOCK_SIZE);
+			src = sctx->buf;
+
+			asm volatile (".byte 0xf3,0x0f,0xa6,0xd0"
+			: "+S"(src), "+D"(dst)
+			: "a"(-1L), "c"(1UL));
+
+			done += SHA256_BLOCK_SIZE;
+			src = data + done;
+		}
+
+		/* Process the left bytes from input data*/
+		if (len - done >= SHA256_BLOCK_SIZE) {
+			asm volatile (".byte 0xf3,0x0f,0xa6,0xd0"
+			: "+S"(src), "+D"(dst)
+			: "a"(-1L),
+			"c"((unsigned long)((len - done) / SHA256_BLOCK_SIZE)));
+
+			done += ((len - done) - (len - done) % SHA256_BLOCK_SIZE);
+			src = data + done;
+		}
+		partial = 0;
+	}
+	memcpy(sctx->state, dst, SHA256_DIGEST_SIZE);
+	memcpy(sctx->buf + partial, src, len - done);
+
+	return 0;
+}
+
+static int zhaoxin_sha256_final(struct shash_desc *desc, u8 *out)
+{
+	struct sha256_state *state = shash_desc_ctx(desc);
+	unsigned int partial, padlen;
+	__be64 bits;
+	static const u8 padding[SHA256_BLOCK_SIZE] = {SHA_PADDING_BYTE, };
+	const int bit_offset = SHA256_BLOCK_SIZE - sizeof(__be64);
+
+	bits = cpu_to_be64(state->count << 3);
+
+	/* Padding */
+	partial = state->count & (SHA256_BLOCK_SIZE - 1);
+	padlen = (partial < bit_offset) ? (bit_offset - partial) :
+		((SHA256_BLOCK_SIZE + bit_offset) - partial);
+	zhaoxin_sha256_update(desc, padding, padlen);
+
+	/* Append length field bytes */
+	zhaoxin_sha256_update(desc, (const u8 *)&bits, sizeof(bits));
+
+	/* Swap to output */
+	zhaoxin_output_block(state->state, (uint32_t *)out, SHA256_DIGEST_SIZE/sizeof(uint32_t));
+
+	return 0;
+}
+
+static inline void zhaoxin_output_block_512(uint64_t *src,
+			uint64_t *dst, size_t count)
+{
+	while (count--)
+		*dst++ = swab64(*src++);
+}
+
+static int zhaoxin_sha384_init(struct shash_desc *desc)
+{
+	struct sha512_state *sctx = shash_desc_ctx(desc);
+
+	*sctx = (struct sha512_state){
+		.state = { SHA384_H0, SHA384_H1, SHA384_H2, SHA384_H3,
+				SHA384_H4, SHA384_H5, SHA384_H6, SHA384_H7},
+		.count = {0, 0},
+	};
+
+	return 0;
+}
+
+static int zhaoxin_sha512_init(struct shash_desc *desc)
+{
+	struct sha512_state *sctx = shash_desc_ctx(desc);
+
+	*sctx = (struct sha512_state){
+		.state = { SHA512_H0, SHA512_H1, SHA512_H2, SHA512_H3,
+				SHA512_H4, SHA512_H5, SHA512_H6, SHA512_H7},
+		.count = {0, 0},
+	};
+
+	return 0;
+}
+
+static int zhaoxin_sha512_update(struct shash_desc *desc, const u8 *data,
+			  unsigned int len)
+{
+	struct sha512_state *sctx = shash_desc_ctx(desc);
+	unsigned int partial, done;
+	const u8 *src;
+	u8 buf[SHA512_BLOCK_SIZE];
+	u8 *dst = &buf[0];
+
+	partial = sctx->count[0] % SHA512_BLOCK_SIZE;
+
+	sctx->count[0] += len;
+	if (sctx->count[0] < len)
+		sctx->count[1]++;
+
+	done = 0;
+	src = data;
+	memcpy(dst, sctx->state, SHA512_DIGEST_SIZE);
+
+	if ((partial + len) >= SHA512_BLOCK_SIZE) {
+		/* Append the bytes in state's buffer to a block to handle */
+		if (partial) {
+
+			done = -partial;
+			memcpy(sctx->buf + partial, data, done + SHA512_BLOCK_SIZE);
+
+			src = sctx->buf;
+
+			asm volatile (".byte 0xf3,0x0f,0xa6,0xe0"
+			: "+S"(src), "+D"(dst)
+			: "c"(1UL));
+
+			done += SHA512_BLOCK_SIZE;
+			src = data + done;
+		}
+
+		/* Process the left bytes from input data*/
+		if (len - done >= SHA512_BLOCK_SIZE) {
+			asm volatile (".byte 0xf3,0x0f,0xa6,0xe0"
+			: "+S"(src), "+D"(dst)
+			: "c"((unsigned long)((len - done) / SHA512_BLOCK_SIZE)));
+
+			done += ((len - done) - (len - done) % SHA512_BLOCK_SIZE);
+			src = data + done;
+		}
+		partial = 0;
+	}
+
+	memcpy(sctx->state, dst, SHA512_DIGEST_SIZE);
+	memcpy(sctx->buf + partial, src, len - done);
+
+	return 0;
+}
+
+static int zhaoxin_sha512_final(struct shash_desc *desc, u8 *out)
+{
+	const int bit_offset = SHA512_BLOCK_SIZE - sizeof(__be64[2]);
+	struct sha512_state *state = shash_desc_ctx(desc);
+	unsigned int partial = state->count[0] % SHA512_BLOCK_SIZE, padlen;
+	__be64 bits2[2];
+
+	// Both SHA384 and SHA512 may be supported.
+	int dgst_size = crypto_shash_digestsize(desc->tfm);
+
+	static u8 padding[SHA512_BLOCK_SIZE];
+
+	memset(padding, 0, SHA512_BLOCK_SIZE);
+	padding[0] = SHA_PADDING_BYTE;
+
+	// Convert byte count in little endian to bit count in big endian.
+	bits2[0] = cpu_to_be64(state->count[1] << 3 | state->count[0] >> 61);
+	bits2[1] = cpu_to_be64(state->count[0] << 3);
+
+	padlen = (partial < bit_offset) ? (bit_offset - partial) :
+		((SHA512_BLOCK_SIZE + bit_offset) - partial);
+
+	zhaoxin_sha512_update(desc, padding, padlen);
+
+	/* Append length field bytes */
+	zhaoxin_sha512_update(desc, (const u8 *)bits2, sizeof(__be64[2]));
+
+	/* Swap to output */
+	zhaoxin_output_block_512(state->state, (uint64_t *)out, dgst_size/sizeof(uint64_t));
+
+	return 0;
+}
+
+static int zhaoxin_sha_export(struct shash_desc *desc,
+				void *out)
+{
+	int statesize = crypto_shash_statesize(desc->tfm);
+	void *sctx = shash_desc_ctx(desc);
+
+	memcpy(out, sctx, statesize);
+	return 0;
+}
+
+static int zhaoxin_sha_import(struct shash_desc *desc,
+				const void *in)
+{
+	int statesize = crypto_shash_statesize(desc->tfm);
+	void *sctx = shash_desc_ctx(desc);
+
+	memcpy(sctx, in, statesize);
+	return 0;
+}
+
+static struct shash_alg sha1_alg = {
+	.digestsize	=	SHA1_DIGEST_SIZE,
+	.init		=	zhaoxin_sha1_init,
+	.update		=	zhaoxin_sha1_update,
+	.final		=	zhaoxin_sha1_final,
+	.export		=	zhaoxin_sha_export,
+	.import		=	zhaoxin_sha_import,
+	.descsize	=	sizeof(struct sha1_state),
+	.statesize	=	sizeof(struct sha1_state),
+	.base		=	{
+		.cra_name		=	"sha1",
+		.cra_driver_name	=	"sha1-zhaoxin",
+		.cra_priority		=	ZHAOXIN_SHA_CRA_PRIORITY,
+		.cra_blocksize		=	SHA1_BLOCK_SIZE,
+		.cra_module		=	THIS_MODULE,
+	}
+};
+
+static struct shash_alg sha256_alg = {
+	.digestsize	=	SHA256_DIGEST_SIZE,
+	.init		=	zhaoxin_sha256_init,
+	.update		=	zhaoxin_sha256_update,
+	.final		=	zhaoxin_sha256_final,
+	.export		=	zhaoxin_sha_export,
+	.import		=	zhaoxin_sha_import,
+	.descsize	=	sizeof(struct sha256_state),
+	.statesize	=	sizeof(struct sha256_state),
+	.base		=	{
+		.cra_name		=	"sha256",
+		.cra_driver_name	=	"sha256-zhaoxin",
+		.cra_priority		=	ZHAOXIN_SHA_CRA_PRIORITY,
+		.cra_blocksize		=	SHA256_BLOCK_SIZE,
+		.cra_module		=	THIS_MODULE,
+	}
+};
+
+static struct shash_alg sha384_alg = {
+	.digestsize	=	SHA384_DIGEST_SIZE,
+	.init		=	zhaoxin_sha384_init,
+	.update		=	zhaoxin_sha512_update,
+	.final		=	zhaoxin_sha512_final,
+	.export		=	zhaoxin_sha_export,
+	.import		=	zhaoxin_sha_import,
+	.descsize	=	sizeof(struct sha512_state),
+	.statesize	=	sizeof(struct sha512_state),
+	.base		=	{
+		.cra_name		=	"sha384",
+		.cra_driver_name	=	"sha384-zhaoxin",
+		.cra_priority		=	ZHAOXIN_SHA_CRA_PRIORITY,
+		.cra_blocksize		=	SHA384_BLOCK_SIZE,
+		.cra_module		=	THIS_MODULE,
+	}
+};
+
+static struct shash_alg sha512_alg = {
+	.digestsize	=	SHA512_DIGEST_SIZE,
+	.init		=	zhaoxin_sha512_init,
+	.update		=	zhaoxin_sha512_update,
+	.final		=	zhaoxin_sha512_final,
+	.export		=	zhaoxin_sha_export,
+	.import		=	zhaoxin_sha_import,
+	.descsize	=	sizeof(struct sha512_state),
+	.statesize	=	sizeof(struct sha512_state),
+	.base		=	{
+		.cra_name		=	"sha512",
+		.cra_driver_name	=	"sha512-zhaoxin",
+		.cra_priority		=	ZHAOXIN_SHA_CRA_PRIORITY,
+		.cra_blocksize		=	SHA512_BLOCK_SIZE,
+		.cra_module		=	THIS_MODULE,
+	}
+};
+
+
+static const struct x86_cpu_id zhaoxin_sha_ids[] = {
+	X86_MATCH_VENDOR_FAM_FEATURE(ZHAOXIN, 6, X86_FEATURE_PHE, NULL),
+	X86_MATCH_VENDOR_FAM_FEATURE(ZHAOXIN, 7, X86_FEATURE_PHE, NULL),
+	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 7, X86_FEATURE_PHE, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, zhaoxin_sha_ids);
+
+static int __init zhaoxin_sha_init(void)
+{
+	int rc = -ENODEV;
+
+	struct shash_alg *sha1;
+	struct shash_alg *sha256;
+	struct shash_alg *sha384;
+	struct shash_alg *sha512;
+
+	if (!x86_match_cpu(zhaoxin_sha_ids) || !boot_cpu_has(X86_FEATURE_PHE_EN))
+		return -ENODEV;
+
+	sha1 = &sha1_alg;
+	sha256 = &sha256_alg;
+
+	rc = crypto_register_shash(sha1);
+	if (rc)
+		goto out;
+
+	rc = crypto_register_shash(sha256);
+	if (rc)
+		goto out_unreg1;
+
+	if (boot_cpu_has(X86_FEATURE_PHE2_EN)) {
+
+		sha384 = &sha384_alg;
+		sha512 = &sha512_alg;
+
+		rc = crypto_register_shash(sha384);
+		if (rc)
+			goto out_unreg2;
+
+		rc = crypto_register_shash(sha512);
+		if (rc)
+			goto out_unreg3;
+
+		pr_notice("Using Zhaoxin Hardware Engine for SHA1/SHA256/SHA384/SHA512 algorithms.\n");
+	} else
+		pr_notice("Using Zhaoxin Hardware Engine for SHA1/SHA256 algorithms.\n");
+
+
+	return 0;
+
+out_unreg3:
+	if (boot_cpu_has(X86_FEATURE_PHE2_EN))
+		crypto_unregister_shash(sha384);
+
+out_unreg2:
+	crypto_unregister_shash(sha256);
+out_unreg1:
+	crypto_unregister_shash(sha1);
+
+out:
+	pr_err("Zhaoxin Hardware Engine for SHA1/SHA256/SHA384/SHA512 initialization failed.\n");
+	return rc;
+}
+
+static void __exit zhaoxin_sha_fini(void)
+{
+	crypto_unregister_shash(&sha1_alg);
+	crypto_unregister_shash(&sha256_alg);
+
+	if (boot_cpu_has(X86_FEATURE_PHE2_EN)) {
+		crypto_unregister_shash(&sha384_alg);
+		crypto_unregister_shash(&sha512_alg);
+	}
+
+}
+
+module_init(zhaoxin_sha_init);
+module_exit(zhaoxin_sha_fini);
+
+MODULE_DESCRIPTION("Zhaoxin Hardware SHA1/SHA256/SHA384/SHA512 algorithms support.");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("George Xue");
+
+MODULE_ALIAS_CRYPTO("sha1-zhaoxin");
+MODULE_ALIAS_CRYPTO("sha256-zhaoxin");
+MODULE_ALIAS_CRYPTO("sha384-zhaoxin");
+MODULE_ALIAS_CRYPTO("sha512-zhaoxin");
+
diff --git a/drivers/crypto/zhaoxin-sha.h b/drivers/crypto/zhaoxin-sha.h
new file mode 100644
index 000000000000..699659018d19
--- /dev/null
+++ b/drivers/crypto/zhaoxin-sha.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Zhaoxin Sha
+ *
+ * Copyright (c) 2023 George Xue<georgexue@zhaoxin.com>
+ */
+
+#ifndef _ZHAOXIN_SHA_H
+#define _ZHAOXIN_SHA_H
+
+#define ZHAOXIN_SHA_CRA_PRIORITY	300
+#define ZHAOXIN_SHA_COMPOSITE_PRIORITY 400
+
+#define SHA_PADDING_BYTE    0x80
+
+#endif	/* _ZHAOXIN_SHA_H */
+
-- 
2.25.1


