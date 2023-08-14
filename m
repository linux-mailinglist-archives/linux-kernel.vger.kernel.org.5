Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771EC77B85F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjHNMMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjHNMLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:11:37 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01559F5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:11:34 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230814121133epoutp017c1d4089b89b3c9fde160706235f3ac7~7PsNHnnGI0044800448epoutp01b
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:11:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230814121133epoutp017c1d4089b89b3c9fde160706235f3ac7~7PsNHnnGI0044800448epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692015093;
        bh=ShySZtEk1+xwW7aJlNCSKMFk+9qm6buF6WBsZ7yCoqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wl7okINh5HOpZzZBJMVa2RMOOAsOJsoVeNAATuk4U9s8XeIlGWIbtuAqYaV3/ajO8
         JRRY6IwHa4Spam/Oj3Masvzr1QAhLRNjYm+dFCCp7jVzqiTOcwXdqo2LXI+ALv7jdU
         n2v7wKi7E7CdtYh40BtfwBC1TOHN1kudXg/0agds=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230814121132epcas5p4a13dfe55bdac406e7b4c03e698892a7f~7PsMQfiT52655926559epcas5p4A;
        Mon, 14 Aug 2023 12:11:32 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RPYCk5pZyz4x9Pr; Mon, 14 Aug
        2023 12:11:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.CF.44250.2F91AD46; Mon, 14 Aug 2023 21:11:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66~7PEg4nhhO2938329383epcas5p3i;
        Mon, 14 Aug 2023 11:26:05 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230814112605epsmtrp28467dd192218d7dfcdabb20054318b78~7PEg3jgEE1398813988epsmtrp2a;
        Mon, 14 Aug 2023 11:26:05 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-27-64da19f210fc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.E3.14748.D4F0AD46; Mon, 14 Aug 2023 20:26:05 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230814112602epsmtip2baeb90e73160c49db1ce52ff1828bd87~7PEd_DqyY1008410084epsmtip2S;
        Mon, 14 Aug 2023 11:26:02 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        richardcochran@gmail.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        alim.akhtar@samsung.com, linux-fsd@tesla.com,
        pankaj.dubey@samsung.com, swathi.ks@samsung.com,
        ravi.patel@samsung.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree bindings
