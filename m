Return-Path: <linux-kernel+bounces-88476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C7786E221
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B4E289D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BEE7318B;
	Fri,  1 Mar 2024 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="J1uN+5ff"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778D7003E;
	Fri,  1 Mar 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299817; cv=none; b=ni1fgDrkiEryZ7PxI1q+U329Z0g4Ho+/3H6B1oHSBml/UujrCSqxwIgvHtwigmlgOX+LpAoJGjQ8X3zIGStrBddeZt5rTcPc8yu5YnNJDdHMjlo3TmqA1oJYz01jJZOXKed/irfa0bWyYaCdgPastfa4mEIu9XKrSC7FGoNuS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299817; c=relaxed/simple;
	bh=0el8uunGQ/NkoHEbNOX3ZItH2N3dGVbsHyS6adyEga0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPusvkT86cLDwP1RrCee4pzNmi9rL+MlWUuGG+BOA+313Tw0LdrNblP4oJoapWrtWuIyn5RUOVVmyiM80vdY6FVgL0bHoViRNJtkmp4rXoncgH83EOx9UcNQYhkM9CcZnNuskkeFHHzPPaqL2J0LevlMqBBZLSkIr6hua/zDjx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=J1uN+5ff; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7EEC31200E6;
	Fri,  1 Mar 2024 16:30:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7EEC31200E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709299813;
	bh=sgGdgYUY7c3C9RbQZFavrkIkbmO0g7BAryBpa2jpO0c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=J1uN+5ffJjPyueoxg+HCmZpECcwkCYFD1NbsenzhyeBHIbZTEKbrZYeroLF7qNBry
	 s3axawY9lwb1ZCxE6He5csWCAOtTU75BC8Ihx6IyfY2Rj//9MlYxZDJ81n5kGfssi6
	 dp0E2ydMY4Bbc8rZL/DI06lF1YkYNnw3IcMAdpDabQkjGbYH0/+AhzBKubcdM/r2Hu
	 hjjaGwcVcJ4i2kKDJt6N+UIMZ7HAw7HeezintBYV+TRdnZY6QY3xxtuAstDfTYCOOn
	 PWoNp9jml6zfTWSjjSr8ymVe2qbUITLYBTQWpO1/cBS7Wa2AIKT8St729fkHIMoCQV
	 aCtbVXNTE+WOw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  1 Mar 2024 16:30:13 +0300 (MSK)
Received: from user-A520M-DS3H.sigma.sbrf.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 16:30:12 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <clabbe@baylibre.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <vadim.fedorenko@linux.dev>
CC: <linux-crypto@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>
Subject: [PATCH v5 09/21] drivers: crypto: meson: process more than MAXDESCS descriptors
Date: Fri, 1 Mar 2024 16:29:24 +0300
Message-ID: <20240301132936.621238-10-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301132936.621238-1-avromanov@salutedevices.com>
References: <20240301132936.621238-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

1. The old alhorithm was not designed to process a large
amount of memory, and therefore gave incorrect results.

2. Not all Amlogic SoC's use 3 KEY/IV descriptors.
Add keyiv descriptors count parameter to platform data.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/crypto/amlogic/amlogic-gxl-cipher.c | 441 ++++++++++++--------
 drivers/crypto/amlogic/amlogic-gxl-core.c   |   1 +
 drivers/crypto/amlogic/amlogic-gxl.h        |   2 +
 3 files changed, 280 insertions(+), 164 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index c662c4b86e97..a71b133a9e9a 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -17,35 +17,41 @@
 #include <crypto/internal/skcipher.h>
 #include "amlogic-gxl.h"
 
