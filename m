Return-Path: <linux-kernel+bounces-61765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6298851650
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FFF1F2633E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965234654B;
	Mon, 12 Feb 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="dOOWvn0V"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7860F3E49B;
	Mon, 12 Feb 2024 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745911; cv=none; b=LwyOf4LvAOJKC+cUnIWvZnOJY558KHFQA5rFxJls7D8rQ16D4skzXJ5VD3cVZHrL2MalMnrRcdgy23xkD0Bg8KkjLVBJJN+0FmKP3kAENwtFi8C7YlT8TmH79HOi3QlMc45dGGQUfqc0AQ7A4Cs7KKGww1BXFjqlTq3mMKiCnaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745911; c=relaxed/simple;
	bh=XlynaIkF9qwbqnzwuOq9i2gMS0VMEsCKfNgPPjrYsD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkO6EJYFPlCH7yS1ikLHUUJWHsHiw2uFcuQPNRNgtzBmBBLauCdZby3oHO3PXZbIpbMWgnZTbVy8YlOp8DnFiK0+FoXqq40K33S3lGMfK7TSFcEdbcU1OFICd0g49bHhk6kFMQEtI4nYIwPHb9/bfqjh4GD3zMkXo9FwGr2oReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=dOOWvn0V; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B42A310001D;
	Mon, 12 Feb 2024 16:51:47 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B42A310001D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707745907;
	bh=IRwgLeIR6ybauKW+ejxf9w28ns0m/CaiGYPhKUCYNTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=dOOWvn0V4n+eHiKOTyBoulWgFXfNrzDewGNY9ZADOxNpkONMEV59gnVIfIDtGJToI
	 iQ428GiWVWUcwSf5e2gP7yWSAAwKTSBPnIarY86xKeKhwcxlQFZSZHus0uf71MZsDt
	 llLOo+oBE/1SopdfCWfQNbuoo+RXUi2WFYldGwPQdTqp7acu7BeQGCeHwVHZvzego2
	 6y4dV/QRqLQh/YDuXQTLKlflU0ebMY+yivozYycAxp9yhOgjYiE+w1nFAL9jsxCU1W
	 5S/x6nGsm5qfkXL2kaHqwn4wkNs0vOwK/nufeKDcHhvgQNgiXMNhdIeEYkzXMEJXNC
	 tuG3m66ebvVPg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 12 Feb 2024 16:51:47 +0300 (MSK)
Received: from user-A520M-DS3H.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 16:51:47 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <clabbe@baylibre.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <vadim.fedorenko@linux.dev>
CC: <linux-crypto@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@salutedevices.com>, Alexey
 Romanov <avromanov@salutedevices.com>
Subject: [PATCH v4 16/20] dt-bindings: crypto: meson: support new SoC's
Date: Mon, 12 Feb 2024 16:51:04 +0300
Message-ID: <20240212135108.549755-17-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212135108.549755-1-avromanov@salutedevices.com>
References: <20240212135108.549755-1-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183368 [Feb 12 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/12 07:49:00 #23556813
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
 .../bindings/crypto/amlogic,gxl-crypto.yaml   | 43 ++++++++++++++++---
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
index 948e11ebe4ee..41f0153d58c8 100644
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
+      - enum:
+          - amlogic,gxl-crypto
+          - amlogic,axg-crypto
+          - amlogic,g12a-crypto
 
   reg:
     maxItems: 1
 
   interrupts:
-    items:
-      - description: Interrupt for flow 0
-      - description: Interrupt for flow 1
+    minItems: 1
+    maxItems: 2
 
   clocks:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
   clock-names:
     const: blkmv
 
@@ -32,8 +42,27 @@ required:
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
+          items:
+            - description: Interrupt for flow 0
+            - description: Interrupt for flow 1
+    else:
+      properties:
+        interrupts:
+          items:
+            - description: Interrupt for flow 0
 
 additionalProperties: false
 
-- 
2.34.1


