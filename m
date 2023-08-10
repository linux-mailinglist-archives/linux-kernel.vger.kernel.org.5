Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EAD777508
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjHJJ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjHJJ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:57:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211732127;
        Thu, 10 Aug 2023 02:57:06 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A9hqC2030429;
        Thu, 10 Aug 2023 09:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=stx5aJw+TjH6vEiDdJAveILMm05cAf8rbZ1FVfNqA1c=;
 b=k3EEc6Wb0mM/VaIPq93292ov9spKBEiklRUyYpxY3P3RiY5SDRLfKh1qg8zu61sTUc7C
 8mYaIN1d9EuQKHqJTf9HSQapSoEoOIRJ//edSHP55iRUXgbdGRJv2rMz5xmTjyXygtub
 EE/YpUp3ZFdap7iaxCIanJx0iwZkdlQFeaKssvMMKhWd6SpgS6GUbUedn1nDMdO50PK6
 tLl/C9aM8EbFfDR1gpr+NjxmroQLh4TCwdnUL2M1p426QvPxODajkoPpnrD4MCGTJ0EH
 mrwC3bJ4t5DBAbwvcu9Vl7OwvHReDYbjDePczK3yiYHzT//nS6xbJ0A8OSWSAo/CaCC1 5Q== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scsurrggj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 09:56:30 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A9uUCO029846
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 09:56:30 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 10 Aug 2023 02:56:23 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 1/5] dt-bindings: phy: qcom,m31: Document qcom,m31 USB phy
Date:   Thu, 10 Aug 2023 15:26:04 +0530
Message-ID: <0d42f556ab28123b2b508521a0c79c7597b8b0fd.1691660905.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1691660905.git.quic_varada@quicinc.com>
References: <cover.1691660905.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OqFjZX3V8m9m_WeS9qXeDYp9EefWxa9z
X-Proofpoint-GUID: OqFjZX3V8m9m_WeS9qXeDYp9EefWxa9z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_09,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the M31 USB2 phy present in IPQ5332.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v7:
	Move 'compatible' to be the first entry
	In the example have 'usb-phy' instead of 'usb2-phy'
	Add 'Reviewed-by: Krzysztof Kozlowski'
	'make dt_binding_check DT_SCHEMA_FILES=qcom,ipq5332-usb-hsphy.yaml' passed
	'make CHECK_DTBS=y DT_SCHEMA_FILES=qcom,ipq5332-usb-hsphy.yaml dtbs_check' passed
v6:
	Add 'Co-developed-by: Sricharan'
	Add 'const' to compatible, vdd-supply
	Remove label and use usb2-phy for nodename in the example
v5:
	Add '#phy-cells', to be able to use generic phy
	Remove 'Reviewed-by: Krzysztof Kozlowski' due to above change
v4:
	Move M31 URL to description
	Remove maxItems and relevant content from clock-names
	Change node name to generic name
	'make dt_binding_check DT_SCHEMA_FILES=qcom' passed
v3:
	Incorporate review comments. Will bring in ipq5018 compatible
	string while posting ipq5018 usb patchset.

v1:
	Rename qcom,m31.yaml -> qcom,ipq5332-usb-hsphy.yaml
	Drop default binding "m31,usb-hsphy"
	Add clock
	Remove 'oneOf' from compatible
	Remove 'qscratch' region from register space as it is not needed
	Remove reset-names
	Fix the example definition
---
 .../bindings/phy/qcom,ipq5332-usb-hsphy.yaml       | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
new file mode 100644
index 0000000..2671a04
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,ipq5332-usb-hsphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: M31 USB PHY
+
+maintainers:
+  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
+  - Varadarajan Narayanan <quic_varada@quicinc.com>
+
+description:
+  USB M31 PHY (https://www.m31tech.com) found in Qualcomm
+  IPQ5018, IPQ5332 SoCs.
+
+properties:
+  compatible:
+    items:
+      - const: qcom,ipq5332-usb-hsphy
+
+  "#phy-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: cfg_ahb
+
+  resets:
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      Phandle to 5V regulator supply to PHY digital circuit.
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
+    usb-phy@7b000 {
+        compatible = "qcom,ipq5332-usb-hsphy";
+        reg = <0x0007b000 0x12c>;
+
+        clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
+        clock-names = "cfg_ahb";
+
+        #phy-cells = <0>;
+
+        resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
+
+        vdd-supply = <&regulator_fixed_5p0>;
+    };
-- 
2.7.4