-static bool meson_cipher_need_fallback(struct skcipher_request *areq)
+static bool meson_cipher_need_fallback_sg(struct skcipher_request *areq,
+					  struct scatterlist *sg)
 {
-	struct scatterlist *src_sg = areq->src;
-	struct scatterlist *dst_sg = areq->dst;
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
+	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
+	unsigned int cryptlen = areq->cryptlen;
+
+	while (cryptlen) {
+		unsigned int len = min(cryptlen, sg->length);
+
+		if (!IS_ALIGNED(sg->offset, sizeof(u32)))
+			return true;
+		if (len % blocksize != 0)
+			return true;
+
+		cryptlen -= len;
+		sg = sg_next(sg);
+	}
+
+	return false;
+}
 
+static bool meson_cipher_need_fallback(struct skcipher_request *areq)
+{
 	if (areq->cryptlen == 0)
 		return true;
 
-	if (sg_nents(src_sg) != sg_nents(dst_sg))
+	if (meson_cipher_need_fallback_sg(areq, areq->src))
 		return true;
 
-	/* KEY/IV descriptors use 3 desc */
-	if (sg_nents(src_sg) > MAXDESC - 3 || sg_nents(dst_sg) > MAXDESC - 3)
-		return true;
+	if (areq->dst == areq->src)
+		return false;
 
-	while (src_sg && dst_sg) {
-		if ((src_sg->length % 16) != 0)
-			return true;
-		if ((dst_sg->length % 16) != 0)
-			return true;
-		if (src_sg->length != dst_sg->length)
-			return true;
-		if (!IS_ALIGNED(src_sg->offset, sizeof(u32)))
-			return true;
-		if (!IS_ALIGNED(dst_sg->offset, sizeof(u32)))
-			return true;
-		src_sg = sg_next(src_sg);
-		dst_sg = sg_next(dst_sg);
-	}
+	if (meson_cipher_need_fallback_sg(areq, areq->dst))
+		return true;
 
 	return false;
 }
@@ -76,184 +82,291 @@ static int meson_cipher_do_fallback(struct skcipher_request *areq)
 	return err;
 }
 
-static int meson_cipher(struct skcipher_request *areq)
+struct cipher_ctx {
+	struct {
+		dma_addr_t addr;
+		unsigned int len;
+	} keyiv;
+
+	struct skcipher_request *areq;
+	struct scatterlist *src_sg;
+	struct scatterlist *dst_sg;
+	void *bkeyiv;
+
+	unsigned int src_offset;
+	unsigned int dst_offset;
+	unsigned int cryptlen;
+	unsigned int tloffset;
+};
+
+static int meson_map_scatterlist(struct skcipher_request *areq, struct meson_dev *mc)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
-	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
-	struct meson_cipher_req_ctx *rctx = skcipher_request_ctx(areq);
-	struct meson_dev *mc = op->mc;
-	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
-	struct meson_alg_template *algt;
-	int flow = rctx->flow;
-	unsigned int todo, eat, len;
-	struct scatterlist *src_sg = areq->src;
-	struct scatterlist *dst_sg = areq->dst;
-	struct meson_desc *desc;
 	int nr_sgs, nr_sgd;
