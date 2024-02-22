Return-Path: <linux-kernel+bounces-76892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC3085FE44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA828B28245
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF967153BCA;
	Thu, 22 Feb 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jO2vW6mg"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4D1534F5;
	Thu, 22 Feb 2024 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620161; cv=none; b=O7rpBk+Oiugxr+oiAnXEDdejslCX+4CXwfhefGy2/tQEXchx6jCbk0yAR/agNILyexSYgot1Q79ZFFXi+FKoq5Vqwy6/1PWQV9GLAHl13IPzvZbvN1eHXM01vWj5BJGRuyTSx5jj9aUEI77UgPpOYDKT4yROA3OYoLrPCKkvDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620161; c=relaxed/simple;
	bh=JiyMeQ4zLEjBU6MJmXNxDjwaVSeLnLIjl5e47ySMs2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0xQlBKO2E4902ibO2Xg4iMUnO9yLkiml/7lyyEyhybLt7apvXBMq/4CnvZN5ZZ0CmpvOvWAE0KD9Dd0NurVjNPeFgoXIpJVQ1WHPEJGoxZQqvwUyw/6hxn8FBVeyIPC8ASVl+gXHIDe9vRu179xPbsddZeniC25iDvKP55jE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jO2vW6mg; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708620159; x=1740156159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JiyMeQ4zLEjBU6MJmXNxDjwaVSeLnLIjl5e47ySMs2Y=;
  b=jO2vW6mgjSYVHtF6oSVHMoJE0rnSa4bTay/STEP+k3wu+XTPBxygRd9V
   aR8xeoBLa3/MtsEEOKoaVcTQz4/JzJOK9vRFZihTC3msyxmifemrLdWbQ
   bVavZjo8rlsNiaRbeAgjFLr3jXJ1sWkLVgVhyFp01UyFlLwFZW8CT2Y7S
   nkWHcaXd/fvPREYe4zifYbr8+XzZSGwoXu49qlae7Pr5BQwO0jQboCOJJ
   4Fm2OT/qF6qxxl4pSgQEDiId3M1IWN0tFbab4+Ry3MUOKQqulN4N3P/bD
   oa7PIKOsoqYmJZ49eTHJVPQl3Tlr4XD8mqkJI9JHfp40q/+CeoNh7hcU/
   Q==;
X-CSE-ConnectionGUID: WIlLG2AjSwCpN2W80dryxA==
X-CSE-MsgGUID: 0Iq3Xyz7Ta++c4VkQ+G2IQ==
X-IronPort-AV: E=Sophos;i="6.06,179,1705388400"; 
   d="scan'208";a="247417429"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2024 09:42:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 09:42:34 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 22 Feb 2024 09:42:31 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
	<jdelvare@suse.com>, <linux@roeck-us.net>, <linux-hwmon@vger.kernel.org>
CC: <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: adding support for PAC193X
Date: Thu, 22 Feb 2024 18:42:05 +0200
Message-ID: <20240222164206.65700-2-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222164206.65700-1-marius.cristea@microchip.com>
References: <20240222164206.65700-1-marius.cristea@microchip.com>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iio/adc/microchip,pac1934.yaml   | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
new file mode 100644
index 000000000000..52be5ada1eb6
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
+    description:
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
+    description:
+        Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        items:
+          minimum: 1
+          maximum: 4
+
+      shunt-resistor-micro-ohms:
+        description:
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
+        power-monitor@10 {
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


