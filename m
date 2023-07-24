Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442AF76025C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjGXWcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjGXWb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:31:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6F01BD9;
        Mon, 24 Jul 2023 15:31:40 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OKj0sR025253;
        Mon, 24 Jul 2023 22:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=0RiqDvAsRoz+wat/BUC+Un9PsqnWtL24OIyCvnctV6A=;
 b=jSwYOX3NDyEvudpBV/16k7U/XSFzhxw9l4D1MRLontm/ufK26H3VGUP4LzOzYmxzhRYk
 IQlihyVSfxWt+nC0rm6pOyGvIUS4CYmO05DBnGv07ifMqhPzb2igH9s2fpNLSB1d08RZ
 2PUjxHVVLH3La7D0aX0CGN0TQx9I6dg3AhJCRh0MzQlCjP9TzAtuTDmNM+LyRP23t3fn
 BqxjCQQ9WRMgSJNkX3AT+SBL3/enTVlIMY9PIo5wgshBKMQfxrNiwFn55FTP3vZhmZiX
 ekaXlgGi9ZnbTBYmz6XDWnsmKBJvJCQCvk0hewBY5+/xuE/hDCxIbAoi/tsSmkqhCC8k jg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1u3t92my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 22:31:30 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OMVTga000964
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 22:31:29 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 15:31:28 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>
Subject: [RFC PATCH 3/4] dt-bindings: power: reset: Document arm,psci-vendor-reset
Date:   Mon, 24 Jul 2023 15:30:53 -0700
Message-ID: <20230724223057.1208122-4-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724223057.1208122-1-quic_eberman@quicinc.com>
References: <20230724223057.1208122-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mRLoo05zWGFRJvpu-xQK8I2LCYpYz64R
X-Proofpoint-ORIG-GUID: mRLoo05zWGFRJvpu-xQK8I2LCYpYz64R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_18,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240198
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for using PSCI SYSTEM_RESET2 with vendor reset  types.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 .../power/reset/arm,psci-vendor-reset.yaml    | 35 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml b/Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml
new file mode 100644
index 000000000000..18b0b8c167a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/arm,psci-vendor-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PSCI SYSTEM_RESET2 Vendor Resets
+
+maintainers:
+  - Elliot Berman <quic_eberman@quicinc.com>
+
+description: |
+  PSCI SYSTEM_RESET2 supports vendor-defined reset types. This describes
+  the conversion of reboot modes to the reset types.
+
+properties:
+  compatible:
+    const: arm,psci-vendor-reset
+
+allOf:
+  - $ref: reboot-mode.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      psci-vendor-resets {
+        compatible = "arm,psci-vendor-reset";
+        reboot-normal = <0x100>;
+        reboot-bootloader = <0x101>;
+        reboot-fastboot = <0x102>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d516295978a4..2da4c5f1917b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16982,6 +16982,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/power/reset/arm,psci-vendor-reset.yaml
 F:	drivers/firmware/psci/
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
-- 
2.41.0

