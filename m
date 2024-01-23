Return-Path: <linux-kernel+bounces-35729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5270A8395A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766D61C27D95
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DCA85C51;
	Tue, 23 Jan 2024 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="RRLjEJau"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439E780038;
	Tue, 23 Jan 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029132; cv=none; b=TRkDMT8qsLswOP0uhgFddNhtPLSRDa7qQ9WUZwtEq1wQ7nNNlinoECvsU3kEfLNupUD20MkfSPhvmc+vfZr+IVaj5bmR0zNsav9+Or0hcbeb3OayjSSDIak88UaOCbi10xds/tvWqgGV+BWBMJJWwtn3U+rqJncSifkfhzMxrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029132; c=relaxed/simple;
	bh=3mj1fOjSwbEBTJaJQvuUWJ7BRPxfPOs8uj4pHB/MgrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2S1AIISuR44vJq0C89o7gr3mBAypHEVNga2ERzoRSb9YKFI0Sve43vOPygu+HAeZd0xZGALHs8A3+CdIEhdcjPES8jjAKJbYdpLioClqFc3TeAkFI4iboNlO2M7dZtXp8l4apMLco+4xf0s5UDN/C6rY3MQ094s4B68cMVuPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=RRLjEJau; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BF67D120010;
	Tue, 23 Jan 2024 19:58:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BF67D120010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706029127;
	bh=9hs7iYNnfUVURIq7U2hWZlFqNnvOqOmG0C8T0Fil3k8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=RRLjEJauiaIZFtlFzZFHWImoFw5CscAmoWLeaninNoYu49NAWZp0wnoUKlU0P4izi
	 wOLbSAaEIhN/kueItLC55vGGzyz+OfUNZ8KLWJmfPxKBDw1paNUCrofAjA7uittVFe
	 KsupCclLSII1fnZKFaiXwedh5/KU5d/bGjto0Zr/nuCtNetLLPzDNKpC2qWsF1lgmD
	 ttoRT8CzbRikGx71z0hDx+lS3jR6WwNnoBeR3TyTRZEMusYUsnCt2bCHLcQ9OomNFP
	 8Z/AWquLl4GVXHknH6O7FL9L0KkQEQKpHi0VQQSr0bZNKOyHtc3ZxE/UkpGWYxML71
	 275HtxLxDEVKw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 23 Jan 2024 19:58:47 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 19:58:47 +0300
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
Subject: [PATCH v2 07/20] drivers: crypto: meson: move algs definition and cipher API to cipher.c
Date: Tue, 23 Jan 2024 19:58:18 +0300
Message-ID: <20240123165831.970023-8-avromanov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 182874 [Jan 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/23 13:53:00 #23383939
X-KSMG-AntiVirus-Status: Clean, skipped

Because that is proper place for them. In particular,
it takes less of exported symbol between compiling entities.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/crypto/amlogic/amlogic-gxl-cipher.c |  98 +++++++++++++++--
 drivers/crypto/amlogic/amlogic-gxl-core.c   | 110 ++++----------------
 drivers/crypto/amlogic/amlogic-gxl.h        |  14 +--
 3 files changed, 119 insertions(+), 103 deletions(-)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index dc0b100c5de2..bc3092a8a2c2 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -271,7 +271,7 @@ int meson_handle_cipher_request(struct crypto_engine *engine, void *areq)
 	return 0;
 }
 
-int meson_skdecrypt(struct skcipher_request *areq)
+static int meson_skdecrypt(struct skcipher_request *areq)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
 	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
@@ -289,7 +289,7 @@ int meson_skdecrypt(struct skcipher_request *areq)
 	return crypto_transfer_skcipher_request_to_engine(engine, areq);
 }
 
-int meson_skencrypt(struct skcipher_request *areq)
+static int meson_skencrypt(struct skcipher_request *areq)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
 	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
@@ -307,7 +307,7 @@ int meson_skencrypt(struct skcipher_request *areq)
 	return crypto_transfer_skcipher_request_to_engine(engine, areq);
 }
 
-int meson_cipher_init(struct crypto_tfm *tfm)
+static int meson_cipher_init(struct crypto_tfm *tfm)
 {
 	struct meson_cipher_tfm_ctx *op = crypto_tfm_ctx(tfm);
 	struct meson_alg_template *algt;
@@ -333,7 +333,7 @@ int meson_cipher_init(struct crypto_tfm *tfm)
 	return 0;
 }
 
-void meson_cipher_exit(struct crypto_tfm *tfm)
+static void meson_cipher_exit(struct crypto_tfm *tfm)
 {
 	struct meson_cipher_tfm_ctx *op = crypto_tfm_ctx(tfm);
 
@@ -341,8 +341,8 @@ void meson_cipher_exit(struct crypto_tfm *tfm)
 	crypto_free_skcipher(op->fallback_tfm);
 }
 
