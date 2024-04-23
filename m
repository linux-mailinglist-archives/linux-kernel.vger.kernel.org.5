Return-Path: <linux-kernel+bounces-154827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBF18AE19F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABAF1F23FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4EB63099;
	Tue, 23 Apr 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p51pCjr/"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82405FBAA;
	Tue, 23 Apr 2024 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866514; cv=none; b=tpohSanHd7DNsZ15I1xbCI+K+gNeMtIswAzfJ37o3aeYkVpiuNjfRS4d5ULC06PiDl36JtkayBslAL6sDOKzfBz1Cxi5kZ1sGd1jvOONmr773oO3A6SbHCvzZDTeDpvjj0fkx3O/pEDWz4vEKPtxT0IlE/H/5Ss4piEOOx5c5CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866514; c=relaxed/simple;
	bh=BNr7Q4jmb2WwnjfsAAi09SDjB7HAi4IIuSZgRKHvw5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phQitGvZ/MWKW81itIWgBe0GRA9GItgThDUsutvauFzSKJUu3p9o9j94uegUSw2ds96ThFUv4OpoK+PAVD6GYvD1pj34BbN+WTgafcr3zYA+Jt+awiJGXgP0Odeq0Ffdp+OJPIKVOt+vIbrzGJJCc1Z9oGSGZLNEU7y1R7iPeGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p51pCjr/; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8189D1C001C;
	Tue, 23 Apr 2024 10:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713866511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9d1LWBS78fz/noWt+gqf119+B397lC3IF2943t1mJfE=;
	b=p51pCjr/a5r4zzZu1njCWQXO3/yoPufH9zRqZh84JLpWmBtq3mWr26sDFzZ+PTatF/fC8g
	NSUJmWPx/gMi53afkoTr4Z5ZlcmG/o5zBdmzcuDRPDDf9OXJ30v74dqB925vcGq2RBvw4o
	tFt8hjnSzNcVdJk2vfKAmb7n8uQASlk7rmjvA/k+cdji2Qk3UvmBfhwlLe4TjAihVYdgll
	u5thehFVolGgeg1Xg35wdrls78JW7HcgHvdAtQjVzWrISyTDSkuuu4JAd/qtDghltq2c69
	nKRcGwdrLcTMp6Bg57uG40ChpxrXU3ptJpVFTzB3WQDw7Os4dW3UxIo9GnhPeg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Apr 2024 12:01:43 +0200
Subject: [PATCH v4 4/6] spi: cadence-qspi: add mobileye,eyeq5-ospi
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-cdns-qspi-mbly-v4-4-3d2a7b535ad0@bootlin.com>
References: <20240423-cdns-qspi-mbly-v4-0-3d2a7b535ad0@bootlin.com>
In-Reply-To: <20240423-cdns-qspi-mbly-v4-0-3d2a7b535ad0@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Declare a new mobileye,eyeq5-ospi compatible.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 87c88ee708e4..05ebb03d319f 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2055,6 +2055,12 @@ static const struct cqspi_driver_platdata pensando_cdns_qspi = {
 	.quirks = CQSPI_NEEDS_APB_AHB_HAZARD_WAR | CQSPI_DISABLE_DAC_MODE,
 };
 
+static const struct cqspi_driver_platdata mobileye_eyeq5_ospi = {
+	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION |
+			CQSPI_RD_NO_IRQ,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -2088,6 +2094,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "amd,pensando-elba-qspi",
 		.data = &pensando_cdns_qspi,
 	},
+	{
+		.compatible = "mobileye,eyeq5-ospi",
+		.data = &mobileye_eyeq5_ospi,
+	},
 	{ /* end of table */ }
 };
 

-- 
2.44.0


