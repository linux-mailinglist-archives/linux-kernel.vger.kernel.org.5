Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E77D6E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344265AbjJYNvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbjJYNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:51:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644B8138;
        Wed, 25 Oct 2023 06:51:29 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PDPmu2027498;
        Wed, 25 Oct 2023 13:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qYoNQFyaTKWoaL1KdcbY+vDyHv9twMsvelnP25RT1fo=;
 b=THxRIvwkZE2B/kCUbwmpgrHWcp8YO/GFQYbtLR7PzyRi69Hgbq0sToBsUcVpprU5cpEW
 ehmqhMfNDTMni+PwyWXiLiLL3Dh4rWuVwP4jLtryWmooCsUJUqJZ+fZF2BY+cOfjkmnV
 j1ewdMK4Zv02RPFoIwVQsBUHVO7adCLnSPxvCH5EZqxNawJ8CbXGok1yjcRtMqtd5JYY
 PrEO/h3eEinfaPL0J3/lNxN5dzE8ETkPkHs9aQloKoB1c7vbPcFzIvFW61WBsWFG/dU4
 wFj4nscy4ahxaKkuBzpFiKiEhOf+jUvmG2Si75t5OxcMeG4g4Jq+Niw3iiCMiJuMehjt yw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txngvhm34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:51:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39PDpNRf011802
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:51:23 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 25 Oct 2023 06:51:18 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>, <abel.vesa@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <quic_tsoni@quicinc.com>, <neil.armstrong@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add SC8380XP pinctrl
Date:   Wed, 25 Oct 2023 19:20:57 +0530
Message-ID: <20231025135058.11268-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025135058.11268-1-quic_sibis@quicinc.com>
References: <20231025135058.11268-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w2wooklxVuPKtQbSB08Y9Qg56nI4rZKB
X-Proofpoint-ORIG-GUID: w2wooklxVuPKtQbSB08Y9Qg56nI4rZKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1011 adultscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <quic_rjendra@quicinc.com>

Add device tree binding Documentation details for Qualcomm SC8380XP TLMM
device

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 .../bindings/pinctrl/qcom,sc8380xp-tlmm.yaml  | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc8380xp-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8380xp-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8380xp-tlmm.yaml
new file mode 100644
index 000000000000..098d3b91e8d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8380xp-tlmm.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sc8380xp-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SC8380XP TLMM block
+
+maintainers:
+  - Rajendra Nayak <quic_rjendra@quicinc.com>
+
+description:
+  Top Level Mode Multiplexer pin controller in Qualcomm SC8380XP SoC.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sc8380xp-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+  interrupt-controller: true
+  "#interrupt-cells": true
+  gpio-controller: true
+
+  gpio-reserved-ranges:
+    minItems: 1
+    maxItems: 119
+
+  gpio-line-names:
+    maxItems: 238
+
+  "#gpio-cells": true
+  gpio-ranges: true
+  wakeup-parent: true
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sc8380xp-tlmm-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sc8380xp-tlmm-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sc8380xp-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
+    unevaluatedProperties: false
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-2][0-9]|23[0-7])$"
+            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+        enum: [ aon_cci, aoss_cti, atest_char, atest_char0,
+                atest_char1, atest_char2, atest_char3, atest_usb,
+                audio_ext, audio_ref, cam_aon, cam_mclk, cci_async,
+                cci_i2c, cci_timer0, cci_timer1, cci_timer2, cci_timer3,
+                cci_timer4, cmu_rng0, cmu_rng1, cmu_rng2, cmu_rng3,
+                cri_trng, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
+                ddr_pxi2, ddr_pxi3, ddr_pxi4, ddr_pxi5, ddr_pxi6, ddr_pxi7,
+                edp0_hot, edp0_lcd, edp1_hot, edp1_lcd, eusb0_ac, eusb1_ac,
+                eusb2_ac, eusb3_ac, eusb5_ac, eusb6_ac, gcc_gp1, gcc_gp2,
+                gcc_gp3, gpio, i2s0_data0, i2s0_data1, i2s0_sck, i2s0_ws, i2s1_data0,
+                i2s1_data1, i2s1_sck, i2s1_ws, ibi_i3c, jitter_bist, mdp_vsync0,
+                mdp_vsync1, mdp_vsync2, mdp_vsync3, mdp_vsync4, mdp_vsync5,
+                mdp_vsync6, mdp_vsync7, mdp_vsync8, pcie3_clk, pcie4_clk,
+                pcie5_clk, pcie6a_clk, pcie6b_clk, phase_flag, pll_bist, pll_clk,
+                prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, qdss_cti,
+                qdss_gpio, qspi00, qspi01, qspi02, qspi03, qspi0_clk, qspi0_cs0,
+                qspi0_cs1, qup0_se0, qup0_se1, qup0_se2, qup0_se3, qup0_se4,
+                qup0_se5, qup0_se6, qup0_se7, qup1_se0, qup1_se1, qup1_se2, qup1_se3,
+                qup1_se4, qup1_se5, qup1_se6, qup1_se7, qup2_se0, qup2_se1, qup2_se2,
+                qup2_se3, qup2_se4, qup2_se5, qup2_se6, qup2_se7, sd_write, sdc4_clk,
+                sdc4_cmd, sdc4_data0, sdc4_data1, sdc4_data2, sdc4_data3, sys_throttle,
+                tb_trig, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3, tgu_ch4, tgu_ch5,
+                tgu_ch6, tgu_ch7, tmess_prng0, tmess_prng1, tmess_prng2, tmess_prng3,
+                tsense_pwm1, tsense_pwm2, sense_pwm3, tsense_pwm4, usb0_dp, usb0_phy,
+                usb0_sbrx, usb0_sbtx, usb1_dp, usb1_phy, usb1_sbrx, usb1_sbtx,
+                usb2_dp, usb2_phy, usb2_sbrx, usb2_sbtx, vsense_trigger ]
+
+    required:
+      - pins
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    tlmm: pinctrl@f100000 {
+        compatible = "qcom,sc8380xp-tlmm";
+        reg = <0x0f100000 0xf00000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&tlmm 0 0 239>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+        gpio-wo-state {
+            pins = "gpio1";
+            function = "gpio";
+        };
+
+        uart-w-state {
+            rx-pins {
+                pins = "gpio26";
+                function = "qup2_se7";
+                bias-pull-up;
+            };
+
+            tx-pins {
+                pins = "gpio27";
+                function = "qup2_se7";
+                bias-disable;
+            };
+        };
+    };
+...
-- 
2.17.1

