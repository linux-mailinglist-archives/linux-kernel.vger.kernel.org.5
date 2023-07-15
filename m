Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D545775481C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 12:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjGOKC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 06:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGOKCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 06:02:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6622726;
        Sat, 15 Jul 2023 03:02:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5216f44d881so1260005a12.1;
        Sat, 15 Jul 2023 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689415342; x=1692007342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9bOirRu6EADR4lQ+to8XFoY/uoEmIKfleVanV2j96+8=;
        b=Ps8nmE8yOES7YE0jt2bn6eP+DPJc31u6tnebmhKJBOOug0eoGMfCw0Qiv1AAFXP4cH
         aEmpGq/v0G9ygn1NBPJy51WCrzOGSwymWQivtv6cftJdR4NuRaV4r53PPRt7zjYMjlUq
         GBFSXcvzGjCIAnwzkBPE9zAHLaJKdWwgydNHaMXWx3cHVkMbYqcl/7GXUL9HUcu6SHJF
         JuIqY70DDRYtOEmHkiv2YVNXQgtSz3rJxoqdmSyWaVirR7TARxilkDrhihSu6jiim7Ye
         tVgbEN+Tkds2uSIdF2hUKPn/0LHk/LJ9koeZZ7qnzq15RMsOw1m3M7qoagUBiR4hkFqF
         rXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689415342; x=1692007342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bOirRu6EADR4lQ+to8XFoY/uoEmIKfleVanV2j96+8=;
        b=iII5sdk4r47ULNHSnay0lGNbdSeV7TyeUoeBqztRHTH6XrYTyrCo48dG8GjpRlfmT/
         0OBgz2nHTyyzDAf99ON3+V4giSIJoZlyjgq7TM5fCYkQrB5MCE9vumOGAXw01amnrAnD
         ofL5xJEiTJztVlPI7PfzebKRGSmskWvjftFswQPawftQ9MtvckT6Z0pFoA5r4i6IoYeZ
         9mfN2KpD9/l4uaHf3i9CQCRXTzc/jNhEa2MuQjv7gq93TFeWKtOhs5ZqwM78X4Bpfvb2
         EjAulI9q/Ou7XRMCuwYDg7SGXlwgVEEnSBwM6ZxZcqVnnLjdF0kWxBZYiDtqWTStcXxy
         EeVQ==
X-Gm-Message-State: ABy/qLZkzVIfvhm8P0qGk1tiLuCDspLeR9iewEz5eJHg2W5UYDV9rKt8
        jW0VrC/vsN3/4y/MbPfGKZQ=
X-Google-Smtp-Source: APBJJlHFdDR9Ve0U9O2+dL66w23HZjO4wRRKs6m+N/Z7kX1eYtMJ5nqBJOTDtXcf1wvq80mJ5t2QAw==
X-Received: by 2002:a05:6402:31f4:b0:51a:5a25:6631 with SMTP id dy20-20020a05640231f400b0051a5a256631mr6854782edb.3.1689415341548;
        Sat, 15 Jul 2023 03:02:21 -0700 (PDT)
Received: from localhost (dslb-094-220-187-252.094.220.pools.vodafone-ip.de. [94.220.187.252])
        by smtp.gmail.com with ESMTPSA id z17-20020aa7c651000000b0051df54c6a27sm6864439edr.56.2023.07.15.03.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 03:02:20 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: spi: convert spi-brcm63xx.txt to YAML
Date:   Sat, 15 Jul 2023 12:02:10 +0200
Message-Id: <20230715100211.14726-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 .../bindings/spi/brcm,bcm63xx-spi.yaml        | 71 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-bcm63xx.txt   | 33 ---------
 MAINTAINERS                                   |  2 +-
 3 files changed, 72 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx.txt

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-spi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-spi.yaml
new file mode 100644
index 000000000000..53e0c058b8b1
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
+      - const: brcm,bcm6348-spi
+      - const: brcm,bcm6358-spi
+
+  reg:
+    items:
+      - description: main registers
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
index 238f50f9498e..3cb77cdb92f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4125,7 +4125,7 @@ BROADCOM BCM6348/BCM6358 SPI controller DRIVER
 M:	Jonas Gorski <jonas.gorski@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Odd Fixes
-F:	Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
+F:	Documentation/devicetree/bindings/spi/brcm,bcm63xx-spi.yaml
 F:	drivers/spi/spi-bcm63xx.c
 
 BROADCOM ETHERNET PHY DRIVERS
-- 
2.34.1

