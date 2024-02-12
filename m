Return-Path: <linux-kernel+bounces-61761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC239851642
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6131D288AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63FD3F8F5;
	Mon, 12 Feb 2024 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="FFI12neM"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0433E485;
	Mon, 12 Feb 2024 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745908; cv=none; b=BwleWFANs4YbfZkwuGSFnSGHlF1NNQMPNGJAEsayU5FV7AMNQJu0dgD0abnwpSvKZqBPnMvlCIP+dDMA0EZ07Tlbe9Dm0taM4knF9us5uHOi9Hx+Y2cb332bCgsb0xSCm0uYUt0/HaB81i+3HXjgmHn+cbachjzDTHqVumFL/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745908; c=relaxed/simple;
	bh=ozEQikAp7SBFkLIa5T0j5RmfB/dVa97bJcoVUR3QyFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvW4Wl01cu9WMsUbG+raN9A7V8ZAUL/yl/h1MSIFApR71GymsWEuk9qO0qdb6Gs1MbBgJmaXzAIsA7i5P3YTlSLUlfXsy68cFvhKpNUnwOT33ZUtry/RL7BysHQ3uuNTO9MFlQ08pqhU0/NWmoiHiXhpQr9ojl+OedBqCO9Ey+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=FFI12neM; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 240D3100019;
	Mon, 12 Feb 2024 16:51:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 240D3100019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707745905;
	bh=Vd9GHGiOwQcDzJagyNBPGZ2N8rH785ofr1KRdm4qjKg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=FFI12neMfJwaomy8bXA7UH0np88sChXspGSIRTI7ANBSqE4neU0KgPJWiN2lQvx4E
	 A0ibT4CCCPxOMmZOfY2p9aG+zXdnlUMhngFAJ+7K1r+edt/LgZ1vKS4qGOb6x6itu8
	 DrymAOd3bno7bxUJ60FANWCrIOPFwU7tb3lb86/zooj0fPXPItaOoibJfueqYzb5LW
	 +yz8nKuZSPfqjqUBfqd+tgWTriMhEiwB4m6jBj74K9LMvfhkk6PHPZPvpT3IE3DL6/
	 ZFBxFUjyuPp4y7n38g6SzSAl5vf24W5gfH2ol5CgUIBSEFc/2uOgYmb0WhsrT1sJ++
	 QUUc1cDnR2XWQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 12 Feb 2024 16:51:44 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 16:51:44 +0300
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
Subject: [PATCH v4 12/20] drivers: crypto: meson: add support for AES-CTR
Date: Mon, 12 Feb 2024 16:51:00 +0300
Message-ID: <20240212135108.549755-13-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212135108.549755-1-avromanov@salutedevices.com>
References: <20240212135108.549755-1-avromanov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 183368 [Feb 12 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/12 07:49:00 #23556813
X-KSMG-AntiVirus-Status: Clean, skipped

This patch adds support for AES-CTR algorithm.
Tested via tcrypt and custom tests.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/crypto/amlogic/amlogic-gxl-cipher.c | 44 +++++++++++++++++++--
 drivers/crypto/amlogic/amlogic-gxl.h        |  1 +
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index 3f42b2cc568d..828109f4a1c3 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -154,7 +154,7 @@ static void meson_setup_keyiv_descs(struct cipher_ctx *ctx)
 	if (ctx->tloffset)
 		return;
 
-	if (blockmode == DESC_OPMODE_CBC) {
+	if (blockmode == DESC_OPMODE_CBC || blockmode == DESC_OPMODE_CTR) {
 		memcpy(op->keyiv + AES_MAX_KEY_SIZE, ctx->areq->iv, ivsize);
 		dma_sync_single_for_device(mc->dev, ctx->keyiv.addr,
 					   ctx->keyiv.len, DMA_TO_DEVICE);
@@ -186,6 +186,7 @@ static bool meson_setup_data_descs(struct cipher_ctx *ctx)
 	struct meson_desc *desc = &mc->chanlist[rctx->flow].tl[ctx->tloffset];
 	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
 	unsigned int blockmode = algt->blockmode;
+	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
 	unsigned int maxlen = rounddown(DESC_MAXLEN, blocksize);
 	unsigned int todo;
 	u32 v;
@@ -204,8 +205,15 @@ static bool meson_setup_data_descs(struct cipher_ctx *ctx)
 	ctx->src_offset += todo;
 	ctx->dst_offset += todo;
 
+	if (blockmode == DESC_OPMODE_CTR) {
+		unsigned int nblocks = todo / blocksize;
+
+		while (nblocks--)
+			crypto_inc(ctx->areq->iv, ivsize);
+	}
+
 	v = DESC_OWN | blockmode | op->keymode | todo;
-	if (rctx->op_dir == MESON_ENCRYPT)
+	if (rctx->op_dir == MESON_ENCRYPT || blockmode == DESC_OPMODE_CTR)
 		v |= DESC_ENCRYPTION;
 
 	if (!ctx->cryptlen || ctx->tloffset == MAXDESC)
@@ -322,7 +330,8 @@ static int meson_cipher(struct skcipher_request *areq)
 	if (ctx.keyiv.len == AES_KEYSIZE_192)
 		ctx.keyiv.len = AES_MAX_KEY_SIZE;
 
-	if (algt->blockmode == DESC_OPMODE_CBC) {
+	if (algt->blockmode == DESC_OPMODE_CBC ||
+		algt->blockmode == DESC_OPMODE_CTR) {
 		memcpy(op->keyiv + AES_MAX_KEY_SIZE, areq->iv, ivsize);
 		ctx.keyiv.len = AES_MAX_KEY_SIZE + ivsize;
 	}
@@ -535,6 +544,35 @@ static struct meson_alg_template algs[] = {
 		.do_one_request = meson_handle_cipher_request,
 	},
 },
+{
+	.type = CRYPTO_ALG_TYPE_SKCIPHER,
+	.blockmode = DESC_OPMODE_CTR,
+	.alg.skcipher.base = {
+		.base = {
+			.cra_name = "ctr(aes)",
+			.cra_driver_name = "ctr-aes-gxl",
+			.cra_priority = 400,
+			.cra_blocksize = AES_BLOCK_SIZE,
+			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
+				CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
+				CRYPTO_ALG_NEED_FALLBACK,
+			.cra_ctxsize = sizeof(struct meson_cipher_tfm_ctx),
+			.cra_module = THIS_MODULE,
+			.cra_alignmask = 0xf,
+			.cra_init = meson_cipher_init,
+			.cra_exit = meson_cipher_exit,
+		},
+		.min_keysize	= AES_MIN_KEY_SIZE,
+		.max_keysize	= AES_MAX_KEY_SIZE,
+		.ivsize		= AES_BLOCK_SIZE,
+		.setkey		= meson_aes_setkey,
+		.encrypt	= meson_skencrypt,
+		.decrypt	= meson_skdecrypt,
+	},
+	.alg.skcipher.op = {
+		.do_one_request = meson_handle_cipher_request,
+	},
+},
 };
 
 int meson_cipher_register(struct meson_dev *mc)
diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
index a07b4f6b3bcc..7f6d91e7b365 100644
--- a/drivers/crypto/amlogic/amlogic-gxl.h
+++ b/drivers/crypto/amlogic/amlogic-gxl.h
@@ -24,6 +24,7 @@
 
 #define DESC_OPMODE_ECB (0 << 26)
 #define DESC_OPMODE_CBC (1 << 26)
+#define DESC_OPMODE_CTR (2 << 26)
 #define DESC_OPMODE_SHA (0 << 26)
 
 #define DESC_MAXLEN ((1 << 17) - 1)
-- 
2.34.1


