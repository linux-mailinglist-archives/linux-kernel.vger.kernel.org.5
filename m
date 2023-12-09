Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2EE80B32E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjLIIJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjLIIJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:09:02 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B397F1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 00:09:07 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B9882TF054908;
        Sat, 9 Dec 2023 02:08:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702109282;
        bh=0A5dgG5e8t8hFbkQsmKr04qZPph+V/aEN1MHzvY6hVo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=g+vN7t846qj5ar33iUK3xG4DCTVpHewbFh+WreOVj0+96UgZuN/xh2pzD9Hy++IJi
         SNZy0EtiMnxzKMlMCFFMmncwACGZu+FvsMkONh40PZLxVPO/CgT3vw4CZuKwGZzpdj
         qab+YHefwogK037ppf8Ctp9+nLHTota2DserFPro=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B9882xl019101
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 9 Dec 2023 02:08:02 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 9
 Dec 2023 02:08:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 9 Dec 2023 02:08:02 -0600
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.163.83])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B987lHF122124;
        Sat, 9 Dec 2023 02:07:58 -0600
From:   Shenghao Ding <shenghao-ding@ti.com>
To:     <broonie@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <soyer@irl.hu>, <tiwai@suse.de>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1 3/3] ASoC: dt-bindings: Add tas2563 into yaml
Date:   Sat, 9 Dec 2023 16:07:42 +0800
Message-ID: <20231209080742.1290-3-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20231209080742.1290-1-shenghao-ding@ti.com>
References: <20231209080742.1290-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support tas2563.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 .../devicetree/bindings/sound/ti,tas2781.yaml   | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index a69e6c223308..84e197e15df4 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -11,11 +11,11 @@ maintainers:
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
@@ -25,16 +25,19 @@ properties:
   compatible:
     enum:
       - ti,tas2781
+      - ti,tas2563
 
   reg:
     description:
-      I2C address, in multiple tas2781s case, all the i2c address
+      I2C address, in multiple AMP case, all the i2c address
       aggregate as one Audio Device to support multiple audio slots.
+      For tas2781, i2c address is from 0x38 to 0x3f; For tas2563,
+      i2c address is from 0x4e to 0x4f.
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

