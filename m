Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D41280F343
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjLLQlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376504AbjLLQk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:40:59 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E68EB0;
        Tue, 12 Dec 2023 08:41:05 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCGIHva006466;
        Tue, 12 Dec 2023 16:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=HZKDOQdlruUrwSrsQrbX8IBxHCZBl+bwGjar2nR9JrU=;
 b=aTpiJC5MOOAjq5MkfryivjwVmETsf9UzGTFvWxMATouKnJqWD7acDJn0Kuhi/VuL21i1
 D+lrq/+ybfr8yzB1Rl7Ry37k8hewf7G+EIQGjGEj9Jhs2DbLDwEU+DLSk97yNFqCwbrb
 Nz3QCWCACakDXyFO++5GZ40E7a+0F9tiBK1B6IfwbG+ZAZaR2uOZt61UmLoa7HSzxPFU
 ToMz7Kjs7TQ8TVzAZsQuCDQHjeDvucD0NB1m02ArgDTXyiFCEGG7GYD18UCf7l5zRgnA
 5WCPKeidyOCMCRTHzVGIReINuuVlQYL5pjlef5P9heOVp15xgfqYUoDXnL4f/AKZsDEa xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxtwu0uv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 16:40:21 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCGKB7m012635;
        Tue, 12 Dec 2023 16:40:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxtwu0uua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 16:40:20 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCGBALS013864;
        Tue, 12 Dec 2023 16:40:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw5921t4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 16:40:19 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BCGeHNL28508762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 16:40:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D812958053;
        Tue, 12 Dec 2023 16:40:17 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D57558059;
        Tue, 12 Dec 2023 16:40:16 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Dec 2023 16:40:16 +0000 (GMT)
From:   Ninad Palsule <ninad@linux.ibm.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        ninad@linux.ibm.com, johannes.holland@infineon.com,
        linux@roeck-us.net, broonie@kernel.org
Cc:     patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
Subject: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
Date:   Tue, 12 Dec 2023 10:39:58 -0600
Message-Id: <20231212164004.1683589-3-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231212164004.1683589-1-ninad@linux.ibm.com>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f3WbNcfTHxBvCCPYQ0MDbJuiyBqBugU7
X-Proofpoint-GUID: jtK8DhAEU76Zj9fXDMurb-EIeRPJhL_c
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_10,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Holland <johannes.holland@infineon.com>

Add a dt schema to support device tree bindings for the generic I2C
physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
Specification for TPM 2.0 v1.04 Revision 14.

This includes descriptions for the Nuvoton and Infineon devices.

OpenBMC-Staging-Count: 3
Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
new file mode 100644
index 000000000000..de1e34065748
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: I2C PTP based TPM Devices
+
+maintainers:
+  - Johannes Holland <johannes.holland@infineon.com>
+
+description:
+  Device Tree Bindings for I2C based Trusted Platform Module (TPM).
+
+properties:
+  $nodename:
+    pattern: "^tpm(@[0-9a-f]+)?$"
+
+  compatible:
+    oneOf:
+      - description: Infineon's Trusted Platform Module (TPM) (SLB9673).
+        items:
+          - const: infineon,slb9673
+          - const: tcg,tpm-tis-i2c
+      - description: Nuvoton's Trusted Platform Module (TPM) (NPCT75x).
+        items:
+          - const: nuvoton,npct75x
+          - const: tcg,tpm-tis-i2c
+      - const: tcg,tpm-tis-i2c
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      tpm@2e {
+        compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
+        reg = <0x2e>;
+      };
+    };
+...
-- 
2.39.2

