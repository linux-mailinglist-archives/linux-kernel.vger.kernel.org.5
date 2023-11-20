Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56C57F14C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjKTNvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjKTNvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:51:22 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D05E126;
        Mon, 20 Nov 2023 05:51:18 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c5b7764016so53079351fa.1;
        Mon, 20 Nov 2023 05:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700488276; x=1701093076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSkXFy8s0m4FAo3hSta1RKyG8KAPqujjDp76lrQjrQM=;
        b=dIAJDECFtovM/SqF68vyMyKsts4M+lf79QkH/pCP22SLdmmmGHLLZ1eJ7qC2dEAzI/
         kjgf6qiq8UVTe3qjqohF1ukPaB5fKv19SJcupSZxU8zvAtWAFWExY4M48cQdsG7MJ/Qe
         zlNN6WHPjbmR5Ya1X6mGNKgnswouIoA7SRx7o+gCPtuP+E0S4OMHewkK+xYnJER0gj0i
         ny8/IxRggIVSBLnE/gcD0MJ7QrtEdw++k0+U2buDeP8N7RpROXej3aslqlJcDWS3U1N6
         cldVDOvRj1L7WD6KNLRT/SrEb4uyx5Jb2tOb9BFXGtLtzRH5pEJTB0ihOTBFNhFIgoCe
         WK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488276; x=1701093076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSkXFy8s0m4FAo3hSta1RKyG8KAPqujjDp76lrQjrQM=;
        b=eIeqSH555xEJ5PiHh+TI0F8nGGQ9n1zABnFgDFb+r5kTLB5Xj4jKzqJzipuL8xCgbP
         OYRi/MHDZ5jFu2uIVLBgGs+HpT1WCeFP6r5FBxf0SEfNitnUFV0O2ndwigMCfGvqPSRf
         8m4wxtNQyce6Rniq/AxTNLhYoU3BN6kxUA+jbknzReXvBjDzUmbyQC3AZMiEiKK3WvEC
         1pvubN/t+ZVkYlpSyHwZz7uZG06sh9kyPE/rEkOqtZt6OlDoNM3tQKUTCRT4j9+4kghB
         /uu2+ihTKcCOWdtbJ9UrLghQWRhQp0yCLFJiwRVQPjuWnWvMNWMxgCxf851p9qUot/4Z
         sNlw==
X-Gm-Message-State: AOJu0YzVOIppXrVzxjXmaqQsV/twC7bzZ9EHXQoZR3aavxPsVSVOSO4M
        YAZIj882jsE20wyqSEMGfV0=
X-Google-Smtp-Source: AGHT+IGRWPskxjGA2rJREXkXtdcG94gsGR4fcmJx18lPkb4K8zHD6Ut0hUV6FgYsk/XQHGBG6tApZg==
X-Received: by 2002:a2e:9192:0:b0:2c5:2eaa:5398 with SMTP id f18-20020a2e9192000000b002c52eaa5398mr4967418ljg.25.1700488276123;
        Mon, 20 Nov 2023 05:51:16 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j33-20020a05600c1c2100b0040772934b12sm18205846wms.7.2023.11.20.05.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 05:51:15 -0800 (PST)
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        Simon Horman <horms@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH 03/14] dt-bindings: net: document ethernet PHY package nodes
Date:   Mon, 20 Nov 2023 14:50:30 +0100
Message-Id: <20231120135041.15259-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231120135041.15259-1-ansuelsmth@gmail.com>
References: <20231120135041.15259-1-ansuelsmth@gmail.com>
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

Document ethernet PHY package nodes used to describe PHY shipped in
bundle of 4-5 PHY. These particular PHY require specific PHY in the
package for global onfiguration of the PHY package.

Example are PHY package that have some regs only in one PHY of the
package and will affect every other PHY in the package, for example
related to PHY interface mode calibration or global PHY mode selection.

The PHY package node should use the global-phys property and the
global-phy-names to define PHY in the package required by the PHY driver
for global configuration.

It's also possible to specify the property phy-mode to specify that the
PHY package sets a global PHY interface mode and every PHY of the
package requires to have the same PHY interface mode.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/ethernet-phy-package.yaml    | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-phy-package.yaml

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
new file mode 100644
index 000000000000..2aa109e155d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ethernet-phy-package.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ethernet-phy-package.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ethernet PHY Package Common Properties
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com
+
+properties:
+  $nodename:
+    pattern: "^ethernet-phy-package(-[0-9]+)?$"
+
+  compatible:
+    const: ethernet-phy-package
+
+  '#address-cells':
+    description: number of address cells for the MDIO bus
+    const: 1
+
+  '#size-cells':
+    description: number of size cells on the MDIO bus
+    const: 0
+
+  global-phys:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 31
+    description:
+      List of phandle to the PHY in the package required and
+      used to configure the PHY package.
+
+  global-phy-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    minItems: 1
+    maxItems: 31
+    description:
+      List of names of the PHY defined in global-phys.
+
+  phy-connection-type:
+    $ref: /schemas/net/ethernet-phy-mode-types.yaml#definitions/phy-connection-type
+    description:
+      Specifies global interface type for the PHY package.
+
+  phy-mode:
+    $ref: "#/properties/phy-connection-type"
+
+patternProperties:
+  ^ethernet-phy(@[a-f0-9]+)?$:
+    $ref: /schemas/net/ethernet-phy.yaml#
+
+required:
+  - compatible
+
+dependencies:
+  global-phy-names: [global-phys]
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy-package {
+            compatible = "ethernet-phy-package";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            global-phys = <&phy4>;
+            global-phy-names = "base";
+
+            ethernet-phy@1 {
+              compatible = "ethernet-phy-ieee802.3-c22";
+              reg = <1>;
+            };
+
+            phy4: ethernet-phy@4 {
+              compatible = "ethernet-phy-ieee802.3-c22";
+              reg = <4>;
+            };
+        };
+    };
-- 
2.40.1

