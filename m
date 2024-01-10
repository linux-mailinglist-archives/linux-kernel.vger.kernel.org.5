Return-Path: <linux-kernel+bounces-22335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9418829C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9444A28A98F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F304CB46;
	Wed, 10 Jan 2024 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LrFx8zTW"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39EC4C3C1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e5508ecb9so13053115e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704896092; x=1705500892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuFDvSADQtGDFtauNpgCupae53N/r/mrPBZ1wNJIP/4=;
        b=LrFx8zTWGqUqT7nGKTJOZWieZBi9kF8nvvVjE98kBx1rQ8LNQFLcA7cSb+NyJrpXEc
         uDzxMyNHhn6mx/LKb2iFY+nU6n/r24BpzLThHa8HBoQPfAJExFV3yTKV5Kn1kq7Rku7V
         d5zupqii1NxrN2iPkkED+0lhSMttldpKqDb9IEMa1OWUV/SlXEkE9Hi93J1K6da1+T1v
         mCR1rMZqfOd6zFwz6tTN7EiWzrjeUKBVkR124QDUuX+UX4SDpddFfSUCI1a8QvK2y4ij
         q4qeSn0m53Ash0GsmrxybJcgTxfm7Evrn1F11gcEaKEESerlYgoiKkEk+l4VEzrn5Tj6
         OVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704896092; x=1705500892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuFDvSADQtGDFtauNpgCupae53N/r/mrPBZ1wNJIP/4=;
        b=WgtbdpdYVLIqYah4vBrbUVXVoQoORdm6ffmU4lA1qgQFOKO2Fmb+A6LkaOQfrXzSzY
         d5iLzAoALazC/sOugg255WK5P71OVOF3vHwPDS6LdfsMwmMmxXy0QwnIrCl1Lcqx50Sg
         10ZD2mb/XGkwSlP1gjsEQy6Z55qQUvZSRtr0qZrYLMfrrXDd4v85UJ8OL2bF0BR76s1B
         0q1NheaVQ2F1zElBDpTSArBKN5W2cQsue/JLdAd4hasqbBAyTElRxHuKjkJeLCniFlh3
         K/TPqiBH5OcNfXoMCJP2lTugg92QIjl8Nv06bhi44lsjjFpzgKLHlsENjYT1Ret+dvCE
         o9gQ==
X-Gm-Message-State: AOJu0YwJE905INzaVS6KDYxWXzFJWsmkQgpRuH6HT6nS2LTiIxM7mvgM
	nLiyJVndlbDxhpX+CMmlgtNcwfqnhV/yMQ==
X-Google-Smtp-Source: AGHT+IHZolr5WggqPbXLxR47q9yPpF3T42AXvS0/DfzP512YbRVeysQflzhKSgg+c6y2x25aCBirKw==
X-Received: by 2002:a1c:7c02:0:b0:40e:42b5:a19b with SMTP id x2-20020a1c7c02000000b0040e42b5a19bmr668080wmc.154.1704896092186;
        Wed, 10 Jan 2024 06:14:52 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040c46719966sm2363890wms.25.2024.01.10.06.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:14:51 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
To: 
Cc: Phi-bang Nguyen <pnguyen@baylibre.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Andy Hsieh <andy.hsieh@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Florian Sylvestre <fsylvestre@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-media@vger.kernel.org,
	Louis Kuo <louis.kuo@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 2/5] dt-bindings: media: add mediatek ISP3.0 camsv
Date: Wed, 10 Jan 2024 15:14:39 +0100
Message-ID: <20240110141443.364655-3-jstephan@baylibre.com>
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

From: Phi-bang Nguyen <pnguyen@baylibre.com>

This adds the bindings, for the ISP3.0 camsv module embedded in
some Mediatek SoC, such as the mt8365

Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Link: https://lore.kernel.org/r/20230807094940.329165-4-jstephan@baylibre.com
---
 .../bindings/media/mediatek,mt8365-camsv.yaml | 109 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml b/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
new file mode 100644
index 000000000000..097b1ab6bc72
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2023 MediaTek, BayLibre
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek,mt8365-camsv.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek CAMSV 3.0
+
+maintainers:
+  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+  - Julien Stephan <jstephan@baylibre.com>
+  - Andy Hsieh <andy.hsieh@mediatek.com>
+
+description:
+  The CAMSV is a set of DMA engines connected to the SENINF CSI-2
+  receivers. The number of CAMSVs depend on the SoC model.
+
+properties:
+  compatible:
+    const: mediatek,mt8365-camsv
+
+  reg:
+    items:
+      - description: camsv base
+      - description: img0 base
+      - description: tg base
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: cam clock
+      - description: camtg clock
+      - description: camsv clock
+
+  clock-names:
+    items:
+      - const: cam
+      - const: camtg
+      - const: camsv
+
+  iommus:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: connection point for camsv0
+
+    required:
+      - port@0
+
+required:
+  - compatible
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - iommus
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/mediatek,mt8365-clk.h>
+    #include <dt-bindings/memory/mediatek,mt8365-larb-port.h>
+    #include <dt-bindings/power/mediatek,mt8365-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        camsv1: camsv@15050000 {
+            compatible = "mediatek,mt8365-camsv";
+            reg = <0 0x15050000 0 0x0040>,
+                  <0 0x15050208 0 0x0020>,
+                  <0 0x15050400 0 0x0100>;
+            interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_LOW>;
+            clocks = <&camsys CLK_CAM>,
+                     <&camsys CLK_CAMTG>,
+                     <&camsys CLK_CAMSV0>;
+            clock-names = "cam", "camtg", "camsv";
+            iommus = <&iommu M4U_PORT_CAM_IMGO>;
+            power-domains = <&spm MT8365_POWER_DOMAIN_CAM>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+                    camsv1_endpoint: endpoint {
+                        remote-endpoint = <&seninf_camsv1_endpoint>;
+                    };
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 4444e719cf8e..3ea2158864e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13616,6 +13616,7 @@ M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 M:	Julien Stephan <jstephan@baylibre.com>
 M:	Andy Hsieh <andy.hsieh@mediatek.com>
 S:	Supported
+F:	Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
 F:	Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
 
 MEDIATEK SMI DRIVER
-- 
2.43.0


