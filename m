Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860087D257F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjJVSxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjJVSxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:53:40 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2290DEE;
        Sun, 22 Oct 2023 11:53:39 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39MHHaUw017890;
        Sun, 22 Oct 2023 14:53:29 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tvusetvps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 14:53:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 39MIrRXD035060
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 22 Oct 2023 14:53:27 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 22 Oct 2023 14:53:27 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 22 Oct 2023 14:53:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 22 Oct 2023 14:53:26 -0400
Received: from HYB-a2JJhsYKAxD.ad.analog.com ([10.132.252.38])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 39MIr0UW003145;
        Sun, 22 Oct 2023 14:53:15 -0400
From:   Gokhan Celik <gokhan.celik@analog.com>
To:     <outreachy@lists.linux.dev>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gokhan Celik <Gokhan.Celik@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Gokhan Celik <gokhan.celik@analog.com>,
        "Conor Dooley" <conor.dooley@microchip.com>
Subject: [PATCH v4 2/2] regulator: dt-bindings: Add ADI MAX77503 support
Date:   Sun, 22 Oct 2023 21:52:51 +0300
Message-ID: <fb2cb32219eb1a5f85169d6c85cd2c057c5bb4a9.1698000185.git.gokhan.celik@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698000185.git.gokhan.celik@analog.com>
References: <cover.1698000185.git.gokhan.celik@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: QfmKcg1AqF98SRRZeOBf3o5aZUaiTGR6
X-Proofpoint-ORIG-GUID: QfmKcg1AqF98SRRZeOBf3o5aZUaiTGR6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-22_16,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2310170000
 definitions=main-2310220174
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADI MAX77503 buck converter devicetree document.

Signed-off-by: Gokhan Celik <gokhan.celik@analog.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changelog:
V2 -> V3: Addressed the review comments

 .../regulator/adi,max77503-regulator.yaml     | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml b/Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml
new file mode 100644
index 000000000000..aa581e550be2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) 2023 Analog Devices, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/adi,max77503-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX77503 Buck Converter
+
+maintainers:
+  - Gokhan Celik <Gokhan.Celik@analog.com>
+
+description: |
+  The Analog Devices MAX77503 is a single channel 14V input, 1.5A
+  high-efficiency buck converter. This converter has 94% efficiency
+  for 2-Cell/3-Cell battery applications.
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,max77503
+
+  reg:
+    description: I2C address of the device
+    items:
+      - enum: [0x1e, 0x24, 0x37]
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@1e {
+            compatible = "adi,max77503";
+            reg = <0x1e>;
+
+            regulator-min-microvolt = <800000>;
+            regulator-max-microvolt = <5000000>;
+        };
+    };
-- 
2.34.1

