Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284FE75BD5B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjGUEgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjGUEga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:36:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96286272C;
        Thu, 20 Jul 2023 21:36:26 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L4SMwC017265;
        Fri, 21 Jul 2023 04:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=3cijBh2MYUWWKASGgVcdl1Q7Qpp17tWUCe4igEBC22w=;
 b=SIj5YZ54ab/cKMA940Eja7piILFCVzkeglRlbBr8GwxNRCC60HpHatWCcAFhS/jeLtwx
 jODQucTkQw5cQHWkHND9YoRGH3xgceOfq06aX4i3FI5uhLyEWiMCe6h19ZSM+i88p8Wo
 gvsRmkhFSpqAMYYIhf9JpFJDiBtcD1Pswl+9t4GVbtDzzE/wzrG9xBb3WPA4h73yti2Z
 Tv4q0ZRRkFIS2V/L40qnV3Vj57joE6O8PN8+Wuuq2QYAvH3uLSeL49yuUURZ/Rh3huHo
 ohb9EuWekVkid3tlSvu+r19/utDuEHU7AFxSo9UvMDX62D3HMf9eEGt11gyegGXHbGBy mA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxup4k2c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 04:36:02 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L4a0xO017807
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 04:36:00 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 21:35:53 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <rafal@milecki.pl>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 2/6] dt-bindings: phy: qcom,m31: Document qcom,m31 USB phy
Date:   Fri, 21 Jul 2023 10:05:27 +0530
Message-ID: <131eb1694229436919ac88bb9920fb54d6808388.1689913334.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1689913334.git.quic_varada@quicinc.com>
References: <cover.1689913334.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qqv4lGOLG0vOSDoZpVZYf9nvQWty-t_L
X-Proofpoint-ORIG-GUID: Qqv4lGOLG0vOSDoZpVZYf9nvQWty-t_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_01,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the M31 USB2 phy present in IPQ5332.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
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
 .../bindings/phy/qcom,ipq5332-usb-hsphy.yaml       | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
new file mode 100644
index 0000000..e0b282b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
@@ -0,0 +1,51 @@
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
+  "#phy-cells":
+    const: 0
+
+  compatible:
+    enum:
+      - qcom,ipq5332-usb-hsphy
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
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
+    usbphy0: usb-phy@7b000 {
+        compatible = "qcom,ipq5332-usb-hsphy";
+        reg = <0x0007b000 0x12c>;
+
+        clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
+        clock-names = "cfg_ahb";
+
+        resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
+    };
-- 
2.7.4

