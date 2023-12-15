Return-Path: <linux-kernel+bounces-556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A36CD8142E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C818B1C223F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D6A2EAEA;
	Fri, 15 Dec 2023 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="htNYVwBU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1430331;
	Fri, 15 Dec 2023 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF6HWWf022899;
	Fri, 15 Dec 2023 07:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=AhES8Y7x+ZpiqbfFpeHU+5rxqGlvKWJu/Mp3zVbaca0=; b=ht
	NYVwBUG0MhcA8iKOg1xpcqrFYN6/1YfR1xwe8qABPDcfFb4yXmPn+ysVsWwwrnR0
	nuKeW0cM6q4GQuGy7ATn1uyOgNvGeDUZHvw9cIdsviuSNBEfJgvsH/254mKykPvD
	JXG/tOAvrY6HUaOf03lUQ7oB3dYsZr3k3AD2qDcOlYGCQYwd/qiavUlSRV4Gcfp4
	jjR9kgtZCgSDEUXJ7Njro+gaVHS5ktzpCGsvp8bubUT0rP4WD3ugBzR3J9sXv9p6
	MSwn/MpBo/HRq/SNNW+ed/pa91lbsmJ39xTa7BqpqNDkMQzVDapGkl7UCZrjFP1B
	jB6R2gS6XC+Z6MV6kJmg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0741jcym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:41:28 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF7fRMf022408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:41:27 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 23:41:23 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v8 14/14] dt-bindings: net: ar803x: add qca8084 PHY properties
Date: Fri, 15 Dec 2023 15:40:04 +0800
Message-ID: <20231215074005.26976-15-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215074005.26976-1-quic_luoj@quicinc.com>
References: <20231215074005.26976-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yx8mAsx_35qSXdlQGbbb70N0gxc5x5Qj
X-Proofpoint-GUID: yx8mAsx_35qSXdlQGbbb70N0gxc5x5Qj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=728
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150047

The following properties are added for qca8084 PHY.

1. add the compatible string "ethernet-phy-id004d.d180" since
   the PHY device is not accessible during MDIO bus register.
2. add property "qcom,phy-addr-fixup" for customizing MDIO address.
3. add property "qcom,phy-work-mode" for specifying qca8084 PHY
   work mode.
4. add the initial clocks and resets.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 .../devicetree/bindings/net/qca,ar803x.yaml   | 158 +++++++++++++++++-
 1 file changed, 155 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qca,ar803x.yaml b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
index 3acd09f0da86..febff039a44f 100644
--- a/Documentation/devicetree/bindings/net/qca,ar803x.yaml
+++ b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
@@ -14,9 +14,6 @@ maintainers:
 description: |
   Bindings for Qualcomm Atheros AR803x PHYs
 
-allOf:
-  - $ref: ethernet-phy.yaml#
-
 properties:
   qca,clk-out-frequency:
     description: Clock output frequency in Hertz.
@@ -85,6 +82,161 @@ properties:
     $ref: /schemas/regulator/regulator.yaml
     unevaluatedProperties: false
 
+  qcom,phy-addr-fixup:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      MDIO address for 4 PHY devices and 3 PCS devices
+
+  qcom,phy-work-mode:
+    description: PHY device work mode.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  clocks:
+    items:
+      - description: APB bridge clock
+      - description: AHB clock
+      - description: Security control clock
+      - description: TLMM clock
+      - description: TLMM AHB clock
+      - description: CNOC AHB clock
+      - description: MDIO AHB clock
+      - description: MDIO master AHB clock
+      - description: PCS0 system clock
+      - description: PCS1 system clock
+      - description: EPHY0 system clock
+      - description: EPHY1 system clock
+      - description: EPHY2 system clock
+      - description: EPHY3 system clock
+    description: PHY initial common clock configs
+
+  clock-names:
+    items:
+      - const: apb_bridge
+      - const: ahb
+      - const: sec_ctrl_ahb
+      - const: tlmm
+      - const: tlmm_ahb
+      - const: cnoc_ahb
+      - const: mdio_ahb
+      - const: mdio_master_ahb
+      - const: srds0_sys
+      - const: srds1_sys
+      - const: gephy0_sys
+      - const: gephy1_sys
+      - const: gephy2_sys
+      - const: gephy3_sys
+
+  resets:
+    items:
+      - description: PCS0 system reset
+      - description: PCS1 system reset
+      - description: EPHY0 system reset
+      - description: EPHY1 system reset
+      - description: EPHY2 system reset
+      - description: EPHY3 system reset
+      - description: EPHY0 software reset
+      - description: EPHY1 software reset
+      - description: EPHY2 software reset
+      - description: EPHY3 software reset
+      - description: Ethernet DSP reset
+    description: PHY initial common reset configs
+
+  reset-names:
+    items:
+      - const: srds0_sys
+      - const: srds1_sys
+      - const: gephy0_sys
+      - const: gephy1_sys
+      - const: gephy2_sys
+      - const: gephy3_sys
+      - const: gephy0_soft
+      - const: gephy1_soft
+      - const: gephy2_soft
+      - const: gephy3_soft
+      - const: gephy_dsp
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ethernet-phy-id004d.d180
+    then:
+      properties:
+        clocks:
+          items:
+            - description: APB bridge clock
+            - description: AHB clock
+            - description: Security control clock
+            - description: TLMM clock
+            - description: TLMM AHB clock
+            - description: CNOC AHB clock
+            - description: MDIO AHB clock
+            - description: MDIO master AHB clock
+            - description: PCS0 system clock
+            - description: PCS1 system clock
+            - description: EPHY0 system clock
+            - description: EPHY1 system clock
+            - description: EPHY2 system clock
+            - description: EPHY3 system clock
+        clock-names:
+          items:
+            - const: apb_bridge
+            - const: ahb
+            - const: sec_ctrl_ahb
+            - const: tlmm
+            - const: tlmm_ahb
+            - const: cnoc_ahb
+            - const: mdio_ahb
+            - const: mdio_master_ahb
+            - const: srds0_sys
+            - const: srds1_sys
+            - const: gephy0_sys
+            - const: gephy1_sys
+            - const: gephy2_sys
+            - const: gephy3_sys
+        resets:
+          items:
+            - description: PCS0 system reset
+            - description: PCS1 system reset
+            - description: EPHY0 system reset
+            - description: EPHY1 system reset
+            - description: EPHY2 system reset
+            - description: EPHY3 system reset
+            - description: EPHY0 software reset
+            - description: EPHY1 software reset
+            - description: EPHY2 software reset
+            - description: EPHY3 software reset
+            - description: Ethernet DSP reset
+        reset-names:
+          items:
+            - const: srds0_sys
+            - const: srds1_sys
+            - const: gephy0_sys
+            - const: gephy1_sys
+            - const: gephy2_sys
+            - const: gephy3_sys
+            - const: gephy0_soft
+            - const: gephy1_soft
+            - const: gephy2_soft
+            - const: gephy3_soft
+            - const: gephy_dsp
+      required:
+        - qcom,phy-addr-fixup
+        - qcom,phy-work-mode
+        - clocks
+        - clock-names
+        - resets
+        - reset-names
+    else:
+      properties:
+        qcom,phy-addr-fixup: false
+        qcom,phy-work-mode: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.42.0