-	int i, err = 0;
-	unsigned int keyivlen, ivsize, offset, tloffset;
-	dma_addr_t phykeyiv;
-	void *backup_iv = NULL, *bkeyiv;
-	u32 v;
-
-	algt = container_of(alg, struct meson_alg_template, alg.skcipher.base);
-
-	dev_dbg(mc->dev, "%s %s %u %x IV(%u) key=%u flow=%d\n", __func__,
-		crypto_tfm_alg_name(areq->base.tfm),
-		areq->cryptlen,
-		rctx->op_dir, crypto_skcipher_ivsize(tfm),
-		op->keylen, flow);
-
-#ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
-	algt->stat_req++;
-	mc->chanlist[flow].stat_req++;
-#endif
-
-	/*
-	 * The hardware expect a list of meson_desc structures.
-	 * The 2 first structures store key
-	 * The third stores IV
-	 */
-	bkeyiv = kzalloc(48, GFP_KERNEL | GFP_DMA);
-	if (!bkeyiv)
-		return -ENOMEM;
-
-	memcpy(bkeyiv, op->key, op->keylen);
-	keyivlen = op->keylen;
-
-	ivsize = crypto_skcipher_ivsize(tfm);
-	if (areq->iv && ivsize > 0) {
-		if (ivsize > areq->cryptlen) {
-			dev_err(mc->dev, "invalid ivsize=%d vs len=%d\n", ivsize, areq->cryptlen);
-			err = -EINVAL;
-			goto theend;
-		}
-		memcpy(bkeyiv + 32, areq->iv, ivsize);
-		keyivlen = 48;
-		if (rctx->op_dir == MESON_DECRYPT) {
-			backup_iv = kzalloc(ivsize, GFP_KERNEL);
-			if (!backup_iv) {
-				err = -ENOMEM;
-				goto theend;
-			}
-			offset = areq->cryptlen - ivsize;
-			scatterwalk_map_and_copy(backup_iv, areq->src, offset,
-						 ivsize, 0);
-		}
-	}
-	if (keyivlen == AES_KEYSIZE_192)
-		keyivlen = AES_MAX_KEY_SIZE;
-
-	phykeyiv = dma_map_single(mc->dev, bkeyiv, keyivlen,
-				  DMA_TO_DEVICE);
-	err = dma_mapping_error(mc->dev, phykeyiv);
-	if (err) {
-		dev_err(mc->dev, "Cannot DMA MAP KEY IV\n");
-		goto theend;
-	}
-
-	tloffset = 0;
-	eat = 0;
-	i = 0;
-	while (keyivlen > eat) {
-		desc = &mc->chanlist[flow].tl[tloffset];
-		memset(desc, 0, sizeof(struct meson_desc));
-		todo = min(keyivlen - eat, 16u);
-		desc->t_src = cpu_to_le32(phykeyiv + i * 16);
-		desc->t_dst = cpu_to_le32(i * 16);
-		v = DESC_MODE_KEY | DESC_OWN | 16;
-		desc->t_status = cpu_to_le32(v);
-
-		eat += todo;
-		i++;
-		tloffset++;
-	}
 
 	if (areq->src == areq->dst) {
 		nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
 				    DMA_BIDIRECTIONAL);
 		if (!nr_sgs) {
 			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
-			err = -EINVAL;
-			goto theend;
+			return -EINVAL;
 		}
