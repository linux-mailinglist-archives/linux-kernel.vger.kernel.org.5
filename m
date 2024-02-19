Return-Path: <linux-kernel+bounces-72051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42E085AE49
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25BBDB2166B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BB754FA7;
	Mon, 19 Feb 2024 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="cd/vqplH"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B27B54FB3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708381113; cv=none; b=M8tOH9RvWKNlU6B9+9eUlSWPfWDSzozhXCLD7qAEOhC9FJv8LypKXpDfHI3RV/u3lHt5rTNdVKIOfl4/avLRq8i3VcFe66hKD5cz07wl9SHnP+jqVjosuBd5JW2USUiVlBsY9rl3iG9ETDAKSXFQ86gqmLPjxEXukhXNhK1LITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708381113; c=relaxed/simple;
	bh=3KLuTROTcuIG8ts2TGB7kpawKU3BuHsxiX3BpUeVXPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCzfIFTCzGnHhZbbKcVLQQcIg/tJ3VgkXsDhSagaygzak7wpsWL54VmAYKyou8iTjlGiOJ8VPicZlwJ0ESmiw6lkIOlHVl0RqLjC01reRSikOOQzpGj9YLyFWrpptJAJGFdf68THVx6UJQuok7F39v92pV844BSQ6xQqwYBGfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=cd/vqplH; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D8BF72C03CF;
	Tue, 20 Feb 2024 11:18:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708381108;
	bh=oyWkRtqqsv+aKaLBRLeW55YBTClyGJKuCBoRSiD+nCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cd/vqplHdk3I+7F+YSv2d9a1tRYD7GiPMPg1bYsD6PBppdzVVC4ESI9SBhyaVZb50
	 lCTLxk+UEa23yL97YoQhKO/9RNv5KKUY9mBCSTh7RppHIlMg+4a7J8kIETY8BmJGHy
	 +OGZmeL+VyRdqoUhWKzuG9QLPq0uxc6yY0uUYEAoy8L4++EvfBDNxryunLTKWWtpDs
	 wZ+Ep4LFsE3cwxOjk/vUQpT3oHZIiW2tBoMqHR5OmFmXKENzWA/8rzyS2TVzZHaIhM
	 pgV2LZ5AvrmTS6+feseG/LyxaYdhKU8SltwuIvK/8XtXrPnjpMTXp/FgRcwVPEAJtD
	 a6loSDeew1hlw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65d3d3b40002>; Tue, 20 Feb 2024 11:18:28 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 92FB213EE85;
	Tue, 20 Feb 2024 11:18:28 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 8BFF2280ADF; Tue, 20 Feb 2024 11:18:28 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: antoniu.miclaus@analog.com,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v7 2/2] dt-bindings: rtc: add max313xx RTCs
Date: Tue, 20 Feb 2024 11:18:24 +1300
Message-ID: <20240219221827.3821415-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219221827.3821415-1-chris.packham@alliedtelesis.co.nz>
References: <20240219221827.3821415-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65d3d3b4 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=gAnH3GRIAAAA:8 a=gEfo2CItAAAA:8 a=2mgWcbLM5WXxDnXTRRQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=oVHKYsEdi7-vN-J5QA_j:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

From: Ibrahim Tilki <Ibrahim.Tilki@analog.com>

Add devicetree binding documentation for Analog Devices MAX313XX RTCs.
This combines the new models with the existing max31335 binding.

Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/rtc/adi,max31335.yaml |  70 --------
 .../devicetree/bindings/rtc/adi,max313xx.yaml | 167 ++++++++++++++++++
 2 files changed, 167 insertions(+), 70 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/adi,max31335.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.ya=
ml

