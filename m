Return-Path: <linux-kernel+bounces-150325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893648A9D64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453AF281798
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365F9168B05;
	Thu, 18 Apr 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZtruPcUq"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2230165FB0;
	Thu, 18 Apr 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451476; cv=none; b=Ay89gUnGg+eIY1l7xWMWZei4JF6/o/OmC1y3alRPW0RnDvcaMeYKtaXeWZkfYXPqwSIORWXLaAhPu1Sqw6JnjkxIRWCA7h1I8/Mg7VlzMwCPO6v8Hz8kld7W26Lff0lZN8u1gi12ArKcIR92zDrQNEEEZ1uUmZsUxZdGem6iWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451476; c=relaxed/simple;
	bh=UIezYAfelGoCLrej/SHQHu9Cudpg7wVfZ/TNzIFOnxI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=itRRCXUSH9q+tDlniQ5dl70aNdMKO5o9yVYj5a0Ji7SgPIzPNqSotHSwM//ZQ74ujKXS9YSoAHS0+uzBvJpOAUzcCqPwJOcwRbtkG1ZXGR1C+OQj3BGCLQ8qLRg56dNbm9WT8H5ptDXGk3xCjZ5Kdb5kxHU3TEyfqY+g9L3+0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZtruPcUq; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IE6PO6030179;
	Thu, 18 Apr 2024 16:44:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=selector1; bh=vhAIipHO+m7PSgyeEztd
	ns8sMS1ah/Ng1G9Fc0eikUA=; b=ZtruPcUqXI8KB/V93yloOv7dlzaouJZyraYT
	sxfBYYIfb95wVhckrTuq/Y1ttHalUl9YciCN9LPyzHiz8jjQ5gUwf5AdqCCU1xLP
	5Zk8GstFdCE39aGAdPoe+P92c+Cpr7qeo6gzmodHdxCIzrKB+l7YuBkokUpsubAR
	0C+xeB87nTNaxgNGo7GWbPQOlKrK+UVDZXyqJbvWP8iYQZzFwnf0UCsm5uYHBxil
	vSQP34UfcreRf/IMsIwgPUv5DKZtQTyAdhZNCbuXsgbBhOTHG5/ebPzwkAxpJadM
	akj/TBv12HAoy0sRWyIIpQk0nZduW8CihbwicLUoqlBsppjtKw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xgecym5dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 16:44:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 248FE40044;
	Thu, 18 Apr 2024 16:43:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 37A4621ED2A;
	Thu, 18 Apr 2024 16:43:01 +0200 (CEST)
Received: from localhost (10.48.86.103) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 16:43:00 +0200
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
Subject: [PATCH 0/3] crypto: stm32/cryp - Improve stm32-cryp driver
Date: Thu, 18 Apr 2024 16:42:53 +0200
Message-ID: <20240418144256.3736800-1-maxime.mere@foss.st.com>
X-Mailer: git-send-email 2.25.1
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
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_12,2024-04-17_01,2023-05-22_02

From: Maxime Méré <maxime.mere@foss.st.com>

This series of patches mainly aims to improve the usage of DMA with the
CRYP peripheral of the STM32 MPU series. The other two patches are needed
to enhance the driver's visibility for ST platforms.

Maxime Méré (3):
  crypto: stm32/cryp - use dma when possible.
  crypto: stm32/cryp - increase priority
  crypto: stm32/cryp - add CRYPTO_ALG_KERN_DRIVER_ONLY flag

 drivers/crypto/stm32/stm32-cryp.c | 722 ++++++++++++++++++++++++++++--
 1 file changed, 678 insertions(+), 44 deletions(-)

-- 
2.25.1


