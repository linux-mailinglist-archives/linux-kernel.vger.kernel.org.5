Return-Path: <linux-kernel+bounces-23372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2298182ABBB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB651F25B15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E961428F;
	Thu, 11 Jan 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NBC6kGru"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4641426C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e60958d7aso1717375e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704968118; x=1705572918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/hW0eMP0R26bZoJ7D3kVMQU+mn9+CNKwNbl/G0tADY=;
        b=NBC6kGruUa/6zDhKGA/sXEndfnYfo0/ccg+uT6QghwJWhyNendqEI3Yt5G/Sr48NEy
         fvYUJ59JRSYEKjwk5JhMiq5JR40j+xN08ouj+D/vQUE+VYIENgY8gcw8TrHps2gsOyVQ
         HKOWJydrjLQNoPCFhsqP+7BvSTtLQBbbLfEHBcIbhXsmZbDT4lZWdNs2vghBKTy9024/
         PTcT/AIRWoz+SuHSKR1+RPKrFWDctrEyBdXm71FgZ0mYlXWmhtFN+UgCW4ClRroDAoHa
         kIGB05PsZ1t0Sn0WRNKUOPs2NxYl1anCQ/nOKuv2p7SM1v8xFR5bHrbCFiLlEgQJI6+9
         ELPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704968118; x=1705572918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/hW0eMP0R26bZoJ7D3kVMQU+mn9+CNKwNbl/G0tADY=;
        b=DVFJbBRkcVsbjg3yd1bMin6DyiunTZV0hJ3VmFfywBaTEfKVGKDD+kAiCCAAaDqePZ
         NNuPx94OAVkPMYlYddStqc/R4WZFAl5YReiwfows+wThoyD42jG2AFZFnXNInzMKeNCO
         tJVQci4q0dcZlIgMZo/rPSzkl2wpBv8b1dL3u8kvRjT3eFrj/HUfcdAxzUTYZkOknpF9
         cdEZbWGvmEFSYS1/UCgixooPT7BKG2E//sE1D6qwjasSmNkJAFy7XkR8Bd5lJB7JH3e/
         F2uhTgqIg+umYirV3/NGIlGaRZbQXyMEiDy9+43pF9eul7+GkJdCfABIQAK/NOuCT3F2
         rcQA==
X-Gm-Message-State: AOJu0Yy+Socl9C6RrctVAAPSuqdnWucznHeir/g5DbNV3ZRxdNhVPI9I
	k2AIKhrvICD1/72nMlQEhKRk4vvZ0Z8siw==
X-Google-Smtp-Source: AGHT+IFyvfnJPRwTsXpGb2dr4GW0LFIBK0jrx5pf/pI5bprzOQBwjVWroWaZz6UXvbjD6JidFSNScQ==
X-Received: by 2002:a05:600c:3ba0:b0:40e:5b66:f4d9 with SMTP id n32-20020a05600c3ba000b0040e5b66f4d9mr300477wms.79.1704968112988;
        Thu, 11 Jan 2024 02:15:12 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040e52cac976sm5157758wmq.29.2024.01.11.02.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:15:12 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
To: 
Cc: Florian Sylvestre <fsylvestre@baylibre.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Andy Hsieh <andy.hsieh@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: phy: add mediatek MIPI CD-PHY module v0.5
Date: Thu, 11 Jan 2024 11:14:50 +0100
Message-ID: <20240111101504.468169-2-jstephan@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111101504.468169-1-jstephan@baylibre.com>
References: <20240111101504.468169-1-jstephan@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Sylvestre <fsylvestre@baylibre.com>

This adds the bindings, for the MIPI CD-PHY module v0.5 embedded in
some Mediatek soc, such as the mt8365

Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/mediatek,mt8365-csi-rx.yaml  | 79 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
new file mode 100644
index 000000000000..2127a5732f73
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2023 MediaTek, BayLibre
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mediatek,mt8365-csi-rx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Sensor Interface MIPI CSI CD-PHY
+
+maintainers:
+  - Julien Stephan <jstephan@baylibre.com>
+  - Andy Hsieh <andy.hsieh@mediatek.com>
+
+description:
+  The SENINF CD-PHY is a set of CD-PHY connected to the SENINF CSI-2
+  receivers. The number of PHYs depends on the SoC model.
+  Depending on the SoC model, each PHYs can be either CD-PHY or D-PHY only
+  capable.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8365-csi-rx
+
+  reg:
+    maxItems: 1
+
+  num-lanes:
+    enum: [2, 3, 4]
+
+  '#phy-cells':
+    enum: [0, 1]
+    description: |
+      If the PHY doesn't support mode selection then #phy-cells must be 0 and
+      PHY mode is described using phy-type property.
+      If the PHY supports mode selection, then #phy-cells must be 1 and mode
+      is set in the PHY cells. Supported modes are:
+        - PHY_TYPE_DPHY
+        - PHY_TYPE_CPHY
+      See include/dt-bindings/phy/phy.h for constants.
+
+  phy-type:
+    description:
+      If the PHY doesn't support mode selection then this set the operating mode.
+      See include/dt-bindings/phy/phy.h for constants.
+    const: 10
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - num-lanes
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/phy/phy.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      csi0_rx: phy@11c10000 {
+        compatible = "mediatek,mt8365-csi-rx";
+        reg = <0 0x11c10000 0 0x2000>;
+        num-lanes = <2>;
+        #phy-cells = <1>;
+      };
+
+      csi1_rx: phy@11c12000 {
+        compatible = "mediatek,mt8365-csi-rx";
+        reg = <0 0x11c12000 0 0x2000>;
+        phy-type = <PHY_TYPE_DPHY>;
+        num-lanes = <2>;
+        #phy-cells = <0>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index cc92b10a4cad..37dfa99b0eb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13569,6 +13569,12 @@ F:	Documentation/devicetree/bindings/media/mediatek-vpu.txt
 F:	drivers/media/platform/mediatek/vcodec/
 F:	drivers/media/platform/mediatek/vpu/
 
+MEDIATEK MIPI-CSI CDPHY DRIVER
+M:	Julien Stephan <jstephan@baylibre.com>
+M:	Andy Hsieh <andy.hsieh@mediatek.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
+
 MEDIATEK MMC/SD/SDIO DRIVER
 M:	Chaotian Jing <chaotian.jing@mediatek.com>
 S:	Maintained
-- 
2.43.0


