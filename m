Return-Path: <linux-kernel+bounces-155438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CEB8AEA87
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E9C1F23129
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC71613CA97;
	Tue, 23 Apr 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="iiNNHVRA"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A82513C695;
	Tue, 23 Apr 2024 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885325; cv=none; b=AW2Hv+C+SRDBdfwhHSQDU49R2PHascrFM110j2PqPkP056yhcDFkAZXOmvrbrxcoGmz4Anhxm5GXMbZN5aqqtfO8KVAe41JEDR9uHHicrgAu1oodrn009YGCgOJ7Y/YzAHEHAQvFJVvytEll2mQ2L2IDqtWjri2dd9Fz7M91VEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885325; c=relaxed/simple;
	bh=lnYfLz/yKVLG22Y0s2TOCf6E1sFzxpYUAzI759jEv3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sk0xyE3kHgjN33nTGjtm/zywIe/H7CGpWT1aMvmiHsW4Yjw/ckjkdQklmi+JnRplAJXickog/tcA+qkUm91yLQQj3JXKNoHzhinMxjG+MyhgxSQ4ZGXLwYM7omN5Yqce5Qx6/x+cAk3MLDYcZZ29xIPsbmNwxFOjVN3MsQ3O8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=iiNNHVRA; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NCH14A018378;
	Tue, 23 Apr 2024 17:15:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	selector1; bh=sORmSAf9vacArCUQo8K1St5wRolQtpbAu5JoPjjIy14=; b=ii
	NNHVRAEhwXhr+niTwSdwL4ktGCL2b1QSYUaSPeh4ZHBjPZLuf2J3Xx9wWzqtg5Bt
	O6ufbjV5uAybP3SOX7vvMkiSM0vnNppdbDpMcXf7UKDRSg4JiOixxi24Q+jRyK/w
	lOyKyTs3y/be+CeJEkV/FVUeXVv5Tum+FBunU9PBDcZTTuP2D7wdoFKIRPqdguac
	e6ap/qrbyncVrdciLBFSY2Dxk56enOgBA8YCADsIHQE+Ms2LV5RKWf5PlbrqJ1Mb
	nbGcXlwo5wlXWTddQw2Vl4krKG8ziaOiJfvdA4byPKOscaK40ml/7YAvvd7qTCB4
	sjuwBbDnrLyP0f39ReuQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4cncfun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 17:15:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2BFCD4002D;
	Tue, 23 Apr 2024 17:14:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CE988223664;
	Tue, 23 Apr 2024 17:14:16 +0200 (CEST)
Received: from localhost (10.48.86.103) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 17:14:16 +0200
From: Maxime MERE <maxime.mere@foss.st.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller"
	<davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob
 Herring <robh@kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] crypto: stm32/cryp - add CRYPTO_ALG_KERN_DRIVER_ONLY flag
Date: Tue, 23 Apr 2024 17:14:09 +0200
Message-ID: <20240423151409.902490-4-maxime.mere@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423151409.902490-1-maxime.mere@foss.st.com>
References: <20240423151409.902490-1-maxime.mere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02

From: Maxime Méré <maxime.mere@foss.st.com>

This flag is needed to make the driver visible from openssl and cryptodev.

Signed-off-by: Maxime Méré <maxime.mere@st.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index 36248975191c..e1a4b5d9d006 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -2294,7 +2294,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "ecb(aes)",
 		.base.cra_driver_name	= "stm32-ecb-aes",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= AES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2316,7 +2316,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "cbc(aes)",
 		.base.cra_driver_name	= "stm32-cbc-aes",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= AES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2339,7 +2339,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "ctr(aes)",
 		.base.cra_driver_name	= "stm32-ctr-aes",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= 1,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2362,7 +2362,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "ecb(des)",
 		.base.cra_driver_name	= "stm32-ecb-des",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2384,7 +2384,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "cbc(des)",
 		.base.cra_driver_name	= "stm32-cbc-des",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2407,7 +2407,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "ecb(des3_ede)",
 		.base.cra_driver_name	= "stm32-ecb-des3",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2429,7 +2429,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "cbc(des3_ede)",
 		.base.cra_driver_name	= "stm32-cbc-des3",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2463,7 +2463,7 @@ static struct aead_engine_alg aead_algs[] = {
 		.cra_name		= "gcm(aes)",
 		.cra_driver_name	= "stm32-gcm-aes",
 		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.cra_blocksize		= 1,
 		.cra_ctxsize		= sizeof(struct stm32_cryp_ctx),
 		.cra_alignmask		= 0,
@@ -2486,7 +2486,7 @@ static struct aead_engine_alg aead_algs[] = {
 		.cra_name		= "ccm(aes)",
 		.cra_driver_name	= "stm32-ccm-aes",
 		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.cra_blocksize		= 1,
 		.cra_ctxsize		= sizeof(struct stm32_cryp_ctx),
 		.cra_alignmask		= 0,
-- 
2.25.1


