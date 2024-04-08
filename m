Return-Path: <linux-kernel+bounces-134799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB00589B715
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C681F21F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F2979EA;
	Mon,  8 Apr 2024 05:14:05 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D57470;
	Mon,  8 Apr 2024 05:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712553245; cv=none; b=aakpLeXoHYHECzaYI+e+ecLsVaVdtP2Luvw28U+k+vKXeQTTIc38fW5S1txkXKq/WFFcamMeY0GKt/e/BswXwZ+UIo0BhMpCVRg9xDwoZa4sbC3idDSKKIxb/qawT8U+08GLjGPyA/6EZ6+zNFDl/YjFJJOqnZHmK0HfFoFN0Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712553245; c=relaxed/simple;
	bh=DLwbCxfXbeWl6N3M1HF6ulR5vBBN4/iqyDlNh+AnF8k=;
	h=From:To:Subject:Date:Message-Id; b=Pu2PhX98juSRx3SEXRr2hHAx/JJDl+Ls9/1xZmffOccveIgHhfkS70P8L/wuLa08gki87UggvjSuTpKcwhN+IOSRS1ddpJmw6UaAq8BFJW/tBfCvzgYASG2A9/XOzwNP1a2SkqwwJG69Vld6wL70uOcIW9SgqYH6w58Ic+LC808=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 644221A1276;
	Mon,  8 Apr 2024 07:13:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 005931A08A6;
	Mon,  8 Apr 2024 07:13:56 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 31AD31820F77;
	Mon,  8 Apr 2024 13:13:54 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ASoC: dt-bindings: imx-audio-spdif: convert to YAML
Date: Mon,  8 Apr 2024 12:55:42 +0800
Message-Id: <1712552142-27055-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Convert the imx-audio-spdif binding to YAML.

When testing dtbs_check, found below compatible strings
are not listed in document:

fsl,imx-sabreauto-spdif
fsl,imx6sx-sdb-spdif

So add them in yaml file to pass the test.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../bindings/sound/imx-audio-spdif.txt        | 36 -----------
 .../bindings/sound/imx-audio-spdif.yaml       | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.yaml

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
deleted file mode 100644
index da84a442ccea..000000000000
--- a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Freescale i.MX audio complex with S/PDIF transceiver
-
-Required properties:
-
-  - compatible		: "fsl,imx-audio-spdif"
-
-  - model		: The user-visible name of this sound complex
-
-  - spdif-controller	: The phandle of the i.MX S/PDIF controller
-
-
-Optional properties:
-
-  - spdif-out		: This is a boolean property. If present, the
-			  transmitting function of S/PDIF will be enabled,
-			  indicating there's a physical S/PDIF out connector
-			  or jack on the board or it's connecting to some
-			  other IP block, such as an HDMI encoder or
-			  display-controller.
-
-  - spdif-in		: This is a boolean property. If present, the receiving
-			  function of S/PDIF will be enabled, indicating there
-			  is a physical S/PDIF in connector/jack on the board.
-
-* Note: At least one of these two properties should be set in the DT binding.
-
-
-Example:
-
-sound-spdif {
-	compatible = "fsl,imx-audio-spdif";
-	model = "imx-spdif";
-	spdif-controller = <&spdif>;
-	spdif-out;
-	spdif-in;
-};
diff --git a/Documentation/devicetree/bindings/sound/imx-audio-spdif.yaml b/Documentation/devicetree/bindings/sound/imx-audio-spdif.yaml
new file mode 100644
index 000000000000..b29e024f553f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audio-spdif.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/imx-audio-spdif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX audio complex with S/PDIF transceiver
+
+maintainers:
+  - Shengjiu Wang <shengjiu.wang@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx-audio-spdif
+          - enum:
+              - fsl,imx-sabreauto-spdif
+              - fsl,imx6sx-sdb-spdif
+      - items:
+          - enum:
+              - fsl,imx-audio-spdif
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+  spdif-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the i.MX S/PDIF controller
+
+  spdif-out:
+    type: boolean
+    description: |
+      If present, the transmitting function of S/PDIF will be enabled,
+      indicating there's a physical S/PDIF out connector or jack on the
+      board or it's connecting to some other IP block, such as an HDMI
+      encoder or display-controller.
+
+  spdif-in:
+    type: boolean
+    description: |
+      If present, the receiving function of S/PDIF will be enabled,
+      indicating there is a physical S/PDIF in connector/jack on the board.
+
+required:
+  - compatible
+  - model
+  - spdif-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    sound-spdif {
+        compatible = "fsl,imx-audio-spdif";
+        model = "imx-spdif";
+        spdif-controller = <&spdif>;
+        spdif-out;
+        spdif-in;
+    };
-- 
2.34.1


