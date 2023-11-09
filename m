Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1961A7E6AF3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjKINHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKING7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:06:59 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24642D7D;
        Thu,  9 Nov 2023 05:06:56 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40859c466efso5656705e9.3;
        Thu, 09 Nov 2023 05:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699535215; x=1700140015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL9FI2uT5Jrru78i6MVf+2TGxRAUmPiO2FTbiOAD7ho=;
        b=HmDrIfww7hCvBG1zw8Ol+FOhMOXWQ/ZH00rrumBuZCE/8+t2VNSQsZGv1t1+FrpObP
         nn0SqVjfNCWoglCgar99zO/i51m7ITcFFdNzhuJHSRVMdLXPO8RFOTyd6PPew1z2YH7l
         kaC1z+sLdfm1GUREDJfwrpg+7Wb81H+dIHGHIpV6h/nHY/yQlppuvgQUaCCma9a2N5W3
         kvaFkPpy+QGBtd7E2QyVhV3j1l12u3A2XP8aG3kMF0KkHIBriFVbfGFaBuHTCShYGnUl
         +E9DllLqirsgSdtdDSwi19oM4S5fTUkVyZw/D11SvO42h720QLxWHtxCZtszc7uFM2ZC
         e+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699535215; x=1700140015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KL9FI2uT5Jrru78i6MVf+2TGxRAUmPiO2FTbiOAD7ho=;
        b=I/oraHqZbe7bDbrxrOf37+2caTYWWanDLifynE47ZJf/oxXKv5MlEUGHvaTggr3YSi
         EwF9Kvt3uergKVEiE2n8ILoeb5qx7a+HtoVso/iDCEfZxMY5zVYtpNqnc3GfDGJedRGs
         xSfQDjP4AypLRSMEnY/YX5SnBSvyzCCFuvHhgnAJ2G1GHSM1x1U0xcbtfwLUlhOe8+He
         qSCJNipYV/XGfCaU80Hc5L1Jd9bf7/t2SiHw8s3/yktrH+GGBFK/ZGasGddM7wH+cStN
         oxTpT2FRvxp28TYk6FzaR3QjPoW/V9CjwVuBDmTF6UWqOcXw1UDy7Vj+kQzBYri1V/c5
         ISUw==
X-Gm-Message-State: AOJu0YwEfIGiG8ystJ7MbDoxn+ww4QX7nzV3G9EtjN+VKb3ezJ29Ka0d
        0uFmGvPSy9NG3t3VxkXwZRc=
X-Google-Smtp-Source: AGHT+IGzKbD1Kv5hsz8aRxLdUv99I9bzk3gdeQ+ntFTzZGCLbBg9mT/5lGMXT8XHOpiLGkAkv99QNg==
X-Received: by 2002:a1c:7507:0:b0:409:8e0:69f4 with SMTP id o7-20020a1c7507000000b0040908e069f4mr4364794wmc.21.1699535214558;
        Thu, 09 Nov 2023 05:06:54 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id v19-20020a05600c445300b0040813e14b49sm2095267wmn.30.2023.11.09.05.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:06:54 -0800 (PST)
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
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>
Subject: [net-next RFC PATCH v6 4/4] dt-bindings: Document Marvell Aquantia PHY
Date:   Thu,  9 Nov 2023 13:32:53 +0100
Message-Id: <20231109123253.3933-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231109123253.3933-1-ansuelsmth@gmail.com>
References: <20231109123253.3933-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for Marvell Aquantia PHY.

The Marvell Aquantia PHY require a firmware to work correctly and there
at least 3 way to load this firmware.

Describe all the different way and document the binding "firmware-name"
to load the PHY firmware from userspace.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes v6:
- Add Reviewed-by tag
- Drop comments in dts examples
- Improve commit title
- Fix wrong reg in example
Changes v5:
- Drop extra entry not related to HW description
Changes v3:
- Make DT description more OS agnostic
- Use custom select to fix dtbs checks
Changes v2:
- Add DT patch

 .../bindings/net/marvell,aquantia.yaml        | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/marvell,aquantia.yaml

diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
new file mode 100644
index 000000000000..68b2087a6722
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Aquantia Ethernet PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Marvell Aquantia Ethernet PHY require a firmware to be loaded to actually
+  work.
+
+  This can be done and is implemented by OEM in 3 different way:
+    - Attached SPI flash directly to the PHY with the firmware. The PHY
+      will self load the firmware in the presence of this configuration.
+    - Read from a dedicated partition on system NAND declared in an
+      NVMEM cell, and loaded to the PHY using its mailbox interface.
+    - Manually provided firmware loaded from a file in the filesystem.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-id03a1.b445
+          - ethernet-phy-id03a1.b460
+          - ethernet-phy-id03a1.b4a2
+          - ethernet-phy-id03a1.b4d0
+          - ethernet-phy-id03a1.b4e0
+          - ethernet-phy-id03a1.b5c2
+          - ethernet-phy-id03a1.b4b0
+          - ethernet-phy-id03a1.b662
+          - ethernet-phy-id03a1.b712
+          - ethernet-phy-id31c3.1c12
+  required:
+    - compatible
+
+properties:
+  reg:
+    maxItems: 1
+
+  firmware-name:
+    description: specify the name of PHY firmware to load
+
+  nvmem-cells:
+    description: phandle to the firmware nvmem cell
+    maxItems: 1
+
+  nvmem-cell-names:
+    const: firmware
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-id31c3.1c12",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <0>;
+            firmware-name = "AQR-G4_v5.4.C-AQR_CIG_WF-1945_0x8_ID44776_VER1630.cld";
+        };
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-id31c3.1c12",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <1>;
+            nvmem-cells = <&aqr_fw>;
+            nvmem-cell-names = "firmware";
+        };
+    };
+
+    flash {
+        compatible = "jedec,spi-nor";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partitions {
+            compatible = "fixed-partitions";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            /* ... */
+
+            partition@650000 {
+                compatible = "nvmem-cells";
+                label = "0:ethphyfw";
+                reg = <0x650000 0x80000>;
+                read-only;
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                aqr_fw: aqr_fw@0 {
+                    reg = <0x0 0x5f42a>;
+                };
+            };
+
+            /* ... */
+
+        };
+    };
-- 
2.40.1

