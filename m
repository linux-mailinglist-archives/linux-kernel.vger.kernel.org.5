Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E437D1604
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjJTS7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJTS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:59:13 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FD7126;
        Fri, 20 Oct 2023 11:59:11 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6c4b9e09521so776335a34.3;
        Fri, 20 Oct 2023 11:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697828349; x=1698433149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KO1B8NLpIZ5UNHSoJGqgEpEiVCyXG+XqGyI71Fm7/d8=;
        b=JFKS3PxQChHY4xtb1ef4+JrM1mYnaDf6dMxMqiaemjLeYM6uKWe7qph6lzlQVrkV5c
         hXMMZoelMCNjH+J+TsMyNOMRYmVRuaJ3fJB1Iz/vOALbhhN+WvAj9Jpql1JH96zsJWFL
         8UYB6aFZPOo/x4zXF/LeUDGc9Mey07Mqar1nTpkC8DqYRwLVXY9/Dy1E2miy2t1YOVMi
         /qV5Y9HqHaGqXbgne/cg7ugJxJWDUfmN1vPb3ZWrKm8VVf5hREpD2lAw605vwDIEChds
         dGbxBqIotO2KuFWYMl/BuJRnDRaPSnf/AhM1hb3yfVPCgALPxwKFMvy4um81NPlzNBss
         0e4Q==
X-Gm-Message-State: AOJu0YyS+R+yEUqGJxU5BrY+FBi7B+tIqG8NlxIyr1qnR8W829leyF1W
        pWKnb+rpagtqGUeicbeeOA==
X-Google-Smtp-Source: AGHT+IGrf0J84sN7F4bffvA216GCVSelzHpDzHYio0ZJs2S3kfoNJOoBl/mnyUTnoeKagOCJixU3zg==
X-Received: by 2002:a05:6830:12d8:b0:6c6:5053:66dc with SMTP id a24-20020a05683012d800b006c6505366dcmr2972485otq.21.1697828348654;
        Fri, 20 Oct 2023 11:59:08 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e10-20020a056830200a00b006b9848f8aa7sm429447otp.45.2023.10.20.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:59:07 -0700 (PDT)
Received: (nullmailer pid 3951059 invoked by uid 1000);
        Fri, 20 Oct 2023 18:59:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2] dt-bindings: pinctrl: brcm: Ensure all child node properties are documented
Date:   Fri, 20 Oct 2023 13:52:02 -0500
Message-ID: <20231020185203.3941590-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom pinctrl bindings are incomplete for child nodes as they are
missing 'unevaluatedProperties: false' to prevent unknown properties.
Fixing this reveals many warnings including having grandchild nodes in some
cases. Many cases in the examples use 'group' property which is
undocumented and not used by the driver. As the schemas define 'pins', I
assume that is the correct name except for the one case, 6358, using
'groups' which is documented.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Well, it's been a year[1] and no one else has stepped up to fix these
bindings. I'm still not certain where "pins" vs. "groups" is correct or
whether it even matters (to the driver). As there are no .dts files to
go by, I went with the schema being correct unless the example was the
complete opposite (6358).

This is about the last thing blocking enabling checks that child node
schemas have unevaluatedProperties or additionalProperties. If no one
wants to fix this correctly, then apply this or we should remove the
bindings.

[1] https://lore.kernel.org/all/20220816183911.2517173-1-robh@kernel.org/
---
 .../mfd/brcm,bcm63268-gpio-sysctl.yaml        | 18 ++++++-------
 .../mfd/brcm,bcm6362-gpio-sysctl.yaml         |  2 +-
 .../mfd/brcm,bcm6368-gpio-sysctl.yaml         |  2 +-
 .../pinctrl/brcm,bcm6318-pinctrl.yaml         |  5 ++++
 .../pinctrl/brcm,bcm63268-pinctrl.yaml        | 25 +++++++++++--------
 .../pinctrl/brcm,bcm6328-pinctrl.yaml         |  5 ++++
 .../pinctrl/brcm,bcm6358-pinctrl.yaml         |  5 ++--
 .../pinctrl/brcm,bcm6362-pinctrl.yaml         |  7 +++++-
 .../pinctrl/brcm,bcm6368-pinctrl.yaml         |  7 +++++-
 9 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
