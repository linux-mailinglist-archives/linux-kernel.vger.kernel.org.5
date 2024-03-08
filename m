Return-Path: <linux-kernel+bounces-97365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 996AE876986
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5140B22CFF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E723BBE3;
	Fri,  8 Mar 2024 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JinAFtZD"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F25282E1;
	Fri,  8 Mar 2024 17:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918307; cv=none; b=LXvKMd30C98kvf1RbjIhqj6NFO/T3SrhIK7d073hmVbXnsVJemJKTGOwb+8hk/Li7F4Z/BiObEE/TxMECrnGstk4xEYk7iH+bT3XNYnHx0OFMv56TsZ4Suyt4+fUjUQhJJ2zBtZP/7v0Se3Ws6La6hq+65suHUnbIVXVOHO9wm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918307; c=relaxed/simple;
	bh=SU8R2y4/XuqxTtYghpt2nzG2hjyN0IAUqTl830ap1V0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEThSgtCgALTpe8pGe2qMKFw2tfXm7gR+PIu8Xdfa1I/DRyV/MjAnXKIGOPw8bJfl+MEzKhMN9+I2dqztHNYa+PJ6+ZwWeTOLT/1BKrP2dhjtHkiYUomzubyoNFnYEjsLi1DyQZh9mY3Ihj3HZppw2ojAQymEri8LGtlhUa4TEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JinAFtZD; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D838C0006;
	Fri,  8 Mar 2024 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709918298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1ZW8csWkCGVE3gvbimGZ4O77Vq0iVPh60n1dHennJc=;
	b=JinAFtZDuCzcKJiWT9oO4ML2pG9VbIGv91fydzWzixAiXLdPrz07Po3Wr7LFPvUdI54XC1
	PhhwaZJppQ2SRbH9z7o0CX1cG8k9PJkSrR2W72EFX5ZBEz02a9KzBnMoclawK7e1qmDsT0
	Jfvg1kbQQndhMh/cvGynw2deAAEm2w7EYqrWdlzGWWhB8/8DV6SZ4cqX2EQ3Z7saeK0FYH
	Ype7+iBLH/3Od/xDTPNmcsfBPT328Cnhq+7FB1dhVQNg/hVR6j52GPu9ZHyzbnjT7EeBdY
	Eroimu6mS2SIguDsea1fNOnFpJP/XxSMdZ9s8WeS8+kFo07b+f6az5Enqtj0uA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 08 Mar 2024 18:18:16 +0100
Subject: [PATCH 01/11] dt-bindings: qspi: cdns,qspi-nor: add
 mobileye,eyeq5-ospi compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240308-cdns-qspi-mbly-v1-1-a503856dd205@bootlin.com>
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

Add Mobileye EyeQ5 compatible.
FIFO depth shall not be passed; hardware can detect it.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index cca81f89e252..cf7abf48673a 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -61,6 +61,17 @@ allOf:
         cdns,fifo-depth:
           enum: [ 128, 256 ]
           default: 128
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mobileye,eyeq5-ospi
+    then:
+      properties:
+        cdns,fifo-depth: false
+    else:
+      required:
+        - cdns,fifo-depth
 
 properties:
   compatible:
@@ -74,6 +85,7 @@ properties:
               - xlnx,versal-ospi-1.0
               - intel,socfpga-qspi
               - starfive,jh7110-qspi
+              - mobileye,eyeq5-ospi
           - const: cdns,qspi-nor
       - const: cdns,qspi-nor
 
@@ -145,7 +157,6 @@ required:
   - reg
   - interrupts
   - clocks
-  - cdns,fifo-depth
   - cdns,fifo-width
   - cdns,trigger-address
   - '#address-cells'

-- 
2.44.0


