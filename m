Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D1E7BCBF6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 06:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344358AbjJHEDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 00:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344270AbjJHEDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 00:03:04 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6217CBF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 21:03:00 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B40593F443
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 04:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696737778;
        bh=KNUhb7JfPoH/ZWd2y0jzmFcfaGuuwfFJNUXkv3vQhWQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Juk14414dQwI2iricBdGWyI8DHHYIYU9sGAU1WnD4sxnDI4EwRtALEbXiQ/5JbpAd
         LZ8r9Yy6TZCJrkEeKJk6WeM7A2FfA9LiAfjZZfIQ3fWGgJP4JDv/vMGxuBL6BEGwqV
         JE8V+sd7yWYZ9ssYrV24PzsAEPD159RmVGJGatoIHR5vDzWc6tcbQe+8Ki+qvu0BWC
         xRJGSPvrUAmlt3p/D7KwRAh5nGVn6aUm0tPvM+42NSyQ7P88Lpfc0nduZofCc/9NZ2
         rEFkMar1dyLJfeOftYBvRppQpsgoaye6rgF+acp3UsPtK0WMp69DpIAOGix0AeRy12
         zMTnfl/O/7E9w==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4059475c174so25405685e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 21:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696737778; x=1697342578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNUhb7JfPoH/ZWd2y0jzmFcfaGuuwfFJNUXkv3vQhWQ=;
        b=kzM2NovKONAjW2hz70+i5ncm0bFc7Uz6yEWGMKcqseJEugy5vMQujkMV9HIOUkpyP3
         lcUgMKPc69uLQg5Y8aftDgunMqoyx5aZWxxDFi9033rEv2Nz/jBuF04O21VwAUiSjuJR
         DNCBCYqlb2zrrmfG5yEnSru1kgDLcmAQvB268aLmp9L/KQxYcJkWfaJOl34sANHov+XM
         Kr61B3gQGonep0ouBEEeVpaD5jF3LVMZnsXsuDZVSeyrGgYjTAJF52QrK5fcG+I9BaTB
         ROh4YGSVNuG0QRwdpHdFbtV4H2m8+hxhyt7vwprSreQhB8x95tqWb/TNPYwpK+olaOOM
         dH9Q==
X-Gm-Message-State: AOJu0Ywp2tcpmVcWecs8hY1Ic8CdlUnhR+F4ofug6sNihnFHtebps0Xc
        T1AoK2xRzgHi54nukUatvb819+H250iBe252Gh6Z5ONuEvnzKfNKF+VPoWz3Y4uvKxsiYVwNuIm
        eyfGlhaQcH7uD8XoN+i5c48zmhHxbXKef+10qE9QIdw==
X-Received: by 2002:a1c:7705:0:b0:401:d947:c8a3 with SMTP id t5-20020a1c7705000000b00401d947c8a3mr10648517wmi.32.1696737778137;
        Sat, 07 Oct 2023 21:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSvtG29oiLOEwKEsBKoW5UzWmZ7ubq/JEAeObxG3cARx+kUXH4sJxWlAl/2jQLCpv3nwdJfQ==
X-Received: by 2002:a1c:7705:0:b0:401:d947:c8a3 with SMTP id t5-20020a1c7705000000b00401d947c8a3mr10648499wmi.32.1696737777512;
        Sat, 07 Oct 2023 21:02:57 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d5489000000b003179d5aee67sm5756839wrv.94.2023.10.07.21.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 21:02:57 -0700 (PDT)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] crypto: remove md4 driver
Date:   Sun,  8 Oct 2023 05:01:39 +0100
Message-Id: <20231008040140.1647892-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No internal users left and cryptographically insecure. Users should
upgrade to something else, e.g. sha256 blake3.

Some drivers have their own full or partial md4 implementation without
using crypto/md4.

Userspace code search indicates a few copies of hash_info.h
https://codesearch.debian.net/search?q=HASH_ALGO_MD4&literal=1 without
need for MD4.

