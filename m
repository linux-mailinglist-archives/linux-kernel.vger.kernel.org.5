Return-Path: <linux-kernel+bounces-22333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B30FA829C49
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5B7289270
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4D24CB33;
	Wed, 10 Jan 2024 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L2Mux3Jo"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E84C61B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e4582ed74so34287775e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704896091; x=1705500891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTbMSXCeFjG6LO+Gmu8KrQ2gSDiCAofLdnufyvOkqZY=;
        b=L2Mux3Joe6lZ319f2rqc+xe1g7LBG79wfwqtITpgUJ3vdEVbhnWXbIdE/D+ofQtreR
         WOOASHiO+c+s9zRwt2rgsbKl4rzkYmPnoXfHb9Mt5LGEOOe/Q9LUZn2m3fceiQJJLrOJ
         ny9l7PM1ibYPy1kRweuRP+uWPSDcss4xfvkeocwWsfVvfOh9RFo1zcvynxt5ilGq2/iy
         +/SXL8fXeINvJLIo8hhwfXJ9J+aQKD7VD6NzZ4laJe7qJxonP1NUthBctwyp79yaSL9L
         k8Il/JOt91AC8dfAB+zdMa5H0z7btE1nYRsOQsjHwzAIVmQ1EvQPWjnj73DzbBn/+toQ
         a3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704896091; x=1705500891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTbMSXCeFjG6LO+Gmu8KrQ2gSDiCAofLdnufyvOkqZY=;
        b=MsIiL2utT2hTjRs/a3Mg+P8FxqCxauaQUHFeQkAsCjS01TcylbO3k1H9bscIVWtkna
         RnGgupI5aj1N49AQXlrIVJz5ykDQqLb1eg3pn8pisn4uZc0hNoAk7aFINxfgZwHVZJBP
         mGg6ujYm8ihf5pYoQ76X1pHzaGvXXOVD9/O1k68KTjTkWNQmeJGvqGGEW6pz15WPaoPa
         BPQcFkGd5EGbDmohxsIepNdXIeDXpvUHbglfFqyXEb6FCuilu2+A3fg+Jds0brETHoV3
         9ZBmaMgt0EHUqfDQPK2t01PZ5kC2CcK+2ItsWuF5PRxBoTQBbptbmzmAn4K9AadOWZok
         bN1w==
X-Gm-Message-State: AOJu0YzkWsuKolPGC4LWtfJGQIu7wdjoxZqqijZQHoTN7HvSlWgE+rKg
	o3CWwFO5lu3Cr4vXihw0P5A1bxWLiHia0g==
X-Google-Smtp-Source: AGHT+IFQ0fw4bllANmyZFKNVcUHRj+VgEGSyZkYpe8Ze3kQgmS8CZ/CE6QB/n1TeHF1cdxT4PX8ciA==
X-Received: by 2002:a1c:7411:0:b0:40e:4ee3:2459 with SMTP id p17-20020a1c7411000000b0040e4ee32459mr307295wmc.347.1704896091436;
        Wed, 10 Jan 2024 06:14:51 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040c46719966sm2363890wms.25.2024.01.10.06.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:14:50 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
To: 
Cc: Louis Kuo <louis.kuo@mediatek.com>,
	Phi-Bang Nguyen <pnguyen@baylibre.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andy Hsieh <andy.hsieh@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Florian Sylvestre <fsylvestre@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-media@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 1/5] dt-bindings: media: add mediatek ISP3.0 sensor interface
Date: Wed, 10 Jan 2024 15:14:38 +0100
Message-ID: <20240110141443.364655-2-jstephan@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110141443.364655-1-jstephan@baylibre.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Louis Kuo <louis.kuo@mediatek.com>