diff --git a/Documentation/devicetree/bindings/rtc/adi,max31335.yaml b/Do=
cumentation/devicetree/bindings/rtc/adi,max31335.yaml
deleted file mode 100644
index 0125cf6727cc..000000000000
--- a/Documentation/devicetree/bindings/rtc/adi,max31335.yaml
+++ /dev/null
@@ -1,70 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/rtc/adi,max31335.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Analog Devices MAX31335 RTC
-
-maintainers:
-  - Antoniu Miclaus <antoniu.miclaus@analog.com>
-
-description:
-  Analog Devices MAX31335 I2C RTC =C2=B12ppm Automotive Real-Time Clock =
with
-  Integrated MEMS Resonator.
-
-allOf:
-  - $ref: rtc.yaml#
-
-properties:
-  compatible:
-    const: adi,max31335
-
-  reg:
-    maxItems: 1
-
-  interrupts:
-    maxItems: 1
-
-  "#clock-cells":
-    description:
-      RTC can be used as a clock source through its clock output pin.
-    const: 0
-
-  adi,tc-diode:
-    description:
-      Select the diode configuration for the trickle charger.
-      schottky - Schottky diode in series.
-      standard+schottky - standard diode + Schottky diode in series.
-    enum: [schottky, standard+schottky]
-
-  trickle-resistor-ohms:
-    description:
-      Selected resistor for trickle charger. Should be specified if tric=
kle
-      charger should be enabled.
-    enum: [3000, 6000, 11000]
-
-required:
-  - compatible
-  - reg
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/irq.h>
-    i2c {
-        #address-cells =3D <1>;
-        #size-cells =3D <0>;
-
-        rtc@68 {
-            compatible =3D "adi,max31335";
-            reg =3D <0x68>;
-            pinctrl-0 =3D <&rtc_nint_pins>;
-            interrupts-extended =3D <&gpio1 16 IRQ_TYPE_LEVEL_HIGH>;
-            aux-voltage-chargeable =3D <1>;
-            trickle-resistor-ohms =3D <6000>;
-            adi,tc-diode =3D "schottky";
-        };
-    };
-...
diff --git a/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml b/Do=
cumentation/devicetree/bindings/rtc/adi,max313xx.yaml
new file mode 100644
index 000000000000..e56e5394aa86
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
@@ -0,0 +1,167 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright 2022 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/adi,max313xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX313XX series I2C RTCs
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+description: Analog Devices MAX313XX series I2C RTCs.
+
+properties:
+  compatible:
+    enum:
+      - adi,max31328
+      - adi,max31329
+      - adi,max31331
+      - adi,max31334
+      - adi,max31335
+      - adi,max31341
+      - adi,max31342
+      - adi,max31343
+
+  reg:
+    description: I2C address of the RTC
+    items:
+      - enum: [0x68, 0x69]
+
+  interrupts:
+    description:
+      Alarm1 interrupt line of the RTC. Some of the RTCs have two interr=
upt
+      lines and alarm1 interrupt muxing depends on the clockin/clockout
+      configuration.
+    maxItems: 1
+
+  "#clock-cells":
+    description:
+      RTC can be used as a clock source through its clock output pin whe=
n
+      supplied.
+    const: 0
+
+  clocks:
+    description:
+      RTC uses this clock for clock input when supplied. Clock has to pr=
ovide
+      one of these four frequencies - 1Hz, 50Hz, 60Hz or 32.768kHz.
+    maxItems: 1
+
+  adi,tc-diode:
+    description:
+      Select the diode configuration for the trickle charger.
+      schottky - Schottky diode in series.
+      standard+schottky - standard diode + Schottky diode in series.
+    enum: [schottky, standard+schottky]
+
+  trickle-resistor-ohms:
+    description:
+      Selected resistor for trickle charger. Should be specified if tric=
kle
+      charger should be enabled.
+    enum: [3000, 6000, 11000]
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: rtc.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,max31328
+              - adi,max31342
+
+    then:
+      properties:
+        aux-voltage-chargeable: false
+        trickle-resistor-ohms: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,max31328
+              - adi,max31331
+              - adi,max31334
+              - adi,max31335
+              - adi,max31343
+
+    then:
+      properties:
+        clocks: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,max31341
+              - adi,max31342
+
+    then:
+      properties:
+        reg:
+          items:
+            - const: 0x69
+
+    else:
+      properties:
+        reg:
+          items:
+            - const: 0x68
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        rtc@68 {
+            reg =3D <0x68>;
+            compatible =3D "adi,max31329";
+            clocks =3D <&clkin>;
+            interrupt-parent =3D <&gpio>;
+            interrupts =3D <26 IRQ_TYPE_EDGE_FALLING>;
+            aux-voltage-chargeable =3D <1>;
+            trickle-resistor-ohms =3D <6000>;
+            adi,tc-diode =3D "schottky";
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        rtc@68 {
+            compatible =3D "adi,max31335";
+            reg =3D <0x68>;
+            pinctrl-0 =3D <&rtc_nint_pins>;
+            interrupts-extended =3D <&gpio1 16 IRQ_TYPE_LEVEL_HIGH>;
+            aux-voltage-chargeable =3D <1>;
+            trickle-resistor-ohms =3D <6000>;
+            adi,tc-diode =3D "schottky";
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        rtc@68 {
+            reg =3D <0x68>;
+            compatible =3D "adi,max31331";
+            #clock-cells =3D <0>;
+        };
+    };
+...
--=20
2.43.2


