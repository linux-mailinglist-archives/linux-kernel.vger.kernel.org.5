Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305477CFA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbjJSNBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345984AbjJSNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:00:59 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11E5525D;
        Thu, 19 Oct 2023 06:00:24 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39JA8nol019597;
        Thu, 19 Oct 2023 08:58:47 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ttbmm16h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:58:46 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 39JCwjox035747
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Oct 2023 08:58:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 19 Oct 2023 08:58:44 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 19 Oct 2023 08:58:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 19 Oct 2023 08:58:43 -0400
Received: from ubuntu20.04.ad.analog.com ([10.32.226.241])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 39JCw2nT004952;
        Thu, 19 Oct 2023 08:58:35 -0400
From:   Eliza Balas <eliza.balas@analog.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Eliza Balas <eliza.balas@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tree binding for TDD engine
Date:   Thu, 19 Oct 2023 15:56:45 +0300
Message-ID: <20231019125646.14236-2-eliza.balas@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231019125646.14236-1-eliza.balas@analog.com>
References: <20231019125646.14236-1-eliza.balas@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: kZbEObt-6r4CgJlq_IyJUkSK-dqlje2S
X-Proofpoint-ORIG-GUID: kZbEObt-6r4CgJlq_IyJUkSK-dqlje2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_11,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2309180000
 definitions=main-2310190111
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree documentation for the AXI TDD Core.
The generic TDD controller is in essence a waveform generator
capable of addressing RF applications which require Time Division
Duplexing, as well as controlling other modules of general
applications through its dedicated 32 channel outputs.

Signed-off-by: Eliza Balas <eliza.balas@analog.com>
---
 .../devicetree/bindings/misc/adi,axi-tdd.yaml | 65 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml

diff --git a/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
new file mode 100644
index 000000000000..4449d9abf46e
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
@@ -0,0 +1,65 @@
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
+  The TDD controller is a waveform generator capable of addressing RF
+  applications which require Time Division Duplexing, as well as controlling
+  other modules of general applications through its dedicated 32 channel
+  outputs. It solves the synchronization issue when transmitting and receiving
+  multiple frames of data through multiple buffers.
+  The TDD IP core is part of the Analog Devices hdl reference designs and has
+  the following features:
+    * Up to 32 independent output channels
+    * Start/stop time values per channel
+    * Enable and polarity bit values per channel
+    * 32 bit-max internal reference counter
+    * Initial startup delay before waveform generation
+    * Configurable frame length and number of frames per burst
+    * 3 sources of synchronization: external, internal and software generated
+  For more information see the wiki:
+  https://wiki.analog.com/resources/fpga/docs/axi_tdd
+
+properties:
+  compatible:
+    enum:
+      - adi,axi-tdd
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
+    tdd@84a00000 {
+        compatible = "adi,axi-tdd";
+        reg = <0x84a00000 0x10000>;
+        clocks = <&zynqmp_clk_PL0_REF>, <&zynqmp_clk_PL1_REF>;
+        clock-names = "s_axi_aclk", "intf_clk";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 59831c69a275..13a1e1990c19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1344,6 +1344,13 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	drivers/dma/dma-axi-dmac.c
 
+ANALOG DEVICES INC GENERIC TDD ENGINE DRIVER
+M:	Eliza Balas <eliza.balas@analog.com>
+S:	Supported
+W:	http://wiki.analog.com/resources/fpga/docs/axi_tdd
+W:	http://ez.analog.com/linux-software-drivers/
+F:	Documentation/devicetree/bindings/misc/adi,axi-tdd.yaml
+
 ANALOG DEVICES INC IIO DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
-- 
2.25.1

