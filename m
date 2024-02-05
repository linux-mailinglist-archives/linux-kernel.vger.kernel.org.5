Return-Path: <linux-kernel+bounces-52978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D815849F14
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7075B22C1B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222584EB31;
	Mon,  5 Feb 2024 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ObOBhIxw"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26BD487A5;
	Mon,  5 Feb 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148562; cv=none; b=bd4nStTEsljgNNAbyobym7TnNSZ+4zUg3LQpJVYBCU4KqX9ODjx2TGOSPVM/Bun8+lf0aTpnH6rxRgs3OHEmNP3Y1KlMREpKf2DgOqTFTqtYsYG25ieTRfEk1jNd+Yhwkn03+jvxR1Dom/a3O9DRsmbLT5YmNT4doK5Aa+nnnvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148562; c=relaxed/simple;
	bh=U82af4k2rze0/Z1C/jV7i/fuTOcbKHrpKIIHOU71Mh8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hva2c11r7c6+BNMzxTisgpTWVQ9BsrUx0LhIsJTqLiScvyKNfF4lcloPAaQ5Hy7Hv/kJ3GSpJ7MqaiKPrAvFCSksbUMenNH2/WkD7ZAhB8zCH6pVqaPS0iElN8PRH+XydXjgdcFP/iUpUdkEEXC9FA3vrYePu1yZkC51/GDO41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ObOBhIxw; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3A791120010;
	Mon,  5 Feb 2024 18:55:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3A791120010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707148555;
	bh=Qr+VxAONZ0O5FrIx5qGgU5o0/1J7EjtyJnC2a1liQBs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ObOBhIxw1ND/D59ROxoV6jOdzysPYSF3pWpv4/L9osVgYUJoUIFhvSuURCWZKcG6w
	 dBt1uuH+8zAZtPh8bcNHCwIT6yu6W+qbeENp0omj71BQtI/rapK2RrXSER+tc3mOCb
	 A6Yf+SArwX2n6AdvXMfyKUiyZVWcGLRWdvzr4bhQZQ6KtoieROIr3G2Ct7IywXWy4l
	 ajiZMXgYE4DT2ij08ZZd0gEQ/ziOsmR9DHBo13JIpxLb4qIpYGUMWDdV8FZichL8Bq
	 km5bz52zrlWjJW3yGLs7CaOjD7PvswrueaHUcnJ/cmQ87iJAamEowiTC57heaUQWQk
	 bHPoOOPuE+AyA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  5 Feb 2024 18:55:55 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 18:55:54 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <clabbe@baylibre.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <linux-crypto@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>
Subject: [PATCH v3 16/20] dt-bindings: crypto: meson: support new SoC's
Date: Mon, 5 Feb 2024 18:55:17 +0300
Message-ID: <20240205155521.1795552-17-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205155521.1795552-1-avromanov@salutedevices.com>
References: <20240205155521.1795552-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183204 [Feb 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/05 10:19:00 #23362212
X-KSMG-AntiVirus-Status: Clean, skipped

Now crypto module available at G12A/G12B/S4/A1/SM1/AXG.

1. Add new compatibles:
  - amlogic,g12a-crypto
  - amlogic,s4-crypto (uses g12a-crypto as fallback)
  - amlogic,a1-crypto (uses g12a-crypto as fallback)
  - amlogic,axg-crypto

2. All SoC's, exclude GXL, doesn't take a clock input for
Crypto IP. Make it required only for amlogic,gxl-crypto.

3. All SoC's, exclude GXL, uses only one interrupt flow
for Crypto IP.

4. Add power-domains in schema.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 .../bindings/crypto/amlogic,gxl-crypto.yaml   | 44 +++++++++++++++----
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
index 948e11ebe4ee..62f772036b06 100644
--- a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
+++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
@@ -11,20 +11,30 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - const: amlogic,gxl-crypto
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,a1-crypto
+              - amlogic,s4-crypto
+          - const: amlogic,g12a-crypto
+      - items:
+          - const: amlogic,gxl-crypto
+      - items:
+          - const: amlogic,axg-crypto
+      - items:
+          - const: amlogic,g12a-crypto
 
   reg:
     maxItems: 1
 
-  interrupts:
-    items:
-      - description: Interrupt for flow 0
-      - description: Interrupt for flow 1
+  interrupts: true
 
   clocks:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
   clock-names:
     const: blkmv
 
@@ -32,8 +42,26 @@ required:
   - compatible
   - reg
   - interrupts
-  - clocks
-  - clock-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amlogic,gxl-crypto
+    then:
+      required:
+        - clocks
+        - clock-names
+      properties:
+        interrupts:
+          maxItems: 2
+          minItems: 2
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+          minItems: 1
 
 additionalProperties: false
 
-- 
2.34.1


