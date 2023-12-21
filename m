Return-Path: <linux-kernel+bounces-8009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A448A81B08B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75131C21ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D541775B;
	Thu, 21 Dec 2023 08:44:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32018B1B;
	Thu, 21 Dec 2023 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id F203D24E269;
	Thu, 21 Dec 2023 16:44:29 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:44:29 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:44:23 +0800
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>, Samin Guo
	<samin.guo@starfivetech.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>
CC: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Ley Foon Tan
	<leyfoon.tan@starfivetech.com>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
Subject: [PATCH v5 1/2] dt-bindings: watchdog: starfive,jh7100-wdt: Add compatible for JH8100
Date: Thu, 21 Dec 2023 16:43:57 +0800
Message-ID: <20231221084358.3458713-2-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221084358.3458713-1-jisheng.teoh@starfivetech.com>
References: <20231221084358.3458713-1-jisheng.teoh@starfivetech.com>
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
 .../watchdog/starfive,jh7100-wdt.yaml         | 40 ++++++++++++++-----
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-w=
dt.yaml b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.=
yaml
index 68f3f6fd08a6..e21f807b0b69 100644
--- a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
@@ -19,14 +19,16 @@ description:
   isn't cleared, the watchdog will reset the system unless the watchdog
   reset is disabled.
=20
-allOf:
-  - $ref: watchdog.yaml#
-
 properties:
   compatible:
-    enum:
-      - starfive,jh7100-wdt
-      - starfive,jh7110-wdt
+    oneOf:
+      - enum:
+          - starfive,jh7100-wdt
+          - starfive,jh7110-wdt
+      - items:
+          - enum:
+              - starfive,jh8100-wdt
+          - const: starfive,jh7110-wdt
=20
   reg:
     maxItems: 1
@@ -45,9 +47,8 @@ properties:
       - const: core
=20
   resets:
-    items:
-      - description: APB reset
-      - description: Core reset
+    minItems: 1
+    maxItems: 2
=20
 required:
   - compatible
@@ -56,6 +57,27 @@ required:
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