index c14def1b2ad2..9c2a04829da5 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
@@ -148,47 +148,47 @@ examples:
 
         pinctrl_nand: nand-pins {
           function = "nand";
-          group = "nand_grp";
+          pins = "nand_grp";
         };
 
         pinctrl_gpio35_alt: gpio35_alt-pins {
           function = "gpio35_alt";
-          pin = "gpio35";
+          pins = "gpio35";
         };
 
         pinctrl_dectpd: dectpd-pins {
           function = "dectpd";
-          group = "dectpd_grp";
+          pins = "dectpd_grp";
         };
 
         pinctrl_vdsl_phy_override_0: vdsl_phy_override_0-pins {
           function = "vdsl_phy_override_0";
-          group = "vdsl_phy_override_0_grp";
+          pins = "vdsl_phy_override_0_grp";
         };
 
         pinctrl_vdsl_phy_override_1: vdsl_phy_override_1-pins {
           function = "vdsl_phy_override_1";
-          group = "vdsl_phy_override_1_grp";
+          pins = "vdsl_phy_override_1_grp";
         };
 
         pinctrl_vdsl_phy_override_2: vdsl_phy_override_2-pins {
           function = "vdsl_phy_override_2";
-          group = "vdsl_phy_override_2_grp";
+          pins = "vdsl_phy_override_2_grp";
         };
 
         pinctrl_vdsl_phy_override_3: vdsl_phy_override_3-pins {
           function = "vdsl_phy_override_3";
-          group = "vdsl_phy_override_3_grp";
+          pins = "vdsl_phy_override_3_grp";
         };
 
         pinctrl_dsl_gpio8: dsl_gpio8-pins {
           function = "dsl_gpio8";
-          group = "dsl_gpio8";
+          pins = "dsl_gpio8";
         };
 
         pinctrl_dsl_gpio9: dsl_gpio9-pins {
           function = "dsl_gpio9";
-          group = "dsl_gpio9";
+          pins = "dsl_gpio9";
         };
       };
     };
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml
index 4d594739b382..c2941638c8f2 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml
@@ -230,7 +230,7 @@ examples:
 
         pinctrl_nand: nand-pins {
           function = "nand";
-          group = "nand_grp";
+          pins = "nand_grp";
         };
       };
     };
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml
index aae83d432880..44e77d77d314 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml
@@ -240,7 +240,7 @@ examples:
 
         pinctrl_uart1: uart1-pins {
           function = "uart1";
-          group = "uart1_grp";
+          pins = "uart1_grp";
         };
       };
     };
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml
index 4478a76171f7..62890a0aead1 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml
@@ -24,6 +24,7 @@ patternProperties:
   '-pins$':
     type: object
     $ref: pinmux-node.yaml#
+    additionalProperties: false
 
     properties:
       function:
@@ -37,6 +38,10 @@ patternProperties:
         enum: [ gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6, gpio7,
                 gpio8, gpio9, gpio10, gpio11, gpio12, gpio13, gpio40 ]
 
+    patternProperties:
+      '-pins$':
+        $ref: '#/patternProperties/-pins$'
+
 allOf:
   - $ref: pinctrl.yaml#
 
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml
index 73e1caa7c011..7cc0e1650835 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml
@@ -24,6 +24,7 @@ patternProperties:
   '-pins$':
     type: object
     $ref: pinmux-node.yaml#
+    unevaluatedProperties: false
 
     properties:
       function:
@@ -36,11 +37,15 @@ patternProperties:
 
       pins:
         enum: [ gpio0, gpio1, gpio16, gpio17, gpio8, gpio9, gpio18, gpio19,
-                gpio22, gpio23, gpio30, gpio31, nand_grp, gpio35
+                gpio22, gpio23, gpio30, gpio31, nand_grp, gpio35,
                 dectpd_grp, vdsl_phy_override_0_grp,
                 vdsl_phy_override_1_grp, vdsl_phy_override_2_grp,
                 vdsl_phy_override_3_grp, dsl_gpio8, dsl_gpio9 ]
 
+    patternProperties:
+      '-pins$':
+        $ref: '#/patternProperties/-pins$'
+
 allOf:
   - $ref: pinctrl.yaml#
 
