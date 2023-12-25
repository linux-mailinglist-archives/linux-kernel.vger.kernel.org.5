Return-Path: <linux-kernel+bounces-10899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD19381DE4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EECB1F215BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 05:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D09F9D0;
	Mon, 25 Dec 2023 05:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NU1/5+7N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914EE443E;
	Mon, 25 Dec 2023 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BP5eLIU002555;
	Sun, 24 Dec 2023 23:40:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703482821;
	bh=/cJuzaMwBV9bj1owzJ1BkwCP1ERmEL8XbnhumEog2aY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NU1/5+7NkV+Tnr0pFQOv3BY5XDp9UBTRWADPZVzrfCWL+PB72rZAO4u+UKchVtYaW
	 lFx1TfgOUGWDNmqXphkEHjTHB22a64qv2iCncEwGNLIzx8XRuX+J0+dSxLrSoRol2m
	 hyX5pjWduaeQtidtc9tsmc3FHQpWvW2n+2vrUgxU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BP5eLom034343
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 24 Dec 2023 23:40:21 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 24
 Dec 2023 23:40:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 24 Dec 2023 23:40:21 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.240])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BP5defg118972;
	Sun, 24 Dec 2023 23:40:14 -0600
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
Subject: [PATCH v3 5/5] ASoC: dt-bindings: Add tas2563 into ti,ta2781.yaml to enable DSP mode
Date: Mon, 25 Dec 2023 13:39:31 +0800
Message-ID: <20231225053932.1138-5-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20231225053932.1138-1-shenghao-ding@ti.com>
References: <20231225053932.1138-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Move tas2563 from tas2562.yaml to tas2781.yaml, because tas2563 only work
in bypass-DSP mode with tas2562 driver. In oder to enable DSP mode for
tas2563, it has been moved to tas2781 driver. As to the hardware part,
such as register setting and DSP firmware, all these are stored in the
binary firmware. What tas2781 drivder dooes is to parse the firmware and
download them to the tas2781 or tas2563, then power on tas2781 or tas2563.
So, tas2781 driver can be resued as tas2563 driver. Only attention will be
paid to downloading corresponding firmware.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v3:
 - Add devicetree list and other list of necessary people and lists to CC
 - Express Compatibility in the bindings
 - Add more comments on why move tas2563 to tas2781 driver
 - Provide rationale in terms of bindings and hardware, not in terms of driver.
   Or at least not only.
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 66 ++++++++++++++-----
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index a69e6c223308..bbe8e5f2c013 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -5,36 +5,72 @@
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
 
 allOf:
   - $ref: dai-common.yaml#
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
+          description:
+            I2C address, in multiple AMP case, all the i2c address
+            aggregate as one Audio Device to support multiple audio slots.
+          maxItems: 4
+          minItems: 1
+          items:
+            minimum: 0x4c
+            maximum: 0x4f
 
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
+      - ti,tas2563
+      # Tas781 driver can support both tas2563 and tas2781, because the
+      # hardware part in the driver code, such as register setting and DSP
+      # firmware, all these are stored in the binary firmware. What drivder
+      # dooes is to parse the firmware and download it to the tas2781 or
+      # tas2563, then control tas2781 or tas2563 to power on/off or switch
+      # different dsp params. So, tas2781 driver can be resued as tas2563
+      # driver. Only attention will be paid to downloading corresponding
+      # firmware.
 
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
-- 
2.34.1


