Return-Path: <linux-kernel+bounces-8187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7480E81B352
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E9828574D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0414D4EB52;
	Thu, 21 Dec 2023 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DYpu6YiF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A3E4EB31;
	Thu, 21 Dec 2023 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLAENjV030741;
	Thu, 21 Dec 2023 04:14:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703153663;
	bh=rbns9usRGQpZ2NWl1wj7gXW/38aT9PQoDkciQ1L7398=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DYpu6YiFBfSv/Y1+aXFDci3Yq9Lq28NvcQp3Y6HN34sN5XxhoLYes6tcSe5o7lm8I
	 ggsev08hY62sJb2BCXfgYHNaHO5lHHu7Najt3RLiLMWuMd8mYJ2OJv171GcEBDNpdq
	 aixnk+sezNrbgyLG96FpgR4HuE2Yc79kgeaR0YZM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLAENuP017558
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 Dec 2023 04:14:23 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 04:14:23 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 04:14:23 -0600
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.210])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLADoQg069419;
	Thu, 21 Dec 2023 04:14:17 -0600
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
Subject: [PATCH v2 5/5] ASoC: dt-bindings: Add tas2563 into ti,ta2781.yaml to support dsp mode better
Date: Thu, 21 Dec 2023 18:13:45 +0800
Message-ID: <20231221101346.429-5-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20231221101346.429-1-shenghao-ding@ti.com>
References: <20231221101346.429-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add tas2563 to better support dsp mode.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v2:
 - Add devicetree list and other list of necessary people and lists to CC
 - Express Compatibility in the bindings
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 61 +++++++++++++------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index a69e6c223308..76d4357117d5 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -5,36 +5,33 @@
 $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Texas Instruments TAS2781 SmartAMP
+title: Texas Instruments TAS2781/TAS2563 SmartAMP
 
 maintainers:
   - Shenghao Ding <shenghao-ding@ti.com>
 
 description:
-  The TAS2781 is a mono, digital input Class-D audio amplifier
-  optimized for efficiently driving high peak power into small
-  loudspeakers. An integrated on-chip DSP supports Texas Instruments
-  Smart Amp speaker protection algorithm. The integrated speaker
-  voltage and current sense provides for real time
+  The TAS2781/TAS2563 is a mono, digital input Class-D audio
+  amplifier optimized for efficiently driving high peak power into
+  small loudspeakers. An integrated on-chip DSP supports Texas
+  Instruments Smart Amp speaker protection algorithm. The
+  integrated speaker voltage and current sense provides for real time
   monitoring of loudspeaker behavior.
 
-allOf:
-  - $ref: dai-common.yaml#
-
 properties:
   compatible:
+    description: |
+      ti,tas2781: 24-V Class-D Amplifier with Real Time Integrated Speaker
+      Protection and Audio Processing, 16/20/24/32bit stereo I2S or
+      multichannel TDM.
+
+      ti,tas2563: 6.1-W Boosted Class-D Audio Amplifier With Integrated
+      DSP and IV Sense, 16/20/24/32bit stereo I2S or multichannel TDM.
     enum:
       - ti,tas2781
+      - ti,tas2563          # fallback compatible
 
-  reg:
-    description:
-      I2C address, in multiple tas2781s case, all the i2c address
-      aggregate as one Audio Device to support multiple audio slots.
-    maxItems: 8
-    minItems: 1
-    items:
-      minimum: 0x38
-      maximum: 0x3f
+  reg: true
 
   reset-gpios:
     maxItems: 1
@@ -49,6 +46,34 @@ required:
   - compatible
   - reg
 
+allOf:
+  - $ref: dai-common.yaml#
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
+            I2C address, in multiple AMP case, all the i2c address
+            aggregate as one Audio Device to support multiple audio slots.
+          maxItems: 8
+          minItems: 1
+          items:
+            minimum: 0x38
+            maximum: 0x3f
+    else:
+      properties:
+        reg:
+          maxItems: 4
+          minItems: 1
+          items:
+            minimum: 0x4c
+            maximum: 0x4f
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


