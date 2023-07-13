Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFF8751913
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjGMGus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjGMGuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:50:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2C199D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:50:45 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3142ee41fd2so447413f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689231043; x=1691823043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lsLSipOcSaG+ttZ4C/xw7qbwKyOndX7eVBkHDKM4U7A=;
        b=SwAs79Le2wRpMXESFtlNh4zQ9gwsStqPzNfZKUByvY2yKboUdXmCbG7o1TOZUvEk2J
         YWQs0AYOgOHBXh2z4jAhx5FPKquA0F5A4NN5uY5ayMAgrrJNogcc2yikcUmFEi1+tzdr
         Exe+I4qHooTEjfmH0u85NNea/fBq4aA4tafamxk98eVS7oTeQTDemWNurA6iP3fBRIBB
         C9i68ojDCWwffMCL1DZ55xhJhALSWK8QxgVCeS6PxmuJv6jdY0cxWjzFHsjXYWXsZrQz
         AOCE1PrHCW16NNcUhFjcrc6SntDaXZPEj3IRY+q3gRDMgzUkyN+gfwE55FAWeqk1xesM
         VV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689231043; x=1691823043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsLSipOcSaG+ttZ4C/xw7qbwKyOndX7eVBkHDKM4U7A=;
        b=bosFZU5aMULIWT3beb5GAlEhkAAQK2hvyJWV71XiPnuox9UA1kue/JN/fx3/qQnnkr
         e1ofBV0SznB3u/mT9r6JufENH45rTYeDT3cOndvZ1ffR73WQQTZKhLkaAKrnzMYO1IpQ
         IKMOg5v6lEMyJ7W/uWKNQjLAZg1/7nDEdL28DqO5FUkY43UkGx0HbFi8es05xRJxCjOr
         sMJ9SeDVDXW25nVXvaIf3lpzbznd5J8ifQk0bO4iunUNXh2P3Z4DeINQ649vC765gSXD
         YFZN+Mo/+ctr81KPRd7frvCXgEUUDTkvM6Og1O80obc4oGwDKdRH/B0GYLA6oM1A5jUA
         lsEA==
X-Gm-Message-State: ABy/qLaA6WCvzOXiQuHWXFkclyvk3vyBtZnOXZJ0QMQVEJ53goqgVDiu
        AJTrxxe9RtbLVgiPcNSPw2xuFw==
X-Google-Smtp-Source: APBJJlHFLOu1DNHLics6ts9Ef0cnDcY7GppD+vmxVYA1owLOuajnoKc7j9XR2JFNVYq919LFgAx0bQ==
X-Received: by 2002:adf:ef0b:0:b0:315:9021:6dc3 with SMTP id e11-20020adfef0b000000b0031590216dc3mr610521wro.27.1689231043487;
        Wed, 12 Jul 2023 23:50:43 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id q21-20020a7bce95000000b003fc06169abdsm6948298wmj.2.2023.07.12.23.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 23:50:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH] dt-bindings: mfd: brcm: drop unneeded quotes and use absolute /schemas path
Date:   Thu, 13 Jul 2023 08:50:40 +0200
Message-Id: <20230713065040.7968-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.  Also absolute path
starting with /schemas is preferred.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Rebase and resend. Dependencies were merged in v6.5-rc1.

 .../devicetree/bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml     | 4 ++--
 .../devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml    | 4 ++--
 .../devicetree/bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml     | 4 ++--
 .../devicetree/bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml     | 4 ++--
 .../devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml     | 4 ++--
 .../devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml     | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml
index 9f9a14af875e..cb480162f967 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml
@@ -35,7 +35,7 @@ patternProperties:
   "^gpio@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../gpio/brcm,bcm63xx-gpio.yaml"
+    $ref: /schemas/gpio/brcm,bcm63xx-gpio.yaml
     description:
       GPIO controller for the SoC GPIOs. This child node definition
       should follow the bindings specified in
@@ -44,7 +44,7 @@ patternProperties:
   "^pinctrl@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../pinctrl/brcm,bcm6318-pinctrl.yaml"
