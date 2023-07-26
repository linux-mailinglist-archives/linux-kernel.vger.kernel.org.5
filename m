Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AF1762CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjGZHQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjGZHPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:15:32 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530561BFB;
        Wed, 26 Jul 2023 00:12:08 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q5j7RP013717;
        Wed, 26 Jul 2023 03:11:52 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s0c15gknw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 03:11:51 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 36Q7Boqx053369
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 03:11:50 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 26 Jul 2023 03:11:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 26 Jul 2023 03:11:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 26 Jul 2023 03:11:49 -0400
Received: from ubuntu20.04.ad.analog.com (HYB-d0iOFy9ma8q.ad.analog.com [10.48.65.141])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 36Q7BYaj004865;
        Wed, 26 Jul 2023 03:11:37 -0400
From:   Eliza Balas <eliza.balas@analog.com>
CC:     Eliza Balas <eliza.balas@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] Documentation: bindings: adi,axi-tdd.yaml: Add new TDD engine driver
Date:   Wed, 26 Jul 2023 10:11:02 +0300
Message-ID: <20230726071103.12172-1-eliza.balas@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ImpkZ8RzsrW2pnE6Amw5X0RaIU6mSwue
X-Proofpoint-GUID: ImpkZ8RzsrW2pnE6Amw5X0RaIU6mSwue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_01,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260063
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree documentation for the AXI TDD Core.
The generic TDD controller is in essence a waveform generator
capable of addressing RF applications which require Time Division
Duplexing, as well as controlling other modules of general
applications through its dedicated 32 channel outputs.

The reason of creating the generic TDD controller was to reduce
the naming confusion around the existing repurposed TDD core
built for AD9361, as well as expanding its number of output
channels for systems which require more than six controlling signals.

Signed-off-by: Eliza Balas <eliza.balas@analog.com>
---
 .../devicetree/bindings/misc/adi,axi-tdd.yaml | 51 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml

diff --git a/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
new file mode 100644
index 000000000000..1894c1c34d4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2023 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/adi,axi-tdd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AXI TDD Core
+
+maintainers:
+  - Eliza Balas <eliza.balas@analog.com>
+
+description: |
+  Bindings for the new generic TDD CORE, which is part of the Analog Devices hdl reference designs.
+  For more information see the wiki: https://wiki.analog.com/resources/fpga/docs/axi_tdd
+
+properties:
+  compatible:
+    enum:
+      - adi,axi-tdd-2.00.a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: System clock
+      - description: TDD Core clock
+
+  clock-names:
+    items:
+      - const: s_axi_aclk
+      - const: intf_clk
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    tdd: tdd@84a00000 {
+            compatible = "adi,axi-tdd-2.00.a";
+            reg = <0x84a00000 0x10000>;
+            clocks = <&zynqmp_clk_PL0_REF>, <&zynqmp_clk_PL1_REF>;
+            clock-names = "s_axi_aclk", "intf_clk";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index aee340630eca..280e66ccdd56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1360,6 +1360,13 @@ F:	Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
 F:	Documentation/hwmon/max31760.rst
 F:	drivers/hwmon/max31760.c
 
+ANALOG DEVICES INC GENERIC TDD ENGINE DRIVER
+M:	Eliza Balas <eliza.balas@analog.com>
+S:	Supported
+W:	http://wiki.analog.com/resources/fpga/docs/axi_tdd
+W:	http://ez.analog.com/linux-software-drivers/
+F:	Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
+
 ANALOGBITS PLL LIBRARIES
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 S:	Supported
-- 
2.25.1

