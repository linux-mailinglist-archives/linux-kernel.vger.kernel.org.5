Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367D777EC59
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346710AbjHPV4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346685AbjHPV4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:56:15 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFC6271D;
        Wed, 16 Aug 2023 14:56:13 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GL2Jb5006163;
        Wed, 16 Aug 2023 21:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=15BJWwCisxol9Y1fVdTADtWs3sLlWGzB6kh21OicCww=;
 b=lVa9j9VfvYQlE4Yjr6qKgHPnamNZvCSdjJBs1XrXXiZKDBo+JYzzzAhX0hEuyCMLx1y8
 LRPc75oCRLO0UzZ20kyol5DkxSg+4muXb5ghr/VK919YCqC2xCrcYwbS6/tDXnHfmggv
 HCZiiUSRL65n910eFEzknSpeg1Kx1yC9SMCv+y5IInHMv8HbgrYSTgRvf14qrdbiE0EE
 XTtfG/g5h+t7/uaySgFoupKcpGVqgIgk0LudfqGdIU+cYLyXF9NbOS/z+OfojnB4v0A0
 6oVVwj+LshVkQFBklcnaICRVWsr7wvVdI+cap8Br/aH6jwtoQmNsq4U2UoxgaktU3R3H Tg== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3sh07b3sgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 21:55:47 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 1CDA7D2DF;
        Wed, 16 Aug 2023 21:55:46 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 61CC080C764;
        Wed, 16 Aug 2023 21:55:45 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        andrew@lunn.ch, verdun@hpe.com, nick.hawkins@hpe.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: net: Add HPE GXP UMAC MDIO
Date:   Wed, 16 Aug 2023 16:52:16 -0500
Message-Id: <20230816215220.114118-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230816215220.114118-1-nick.hawkins@hpe.com>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: kCzjZKcd_xUvIl_aQtS8pE5_ViDE9c52
X-Proofpoint-ORIG-GUID: kCzjZKcd_xUvIl_aQtS8pE5_ViDE9c52
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160195
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

---
v3:
 * no change
v2:
 * remove |
 * remove unecessary description
---
 .../bindings/net/hpe,gxp-umac-mdio.yaml       | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml b/Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml
new file mode 100644
index 000000000000..a8ab93c681bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml
@@ -0,0 +1,50 @@
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
+description:
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

