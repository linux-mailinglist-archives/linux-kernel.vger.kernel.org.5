Return-Path: <linux-kernel+bounces-32520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DFA835C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496421F21599
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A9538FA9;
	Mon, 22 Jan 2024 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ms03aeg4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EAC38386;
	Mon, 22 Jan 2024 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912217; cv=none; b=qgslJjqK6hX3o8s2doLF7av4QY/N9EnpRL0o9QHAgTCW2xGCms4xlwPE3GMlDE4nPQQSD0NarL9WjuoziRoIvJRyb127kTdDCx3zxkrpnUjnU2PSxrJl96lDZrRlNNis7b6PAzWKctY5DVc0YsDkFqRTrb9z8C4vO2UnNyOEZek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912217; c=relaxed/simple;
	bh=Rf5MI82lZHhYGSDhwKtyN1xGV0ZqSdRkhIta/II4uNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVE72F1WWVp+kbfJEowWWEOPGTlHYQVr/iNl+paKNGHqkl1ObgXiSDMT6/zOYeMZ2dMgPajVun3wVJ6vi4xLBt8fJUEWwNMl9LoDHVXXIf2BnxlYzqRsqDp+FluAgfY69iKyl+FMH/Cr9ZObrlls2Tz7CFVTc7iLTPiHv+/F9fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ms03aeg4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705912215; x=1737448215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rf5MI82lZHhYGSDhwKtyN1xGV0ZqSdRkhIta/II4uNE=;
  b=Ms03aeg47J/n5pf0XBWeuT9dbvr5sf3ru0WJHdAIPi3LZW+WFEF8oiBX
   DG45oUCKc2rODgCKrrt7Z+Yn+85Y4ArPt0NZRwvjpdLBv0UP+rjRBMuwZ
   ETOJxRkk2AQP2vAfmM2NwDKJe7FydCBiNKxUSy0iysnbrCG17ytMrBkmm
   9CqAB3j3DjdM7w7rIzlnxRf2FtvnJ0QhljBIOOgbp1/eTFR4FPVTXgfYi
   zd1lHXP7WUmki4Qn9QioWiCOMklu3n/yX6l94779D6xOrnXBkV5DthlQl
   c2IomLIDC9HG7x6dOzvNjjK+mJioQNwcd4YmNXKJBrvb2/RNipXFLcqHl
   w==;
X-CSE-ConnectionGUID: C6zQ2Iq3QDa7pYOudyjy+g==
X-CSE-MsgGUID: iDsarLzDRj6WJ7QX1eoRtg==
X-IronPort-AV: E=Sophos;i="6.05,211,1701154800"; 
   d="scan'208";a="15086355"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2024 01:30:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 01:30:04 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 01:29:57 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <manikandan.m@microchip.com>, <dharma.b@microchip.com>,
	<andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
	<Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux4microchip@microchip.com>
Subject: [PATCH 1/3] dt-bindings: display: bridge: add sam9x7-lvds compatible
Date: Mon, 22 Jan 2024 13:59:45 +0530
Message-ID: <20240122082947.21645-2-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122082947.21645-1-dharma.b@microchip.com>
References: <20240122082947.21645-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the 'sam9x7-lvds' compatible binding, which describes the
Low Voltage Differential Signaling (LVDS) Controller found on Microchip's
sam9x7 series System-on-Chip (SoC) devices. This binding will be used to
define the properties and configuration for the LVDS Controller in DT.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 .../display/bridge/microchip,sam9x7-lvds.yaml | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
new file mode 100644
index 000000000000..8c2c5b858c85
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x7-lvds.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/microchip,sam9x7-lvds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip SAM9X7 LVDS Controller
+
+maintainers:
+  - Dharma Balasubiramani <dharma.b@microchip.com>
+
+description: |
+  The Low Voltage Differential Signaling Controller (LVDSC) manages data
+  format conversion from the LCD Controller internal DPI bus to OpenLDI
+  LVDS output signals. LVDSC functions include bit mapping, balanced mode
+  management, and serializer.
+
+properties:
+  compatible:
+    const: microchip,sam9x7-lvds
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral Bus Clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+    minItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    lvds-controller@f8060000 {
+      compatible = "microchip,sam9x7-lvds";
+      reg = <0xf8060000 0x100>;
+      interrupts = <56 IRQ_TYPE_LEVEL_HIGH 0>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 56>;
+      clock-names = "pclk";
+    };
-- 
2.25.1


