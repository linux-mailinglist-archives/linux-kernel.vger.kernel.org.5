Return-Path: <linux-kernel+bounces-59511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486DB84F835
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F0C2888B5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3BA6DD1E;
	Fri,  9 Feb 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DXyJXkFn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19496D1CB;
	Fri,  9 Feb 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707491336; cv=none; b=YPQobm2WQD95zVsvyJyaw21EQcyzg9CB1ZM+vM6DbP23hdx/o5Qn43HHsuUq3zz4musutwbWJsbF+6hEIlG2pEo6DhZ6WBzvGsTBoXKukloHcErJGS++fdpi2Li0JMKXHSQkdOv9f5FAmCJ+UqU/B8Ce5s7CzjdlctRPJHctgRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707491336; c=relaxed/simple;
	bh=mn0xWgi/6UQLUMoJ5s/lxkh6G+bbnSgewb4JFdRi4Ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ef6JMRFKX/q4vz43DHAzIHt9eYA4ZrKIqmCgja4YnO9SvVlUfm6Pt6so3XGVCKNmbMVDgF9lW75LlCKvZrT1kp42rTbHyO42MlBonLu0rN5rk4AhiYVI9dFwaMMHstqHFc4mHeGpwSNu31BrYKUgaLYB5hFFNrkHOL/ca65iXiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DXyJXkFn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707491334; x=1739027334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mn0xWgi/6UQLUMoJ5s/lxkh6G+bbnSgewb4JFdRi4Ec=;
  b=DXyJXkFn1N0nkE8RQSLBrOxuVjEn6aIzS4/qwRIqTMuAnKcgAIG2/lOP
   6/hhHCmSv5tC9HIATevznMKXM1GGmYFO2iDRRiLkxU0xtX8vUQPNh6pO7
   GnF7suYCzSGmKoClMCRZHAn/DoCRudRV3YQvOZpTZUvyMXCi4MKExyK3b
   4jQQoNK2Kgo60yxx6OUiz5iluDrtdUsYcMl0NJ5ycd6AYdgDOGNRMEfdc
   mq02UvS8GVXZ8XC9kqIJ3LXXNDSZo5m3JMPn6UO6SxODLo6fp4PMFMABd
   svin/0GKyGaA0D9AQnGOShQHbuimNeN7b4P5Su/b9n8mYGz2exp2+VadV
   A==;
X-CSE-ConnectionGUID: mfk2QRC8TEy2GEu9hHFtmA==
X-CSE-MsgGUID: cTinoXJuRiu/M5E1R7jgSQ==
X-IronPort-AV: E=Sophos;i="6.05,257,1701154800"; 
   d="scan'208";a="16538527"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Feb 2024 08:08:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 08:08:25 -0700
Received: from che-lt-i70843lx.amer.actel.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 08:08:12 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <manikandan.m@microchip.com>,
	<dharma.b@microchip.com>, <arnd@arndb.de>, <geert+renesas@glider.be>,
	<Jason@zx2c4.com>, <mpe@ellerman.id.au>, <gerg@linux-m68k.org>,
	<rdunlap@infradead.org>, <vbabka@suse.cz>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <hari.prasathge@microchip.com>,
	<akpm@linux-foundation.org>, <deller@gmx.de>
CC: Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: display: bridge: add sam9x75-lvds binding
Date: Fri, 9 Feb 2024 20:37:54 +0530
Message-ID: <20240209150757.66914-2-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209150757.66914-1-dharma.b@microchip.com>
References: <20240209150757.66914-1-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the 'sam9x75-lvds' compatible binding, which describes the Low Voltage
Differential Signaling (LVDS) Controller found on some Microchip's sam9x7
series System-on-Chip (SoC) devices. This binding will be used to define
the properties and configuration for the LVDS Controller in DT.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changelog
v3 -> v4
- Rephrase the commit subject.
v2 -> v3
- No changes.
v1 -> v2
- Remove '|' in description, as there is no formatting to preserve.
- Remove 'gclk' from clock-names as there is only one clock(pclk).
- Remove the unused headers and include only used ones.
- Change the compatible name specific to SoC (sam9x75) instead of entire series.
- Change file name to match the compatible name.
---
 .../bridge/microchip,sam9x75-lvds.yaml        | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-lvds.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-lvds.yaml b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-lvds.yaml
new file mode 100644
index 000000000000..862ef441ac9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-lvds.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/microchip,sam9x75-lvds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip SAM9X75 LVDS Controller
+
+maintainers:
+  - Dharma Balasubiramani <dharma.b@microchip.com>
+
+description:
+  The Low Voltage Differential Signaling Controller (LVDSC) manages data
+  format conversion from the LCD Controller internal DPI bus to OpenLDI
+  LVDS output signals. LVDSC functions include bit mapping, balanced mode
+  management, and serializer.
+
+properties:
+  compatible:
+    const: microchip,sam9x75-lvds
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/at91.h>
+    lvds-controller@f8060000 {
+      compatible = "microchip,sam9x75-lvds";
+      reg = <0xf8060000 0x100>;
+      interrupts = <56 IRQ_TYPE_LEVEL_HIGH 0>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 56>;
+      clock-names = "pclk";
+    };
-- 
2.25.1


