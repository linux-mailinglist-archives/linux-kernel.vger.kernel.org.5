Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA7C805063
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346815AbjLEKgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbjLEKgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:36:18 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD80FA;
        Tue,  5 Dec 2023 02:36:18 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50be58a751cso3751510e87.2;
        Tue, 05 Dec 2023 02:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701772576; x=1702377376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkWrOF+Tbg1zeu9NCdUddDmIHRAWNVNjds7PaG64M2Y=;
        b=dhECj9SEn0QXSu+280gUsuYrqSz9ImOmUZ3gJkz1Tm6UwIFWnpBsUPNQlSzWOTePae
         kCr4tCo7iLAinJkySlmPMBuyJjLK6UzZt/3cNJy756zW1texvQzDtnZiFAAzeZ6D3kdm
         3m+ivo7d/cf7NDPrgnpfPS3P0xN2Rvmg5b3mesFbAtj1cSlMLobimp33ZraqtXntGT72
         lswud72j0Kh++G19v7Suh7N2C6ic9OTE0pM3bkPrLa0lDEndcTVVvog8nmyQZTuWZy1H
         +EwG3F7kkGrhj8Etu1q8dVYH+snv5OCcT2XPwoNO7T6IEJylqpe2wve8f7uBv+T8yvGT
         eodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701772576; x=1702377376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkWrOF+Tbg1zeu9NCdUddDmIHRAWNVNjds7PaG64M2Y=;
        b=YxhLuWChAvxhpl/YZtMFBfJE7Oz/8HXfXWZB5UD20gao/Qxibfkd1XsI/dSoNOwUYw
         NxbStR117YYDTuZM2RiX++3poa/cNdHC7m9gusZDD8OZplM6FIdGziJuRsbIgcOQs3NB
         P7wdzTZEH//TbPTN+OLuRzMAqHkWauDNYzSfoEtal70IQMPiL3H0Yp5wBItwobM1XL4b
         wosYoaAMADwWI6FgQjX9rsPehjKJNuXpO2I3ftZRs018q1Ot7iBsTj9IAlxzbFZ5okQi
         Oj+N8Nyb91hBYAHrHP9NlXDSxKSR0j/28FT28X56E2XLgKyFANm0Nbue18d33w049YOd
         nVog==
X-Gm-Message-State: AOJu0Yx+rD+XALkj/YW6stBofuqDO2q0EjXzWlzfymP5Y6lsSx6AeXwF
        13w8q7WfBMWCyPPR45FHUK4=
X-Google-Smtp-Source: AGHT+IHW1p9aU8tTY9sg91uEzIDkgdKT+nrzGfXjbWF3melerUTwy66MPZnO/elp4AuS+/rL2RSIaQ==
X-Received: by 2002:a05:6512:ac8:b0:50c:e6c:685a with SMTP id n8-20020a0565120ac800b0050c0e6c685amr187819lfu.124.1701772576328;
        Tue, 05 Dec 2023 02:36:16 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id fc5-20020a056512138500b0050bfbb6a388sm445422lfb.22.2023.12.05.02.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:36:15 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 08/16] dt-bindings: net: Add Synopsys DW xPCS bindings
Date:   Tue,  5 Dec 2023 13:35:29 +0300
Message-ID: <20231205103559.9605-9-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231205103559.9605-1-fancer.lancer@gmail.com>
References: <20231205103559.9605-1-fancer.lancer@gmail.com>
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

Synopsys DesignWare XPCS IP-core is a Physical Coding Sublayer (PCS) layer
providing an interface between the Media Access Control (MAC) and Physical
Medium Attachment Sublayer (PMA) through a Media independent interface.
From software point of view it exposes IEEE std. Clause 45 CSR space and
can be accessible either by MDIO or MCI/APB3 bus interfaces. The later
case is described by means of a dedicated DT-bindings which imply having
the DW XPCS Management Interface defined as a DT-supernode which child the
PCSs nodes would be (in the same way as the standard MDIO buses and
devices are normally defined).

Besides of that DW XPCS DT-nodes can have the interrupts and clock source
properties specified. The former one indicates the Clause 73/37
auto-negotiation events like: negotiation page received, AN is completed
or incompatible link partner. The clock DT-properties can describe up to
two clock sources: internal one and the one connected to the chip pad.
Either of them is supposed to be used as the device reference clocks.

Finally the DW XPCS IP-core can be optionally synthesized with a
vendor-specific interface connected to Synopsys PMA (also called
DesignWare Consumer/Enterprise PHY). Alas that isn't auto-detectable
anyhow so if the DW XPCS device has the respective PMA attached then it
should be reflected in the DT-node compatible string so the driver would
be aware of the PMA-specific device capabilities (mainly connected with
CSRs available for the fine-tunings).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 .../bindings/net/pcs/snps,dw-xpcs.yaml        | 88 +++++++++++++++++++
 .../bindings/net/snps,dw-xpcs-mi.yaml         | 88 +++++++++++++++++++
 2 files changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
 create mode 100644 Documentation/devicetree/bindings/net/snps,dw-xpcs-mi.yaml

diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
new file mode 100644
index 000000000000..9694ef51abad
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pcs/snps,dw-xpcs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare Ethernet PCS
+
+maintainers:
+  - Jose Abreu <Jose.Abreu@synopsys.com>
+
+description:
+  Synopsys DesignWare Ethernet Physical Coding Sublayer provides an interface
+  between Media Access Control and Physical Medium Attachment Sublayer through
+  the Media Independent Interface (XGMII, USXGMII, XLGMII, GMII, etc)
+  controlled by means of the IEEE std. Clause 45 registers set. The PCS can be
+  optionally synthesized with a vendor-specific interface connected to
+  Synopsys PMA (also called DesignWare Consumer/Enterprise PHY) although in
+  general it can be used to communicate with any compatible PHY.
+
+properties:
+  compatible:
+    oneOf:
+      - description: Synopsys DesignWare XPCS with none or unknown PMA
+        const: snps,dw-xpcs
+      - description: Synopsys DesignWare XPCS with Consumer Gen1 3G PMA
+        const: snps,dw-xpcs-gen1-3g
+      - description: Synopsys DesignWare XPCS with Consumer Gen2 3G PMA
+        const: snps,dw-xpcs-gen2-3g
+      - description: Synopsys DesignWare XPCS with Consumer Gen2 6G PMA
+        const: snps,dw-xpcs-gen2-6g
+      - description: Synopsys DesignWare XPCS with Consumer Gen4 3G PMA
+        const: snps,dw-xpcs-gen4-3g
+      - description: Synopsys DesignWare XPCS with Consumer Gen4 6G PMA
+        const: snps,dw-xpcs-gen4-6g
+      - description: Synopsys DesignWare XPCS with Consumer Gen5 10G PMA
+        const: snps,dw-xpcs-gen5-10g
+      - description: Synopsys DesignWare XPCS with Consumer Gen5 12G PMA
+        const: snps,dw-xpcs-gen5-12g
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      System interface interrupt output (sbd_intr_o) indicating Clause 73/37
+      auto-negotiation events like':' Page received, AN is completed or
+      incompatible link partner.
+    maxItems: 1
+
+  clocks:
+    description:
+      PCS/PMA interface be can clocked either by internal reference clock
+      source or by an externally connected (via a pad) clock generator.
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum: [ core, pad ]
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mdio-bus {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      xgmac_pcs: ethernet-pcs@0 {
+        compatible = "snps,dw-xpcs";
+        reg = <0>;
+
+        interrupts = <79 IRQ_TYPE_LEVEL_HIGH>;
+
+        clocks = <&ccu_core>, <&ccu_pad>;
+        clock-names = "core", "pad";
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/net/snps,dw-xpcs-mi.yaml b/Documentation/devicetree/bindings/net/snps,dw-xpcs-mi.yaml
new file mode 100644
index 000000000000..67ddba9d61fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/snps,dw-xpcs-mi.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/snps,dw-xpcs-mi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare Ethernet PCS Management Interface
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description:
+  Synopsys DesignWare Ethernet PCS provides an interface between MAC and PMA
+  through the Media Independent Interface. The PCS CSRs can be accessible over
+  the Ethernet MDIO bus or directly by means of the APB3/MCI interfaces. In the
+  later case the XPCS can be mapped right to the system IO memory space.
+
+allOf:
+  - $ref: mdio.yaml#
+
+properties:
+  compatible:
+    const: snps,dw-xpcs-mi
+
+  reg:
+    items:
+      - description:
+          DW XPCS CSRs space can be either 'directly' or 'indirectly'
+          accessible. In the former case all Clause 45 registers are
+          contiguously mapped within the address space MMD '[20:16]',
+          Reg '[15:0]'. In the later case the space is divided to the
+          multiple 256 register sets. There is a special viewport CSR
+          which is responsible for the set selection. The upper part of
+          the CSR address is supposed to be written in there thus the
+          corresponding subset would be mapped over the lowest 255 CSRs.
+
+  reg-names:
+    items:
+      - enum: [ direct, indirect ]
+
+  reg-io-width:
+    description:
+      The way the CSRs are mapped to the memory is platform depended. Since
+      each Clause 45 CSR is of 16-bits wide the access instructions must be
+      two bytes aligned at least.
+    default: 2
+    enum: [ 2, 4 ]
+
+  clocks:
+    items:
+      - description: Peripheral MCI/APB3 bus clock source
+
+  clock-names:
+    items:
+      - const: pclk
+
+patternProperties:
+  'ethernet-pcs@[0-9a-f]+$':
+    type: object
+
+    $ref: pcs/snps,dw-xpcs.yaml#
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio@1f05d000 {
+      compatible = "snps,dw-xpcs-mi";
+      reg = <0x1f05d000 0x1000>;
+      reg-names = "indirect";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      clocks = <&ccu_pclk>;
+      clock-names = "pclk";
+
+      reg-io-width = <4>;
+
+      ethernet-pcs@0 {
+        compatible = "snps,dw-xpcs";
+        reg = <0>;
+      };
+    };
-- 
2.42.1

