Return-Path: <linux-kernel+bounces-82503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F749868576
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9836B2246F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E09610D;
	Tue, 27 Feb 2024 01:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="SXdnW8ZR"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA244C61
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995802; cv=none; b=EEsl2vQsESQARpPNY9DcoPeJ75pJFsz6ZsrnaAl55golGCmQVF5DK8v1IzqP18sOvGMg78Xg0c+gVlefN8YhJ6cGb6kSaHX1nDdMLdzywu8bmqE9l8mWbzW1yaJee8Kv6IfDstYiO7I/stNBZLxaA6D8Y7Au6Chh0lY6RcuuoJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995802; c=relaxed/simple;
	bh=RwCvkBpjWjZdDzoyR0sUhIz+j7ms5wHaCth84P3MKYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtUUiuxooq+1kuKWSPGJ45ORSMJiOARPFfQUiPmtgCqkiziptpupPqQAQwcRpd7s6vs9bqkGEJAkcs4so+JyWhyeMD9EVWCy1z2gBQsT99hjHu++rkfkSk7GWr3btzN3mN+dPKqLQpZZo6nqrT6hfsQMwEy+q1C+bY2WFFQ4bfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=SXdnW8ZR; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9BB282C0657;
	Tue, 27 Feb 2024 14:03:19 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1708995799;
	bh=wH2e4GGOGFrvrqcOtz3dw/t+ACqpEAmKW5pshoxQMl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SXdnW8ZRYoXWowI1tt+OTin8WfwlTlcBB2mrxkVTqzTyOw8LvdkjK5Xb2Yf7SfuGn
	 +EvGUPa5UEh1saNoNzZtgOHT9md7UIiKzsRTUInUc6g/PFWzX3vLNRYqflSF0TKHK+
	 AwU1dN46bOca0yPL7hVN0JUBtVSFykmPQi7dZeW/BuPI/Inp7riL68YxlmH1WZz4Aj
	 9QhujcQKBrn1IiZr0/ROUMHyCg2KZL9qhRJM0m0f7Lgh9hdlUoymXJLfaVtSqnm3VT
	 DpP5s/PrD4KV/ysdvtbYx+RLWs5PnHbhiXeiU3j0ptf93Kw2i553x6b4v3uHZZYU/N
	 9K6sYPTu5dKvg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65dd34d70000>; Tue, 27 Feb 2024 14:03:19 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 4793E13ED8D;
	Tue, 27 Feb 2024 14:03:19 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 445FF2807DC; Tue, 27 Feb 2024 14:03:19 +1300 (NZDT)
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
Subject: [PATCH v8 2/2] dt-bindings: rtc: add max313xx RTCs
Date: Tue, 27 Feb 2024 14:03:10 +1300
Message-ID: <20240227010312.3305966-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227010312.3305966-1-chris.packham@alliedtelesis.co.nz>
References: <20240227010312.3305966-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BKkQr0QG c=1 sm=1 tr=0 ts=65dd34d7 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=gAnH3GRIAAAA:8 a=gEfo2CItAAAA:8 a=ZcN8bhqOFn-iYlg87JMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=oVHKYsEdi7-vN-J5QA_j:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

From: Ibrahim Tilki <Ibrahim.Tilki@analog.com>

Add devicetree binding documentation for Analog Devices MAX313XX RTCs.
This combines the new models with the existing max31335 binding.

Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/rtc/adi,max31335.yaml | 88 ++++++++++++++++---
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/adi,max31335.yaml b/Do=
cumentation/devicetree/bindings/rtc/adi,max31335.yaml
index 0125cf6727cc..ad8d6fec9a2b 100644
--- a/Documentation/devicetree/bindings/rtc/adi,max31335.yaml
+++ b/Documentation/devicetree/bindings/rtc/adi,max31335.yaml
@@ -1,36 +1,54 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright 2022 Analog Devices Inc.
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/rtc/adi,max31335.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Analog Devices MAX31335 RTC
+title: Analog Devices MAX313XX series I2C RTCs
=20
 maintainers:
   - Antoniu Miclaus <antoniu.miclaus@analog.com>
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
=20
-description:
-  Analog Devices MAX31335 I2C RTC =C2=B12ppm Automotive Real-Time Clock =
with
-  Integrated MEMS Resonator.
-
-allOf:
-  - $ref: rtc.yaml#
+description: Analog Devices MAX313XX series I2C RTCs.
=20
 properties:
   compatible:
-    const: adi,max31335
+    enum:
+      - adi,max31328
+      - adi,max31329
+      - adi,max31331
+      - adi,max31334
+      - adi,max31335
+      - adi,max31341
+      - adi,max31342
+      - adi,max31343
=20
   reg:
-    maxItems: 1
+    description: I2C address of the RTC
+    items:
+      - enum: [0x68, 0x69]
=20
   interrupts:
+    description:
+      Alarm1 interrupt line of the RTC. Some of the RTCs have two interr=
upt
+      lines and alarm1 interrupt muxing depends on the clockin/clockout
+      configuration.
     maxItems: 1
=20
   "#clock-cells":
     description:
-      RTC can be used as a clock source through its clock output pin.
+      RTC can be used as a clock source through its clock output pin whe=
n
+      supplied.
     const: 0
=20
+  clocks:
+    description:
+      RTC uses this clock for clock input when supplied. Clock has to pr=
ovide
+      one of these four frequencies - 1Hz, 50Hz, 60Hz or 32.768kHz.
+    maxItems: 1
+
   adi,tc-diode:
     description:
       Select the diode configuration for the trickle charger.
@@ -48,6 +66,56 @@ required:
   - compatible
   - reg
=20
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
 unevaluatedProperties: false
=20
 examples:
--=20
2.43.2


