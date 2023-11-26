Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60EE7F90C3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 02:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjKZByL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 20:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjKZBx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 20:53:56 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4246F127;
        Sat, 25 Nov 2023 17:54:02 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b402c36c4so4846115e9.1;
        Sat, 25 Nov 2023 17:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700963641; x=1701568441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9LJN1mgEySGU8oKiT605MgEBGzWasHtQXxakyyFMOs=;
        b=XiucdMfRYBJ8vYdwYrANxC4qfVvI6vh0Wfge/UgxK1ZLHPsx679AzKz/y+jA7sVH8y
         0kxX1+fYoodNxRZNfG+wMnr/Pn6x4+ZvC3w7XdeHRNd34iGuubIDQpT4zEbgfciT1zir
         YUs+y8SzOSX5yyZLzz7cuWSqRoplqg/NZKlzjh7qtcYDZ9dnBk7Iag/3O6KiXdAEZpdh
         sTBXzL7Dv1mm5RrgLtx+TbB92kce7yM9r2Xe+/pMFSQPBtAr7tOeAFxhEfnLtsiAtPQX
         rrXiLBduEV5kAua6xSLWYSjcYoP3utWgGfq/McU/o4A7w7GbnFp4sMUoNXjFnF5mR0o4
         V8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700963641; x=1701568441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9LJN1mgEySGU8oKiT605MgEBGzWasHtQXxakyyFMOs=;
        b=GfPWlbGUrHPguGh/EwU6RfRy8bjxUweYSOxcb88V28EKivFrmKGEC2Xb7Rrm0XlhAw
         BXm+slJaVcdGf15wwGCboZWjRR2ydJwIGQsmJYMtTBPAsZiUujy284CVSueCgZBqxDdl
         7W81kwL+pP6kFbGF5+j6i6qs3vmsKU9444O4z0yGXWesyLoJdFMooitiqb0FK25mLlsP
         2736Qtye9rzYNdT/ddlSPt9+JIPWb2oZKYDq0pMO4x2/L7Ge0p5r2YPNG39bWCMQKANC
         E0hcglsANHtmBfgcPiTTA+YKPAvpN66r8dBhBA6vZNl9ZKfUM0zlhCZ76fUvzQcGnqIR
         XH3w==
X-Gm-Message-State: AOJu0YwWgqll9U51EBQVyTh89yaMOdxRsEIb/MzTAqT+IcDWlHjTXiBn
        YqeE5x250U5QHkZN+ZI7s0k=
X-Google-Smtp-Source: AGHT+IEOlkdnWzLr3V/+uJg7PbiQse/jLD1AEgl68HSLlLB3UbwFYW+kAXv5TWq8sfRQ24c7VP3WoQ==
X-Received: by 2002:a05:600c:4687:b0:40b:36e9:b84a with SMTP id p7-20020a05600c468700b0040b36e9b84amr5561233wmo.23.1700963640552;
        Sat, 25 Nov 2023 17:54:00 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id p34-20020a05600c1da200b00406408dc788sm9875344wms.44.2023.11.25.17.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 17:54:00 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next PATCH RFC v3 6/8] dt-bindings: net: Document Qcom QCA807x PHY package
Date:   Sun, 26 Nov 2023 02:53:44 +0100
Message-Id: <20231126015346.25208-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126015346.25208-1-ansuelsmth@gmail.com>
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Qcom QCA807x PHY package.

Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
1000BASE-T PHY-s.

Document the required property to make the PHY package correctly
configure and work.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/net/qcom,qca807x.yaml | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,qca807x.yaml

diff --git a/Documentation/devicetree/bindings/net/qcom,qca807x.yaml b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
new file mode 100644
index 000000000000..136ba2128b73
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qcom,qca807x.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qcom,qca807x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCA807X Ethernet PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+  - Robert Marko <robert.marko@sartura.hr>
+
+description: |
+  Qualcomm QCA807X Ethernet PHY is PHY package of 2 or 5
+  IEEE 802.3 clause 22 compliant 10BASE-Te, 100BASE-TX and
+  1000BASE-T PHY-s.
+
+  They feature 2 SerDes, one for PSGMII or QSGMII connection with
+  MAC, while second one is SGMII for connection to MAC or fiber.
+
+  Both models have a combo port that supports 1000BASE-X and
+  100BASE-FX fiber.
+
+  Each PHY inside of QCA807x series has 4 digitally controlled
+  output only pins that natively drive LED-s for up to 2 attached
+  LEDs. Some vendor also use these 4 output for GPIO usage without
+  attaching LEDs.
+
+  Note that output pins can be set to drive LEDs OR GPIO, mixed
+  definition are not accepted.
+
+  PHY package can be configured in 3 mode following this table:
+
+                First Serdes mode       Second Serdes mode
+  Option 1      PSGMII for copper       Disabled
+                ports 0-4
+  Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
+                ports 0-4
+  Option 3      QSGMII for copper       SGMII for
+                ports 0-3               copper port 4
+
+$ref: ethernet-phy-package.yaml#
+
+properties:
+  qcom,package-mode:
+    enum:
+      - qsgmii
+      - psgmii
+
+  qcom,tx-driver-strength:
+    description: set the TX Amplifier value in mv.
+      If not defined, 600mw is set by default.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [140, 160, 180, 200, 220,
+           240, 260, 280, 300, 320,
+           400, 500, 600]
+
+patternProperties:
+  ^ethernet-phy(@[a-f0-9]+)?$:
+    $ref: ethernet-phy.yaml#
+
+    properties:
+      gpio-controller:
+        description: set the output lines as GPIO instead of LEDs
+        type: boolean
+
+      '#gpio-cells':
+        description: number of GPIO cells for the PHY
+        const: 2
+
+    dependencies:
+      gpio-controller: ['#gpio-cells']
+
+    if:
+      required:
+        - gpio-controller
+    then:
+      properties:
+        leds: false
+
+    unevaluatedProperties: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy-package@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "ethernet-phy-package";
+            reg = <0>;
+
+            qcom,package-mode = "qsgmii";
+
+            ethernet-phy@0 {
+                reg = <0>;
+
+                leds {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    led@0 {
+                        reg = <0>;
+                        color = <LED_COLOR_ID_GREEN>;
+                        function = LED_FUNCTION_LAN;
+                        default-state = "keep";
+                    };
+                };
+            };
+
+            ethernet-phy@1 {
+                reg = <1>;
+            };
+
+            ethernet-phy@2 {
+                reg = <2>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            ethernet-phy@3 {
+                reg = <3>;
+            };
+
+            ethernet-phy@4 {
+                reg = <4>;
+            };
+        };
+    };
-- 
2.40.1

