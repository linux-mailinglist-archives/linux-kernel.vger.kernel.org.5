Return-Path: <linux-kernel+bounces-35731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46213839615
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F7BB28639
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EFE8614E;
	Tue, 23 Jan 2024 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ngUUaqME"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46685C56;
	Tue, 23 Jan 2024 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029135; cv=none; b=BXmfJxdu/HE5T3mh4wpNFpDLKhrAYWEZIkjKm/+bTc26WIuWzOU7ACDMHU/saT0erh8sRM7/5eZVzupxqDDSryXjpuIuWo56oxxXewQkBg0hPVRn7+CdWM+tDhpPDpMI4ShVXDUp17frgWqh7pt1UdWRJMNfh7/4wxwaZsDzZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029135; c=relaxed/simple;
	bh=+vw47rn92sXYdYV1SomM5H1NSb6QCNHwuvK/L7LX9Tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLKOAdBXqa3Fvbg92OJ2gXOkjXUXXwDlrKmMgeCYjhffOqVo/jPsPkVlbK1Lbx1nZNTz4XLUZ7RvqNcItPRqAd9jYEEEIsR+sczR4DLtTo2ni9gPtZK+vUBvzX/W43lq+YfPcZt5vHbx6mo3VuGSdWRJhdQkgClUn9fWLfcQ328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ngUUaqME; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1CF22100011;
	Tue, 23 Jan 2024 19:58:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1CF22100011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706029130;
	bh=wlMDvETCPIDqaatfBkWj0xzIDef6fbxRCoQEpdIyILI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ngUUaqMEuYiipxxaa6YgbDM/CC3LAZrZtLY/oYd1BTwYuvGjbAj0SVNn0fwi+jeRs
	 2lumimh9vtFbEQscQ+j65D/1AfvXxca8Ema3Mhs3AJ7eyx7mmBxKP/1OWJTsxeibp/
	 oMlY8Rn419WE53Kzanp/ZvwtLjOY4UpG9QAJvD/N3vBsdnOAfGZluAZ57sbndFy+B7
	 LUfCYOPOpNhP35qkBdDxWkY+kMn5DF11oLh1H6OHyS0Fwjg2NtZLPbSXzUkL0dZJ/r
	 fLWo3VSuuas7f45Y57mLTp2nTI4Woyl07kXWu7HJi1NxWehWr+EAZANqpNGi0WjJmx
	 n+XkSaYJSfe6Q==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 23 Jan 2024 19:58:49 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 19:58:49 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <clabbe@baylibre.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-crypto@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 10/20] drivers: crypto: meson: avoid kzalloc in engine thread
Date: Tue, 23 Jan 2024 19:58:21 +0300
Message-ID: <20240123165831.970023-11-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123165831.970023-1-avromanov@salutedevices.com>
References: <20240123165831.970023-1-avromanov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 182873 [Jan 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/23 13:53:00 #23383939
X-KSMG-AntiVirus-Status: Clean, skipped

It makes no sense to allocate memory via kzalloc, we
can use static buffer, speedup data processing and
don't think about kfree() calls.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/crypto/amlogic/amlogic-gxl-cipher.c | 24 ++++++++-------------
 drivers/crypto/amlogic/amlogic-gxl.h        |  6 +++---
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index 9c96e7b65e1e..3f42b2cc568d 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -155,8 +155,7 @@ static void meson_setup_keyiv_descs(struct cipher_ctx *ctx)
 		return;
 
 	if (blockmode == DESC_OPMODE_CBC) {
-		memcpy(op->key + AES_MAX_KEY_SIZE, ctx->areq->iv, ivsize);
-		ctx->keyiv.len = AES_MAX_KEY_SIZE + ivsize;
+		memcpy(op->keyiv + AES_MAX_KEY_SIZE, ctx->areq->iv, ivsize);
 		dma_sync_single_for_device(mc->dev, ctx->keyiv.addr,
 					   ctx->keyiv.len, DMA_TO_DEVICE);
 	}
@@ -319,16 +318,16 @@ static int meson_cipher(struct skcipher_request *areq)
 	mc->chanlist[rctx->flow].stat_req++;
 #endif
 
-	op->key = kzalloc(48, GFP_KERNEL | GFP_DMA);
-	if (!op.key)
-		return -ENOMEM;
-
-	memcpy(op->key, op->key, op->keylen);
 	ctx.keyiv.len = op->keylen;
 	if (ctx.keyiv.len == AES_KEYSIZE_192)
 		ctx.keyiv.len = AES_MAX_KEY_SIZE;
 
-	ctx.keyiv.addr = dma_map_single(mc->dev, op->key, ctx.keyiv.len,
+	if (algt->blockmode == DESC_OPMODE_CBC) {
+		memcpy(op->keyiv + AES_MAX_KEY_SIZE, areq->iv, ivsize);
+		ctx.keyiv.len = AES_MAX_KEY_SIZE + ivsize;
+	}
+
+	ctx.keyiv.addr = dma_map_single(mc->dev, op->keyiv, ctx.keyiv.len,
 				  DMA_TO_DEVICE);
 	err = dma_mapping_error(mc->dev, ctx.keyiv.addr);
 	if (err) {
@@ -366,8 +365,6 @@ static int meson_cipher(struct skcipher_request *areq)
 	meson_unmap_scatterlist(areq, mc);
 
 theend:
-	kfree_sensitive(op->key);
-
 	return err;
 }
 
@@ -450,7 +447,6 @@ static void meson_cipher_exit(struct crypto_tfm *tfm)
 {
 	struct meson_cipher_tfm_ctx *op = crypto_tfm_ctx(tfm);
 
-	kfree_sensitive(op->key);
 	crypto_free_skcipher(op->fallback_tfm);
 }
 
@@ -474,11 +470,9 @@ static int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 		dev_dbg(mc->dev, "ERROR: Invalid keylen %u\n", keylen);
 		return -EINVAL;
 	}
-	kfree_sensitive(op->key);
+
+	memcpy(op->keyiv, key, keylen);
 	op->keylen = keylen;
-	op->key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
-	if (!op->key)
-		return -ENOMEM;
 
 	return crypto_skcipher_setkey(op->fallback_tfm, key, keylen);
 }
diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
index d1665bbfe6d0..3d0793cd80f6 100644
--- a/drivers/crypto/amlogic/amlogic-gxl.h
+++ b/drivers/crypto/amlogic/amlogic-gxl.h
@@ -127,15 +127,15 @@ struct meson_cipher_req_ctx {
 
 /*
  * struct meson_cipher_tfm_ctx - context for a skcipher TFM
- * @key:		pointer to key data
+ * @keyiv:		key data
  * @keylen:		len of the key
  * @keymode:		The keymode(type and size of key) associated with this TFM
  * @mc:			pointer to the private data of driver handling this TFM
  * @fallback_tfm:	pointer to the fallback TFM
  */
 struct meson_cipher_tfm_ctx {
-	u32 *key;
-	u32 keylen;
+	u8 keyiv[AES_MAX_KEY_SIZE + AES_BLOCK_SIZE] ____cacheline_aligned;
+	u32 keylen ____cacheline_aligned;
 	u32 keymode;
 	struct meson_dev *mc;
 	struct crypto_skcipher *fallback_tfm;
-- 
2.34.1


