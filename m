Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA0A76D897
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjHBUWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjHBUWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:22:18 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4213FFF;
        Wed,  2 Aug 2023 13:22:16 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372H2EOG001363;
        Wed, 2 Aug 2023 20:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=BROgmJsd4cMAmDfq1m4xfbtSICGwWHyKQVsuA5deR2A=;
 b=cRdLfNg0D0FVGoQiY5npkQXNR3UDzRj8kihaweK7QF8H2USUuZ9r6DxFQImDFICjuf35
 VGSWJPy7Iil0yIXbjhSDcoAn6T9YbJ0ZZgCFsp02AR3NwBp6D+DrYomFVUHb2AU6c1k+
 wkJpq016MbRw8tRsQwjnUuJxAoA0p/1V0Y3CPIk8uhxNs3DCA2G5CPMtircB+Fj2RoWz
 dUoCJ7HlRWYSWP6I9ffZ4e5tHlDxdsgXd6KScrcAt9vSfsSIm8k7YKzsCZHOphh4EJf5
 W+/8W9HMvxPPgeJ2ZK5iDUnhj28wtQ8PEpbayn4S4DbOaV3ZtQK/QsaMBMtjvklmD3vG aQ== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3s7rbntyp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 20:21:57 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 723E1D2F2;
        Wed,  2 Aug 2023 20:21:56 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 8C48380F065;
        Wed,  2 Aug 2023 20:21:55 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        andrew@lunn.ch, verdun@hpe.com, nick.hawkins@hpe.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] dt-bindings: net: Add HPE GXP UMAC
Date:   Wed,  2 Aug 2023 15:18:22 -0500
Message-Id: <20230802201824.3683-4-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230802201824.3683-1-nick.hawkins@hpe.com>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: GZCrggmy_2kp5b0r7Gk-_oh6k2yoyBWu
X-Proofpoint-ORIG-GUID: GZCrggmy_2kp5b0r7Gk-_oh6k2yoyBWu
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_16,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Provide access to the register regions and interrupt for Universal
MAC(UMAC). The driver under the hpe,gxp-umac binding will provide an
interface for sending and receiving networking data from both of the
UMACs on the system.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---

v2:
 *Move mac-addresses into ports
 *Remove | where not needed
---
 .../devicetree/bindings/net/hpe,gxp-umac.yaml | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml

diff --git a/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml b/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
new file mode 100644
index 000000000000..ff1a3a201dcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/hpe,gxp-umac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP Unified MAC Controller
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+
+description:
+  HPE GXP 802.3 10/100/1000T Ethernet Unifed MAC controller.
+  Device node of the controller has following properties.
+
+properties:
+  compatible:
+    const: hpe,gxp-umac
+
+  use-ncsi:
+    type: boolean
+    description:
+      Indicates if the device should use NCSI (Network Controlled
+      Sideband Interface).
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  ethernet-ports:
+    type: object
+    additionalProperties: false
+    description: Ethernet ports to PHY
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^port@[0-1]$":
+        type: object
+        additionalProperties: false
+        description: Port to PHY
+
+        properties:
+          reg:
+            minimum: 0
+            maximum: 1
+
+          phy-handle:
+            maxItems: 1
+
+          mac-address: true
+
+        required:
+          - reg
+          - phy-handle
+
+  mdio:
+    $ref: mdio.yaml#
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ethernet-ports
+
+examples:
+  - |
+    ethernet@4000 {
+      compatible = "hpe,gxp-umac";
+      reg = <0x4000 0x80>;
+      interrupts = <22>;
+      ethernet-ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+          phy-handle = <&int_phy0>;
+          mac-address = [00 00 00 00 00 00];
+        };
+
+        port@1 {
+          reg = <1>;
+          phy-handle = <&ext_phy1>;
+          mac-address = [00 00 00 00 00 00];
+        };
+      };
+
+      mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        eth_phy0: ethernet-phy@0 {
+          reg = <0>;
+        };
+
+        eth_phy1: ethernet-phy@1 {
+          reg = <1>;
+        };
+      };
+    };
+...
-- 
2.17.1

