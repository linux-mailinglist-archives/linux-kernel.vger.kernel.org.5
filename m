Return-Path: <linux-kernel+bounces-1935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D06D7815615
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707FB1F25869
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B7220E5;
	Sat, 16 Dec 2023 01:49:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AC1C3F;
	Sat, 16 Dec 2023 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id B02D024DFED;
	Sat, 16 Dec 2023 09:49:14 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 09:49:14 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 16 Dec
 2023 09:49:10 +0800
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>, Samin Guo
	<samin.guo@starfivetech.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Ley Foon Tan
	<leyfoon.tan@starfivetech.com>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/1] dt-bindings: watchdog: starfive,jh7100-wdt: Add compatible for JH8100
Date: Sat, 16 Dec 2023 09:48:50 +0800
Message-ID: <20231216014850.1011344-2-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231216014850.1011344-1-jisheng.teoh@starfivetech.com>
References: <20231216014850.1011344-1-jisheng.teoh@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add "starfive,jh8100-wdt" compatible string for StarFive's JH8100
watchdog.
Since JH8100 watchdog only has 1 reset signal, update binding
document to support one reset for "starfive,jh8100-wdt" compatible.

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 .../watchdog/starfive,jh7100-wdt.yaml         | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-w=
dt.yaml b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.=
yaml
index 68f3f6fd08a6..ab077f64a83e 100644
--- a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
@@ -19,14 +19,12 @@ description:
   isn't cleared, the watchdog will reset the system unless the watchdog
   reset is disabled.
=20
-allOf:
-  - $ref: watchdog.yaml#
-
 properties:
   compatible:
     enum:
       - starfive,jh7100-wdt
       - starfive,jh7110-wdt
+      - starfive,jh8100-wdt
=20
   reg:
     maxItems: 1
@@ -45,9 +43,7 @@ properties:
       - const: core
=20
   resets:
-    items:
-      - description: APB reset
-      - description: Core reset
+    maxItems: 2
=20
 required:
   - compatible
@@ -56,6 +52,27 @@ required:
   - clock-names
   - resets
=20
+allOf:
+  - $ref: watchdog.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - starfive,jh8100-wdt
+    then:
+      properties:
+        resets:
+          items:
+            - description: Core reset
+    else:
+      properties:
+        resets:
+          items:
+            - description: APB reset
+            - description: Core reset
+
 unevaluatedProperties: false
=20
 examples:
--=20
2.25.1


