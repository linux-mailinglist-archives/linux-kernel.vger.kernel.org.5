Return-Path: <linux-kernel+bounces-134934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CF289B903
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9AA283D85
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460164AED5;
	Mon,  8 Apr 2024 07:45:11 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CBA4AEC5;
	Mon,  8 Apr 2024 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562310; cv=none; b=NfTbmQghi72JGnTyUmYhTyDBj+S2ZIpyGH2DJH+4urJ9wf3K/HEH7v4dRV68+Q5nS4vASKwEK9GML4qTiAlihbJe8ZVJv3BPCaaY24rTWBFTKyNIVLiznItW68lZI+emHYD8vx4zTmxyUaBFMHeFJtH+tG/beQhUZ79aM4U47I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562310; c=relaxed/simple;
	bh=0JENu9WiKSJLpeMNzJmm8wbacwTWaUoERNUlp28ay3s=;
	h=From:To:Subject:Date:Message-Id; b=jB36hZpk3mgK2O9y1E0UWP/jZYtoLNoDJvKCd9lg2Iw3nWNrZ2M86mtMMCLn7KXi4E3iGeSK3JC6fQD6Cxdzj4LtoPC+/b1o1R4R/8NvNlLhhqL7u9BkOvFtsjNquRYTaROPdLm6mWafJjCwmFEHtiTZBhtXUorgTeAUbt8MT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FBEC201B11;
	Mon,  8 Apr 2024 09:45:01 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6DA58201AF9;
	Mon,  8 Apr 2024 09:45:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 970C0183AC0A;
	Mon,  8 Apr 2024 15:44:58 +0800 (+08)
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
Subject: [PATCH v2] ASoC: dt-bindings: imx-audio-spdif: convert to YAML
Date: Mon,  8 Apr 2024 15:27:13 +0800
Message-Id: <1712561233-27250-1-git-send-email-shengjiu.wang@nxp.com>
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
changes in v2:
- change file name to imx-spdif.yaml
- remove |
- add anyof for spdif-in and spdif-out requirement
- change example name to sound

 .../bindings/sound/imx-audio-spdif.txt        | 36 ----------
 .../devicetree/bindings/sound/imx-spdif.yaml  | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/imx-spdif.yaml

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
diff --git a/Documentation/devicetree/bindings/sound/imx-spdif.yaml b/Documentation/devicetree/bindings/sound/imx-spdif.yaml
new file mode 100644
index 000000000000..beb214b51a50
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-spdif.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/imx-spdif.yaml#
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
+      - enum:
+          - fsl,imx-audio-spdif
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
+    description:
+      If present, the transmitting function of S/PDIF will be enabled,
+      indicating there's a physical S/PDIF out connector or jack on the
+      board or it's connecting to some other IP block, such as an HDMI
+      encoder or display-controller.
+
+  spdif-in:
+    type: boolean
+    description:
+      If present, the receiving function of S/PDIF will be enabled,
+      indicating there is a physical S/PDIF in connector/jack on the board.
+
+required:
+  - compatible
+  - model
+  - spdif-controller
+
+anyOf:
+  - required:
+      - spdif-in
+  - required:
+      - spdif-out
+  - required:
+      - spdif-out
+      - spdif-in
+
+additionalProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "fsl,imx-audio-spdif";
+        model = "imx-spdif";
+        spdif-controller = <&spdif>;
+        spdif-out;
+        spdif-in;
+    };
-- 
2.34.1