-		nr_sgd = nr_sgs;
 	} else {
 		nr_sgs = dma_map_sg(mc->dev, areq->src, sg_nents(areq->src),
 				    DMA_TO_DEVICE);
-		if (!nr_sgs || nr_sgs > MAXDESC - 3) {
+		if (!nr_sgs) {
 			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgs);
-			err = -EINVAL;
-			goto theend;
+			return -EINVAL;
 		}
+
 		nr_sgd = dma_map_sg(mc->dev, areq->dst, sg_nents(areq->dst),
 				    DMA_FROM_DEVICE);
-		if (!nr_sgd || nr_sgd > MAXDESC - 3) {
+		if (!nr_sgd) {
 			dev_err(mc->dev, "Invalid SG count %d\n", nr_sgd);
-			err = -EINVAL;
-			goto theend;
+			return -EINVAL;
 		}
 	}
 
-	src_sg = areq->src;
-	dst_sg = areq->dst;
-	len = areq->cryptlen;
-	while (src_sg) {
-		desc = &mc->chanlist[flow].tl[tloffset];
-		memset(desc, 0, sizeof(struct meson_desc));
-
-		desc->t_src = cpu_to_le32(sg_dma_address(src_sg));
-		desc->t_dst = cpu_to_le32(sg_dma_address(dst_sg));
-		todo = min(len, sg_dma_len(src_sg));
-		v = op->keymode | DESC_OWN | todo | algt->blockmode;
-		if (rctx->op_dir)
-			v |= DESC_ENCRYPTION;
-		len -= todo;
-
-		if (!sg_next(src_sg))
-			v |= DESC_LAST;
-		desc->t_status = cpu_to_le32(v);
-		tloffset++;
-		src_sg = sg_next(src_sg);
-		dst_sg = sg_next(dst_sg);
+	return 0;
+}
+
+static void meson_unmap_scatterlist(struct skcipher_request *areq, struct meson_dev *mc)
+{
+	if (areq->src == areq->dst) {
+		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_BIDIRECTIONAL);
+	} else {
+		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
+		dma_unmap_sg(mc->dev, areq->dst, sg_nents(areq->dst), DMA_FROM_DEVICE);
+	}
+}
+
+static void meson_setup_keyiv_descs(struct cipher_ctx *ctx)
+{
+	struct meson_cipher_req_ctx *rctx = skcipher_request_ctx(ctx->areq);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(ctx->areq);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct meson_alg_template *algt = container_of(alg,
+		struct meson_alg_template, alg.skcipher.base);
+	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
+	struct meson_dev *mc = op->mc;
+	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
+	unsigned int blockmode = algt->blockmode;
+	int i;
+
+	if (ctx->tloffset)
+		return;
+
+	if (blockmode == DESC_OPMODE_CBC) {
+		memcpy(ctx->bkeyiv + AES_MAX_KEY_SIZE, ctx->areq->iv, ivsize);
+		ctx->keyiv.len = AES_MAX_KEY_SIZE + ivsize;
+		dma_sync_single_for_device(mc->dev, ctx->keyiv.addr,
+					   ctx->keyiv.len, DMA_TO_DEVICE);
 	}
 
-	reinit_completion(&mc->chanlist[flow].complete);
-	meson_dma_start(mc, flow);
+	for (i = 0; i < mc->pdata->setup_desc_cnt; i++) {
+		struct meson_desc *desc =
+			&mc->chanlist[rctx->flow].tl[ctx->tloffset];
+		int offset = i * 16;
+
+		desc->t_src = cpu_to_le32(ctx->keyiv.addr + offset);
+		desc->t_dst = cpu_to_le32(offset);
+		desc->t_status = cpu_to_le32(DESC_OWN | DESC_MODE_KEY | ctx->keyiv.len);
+
+		ctx->tloffset++;
+	}
+}
 
