Return-Path: <linux-kernel+bounces-69677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAB3858D33
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 05:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E72283741
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D831CA9B;
	Sat, 17 Feb 2024 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6uk8iaF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024AF1CA8A;
	Sat, 17 Feb 2024 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708144834; cv=none; b=XcmfGUNjdk6oyK3K4yhDHvGVICL8mlMIZgBnemhnmxORjEiplSQJMvL0hfKSYG6kpSkzCwr26+anPPf49jUza+4lXKIJ6bU9p2gIf7TN67bRuUSU03gAeuGqBqaWcPqEqgBXTrgey/ckQZHkFIoQm22H8FFpli9QsoZj0XYPdF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708144834; c=relaxed/simple;
	bh=vtNbiCf8dPvo8myozP2/Im+/upL82iYWSS1O9Sy10wM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MV2PKjeixIF64EmOqnBHtB8/aMUrNfk1y66zWGQd2V3oXW6DWvyErAv7SNWsL2Ekz45oBhU6UV7AqA1is0YDZ+Jycs/hG8nf1wHjo7z5HBwo/aDq0XrGpLGxGdOXiBy6lH7JFQcsCUbzFQn5v7cqf5eYiDP8p4iQmwi/sqMYwf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6uk8iaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9259AC43390;
	Sat, 17 Feb 2024 04:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708144833;
	bh=vtNbiCf8dPvo8myozP2/Im+/upL82iYWSS1O9Sy10wM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=a6uk8iaFExqKCvG6TVaVt4kGzuYUIUGWy5M/JllferAMgwTupd78xlWRHjrUzXq5T
	 ImTyyyPzV46AuBiZG7m+/joYYktJoH4uuViDBetorzDy/8Gp8eDkznCsJxe6jbQK3f
	 iEWwTH3+4+AMIRmBUuSo6dyl90Of4YIUaEFEGm5i+iJgDhMDR3qh0JwQgsWUm4LRom
	 +78oELK6XmcjRwmfWl7U92dpkygZ84/NooIRTZ/jjlioABGtKt5209LrZ5TcUeCU/M
	 QYHQSK4Uzljs4WQvTBUDfyQC3dov5usDOFgKDK42SIIcWRAMyFTTQzuw5F8FrYRJbX
	 1e4lzvOvySx7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7E3C5475B;
	Sat, 17 Feb 2024 04:40:33 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 17 Feb 2024 12:40:35 +0800
Subject: [PATCH 2/2] dt-binding: watchdog: arm,sp805: document the reset
 signal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-hisi-wdt-v1-2-cdb9ddcab968@outlook.com>
References: <20240217-hisi-wdt-v1-0-cdb9ddcab968@outlook.com>
In-Reply-To: <20240217-hisi-wdt-v1-0-cdb9ddcab968@outlook.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708144834; l=1040;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=HUldbqmBl21KlfOEiljP/y3O1Exgubj2VKDOCZ4vRqw=;
 b=/PKUGGOnHUsZta+uz74jNQ9BXBn4YtiauYN296RUBFBiX1nUzbuQoSFRuQn1heUk1+6JtgNd6
 2wcAhavXQaRAEDph8fHPc0BJADn6Dkns1GG3jF0qjNafC7XnpBEz7EC
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

The reset signal needs to be deasserted before operation of sp805
module. Document in the binding.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/watchdog/arm,sp805.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml b/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
index 7aea255b301b..6d4f63f23f1a 100644
--- a/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
+++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.yaml
@@ -50,6 +50,11 @@ properties:
       - const: wdog_clk
       - const: apb_pclk
 
+  resets:
+    maxItems: 1
+    description: |
+      WDOGRESn input reset signal for sp805 module.
+
 required:
   - compatible
   - reg
@@ -67,4 +72,5 @@ examples:
         interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&wdt_clk>, <&apb_pclk>;
         clock-names = "wdog_clk", "apb_pclk";
+        resets = <&wdt_rst>;
     };

-- 
2.43.0


