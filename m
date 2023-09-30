Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3327B4257
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjI3QvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbjI3QvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:51:01 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42DEF1;
        Sat, 30 Sep 2023 09:50:59 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3ae35773a04so7229755b6e.0;
        Sat, 30 Sep 2023 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696092659; x=1696697459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BD+dNoaQ5Ko9mEneN4hRLVbcmg6MeMpXyWLNg0tAORY=;
        b=SfF+0E4rd6UZXXeJMTdm2OftGotJYsDLWaXQ+4mK2V/YSkSO9ZdelUBEEI4jWiwIkP
         eeYyDnFulJzlo/H6MkB+pcybsJnAOEoRVlmyQ414Vn8X1qqhQ6n4NpdVYzlAbGMaIy6L
         cXnVURUZgR8vsAAkxV+TIhHmy5OvtbFFlbCwXBmFuWntCn5GPQFUKM5a1dttCPDQFR9I
         S2oBjMMASFUAYqsPhzlkkn6E0ZtDQmGaGQawpmh6hRArS4Xq/pqhJYanAGroSgXvUP4V
         2P1V3n88e4k+F7imDQfKWWdQROuZ4GriTWQZAzrUl+rdDHKZotKXxoCyR7EsYV/oAqbC
         vwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696092659; x=1696697459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BD+dNoaQ5Ko9mEneN4hRLVbcmg6MeMpXyWLNg0tAORY=;
        b=wMgpPIZKn670R9xnsh6Ilj7M+pS7meSk8A2YoJ9VbYk4XbboTSzKeYyYPqPuLBYSNJ
         TS+ohY1KYAKBM3JuAUwN33Rv4Z7BocCWPAYd9LeIEXx8I50eJ2pEvxbr2JQlQPIwOUT/
         GVNWbjPgBezILalqs5M1Y/ZO3HaACNbUZ8xrToGcMU+rm7wRoWEHdUUz/HT/L/47sPD/
         EkD8Tlnu46ylEscDaC9MKBE/ZXcjAcalkpMJvUGl7YN/yCphkp1WqUON7YuPyGYnzWJS
         0ed3hvfkyow8O85J/Y2tbC0pXkQ034nOAJMioHUgRex8OsccPB0xBsILvd+XiBDccCEi
         fmeQ==
X-Gm-Message-State: AOJu0YzYZxeAqNGNaO80nMog8PXcUqsuL96XLd7QQMZAq+YIEUx4e4/9
        GZGTIstX0Lwlvot39xbNzCMytGGVLo4WBQ==
X-Google-Smtp-Source: AGHT+IFFpZXmqz2lsFQCuPTwDpRXOkoC6NFk3863nEWuEFjRiK/iEe8dVToBwEgKuWVFEMN/pCTBOg==
X-Received: by 2002:a05:6870:c08e:b0:1d5:6161:76f3 with SMTP id c14-20020a056870c08e00b001d5616176f3mr8349420oad.3.1696092658868;
        Sat, 30 Sep 2023 09:50:58 -0700 (PDT)
Received: from brag-vm.localdomain ([157.51.87.154])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b0068fe7c4148fsm16583055pfd.57.2023.09.30.09.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 09:50:58 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: dt-bindings: rt5616: Convert to dtschema
Date:   Sat, 30 Sep 2023 22:20:50 +0530
Message-Id: <20230930165050.7793-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the rt5616 audio CODEC bindings to DT schema

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
V1 -> V2: Changes codec to audio-codec and added spacing above

 .../bindings/sound/realtek,rt5616.yaml        | 49 +++++++++++++++++++
 .../devicetree/bindings/sound/rt5616.txt      | 32 ------------
 2 files changed, 49 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5616.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
new file mode 100644
index 000000000000..a387f802afd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt5616.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek rt5616 ALSA SoC audio codec driver
+
+description: |
+  Pins on the device (for linking into audio routes) for RT5616:
+
+      * IN1P
+      * IN2P
+      * IN2N
+      * LOUTL
+      * LOUTR
+      * HPOL
+      * HPOR
+
+maintainers:
+  - Bard Liao <bardliao@realtek.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: realtek,rt5616
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        audio-codec@1b {
+            compatible = "realtek,rt5616";
+            reg = <0x1b>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt5616.txt b/Documentation/devicetree/bindings/sound/rt5616.txt
deleted file mode 100644
index 540a4bf252e4..000000000000
--- a/Documentation/devicetree/bindings/sound/rt5616.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-RT5616 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-- compatible : "realtek,rt5616".
-
-- reg : The I2C address of the device.
-
-Optional properties:
-
-- clocks: The phandle of the master clock to the CODEC.
-
-- clock-names: Should be "mclk".
-
-Pins on the device (for linking into audio routes) for RT5616:
-
-  * IN1P
-  * IN2P
-  * IN2N
-  * LOUTL
-  * LOUTR
-  * HPOL
-  * HPOR
-
-Example:
-
-rt5616: codec@1b {
-	compatible = "realtek,rt5616";
-	reg = <0x1b>;
-};
-- 
2.34.1

