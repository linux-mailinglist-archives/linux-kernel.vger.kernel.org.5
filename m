Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FCA76878C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjG3Tmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjG3Tmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:42:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDF210FE
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:42:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99357737980so616484066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690746152; x=1691350952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOIx3c8bCXmFks0uYOhLCtUYhVUu2tl5xgP/O/vVgJI=;
        b=vc9CMHFKnR97qG1GwBTBh1ObSMRpa+wldPux2V3EY50WpG3b32cD7AfyEgXv2R1kYf
         ra4VmLBQgV8qmxTS7GbE1ytMiKZvZbZ7mH8zkIlfJm1OVdE+b6GFYkEPI3/4DR8ispKv
         J1Wv3gJ6G2bL+MEm0ff+gJE0w83tIFpHZviCXbwrovuTRZRA30CuunaNfIA6KK7IOipA
         8+niPbaue2B0au8MR+aMoF0fgFIZK+Lk+NdXhstMC6U/s8mQr298EQWH8F5bYY6Q978G
         lSO+icKCFPo+xMg5J+cMQJz5tfHBvUQltXrOtk44S3djsGrQF2XmjjE1f96QqmBxjk4N
         D7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690746152; x=1691350952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOIx3c8bCXmFks0uYOhLCtUYhVUu2tl5xgP/O/vVgJI=;
        b=JOD1C+CZR65HvJncU59DrjxQwWkopfLrfGEYAS53E2x0Rq0IQoZyu1vCh+Td3QPjt0
         e+kXzGAShaCzVdx1Sbjs286my207czum9SzV88r6hUfa5hsDhi4xK3DZbusUkHzRUUO/
         JpFE2ePxOTQ0QAfOY/CGa7lMsKsDUCtUW9SGTofCv8VRStm54rBtaFP5dwasYz8oOwzk
         MmwMiMUFyuHIkUcbca0WE/27JYQ5daDwTBTPqjGB8NXCuP7EU/eZlLKAu5WMiaBlRy+P
         zJnc1b1PT9fa7bP0cmhCAMWJps5dUw5HtplrtO74vZqqq2BePSYbEkC+qhCH7BWWsgSF
         E6CA==
X-Gm-Message-State: ABy/qLaQab4rbMr7gJDGioKq0LnMCbN36EHwucqhanOcvHDeDdZXJ8mT
        ZVxhc5hSbsFKpjUav83y8lExCQ==
X-Google-Smtp-Source: APBJJlF+nwd2cY5Tl1A0VVfn6wBKe5tUmj/bu9lDv5yNX/9MfkMSk0RHzpD27NBOLmdO4E94ht1w2A==
X-Received: by 2002:a17:906:76c8:b0:99b:ef1e:3836 with SMTP id q8-20020a17090676c800b0099bef1e3836mr6340313ejn.9.1690746152559;
        Sun, 30 Jul 2023 12:42:32 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id j25-20020a170906255900b0099b4d86fbccsm5140490ejb.141.2023.07.30.12.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 12:42:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ryan Lee <ryans.lee@maximintegrated.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: Convert maxim,max98925 to DT schema
Date:   Sun, 30 Jul 2023 21:42:30 +0200
Message-Id: <20230730194230.34447-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Maxim Integrated MAX98925/MAX98926/MAX98927 speaker
amplifier bindings to DT schema format.  Changes during conversion: add
sound-dai-cells, already used by DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Ryan,
As original author, I added you as bindings maintainer. Is that okay or
maybe someone else from Maxim should take care about the bindings?
---
 .../devicetree/bindings/sound/max9892x.txt    |  44 --------
 .../bindings/sound/maxim,max98925.yaml        | 100 ++++++++++++++++++
 2 files changed, 100 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/max9892x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98925.yaml

diff --git a/Documentation/devicetree/bindings/sound/max9892x.txt b/Documentation/devicetree/bindings/sound/max9892x.txt
deleted file mode 100644
index 98cb9ba5b328..000000000000
--- a/Documentation/devicetree/bindings/sound/max9892x.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Maxim Integrated MAX98925/MAX98926/MAX98927 Speaker Amplifier
-
-This device supports I2C.
-
-Required properties:
-
-  - compatible : should be one of the following
-    - "maxim,max98925"
-    - "maxim,max98926"
-    - "maxim,max98927"
-
-  - vmon-slot-no : slot number used to send voltage information
-                   or in inteleave mode this will be used as
-                   interleave slot.
-                   MAX98925/MAX98926 slot range : 0 ~ 30,  Default : 0
-                   MAX98927 slot range : 0 ~ 15,  Default : 0
-
-  - imon-slot-no : slot number used to send current information
-                   MAX98925/MAX98926 slot range : 0 ~ 30,  Default : 0
-                   MAX98927 slot range : 0 ~ 15,  Default : 0
-
-  - interleave-mode : When using two MAX9892X in a system it is
-                   possible to create ADC data that that will
-                   overflow the frame size. Digital Audio Interleave
-                   mode provides a means to output VMON and IMON data
-                   from two devices on a single DOUT line when running
-                   smaller frames sizes such as 32 BCLKS per LRCLK or
-                   48 BCLKS per LRCLK.
-                   Range : 0 (off), 1 (on),  Default : 0
-
-  - reg : the I2C address of the device for I2C
-
-Optional properties:
-  - reset-gpios : GPIO to reset the device
-
-Example:
-
-codec: max98927@3a {
-   compatible = "maxim,max98927";
-   vmon-slot-no = <0>;
-   imon-slot-no = <1>;
-   interleave-mode = <0>;
-   reg = <0x3a>;
-};
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98925.yaml b/Documentation/devicetree/bindings/sound/maxim,max98925.yaml
new file mode 100644
index 000000000000..a01a130ef686
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98925.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98925.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX98925/MAX98926/MAX98927 speaker amplifier
+
+maintainers:
+  - Ryan Lee <ryans.lee@maximintegrated.com>
+
+properties:
+  compatible:
+    enum:
+      - maxim,max98925
+      - maxim,max98926
+      - maxim,max98927
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  vmon-slot-no:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 30
+    default: 0
+    description:
+      Slot number used to send voltage information or in inteleave mode this
+      will be used as interleave slot.
+
+  imon-slot-no:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 30
+    default: 0
+    description:
+      Slot number used to send current information.
+
+  interleave-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    default: 0
+    description:
+      When using two MAX9892X in a system it is possible to create ADC data
+      that will overflow the frame size. Digital Audio Interleave mode provides
+      a means to output VMON and IMON data from two devices on a single DOUT
+      line when running smaller frames sizes such as 32 BCLKS per LRCLK or 48
+      BCLKS per LRCLK.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: dai-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - maxim,max98927
+    then:
+      properties:
+        vmon-slot-no:
+          minimum: 0
+          maximum: 15
+
+        imon-slot-no:
+          minimum: 0
+          maximum: 15
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        #include <dt-bindings/gpio/gpio.h>
+        audio-codec@3a {
+            compatible = "maxim,max98927";
+            reg = <0x3a>;
+            #sound-dai-cells = <0>;
+
+            pinctrl-0 = <&speaker_default>;
+            pinctrl-names = "default";
+
+            reset-gpios = <&tlmm 69 GPIO_ACTIVE_LOW>;
+
+            vmon-slot-no = <1>;
+            imon-slot-no = <0>;
+        };
+    };
-- 
2.34.1

