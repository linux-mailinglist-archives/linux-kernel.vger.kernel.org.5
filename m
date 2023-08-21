Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA4B782E71
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbjHUQ3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbjHUQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:29:13 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0964D3;
        Mon, 21 Aug 2023 09:29:11 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37LEAtoO010730;
        Mon, 21 Aug 2023 12:28:56 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3skvcqc7y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 12:28:56 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 37LGStRR055705
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Aug 2023 12:28:55 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 21 Aug 2023 12:28:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 21 Aug 2023 12:28:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 21 Aug 2023 12:28:54 -0400
Received: from HYB-a2JJhsYKAxD.ad.analog.com (HYB-a2JJhsYKAxD.ad.analog.com [10.25.72.79])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 37LGSQsq012468;
        Mon, 21 Aug 2023 12:28:42 -0400
From:   Gokhan Celik <gokhan.celik@analog.com>
To:     <outreachy@lists.linux.dev>
CC:     Gokhan Celik <gokhan.celik@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gokhan Celik <Gokhan.Celik@analog.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: regulator: Add MAX77503 regulator bindings
Date:   Mon, 21 Aug 2023 19:28:22 +0300
Message-ID: <50b983f2eb74aab5947cf7721770983b51ffd949.1692634090.git.gokhan.celik@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692634090.git.gokhan.celik@analog.com>
References: <cover.1692634090.git.gokhan.celik@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 4c98y7WqKRxjrQheiDzBQHOjJnzqXdNW
X-Proofpoint-GUID: 4c98y7WqKRxjrQheiDzBQHOjJnzqXdNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_04,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2306200000 definitions=main-2308210153
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for MAX77503 buck converter.

Signed-off-by: Gokhan Celik <gokhan.celik@analog.com>
---
 .../regulator/adi,max77503-regulator.yaml     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml b/Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml
new file mode 100644
index 000000000000..0d351225e107
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml
@@ -0,0 +1,64 @@
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
+description: Analog Devices MAX77503 Buck Converter
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
+  regulator:
+    type: object
+    $ref: regulator.yaml#
+    additionalProperties: false
+    description: |
+      Buck regulator
+
+    properties:
+      regulator-name: true
+      regulator-always-on: true
+      regulator-boot-on: true
+      regulator-min-microvolt:
+        minimum: 800000
+      regulator-max-microvolt:
+        maximum: 5000000
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        max77503@1e {
+            compatible = "adi,max77503";
+            reg = <0x1e>;
+            regulator{
+                regulator-name = "max777503-regulator";
+                regulator-min-microvolt = <800000>;
+                regulator-max-microvolt = <5000000>;
+                regulator-boot-on;
+            };
+        };
+    };
+
-- 
2.34.1

