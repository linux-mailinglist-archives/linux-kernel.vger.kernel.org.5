Return-Path: <linux-kernel+bounces-37366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FFA83AEDA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E651C22966
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412117E777;
	Wed, 24 Jan 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="erE85xfv"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0F7E574;
	Wed, 24 Jan 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115397; cv=none; b=Di4gTiagbnGrG5FYVHvYle1x9WsSn3E4SNwq7mYbsftcRSYRTmxvQqHuUEPqyQYrGWDtyAPuzs4zfLo5AilCLBzxIIjm2Rsvk+QJI+PsYZ8YrLXTEcEfhcPRW7N7ESgon0hRIYX/L8WV2Nf2EluEOIq1zxnjJAPOvJevO92+SfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115397; c=relaxed/simple;
	bh=N/kGM6SSHeoHMJ/i/c2gY34ro1FC3sWkupBy+t0cAyk=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=ATmSc2h5G9mBrKQzpQpcleckVbR3jpsYRPzJ2BvOWa8MC71W24Aqn9c3Nij3XsqyVDZwpdOxQAsMSfrrmu43I+uCmgM5bNVInoSo/YCvNMJDdj3dHNkSysDh+EMziiRFfxlmH3krh7ss4kCuSV0xIxojrsQvCptUmpl7Ad0ADSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=erE85xfv; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=BprktDcYRExOw/27QWQGvLSVRCiQlLMf3BAYhVwKXac=; b=erE85xfvepTFm0ptxWkoTE1IAC
	KqNdeL+oXb//LAH9P2RczM1XWDJD/cwUeHdGSqB6qRKIuc9rRkjdsfxZB/vdVp0Z4KY1fTambXfjS
	ByjSNrPWbGrgj7YkgpEEVAknRU6aJDfG+xBA527PDAUk5ywLjBh8Q2zIXGYh6REoPCAo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:45420 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rSgY9-0007ym-At; Wed, 24 Jan 2024 11:56:29 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	leoyang.li@nxp.com,
	hvilleneuve@dimonoff.com
Cc: krzysztof.kozlowski@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com
Date: Wed, 24 Jan 2024 11:46:46 -0500
Message-Id: <20240124164646.1506814-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124164646.1506814-1-hugo@hugovil.com>
References: <20240124164646.1506814-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH v2 2/2] arm64: dts: imx8mn-rve-gateway: remove redundant company name
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Company name in compatible description appears twice, which is not really
helpful, so remove it from product name.

Fixes: 67275c2f3d9b ("arm64: dts: freescale: introduce rve-gateway board")
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts b/arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts
index 1b633bd1ebb6..ea1855171fb0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-rve-gateway.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "RVE gateway";
-	compatible = "rve,rve-gateway", "variscite,var-som-mx8mn", "fsl,imx8mn";
+	compatible = "rve,gateway", "variscite,var-som-mx8mn", "fsl,imx8mn";
 
 	crystal_duart_24m: crystal-duart-24m {
 		compatible = "fixed-clock";
-- 
2.39.2


