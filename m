Return-Path: <linux-kernel+bounces-60683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C8850868
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B41AB21C9E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76715A4CD;
	Sun, 11 Feb 2024 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="TUYZLq4r"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9965B59168;
	Sun, 11 Feb 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707644831; cv=none; b=bnUmt+Ga3l1a9p9NM4AZSsD0OAl90tieiImmA6VH2XylqlY3aIM3IHT9YedAeuHQhVI55B4wo66kvH+SnIL6v9lmBgPmqV0qUC72ejeYcjrdpZnd+1Qqa0iHZzBuciDkXf6EdwXez2LZV5tsE6ySF1AEChTxIiI1kLoVWn7964c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707644831; c=relaxed/simple;
	bh=oqauVdjizpK0nSqK/k+yascV7g6ah9iuGuFIqFuEPk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYj379eJpfm39KLUqFQG8VKYVQv3+/7AvDyXdWLza7gVS5bZAAOdDX+24G1eCxQVV3FGbP0LfAunbyq2Tp7x0jh+9SI/Q7W19cOvZfVSoAqE6D+So7iBUEdNhRtRv71Hvxfv2+/5vfcc0TDB+ErPxn4h9z1lOP1i4105bvK2x4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=TUYZLq4r; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 66E772811C0;
	Sun, 11 Feb 2024 10:47:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1707644820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1dd6eTc4LuIWcje8dVYWy0TKIb1SEY0gJW1Mf2PyJcw=;
	b=TUYZLq4rPBpv91SS5xG8EGT9euIw+fgu2Tsr16UjY3Fm4AXV8PoRSAyaTCvrFklmNPEuWY
	zwZ58p0AboOSifjInOnzV9lxuM5rcKnXwW/ClXWlKMnOvKKsOdiw+cFVVKjaCg4va36AT1
	R6wHvMIEzQUDuCGbgoWxa3CkAzfNJmg=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 436CA457D27;
	Sun, 11 Feb 2024 10:47:00 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH v2 1/6] dt-bindings: mfd: add entry for Marvell 88PM886 PMIC
Date: Sun, 11 Feb 2024 10:35:51 +0100
Message-ID: <20240211094609.2223-2-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

Marvell 88PM886 is a PMIC with several subdevices such as onkey,
regulators or battery and charger. It comes in at least two revisions,
A0 and A1 -- only A1 is described here at the moment.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    RFC v2:
    - Address Rob's feedback:
      - Drop mention of 88PM880.
      - Make sure the file passes bindings check (add the necessary header
        and fix `interrupt-cells`).
      - Other small changes.
    - Add regulators. Changes with respect to the regulator RFC series:
      - Address Krzysztof's comments:
        - Drop unused compatible.
        - Fix sub-node pattern.

 .../bindings/mfd/marvell,88pm88x.yaml         | 74 +++++++++++++++++++
 .../regulator/marvell,88pm88x-regulator.yaml  | 28 +++++++
 2 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml

diff --git a/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
new file mode 100644
index 000000000000..29ab979862d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/marvell,88pm88x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell 88PM88X PMIC core
+
+maintainers:
+  - Karel Balej <balejk@matfyz.cz>
+
+description:
+  Marvell 88PM886 is a PMIC providing several functions such as onkey,
+  regulators or battery and charger.
+
+properties:
+  compatible:
+    const: marvell,88pm886-a1
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  interrupts:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 1
+
+  regulators:
+    $ref: /schemas/regulator/marvell,88pm88x-regulator.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pmic@30 {
+        compatible = "marvell,88pm886-a1";
+        reg = <0x30>;
+        interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&gic>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        regulators {
+          ldo2: ldo2 {
+            regulator-min-microvolt = <3100000>;
+            regulator-max-microvolt = <3300000>;
+            };
+
+          ldo15: ldo15 {
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            };
+
+          buck2: buck2 {
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+            };
+        };
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml b/Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml
new file mode 100644
index 000000000000..1b4b5f1b4932
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/marvell,88pm88x-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulators of Marvell 88PM88X PMICs.
+
+maintainers:
+  - Karel Balej <balejk@matfyz.cz>
+
+description: |
+  This is a part of device tree bindings for Marvell 88PM88X MFD.
+
+  The regulators node is represented as a sub-node of the PMIC node on the
+  device tree.
+
+  See also Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml for
+  additional information and example.
+
+patternProperties:
+  "^(ldo(1[0-6]|[1-9])|buck[1-5])$":
+    type: object
+    $ref: /schemas/regulator/regulator.yaml#
+    description: LDO or buck regulator.
+    unevaluatedProperties: false
+
+additionalProperties: false
-- 
2.43.0


