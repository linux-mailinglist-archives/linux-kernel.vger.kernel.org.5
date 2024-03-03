Return-Path: <linux-kernel+bounces-89699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB6286F452
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15FA4B21765
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF4CFBFD;
	Sun,  3 Mar 2024 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="OtimUvm/"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2CBA30;
	Sun,  3 Mar 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709460938; cv=none; b=hlx0S7RswA2EocWNWK/b2PqoWpq2TEiIV4YIGfZGnmC1mkPxDMV6OWPaI5EuX5eApSrQFlARGtJjyg6ASUfFqG1DQaspMEXviIl/wf3JpxnFw4pBThrg7CAT8FKSuEplYK4C1xUneZOGyQidKQgOMVOMhFJja+rSnm3L6fhgd5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709460938; c=relaxed/simple;
	bh=R6YYY+vpVbo5nxzzB1tqlhfbOWzLEQy5/+Ton+dIJjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAqBk5qHgB3ROyF7SH3O4oYdDSIFtTA3SthxtrcvXLSclW16YRzyU0LUaMqNTDjKRd1gVLFSbAEYQ/LHxx9y+Gx3ykSP15GTDrlSMuuDpsCgBCik5sy5PzinaWZH3Qc/ICoqR1f83wYGQuji3rE3xTA8klV83Jh4YNwNAHTNoHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=OtimUvm/; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id C8871284290;
	Sun,  3 Mar 2024 11:15:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1709460926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqM2m/EgTSqkL6d+GqfITU+aAhAGH+pq/fWiHyN8krk=;
	b=OtimUvm//Dfjq0LJBwnqOgR6G72hoD4ofA3tWDhNWe3YjAyjSF6CUXtUc20TjvtvOiz2Kc
	ek9fz0LANXioGElR5tsAIeLB+hZzIPKp8QaA6OssrbeVy4CBXDHVG32sFGEcMEnJV32Dzy
	4ZNnngtBhnrI+YrWAS1P8IRFGFapmAE=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id A7154456F3E;
	Sun,  3 Mar 2024 11:15:26 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH v3 1/5] dt-bindings: mfd: add entry for Marvell 88PM886 PMIC
Date: Sun,  3 Mar 2024 11:04:22 +0100
Message-ID: <20240303101506.4187-2-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
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
    RFC v3:
    - Add wakeup-source property.
    - Address Rob's feedback:
      - Move regulators into the MFD file.
      - Remove interrupt-controller and #interrupt-cells properties.
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

 .../bindings/mfd/marvell,88pm886-a1.yaml      | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml

diff --git a/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml b/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
new file mode 100644
index 000000000000..61ffbf669e90
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/marvell,88pm886-a1.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/marvell,88pm886-a1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell 88PM886 PMIC core
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
+  interrupts:
+    maxItems: 1
+
+  wakeup-source: true
+
+  regulators:
+    type: object
+    additionalProperties: false
+    patternProperties:
+      "^(ldo(1[0-6]|[1-9])|buck[1-5])$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        description: LDO or buck regulator.
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
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
+        wakeup-source;
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
-- 
2.44.0


