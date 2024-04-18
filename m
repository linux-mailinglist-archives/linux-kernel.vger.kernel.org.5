Return-Path: <linux-kernel+bounces-150326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51B28A9D65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB2A9B21DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB15168B09;
	Thu, 18 Apr 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="tjV3O8dl"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E41DFD8;
	Thu, 18 Apr 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451476; cv=none; b=s8D9S8wcn1EBTw15qx/ztZmYzyTsMVoZLGJl+J49WklI0QgqbSA0Zfdcs4NX5G+uPxqgRFDGnLv0F2cBEAwUwHkEbPrAn5K5oSOZni098rUzDrglKGuGVOJtHQyL7CsaG595ow9tgaHZjJ2CxAJD8pdbzLAGbfhUUbFTOMR8DxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451476; c=relaxed/simple;
	bh=t5CCBCzneTz0u5OTkdYXv22f6m6V2+XYsieR+BPa1yU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z4KvL7GfeoA82KnDAyZh29Zqh4ZaKsoXsk4EsnCDZBa8YEMjYeMxytws7b6bRZimYndJvYPsHvWynT8yMJHqFDDhn0Ilh4hD6p9lhXdXDI0jWqSQQAAZ6UVy6ry5xNvJmj782dz+wQKuSIdViyUnhSpfuDa6Vgqjoi0uxs1ALd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=tjV3O8dl; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IDr9gT032318;
	Thu, 18 Apr 2024 16:43:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	selector1; bh=ph2A+Aw1OMyUQhmZZLizkI6tX13F6U5ZvFiwqHaXpf0=; b=tj
	V3O8dl6CW7GArOc/8CrCAibJaG0ipbX1qe6chr7Ze9/NzeTitAJaZZPHeow+ZONp
	z7i7ISAuIBOy6ZiyJlsJA5q8aPuvoI2M6RH2T3LlrVFA/B3cRtqluut5tGErhMcW
	fwqal0NaOdX6KtAU1N+BGn4j5McJXiJ/RVfgUdde5cJwdCtFXNBd5AKmII1y8JKY
	/IRoOP3TDATFytWO/iRu3/B0AWSFD2YIeIKPuvEFV3X/hU+LtwfZ8ITSjPlW1Y6f
	ZmtnEwhYf4K+pZDN4TNYYb3xkT7J2listjt0u55jreJ+Sa53/0B/zxnq9S6Y01N6
	eaC34QgZwmYEX0W0Jtpw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xgecym5du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 16:43:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2498540045;
	Thu, 18 Apr 2024 16:43:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0627821ED4B;
	Thu, 18 Apr 2024 16:43:03 +0200 (CEST)
Received: from localhost (10.48.86.103) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 16:43:02 +0200
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
Subject: [PATCH 2/3] crypto: stm32/cryp - increase priority
Date: Thu, 18 Apr 2024 16:42:55 +0200
Message-ID: <20240418144256.3736800-3-maxime.mere@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418144256.3736800-1-maxime.mere@foss.st.com>
References: <20240418144256.3736800-1-maxime.mere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_12,2024-04-17_01,2023-05-22_02

From: Maxime Méré <maxime.mere@foss.st.com>

Increase STM32 CRYP priority, to be greater than the ARM-NEON
accelerated version.

Co-developed-by: Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
Signed-off-by: Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
Signed-off-by: Maxime Méré <maxime.mere@foss.st.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index c6d76c81d60f..4480d0e52260 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -2291,7 +2291,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "ecb(aes)",
 		.base.cra_driver_name	= "stm32-ecb-aes",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= AES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2313,7 +2313,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "cbc(aes)",
 		.base.cra_driver_name	= "stm32-cbc-aes",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= AES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2336,7 +2336,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "ctr(aes)",
 		.base.cra_driver_name	= "stm32-ctr-aes",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= 1,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2359,7 +2359,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "ecb(des)",
 		.base.cra_driver_name	= "stm32-ecb-des",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2381,7 +2381,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "cbc(des)",
 		.base.cra_driver_name	= "stm32-cbc-des",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2404,7 +2404,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "ecb(des3_ede)",
 		.base.cra_driver_name	= "stm32-ecb-des3",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2426,7 +2426,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "cbc(des3_ede)",
 		.base.cra_driver_name	= "stm32-cbc-des3",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2460,7 +2460,7 @@ static struct aead_engine_alg aead_algs[] = {
 	.base.base = {
 		.cra_name		= "gcm(aes)",
 		.cra_driver_name	= "stm32-gcm-aes",
-		.cra_priority		= 200,
+		.cra_priority		= 300,
 		.cra_flags		= CRYPTO_ALG_ASYNC,
 		.cra_blocksize		= 1,
 		.cra_ctxsize		= sizeof(struct stm32_cryp_ctx),
@@ -2483,7 +2483,7 @@ static struct aead_engine_alg aead_algs[] = {
 	.base.base = {
 		.cra_name		= "ccm(aes)",
 		.cra_driver_name	= "stm32-ccm-aes",
-		.cra_priority		= 200,
+		.cra_priority		= 300,
 		.cra_flags		= CRYPTO_ALG_ASYNC,
 		.cra_blocksize		= 1,
 		.cra_ctxsize		= sizeof(struct stm32_cryp_ctx),
-- 
2.25.1


