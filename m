Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9F07DC0C2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjJ3Tl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJ3Tly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:41:54 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21724E6;
        Mon, 30 Oct 2023 12:41:51 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so71058891fa.0;
        Mon, 30 Oct 2023 12:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694909; x=1699299709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swATsRm/D/rD5LWbhxOgcaqNC48PvNHzrc6mwlQlkRo=;
        b=M3qlTjKddEF4Z/mI8X2qm40HWUlphyZvdII1BhLpn85ZJhWDwQ80hC1H/sV/JrHDpF
         yIOm6wTQ39KtN9KAKnOjQr/RJHijnjyOFqO0Jjvx8YEOJ/K3aMuuOINGUvaOlPysxLZy
         fiABquYSFiEEpi8fwI6LhGmg5qW+WzsDSsTDAOJ7vtjzv6HXbliU6kFS+kDXl9wsx5SO
         Iva5Mz7dmltFnFiezXONwwSdlGCBUc8B5bRzJcQIEI5NdEZydibk1PkWGuCTSa7+v0Xl
         mpTBCqh1p9lgJvW3arK5nIcHBrWL232sl8PxQ5qh3s158qlqZkDlVK9WRuWrjl/Cp0Iv
         d1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694909; x=1699299709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swATsRm/D/rD5LWbhxOgcaqNC48PvNHzrc6mwlQlkRo=;
        b=EmysLc4eAsFCS3xA1Z7VfZTcVHqH7yuEGNG1ydCAfcv2F21C7THpi6xDKV3Llt3AYa
         zY8WKTbCW/lk2CU1wspmM3RgWM+/5nuyo2PhJuPUs4EF07xEN97AMZN1fN1YkQ9I+2nB
         eEkBIlbc27rCwQpn+hlrfoHZ8hcJoImSuHsqg4sZ30TsfMoEceqRVp2Zpq/2g1IhH1vw
         QBJQLNU8OUbLKORJ9SJXX9Vf7vUnU5YySnC2FcYGC2456oHRjGLbNWkKJTc/LlPhjWzB
         lT9biEjXHan+o7/pod2HprLTSLlqUk0JDXrKEaRiusjHvykHxn++ymS+0yAzlY0CSioH
         x+2A==
X-Gm-Message-State: AOJu0YxEW2CCRv/6/ZNYk249GWCYM9ixKIxVzDDwG97CyLSBVS8OPWZl
        t2DP3Mvj2JBtFUGOgOxFlg0=
X-Google-Smtp-Source: AGHT+IHDjgogZloqvF0vTFY93o5pdCKouALhCREZfA40vWUlSo3ELseYviRwZ7oOCxUJTw0ha3c1Mw==
X-Received: by 2002:a05:6512:1109:b0:4f8:714e:27a8 with SMTP id l9-20020a056512110900b004f8714e27a8mr9469763lfg.0.1698694909024;
        Mon, 30 Oct 2023 12:41:49 -0700 (PDT)
Received: from hex.my.domain (83.11.208.51.ipv4.supernova.orange.pl. [83.11.208.51])
        by smtp.gmail.com with ESMTPSA id m10-20020ac2428a000000b005057184ae62sm1527802lfh.96.2023.10.30.12.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:41:48 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
Date:   Mon, 30 Oct 2023 20:41:43 +0100
Subject: [PATCH v2 1/6] dt-bindings: mfd: brcm,bcm59056: Convert to YAML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-bcm59054-v2-1-5fa4011aa5ba@gmail.com>
References: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
In-Reply-To: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698694906; l=4521;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=Y62BQBGtAcPv02Fu046rbEKVHmHWcxt/VeMRr4coqwE=;
 b=nx2q3J0EGQzhBlh4CNujQQbnjJb61qCJNAkQKsR4ky9V7rmn4T7KziV5xY9FTTpXm56BySP/+
 MJ52RAUBHWrADwtKPq44YGhq1lav7wc3rBoleVHhkWMeAupfSYnw7G0
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert devicetree bindings for the Broadcom BCM59056 PMU MFD from
TXT to YAML format. This patch does not change any functionality;
the bindings remain the same.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 .../devicetree/bindings/mfd/brcm,bcm59056.txt      | 39 ----------
 .../devicetree/bindings/mfd/brcm,bcm59056.yaml     | 91 ++++++++++++++++++++++
 2 files changed, 91 insertions(+), 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.txt b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.txt
deleted file mode 100644
index be51a15e05f9..000000000000
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.txt
+++ /dev/null
@@ -1,39 +0,0 @@
--------------------------------
-BCM590xx Power Management Units
--------------------------------
-
-Required properties:
-- compatible: "brcm,bcm59056"
-- reg: I2C slave address
-- interrupts: interrupt for the PMU. Generic interrupt client node bindings
-  are described in interrupt-controller/interrupts.txt
-
-------------------
-Voltage Regulators
-------------------
-
-Optional child nodes:
-- regulators: container node for regulators following the generic
-  regulator binding in regulator/regulator.txt
-
-  The valid regulator node names for BCM59056 are:
-  	rfldo, camldo1, camldo2, simldo1, simldo2, sdldo, sdxldo,
-	mmcldo1, mmcldo2, audldo, micldo, usbldo, vibldo,
-	csr, iosr1, iosr2, msr, sdsr1, sdsr2, vsr,
-	gpldo1, gpldo2, gpldo3, gpldo4, gpldo5, gpldo6,
-	vbus
-
-Example:
-	pmu: bcm59056@8 {
-		compatible = "brcm,bcm59056";
-		reg = <0x08>;
-		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
-		regulators {
-			rfldo_reg: rfldo {
-				regulator-min-microvolt = <1200000>;
-				regulator-max-microvolt = <3300000>;
-			};
-
-			...
-		};
-	};
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
new file mode 100644
index 000000000000..6d6acc9fd312
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm59056.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/brcm,bcm59056.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BCM590xx Power Management Unit MFD
+
+maintainers:
+  - Artur Weber <aweber.kernel@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - "brcm,bcm59056"
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: Container node for regulators.
+
+    # The valid regulator node names for BCM59056 are:
+    #   rfldo, camldo1, camldo2, simldo1, simldo2, sdldo, sdxldo,
+    #   mmcldo1, mmcldo2, audldo, micldo, usbldo, vibldo,
+    #   csr, iosr1, iosr2, msr, sdsr1, sdsr2, vsr,
+    #   gpldo1, gpldo2, gpldo3, gpldo4, gpldo5, gpldo6,
+    #   vbus
+    patternProperties:
+      "^(cam|sim|mmc)ldo[1-2]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+      "^(rf|sd|sdx|aud|mic|usb|vib)ldo$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+      "^(c|m|v)sr$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+      "^(io|sd)sr[1-2]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+      "^gpldo[1-6]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+    properties:
+      "vbus":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmu: bcm59056@8 {
+            compatible = "brcm,bcm59056";
+            reg = <0x08>;
+            interrupts = <0 215 IRQ_TYPE_LEVEL_HIGH>;
+            regulators {
+                rfldo_reg: rfldo {
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+            };
+        };
+    };

-- 
2.42.0

