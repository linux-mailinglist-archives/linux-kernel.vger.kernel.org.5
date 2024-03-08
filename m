Return-Path: <linux-kernel+bounces-97375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C73A58769AE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042891C21031
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9175E083;
	Fri,  8 Mar 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X9aVg9/q"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD1657884;
	Fri,  8 Mar 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918312; cv=none; b=H4+7M4g9MUAsmPBD492aKb+Zcw5fLucGRgknpzM7rDKeFZGkWykVGN/aoFbNc8MiaHIyLEOdwMJsn7JQz4tVojcto6Z3y9jjgu86JWAktWUDi+Ntc3Cwk1P8It5domCZIII7NaxGqVfiXD7Jy+YnXSECUQJ53/H0wSBrvl2BbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918312; c=relaxed/simple;
	bh=E0t6bF/4dRoh6j8qffNxazRcYBw8oIfU33XsZM5uMLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utl/uF4EO7/1uEpps7YZ3DNYz2PXedbTqYIeffxulKn71qkdTpjibNaIxi91FJaQY1FttLiKLPWbRc64vsafUVeSWr+rn9irzMcKd1GzOPacTNcxIuUKirCNFEugPupSbfC62uTGVKrjKuXb5L1j9+2z74MW9VKWNRsoVFIzCt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X9aVg9/q; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03FD3C000E;
	Fri,  8 Mar 2024 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709918303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGb9e89q1LiUktbIoiZeA2KMG4e+G1lEPOW1m5KfN4U=;
	b=X9aVg9/qhraKN94VDBDlfhLYjXH67Q+YJ6LtY368WNqu1tKWcWUHk/XN7rP75AlNcvAd5h
	9zHJPH89XoFQm+gbwb6wNY9n43mUhI2y4BpX4RaSq14SwDWQSfQFCTFPsX6xdOqd62j6Bj
	VTtBm/3VhnuECzWOnV+Irf1YV9kgF2zWrmjaF7uklybXJBkCTl2vn3X58wOruAprKQfloi
	1ShWi8uuDvxE7tcAxyiF/fVxhn4QMZILWZVBvkWtsrFvo9o1FXdqzL80tn+f62xfnUM5xV
	O8jxlL+j+WbCcjtEULFuKDAeaMF5XPQ/Z5skpk3u+M5VGgwlS3RSKMKWzZeMPg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Mar 2024 18:18:24 +0100
Subject: [PATCH 09/11] spi: cadence-qspi: add mobileye,eyeq5-ospi
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240308-cdns-qspi-mbly-v1-9-a503856dd205@bootlin.com>
References: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
In-Reply-To: <20240308-cdns-qspi-mbly-v1-0-a503856dd205@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Declare a new mobileye,eyeq5-ospi compatible. Exploit quirk flags:
detect FIFO depth through SRAMPARTITION register; avoid IRQs during
read operations.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 2ad9c736f85f..046388cacc66 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2060,6 +2060,13 @@ static const struct cqspi_driver_platdata pensando_cdns_qspi = {
 	.quirks = CQSPI_NEEDS_APB_AHB_HAZARD_WAR | CQSPI_DISABLE_DAC_MODE,
 };
 
+static const struct cqspi_driver_platdata mobileye_eyeq5_ospi = {
+	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION |
+			CQSPI_DETECT_FIFO_DEPTH | CQSPI_RD_NO_IRQ |
+			CQSPI_BUSYWAIT_EARLY,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -2093,6 +2100,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
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