This adds the bindings, for the mediatek ISP3.0 SENINF module embedded in
some Mediatek SoC, such as the mt8365

Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
Signed-off-by: Phi-Bang Nguyen <pnguyen@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Link: https://lore.kernel.org/r/20230807094940.329165-2-jstephan@baylibre.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../media/mediatek,mt8365-seninf.yaml         | 259 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 266 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
new file mode 100644
index 000000000000..0a7b7d949df7
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
@@ -0,0 +1,259 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2023 MediaTek, BayLibre
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mt8365-seninf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Sensor Interface 3.0
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+  - Julien Stephan <jstephan@baylibre.com>
+  - Andy Hsieh <andy.hsieh@mediatek.com>
+
+description:
+  The ISP3.0 SENINF is the CSI-2 and parallel camera sensor interface found in
+  multiple MediaTek SoCs. It can support up to three physical CSI-2
+  input ports, configured in DPHY (2 or 4 data lanes) or CPHY depending on the soc.
+  On the output side, SENINF can be connected either to CAMSV instance or
+  to the internal ISP. CAMSV is used to bypass the internal ISP processing
+  in order to connect either an external ISP, or a sensor (RAW, YUV).
+
+properties:
+  compatible:
+    const: mediatek,mt8365-seninf
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Seninf camsys clock
+      - description: Seninf top mux clock
+
+  clock-names:
+    items:
+      - const: camsys
+      - const: top_mux
+
+  phys:
+    minItems: 1
+    maxItems: 4
+    description:
+      phandle to the PHYs connected to CSI0/A, CSI1, CSI2 and CSI0B
+
+  phy-names:
+    minItems: 1
+    items:
+      - const: csi0
+      - const: csi1
+      - const: csi2
+      - const: csi0b
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI0 or CSI0A port
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI1 port
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+      port@2:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI2 port
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+
+      port@3:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: CSI0B port
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              clock-lanes:
+                maxItems: 1
+              data-lanes:
+                minItems: 1
+                maxItems: 2
+
+      port@4:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for cam0
+
+      port@5:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for cam1
+
+      port@6:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv0
+
+      port@7:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv1
+
+      port@8:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv2
+
+      port@9:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv3
+
+    required:
+      - port@0
+      - port@1
+      - port@2
+      - port@3
+      - port@4
+      - port@5
+      - port@6
+      - port@7
+      - port@8
+      - port@9
+
+required:
+  - compatible
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/power/mediatek,mt8365-power.h>
+
+    soc {
+          #address-cells = <2>;
+          #size-cells = <2>;
+
+          seninf: seninf@15040000 {
+                compatible = "mediatek,mt8365-seninf";
+                reg = <0 0x15040000 0 0x6000>;
+                interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_LOW>;
+                clocks = <&camsys CLK_CAM_SENIF>,
+                         <&topckgen CLK_TOP_SENIF_SEL>;
+                clock-names = "camsys", "top_mux";
+
+                power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+
+                phys = <&mipi_csi0 PHY_TYPE_DPHY>;
+                phy-names = "csi0";
+
+                ports {
+                      #address-cells = <1>;
+                      #size-cells = <0>;
+
+                      port@0 {
+                            reg = <0>;
+                            seninf_in1: endpoint {
+                              clock-lanes = <2>;
+                              data-lanes = <1 3 0 4>;
+                              remote-endpoint = <&isp1_out>;
+                            };
+                      };
+
+                      port@1 {
+                          reg = <1>;
+                      };
+
+                      port@2 {
+                            reg = <2>;
+                      };
+
+                      port@3 {
+                            reg = <3>;
+                      };
+
+                      port@4 {
+                            reg = <4>;
+                            seninf_camsv1_endpoint: endpoint {
+                                remote-endpoint = <&camsv1_endpoint>;
+                            };
+                      };
+
+                      port@5 {
+                            reg = <5>;
+                      };
+
+                      port@6 {
+                            reg = <6>;
+                      };
+
+                      port@7 {
+                            reg = <7>;
+                      };
+
+                      port@8 {
+                            reg = <8>;
+                      };
+
+                      port@9 {
+                            reg = <9>;
+                      };
+
+                };
+          };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 41e0862cfa7d..4444e719cf8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13611,6 +13611,13 @@ M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
 F:	drivers/char/hw_random/mtk-rng.c
 
+MEDIATEK ISP3.0 DRIVER
+M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+M:	Julien Stephan <jstephan@baylibre.com>
+M:	Andy Hsieh <andy.hsieh@mediatek.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
+
 MEDIATEK SMI DRIVER
 M:	Yong Wu <yong.wu@mediatek.com>
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
-- 
2.43.0


