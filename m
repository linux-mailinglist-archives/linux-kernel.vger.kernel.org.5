Return-Path: <linux-kernel+bounces-12960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D403F81FD59
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC642829D9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 06:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DFF79D8;
	Fri, 29 Dec 2023 06:45:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CBF7472;
	Fri, 29 Dec 2023 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4T1bTz35djz1vqcK;
	Fri, 29 Dec 2023 14:45:11 +0800 (CST)
Received: from dggpeml500001.china.huawei.com (unknown [7.185.36.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 359C01A0197;
	Fri, 29 Dec 2023 14:45:07 +0800 (CST)
Received: from huawei.com (10.69.192.56) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Dec
 2023 14:44:52 +0800
From: Qi Tao <taoqi10@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<liulongfang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH 4/4] crypto: hisilicon/sec - remove unused parameter
Date: Fri, 29 Dec 2023 14:44:21 +0800
Message-ID: <20231229064421.16981-5-taoqi10@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231229064421.16981-1-taoqi10@huawei.com>
References: <20231229064421.16981-1-taoqi10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500001.china.huawei.com (7.185.36.227)

From: Wenkai Lin <linwenkai6@hisilicon.com>

Unused parameter of static functions should be removed.

Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 5d4facf62c86..ee6cc2e483ab 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -485,8 +485,7 @@ static void sec_alg_resource_free(struct sec_ctx *ctx,
 		sec_free_mac_resource(dev, qp_ctx->res);
 }
 
-static int sec_alloc_qp_ctx_resource(struct hisi_qm *qm, struct sec_ctx *ctx,
-				     struct sec_qp_ctx *qp_ctx)
+static int sec_alloc_qp_ctx_resource(struct sec_ctx *ctx, struct sec_qp_ctx *qp_ctx)
 {
 	u16 q_depth = qp_ctx->qp->sq_depth;
 	struct device *dev = ctx->dev;
@@ -541,8 +540,7 @@ static void sec_free_qp_ctx_resource(struct sec_ctx *ctx, struct sec_qp_ctx *qp_
 	kfree(qp_ctx->req_list);
 }
 
-static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
-			     int qp_ctx_id, int alg_type)
+static int sec_create_qp_ctx(struct sec_ctx *ctx, int qp_ctx_id)
 {
 	struct sec_qp_ctx *qp_ctx;
 	struct hisi_qp *qp;
@@ -561,7 +559,7 @@ static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
 	idr_init(&qp_ctx->req_idr);
 	INIT_LIST_HEAD(&qp_ctx->backlog);
 
-	ret = sec_alloc_qp_ctx_resource(qm, ctx, qp_ctx);
+	ret = sec_alloc_qp_ctx_resource(ctx, qp_ctx);
 	if (ret)
 		goto err_destroy_idr;
 
@@ -614,7 +612,7 @@ static int sec_ctx_base_init(struct sec_ctx *ctx)
 	}
 
 	for (i = 0; i < sec->ctx_q_num; i++) {
-		ret = sec_create_qp_ctx(&sec->qm, ctx, i, 0);
+		ret = sec_create_qp_ctx(ctx, i);
 		if (ret)
 			goto err_sec_release_qp_ctx;
 	}
@@ -750,9 +748,7 @@ static void sec_skcipher_uninit(struct crypto_skcipher *tfm)
 	sec_ctx_base_uninit(ctx);
 }
 
-static int sec_skcipher_3des_setkey(struct crypto_skcipher *tfm, const u8 *key,
-				    const u32 keylen,
-				    const enum sec_cmode c_mode)
+static int sec_skcipher_3des_setkey(struct crypto_skcipher *tfm, const u8 *key, const u32 keylen)
 {
 	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
@@ -843,7 +839,7 @@ static int sec_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 
 	switch (c_alg) {
 	case SEC_CALG_3DES:
-		ret = sec_skcipher_3des_setkey(tfm, key, keylen, c_mode);
+		ret = sec_skcipher_3des_setkey(tfm, key, keylen);
 		break;
 	case SEC_CALG_AES:
 	case SEC_CALG_SM4:
-- 
2.33.0