Preserve uapi hash algorithm indexes and array length, but rename the
MD4 enum.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 crypto/Kconfig                 |   6 -
 crypto/Makefile                |   1 -
 crypto/hash_info.c             |   4 +-
 crypto/md4.c                   | 241 ---------------------------------
 crypto/tcrypt.c                |  12 --
 crypto/testmgr.c               |   6 -
 crypto/testmgr.h               |  42 ------
 include/uapi/linux/hash_info.h |   2 +-
 8 files changed, 3 insertions(+), 311 deletions(-)
 delete mode 100644 crypto/md4.c

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 650b1b3620..7d293a1ae8 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -946,12 +946,6 @@ config CRYPTO_HMAC
 
 	  This is required for IPsec AH (XFRM_AH) and IPsec ESP (XFRM_ESP).
 
-config CRYPTO_MD4
-	tristate "MD4"
-	select CRYPTO_HASH
-	help
-	  MD4 message digest algorithm (RFC1320)
-
 config CRYPTO_MD5
 	tristate "MD5"
 	select CRYPTO_HASH
diff --git a/crypto/Makefile b/crypto/Makefile
index 953a7e105e..67473c6fd1 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -72,7 +72,6 @@ obj-$(CONFIG_CRYPTO_HMAC) += hmac.o
 obj-$(CONFIG_CRYPTO_VMAC) += vmac.o
 obj-$(CONFIG_CRYPTO_XCBC) += xcbc.o
 obj-$(CONFIG_CRYPTO_NULL2) += crypto_null.o
-obj-$(CONFIG_CRYPTO_MD4) += md4.o
 obj-$(CONFIG_CRYPTO_MD5) += md5.o
 obj-$(CONFIG_CRYPTO_RMD160) += rmd160.o
 obj-$(CONFIG_CRYPTO_SHA1) += sha1_generic.o
