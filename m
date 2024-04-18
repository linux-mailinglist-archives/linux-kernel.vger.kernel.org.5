Return-Path: <linux-kernel+bounces-150327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3438A9D67
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED82B226FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E73616ABFF;
	Thu, 18 Apr 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="tf9UAxTV"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E50165FC5;
	Thu, 18 Apr 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451477; cv=none; b=AsqD+eJORWKdq2lJJ6dLSjTEGUAfZ5OrhVeBA7MVTkxu1HWxRYvhAOGCI7X4A01xZ9+gqOD3rQTcs+UXvFt9gZ+tQxHD010NKJDJD9uhaekPNLp/reqRSakvSMBc7TOt7+eyIb2fFBCYZBIU+3q5pUxv9jr3Ch8Yc5Ej5XtSRH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451477; c=relaxed/simple;
	bh=qGvIo65M/O9XSi3OcO+KBDaMzqHEMwrb0/nSlAgIJK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOxgeHVGl7Z2x9UPHKcl71AewQvonepRq4X7We5jwSceqonP9ZxVGodlJpJXahnQkBAy8wpdFQ4cbUs2sMFCH/UvnoimRxwiTqoUqt32GK3SLq2QGVhUAuGA9M2k6PFtL9imFMKFsTx/uL3hA1RNwNq0kJNf8Fr/l9S1wyYp+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=tf9UAxTV; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43I9ZrBH012295;
	Thu, 18 Apr 2024 16:43:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	selector1; bh=6NIHXnPi2/F1Fg1UZ+58Nla4m2nGFD2Orsz8Fiuy0lU=; b=tf
	9UAxTVCQ34SJRJhZFeA0c/7GSc5sytw5pB1n/I0UqO+8bJ30EbETwuk4yildqC1X
	6ghftpvefU0Grr21G50z+H5XBEkjz1mf80KOADBZBCMCHjyCjWJ8M8BDhZM45iJM
	vqUwJoLxpRTp2Uv18Wmf5bxyPdMJ0t3G5Sv2aa0Xhf/8rQYPcjpmey2I/ZV3EGuR
	ez8Fp/wbMGqRG9qEuO0SrhjnaFsg21TCTPbSABZNxQQIPblqo+9vQ5TVzG3VbUVg
	X+4U55SGwWlF/gx722I8pafTGWVLWOE0lBIGqqXXXHNzV+h5YdYlHTtlXpLE/fYV
	ieDOc5G45d9L4lTWQCug==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xffffre01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 16:43:57 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 24A0E40046;
	Thu, 18 Apr 2024 16:43:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CF974221951;
	Thu, 18 Apr 2024 16:43:03 +0200 (CEST)
Received: from localhost (10.48.86.103) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 16:43:03 +0200
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
Subject: [PATCH 3/3] crypto: stm32/cryp - add CRYPTO_ALG_KERN_DRIVER_ONLY flag
Date: Thu, 18 Apr 2024 16:42:56 +0200
Message-ID: <20240418144256.3736800-4-maxime.mere@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418144256.3736800-1-maxime.mere@foss.st.com>
References: <20240418144256.3736800-1-maxime.mere@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_12,2024-04-17_01,2023-05-22_02

From: Maxime Méré <maxime.mere@foss.st.com>

This flag is needed to make the driver visible from openssl and cryptodev.

Signed-off-by: Maxime Méré <maxime.mere@foss.st.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index 4480d0e52260..5679ea1032a0 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -2292,7 +2292,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "ecb(aes)",
 		.base.cra_driver_name	= "stm32-ecb-aes",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= AES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2314,7 +2314,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "cbc(aes)",
 		.base.cra_driver_name	= "stm32-cbc-aes",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= AES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2337,7 +2337,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "ctr(aes)",
 		.base.cra_driver_name	= "stm32-ctr-aes",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= 1,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2360,7 +2360,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "ecb(des)",
 		.base.cra_driver_name	= "stm32-ecb-des",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2382,7 +2382,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "cbc(des)",
 		.base.cra_driver_name	= "stm32-cbc-des",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2405,7 +2405,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "ecb(des3_ede)",
 		.base.cra_driver_name	= "stm32-ecb-des3",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2427,7 +2427,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 		.base.cra_name		= "cbc(des3_ede)",
 		.base.cra_driver_name	= "stm32-cbc-des3",
 		.base.cra_priority	= 300,
-		.base.cra_flags		= CRYPTO_ALG_ASYNC,
+		.base.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
 		.base.cra_alignmask	= 0,
@@ -2461,7 +2461,7 @@ static struct aead_engine_alg aead_algs[] = {
 		.cra_name		= "gcm(aes)",
 		.cra_driver_name	= "stm32-gcm-aes",
 		.cra_priority		= 300,
-		.cra_flags		= CRYPTO_ALG_ASYNC,
+		.cra_flags		= CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY,
 		.cra_blocksize		= 1,
 		.cra_ctxsize		= sizeof(struct stm32_cryp_ctx),
 		.cra_alignmask		= 0,
@@ -2484,7 +2484,7 @@ static struct aead_engine_alg aead_algs[] = {
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


