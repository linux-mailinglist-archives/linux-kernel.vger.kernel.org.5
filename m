Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F907DC09D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjJ3Tg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjJ3Tg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:36:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D9E4;
        Mon, 30 Oct 2023 12:36:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a3b8b113so7050700e87.0;
        Mon, 30 Oct 2023 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694612; x=1699299412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swATsRm/D/rD5LWbhxOgcaqNC48PvNHzrc6mwlQlkRo=;
        b=TNMwdrTeUoaKkyAka2zhYPkkCaPnrKgcu65NzPg3E8keiqnF5LYUBWpdSDCTkeCKee
         Zc96XNxA/PRrl2lJ2iKiMH9qJEMwe+WW8GOBdKTXO1rRrcOxMUNq2wnhGxVG1IobFfnR
         6ECwSmXEdLN25M3YAJvC+z0pcSXPHxkcIIOK9M5Uit1AEnf/hZcX4EpRT6O4XeXC6WLY
         u/grzs/DWKlYh0zqMTKjt73kJ9g/6uj42KdLaSzqAiJ1qR4IAgQxAU8bzLt0kMMqwU6K
         yMXeEGvq00ddYXltgep6a5kuqBtnqk2ZU/JFN8aTMhbE+dU6wCpAD2lUgJ01443rwg0V
         oQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694612; x=1699299412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swATsRm/D/rD5LWbhxOgcaqNC48PvNHzrc6mwlQlkRo=;
        b=ryqQ2Iv+nsrWP1YouGMN6dBTKdXZBtoaUBWWAmZNA9amG6OOFucMXKYyITa/GTwT6I
         pClH0/7f0hGaKhjsYl2t8PiTZdKtjGC8r7a9v0iq1jcnSEmj50xkfqMhRuBpCzo7WC6T
         pJH1Vb2TT6Mw1R9bVyLz5cSqb2NgQ5y/h2YwFzi4Z5Es7suPnki5rnlxTqu5d/9caKnQ
         yD3oaov7bjXNHciJ6HNShsLoqsnxP4qRx0odMM8KW/rkEPAoN1KxtMS8xVpi8j1SXy4E
         yk77Qj1d3VFFukAKPhYLt3fw3pj+Y+v5zJKCie2QqxbWUuhNp3/0d7SmlIBhXLRaDdxo
         OIag==
X-Gm-Message-State: AOJu0YzhVAjYkBQRziDslImuGn4Rfz9+sG9K08afycNwCwbV0Wu9saYK
        dfZKWHex65iGSB8oJRlycko=
X-Google-Smtp-Source: AGHT+IHYbNe4KBt+CBTopPnMMMZtMSCUiv8wrfgJIVyNXLh+MeRN2a7zjDK6KPfXhkRi+LHbdUhLhg==
X-Received: by 2002:a05:6512:489a:b0:502:9fce:b6d4 with SMTP id eq26-20020a056512489a00b005029fceb6d4mr7018134lfb.25.1698694612133;
        Mon, 30 Oct 2023 12:36:52 -0700 (PDT)
Received: from hex.my.domain (83.11.208.51.ipv4.supernova.orange.pl. [83.11.208.51])
        by smtp.gmail.com with ESMTPSA id a27-20020ac2521b000000b0050482b29ac8sm1510781lfl.31.2023.10.30.12.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:36:51 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
Date:   Mon, 30 Oct 2023 20:36:38 +0100
Subject: [PATCH 1/6] dt-bindings: mfd: brcm,bcm59056: Convert to YAML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-bcm59054-v1-1-3517f980c1e3@gmail.com>
References: <20231030-bcm59054-v1-0-3517f980c1e3@gmail.com>
In-Reply-To: <20231030-bcm59054-v1-0-3517f980c1e3@gmail.com>
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
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698694608; l=4521;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=Y62BQBGtAcPv02Fu046rbEKVHmHWcxt/VeMRr4coqwE=;
 b=NXn9onAcbC7xKz6CkbyIxg5LEEu9GFFO0hSS76/oKuLrVrPcz57N+/GGBvnxVJPYP/i02U1hu
 RnJrwGYM67tDIxoQUuTf/QZUxB0QkMPSRR+FqKBij5kYBfJHDe4kBy8
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