diff --git a/crypto/hash_info.c b/crypto/hash_info.c
index a49ff96bde..7591ab8d48 100644
--- a/crypto/hash_info.c
+++ b/crypto/hash_info.c
@@ -9,7 +9,7 @@
 #include <crypto/hash_info.h>
 
 const char *const hash_algo_name[HASH_ALGO__LAST] = {
-	[HASH_ALGO_MD4]		= "md4",
+	[__REMOVED_HASH_ALGO_MD4] = "",
 	[HASH_ALGO_MD5]		= "md5",
 	[HASH_ALGO_SHA1]	= "sha1",
 	[HASH_ALGO_RIPE_MD_160]	= "rmd160",
@@ -33,7 +33,7 @@ const char *const hash_algo_name[HASH_ALGO__LAST] = {
 EXPORT_SYMBOL_GPL(hash_algo_name);
 
 const int hash_digest_size[HASH_ALGO__LAST] = {
-	[HASH_ALGO_MD4]		= MD5_DIGEST_SIZE,
+	[__REMOVED_HASH_ALGO_MD4] = 0,
 	[HASH_ALGO_MD5]		= MD5_DIGEST_SIZE,
 	[HASH_ALGO_SHA1]	= SHA1_DIGEST_SIZE,
 	[HASH_ALGO_RIPE_MD_160]	= RMD160_DIGEST_SIZE,
diff --git a/crypto/md4.c b/crypto/md4.c
deleted file mode 100644
index 2e7f2f319f..0000000000
--- a/crypto/md4.c
+++ /dev/null
@@ -1,241 +0,0 @@
-/* 
- * Cryptographic API.
- *
- * MD4 Message Digest Algorithm (RFC1320).
- *
- * Implementation derived from Andrew Tridgell and Steve French's
- * CIFS MD4 implementation, and the cryptoapi implementation
- * originally based on the public domain implementation written
- * by Colin Plumb in 1993.
- *
- * Copyright (c) Andrew Tridgell 1997-1998.
- * Modified by Steve French (sfrench@us.ibm.com) 2002
- * Copyright (c) Cryptoapi developers.
- * Copyright (c) 2002 David S. Miller (davem@redhat.com)
- * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-#include <crypto/internal/hash.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <asm/byteorder.h>
-
-#define MD4_DIGEST_SIZE		16
-#define MD4_HMAC_BLOCK_SIZE	64
-#define MD4_BLOCK_WORDS		16
-#define MD4_HASH_WORDS		4
-
-struct md4_ctx {
-	u32 hash[MD4_HASH_WORDS];
-	u32 block[MD4_BLOCK_WORDS];
-	u64 byte_count;
-};
-
-static inline u32 lshift(u32 x, unsigned int s)
-{
-	x &= 0xFFFFFFFF;
-	return ((x << s) & 0xFFFFFFFF) | (x >> (32 - s));
-}
-
-static inline u32 F(u32 x, u32 y, u32 z)
-{
-	return (x & y) | ((~x) & z);
-}
-
-static inline u32 G(u32 x, u32 y, u32 z)
-{
-	return (x & y) | (x & z) | (y & z);
-}
-
-static inline u32 H(u32 x, u32 y, u32 z)
-{
-	return x ^ y ^ z;
-}
-
-#define ROUND1(a,b,c,d,k,s) (a = lshift(a + F(b,c,d) + k, s))
-#define ROUND2(a,b,c,d,k,s) (a = lshift(a + G(b,c,d) + k + (u32)0x5A827999,s))
-#define ROUND3(a,b,c,d,k,s) (a = lshift(a + H(b,c,d) + k + (u32)0x6ED9EBA1,s))
-
-static void md4_transform(u32 *hash, u32 const *in)
-{
-	u32 a, b, c, d;
-
-	a = hash[0];
-	b = hash[1];
-	c = hash[2];
-	d = hash[3];
-
-	ROUND1(a, b, c, d, in[0], 3);
-	ROUND1(d, a, b, c, in[1], 7);
-	ROUND1(c, d, a, b, in[2], 11);
-	ROUND1(b, c, d, a, in[3], 19);
-	ROUND1(a, b, c, d, in[4], 3);
-	ROUND1(d, a, b, c, in[5], 7);
-	ROUND1(c, d, a, b, in[6], 11);
-	ROUND1(b, c, d, a, in[7], 19);
-	ROUND1(a, b, c, d, in[8], 3);
-	ROUND1(d, a, b, c, in[9], 7);
-	ROUND1(c, d, a, b, in[10], 11);
-	ROUND1(b, c, d, a, in[11], 19);
-	ROUND1(a, b, c, d, in[12], 3);
-	ROUND1(d, a, b, c, in[13], 7);
-	ROUND1(c, d, a, b, in[14], 11);
-	ROUND1(b, c, d, a, in[15], 19);
-
-	ROUND2(a, b, c, d,in[ 0], 3);
-	ROUND2(d, a, b, c, in[4], 5);
-	ROUND2(c, d, a, b, in[8], 9);
-	ROUND2(b, c, d, a, in[12], 13);
-	ROUND2(a, b, c, d, in[1], 3);
-	ROUND2(d, a, b, c, in[5], 5);
-	ROUND2(c, d, a, b, in[9], 9);
-	ROUND2(b, c, d, a, in[13], 13);
-	ROUND2(a, b, c, d, in[2], 3);
-	ROUND2(d, a, b, c, in[6], 5);
-	ROUND2(c, d, a, b, in[10], 9);
-	ROUND2(b, c, d, a, in[14], 13);
-	ROUND2(a, b, c, d, in[3], 3);
-	ROUND2(d, a, b, c, in[7], 5);
-	ROUND2(c, d, a, b, in[11], 9);
-	ROUND2(b, c, d, a, in[15], 13);
-
-	ROUND3(a, b, c, d,in[ 0], 3);
-	ROUND3(d, a, b, c, in[8], 9);
-	ROUND3(c, d, a, b, in[4], 11);
-	ROUND3(b, c, d, a, in[12], 15);
-	ROUND3(a, b, c, d, in[2], 3);
-	ROUND3(d, a, b, c, in[10], 9);
-	ROUND3(c, d, a, b, in[6], 11);
-	ROUND3(b, c, d, a, in[14], 15);
-	ROUND3(a, b, c, d, in[1], 3);
-	ROUND3(d, a, b, c, in[9], 9);
-	ROUND3(c, d, a, b, in[5], 11);
-	ROUND3(b, c, d, a, in[13], 15);
-	ROUND3(a, b, c, d, in[3], 3);
-	ROUND3(d, a, b, c, in[11], 9);
-	ROUND3(c, d, a, b, in[7], 11);
-	ROUND3(b, c, d, a, in[15], 15);
-
-	hash[0] += a;
-	hash[1] += b;
-	hash[2] += c;
-	hash[3] += d;
-}
-
-static inline void md4_transform_helper(struct md4_ctx *ctx)
-{
-	le32_to_cpu_array(ctx->block, ARRAY_SIZE(ctx->block));
-	md4_transform(ctx->hash, ctx->block);
-}
-
-static int md4_init(struct shash_desc *desc)
-{
-	struct md4_ctx *mctx = shash_desc_ctx(desc);
-
-	mctx->hash[0] = 0x67452301;
-	mctx->hash[1] = 0xefcdab89;
-	mctx->hash[2] = 0x98badcfe;
-	mctx->hash[3] = 0x10325476;
-	mctx->byte_count = 0;
-
-	return 0;
-}
-
-static int md4_update(struct shash_desc *desc, const u8 *data, unsigned int len)
-{
-	struct md4_ctx *mctx = shash_desc_ctx(desc);
-	const u32 avail = sizeof(mctx->block) - (mctx->byte_count & 0x3f);
-
-	mctx->byte_count += len;
-
-	if (avail > len) {
-		memcpy((char *)mctx->block + (sizeof(mctx->block) - avail),
-		       data, len);
-		return 0;
-	}
-
-	memcpy((char *)mctx->block + (sizeof(mctx->block) - avail),
-	       data, avail);
-
-	md4_transform_helper(mctx);
-	data += avail;
-	len -= avail;
-
-	while (len >= sizeof(mctx->block)) {
-		memcpy(mctx->block, data, sizeof(mctx->block));
-		md4_transform_helper(mctx);
-		data += sizeof(mctx->block);
-		len -= sizeof(mctx->block);
-	}
-
-	memcpy(mctx->block, data, len);
-
-	return 0;
-}
-
-static int md4_final(struct shash_desc *desc, u8 *out)
-{
-	struct md4_ctx *mctx = shash_desc_ctx(desc);
-	const unsigned int offset = mctx->byte_count & 0x3f;
-	char *p = (char *)mctx->block + offset;
-	int padding = 56 - (offset + 1);
-
-	*p++ = 0x80;
-	if (padding < 0) {
-		memset(p, 0x00, padding + sizeof (u64));
-		md4_transform_helper(mctx);
-		p = (char *)mctx->block;
-		padding = 56;
-	}
-
-	memset(p, 0, padding);
-	mctx->block[14] = mctx->byte_count << 3;
-	mctx->block[15] = mctx->byte_count >> 29;
-	le32_to_cpu_array(mctx->block, (sizeof(mctx->block) -
-	                  sizeof(u64)) / sizeof(u32));
-	md4_transform(mctx->hash, mctx->block);
-	cpu_to_le32_array(mctx->hash, ARRAY_SIZE(mctx->hash));
-	memcpy(out, mctx->hash, sizeof(mctx->hash));
-	memset(mctx, 0, sizeof(*mctx));
-
-	return 0;
-}
-
-static struct shash_alg alg = {
-	.digestsize	=	MD4_DIGEST_SIZE,
-	.init		=	md4_init,
-	.update		=	md4_update,
-	.final		=	md4_final,
-	.descsize	=	sizeof(struct md4_ctx),
-	.base		=	{
-		.cra_name	 =	"md4",
-		.cra_driver_name =	"md4-generic",
-		.cra_blocksize	 =	MD4_HMAC_BLOCK_SIZE,
-		.cra_module	 =	THIS_MODULE,
-	}
-};
-
-static int __init md4_mod_init(void)
-{
-	return crypto_register_shash(&alg);
-}
-
-static void __exit md4_mod_fini(void)
-{
-	crypto_unregister_shash(&alg);
-}
-
-subsys_initcall(md4_mod_init);
-module_exit(md4_mod_fini);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MD4 Message Digest Algorithm");
-MODULE_ALIAS_CRYPTO("md4");
diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 202ca1a310..22fde782d4 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -1487,10 +1487,6 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		ret = min(ret, tcrypt_test("ctr(des3_ede)"));
 		break;
 
-	case 5:
-		ret = min(ret, tcrypt_test("md4"));
-		break;
-
 	case 6:
 		ret = min(ret, tcrypt_test("sha256"));
 		break;
@@ -2228,10 +2224,6 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 			break;
 		}
 		fallthrough;
-	case 301:
-		test_hash_speed("md4", sec, generic_hash_speed_template);
-		if (mode > 300 && mode < 400) break;
-		fallthrough;
 	case 302:
 		test_hash_speed("md5", sec, generic_hash_speed_template);
 		if (mode > 300 && mode < 400) break;
@@ -2336,10 +2328,6 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 			break;
 		}
 		fallthrough;
-	case 401:
-		test_ahash_speed("md4", sec, generic_hash_speed_template);
-		if (mode > 400 && mode < 500) break;
-		fallthrough;
 	case 402:
 		test_ahash_speed("md5", sec, generic_hash_speed_template);
 		if (mode > 400 && mode < 500) break;
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 216878c8bc..7b1e4cf0fb 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5399,12 +5399,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 				.decomp = __VECS(lzorle_decomp_tv_template)
 			}
 		}
-	}, {
-		.alg = "md4",
-		.test = alg_test_hash,
-		.suite = {
-			.hash = __VECS(md4_tv_template)
-		}
 	}, {
 		.alg = "md5",
 		.test = alg_test_hash,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 5ca7a41250..3cfe91e2d1 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -4402,48 +4402,6 @@ static const struct kpp_testvec ecdh_p384_tv_template[] = {
 	}
 };
 
-/*
- * MD4 test vectors from RFC1320
- */
-static const struct hash_testvec md4_tv_template[] = {
-	{
-		.plaintext = "",
-		.digest	= "\x31\xd6\xcf\xe0\xd1\x6a\xe9\x31"
-			  "\xb7\x3c\x59\xd7\xe0\xc0\x89\xc0",
-	}, {
-		.plaintext = "a",
-		.psize	= 1,
-		.digest	= "\xbd\xe5\x2c\xb3\x1d\xe3\x3e\x46"
-			  "\x24\x5e\x05\xfb\xdb\xd6\xfb\x24",
-	}, {
-		.plaintext = "abc",
-		.psize	= 3,
-		.digest	= "\xa4\x48\x01\x7a\xaf\x21\xd8\x52"
-			  "\x5f\xc1\x0a\xe8\x7a\xa6\x72\x9d",
-	}, {
-		.plaintext = "message digest",
-		.psize	= 14,
-		.digest	= "\xd9\x13\x0a\x81\x64\x54\x9f\xe8"
-			"\x18\x87\x48\x06\xe1\xc7\x01\x4b",
-	}, {
-		.plaintext = "abcdefghijklmnopqrstuvwxyz",
-		.psize	= 26,
-		.digest	= "\xd7\x9e\x1c\x30\x8a\xa5\xbb\xcd"
-			  "\xee\xa8\xed\x63\xdf\x41\x2d\xa9",
-	}, {
-		.plaintext = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789",
-		.psize	= 62,
-		.digest	= "\x04\x3f\x85\x82\xf2\x41\xdb\x35"
-			  "\x1c\xe6\x27\xe1\x53\xe7\xf0\xe4",
-	}, {
-		.plaintext = "123456789012345678901234567890123456789012345678901234567890123"
-			   "45678901234567890",
-		.psize	= 80,
-		.digest	= "\xe3\x3b\x4d\xdc\x9c\x38\xf2\x19"
-			  "\x9c\x3e\x7b\x16\x4f\xcc\x05\x36",
-	},
-};
-
 static const struct hash_testvec sha3_224_tv_template[] = {
 	{
 		.plaintext = "",
diff --git a/include/uapi/linux/hash_info.h b/include/uapi/linux/hash_info.h
index 74a8609fcb..c8500e9c88 100644
--- a/include/uapi/linux/hash_info.h
+++ b/include/uapi/linux/hash_info.h
@@ -15,7 +15,7 @@
 #define _UAPI_LINUX_HASH_INFO_H
 
 enum hash_algo {
-	HASH_ALGO_MD4,
+	__REMOVED_HASH_ALGO_MD4, /* deprecated and removed */
 	HASH_ALGO_MD5,
 	HASH_ALGO_SHA1,
 	HASH_ALGO_RIPE_MD_160,
-- 
2.34.1

