Return-Path: <linux-kernel+bounces-38987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B7683C961
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F6C299168
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3981339B4;
	Thu, 25 Jan 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="RABzovkS"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C512FF99;
	Thu, 25 Jan 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202004; cv=none; b=DEv2jWbAjobvIp6wJRXMZQGqDs5qbbk+z7DXQAP5cDRzOv7aAjTXYhZgJ5iDMWEZogXLSiUBnqNid+90kQvHWaRJbD2ezyS2rgNr1nLHFlsUpvyVHRoXpmiRi39xK7XnN5ZiGrG1S5LsET+D5HYjwXBrBrKcS8Ledzfie+89AVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202004; c=relaxed/simple;
	bh=uUvP/Xg9uFs1E8+6CwafLn9B4SkKPLlMbH3oAgssuCA=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=G9nyt/le6ORnde5+Ihd9vlNSET02yhhv/tpt2daquFhPnGOhuMLWDyAXryAGbsZ9Ziwgs0kUQJXWDgB4OWw+ZQKu5dyFmhO+ysFcDTHhotarxBjtUxP+E1PqLuOqLcD2+9oosrtgxzid9AQp5BxQ87399j3pCZvZG98+GU1BOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=RABzovkS; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=/6ue+7JJseCL6n+4HhRQMzcrnbbEUcvQpDog+ZL8f7w=; b=RABzovkSNGxMhdGthvMz9RPZYb
	oKzpYmRjbvWSc6zLtPPKsR/LjTvjGjOd5uW4aaVr3O0ihPrHqwSoKGjXDZuuYsUq9KjnfB9gtgnr+
	XK1UvR93iBm8wHyO3Cc2u16a17JExerToek2o92WG0UvcIeCsdwNhcIpDUpHC/GbV3ns=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48112 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rT34r-0001qz-8V; Thu, 25 Jan 2024 11:59:45 -0500
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
Date: Thu, 25 Jan 2024 11:59:35 -0500
Message-Id: <20240125165935.886992-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125165935.886992-1-hugo@hugovil.com>
References: <20240125165935.886992-1-hugo@hugovil.com>
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
Subject: [PATCH v3 2/2] arm64: dts: imx8mn-rve-gateway: remove redundant company name
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Company name in compatible description appears twice, which is not really
helpful, so remove it from product name.

The board is a prototype developed by my company and we are still at the
prototype stage, so there is zero ABI impact.

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


