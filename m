Return-Path: <linux-kernel+bounces-116337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 071BB889E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA091F37707
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982217F37B;
	Mon, 25 Mar 2024 03:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPi/vjOW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F5184F0A;
	Sun, 24 Mar 2024 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324340; cv=none; b=pZH4+WDsoktXrHoPoN/jtlJl/DYOdzyWPZ+3Rd9aNnD2TSk5ptbEqDqkCx6swUUBDFdWhbagKToJvjg3bjyFhYHr9O6/XkBvmGDkJt9GsY3VMA2J74972g7v0ZOOMHgkrpFHwQXUhYn26QQnvjqTw3TfLaYVwmS8V4jtHtUIhfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324340; c=relaxed/simple;
	bh=5bMpDei5pQBV7TFItVqG+PgNFyz4lHjg/J19IK10tro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9o6FW4yUOlJbz5/R8bDL5aazHjuKIABpjuz6HiwKVcBdFoUsdVyVfdKqid+qwY1Yu0pHRFmVFT2zN3uj1vQzFJR3jvJZd4lRLKEkPiP4jlIuI/SliFAwjtRz0W5uvpvplLdAu2PHx4jRnw+msnuvhma1koiQ37x26QzOeVO4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPi/vjOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76538C433C7;
	Sun, 24 Mar 2024 23:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324340;
	bh=5bMpDei5pQBV7TFItVqG+PgNFyz4lHjg/J19IK10tro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPi/vjOWoDdkz8HlmaIZrC3Zg9MG0POta1VI8MFT4IMwgAcrGrS1umb3LDw6bNw2O
	 JzHV4mDqWpeFbP+MPtgUtbjyEAEbLE01dQ3EtrnuwkW3+i/87H4KHE+nlrtyO032LX
	 +RVEu18AJ7pfngedLQzlwEOhTOOqzSZPSv0o5nuGIS/K09uxQhpoj41TQvbrjRTR6e
	 l6QuYm8WgpZQkcKa0nNC2Rzh+M6Fo6pcRwsEVzXE/ecq7tE/ZxEX4UY9n6/liH5PDX
	 s5dMV4yL+ReF1+UT+fBJKmvqb6n+3VUl6F/mJggw2J2dfmLAJvKxcbRy1/CWfJfhR3
	 f/xXgdG4U8dbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 110/148] crypto: arm - Rename functions to avoid conflict with crypto/sha256.h
Date: Sun, 24 Mar 2024 19:49:34 -0400
Message-ID: <20240324235012.1356413-111-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit e4dcc1be15268b6d34de3968f906577591521bd5 ]

Rename static / file-local functions so that they do not conflict with
the functions declared in crypto/sha256.h.

