Return-Path: <linux-kernel+bounces-37277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968AE83ADA9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E0289565
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C896F7CF0E;
	Wed, 24 Jan 2024 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="mtVUL5TH"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA727A724;
	Wed, 24 Jan 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706111151; cv=none; b=OwlG9h0Z2LCGXM+qRT6yWxcEIRnnu2fNdPEbSuo3+Jnv2cDE9k4EP1bf3Z8h4OPBiOFjXr2ueGvAFSiJdfNE949/CS7L/eEk/w1u5GZRIF/Xq6weJdZEHa7bHcWXR9Y4hCsAMckIXCwpiTyHBMRj/Zn80F7HppkTX4s/U6oay9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706111151; c=relaxed/simple;
	bh=B3WDKkmrlVOWI/LPemHKRxp7EZwsQfNlpWjUjIzH2MU=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=OyoWDnoZrYCmbceveBX5feOQA7pzoIgpEdk52Y22LloBnpjPVl31ohAoYcg42RGtQiDTaOZ61HAi5grg3l4R6dNOUkcSUvkOgWXllKcNLOuSz9qcmvfQJMyACI2YTOukgzzrx3v3BKTkra3MmIQypL3QOBCndouzej/nThxzKB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=mtVUL5TH; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=J7acFEtpPDajsbbDC0lrPyBCz3dN4ZDx6rM5yN/XWKk=; b=mtVUL5THrCha2dPqpXOaKxdmlx
	nKFroWUguPZFgS8vnrz8apP6WYnv/h034u5nm9V9/KJoobZTJZlpMiIdQVEaRIhnROOQYdpj3TPn+
	g67VMgPa0nEdvNxoUTlC2RCl8hi83KddfVIrwlq5lx88xgrkGVMJA7t6YpvNcGwWxvBw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:46384 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rSfRd-0007N8-Fk; Wed, 24 Jan 2024 10:45:41 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	leoyang.li@nxp.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	hugo@hugovil.com,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Jan 2024 10:44:21 -0500
Message-Id: <20240124154422.3600920-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124154422.3600920-1-hugo@hugovil.com>
References: <20240124154422.3600920-1-hugo@hugovil.com>
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
Subject: [PATCH 2/2] arm64: dts: imx8mn-rve-gateway: remove redundant company name
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Company name in compatible description appears twice, which is not really
helpful, so remove it from product name.

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