@@ -122,46 +127,46 @@ examples:
 
       pinctrl_nand: nand-pins {
         function = "nand";
-        group = "nand_grp";
+        pins = "nand_grp";
       };
 
       pinctrl_gpio35_alt: gpio35_alt-pins {
         function = "gpio35_alt";
-        pin = "gpio35";
+        pins = "gpio35";
       };
 
       pinctrl_dectpd: dectpd-pins {
         function = "dectpd";
-        group = "dectpd_grp";
+        pins = "dectpd_grp";
       };
 
       pinctrl_vdsl_phy_override_0: vdsl_phy_override_0-pins {
         function = "vdsl_phy_override_0";
-        group = "vdsl_phy_override_0_grp";
+        pins = "vdsl_phy_override_0_grp";
       };
 
       pinctrl_vdsl_phy_override_1: vdsl_phy_override_1-pins {
         function = "vdsl_phy_override_1";
-        group = "vdsl_phy_override_1_grp";
+        pins = "vdsl_phy_override_1_grp";
       };
 
       pinctrl_vdsl_phy_override_2: vdsl_phy_override_2-pins {
         function = "vdsl_phy_override_2";
-        group = "vdsl_phy_override_2_grp";
+        pins = "vdsl_phy_override_2_grp";
       };
 
       pinctrl_vdsl_phy_override_3: vdsl_phy_override_3-pins {
         function = "vdsl_phy_override_3";
-        group = "vdsl_phy_override_3_grp";
+        pins = "vdsl_phy_override_3_grp";
       };
 
       pinctrl_dsl_gpio8: dsl_gpio8-pins {
         function = "dsl_gpio8";
-        group = "dsl_gpio8";
+        pins = "dsl_gpio8";
       };
 
       pinctrl_dsl_gpio9: dsl_gpio9-pins {
         function = "dsl_gpio9";
-        group = "dsl_gpio9";
+        pins = "dsl_gpio9";
       };
     };
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml
index 2750ba42aeb8..f57bb34c3130 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml
@@ -24,6 +24,7 @@ patternProperties:
   '-pins$':
     type: object
     $ref: pinmux-node.yaml#
+    unevaluatedProperties: false
 
     properties:
       function:
@@ -36,6 +37,10 @@ patternProperties:
                 gpio20, gpio25, gpio26, gpio27, gpio28, hsspi_cs1,
                 usb_port1 ]
 
+    patternProperties:
+      '-pins$':
+        $ref: '#/patternProperties/-pins$'
+
 allOf:
   - $ref: pinctrl.yaml#
 
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml
index 2f6c540498bc..ce6fc5380c52 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml
@@ -24,15 +24,16 @@ patternProperties:
   '-pins$':
     type: object
     $ref: pinmux-node.yaml#
+    unevaluatedProperties: false
 
     properties:
       function:
         enum: [ ebi_cs, uart1, serial_led, legacy_led, led, spi_cs, utopia,
                 pwm_syn_clk, sys_irq ]
 
-      pins:
+      groups:
         enum: [ ebi_cs_grp, uart1_grp, serial_led_grp, legacy_led_grp,
-                led_grp, spi_cs_grp, utopia_grp, pwm_syn_clk, sys_irq_grp ]
+                led_grp, spi_cs_grp, utopia_grp, pwm_syn_clk_grp, sys_irq_grp ]
 
 allOf:
   - $ref: pinctrl.yaml#
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml
index b3044f805753..5f7ed7d3dd49 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml
@@ -24,6 +24,7 @@ patternProperties:
   '-pins$':
     type: object
     $ref: pinmux-node.yaml#
+    unevaluatedProperties: false
 
     properties:
       function:
@@ -41,6 +42,10 @@ patternProperties:
                 gpio15, gpio16, gpio17, gpio18, gpio19, gpio20, gpio21,
                 gpio22, gpio23, gpio24, gpio25, gpio26, gpio27, nand_grp ]
 
+    patternProperties:
+      '-pins$':
+        $ref: '#/patternProperties/-pins$'
+
 allOf:
   - $ref: pinctrl.yaml#
 
@@ -204,6 +209,6 @@ examples:
 
       pinctrl_nand: nand-pins {
         function = "nand";
-        group = "nand_grp";
+        pins = "nand_grp";
       };
     };
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml
index 3236871827df..d549e945505b 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml
@@ -24,6 +24,7 @@ patternProperties:
   '-pins$':
     type: object
     $ref: pinmux-node.yaml#
+    unevaluatedProperties: false
 
     properties:
       function:
@@ -42,6 +43,10 @@ patternProperties:
                 gpio24, gpio25, gpio26, gpio27, gpio28, gpio29, gpio30,
                 gpio31, uart1_grp ]
 
+    patternProperties:
+      '-pins$':
+        $ref: '#/patternProperties/-pins$'
+
 allOf:
   - $ref: pinctrl.yaml#
 
@@ -215,6 +220,6 @@ examples:
 
       pinctrl_uart1: uart1-pins {
         function = "uart1";
-        group = "uart1_grp";
+        pins = "uart1_grp";
       };
     };
-- 
2.42.0

