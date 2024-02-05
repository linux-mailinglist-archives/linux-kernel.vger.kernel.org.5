Return-Path: <linux-kernel+bounces-52461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5071784987E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7CACB28DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EA21B7F2;
	Mon,  5 Feb 2024 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iCkTrKDG"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF9B1B7F9;
	Mon,  5 Feb 2024 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131286; cv=none; b=eW5CbzrrEHGcZbIBuFPoyiH+YmasDTQwwkSSzmA+Gt0/nlI7A5stqCxA5dMGgI8qIK7sg6Fu48GtrLxdH5WFBMZOks+X0vU5AjCa12JaGHWT0esP8QqEOiNdkIYYBpAAJ4z/Gnj6ttMHKpxWf+NIARcAxOCvoF5jXFPsUZu8aHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131286; c=relaxed/simple;
	bh=7mWEWnxAauLCFNk47f49pAB6QNSuMAx+Qk1dfenkHL8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4clzdN2VcGA9xfKXD4jc+O7YsXkQHpmp6Ef9flD+UZijuF/d/FWqVa6UYqlbS2Iw3RSRdKHTTgyhqr2mPCQaiiZafdPyoHW7Hx7lp6NBGsMImu7dHfgQdsRq1OYYFJ0IccUb2d4nxIAl+4UKFYAOzFE3H/hY6gBZ03NnnNtnlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iCkTrKDG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707131284; x=1738667284;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=7mWEWnxAauLCFNk47f49pAB6QNSuMAx+Qk1dfenkHL8=;
  b=iCkTrKDGJ29LmHya9ZXTMcVdTE0mM0H4Ske/qWym2FgsSDR/M/xj8pKx
   8IjNbKGZmi+UrNvKHluwjR54kfSid+CmDTpHDGFGFVzsf6mVh4IT5Mmge
   bTZ6EwHwCF+9WfUdhPjmR8VdQTp5GfkfnfuPk19bDAforO/j6gyc+bAxv
   HVvjG3mx2ST2LtZ5ZynfjkP38JUk1C2DzdIcMYI+MZnvZ2R02t6oIK4vd
   b6kskxTkqXW9PyOtRpiOcIZwClFDjucqKulgHBmlR3LLxoHuuFLwpJsyp
   iWBtUrUJG/x7UvveoYHBWrRie16aJz2FEDSwxq2LIT3/kqkLS8kZD1kFJ
   A==;
X-CSE-ConnectionGUID: tvnljXD9ScO2Biw+t+1Jqg==
X-CSE-MsgGUID: uOaGY4zKTEaXsI2/T8fQgg==
X-IronPort-AV: E=Sophos;i="6.05,245,1701154800"; 
   d="scan'208";a="17124179"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 04:07:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 04:06:35 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 04:06:24 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <dharma.b@microchip.com>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <geert+renesas@glider.be>, <arnd@arndb.de>,
	<hari.prasathge@microchip.com>, <Jason@zx2c4.com>, <rientjes@google.com>,
	<rdunlap@infradead.org>, <vbabka@suse.cz>, <manikandan.m@microchip.com>
Subject: [linux][PATCH v2 1/4] dt-bindings: display: bridge: add sam9x75-lvds compatible
Date: Mon, 5 Feb 2024 16:36:06 +0530
Message-ID: <20240205110609.217022-2-dharma.b@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205110609.217022-1-dharma.b@microchip.com>
References: <20240205110609.217022-1-dharma.b@microchip.com>
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
---
Changelog
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


