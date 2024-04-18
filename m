Return-Path: <linux-kernel+bounces-149718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EA08A94F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44ED51C20BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1069146A7F;
	Thu, 18 Apr 2024 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e5GW/Wog"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F175143867;
	Thu, 18 Apr 2024 08:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428909; cv=none; b=akJqEc12N4oyO3nXv/6Y7/g4y8W+aGyLo+bD2ZzrpD0xhIeXC85SQN2NM5IwPnG9WgS3OuW+3JiHmO18Le4BJHSKrh2EItGin5r66AxiSMlrgM/blfdncA29m41Qf68ZHbjcXF4+rSU37fISJuUCRzDDSA2KZQwnaxudHs0FWlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428909; c=relaxed/simple;
	bh=xJ47AhVCJnPzfAzCCyTdF9TGxPyIWa3chHq1ZLjt15I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoh9E/Tc9b3uoZIrFjhHojvJYl+lQpzoX3Tf0cHFod/h1EEumKfnx5qjcLYvpfhJTliL2tvOoKL19+a8lM0sCl49LyXRgLwKI4iceqoc3NXkvzw/xLoE3Kbjfz2MRYXy+kAEODNj99RbwsYva429qp2zF5ZVzcbkctT7MKE3ePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e5GW/Wog; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713428901;
	bh=xJ47AhVCJnPzfAzCCyTdF9TGxPyIWa3chHq1ZLjt15I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5GW/WogRV/CULnhstD/d5HInPvtFtwGdcUDR3vX8KNUMZapdpKf25egaE2LYtQKG
	 aTIgNC9Ynj1xLDzW9BJpKzTx3GMm6Ht7aLIprY8p3vf5WgIV5JOAD0vquEmDiw03P4
	 ek15kfXoMbjrCH6Gq7SHYJaHpppwW4VOmWakd888Lw0CGnOg39GUDv5PDvwbP5tmP3
	 OzfVX6lBU7557Xwc4ZkhsA9LksgqZTyP/bwmb1bZCLETAjHzySD7dA9lcT2A4kV3oA
	 1Lfigu90IGTBNckSYrpYimYpK35PvjC8yJsIarvIuBYdsGqeREW+9X+JhxxHRr9wA1
	 Jgv6F5jqNye7A==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 01C533782146;
	Thu, 18 Apr 2024 08:28:19 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: djakov@kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	keescook@chromium.org,
	gustavoars@kernel.org,
	henryc.chen@mediatek.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org,
	amergnat@baylibre.com
Subject: [PATCH v3 3/7] dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
Date: Thu, 18 Apr 2024 10:28:08 +0200
Message-ID: <20240418082812.152270-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418082812.152270-1-angelogioacchino.delregno@collabora.com>
References: <20240418082812.152270-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the MediaTek Dynamic Voltage and Frequency Scaling
Resource Collector (DVFSRC), a hardware module used to collect all the
requests from both software and the various remote processors embedded
into the SoC and decide about a minimum operating voltage and a minimum
DRAM frequency to fulfill those requests in an effort to provide the
best achievable performance per watt.

This hardware IP is capable of transparently performing direct register
R/W on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
new file mode 100644
index 000000000000..da948098eebe
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/mediatek/mediatek,mt8183-dvfsrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC)
+
+description:
+  The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
+  Hardware module used to collect all the requests from both software and the
+  various remote processors embedded into the SoC and decide about a minimum
+  operating voltage and a minimum DRAM frequency to fulfill those requests in
+  an effort to provide the best achievable performance per watt.
+  This hardware IP is capable of transparently performing direct register R/W
+  on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+  - Henry Chen <henryc.chen@mediatek.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt8183-dvfsrc
+          - mediatek,mt8195-dvfsrc
+      - items:
+          - const: mediatek,mt8192-dvfsrc
+          - const: mediatek,mt8195-dvfsrc
+
+  reg:
+    maxItems: 1
+    description: DVFSRC common register address and length.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    enum: [ 0, 1 ]
+
+patternProperties:
+  "regulators@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/regulator/mediatek,mt6873-dvfsrc-regulator.yaml#
+
+  "interconnect@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/interconnect/mediatek,mt8183-emi.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        system-controller@10012000 {
+            compatible = "mediatek,mt8195-dvfsrc";
+            reg = <0 0x10012000 0 0x1000>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            regulators@0 {
+                compatible = "mediatek,mt8195-dvfsrc-regulator";
+                reg = <0>;
+
+                dvfsrc_vcore: dvfsrc-vcore {
+                        regulator-name = "dvfsrc-vcore";
+                        regulator-min-microvolt = <550000>;
+                        regulator-max-microvolt = <750000>;
+                        regulator-always-on;
+                };
+
+                dvfsrc_vscp: dvfsrc-vscp {
+                        regulator-name = "dvfsrc-vscp";
+                        regulator-min-microvolt = <550000>;
+                        regulator-max-microvolt = <750000>;
+                        regulator-always-on;
+                };
+            };
+
+            emi_icc: interconnect@1 {
+                compatible = "mediatek,mt8195-emi";
+                reg = <1>;
+                #interconnect-cells = <1>;
+            };
+        };
+    };
-- 
2.44.0


