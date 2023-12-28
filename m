Return-Path: <linux-kernel+bounces-12757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD4A81F9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8551C212B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885AAF50E;
	Thu, 28 Dec 2023 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cnZYnqL7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6264DF4E9;
	Thu, 28 Dec 2023 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BSFUaXv103330;
	Thu, 28 Dec 2023 09:30:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703777436;
	bh=hbQn/7htqu5ze6cnODQAltMYX+xCyXIFHCSDxaMTPfc=;
	h=From:To:CC:Subject:Date;
	b=cnZYnqL75ELnqaZJVCm+YD6gR4gNeBHKUqNlfqeJ9Pava7VAPj9PNnFsRvrI3jTUI
	 JvmHsbvUyq4A68P/tl1LLDhI89MoVNGwpJ+GGaEkCfqrsvqw0dTf3Mh+05EDsHhMtF
	 9gY682Ptu3mEdTOkYhzILMuWqzVqit8n6PJ5C+Uc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BSFUaBq038470
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Dec 2023 09:30:36 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Dec 2023 09:30:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Dec 2023 09:30:35 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.161.188])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BSFUSKm116497;
	Thu, 28 Dec 2023 09:30:29 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <kevin-lu@ti.com>, <baojun.xu@ti.com>, <devicetree@vger.kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <13916275206@139.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liam.r.girdwood@intel.com>, <soyer@irl.hu>, <tiwai@suse.de>,
        <peeyush@ti.com>, <navada@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v4 1/4] ASoC: dt-bindings: move tas2563 from tas2562.yaml to tas2781.yaml
Date: Thu, 28 Dec 2023 23:30:20 +0800
Message-ID: <20231228153024.1659-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Move tas2563 from tas2562.yaml to tas2781.yaml to unbind tas2563 from
tas2562 driver code and bind it to tas2781 driver code, because tas2563
only work in bypass-DSP mode with tas2562 driver. In order to enable DSP
mode for tas2563, it has been moved to tas2781 driver. As to the hardware
part, such as register setting and DSP firmware, all these are stored in
the binary firmware. What tas2781 drivder dooes is to parse the firmware
and download it to the chip, then power on the chip. So, tas2781 driver
can be resued as tas2563 driver. Only attention will be paid to
downloading corresponding firmware.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v4:
 - remove tas2563, which will be move to tas2781 driver.
 - Add more comments on why to move tas2563 to tas2781 driver.
 - Provide rationale in terms of bindings and hardware, not in terms of driver.
   Or at least not only.
 - Reorder chip, tas2563 is first, tas2781 is second.
 - Add datasheet linkings.
 - squash both tas2562 and tas2781 binding patches.
 - Put allOf: to the end of the file, after required: block.
---
 .../devicetree/bindings/sound/tas2562.yaml    |  2 -
 .../devicetree/bindings/sound/ti,tas2781.yaml | 85 ++++++++++++++-----
 2 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index f01c0dde0cf7..d28c102c0ce7 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -18,7 +18,6 @@ description: |
 
   Specifications about the audio amplifier can be found at:
     https://www.ti.com/lit/gpn/tas2562
-    https://www.ti.com/lit/gpn/tas2563
     https://www.ti.com/lit/gpn/tas2564
     https://www.ti.com/lit/gpn/tas2110
 
@@ -29,7 +28,6 @@ properties:
   compatible:
     enum:
       - ti,tas2562
-      - ti,tas2563
       - ti,tas2564
       - ti,tas2110
 
diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index a69e6c223308..78d89008c36f 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -5,36 +5,41 @@
 $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Texas Instruments TAS2781 SmartAMP
+title: Texas Instruments TAS2563/TAS2781 SmartAMP
 
 maintainers:
   - Shenghao Ding <shenghao-ding@ti.com>
 
-description:
-  The TAS2781 is a mono, digital input Class-D audio amplifier
-  optimized for efficiently driving high peak power into small
-  loudspeakers. An integrated on-chip DSP supports Texas Instruments
-  Smart Amp speaker protection algorithm. The integrated speaker
-  voltage and current sense provides for real time
+description: |
+  The TAS2563/TAS2781 is a mono, digital input Class-D audio
+  amplifier optimized for efficiently driving high peak power into
+  small loudspeakers. An integrated on-chip DSP supports Texas
+  Instruments Smart Amp speaker protection algorithm. The
+  integrated speaker voltage and current sense provides for real time
   monitoring of loudspeaker behavior.
 
-allOf:
-  - $ref: dai-common.yaml#
+  Specifications about the audio amplifier can be found at:
+    https://www.ti.com/lit/gpn/tas2563
+    https://www.ti.com/lit/gpn/tas2781
 
 properties:
   compatible:
-    enum:
-      - ti,tas2781
-
-  reg:
-    description:
-      I2C address, in multiple tas2781s case, all the i2c address
-      aggregate as one Audio Device to support multiple audio slots.
-    maxItems: 8
-    minItems: 1
-    items:
-      minimum: 0x38
-      maximum: 0x3f
+    description: |
+      ti,tas2563: 6.1-W Boosted Class-D Audio Amplifier With Integrated
+      DSP and IV Sense, 16/20/24/32bit stereo I2S or multichannel TDM.
+
+      ti,tas2781: 24-V Class-D Amplifier with Real Time Integrated Speaker
+      Protection and Audio Processing, 16/20/24/32bit stereo I2S or
+      multichannel TDM.
+    oneOf:
+      - items:
+          - enum:
+              - ti,tas2563
+          - const: ti,tas2781
+      - enum:
+          - ti,tas2781
+
+  reg: true
 
   reset-gpios:
     maxItems: 1
@@ -49,6 +54,44 @@ required:
   - compatible
   - reg
 
+allOf:
+  - $ref: dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tas2563
+    then:
+      properties:
+        reg:
+          description:
+            I2C address, in multiple-AMP case, all the i2c address
+            aggregate as one Audio Device to support multiple audio slots.
+          maxItems: 4
+          minItems: 1
+          items:
+            minimum: 0x4c
+            maximum: 0x4f
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tas2781
+    then:
+      properties:
+        reg:
+          description:
+            I2C address, in multiple-AMP case, all the i2c address
+            aggregate as one Audio Device to support multiple audio slots.
+          maxItems: 8
+          minItems: 1
+          items:
+            minimum: 0x38
+            maximum: 0x3f
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


