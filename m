Return-Path: <linux-kernel+bounces-133206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5E389A07F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2741C234EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F6116FF2A;
	Fri,  5 Apr 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CU+Bk9VN"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72C16F826;
	Fri,  5 Apr 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329341; cv=none; b=f01a6dKIhTeIONX6Gbw8EDQ5iV6NIt+cE1iezGVdcDmZ7uvaZooUH+0U41iXeaMsy8VEp3sPqUJ7Mi8nQaoyBAL6h9daT1a0Yf+xsst21Sqfup+Xe7juokhXtQgiUu1uFng2cl3ChaUvwnwLy6J16CthrUa69mQCAxWjyh4rfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329341; c=relaxed/simple;
	bh=JYqa8ClMGY37mf7kIy93d39+cOUrt+d9iRtScZqNWn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IRP/Ct391JRYruGQcNr+4xw7SRTGWK0W9jLEOWrBCtUVfzS8tusSUltsAXQ8rRWSQtiq56AvxOfat+JAteT38iBM0b/B0oetBLQZJe5ZjG6uaYAorac3KlCX3NgBO0a0kmM7Gp2X9CzKHNFYJhYDFkaw7uLeFTDqcusU0VSh7vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CU+Bk9VN; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC8FE1BF203;
	Fri,  5 Apr 2024 15:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712329337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//mrmmNpsITXWI/YjExwEf3g6/noqwNFwDTbVRFFcWs=;
	b=CU+Bk9VNIPYfIPNQw8srECJKdGq5AePaAEO9uYNuRQUoheQVYuTAO8bFjQeC28ZcDL7oAn
	Cz+70+5ToE1x9xbbEWb2ws1b+cVeYh82YrAIbYG8cKh1TGZZzqO8LpAevanT2Xm1N9iX8t
	6RH8cJLxtjfjFKNkoPumB4NwQXaFLZDnsBNCOowY4NW8mQSPk1WHuekMIayn+Es5J0ABJM
	SWBSxlWUkmeEtqCjSRKTHCYewkidrGfQhAMuaEJK81Z26z0/o3nPrbSCJiq98X1Mv2glGB
	aSBLr5yDt6WTJPOSm36WDEDEiLB3y+P7T0QmrQW8zPlehyuJ9ecJGWcmZcUsWA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 05 Apr 2024 17:02:13 +0200
Subject: [PATCH v2 03/11] spi: cadence-qspi: allow building for MIPS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240405-cdns-qspi-mbly-v2-3-956679866d6d@bootlin.com>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
In-Reply-To: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
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

The Cadence QSPI Controller driver is used on Mobileye EyeQ5 platform.
Allow building on MIPS.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index bc7021da2fe9..548af3d9e30d 100644
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


