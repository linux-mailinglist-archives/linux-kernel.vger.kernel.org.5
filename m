Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D197CD77E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjJRJEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjJRJEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:04:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A853F106
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:03:59 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a62d4788so5804014e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697619838; x=1698224638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAoLwGOze8wrOhHWHJbCc0YbKSQgR6L56yNHOLOvQxY=;
        b=Hqx+8bz+mbRZpLdEyv8DsMIVX0ffYm4VBpOn1diY0DqeY39Nm4XWIiqUy5dlRFg7z9
         BmhGUq57UNe8BlxFrYl2YmfAtYP8MJwfZ88CYO/tOqqGMZ0aLNGr83qWfsBquLTX/VQV
         kImUsuGLtbJPjp4PouvN2PpPEuv7NoYXb8Mnbc3NdLLNx+PkbHdmp7dApZVI3BdcbezK
         /arcicAxZeXiHKmrbAey1hXlZ5wjXE+V36FG/LCrsStnVy8d9jY1ZD274AdipgSLQ345
         uYbzHNfGQvFbFvpOJ9lw+N+iwwMf0J2ZY2/a0ItaG6Wwab1yKGNs3sy3UGSTFFeAdqqU
         +ARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619838; x=1698224638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAoLwGOze8wrOhHWHJbCc0YbKSQgR6L56yNHOLOvQxY=;
        b=oD3SsZg5HiSs+jITQhFlThXYEvANJWnKsyd0cZFKgrBo0Yiivpl5lT4i7NLvRt/pj/
         5G6RyoCyZHbot1Hd27E61BbmjwsUNBowWTXKrwNGF4WdMaTWoDGyZ7FLfMgnugwmNfN7
         3vDJLRW5E57Yt1IbeRjdnT9FSkMFfcZouX5tM3W5z+dg5FevL8/FKMFMX6y0M+z1nd92
         ooCB8VRoQRk+5GqYqUnpzDq8v1jUcWcze3E+COO95U9jwFGkDT+eWCY0g9vdYE8HHZxB
         a/9+xUidn/dQCaPo2VfgNEO+ZZE2+K8l4EwdIR6R0xnGQ/j9/G6I1GUqU6EsbdscAtpk
         tP+w==
X-Gm-Message-State: AOJu0YwdcpA9dkCzGLBJ8xHEV3vF+oy0NspLMOgsKURbHufjK7hNpliq
        LZR/jfRrFdFQo23fDtmpHM0o5w==
X-Google-Smtp-Source: AGHT+IFywDCVE3gR9Ux7ZEHzkzY3P0TiOBmbo31y8MNAxSg0CIiSz1/kLuYvTQ7JGVxBY5mY6rQWoQ==
X-Received: by 2002:a05:6512:304c:b0:507:8c55:39f9 with SMTP id b12-20020a056512304c00b005078c5539f9mr4283817lfb.49.1697619837993;
        Wed, 18 Oct 2023 02:03:57 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w19-20020a05651234d300b005056fb1d6fbsm616595lfr.238.2023.10.18.02.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:03:57 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Oct 2023 11:03:46 +0200
Subject: [PATCH net-next v4 7/7] dt-bindings: marvell: Add Marvell
 MV88E6060 DSA schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-marvell-88e6152-wan-led-v4-7-3ee0c67383be@linaro.org>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
In-Reply-To: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell MV88E6060 is one of the oldest DSA switches from
Marvell, and it has DT bindings used in the wild. Let's define
them properly.

It is different enough from the rest of the MV88E6xxx switches
that it deserves its own binding.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/net/dsa/marvell,mv88e6060.yaml        | 90 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6060.yaml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6060.yaml
new file mode 100644
index 000000000000..787f328551f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6060.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6060.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MV88E6060 DSA switch
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+
+description:
+  The Marvell MV88E6060 switch has been produced and sold by Marvell
+  since at least 2010. The switch has one pin ADDR4 that controls the
+  MDIO address of the switch to be 0x10 or 0x00, and on the MDIO bus
+  connected to the switch, the PHYs inside the switch appear as
+  independent devices on address 0x00-0x04 or 0x10-0x14, so in difference
+  from many other DSA switches this switch does not have an internal
+  MDIO bus for the PHY devices.
+
+properties:
+  compatible:
+    const: marvell,mv88e6060
+    description:
+      The MV88E6060 is the oldest Marvell DSA switch product, and
+      as such a bit limited in features compared to later hardware.
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      GPIO to be used to reset the whole device
+    maxItems: 1
+
+$ref: dsa.yaml#
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-switch@16 {
+            compatible = "marvell,mv88e6060";
+            reg = <16>;
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                };
+                port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                };
+                port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                };
+                port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                };
+                port@5 {
+                    reg = <5>;
+                    phy-mode = "rev-mii";
+                    ethernet = <&ethc>;
+                    fixed-link {
+                        speed = <100>;
+                        full-duplex;
+                    };
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1b4475254d27..4c933a2a56ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12625,6 +12625,7 @@ MARVELL 88E6XXX ETHERNET SWITCH FABRIC DRIVER
 M:	Andrew Lunn <andrew@lunn.ch>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/marvell,mv88e6060.yaml
 F:	Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
 F:	Documentation/networking/devlink/mv88e6xxx.rst
 F:	drivers/net/dsa/mv88e6xxx/

-- 
2.34.1

