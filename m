Return-Path: <linux-kernel+bounces-133204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF84689A07A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790C8287333
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15F116F8F3;
	Fri,  5 Apr 2024 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NEXcKC/n"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A216F83A;
	Fri,  5 Apr 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329340; cv=none; b=JoCch8eCAgZX4N+/tXA79mX9pTYNHXAdAJUJA5gfAEjV2s4k9wsJ2TDwGvj8TmqbcRyO5ESK1V6XGSVmHPkkXQsaIufBanNPvZnlaN7fJcydLFELM+V8DMsOGrYkGm5fqVFv0vM8IENZ5a+PRAO5cDrGz1eslovilNAPjaaj6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329340; c=relaxed/simple;
	bh=Fv59z7lNREOZ9zqggxggPs2+8dCuzPBU1A5Z3HcBFGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kbnL+GaLl+n/2iVSNhE6KHAATmkw4TKWQrNRoWk4st69WF4oj2NZ6alzznygFG2t3oR8Ys23MTfVV7z+0DVC5WgC48x9IgtHUbqpDmD9YmIM9EV9l/U1+rSq2ylYi9xNKUxqpxE91vNBDdI1U6Bh7SwUUIbPJZuIuDIK+artP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NEXcKC/n; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8027F1BF210;
	Fri,  5 Apr 2024 15:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712329336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzJfFQbN8uRXN7g6fZUa72H4ER4DsHLI5fXnygcJqVA=;
	b=NEXcKC/nJoeOj4z85TKUHfO7Ufw4Hu1vLkHXsBoc4uu0qAxFacaLS3pPs8LFPGJapWNK15
	pwgrBB5MQ1EfN2OdfFg3niRDEAdXnyMcjdR35QL0pUZKO0F6cfzfwMd0vF7jspYrraUQOq
	f9zK/ZFV72Z7Lmpjiw2JAmuN+BN53nmJy7uj4OU7vxU9P1fN0jEeuSKPqY6m7TLA5FGoPF
	wj1VtEwrBpco9jAOEj4x/kcloPVgIStfH6b6Cs7xJVNrPW5YfbLmG+RmreIq7FjouIOBPw
	G9hbkEfAsYr3i6ZDKHlRjYLdSNggg7rrA9rwSrEHtUcbB7+dvBEVuZ2sfiY3IQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 05 Apr 2024 17:02:11 +0200
Subject: [PATCH v2 01/11] spi: dt-bindings: cdns,qspi-nor: add
 mobileye,eyeq5-ospi compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240405-cdns-qspi-mbly-v2-1-956679866d6d@bootlin.com>
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add Mobileye EyeQ5 compatible.
FIFO depth shall not be passed; hardware can detect it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index cca81f89e252..5509c126b1cf 100644
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
@@ -68,6 +79,7 @@ properties:
       - items:
           - enum:
               - amd,pensando-elba-qspi
+              - mobileye,eyeq5-ospi
               - ti,k2g-qspi
               - ti,am654-ospi
               - intel,lgm-qspi
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


