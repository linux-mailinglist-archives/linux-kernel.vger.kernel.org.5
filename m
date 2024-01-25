Return-Path: <linux-kernel+bounces-38986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0587583C960
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381421C25C81
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050341339B1;
	Thu, 25 Jan 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="tE0xOKud"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732B130E28;
	Thu, 25 Jan 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202004; cv=none; b=Hu7NH/QVk3LZwa4xw0FzVy3c+860ER80TcjkbtPI/HUkTaYGea/Gix732bb+V+QiHCRM3UzX7GJyKJd5LgsEMka6z+lXQJ5JiJ1qq9iRpqmVt3i3xzBiLzS5Sj3JmFzXa925+rSiI2gePAAjEzeBuvfCupxl31TeVQhjQaUBlLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202004; c=relaxed/simple;
	bh=8XCa7Qh9OppTXI92mefwhx8itAPRWOoF6MKaoDejCM4=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=Dxhwwsb8nKMJ87rPKVOyBcs+d4t7peByH+SGMarW5S6s2Oz5ocViLvDJynXYA41T1b11Swccd4xPvkCfehBKef3mUL0bE//894lUUMrNesIz2OZYSicrcd1Tn4pXq3YdmvC/3EgFu65qhA9FTEnGMoziS7X8UobB2TCZDshIA3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=tE0xOKud; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=bcHtdL0Jpkz0Bv6AwoLFCG1COeuQZJ/X6BxmGnNOwU8=; b=tE0xOKudeZv0bi7Prm6BPSatcw
	YwqE7PQZBczLVR8+7gXt3MVzR3+M7Sb3SiYHd8PcF4HKurkDyZyIQXVXa02dykonl5K+XReb8EQiD
	wlC/+gs3HW4uefHDQvle5N9QDXeVxPWAGBIfOW3eTIxeA2Q2iZgEid+TrCB62hjbgAkc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48112 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rT34q-0001qz-2l; Thu, 25 Jan 2024 11:59:44 -0500
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
Date: Thu, 25 Jan 2024 11:59:34 -0500
Message-Id: <20240125165935.886992-2-hugo@hugovil.com>
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
Subject: [PATCH v3 1/2] dt-bindings: arm: fsl: remove redundant company name
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Company name in compatible description appears twice, which is not really
helpful, so remove it from product name.

The board is a prototype developed by my company and we are still at the
prototype stage, so there is zero ABI impact.

Fixes: bb405e8b5336 ("dt-bindings: arm: fsl: add RVE gateway board")
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..f455c0172c84 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1026,7 +1026,7 @@ properties:
         items:
           - enum:
               - dimonoff,gateway-evk # i.MX8MN Dimonoff Gateway EVK Board
-              - rve,rve-gateway # i.MX8MN RVE Gateway Board
+              - rve,gateway # i.MX8MN RVE Gateway Board
               - variscite,var-som-mx8mn-symphony
           - const: variscite,var-som-mx8mn
           - const: fsl,imx8mn
-- 
2.39.2