This is a preparation patch for folding crypto/sha256.h into crypto/sha.h.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 53cc9baeb9bc ("crypto: arm/sha - fix function cast warnings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/crypto/sha256_glue.c      |  8 ++++----
 arch/arm/crypto/sha256_neon_glue.c | 24 ++++++++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/crypto/sha256_glue.c b/arch/arm/crypto/sha256_glue.c
index 0ae900e778f3b..040c744ef9f50 100644
--- a/arch/arm/crypto/sha256_glue.c
+++ b/arch/arm/crypto/sha256_glue.c
@@ -44,7 +44,7 @@ int crypto_sha256_arm_update(struct shash_desc *desc, const u8 *data,
 }
 EXPORT_SYMBOL(crypto_sha256_arm_update);
 
-static int sha256_final(struct shash_desc *desc, u8 *out)
+static int crypto_sha256_arm_final(struct shash_desc *desc, u8 *out)
 {
 	sha256_base_do_finalize(desc,
 				(sha256_block_fn *)sha256_block_data_order);
@@ -56,7 +56,7 @@ int crypto_sha256_arm_finup(struct shash_desc *desc, const u8 *data,
 {
 	sha256_base_do_update(desc, data, len,
 			      (sha256_block_fn *)sha256_block_data_order);
-	return sha256_final(desc, out);
+	return crypto_sha256_arm_final(desc, out);
 }
 EXPORT_SYMBOL(crypto_sha256_arm_finup);
 
@@ -64,7 +64,7 @@ static struct shash_alg algs[] = { {
 	.digestsize	=	SHA256_DIGEST_SIZE,
 	.init		=	sha256_base_init,
 	.update		=	crypto_sha256_arm_update,
-	.final		=	sha256_final,
+	.final		=	crypto_sha256_arm_final,
 	.finup		=	crypto_sha256_arm_finup,
 	.descsize	=	sizeof(struct sha256_state),
 	.base		=	{
@@ -78,7 +78,7 @@ static struct shash_alg algs[] = { {
 	.digestsize	=	SHA224_DIGEST_SIZE,
 	.init		=	sha224_base_init,
 	.update		=	crypto_sha256_arm_update,
-	.final		=	sha256_final,
+	.final		=	crypto_sha256_arm_final,
 	.finup		=	crypto_sha256_arm_finup,
 	.descsize	=	sizeof(struct sha256_state),
 	.base		=	{
diff --git a/arch/arm/crypto/sha256_neon_glue.c b/arch/arm/crypto/sha256_neon_glue.c
index 1d82c6cd31a41..8d296529c8ba7 100644
--- a/arch/arm/crypto/sha256_neon_glue.c
+++ b/arch/arm/crypto/sha256_neon_glue.c
@@ -29,8 +29,8 @@
 asmlinkage void sha256_block_data_order_neon(u32 *digest, const void *data,
 					     unsigned int num_blks);
 
-static int sha256_update(struct shash_desc *desc, const u8 *data,
-			 unsigned int len)
+static int crypto_sha256_neon_update(struct shash_desc *desc, const u8 *data,
+				     unsigned int len)
 {
 	struct sha256_state *sctx = shash_desc_ctx(desc);
 
@@ -46,8 +46,8 @@ static int sha256_update(struct shash_desc *desc, const u8 *data,
 	return 0;
 }
 
-static int sha256_finup(struct shash_desc *desc, const u8 *data,
-			unsigned int len, u8 *out)
+static int crypto_sha256_neon_finup(struct shash_desc *desc, const u8 *data,
+				    unsigned int len, u8 *out)
 {
 	if (!may_use_simd())
 		return crypto_sha256_arm_finup(desc, data, len, out);
@@ -63,17 +63,17 @@ static int sha256_finup(struct shash_desc *desc, const u8 *data,
 	return sha256_base_finish(desc, out);
 }
 
-static int sha256_final(struct shash_desc *desc, u8 *out)
+static int crypto_sha256_neon_final(struct shash_desc *desc, u8 *out)
 {
-	return sha256_finup(desc, NULL, 0, out);
+	return crypto_sha256_neon_finup(desc, NULL, 0, out);
 }
 
 struct shash_alg sha256_neon_algs[] = { {
 	.digestsize	=	SHA256_DIGEST_SIZE,
 	.init		=	sha256_base_init,
-	.update		=	sha256_update,
-	.final		=	sha256_final,
-	.finup		=	sha256_finup,
+	.update		=	crypto_sha256_neon_update,
+	.final		=	crypto_sha256_neon_final,
+	.finup		=	crypto_sha256_neon_finup,
 	.descsize	=	sizeof(struct sha256_state),
 	.base		=	{
 		.cra_name	=	"sha256",
@@ -85,9 +85,9 @@ struct shash_alg sha256_neon_algs[] = { {
 }, {
 	.digestsize	=	SHA224_DIGEST_SIZE,
 	.init		=	sha224_base_init,
-	.update		=	sha256_update,
-	.final		=	sha256_final,
-	.finup		=	sha256_finup,
+	.update		=	crypto_sha256_neon_update,
+	.final		=	crypto_sha256_neon_final,
+	.finup		=	crypto_sha256_neon_finup,
 	.descsize	=	sizeof(struct sha256_state),
 	.base		=	{
 		.cra_name	=	"sha224",
-- 
2.43.0


