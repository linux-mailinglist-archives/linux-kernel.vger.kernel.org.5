Return-Path: <linux-kernel+bounces-54813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13C784B401
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC58B24292
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0A13A88C;
	Tue,  6 Feb 2024 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="29QCsN8V"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD81369AA;
	Tue,  6 Feb 2024 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219253; cv=none; b=HJ04DqHEOaSw98TxFI94iHTw9wPDTZhR2wekt1aHzK5RsLKKKYxFfJ2VApUg5x7RGKSQoLxnmI+jcN256NDXvqwUNPL6/QUHctel+IXNsOIVHW8WYfStujm0e6KCAyAsX8mp9iPHp7KibaJPbvQyj6Cy1uBDuzPNoqcZYUcyoVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219253; c=relaxed/simple;
	bh=jmzuJBTpYHxye258ONgLzvf78sN3jD7lKR0LYeflsrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GTkQkGdA8FUP9V8UemqhHPIQR0/0xtyMPPr+a5ZWznbh6VU/7DJDjo02AGFqhR+4relc2cwGybJqkvzNytVoVMhzzsoB331wrVSvma16bFkO0FOF+8Ac+QH8C11i2D2tNmENSDZhpTF2X+iIZssQtSinzZOhGS2OlZSMpnXlAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=29QCsN8V; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4167NurZ009460;
	Tue, 6 Feb 2024 12:33:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=selector1; bh=1w+ndbM6GHzLyVcAYTae3/fhE8TsZIL47lZq/InxccQ
	=; b=29QCsN8Vsiuwe2nfRSrEXAgAWWgPEmj2nhXx7RW2G7EQKupY12hHnmeTa7O
	5ypOd+xxlrxOIIUxjXyafEGbqn8cFY82t4dMmKz5aZQ/V+sxfB0panj8yV0eEH60
	Y69crSRDy5TIOnxlq2FjlxUJhQ1Dyv91x99yOLcACB2aliEIJruZgqFistzHk84i
	ajyjEr13+RDwAxSvmAUlz34BvPNguVgXNkg/XJSI8h1mcZlakNcU6/Fb5AUKyBoa
	m4z4RshpHMw8rAainI8P5s34uKHDJZOlx/GFRRrBzAoDtnnRulYRCVfe4PPKwJ1i
	V6CErwLlMDEQMKJIuKiaIUBOiwg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w21ap0pmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 12:33:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C5B3A100056;
	Tue,  6 Feb 2024 12:33:19 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B277523C6B6;
	Tue,  6 Feb 2024 12:33:19 +0100 (CET)
Received: from localhost (10.129.178.155) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 6 Feb
 2024 12:33:19 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Tue, 6 Feb 2024 12:33:16 +0100
Subject: [PATCH v4 1/3] dt-bindings: display: add STM32 LVDS device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240206-lvds-v4-1-98d5f9af399d@foss.st.com>
References: <20240206-lvds-v4-0-98d5f9af399d@foss.st.com>
In-Reply-To: <20240206-lvds-v4-0-98d5f9af399d@foss.st.com>
To: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02

Add "st,stm32mp25-lvds" compatible.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
Depends on: "dt-bindings: stm32: add clocks and reset binding for
	    stm32mp25 platform" by Gabriel Fernandez

Changes in v4:
	- Align filename to compatible
	- Fix compatible in the example
	- Remove redundant word in the subject

Changes in v3:
	- Clarify commit dependency
	- Fix includes in the example
	- Fix YAML
	- Add "clock-cells" description
	- s/regroups/is composed of/
	- Changed compatible to show SoC specificity

Changes in v2:
	- Switch compatible and clock-cells related areas
	- Remove faulty #include in the example.
	- Add entry in MAINTAINERS
---
 .../bindings/display/st,stm32mp25-lvds.yaml        | 119 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 120 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
new file mode 100644
index 000000000000..6736f93256b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/st,stm32mp25-lvds.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/st,stm32mp25-lvds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 LVDS Display Interface Transmitter
+
+maintainers:
+  - Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
+  - Yannick Fertre <yannick.fertre@foss.st.com>
+
+description: |
+  The STMicroelectronics STM32 LVDS Display Interface Transmitter handles the
+  LVDS protocol: it maps the pixels received from the upstream Pixel-DMA (LTDC)
+  onto the LVDS PHY.
+
+  It is composed of three sub blocks:
+    - LVDS host: handles the LVDS protocol (FPD / OpenLDI) and maps its input
+      pixels onto the data lanes of the PHY
+    - LVDS PHY: parallelize the data and drives the LVDS data lanes
+    - LVDS wrapper: handles top-level settings
+
+  The LVDS controller driver supports the following high-level features:
+    - FDP-Link-I and OpenLDI (v0.95) protocols
+    - Single-Link or Dual-Link operation
+    - Single-Display or Double-Display (with the same content duplicated on both)
+    - Flexible Bit-Mapping, including JEIDA and VESA
+    - RGB888 or RGB666 output
+    - Synchronous design, with one input pixel per clock cycle
+
+properties:
+  compatible:
+    const: st,stm32mp25-lvds
+
+  "#clock-cells":
+    const: 0
+    description:
+      Provides the internal LVDS PHY clock to the framework.
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: APB peripheral clock
+      - description: Reference clock for the internal PLL
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: ref
+
+  resets:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          LVDS input port node, connected to the LTDC RGB output port.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          LVDS output port node, connected to a panel or bridge input port.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - "#clock-cells"
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
+    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
+
+    lvds: lvds@48060000 {
+        compatible = "st,stm32mp25-lvds";
+        reg = <0x48060000 0x2000>;
+        #clock-cells = <0>;
+        clocks = <&rcc CK_BUS_LVDS>, <&rcc CK_KER_LVDSPHY>;
+        clock-names = "pclk", "ref";
+        resets = <&rcc LVDS_R>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                lvds_in: endpoint {
+                   remote-endpoint = <&ltdc_ep1_out>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                lvds_out0: endpoint {
+                   remote-endpoint = <&lvds_panel_in>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 59b3da17debc..1736b243d7d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7231,6 +7231,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
+F:	Documentation/devicetree/bindings/display/st,stm32-lvds.yaml
 F:	drivers/gpu/drm/stm
 
 DRM DRIVERS FOR TI KEYSTONE

-- 
2.25.1


