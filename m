Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6903375D683
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGUVZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjGUVZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:25:22 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C615E3A8F;
        Fri, 21 Jul 2023 14:25:00 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LK8aev026761;
        Fri, 21 Jul 2023 21:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=iRlorkov3huiTBrRF5aHfpBB+eam/ZCgsrAc5IIrWq8=;
 b=TziHYlpZO6AU9reDDGzkF3KOI5m/BNS+R4Kom6ATxoAPqZF6xeuiPh2JYBd9m0EgfnzN
 jhqtIJzfwQtmRZH/yjZNCRtube7P3LyR5BmXzoNDsdmzSaXH8391rEYiQu6Lawz3Mq6S
 MOyXqqr9GFbj0ceuyn/X7zOf/ZztBeXcmAZael02C9Il6p0aEPlLJ3JJxGgNpF6ooTR+
 BRS4rr4XtanNs9nnPpdy+0dZBWYp35Z6C5MFtPGdo7aKClz6c26ATxfRa+lFYhcocUSl
 Qm0JRyvmLI7j8y6TYV3IaeGPzI5wjc91V1fn7GCdJ5kQz2RmQb8rWbZ5GQzOxHX0aUiw zA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ryd8b9ywq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 21:24:53 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 9C2AA804DF9;
        Fri, 21 Jul 2023 21:24:28 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 15CE080A540;
        Fri, 21 Jul 2023 21:24:28 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] dt-bindings: net: Add HPE GXP UMAC
Date:   Fri, 21 Jul 2023 16:20:42 -0500
Message-Id: <20230721212044.59666-4-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230721212044.59666-1-nick.hawkins@hpe.com>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: ZzxqsRzLTQy19jOxfQcenbfm7Vr8U2BV
X-Proofpoint-ORIG-GUID: ZzxqsRzLTQy19jOxfQcenbfm7Vr8U2BV
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=952
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210189
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 .../devicetree/bindings/net/hpe,gxp-umac.yaml | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml

diff --git a/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml b/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
new file mode 100644
index 000000000000..c3b68c4ba7f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
@@ -0,0 +1,111 @@
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
+description: |
+  HPE GXP 802.3 10/100/1000T Ethernet Unifed MAC controller.
+  Device node of the controller has following properties.
+
+properties:
+  compatible:
+    const: hpe,gxp-umac
+
+  use-ncsi:
+    type: boolean
+    description: |
+      Indicates if the device should use NCSI (Network Controlled
+      Sideband Interface).
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  mac-address: true
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
+      mac-address = [00 00 00 00 00 00]; /* Filled in by U-Boot */
+      ethernet-ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+          phy-handle = <&eth_phy0>;
+        };
+
+        port@1 {
+          reg = <1>;
+          phy-handle = <&eth_phy1>;
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