Date:   Mon, 14 Aug 2023 16:55:36 +0530
Message-Id: <20230814112539.70453-2-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230814112539.70453-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTfUxTVxTf7WvfK46ylyJ4IerII5rBwkeVjwsCNhszT3SjDjOTLYIdfaMN
        pe3aMpnJBgEr4hRFB1sQEYHMAALalo6vdgQqm2CQAcMBsgjIx4AhtgR1i2Qthe2/3/md3++c
        c8+9l4vxe3BfrkyhZdQKsZzCt7BNXQGBQTafUUlo/cvd6OWfJQA9Ljfh6Ja5j4XKHpxmo+vW
        Pg6a7p4k0B+VSxxUODeBoX5TIQfpp4Y5aGL+GBpsLcPR9w8sLFT+qp6Duiu80WrvIkCVTSsE
        mlhuJ5D1/hyGdGYrgcYWGzho5c4IIfSmjTUjLHr6YhNBt5SOE3SFPpPW1xbg9KPhdpw2VGfT
        Ty2/4XShsRbQxp/sgF7LvUbQdv1OkfvH6TFSRixh1H6MIlUpkSnSYqlDSSnvpoRHhAqCBFEo
        kvJTiDOYWCr+sCjogEzuODDl94VYnumgRGKNhgqJi1ErM7WMn1Sp0cZSjEoiV4WpgjXiDE2m
        Ii1YwWijBaGhe8IdwhPp0o7GZkJVEpA1sHaenQOKd5wDblxIhsGR6kVwDmzh8sk2AJ8U5eOu
        wAbgWP8gyxWsOoJ7M6xNi8lk5zgxnzQDWLHwkUukY8G82X7MmcDJIKgbtq+7t5JnMHjL9u16
        AiPvA1hoCXZiT/IQzFnROURcLpvcBQ0DGifNI2PhQNWLjWZvwrrbHetWNzIOLj9sZztrQnKO
        Cwev1ACXKB7a8s24C3vC+Z+NhAv7QvvSJp8GDVYDx4Xl8GxuHubC+2HHUBnbOQNGBsDG1hAX
        vQMW9zSwXCN7wAv/PNmYhwebyzfxblg1WbCBt8P6SdtGeRou/Z1LuJZSBOBK8e/YJbCz9P8W
        FQDUAh9GpclIYzThqj0K5uR/t5aqzNCD9UcdmNAMJh4vB3cCFhd0AsjFqK2887xRCZ8nEX95
        ilErU9SZckbTCcId+yvCfL1SlY5fodCmCMKiQsMiIiLCovZGCKhtvAXdNQmfTBNrmXSGUTHq
        TR+L6+abw5KLpO7LCdWmo1mJ5MEfLHdF3iG+fr/Y9rXTf9Wbc3LOfEq/1/bwq6jLuFB5d8xL
        nS785NfkfvyC7PPkpwexmcQSCo0WX176rDdp30Wr7U7gG5VNOn/Jzb4f2XXtHnyv6Wxxw4FH
        id34oKdi6m25cuTrlqv3qhopr6MJdXVJq8Yeof72/pLj0mjRs1Kfd4TJkR/c7J11t3ftHZ+d
        Wsh+/tZr22Z5grWRhPiYfFmgdG7If8b/iCXF8Op5Waep/nrc6/30d/FVx8CQvOXFh2eZU1fH
        7YN9lhstk61Coyn6meFIesUlj9KCmu1ZeXWnzSeM1qnJ1tz599tuVEWe7PKXfXN8dYZia6Ri
        QSCm1oj/BcqVRGxdBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJXteX/1aKwd6z2hY/X05jtHgwbxub
        xZq955gs5pxvYbGYf+Qcq8XTY4/YLe4tesdq0ffiIbPFhW19rBabHl9jtXj4Ktzi8q45bBYz
        zu9jspj3dy2rxbEFYhbfTr9htFi09Qu7xcMPe9gtjpx5wWzRuvcIu8XtN+tYLb5svMnuIOax
        ZeVNJo+n/VvZPXbOusvusWBTqcemVZ1sHneu7WHz2Lyk3uP9vqtsHn1bVjF6bNn/mdHjX9Nc
        do/Pm+QCeKK4bFJSczLLUov07RK4Mg6s38FeME2z4tK/HpYGxqmyXYycHBICJhLbtn1mBbGF
        BHYzSuzZmAIRl5E4+WAJM4QtLLHy33P2LkYuoJpmJom+xbfAGtgEdCVar31mAkmICMxilpg3
        eQUziMMscIFRYvWdu0wgVcIC3hINX1qBbA4OFgFVic2XikHCvAK2EpcW/2CC2CAvsXrDAbBt
        nAJ2Eh+u72GBuMhWYtfXpawTGPkWMDKsYpRMLSjOTc9NNiwwzEst1ytOzC0uzUvXS87P3cQI
        jiUtjR2M9+b/0zvEyMTBeIhRgoNZSYS3h/dWihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFewxmz
        U4QE0hNLUrNTUwtSi2CyTBycUg1MKXmWr22PSLM/0ujTtBUNWFL+UktIauKV9lqtY748nDNb
        D4Zsvsp4tnprnqHxep6k2X6LXzrO+3h68gLnSj3jt5opnywNZyzctfvxuqX7nHZUr7ATqrQ5
        LyUmNUm3+0ezydZfYpvmvDoQ8XXVu4D2xZdsU7s3eWW+V/9hmrQ8cntQ1ymfkpYVzKujZARu
        yi0OXBGx+kwNm5iR35Pl198/urP31a+A09t/VnLVJqidb1/ZsT7tUaewcfKEbZpLt90N+bWm
        fNNOEeGPK593ua/8yOk1SeT78oeqZ/2iUwv7zI7cztGWsquPq5n8ttr9TL2K3747t75dtnF6
        FfDt5/3cC5x/7TOY5jskin37UMXSr8RSnJFoqMVcVJwIAEGrb+8UAwAA
X-CMS-MailID: 20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
        <CGME20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FSD Ethernet compatible in Synopsys dt-bindings document. Add FSD
