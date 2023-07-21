Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE5F75D674
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGUVYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGUVYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:24:41 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4331030D0;
        Fri, 21 Jul 2023 14:24:40 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LLF4Yg009348;
        Fri, 21 Jul 2023 21:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=v4nK1wM9bJnFLBK8DYB5LMkXWzyI0R0NAUVPmfiJkQk=;
 b=WorVO4mLoGIc1skC+BcSfJQhf3hlLM870S/p439/jXNBOVrrIR4FBSIR1U9wD8j6bdKX
 8XAJboA1eNW4e3pW1Ar+MnUFrB+eZxcNB2lMdCqoWIWrRh+IFmo1z8qi49ZfK7Ys+2Jj
 nmHkCoGBQOVG2teBRMvlrFqvHh6cVXHxUjQPxt4Olk7xutgBLXon+Ld4MOC65vChc1qb
 O7tAaTaJpSdghN2ALFD9/BOR4u731yt1vBBbVR7MP6XVHJreIFUs6+L+TCHAHJb12DBL
 R3z6UdYD91roIZBd4f6kLDuCIAcCGjfIIuDE7ooqXcJg2/+xt2jazozj/Jvvaclsvzsa 9Q== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ryuq4329b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 21:24:28 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 5EA5E804DFE;
        Fri, 21 Jul 2023 21:24:27 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id D53A2809E78;
        Fri, 21 Jul 2023 21:24:26 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] dt-bindings: net: Add HPE GXP UMAC MDIO
Date:   Fri, 21 Jul 2023 16:20:40 -0500
Message-Id: <20230721212044.59666-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230721212044.59666-1-nick.hawkins@hpe.com>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: O2Xjkxt5WkgSovZXZ8ZDNUwXRFXYpXlJ
X-Proofpoint-GUID: O2Xjkxt5WkgSovZXZ8ZDNUwXRFXYpXlJ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
MAC(UMAC). The driver under the hpe,gxp-umac-mdio will provide an
interface for managing both the internal and external PHYs.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../bindings/net/hpe,gxp-umac-mdio.yaml       | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml b/Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml
new file mode 100644
index 000000000000..bb0db1bb67b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/hpe,gxp-umac-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP UMAC MDIO Controller
+
+maintainers:
+  - Nicholas Hawkins <nick.hawkins@hpe.com>
+
+description: |+
+  The HPE GXP Unversal MAC (UMAC) MDIO controller provides a configuration
+  path for both external PHY's and SERDES connected PHY's.
+
+allOf:
+  - $ref: mdio.yaml#
+
+properties:
+  compatible:
+    const: hpe,gxp-umac-mdio
+
+  reg:
+    maxItems: 1
+    description: The register range of the MDIO controller instance
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio0: mdio@4080 {
+      compatible = "hpe,gxp-umac-mdio";
+      reg = <0x4080 0x10>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ethphy0: ethernet-phy@0 {
+        compatible = "ethernet-phy-ieee802.3-c22";
+        phy-mode = "sgmii";
+        reg = <0>;
+      };
+    };
-- 
2.17.1

