Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DCA7E0303
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376437AbjKCMf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376604AbjKCMfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:35:50 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64190D44;
        Fri,  3 Nov 2023 05:35:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-408382da7f0so14739555e9.0;
        Fri, 03 Nov 2023 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699014942; x=1699619742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjqMreabRsDRLtUlqL50Lj0Jf1Dc8tKq0A0FqOYk3vI=;
        b=gkfeMiHJ8yfnGQviQlRNGcvJaN/7EpRFQls3Al3RD4ThxVEvn5KZL6O3jTTwrcMWGE
         Tpzbk2jrRGH/pyFUV7wMKkHj5/dMIuw2PxnE5ghHEu3uDlFM2fyvypFguKZ06S69EVMD
         +0wZiYO4A0H6Vjetmv66IMiNiT562nIH/jfUfvytVKVkPsnV96wxVpxdKbX4q7DuQ6s6
         U8GjmF4bVJoNyS0vN5iZ7lUGgozGQl2w8ATSUCMfqppwrn6LFxGgnBI76N/sAyqca3OS
         is0F6Kcc9X/N6qQ1GZByBADhceuwrFL3+4CG6vGHs3VciXSGGOOGAv+QKvwfJdlJjYJ1
         CwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699014942; x=1699619742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjqMreabRsDRLtUlqL50Lj0Jf1Dc8tKq0A0FqOYk3vI=;
        b=BGxWQ7NRqwLI+c4ZRRXlZL4WhdLQFBjD2lpOszO3boRgnshQcdnzImwGtsXG4/b4ef
         g9KgijPhfN0wNHYub1Bog47ahgKrR8K8fuv42IRM90KIk8Ki2ZSTU1XQJ4ItSyCPQ7R4
         fYzsw9neThhLyCdlWAlX9rvtrXd++gJ8JPzwzlJXLFCy9gMgPcCwb1Czwr3b3ZUFQdEZ
         i4e3x4ckNvHyCkCTo5Fwqnl4sJNXnrl306jhvy77k4JP+DTwErFuGnsIx9xHLmMUNR9Q
         8EDYjXx6NrU3jDxmfI9LUtKyw+xIYKe/wqI3ikkuJxYs/mS1aUKIass0TT9wXMf2wLIH
         IVEg==
X-Gm-Message-State: AOJu0YzCus+E+3p8pXrVt4VU5dPD+lfivFmG6yCRdlwyyobPoNEN4kwf
        kspkE5g6XqE5m7IoOhCWbq8=
X-Google-Smtp-Source: AGHT+IHGs4gji+g2U4kBjOtwTYkojeV3TRMvObEl7gxzwYVM4E0/HGnyxcP2O2jk9DZbaKULABrriQ==
X-Received: by 2002:a05:600c:4e91:b0:408:4918:590e with SMTP id f17-20020a05600c4e9100b004084918590emr17031461wmq.39.1699014941674;
        Fri, 03 Nov 2023 05:35:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id gy14-20020a05600c880e00b00403b63e87f2sm2277014wmb.32.2023.11.03.05.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 05:35:41 -0700 (PDT)
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
Subject: [net-next RFC PATCH v4 4/4] dt-bindings: Document bindings for Marvell Aquantia PHY
Date:   Fri,  3 Nov 2023 13:35:32 +0100
Message-Id: <20231103123532.687-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231103123532.687-1-ansuelsmth@gmail.com>
References: <20231103123532.687-1-ansuelsmth@gmail.com>
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

Document bindings for Marvell Aquantia PHY.

The Marvell Aquantia PHY require a firmware to work correctly and there
at least 3 way to load this firmware.

Describe all the different way and document the binding "firmware-name"
to load the PHY firmware from userspace.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v3:
- Make DT description more OS agnostic
- Use custom select to fix dtbs checks
Changes v2:
- Add DT patch

 .../bindings/net/marvell,aquantia.yaml        | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/marvell,aquantia.yaml

diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
new file mode 100644
index 000000000000..d43cf28a4d61
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
@@ -0,0 +1,126 @@
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
+    - Attached SPI directly to the PHY with the firmware. The PHY will
+      self load the firmware in the presence of this configuration.
+    - Dedicated partition on system NAND with firmware in it. NVMEM
+      subsystem will be used and the declared NVMEM cell will load
+      the firmware to the PHY using the PHY mailbox interface.
+    - Manually provided firmware loaded from a file in the filesystem.
+
+  If declared, NVMEM will always take priority over filesystem provided
+  firmware.
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
+            /*  Only needed to make DT lint tools work. Do not copy/paste
+             *  into real DTS files.
+             */
+            compatible = "ethernet-phy-id31c3.1c12",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <0>;
+            firmware-name = "AQR-G4_v5.4.C-AQR_CIG_WF-1945_0x8_ID44776_VER1630.cld";
+        };
+
+        ethernet-phy@1 {
+            /*  Only needed to make DT lint tools work. Do not copy/paste
+             *  into real DTS files.
+             */
+            compatible = "ethernet-phy-id31c3.1c12",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <0>;
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

