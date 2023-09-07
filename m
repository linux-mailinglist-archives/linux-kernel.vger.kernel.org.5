Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEE4797DC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbjIGVJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjIGVJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:09:28 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850BD1BD6;
        Thu,  7 Sep 2023 14:09:17 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387FZhKs008731;
        Thu, 7 Sep 2023 21:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=KKh2mp3ccJj/PzchVn9gXJeWuTjcaxZHtk32YqXVeM4=;
 b=KEz9lEYHRjPqU95nwO9YYMu8kvQ3zFt9ZvFWtU2LUDAnc3kVo1MvDsvGCmmszfo4m4QD
 S9EMD1a7kxZml0lLqO40/0pd2YVssRLDG8gxvPQI5hMCoKcE8KIQBciKVs7eZBPq4WN7
 77BiXZsw6grKapYAOB8Lrh5wni37czHRtZ3RIsmNfOtw5m95X/Jc3KAi5iadJVqVmps9
 kwdB5zefMWiLf9c1i1hmeyf6bytV8TZgUjeKBDXBgC7UaWFj4GthAaE0sT6OXJWE55OT
 or39z/Pet4QY9Mbn5hGqS8xGzTYMul/GLDkASmGA9usK0ISHmtn8q+T0lL0McebegPLg NA== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3syafyy1ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 21:09:04 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 9BD15800441;
        Thu,  7 Sep 2023 21:09:03 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 21B6880A247;
        Thu,  7 Sep 2023 21:09:03 +0000 (UTC)
From:   richard.yu@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, richard.yu@hpe.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: usb: Add HPE GXP HUB Controller
Date:   Thu,  7 Sep 2023 16:05:59 -0500
Message-Id: <20230907210601.25284-2-richard.yu@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230907210601.25284-1-richard.yu@hpe.com>
References: <20230907210601.25284-1-richard.yu@hpe.com>
X-Proofpoint-GUID: gX75CXe-gfZLerM0G8_oA2vg_G6RHpnZ
X-Proofpoint-ORIG-GUID: gX75CXe-gfZLerM0G8_oA2vg_G6RHpnZ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=615 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Yu <richard.yu@hpe.com>

Provide access to the two register regions for GXP HUB
controller through the hpe,gxp-hub binding.

Signed-off-by: Richard Yu <richard.yu@hpe.com>

---

v2:
 *Removed the term "virtual" as it is still a device.
 *Removed the downstream port number and generic endpoints
  number properties from device tree structure.
---
 .../devicetree/bindings/usb/hpe,gxp-hub.yaml  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/hpe,gxp-hub.yaml

diff --git a/Documentation/devicetree/bindings/usb/hpe,gxp-hub.yaml b/Documentation/devicetree/bindings/usb/hpe,gxp-hub.yaml
new file mode 100644
index 000000000000..b3e7bc42d134
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/hpe,gxp-hub.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/hpe,gxp-hub.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP USB HUB controller
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+  - Richard Yu <richard.yu@hpe.com>
+
+description:
+  The HPE GXP USB HUB Controller implements 1 set of USB
+  register and several sets of device and endpoint registers to support
+  the HUB's downstream USB devices.
+
+properties:
+  compatible:
+    enum:
+      - hpe,gxp-hub
+
+  reg:
+    items:
+      - description: GXP hub (gxphub) controller register set
+      - description: Several sets of Device and Endpoint registers to support
+                     the HUB's downstream USB devices.
+
+  reg-names:
+    items:
+      - const: gxphub
+      - const: udc
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    usb-hub@80400800 {
+        compatible = "hpe,gxp-hub";
+        reg = <0x80400800 0x0200>, <0x80401000 0x8000>;
+        reg-names = "gxphub", "udc";
+        interrupts = <13>;
+        interrupt-parent = <&vic1>;
+    };
-- 
2.17.1

