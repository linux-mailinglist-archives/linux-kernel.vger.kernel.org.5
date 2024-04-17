Return-Path: <linux-kernel+bounces-147859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7803A8A7AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC0E2837FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7F86FBE;
	Wed, 17 Apr 2024 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CkPNGCqv"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D04567F;
	Wed, 17 Apr 2024 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321759; cv=none; b=uih2rVhkofR+enKKNTy/q/57+yMI2VYPv3po9pJR+D72lEd5JvmlRbJ0iUDTcitEQgaGuFmW+8Z+iVrJYM5yEhshFgMzGgd4i+UbtLrecvECdU6S5gcrX1SmtoYi7+x7SEghGhr8lSLuApaehNpv4JiGc0+CbFTDtAqBjz14R+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321759; c=relaxed/simple;
	bh=8yajIAMtfrnOR0YPhjzLw1ZaJc0hJ5ZYx12eiEu4sWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhvomwJb7gbKzVKkcogxJvNceCrspBJhnGl4xmROimPyNejkMIRxO3hMu3jH0XejRvcAysX5CIuM5fCufE6yalUnzPFaIB/za/XxF7bm2Z/Yk6ci+sZ/z8mnV960GtIShyyD3ghL/NJul76W61UlgCymzV9VwEhuiFwCE3XvITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CkPNGCqv; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713321758; x=1744857758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8yajIAMtfrnOR0YPhjzLw1ZaJc0hJ5ZYx12eiEu4sWU=;
  b=CkPNGCqvWmIWVhGBtfJdDD6uAUlz2o3hnRw0FkGtEB9dqZxk1sVSXJkf
   +rLDAgtF3LZoSi7KcdKsHs3wjxXkvE2zfcW+kyGIVB9dUyxahfYtz1dYu
   3XLOKkcfzuhkqKTz3TR7bQ3Ei8gov8uccygKOfsJFfEY9kcEcrj+YZwvx
   2fP2Z8FqGFfp1Aq30hNVcW4/vno4XOr1jxqCHZ1tijloDVHanPRbpWoLX
   5tl4MV4ve2nAOkH7nm0CfJ9JW6lEqnG/WH1tHnildOc4gOuQEGGFG/TH4
   Rns76r9cNWRMa5PwftUjTFhWbtFRmA3YBqq8jC9IkfVACjcFkgTMRRJhm
   g==;
X-CSE-ConnectionGUID: rOmQUjIYQSOnYHCy61jG5w==
X-CSE-MsgGUID: 3sG7qdeIQKmvyyvR8cJiww==
X-IronPort-AV: E=Sophos;i="6.07,207,1708412400"; 
   d="scan'208";a="21373548"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 19:42:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 19:42:20 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 19:42:09 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <Dharma.B@microchip.com>, <andrzej.hajda@intel.com>,
	<neil.armstrong@linaro.org>, <rfoss@kernel.org>,
	<Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <Manikandan.M@microchip.com>, <arnd@arndb.de>,
	<geert+renesas@glider.be>, <Jason@zx2c4.com>, <mpe@ellerman.id.au>,
	<gerg@linux-m68k.org>, <rdunlap@infradead.org>, <vbabka@suse.cz>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, Dharma Balasubiramani
	<dharma.b@microchip.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: display: bridge: add sam9x75-lvds binding
Date: Wed, 17 Apr 2024 08:11:34 +0530
Message-ID: <20240417024137.144727-2-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240417024137.144727-1-dharma.b@microchip.com>
References: <20240417024137.144727-1-dharma.b@microchip.com>
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
v5 -> v6
- No Changes.
v4 -> v5
- No changes.
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


