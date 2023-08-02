Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173F876D89A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjHBUWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjHBUWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:22:19 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A05D2698;
        Wed,  2 Aug 2023 13:22:16 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372H25on001382;
        Wed, 2 Aug 2023 20:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=HtjNd577GIB9HC1wPuQzFolO42XKedakoDs40nlPQb0=;
 b=pFe9wTNmWiy/lzX4+wIkD1AAKDobtGMZ0GA/qsaVGVFeCeRYlpEweUWkt9K3NwdZkUw+
 UcnwxfSbqPGDc3JKotNTWk5Sx07vGe/IkOO64AQpsI0bpGOPzZsDJs5xApCT2S09tmLh
 hvJ2Tqyj37RpSxAolK/d+5q/gZ5GHDajnyp8M10ExBua6JWeaWfCB+1k91bIjdQVwo5c
 ONwO2pip/RYexFiEhZxEx6mxcxjUmPAWQQ9kA+1NPM3gu2eaaQjWQ0xS1Uo+RVJmFOnh
 Sj/nbF44WvBXxTuidjfBSIeS98iEecIz83BR+Dutz3QvR2oMiYhzL+CewGSKaXEOB+dN pQ== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3s797ca629-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 20:21:55 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 984A0D2D0;
        Wed,  2 Aug 2023 20:21:54 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id ACBB980F07E;
        Wed,  2 Aug 2023 20:21:53 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        andrew@lunn.ch, verdun@hpe.com, nick.hawkins@hpe.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: net: Add HPE GXP UMAC MDIO
Date:   Wed,  2 Aug 2023 15:18:20 -0500
Message-Id: <20230802201824.3683-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230802201824.3683-1-nick.hawkins@hpe.com>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: gWrKrPP3KhBaCK5T5dTeIH79snqZ4hcU
X-Proofpoint-GUID: gWrKrPP3KhBaCK5T5dTeIH79snqZ4hcU
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_17,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308020179
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
MAC(UMAC). The driver under the hpe,gxp-umac-mdio will provide an
interface for managing both the internal and external PHYs.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

---

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