+    $ref: /schemas/pinctrl/brcm,bcm6318-pinctrl.yaml
     description:
       Pin controller for the SoC pins. This child node definition
       should follow the bindings specified in
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
index 803277dd2725..c14def1b2ad2 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
@@ -35,7 +35,7 @@ patternProperties:
   "^gpio@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../gpio/brcm,bcm63xx-gpio.yaml"
+    $ref: /schemas/gpio/brcm,bcm63xx-gpio.yaml
     description:
       GPIO controller for the SoC GPIOs. This child node definition
       should follow the bindings specified in
@@ -44,7 +44,7 @@ patternProperties:
   "^pinctrl@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../pinctrl/brcm,bcm63268-pinctrl.yaml"
+    $ref: /schemas/pinctrl/brcm,bcm63268-pinctrl.yaml
     description:
       Pin controller for the SoC pins. This child node definition
       should follow the bindings specified in
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml
index b9a6856ce970..5f48209ed40f 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml
@@ -35,7 +35,7 @@ patternProperties:
   "^gpio@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../gpio/brcm,bcm63xx-gpio.yaml"
+    $ref: /schemas/gpio/brcm,bcm63xx-gpio.yaml
     description:
       GPIO controller for the SoC GPIOs. This child node definition
       should follow the bindings specified in
@@ -44,7 +44,7 @@ patternProperties:
   "^pinctrl@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../pinctrl/brcm,bcm6328-pinctrl.yaml"
+    $ref: /schemas/pinctrl/brcm,bcm6328-pinctrl.yaml
     description:
       Pin controller for the SoC pins. This child node definition
       should follow the bindings specified in
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml
index 4651fe4dde07..f1f4629565d9 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml
@@ -35,7 +35,7 @@ patternProperties:
   "^gpio@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../gpio/brcm,bcm63xx-gpio.yaml"
+    $ref: /schemas/gpio/brcm,bcm63xx-gpio.yaml
     description:
       GPIO controller for the SoC GPIOs. This child node definition
       should follow the bindings specified in
@@ -44,7 +44,7 @@ patternProperties:
   "^pinctrl@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../pinctrl/brcm,bcm6358-pinctrl.yaml"
+    $ref: /schemas/pinctrl/brcm,bcm6358-pinctrl.yaml
     description:
       Pin controller for the SoC pins. This child node definition
       should follow the bindings specified in
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml
index 0330b621fd38..4d594739b382 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml
@@ -35,7 +35,7 @@ patternProperties:
   "^gpio@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../gpio/brcm,bcm63xx-gpio.yaml"
+    $ref: /schemas/gpio/brcm,bcm63xx-gpio.yaml
     description:
       GPIO controller for the SoC GPIOs. This child node definition
       should follow the bindings specified in
@@ -44,7 +44,7 @@ patternProperties:
   "^pinctrl@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../pinctrl/brcm,bcm6362-pinctrl.yaml"
+    $ref: /schemas/pinctrl/brcm,bcm6362-pinctrl.yaml
     description:
       Pin controller for the SoC pins. This child node definition
       should follow the bindings specified in
diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml
index 82d3e4415bda..aae83d432880 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml
@@ -35,7 +35,7 @@ patternProperties:
   "^gpio@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../gpio/brcm,bcm63xx-gpio.yaml"
+    $ref: /schemas/gpio/brcm,bcm63xx-gpio.yaml
     description:
       GPIO controller for the SoC GPIOs. This child node definition
       should follow the bindings specified in
@@ -44,7 +44,7 @@ patternProperties:
   "^pinctrl@[0-9a-f]+$":
     # Child node
     type: object
-    $ref: "../pinctrl/brcm,bcm6368-pinctrl.yaml"
+    $ref: /schemas/pinctrl/brcm,bcm6368-pinctrl.yaml
     description:
       Pin controller for the SoC pins. This child node definition
       should follow the bindings specified in
-- 
2.34.1

