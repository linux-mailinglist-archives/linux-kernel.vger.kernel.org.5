Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026F080B18F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574941AbjLIBsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjLIBsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:48:31 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89455E3;
        Fri,  8 Dec 2023 17:48:37 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c39e936b4so4022705e9.1;
        Fri, 08 Dec 2023 17:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702086516; x=1702691316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5TEoN9vdBbfGAJM/hB7+1BTZHwjSbPnt7yiTcrzTj8=;
        b=hXOgtvFLcBvivpUwVYMwm5L6MDNM+kaQ3Zy7eUMIu7ORLBQimNWl8CouKnm+alvD99
         1YBrA6aa5eHoGRWv6/Bn+uc/9T6NDfaBqOZzgZmVvZA92gbbyx/pQ8e7vhLY9jsveHUP
         ZhJojQA+sWWgMvzZwWun4hgAbg+O0vYrQ0KULvfjmJqAeSSQQYoCuX/GIOxwu3C7UuYn
         b4cwGgS//DsUAdf7S4ZbzimJDhuV4Vm2OhrDl22JAKplBL+wQn5/w27kD3yNuelf8EBc
         S6f42bUIVYEiTfXtNzBNokc3SmETDd/4i6SIsjORlBIJPU6Rfdh9WBELQFXwLOk6vFVL
         eUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702086516; x=1702691316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5TEoN9vdBbfGAJM/hB7+1BTZHwjSbPnt7yiTcrzTj8=;
        b=JTnmO/63q91bTZzf7UsjLw6JOBd7F6pyntJAe+hrSKCI7U8iW3oITyV1vpwJOFLmzM
         pozWxJkgtqqs29YW480G3uSEjTwUntgRb4PMShF+2FGPvaqu/DNt4glX5ghtJiBe3vDU
         k4PZnrBcCXcJ/5HrfwZYmeDgfqz8DJnE2hH21Tz7QyQxUtZKU13kU0vGvcEJ9JZ3VEXf
         hg9De9ssVgZK8qIGTpalEuPKntWlm7h/bcgzbz7NgFz2RdNGGipZdSYGu82du4/955XY
         Tw4NruC25SVk0cwkgFMqXNvO4mPyu3501bg6h8eUgrtUXTOcTYkdIzBaociv/7QRGX5f
         nSlw==
X-Gm-Message-State: AOJu0Yw1f2D5Lob7pENCisoYxp+VjPb3wly8MN4ibvlllQoHUa09F/PO
        MusO9iPacWj47w26dxmXNLo=
X-Google-Smtp-Source: AGHT+IHt7khlaVyNJ786ZfNWjEYzbl2gYMNhEnAwlIuVvPoveCgGqGVZ/sslT2rtJ+yo9gHGswDr9Q==
X-Received: by 2002:a05:600c:1ca7:b0:40b:5e59:f726 with SMTP id k39-20020a05600c1ca700b0040b5e59f726mr202635wms.152.1702086515720;
        Fri, 08 Dec 2023 17:48:35 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id n18-20020a05600c501200b0040c26a459b4sm1218118wmr.0.2023.12.08.17.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 17:48:35 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Christian Marangi <ansuelsmth@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH 1/2] dt-bindings: Document QCA808x PHYs
Date:   Sat,  9 Dec 2023 02:48:27 +0100
Message-Id: <20231209014828.28194-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Add Documentation for QCA808x PHYs for the additional property for the
active high LED setting and also document the LED configuration for this
PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/net/qca,qca808x.yaml  | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml

diff --git a/Documentation/devicetree/bindings/net/qca,qca808x.yaml b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
new file mode 100644
index 000000000000..73cfff357311
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qca,qca808x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Atheros QCA808X PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Bindings for Qualcomm Atheros QCA808X PHYs
+
+  QCA808X PHYs can have up to 3 LEDs attached.
+  All 3 LEDs are disabled by default.
+  2 LEDs have dedicated pins with the 3rd LED having the
+  double function of Interrupt LEDs/GPIO or additional LED.
+
+  By default this special PIN is set to LED function.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-id004d.d101
+  required:
+    - compatible
+
+properties:
+  qca,led-active-high:
+    description: Set all the LEDs to active high to be turned on.
+    type: boolean
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
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-id004d.d101";
+            reg = <0>;
+            qca,led-active-high;
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_WAN;
+                    default-state = "keep";
+                };
+            };
+        };
+    };
-- 
2.40.1

