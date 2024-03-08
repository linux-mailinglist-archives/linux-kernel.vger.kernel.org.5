Return-Path: <linux-kernel+bounces-97368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A9876991
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50B21F22E71
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB9A58AD9;
	Fri,  8 Mar 2024 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HA4ECSJf"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E428DA6;
	Fri,  8 Mar 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918309; cv=none; b=XGrTxzZcvheGytB3jlUTnzdE6DvvNhyx8+90pEo6D2hoFZhoddIPGJZMdUzNp31RoNBbAJ9KhcKa09il02U+tVTyMTIeLPTHuAKzxx7Nr2T8BUZvnyZCOzY+Suz9aKHCTY/nL7fEHoyNCiqOEAWwvBIsDeywR1QAV1Rm5IZyhA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918309; c=relaxed/simple;
	bh=nk0694HdvY49hVbvEOBszReAqBL6XI4pN9/4MeXvheU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=arOwFIM/Gw2ADajybAW0WZaOtWoLwPl3qtTb2Ype/YbnXD9TC6iYzlOIHWWrmPqWLxbD3ADK1XvKSyGbdzDLrOk5Gw1ZCJO5pvxG/jh5J4aLwKJA4MliN4Y1Crtc49kyD4smHHEKKHxGSeNb3Dcz05XCdJhapaKu6A+hxWoGiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HA4ECSJf; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5415CC0005;
	Fri,  8 Mar 2024 17:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709918299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNms7RL0icimFpEg39nbbIwCCVvraktcinQEWSShPjQ=;
	b=HA4ECSJfUQ3aBKJDbX9bEwwdh1hAX9KCtxzWxfGrN1xghbXTzpgi9WAAPG5PBpTp02q2mo
	lxGmf9qtxrpL58I8YHGme7MWU+3sQffOWPIqOD+RG/uiB6gMzfA1rB7HvYijZ63QM+mUws
	UqEHPQaByM6qaupug2ZRSIW+6m40hjmQcR9N4otzZIDMQGWeCLceBWX39hZ2U+xYYaijWJ
	XzPfgwtxjsysC/d0LoYYqtfSFfzkScFWyOG1LN4spB7fSGjUp1N2sOZ9ly/fxLwi4SXEIv
	pOLD6zQvOVzFtrN91V8Z4fw3QwMmzlimPUymJ+hxj9bYlBZL61z2nVqtlW419w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Mar 2024 18:18:18 +0100
Subject: [PATCH 03/11] spi: cadence-qspi: allow building for MIPS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240308-cdns-qspi-mbly-v1-3-a503856dd205@bootlin.com>
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

The Cadence QSPI Controller driver is used on Mobileye EyeQ5 platform.
Allow building on MIPS.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ddae0fde798e..77489dad2945 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -246,7 +246,7 @@ config SPI_CADENCE
 
 config SPI_CADENCE_QUADSPI
 	tristate "Cadence Quad SPI controller"
-	depends on OF && (ARM || ARM64 || X86 || RISCV || COMPILE_TEST)
+	depends on OF && (ARM || ARM64 || X86 || RISCV || MIPS || COMPILE_TEST)
 	help
 	  Enable support for the Cadence Quad SPI Flash controller.
 

-- 
2.44.0


