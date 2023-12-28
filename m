Return-Path: <linux-kernel+bounces-12553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D3B81F6AC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E652856E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D25579C3;
	Thu, 28 Dec 2023 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="GDVGVZqn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6007466;
	Thu, 28 Dec 2023 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id EE47728C555;
	Thu, 28 Dec 2023 11:02:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1703757750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ulYHfJL4a5ktaQ0LB/F7mH1W93VxrEdW8tL9PPAz/s=;
	b=GDVGVZqn3z88bQUAkXgh9dHfS5mMVni/1i+u59lATKWgBy0g98G0DCbmRR3tc/mrp3d0DC
	K3dzg0a7Fkg3G3Y0fzH9LpJ+rnT4gOFV87BoDnmPgj6UicHrny3jxlu+hClzWra4cNDHx8
	Yk9pyT/vqZgNyMqAPJjA4jojsc51NZw=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id CC95E4423CE;
	Thu, 28 Dec 2023 11:02:30 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH 3/5] dt-bindings: regulator: add documentation entry for 88pm88x-regulator
Date: Thu, 28 Dec 2023 10:39:12 +0100
Message-ID: <20231228100208.2932-4-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
References: <20231228100208.2932-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

The Marvell 88PM88X PMICs provide regulators among other things.
Document how to use them.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 .../bindings/mfd/marvell,88pm88x.yaml         | 17 +++++++++++
 .../regulator/marvell,88pm88x-regulator.yaml  | 28 +++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml

diff --git a/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
index 115b41c9f22c..e6944369fc5c 100644
--- a/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
+++ b/Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml
@@ -54,6 +54,23 @@ examples:
         onkey {
           compatible = "marvell,88pm88x-onkey";
         };
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
       };
     };
 ...
diff --git a/Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml b/Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml
new file mode 100644
index 000000000000..c6ac17b113e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/marvell,88pm88x-regulator.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/marvell,88pm88x-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell 88PM88X PMICs regulators
+
+maintainers:
+  - Karel Balej <balejk@matfyz.cz>
+
+description: |
+  This module is part of the Marvell 88PM88X MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/marvell,88pm88x.yaml.
+
+  The regulator controller is represented as a sub-node of the PMIC node
+  in the device tree.
+
+  The valid names for 88PM886 regulator nodes are ldo[1-9], ldo1[0-6], buck[1-5].
+
+patternProperties:
+  "^(ldo|buck)[0-9]+$":
+    type: object
+    description:
+      Properties for single regulator.
+    $ref: regulator.yaml#
+
+additionalProperties: false
-- 
2.43.0