Ethernet YAML schema to enable the DT validation.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
Signed-off-by: Swathi K S <swathi.ks@samsung.com>
Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |   5 +-
 .../devicetree/bindings/net/tesla,ethqos.yaml | 114 ++++++++++++++++++
 2 files changed, 117 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/tesla,ethqos.yaml

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index ddf9522a5dc2..0ced7901e644 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -96,6 +96,7 @@ properties:
         - snps,dwxgmac
         - snps,dwxgmac-2.10
         - starfive,jh7110-dwmac
+        - tesla,fsd-ethqos-4.21
 
   reg:
     minItems: 1
@@ -117,7 +118,7 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 8
+    maxItems: 10
     additionalItems: true
     items:
       - description: GMAC main clock
@@ -129,7 +130,7 @@ properties:
 
   clock-names:
     minItems: 1
-    maxItems: 8
+    maxItems: 10
     additionalItems: true
     contains:
       enum:
diff --git a/Documentation/devicetree/bindings/net/tesla,ethqos.yaml b/Documentation/devicetree/bindings/net/tesla,ethqos.yaml
new file mode 100644
index 000000000000..b78829246364
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/tesla,ethqos.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/tesla,ethqos.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: FSD Ethernet Quality of Service
+
+maintainers:
+  - Sriranjani P <sriranjani.p@samsung.com>
+  - Swathi K S <swathi.ks@samsung.com>
+
+description:
+  dwmmac based tesla ethernet devices which support Gigabit
+  ethernet.
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    const: tesla,fsd-ethqos-4.21.yaml
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 5
+    maxItems: 10
+
+  clock-names:
+    minItems: 5
+    maxItems: 10
+    items:
+      - const: ptp_ref
+      - const: master_bus
+      - const: slave_bus
+      - const: tx
+      - const: rx
+      - const: master2_bus
+      - const: slave2_bus
+      - const: eqos_rxclk_mux
+      - const: eqos_phyrxclk
+      - const: dout_peric_rgmii_clk
+
+  fsd-rx-clock-skew:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the syscon node
+          - description: offset of the control register
+    description:
+      Should be phandle/offset pair. The phandle to the syscon node.
+
+  iommus:
+    maxItems: 1
+
+  phy-mode:
+    $ref: ethernet-controller.yaml#/properties/phy-connection-type
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - rx-clock-skew
+  - iommus
+  - phy-mode
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/fsd-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    ethernet_1: ethernet@14300000 {
+              compatible = "tesla,dwc-qos-ethernet-4.21";
+              reg = <0x0 0x14300000 0x0 0x10000>;
+              interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+              clocks = <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I>,
+                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_ACLK_I>,
+                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_HCLK_I>,
+                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_RGMII_CLK_I>,
+                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_RX_I>,
+                       <&clock_peric PERIC_BUS_D_PERIC_IPCLKPORT_EQOSCLK>,
+                       <&clock_peric PERIC_BUS_P_PERIC_IPCLKPORT_EQOSCLK>,
+                       <&clock_peric PERIC_EQOS_PHYRXCLK_MUX>,
+                       <&clock_peric PERIC_EQOS_PHYRXCLK>,
+                       <&clock_peric PERIC_DOUT_RGMII_CLK>;
+              clock-names = "ptp_ref",
+                            "master_bus",
+                            "slave_bus",
+                            "tx",
+                            "rx",
+                            "master2_bus",
+                            "slave2_bus",
+                            "eqos_rxclk_mux",
+                            "eqos_phyrxclk",
+                            "dout_peric_rgmii_clk";
+              pinctrl-names = "default";
+              pinctrl-0 = <&eth1_tx_clk>, <&eth1_tx_data>, <&eth1_tx_ctrl>,
+                          <&eth1_phy_intr>, <&eth1_rx_clk>, <&eth1_rx_data>,
+                          <&eth1_rx_ctrl>, <&eth1_mdio>;
+              fsd-rx-clock-skew = <&sysreg_peric 0x10>;
+              iommus = <&smmu_peric 0x0 0x1>;
+              phy-mode = "rgmii";
+    };
+
+...
-- 
2.17.1

