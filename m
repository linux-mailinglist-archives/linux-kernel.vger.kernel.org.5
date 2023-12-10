Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D9980BE61
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 00:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjLJXta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 18:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLJXt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 18:49:27 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5523AE7;
        Sun, 10 Dec 2023 15:49:33 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BANmILC117035;
        Sun, 10 Dec 2023 17:48:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702252098;
        bh=tqVowNCu+gkbra0kKTIBn0rJWUwWawWCh6sjB2aRuug=;
        h=From:To:CC:Subject:Date;
        b=SLVhScEU0stjXmFxhm+n8t1noEhS9mHOX3Qt94i2LI6ecjBoZ5pl2KgzXZQS2fk2H
         GvHcWUsPERcSa6WP3Jgb7xpDECeRlBYlvUwsK4plMxRFM5KdzaHGS+YjPJpeFZ+tVu
         7m+DSW693ZMz3C26hyLrEGLK4TC+II+t8xlBf+uM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BANmI2M016287
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 10 Dec 2023 17:48:18 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 10
 Dec 2023 17:48:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 10 Dec 2023 17:48:18 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.64.203])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BANm4Cd015683;
        Sun, 10 Dec 2023 17:48:06 -0600
From:   Shenghao Ding <shenghao-ding@ti.com>
To:     <broonie@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC:     <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <soyer@irl.hu>, <tiwai@suse.de>, <peeyush@ti.com>, <navada@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v2] ASoC: dt-bindings: Add tas2563 into yaml
Date:   Mon, 11 Dec 2023 07:47:58 +0800
Message-ID: <20231210234759.1095-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support tas2563.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v2:
 - Add devicetree list and other list of necessary people and lists to CC
 - Express Compatibility in the bindings
 - Drop driver changes
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index a69e6c223308..c049fe6b2dad 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -5,17 +5,17 @@
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
@@ -23,18 +23,28 @@ allOf:
 
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
 
   reg:
     description:
-      I2C address, in multiple tas2781s case, all the i2c address
+      I2C address, in multiple AMP case, all the i2c address
       aggregate as one Audio Device to support multiple audio slots.
+      - For tas2781, i2c address is from 0x38 to 0x3f.
+      - For tas2563, i2c address is from 0x4e to 0x4f.
     maxItems: 8
     minItems: 1
     items:
       minimum: 0x38
-      maximum: 0x3f
+      maximum: 0x4f
 
   reset-gpios:
     maxItems: 1
-- 
2.34.1

