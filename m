Return-Path: <linux-kernel+bounces-12469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 662C681F534
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983EB1C21BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D6163C6;
	Thu, 28 Dec 2023 06:53:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C163AC;
	Thu, 28 Dec 2023 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 4FE0D24E295;
	Thu, 28 Dec 2023 14:53:36 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Dec
 2023 14:53:35 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Dec
 2023 14:53:30 +0800
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Yangtao Li <frank.li@vivo.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Linus Walleij
	<linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alex Soo <yuklin.soo@starfivetech.com>
Subject: [PATCH 1/3] dt-bindings: mmc: sdhci-cadence6: add DT bindings documentation
Date: Thu, 28 Dec 2023 14:53:20 +0800
Message-ID: <20231228065322.1176351-2-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231228065322.1176351-1-yuklin.soo@starfivetech.com>
References: <20231228065322.1176351-1-yuklin.soo@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add DT bindings documentation for Cadence SD/eMMC host controller
(Version 6) driver.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 .../devicetree/bindings/mmc/cdns,sd6hci.yaml  | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sd6hci.yam=
l

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hci.yaml b/Doc=
umentation/devicetree/bindings/mmc/cdns,sd6hci.yaml
new file mode 100644
index 000000000000..97e28d720c7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hci.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/cdns,sd6hci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence SD/SDIO/eMMC Host Controller Version 6.0 (SD6HC)
+
+maintainers:
+  - Alex Soo <yuklin.soo@starfivetech.com>
+
+allOf:
+  - $ref: mmc-controller.yaml
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - starfive,jh8100-sd6hc
+      - const: cdns,sd6hc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: main
+      - const: sdmclk
+
+  clocks:
+    items:
+      - description: main clock gate which controls the gating of all cl=
ock signals to SDHCI
+                     controller
+      - description: the SD master clock signal
+
+  resets:
+    items:
+      - description: reset phandle which controls the assert/deassert of=
 all reset lines to
+                     SDHCI controller
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    emmc: mmc@1f110000 {
+        compatible =3D "starfive,jh8100-sd6hc", "cdns,sd6hc";
+        reg =3D <0x1f110000 0x10000>;
+        interrupts =3D <174>;
+        clock-names =3D "main", "sdmclk";
+        clocks =3D <&aoncrg 62>,
+                 <&aoncrg 43>;
+        resets =3D <&aoncrg 9>;
+        bus-width =3D <8>;
+    };
--=20
2.25.1


