Return-Path: <linux-kernel+bounces-32564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01755835D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866B31F2115E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161C23BB43;
	Mon, 22 Jan 2024 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="syBhrkg8"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F80239FCE;
	Mon, 22 Jan 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913282; cv=none; b=JH5Gl4v433zgy67PPPLy/f6nmn5E0dIenKdKu0YlMzDKNG8XE7pxQB99Hm2yXQ5EvVWDENwJ1/mYrfXBx+GoTgOdirtm3MDtiqejEFpz/5LINkPEQEYHhWAR73w//6Ks69n7hQVr5Pv6wQt9cv1ow8RfXBWeVUN5LeUnteifHJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913282; c=relaxed/simple;
	bh=sFF0XyltPyKzQq4OrzysU1aw8d82Vo4XKjC4WvPESsM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kO8J/te2tLbU7VPhRg2kitkrUrjQIIRg6przdA5d512XvrwD52oI8o+Cqni35IoJxTzjWKrn3opwc4kTOXEA++APB7+JpUBjQoDrWd8uflFC+1p7O3pEf6XcA0XOnad4KptvLRqMVpHRzqFvsdM3GVlFmu4DISYU9NlTCcvFn0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=syBhrkg8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705913280; x=1737449280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sFF0XyltPyKzQq4OrzysU1aw8d82Vo4XKjC4WvPESsM=;
  b=syBhrkg80yYViGAJR7vlVoOkZ2SeLd1YsxBYbPZjgI8Whxd3ewiIg8CE
   jIZ+yBS4V1fdq3hQjB2oBYGCNgLaclt5CPgnxt4dZx8NIPNNcn8iPWIn3
   PX7PQboPWOHc8kbpW1ShTIDSXNETFBdlnSrVTIuQYLEBLbyon7OaWZeGx
   ewJTORuCDt+F7bgZC3NuH/UJJgwROHZlR0uwWIAlBMcBxVGh3jVb7GGGY
   JwzDK+ktLN32tZE4prdI/4XONvyNZZZXAd5ItvLSoZlhDFaOFBMHv4DTd
   CcRjPcwb/nHjhFWMRppuZRYYqIlTQDDnyqJeE+kvxRVvqL/B6qxr3x4bU
   g==;
X-CSE-ConnectionGUID: urVykdzqSkuqk7i3uo9dbg==
X-CSE-MsgGUID: UboQHsKQQJahTOqj7mSERA==
X-IronPort-AV: E=Sophos;i="6.05,211,1701154800"; 
   d="scan'208";a="15087186"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2024 01:47:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 01:47:23 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 22 Jan 2024 01:47:20 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>
CC: <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: adding support for PAC193X
Date: Mon, 22 Jan 2024 10:47:11 +0200
Message-ID: <20240122084712.11507-2-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122084712.11507-1-marius.cristea@microchip.com>
References: <20240122084712.11507-1-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

This is the device tree schema for iio driver for
Microchip PAC193X series of Power Monitors with Accumulator.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../bindings/iio/adc/microchip,pac1934.yaml   | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
new file mode 100644
index 000000000000..cd9cb2a71566
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,pac1934.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PAC1934 Power Monitors with Accumulator
+
+maintainers:
+  - Marius Cristea <marius.cristea@microchip.com>
+
+description: |
+  This device is part of the Microchip family of Power Monitors with
+  Accumulator.
+  The datasheet for PAC1931, PAC1932, PAC1933 and PAC1934 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/PAC1931-Family-Data-Sheet-DS20005850E.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,pac1931
+      - microchip,pac1932
+      - microchip,pac1933
+      - microchip,pac1934
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  interrupts:
+    maxItems: 1
+
+  slow-io-gpios:
+    description: |
+      A GPIO used to trigger a change is sampling rate (lowering the chip power
+      consumption). If configured in SLOW mode, if this pin is forced high,
+      sampling rate is forced to eight samples/second. When it is forced low,
+      the sampling rate is 1024 samples/second unless a different sample rate
+      has been programmed.
+
+patternProperties:
+  "^channel@[1-4]+$":
+    type: object
+    $ref: adc.yaml
+    description: |
+        Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        items:
+          minimum: 1
+          maximum: 4
+
+      shunt-resistor-micro-ohms:
+        description: |
+          Value in micro Ohms of the shunt resistor connected between
+          the SENSE+ and SENSE- inputs, across which the current is measured.
+          Value is needed to compute the scaling of the measured current.
+
+    required:
+      - reg
+      - shunt-resistor-micro-ohms
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pac193x: power-monitor@10 {
+            compatible = "microchip,pac1934";
+            reg = <0x10>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@1 {
+                reg = <0x1>;
+                shunt-resistor-micro-ohms = <24900000>;
+                label = "CPU";
+            };
+
+            channel@2 {
+                reg = <0x2>;
+                shunt-resistor-micro-ohms = <49900000>;
+                label = "GPU";
+            };
+
+            channel@3 {
+                reg = <0x3>;
+                shunt-resistor-micro-ohms = <75000000>;
+                label = "MEM";
+                bipolar;
+            };
+
+            channel@4 {
+                reg = <0x4>;
+                shunt-resistor-micro-ohms = <100000000>;
+                label = "NET";
+                bipolar;
+            };
+        };
+    };
+
+...
-- 
2.34.1


