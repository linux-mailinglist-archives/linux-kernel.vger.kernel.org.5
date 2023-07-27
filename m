Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7186764834
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjG0HPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjG0HPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:15:08 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFB14C11;
        Thu, 27 Jul 2023 00:09:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso6401695e9.0;
        Thu, 27 Jul 2023 00:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690441693; x=1691046493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy0ZPSBy/NyLfyM/Q1eVqojfIwuNg1V+4W9H5qPvnrE=;
        b=GSM/LfeG1DRpQU/3h0UPD8P85XQpwyZ0TH0C7i5iTlrVBs9hV8sCNF7vPnLs014p32
         Vd/JJpiHtmV3xhbF3VUj6mmpaD5dsnUqeOICHwq2F5h9tIhVSOJZZYsVI/0tf332gUqU
         NDIqNwyWlhd/4P9B3galyH4h26Rwud5Y9waDJEBJjDBvKG80/oqn+3MhcBGlEVAb/GST
         Ss4kF6lEG1JV6UxdLnrCzTnWWipr1CRKgeN/dhHOc49a1beKOchHjGFMmlrqvh/B6gTL
         hxDibRx23NBYCH1tOIZ8U8ZkcjTYvIRo0iPKsTGV0/RT8jXKG1Cag+hUyKqNOOWnBZ4S
         nkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690441693; x=1691046493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dy0ZPSBy/NyLfyM/Q1eVqojfIwuNg1V+4W9H5qPvnrE=;
        b=f2Q2iGN9asR5qbUkBLWuZyVxxSh5XsvNfcCTHtKh2pshbuH7AAWA/TC4JgD0DjKgWX
         rC0cqbwIfGBQlgaTak/nPl4cA2e+WmUCTnZAzsQavw7nB9VIGUQRYusFtEqqT3RIEGDy
         UBschpaU7gesrONjoMln5yICMAINIs014dS+SoPYIPtK6Fy9P/3DrB9s3No2V/HwnSig
         meqePVjnLPXqCxP4y6gqDeeomocGfkTaoVefQWFJX61GbLbSMqEml8Z1mWBzzfMrClxN
         rc2OH+0/QLyTQB7PfwSlf/4zc9LJpFE4zLrPUgJ1DJakDrmYQ1B3I86nfyu+DjR0flki
         YgfQ==
X-Gm-Message-State: ABy/qLbJ/7VpBBj14rS0uzZdtyVHQ4hml3tF162U1qaAS3EoO3ljXy5n
        eC0sxiUoV7lhC4L4RBOj8wTjYSnzOd0=
X-Google-Smtp-Source: APBJJlH7gFR5ZcceVKw/6PYsYPsQb5R5JwEd8nFNtGwVVDDSYNkmt1Qcq+S1TK85E5fTpMfNNUv0dA==
X-Received: by 2002:a05:600c:209:b0:3f8:f1db:d206 with SMTP id 9-20020a05600c020900b003f8f1dbd206mr941663wmi.25.1690441693134;
        Thu, 27 Jul 2023 00:08:13 -0700 (PDT)
Received: from localhost (dslb-088-076-253-094.088.076.pools.vodafone-ip.de. [88.76.253.94])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c00d400b003faef96ee78sm3860651wmm.33.2023.07.27.00.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:08:12 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: spi: convert spi-brcm63xx.txt to YAML
Date:   Thu, 27 Jul 2023 09:08:06 +0200
Message-Id: <20230727070806.12205-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes done during conversion:

* added a description, lifting and adapting the limitation sentence from
  brcm,bcm63xx-hsspi.yml
* added appropriate compatibles for all SoCs that are supported by
  bcm63xx/bmips

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* applied Kryzstof's review comments:
 * replaced oneOf list of two consts with enum
 * replaced textual description of only reg item with maxItems: 1
 * added Reviewed-By

 .../bindings/spi/brcm,bcm63xx-spi.yaml        | 71 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-bcm63xx.txt   | 33 ---------
 MAINTAINERS                                   |  2 +-
 3 files changed, 72 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx.txt

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-spi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-spi.yaml
new file mode 100644
index 000000000000..fa03cdd68e70
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-spi.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/brcm,bcm63xx-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM6348/BCM6358 SPI controller
+
+maintainers:
+  - Jonas Gorski <jonas.gorski@gmail.com>
+
+description: |
+  Broadcom "Low Speed" SPI controller found in many older MIPS based Broadband
+  SoCs.
+
+  This controller has a limitation that can not keep the chip select line active
+  between the SPI transfers within the same SPI message. This can terminate the
+  transaction to some SPI devices prematurely. The issue can be worked around by
+  the controller's prepend mode.
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,bcm6368-spi
+              - brcm,bcm6362-spi
+              - brcm,bcm63268-spi
+          - const: brcm,bcm6358-spi
+      - enum:
+          - brcm,bcm6348-spi
+          - brcm,bcm6358-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SPI master reference clock
+
+  clock-names:
+    items:
+      - const: spi
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@10000800 {
+        compatible = "brcm,bcm6368-spi", "brcm,bcm6358-spi";
+        reg = <0x10000800 0x70c>;
+        interrupts = <1>;
+        clocks = <&clkctl 9>;
+        clock-names = "spi";
+        num-cs = <5>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt b/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
deleted file mode 100644
index 1c16f6692613..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Binding for Broadcom BCM6348/BCM6358 SPI controller
-
-Required properties:
-- compatible: must contain one of "brcm,bcm6348-spi", "brcm,bcm6358-spi".
-- reg: Base address and size of the controllers memory area.
-- interrupts: Interrupt for the SPI block.
-- clocks: phandle of the SPI clock.
-- clock-names: has to be "spi".
-- #address-cells: <1>, as required by generic SPI binding.
-- #size-cells: <0>, also as required by generic SPI binding.
-
-Optional properties:
-- num-cs: some controllers have less than 8 cs signals. Defaults to 8
-  if absent.
-
-Child nodes as per the generic SPI binding.
-
-Example:
-
-	spi@10000800 {
-		compatible = "brcm,bcm6368-spi", "brcm,bcm6358-spi";
-		reg = <0x10000800 0x70c>;
-
-		interrupts = <1>;
-
-		clocks = <&clkctl 9>;
-		clock-names = "spi";
-
-		num-cs = <5>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index d516295978a4..e3aae8887044 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4127,7 +4127,7 @@ BROADCOM BCM6348/BCM6358 SPI controller DRIVER
 M:	Jonas Gorski <jonas.gorski@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Odd Fixes
-F:	Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
+F:	Documentation/devicetree/bindings/spi/brcm,bcm63xx-spi.yaml
 F:	drivers/spi/spi-bcm63xx.c
 
 BROADCOM ETHERNET PHY DRIVERS
-- 
2.34.1

