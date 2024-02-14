Return-Path: <linux-kernel+bounces-65525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72705854E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A619E1C20F86
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5904C612C3;
	Wed, 14 Feb 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MWNUmwvA"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C960864;
	Wed, 14 Feb 2024 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927899; cv=none; b=UHtRfkNUcCNKT7/Fd13nmVRayOq6556XFLsizd47zURjS0qRpWhUdGk1nxVP1SojtLGY2TZRolIRRHEg2cEnZzN8Sv5Ucn1P8LR8bpsAnnhNwS7Mdhb6nmR5FYLJOTd5uXjFASanPU/muO2HkUBVvbIUySIJt3mbxONMfzR5u1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927899; c=relaxed/simple;
	bh=8E7Wy8AkHFPCX2Q+tqPqYDkUm9YDHngVl5svTe4s0As=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbqlxIc7HzpBi8Ghme750mKz43WO/ZptbaHX5z+IZa0uO4W8wGY5AeQwOJQL+oM2FijeOceatEWVx9bPkTm7U2qJyJWe/iCudRNUufwcqykff5AtoL6WXCEWNWDeRUSAyFW6prZwB/g3dTnxh05Ze7XPLloOMrtkFN32jhEJIPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MWNUmwvA; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DD976001A;
	Wed, 14 Feb 2024 16:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707927895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1qrTeQNU3DDMwNE9nbpFTPD5p88DGc3qAx/J2q1BTU=;
	b=MWNUmwvA/pQkLlh0zDXoss2zpp0GzNy2efEJY8cU5OTUH+bV0iSsJeWl+GwBaDjkrLJinu
	SL3qDvaUMyRtyU8PDFVKj8AJZsBVOPjpZlPSwj7bpHojXQ6iDft/LgCvkeHY62xTZsjWnI
	mqSedQUzJuKLj49P/VTQyKGU1TpnPhcOJczUCXaW3ASGu3NDbjuxSdBZzXrf2HcbPaie5N
	8yulKOeYd0lluGLE/veWJ++6Fu2eiZQuDrmRjR17FxsKNYHL/ZYxe54OdoFNqcEvFbkJn3
	3SD0DEx3parSHUQQt2rhEZjcKpg3Ng9qFXJvKKDDWJl9fOJQDbGUaePKD22M/A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 14 Feb 2024 17:24:08 +0100
Subject: [PATCH 15/23] gpio: nomadik: change driver name from gpio to
 gpio-nomadik
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240214-mbly-gpio-v1-15-f88c0ccf372b@bootlin.com>
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
In-Reply-To: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

This GPIO driver is historically related to the Nomadik platform. It
however can be used by others as it implements the ST STA2X11 IP block.
Pick a less ambiguous name for it.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/gpio/gpio-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 2e7d3840b714..25c8490aa1b6 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -647,7 +647,7 @@ static const struct of_device_id nmk_gpio_match[] = {
 
 static struct platform_driver nmk_gpio_driver = {
 	.driver = {
-		.name = "gpio",
+		.name = "nomadik-gpio",
 		.of_match_table = nmk_gpio_match,
 	},
 	.probe = nmk_gpio_probe,

-- 
2.43.1


