Return-Path: <linux-kernel+bounces-18720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601B28261C4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 22:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877151C20F64
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 21:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A454BF9D3;
	Sat,  6 Jan 2024 21:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ael9U+qU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FEDF9C2;
	Sat,  6 Jan 2024 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7ba737ee9b5so66727439f.0;
        Sat, 06 Jan 2024 13:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704577912; x=1705182712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TjQrh5h1eahZONpR05p3w9rNE8So3C2WDYnYx2WcRS0=;
        b=ael9U+qUEGK6yUeGUm5Vz9g1922n7CEa7wkN2EznF1blbMPcB89/Gsb61EdKO8FHNF
         ufEq7Wnrw0B4+2MZaWyy4iL4KaSjp6fWGmwaNUGlw1Jlxbp4Noj1YVTgUcEUMByKcsct
         qWyR5RQEeCaYBIpOAUIAwOhl9ljvIAPySVeMg/vDrW5vumdCqpa/UOM6iexTxwzeY6AP
         zox4a95k4TyyjztM32mfr+He52yxYDtvBj5l0C79fWe+uS7y29KEgIvlJwxiFFIQXyPV
         eTGBgPtT3Fz06BDLc36dJdshYMDRm/y8Kbppo04BEx4mpVGS69467XBYZkHWadE17Oi3
         Ehhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704577912; x=1705182712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjQrh5h1eahZONpR05p3w9rNE8So3C2WDYnYx2WcRS0=;
        b=Os6+BEtNK7gaVIF4p08NEpWrG8JrjxyLNDI+MiFzJ/QAOrJBQH+noF6q3jgFfIX0G1
         JBG6hoBTuqSRGZtBAXGlPbb/6z57YG7BMZbn/qydON/Aws7v2mZktr6fZQIESfMvgqCU
         ufwWmwivav1Zqci7dv8cknXgzYShKkQsrhCJOpq+fmNfHYDD+RZLTNH/l5YO85zY64np
         arGE85d72wR/R53xJqmLyBLlRtbLpMsJh5CYn8opk/9htFi5wSWp7N/sHvjEDcr3Js9D
         B0m6CBvsFo/ZifsGfSyiT6pz/b2Lq0d85yd3LrkUEsBM8uaVd+hNJthPNh8+DZ06Nsel
         X4mQ==
X-Gm-Message-State: AOJu0Yxs3cjjR5Y3Uvajm86e1MNdQMzRuMmTKijkugjxdSLNEI4TvnQv
	heSdkYwQXuza5zL4hXDHGXU=
X-Google-Smtp-Source: AGHT+IGakRogLZjAWssqGnL0f0EpuAWiQoMP5dWkzx6jPvFAPrDve3HXtEzEkbVbG3bMAbQM9SmCDA==
X-Received: by 2002:a05:6602:1408:b0:7b7:cd4f:fa2 with SMTP id t8-20020a056602140800b007b7cd4f0fa2mr3127747iov.18.1704577912502;
        Sat, 06 Jan 2024 13:51:52 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:af2f:17f0:33a3:d6fe])
        by smtp.gmail.com with ESMTPSA id du4-20020a056638604400b0046dc6ede06dsm1347498jab.5.2024.01.06.13.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 13:51:52 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Adam Ford <aford173@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Liu Ying <victor.liu@nxp.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 1/2] dt-bindings: display: imx: add binding for i.MX8MP HDMI PVI
Date: Sat,  6 Jan 2024 15:51:44 -0600
Message-ID: <20240106215146.147922-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

Add binding for the i.MX8MP HDMI parallel video interface block.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V7:  No Change

V6:  Add s-o-b message for myself (Adam)

V5:  I tried to help move this along, so I took Lucas' patch and
     attempted to apply fixes based on feedback.  I don't have
     all the history, so apologies for that.
     Removed the pipe character from the Description.
     Increased the register size from 0x40 to 0x44.
diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.yaml
new file mode 100644
index 000000000000..3377f152f319
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/fsl,imx8mp-hdmi-pvi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8MP HDMI Parallel Video Interface
+
+maintainers:
+  - Lucas Stach <l.stach@pengutronix.de>
+
+description:
+  The HDMI parallel video interface is a timing and sync generator block in the
+  i.MX8MP SoC, that sits between the video source and the HDMI TX controller.
+
+properties:
+  compatible:
+    const: fsl,imx8mp-hdmi-pvi
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
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Input from the LCDIF controller.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Output to the HDMI TX controller.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - power-domains
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/imx8mp-power.h>
+
+    display-bridge@32fc4000 {
+        compatible = "fsl,imx8mp-hdmi-pvi";
+        reg = <0x32fc4000 0x44>;
+        interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_PVI>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                pvi_from_lcdif3: endpoint {
+                    remote-endpoint = <&lcdif3_to_pvi>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                pvi_to_hdmi_tx: endpoint {
+                    remote-endpoint = <&hdmi_tx_from_pvi>;
+                };
+            };
+        };
+    };
-- 
2.43.0


