Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ED17ADD7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjIYQ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjIYQ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:57:29 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C699EBE;
        Mon, 25 Sep 2023 09:57:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-692a885f129so3797714b3a.0;
        Mon, 25 Sep 2023 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695661042; x=1696265842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KNPKfLP0E+UkNkw5CTvEwC/Bj3Ev7o9rQHtsP3/MgPM=;
        b=GtrLMCGa6q5uMUkTjANg1YwZxyinihngCu4qQQvnQvafv9JM/ybIBOYowUgJkYUYWk
         ZjSWbPcieMdnvmaiz7X8bkhsY+pYs45gjvhmVpsHMZlHKe0D+uWs9Uf7t4tewSpG863Q
         we6oFK3e1tJmnxmsGPgUM95IqrURqvqc98sYfHxjxgBppxPjJ4Tg6w/QQp7/3/QTKwY2
         NyMhfnt5UeHVk0T+zsPURaa4bmRDbAlWSpyxRIihachph5qwacpZ7pS9s13DxJw+FHNP
         x8VMQQ0xNt4iAxz8zTvsO6G7MSXOm2Lb4HahRiHUOc1WcD2bbhCjaDoG6hdDunJ7YOEe
         NEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695661042; x=1696265842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNPKfLP0E+UkNkw5CTvEwC/Bj3Ev7o9rQHtsP3/MgPM=;
        b=acLFFApWWcHiveuQnUwxX0Ww0sEPbxPAPMbSl42suVSo5gdqpfr0Sm8pav75dXCTPJ
         /2+hwh/S5ppFJwerlV1IDxkwiBoztAo80EHYxqzKUNyPNgzc61sVbCEZ/klTPNFKEosN
         /Zr//ikEHQibN3tOn6reWqXk/3sCbRSZv2qc6msKFoXzbi94cSxQ77sKhArv9YmV/UGd
         49GP6NHlk6a4WXeRLeb90UH82TfaZo3hHeA4K+w1BmGgwUY7Fha1txY5fD3xd9XZ19ug
         7Besr3WUkFBkkApTcCy/bVC09GvTE4JRrzfbQZRNq+FlGWrJGDk29fa3k3X4XyRFx9Ob
         h/fw==
X-Gm-Message-State: AOJu0Yy+dcWAow3F5kYhUZnhXEE633mJInU/ap1JXM4mIyjKMhwQ051j
        rwevfnP2v2zPCuj8w6Qkywk=
X-Google-Smtp-Source: AGHT+IGgAIdPUxAnztT0fJPj4/tqnX0ygspeJDX0q+y8/ITWvnKA6PxrzpaVbgnvmtZnsupmDazAKA==
X-Received: by 2002:a05:6a21:601:b0:155:5c28:ea74 with SMTP id ll1-20020a056a21060100b001555c28ea74mr5201556pzb.12.1695661042173;
        Mon, 25 Sep 2023 09:57:22 -0700 (PDT)
Received: from brag-vm.localdomain ([27.4.138.218])
        by smtp.gmail.com with ESMTPSA id jw1-20020a170903278100b001c452f827casm9158507plb.257.2023.09.25.09.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 09:57:21 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: rt5616: Convert to dtschema
Date:   Mon, 25 Sep 2023 22:27:15 +0530
Message-Id: <20230925165715.34883-1-bragathemanick0908@gmail.com>
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
No error/warning seen when running make dt_binding_check

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 .../bindings/sound/realtek,rt5616.yaml        | 53 +++++++++++++++++++
 .../devicetree/bindings/sound/rt5616.txt      | 32 -----------
 2 files changed, 53 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5616.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
new file mode 100644
index 000000000000..00ff9b4e3c7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5616.yaml
@@ -0,0 +1,53 @@
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
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - '#sound-dai-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@1b {
+            compatible = "realtek,rt5616";
+            reg = <0x1b>;
+            #sound-dai-cells = <0>;
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

