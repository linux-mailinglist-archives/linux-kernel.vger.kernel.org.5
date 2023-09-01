Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A53D78F852
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348332AbjIAGDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348326AbjIAGDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:03:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDAF10CC;
        Thu, 31 Aug 2023 23:03:03 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38155hBm029804;
        Fri, 1 Sep 2023 06:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=oN8zR8xZVsT+fn+C96m/X0XHTmuDPyu0oN86deQxb6Q=;
 b=RSB3hNZrqUmnipPpeF99EYJqZ60Gic9WJazJVJ0em4ePRi6cRw5s+R9x5vASlYYFaMfA
 7KxGwVWcNF8VFtdfpdC69gfJwzRgmWwWqQA2ZQyVYI25993ab5NkJa7YweaL9h5VoQSa
 dArpWwnAJDiVwvKq0uuMjekdqgwYc7mTrInoZe51qDLzhbR2sLxzcwFn0V444vVQMZfb
 0bp+seK2vL2Z60tnuoQPp/PYTIhihcgoCHre0y/KYt8b+b2Jx2Js0t1IM7bQZoeJ0aa+
 0GphBXone0vhJBUONuMlAj1oS5pqc5menXtKiqupUtLSfxvQTP5rNL+rKFqbyi+M4OOl yA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stks5u901-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 06:02:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38162oAO014950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 06:02:50 GMT
Received: from hu-namajain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 31 Aug 2023 23:02:43 -0700
From:   Naman Jain <quic_namajain@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Naman Jain <quic_namajain@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kaushalk@quicinc.com>, <quic_rohiagar@quicinc.com>,
        <kernel@quicinc.com>
Subject: [PATCH] dt-bindings: firmware: Add documentation for qcom,platform-parts-info
Date:   Fri, 1 Sep 2023 11:32:23 +0530
Message-ID: <20230901060223.19575-1-quic_namajain@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VUhUXjWcmu9rUsBCdO3L7eqYPA8JswEZ
X-Proofpoint-ORIG-GUID: VUhUXjWcmu9rUsBCdO3L7eqYPA8JswEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_04,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 impostorscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe device tree bindings for QCOM's
platform-parts-info node. Firmware populates these nodes to pass the
information to kernel regarding the subset of hardware blocks
and features like Camera, Modem, Display present in a product.

This is to support that the same software image runs seamlessly on
different platforms where one or more HW blocks are not supported or
if some sub parts for a particular block are not supported.

Purpose of these definitions is to allow clients to know about this,
and thus, handle these cases gracefully.
For eg: Camera drivers and user space daemons can use this to know
if camera is not supported on the device, or some particular HW blocks
inside a camera are not supported.

Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
---
 .../firmware/qcom,platform-parts-info.yaml    | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,platform-parts-info.yaml

diff --git a/Documentation/devicetree/bindings/firmware/qcom,platform-parts-info.yaml b/Documentation/devicetree/bindings/firmware/qcom,platform-parts-info.yaml
new file mode 100644
index 000000000000..64e085d3ea88
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/qcom,platform-parts-info.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/qcom,platform-parts-info.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM Platform's Parts Information
+
+description:
+  Qualcomm platforms support a feature where a subset of hardware blocks
+  like Camera, GPU, Display, Modem, CPUs are available in a product,
+  based on features selected for a particular Stock keeping unit (SKU)
+  and the same software images are supposed to work seamlessly with these.
+  This is to support usecases where lets say a software image running on handset
+  device which supports display and camera, can work just fine on another
+  IoT product which doesn't need these. This also enables usecases, where certain
+  sub parts for a HW block are not supported.
+
+  Firmware (bootloader), reads the parts related information from lower
+  layers and passes this information to kernel via this device tree interface,
+  so that the respective clients are aware of it.
+  For example, Camera drivers and its user space daemons can use this interface
+  to know if camera is not supported on the device or if certain sub feature inside
+  camera is not supported.
+
+maintainers:
+  - Naman Jain <quic_namajain@quicinc.com>
+
+properties:
+  $nodename:
+    const: qcom,platform-parts-info
+
+  qcom,subset-parts-names:
+    description:
+      List of part name strings, sorted in same order as the subset-parts property.
+      Parts here can be modem, camera, display etc. which are either partially supported
+      or not supported at all.
+    $ref: /schemas/types.yaml#/definitions/string-array
+    minItems: 1
+    maxItems: 13
+    items:
+      enum: [gpu, video, camera, display, audio, wlan, compute, sensors, npu, spss, nav, nsp, eva]
+
+  qcom,subset-parts:
+    description:
+      A matrix, with each row corresponding to a specific part type (GPU, Camera etc) mentioned
+      in subset-parts-names property. The number of rows here are expected to be same as number of
+      subset-parts-names provided. A row can contain multiple bitmask values representing
+      multiple parts of the same type, if supported on a platform, like 2 display panels, or
+      3 cameras for example.
+      Each bitmask value, has its 0th bit set if that part is completely not supported.
+      Otherwise, rest of the bits will correspond to specific functionalities
+      of that part not supported.
+      If the bitmask is 0xffff, i.e. all bits set, then that value is invalid and not to be
+      considered.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 13
+    items:
+      maxItems: 3
+      items:
+        description:
+          Bitmask value corresponding to a part of a specific part type, or 0xffff if data is
+          invalid and not to be considered.
+
+  qcom,subset-cores:
+    description:
+      A bitmask value, encoded from LSB with a set bit corresponding to actual physical CPU
+      not supported on the SoC.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - qcom,subset-cores
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+        qcom,platform-parts-info {                    /* populated by firmware */
+            qcom,subset-parts-names = "gpu", "display", "camera";
+            qcom,subset-parts = <0x1 0xffff 0xffff>,  /* GPU 1 is completely not supported */
+                                <0x0 0x1 0xffff>,     /* Display 2 is fully not supported */
+                                <0x30 0xffff 0xffff>; /* Camera 1 is partially supported */
+            qcom,subset-cores = <0x90>;               /* CPU 4 and 7 are not supported */
+        };
+    };
+...
-- 
2.17.1