-int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
-		     unsigned int keylen)
+static int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			    unsigned int keylen)
 {
 	struct meson_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
 	struct meson_dev *mc = op->mc;
@@ -369,3 +369,89 @@ int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
 
 	return crypto_skcipher_setkey(op->fallback_tfm, key, keylen);
 }
+
+static struct meson_alg_template algs[] = {
+{
+	.type = CRYPTO_ALG_TYPE_SKCIPHER,
+	.blockmode = MESON_OPMODE_CBC,
+	.alg.skcipher.base = {
+		.base = {
+			.cra_name = "cbc(aes)",
+			.cra_driver_name = "cbc-aes-gxl",
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
+{
+	.type = CRYPTO_ALG_TYPE_SKCIPHER,
+	.blockmode = MESON_OPMODE_ECB,
+	.alg.skcipher.base = {
+		.base = {
+			.cra_name = "ecb(aes)",
+			.cra_driver_name = "ecb-aes-gxl",
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
+		.setkey		= meson_aes_setkey,
+		.encrypt	= meson_skencrypt,
+		.decrypt	= meson_skdecrypt,
+	},
+	.alg.skcipher.op = {
+		.do_one_request = meson_handle_cipher_request,
+	},
+},
+};
+
+int meson_cipher_register(struct meson_dev *mc)
+{
+	return meson_register_algs(mc, algs, ARRAY_SIZE(algs));
+}
+
+void meson_cipher_unregister(struct meson_dev *mc)
+{
+	meson_unregister_algs(mc, algs, ARRAY_SIZE(algs));
+}
+
+void meson_cipher_debugfs_show(struct seq_file *seq, void *v)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(algs); i++) {
+		seq_printf(seq, "%s %s %lu %lu\n",
+			   algs[i].alg.skcipher.base.base.cra_driver_name,
+			   algs[i].alg.skcipher.base.base.cra_name,
+#ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
+			   algs[i].stat_req, algs[i].stat_fb);
+#else
+			   0ul, 0ul);
+#endif
+	}
+}
diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index c846e1973a29..cf984f063cf1 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -65,66 +65,6 @@ static irqreturn_t meson_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static struct meson_alg_template mc_algs[] = {
-{
-	.type = CRYPTO_ALG_TYPE_SKCIPHER,
-	.blockmode = MESON_OPMODE_CBC,
-	.alg.skcipher.base = {
-		.base = {
-			.cra_name = "cbc(aes)",
-			.cra_driver_name = "cbc-aes-gxl",
-			.cra_priority = 400,
-			.cra_blocksize = AES_BLOCK_SIZE,
-			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
-				CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
-				CRYPTO_ALG_NEED_FALLBACK,
-			.cra_ctxsize = sizeof(struct meson_cipher_tfm_ctx),
-			.cra_module = THIS_MODULE,
-			.cra_alignmask = 0xf,
-			.cra_init = meson_cipher_init,
-			.cra_exit = meson_cipher_exit,
-		},
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
-		.setkey		= meson_aes_setkey,
-		.encrypt	= meson_skencrypt,
-		.decrypt	= meson_skdecrypt,
-	},
-	.alg.skcipher.op = {
-		.do_one_request = meson_handle_cipher_request,
-	},
-},
-{
-	.type = CRYPTO_ALG_TYPE_SKCIPHER,
-	.blockmode = MESON_OPMODE_ECB,
-	.alg.skcipher.base = {
-		.base = {
-			.cra_name = "ecb(aes)",
-			.cra_driver_name = "ecb-aes-gxl",
-			.cra_priority = 400,
-			.cra_blocksize = AES_BLOCK_SIZE,
-			.cra_flags = CRYPTO_ALG_TYPE_SKCIPHER |
-				CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
-				CRYPTO_ALG_NEED_FALLBACK,
-			.cra_ctxsize = sizeof(struct meson_cipher_tfm_ctx),
-			.cra_module = THIS_MODULE,
-			.cra_alignmask = 0xf,
-			.cra_init = meson_cipher_init,
-			.cra_exit = meson_cipher_exit,
-		},
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-		.setkey		= meson_aes_setkey,
-		.encrypt	= meson_skencrypt,
-		.decrypt	= meson_skdecrypt,
-	},
-	.alg.skcipher.op = {
-		.do_one_request = meson_handle_cipher_request,
-	},
-},
-};
-
 static int meson_debugfs_show(struct seq_file *seq, void *v)
 {
 	struct meson_dev *mc __maybe_unused = seq->private;
@@ -138,20 +78,8 @@ static int meson_debugfs_show(struct seq_file *seq, void *v)
 			   0ul);
 #endif
 
-	for (i = 0; i < ARRAY_SIZE(mc_algs); i++) {
-		switch (mc_algs[i].type) {
-		case CRYPTO_ALG_TYPE_SKCIPHER:
-			seq_printf(seq, "%s %s %lu %lu\n",
-				   mc_algs[i].alg.skcipher.base.base.cra_driver_name,
-				   mc_algs[i].alg.skcipher.base.base.cra_name,
-#ifdef CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG
-				   mc_algs[i].stat_req, mc_algs[i].stat_fb);
-#else
-				   0ul, 0ul);
-#endif
-			break;
-		}
-	}
+	meson_cipher_debugfs_show(seq, v);
+
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(meson_debugfs);
@@ -228,38 +156,40 @@ static int meson_allocate_chanlist(struct meson_dev *mc)
 	return err;
 }
 