-	err = wait_for_completion_interruptible_timeout(&mc->chanlist[flow].complete,
+static bool meson_setup_data_descs(struct cipher_ctx *ctx)
+{
+	struct meson_cipher_req_ctx *rctx = skcipher_request_ctx(ctx->areq);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(ctx->areq);
+	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct meson_alg_template *algt = container_of(alg,
+						       struct meson_alg_template,
+						       alg.skcipher.base);
+	struct meson_dev *mc = op->mc;
+	struct meson_desc *desc = &mc->chanlist[rctx->flow].tl[ctx->tloffset];
+	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
+	unsigned int blockmode = algt->blockmode;
+	unsigned int maxlen = rounddown(DESC_MAXLEN, blocksize);
+	unsigned int todo;
+	u32 v;
+
+	ctx->tloffset++;
+
+	todo = min(ctx->cryptlen, maxlen);
+	todo = min(todo, ctx->cryptlen);
+	todo = min(todo, sg_dma_len(ctx->src_sg) - ctx->src_offset);
+	todo = min(todo, sg_dma_len(ctx->dst_sg) - ctx->dst_offset);
+
+	desc->t_src = cpu_to_le32(sg_dma_address(ctx->src_sg) + ctx->src_offset);
+	desc->t_dst = cpu_to_le32(sg_dma_address(ctx->dst_sg) + ctx->dst_offset);
+
+	ctx->cryptlen -= todo;
+	ctx->src_offset += todo;
+	ctx->dst_offset += todo;
+
+	v = DESC_OWN | blockmode | op->keymode | todo;
+	if (rctx->op_dir == MESON_ENCRYPT)
+		v |= DESC_ENCRYPTION;
+
+	if (!ctx->cryptlen || ctx->tloffset == MAXDESC)
+		v |= DESC_LAST;
+
+	desc->t_status = cpu_to_le32(v);
+
+	return v & DESC_LAST;
+}
+
+static int meson_kick_hardware(struct cipher_ctx *ctx)
+{
+	struct meson_cipher_req_ctx *rctx = skcipher_request_ctx(ctx->areq);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(ctx->areq);
+	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct meson_alg_template *algt = container_of(alg,
+						       struct meson_alg_template,
+						       alg.skcipher.base);
+	struct meson_dev *mc = op->mc;
+	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
+	unsigned int blockmode = algt->blockmode;
+	enum dma_data_direction new_iv_dir;
+	dma_addr_t new_iv_phys;
+	void *new_iv;
+	int err;
+
+	if (blockmode == DESC_OPMODE_CBC) {
+		struct scatterlist *sg;
+		unsigned int offset;
+
+		if (rctx->op_dir == MESON_ENCRYPT) {
+			sg = ctx->dst_sg;
+			offset = ctx->dst_offset;
+			new_iv_dir = DMA_FROM_DEVICE;
+		} else {
+			sg = ctx->src_sg;
+			offset = ctx->src_offset;
+			new_iv_dir = DMA_TO_DEVICE;
+		}
+
+		if (ctx->areq->src == ctx->areq->dst)
+			new_iv_dir = DMA_BIDIRECTIONAL;
+
+		offset -= ivsize;
+		new_iv = sg_virt(sg) + offset;
+		new_iv_phys = sg_dma_address(sg) + offset;
+	}
+
+	if (blockmode == DESC_OPMODE_CBC &&
+	    rctx->op_dir == MESON_DECRYPT) {
+		dma_sync_single_for_cpu(mc->dev, new_iv_phys,
+					ivsize, new_iv_dir);
+		memcpy(ctx->areq->iv, new_iv, ivsize);
+	}
+
+	reinit_completion(&mc->chanlist[rctx->flow].complete);
+	meson_dma_start(mc, rctx->flow);
+	err = wait_for_completion_interruptible_timeout(&mc->chanlist[rctx->flow].complete,
 							msecs_to_jiffies(500));
 	if (err == 0) {
-		dev_err(mc->dev, "DMA timeout for flow %d\n", flow);
-		err = -EINVAL;
+		dev_err(mc->dev, "DMA timeout for flow %d\n", rctx->flow);
+		return -EINVAL;
 	} else if (err < 0) {
 		dev_err(mc->dev, "Waiting for DMA completion is failed (%d)\n", err);
-	} else {
-		/* No error */
-		err = 0;
+		return err;
 	}
 
-	dma_unmap_single(mc->dev, phykeyiv, keyivlen, DMA_TO_DEVICE);
+	if (blockmode == DESC_OPMODE_CBC &&
+	    rctx->op_dir == MESON_ENCRYPT) {
+		dma_sync_single_for_cpu(mc->dev, new_iv_phys,
+					ivsize, new_iv_dir);
+		memcpy(ctx->areq->iv, new_iv, ivsize);
+	}
 
-	if (areq->src == areq->dst) {
-		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_BIDIRECTIONAL);
-	} else {
-		dma_unmap_sg(mc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
-		dma_unmap_sg(mc->dev, areq->dst, sg_nents(areq->dst), DMA_FROM_DEVICE);
+	ctx->tloffset = 0;
+
+	return 0;
+}
+
+static int meson_cipher(struct skcipher_request *areq)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
+	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
+	struct meson_cipher_req_ctx *rctx = skcipher_request_ctx(areq);
+	struct meson_dev *mc = op->mc;
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+	struct meson_alg_template *algt;
+	struct cipher_ctx ctx = {
+		.areq = areq,
+		.src_offset = 0,
+		.dst_offset = 0,
+		.src_sg = areq->src,
+		.dst_sg = areq->dst,
+		.cryptlen = areq->cryptlen,
+	};
+	int err;
+
+	dev_dbg(mc->dev, "%s %s %u %x IV(%u) key=%u ctx.flow=%d\n", __func__,
+		crypto_tfm_alg_name(areq->base.tfm),
+		areq->cryptlen,
+		rctx->op_dir, crypto_skcipher_ivsize(tfm),
+		op->keylen, rctx->flow);
+
+	algt = container_of(alg, struct meson_alg_template, alg.skcipher.base);
+
+#ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
+	algt->stat_req++;
+	mc->chanlist[rctx->flow].stat_req++;
+#endif
+
+	ctx.bkeyiv = kzalloc(48, GFP_KERNEL | GFP_DMA);
+	if (!ctx.bkeyiv)
+		return -ENOMEM;
+
+	memcpy(ctx.bkeyiv, op->key, op->keylen);
+	ctx.keyiv.len = op->keylen;
+	if (ctx.keyiv.len == AES_KEYSIZE_192)
+		ctx.keyiv.len = AES_MAX_KEY_SIZE;
+
+	ctx.keyiv.addr = dma_map_single(mc->dev, ctx.bkeyiv, ctx.keyiv.len,
+					DMA_TO_DEVICE);
+	err = dma_mapping_error(mc->dev, ctx.keyiv.addr);
+	if (err) {
+		dev_err(mc->dev, "Cannot DMA MAP KEY IV\n");
+		goto theend;
 	}
 
-	if (areq->iv && ivsize > 0) {
-		if (rctx->op_dir == MESON_DECRYPT) {
-			memcpy(areq->iv, backup_iv, ivsize);
-		} else {
-			scatterwalk_map_and_copy(areq->iv, areq->dst,
-						 areq->cryptlen - ivsize,
-						 ivsize, 0);
+	err = meson_map_scatterlist(areq, mc);
+	if (err)
+		goto theend;
+
+	ctx.tloffset = 0;
+
+	while (ctx.cryptlen) {
+		meson_setup_keyiv_descs(&ctx);
+
+		if (meson_setup_data_descs(&ctx)) {
+			err = meson_kick_hardware(&ctx);
+			if (err)
+				break;
+		}
+
+		if (ctx.src_offset == sg_dma_len(ctx.src_sg)) {
+			ctx.src_offset = 0;
+			ctx.src_sg = sg_next(ctx.src_sg);
+		}
+
+		if (ctx.dst_offset == sg_dma_len(ctx.dst_sg)) {
+			ctx.dst_offset = 0;
+			ctx.dst_sg = sg_next(ctx.dst_sg);
 		}
 	}
+
+	dma_unmap_single(mc->dev, ctx.keyiv.addr, ctx.keyiv.len, DMA_TO_DEVICE);
+	meson_unmap_scatterlist(areq, mc);
+
 theend:
-	kfree_sensitive(bkeyiv);
-	kfree_sensitive(backup_iv);
+	kfree_sensitive(ctx.bkeyiv);
 
 	return err;
 }
diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 95443945bdc1..c7e3b402b14e 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -266,6 +266,7 @@ static void meson_crypto_remove(struct platform_device *pdev)
 static const struct meson_pdata meson_gxl_pdata = {
 	.descs_reg = 0x0,
 	.status_reg = 0x4,
+	.setup_desc_cnt = 3,
 };
 
 static const struct of_device_id meson_crypto_of_match_table[] = {
diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
index 1ab3462dea42..f3455babb52a 100644
--- a/drivers/crypto/amlogic/amlogic-gxl.h
+++ b/drivers/crypto/amlogic/amlogic-gxl.h
@@ -82,10 +82,12 @@ struct meson_flow {
  * struct meson_pdata - SoC series dependent data.
  * @reg_descs:	offset to descriptors register
  * @reg_status:	offset to status register
+ * @setup_desc_cnt:	number of setup descriptor to configure.
  */
 struct meson_pdata {
 	u32 descs_reg;
 	u32 status_reg;
+	u32 setup_desc_cnt;
 };
 
 /*
-- 
2.34.1


