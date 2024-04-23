Return-Path: <linux-kernel+bounces-155440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8B58AEA8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDF41C21C36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610F813D50A;
	Tue, 23 Apr 2024 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0SSYQ5J8"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66013BC29;
	Tue, 23 Apr 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885333; cv=none; b=g0ma/fRq/yFE3Z91WQ4q2cCXgW+Z7imyeXKcJbt9L6rd4DIYQUROZ6EP8NmyXkXxI27RxMBPUs65GNoGYFVjYvX3AEDpIoj7DlUeEl75yX7pR22YF7bldQSbFMfiy4FhdC2+SvUw+0MCndD1xzVXuEcR3ITbaQrylSlRNfSfCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885333; c=relaxed/simple;
	bh=+7L2xHxhehvAkcUf86WO8mIMGSDiqwaar3cKR/gKO/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9T6dpiCzWVqiPbI2lJf6rKls1rj8BChgle9jRENfCXPT0QmXogfsy8QFuVFkpOK7aKUCTONQauLVoFauWkwYuvoVLCY9kOsyRTEKYQ5naPoM6q+RoE0Fk7PXNv9D+bMdXSUb+FLXHV3uo8JURldTw0KudWYsOkX6HC3KSp2e54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0SSYQ5J8; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NBd3ME013106;
	Tue, 23 Apr 2024 17:15:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	selector1; bh=W5kriCTlwtswYN7XF7ASYU4t8GUwuuzQNeua46yCkMs=; b=0S
	SYQ5J85N5KCRVpjUXd+eHOFttpIcmbuGx+SH3nzSMjrxMR2BpdlroSjMvcAviYg8
	lU7oR9AxrUcY3GR1MA63vM+iFjTaX2JIsJu+1CuphywQHDJGrrJM2U/BwwthbIZU
	FgXHLepnK4UmIga3NvQpGpw0L+mhyfX64IJf6ICloN3Va2yjpLqohzkSejKIiq3A
	N+ymWZ1vSfZ8VEJYo/vG//2QoKSEJov1X3nAQrhlXAGo5DZRgn+WwvjbbO3e6RfE
	2skbS0z/EjkNkmJGzECM2SfBqRPKCm6S1U9Ag4Us20PgHUc/GVKsdgN2utsbLCbK
	zbxlC6JsTQ4gfHre5RoQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmrnj1q9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 17:15:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2C05440044;
	Tue, 23 Apr 2024 17:14:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A28122365F;
	Tue, 23 Apr 2024 17:14:16 +0200 (CEST)
Received: from localhost (10.48.86.103) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 17:14:15 +0200
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
Subject: [PATCH v2 2/3] crypto: stm32/cryp - increase priority
Date: Tue, 23 Apr 2024 17:14:08 +0200
Message-ID: <20240423151409.902490-3-maxime.mere@foss.st.com>
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

Increase STM32 CRYP priority, to be greater than the ARM-NEON
accelerated version.

Signed-of-by: Maxime Méré <maxime.mere@foss.st.com>
Signed-off-by: Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index 5b6d2fc68fea..36248975191c 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -2293,7 +2293,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "ecb(aes)",
 		.base.cra_driver_name	= "stm32-ecb-aes",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= AES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2315,7 +2315,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "cbc(aes)",
 		.base.cra_driver_name	= "stm32-cbc-aes",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= AES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2338,7 +2338,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "ctr(aes)",
 		.base.cra_driver_name	= "stm32-ctr-aes",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= 1,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2361,7 +2361,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "ecb(des)",
 		.base.cra_driver_name	= "stm32-ecb-des",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2383,7 +2383,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "cbc(des)",
 		.base.cra_driver_name	= "stm32-cbc-des",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2406,7 +2406,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "ecb(des3_ede)",
 		.base.cra_driver_name	= "stm32-ecb-des3",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2428,7 +2428,7 @@ static struct skcipher_engine_alg crypto_algs[] = {
 	.base = {
 		.base.cra_name		= "cbc(des3_ede)",
 		.base.cra_driver_name	= "stm32-cbc-des3",
-		.base.cra_priority	= 200,
+		.base.cra_priority	= 300,
 		.base.cra_flags		= CRYPTO_ALG_ASYNC,
 		.base.cra_blocksize	= DES_BLOCK_SIZE,
 		.base.cra_ctxsize	= sizeof(struct stm32_cryp_ctx),
@@ -2462,7 +2462,7 @@ static struct aead_engine_alg aead_algs[] = {
 	.base.base = {
 		.cra_name		= "gcm(aes)",
 		.cra_driver_name	= "stm32-gcm-aes",
-		.cra_priority		= 200,
+		.cra_priority		= 300,
 		.cra_flags		= CRYPTO_ALG_ASYNC,
 		.cra_blocksize		= 1,
 		.cra_ctxsize		= sizeof(struct stm32_cryp_ctx),
@@ -2485,7 +2485,7 @@ static struct aead_engine_alg aead_algs[] = {
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