-static int meson_register_algs(struct meson_dev *mc)
+int meson_register_algs(struct meson_dev *mc, struct meson_alg_template *algs,
+			unsigned int count)
 {
 	int err, i;
 
-	for (i = 0; i < ARRAY_SIZE(mc_algs); i++) {
-		mc_algs[i].mc = mc;
-		switch (mc_algs[i].type) {
+	for (i = 0; i < count; i++) {
+		switch (algs[i].type) {
 		case CRYPTO_ALG_TYPE_SKCIPHER:
-			err = crypto_engine_register_skcipher(&mc_algs[i].alg.skcipher);
+			err = crypto_engine_register_skcipher(&algs[i].alg.skcipher);
 			if (err) {
 				dev_err(mc->dev, "Fail to register %s\n",
-					mc_algs[i].alg.skcipher.base.base.cra_name);
-				mc_algs[i].mc = NULL;
+					algs[i].alg.skcipher.base.base.cra_name);
+				meson_unregister_algs(mc, algs, count);
 				return err;
 			}
 			break;
 		}
+		algs[i].mc = mc;
 	}
 
 	return 0;
 }
 
-static void meson_unregister_algs(struct meson_dev *mc)
+void meson_unregister_algs(struct meson_dev *mc, struct meson_alg_template *algs,
+			   unsigned int count)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(mc_algs); i++) {
-		if (!mc_algs[i].mc)
+	for (i = 0; i < count; i++) {
+		if (!algs[i].mc)
 			continue;
-		switch (mc_algs[i].type) {
+		switch (algs[i].type) {
 		case CRYPTO_ALG_TYPE_SKCIPHER:
-			crypto_engine_unregister_skcipher(&mc_algs[i].alg.skcipher);
+			crypto_engine_unregister_skcipher(&algs[i].alg.skcipher);
 			break;
 		}
 	}
@@ -313,9 +243,9 @@ static int meson_crypto_probe(struct platform_device *pdev)
 	if (err)
 		goto error_flow;
 
-	err = meson_register_algs(mc);
+	err = meson_cipher_register(mc);
 	if (err)
-		goto error_alg;
+		goto error_flow;
 
 	if (IS_ENABLED(CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG)) {
 		struct dentry *dbgfs_dir;
@@ -329,8 +259,6 @@ static int meson_crypto_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-error_alg:
-	meson_unregister_algs(mc);
 error_flow:
 	meson_free_chanlist(mc, mc->flow_cnt - 1);
 	return err;
@@ -344,7 +272,7 @@ static void meson_crypto_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(mc->dbgfs_dir);
 #endif
 
-	meson_unregister_algs(mc);
+	meson_cipher_unregister(mc);
 
 	meson_free_chanlist(mc, mc->flow_cnt - 1);
 
diff --git a/drivers/crypto/amlogic/amlogic-gxl.h b/drivers/crypto/amlogic/amlogic-gxl.h
index 4d60a0cc2dca..9d66903aa73d 100644
--- a/drivers/crypto/amlogic/amlogic-gxl.h
+++ b/drivers/crypto/amlogic/amlogic-gxl.h
@@ -165,10 +165,12 @@ void meson_dma_start(struct meson_dev *mc, int flow);
 
 int meson_enqueue(struct crypto_async_request *areq, u32 type);
 
-int meson_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
-		     unsigned int keylen);
-int meson_cipher_init(struct crypto_tfm *tfm);
-void meson_cipher_exit(struct crypto_tfm *tfm);
-int meson_skdecrypt(struct skcipher_request *areq);
-int meson_skencrypt(struct skcipher_request *areq);
+int meson_register_algs(struct meson_dev *mc, struct meson_alg_template *algs,
+			unsigned int count);
+void meson_unregister_algs(struct meson_dev *mc, struct meson_alg_template *algs,
+			   unsigned int count);
+
+int meson_cipher_register(struct meson_dev *mc);
+void meson_cipher_unregister(struct meson_dev *mc);
+void meson_cipher_debugfs_show(struct seq_file *seq, void *v);
 int meson_handle_cipher_request(struct crypto_engine *engine, void *areq);
-- 
2.34.1


