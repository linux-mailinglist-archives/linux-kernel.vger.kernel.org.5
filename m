Return-Path: <linux-kernel+bounces-31779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871A38333DC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D181C2125C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AD8EAF6;
	Sat, 20 Jan 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QwIM+OLE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0531DDA8;
	Sat, 20 Jan 2024 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705749695; cv=none; b=EAqyImsJdGjE3N6/YM1rP5W1Aw50A2nyZkfqtByxgXG/VdKtUkKYP6m/dwYjSn18lqYq6sFdI0IvsZ1dadKKQfQzqO0BxOW3LBxcAOsGJGmCHrtn9ynyyF3Xr0lShVfdkWeTF/rYcc77PKA3nwOGdz2qWp4uoc/ILk9p82Z22uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705749695; c=relaxed/simple;
	bh=VeJh7bhQMahxyNVxwPqjMr5BnLjO1Euedl/ywXjKduM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIdG3ZhfTS8iUvhDQZdRi+mQ/5ps+0I4KQ3PACzN1wE4MJ34zwLGGYkn8Le61kncqiugPffxi057SAf9EFOiWPGa3XqNmBCQqy0M4pTwlh8kgKx4iC9AMQmLTBMrPnair4047iZrKHtvQkW3dOxTgAbVcAPyS7/gee2b2uWeoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QwIM+OLE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40KAssXH001079;
	Sat, 20 Jan 2024 11:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=Pb7qgEHhgkCX46NdSFSp
	xy94/yixfRQ/QBM5uzpO9IY=; b=QwIM+OLE9igau3OQ4SxA5dhrpEhDl5brbXPt
	fQTNqYeNhvrCASRHvol4SmeEUym7Q1xk/ntLK6Ia71hMcT4B1VzraZ8HYxDUIxZp
	qIBXl0JPXihbGXMsNG83YQ0zwRtW8IpQEJVgriWFI/DWd9nmiomaF4X4gNW3c4nl
	i/eamJI9yH9482bNspHKXHyRWl58kg6dZ1+AvODpjO4N5127scApbmlyXz1z9uIg
	eKINZnrhtKi7h/X7GUVHsaTtLFxVImpQyNjUkzFGl1zaTS4W6zAjXxznsAYu+cYQ
	RNhUyy3S8ckP4e1CDeHfF4s/XXnq+ZKjFPc24Zu0MZlEskX3BQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr3ht0nr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 11:21:29 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40KBLSs4004127
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 11:21:28 GMT
Received: from hu-amrianan-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 20 Jan 2024 03:21:21 -0800
From: Amrit Anand <quic_amrianan@quicinc.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Amrit Anand
	<quic_amrianan@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH 2/2] dt-bindings: hwinfo: Add Qualcomm's board-id types
Date: Sat, 20 Jan 2024 16:50:49 +0530
Message-ID: <1705749649-4708-3-git-send-email-quic_amrianan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nx_ouLdjrKNNyTnvJz-FDjRH6642YcSq
X-Proofpoint-ORIG-GUID: nx_ouLdjrKNNyTnvJz-FDjRH6642YcSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-20_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401200092

Qualcomm based DT uses two or three different identifiers. The SoC
based idenfier which signifies chipset and the revision for those
chipsets. The board based identifier is used to distinguish different
boards (e.g. IDP, MTP) along with the different types of same boards.
The PMIC attached to the board can also be used as a identifier for
device tree.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
---
 .../devicetree/bindings/hwinfo/qcom,board-id.yaml  | 86 ++++++++++++++++++++++
 include/dt-bindings/arm/qcom,ids.h                 | 68 +++++++++++++++--
 2 files changed, 146 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml

diff --git a/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml b/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
new file mode 100644
index 0000000..807f134
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwinfo/qcom,board-id.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM Board Identifier for Devicetree Selection
+
+maintainers:
+  - Amrit Anand <quic_amrianan@quicinc.com>
+  - Elliot Berman <quic_eberman@quicinc.com>
+
+description: |
+  Qualcomm uses two and sometimes three hardware identifiers to describe
+  its boards
+      - a SoC identifier is used to match chipsets (e.g. sm8550 vs sm8450)
+      - a board identifier is used to match board form factor (e.g. MTP, QRD,
+        ADP, CRD)
+      - a PMIC identifier is occasionally used when different PMICs are used
+        for a given board/SoC combination.
+  Each field and helper macros are defined at::
+      - include/dt-bindings/arm/qcom,ids.h
+
+  For example,
+    / {
+        #board-id-cells = <2>;
+        board-id = <456 0>, <457 0>, <10 0>;
+        board-id-types = "qcom,soc-id", "qcom,soc-id", "qcom,board-id";
+     }
+
+allOf:
+  - $ref: board-id.yaml#
+
+properties:
+  board-id:
+    minItems: 2
+
+  board-id-types:
+    minItems: 2
+    items:
+      oneOf:
+        - const: qcom,soc-id
+          description: |
+            Matches Qualcomm Technologies, Inc. boards with the specified SoC.
+            2 integers are needed to describe a soc-id. The first integer is the
+            SoC ID and the second integer is the SoC revision.
+            qcom,soc-id = <soc-id  soc-revision>
+        - const: qcom,board-id
+          description: |
+            Matches Qualcomm Technologies, Inc. boards with the specified board.
+            2 integers are needed to describe a board-id. The first integer is the
+            board ID. The second integer is the board-subtype.
+            qcom,board-id = <board-id  board-subtype>
+        - const: qcom,pmic-id
+          description: |
+            QUALCOMM boards can be atached to mutliple PMICs where slave-id (SID)
+            indicates the address of the bus on which the PMIC is attached. It can be
+            any number. The model for a PMIC indicates the PMIC name attached to bus
+            described by SID along with  major and minor version. 2 integers are needed
+            to describe qcom,pmic-id. The first integer is the slave-id and the second integer
+            is the pmic model.
+            qcom,pmic-id = <pmic-sid pmic-model>
+
+  '#board-id-cells':
+    minimum: 2
+
+additionalProperties: true
+
+examples:
+   - |
+     #include <dt-bindings/arm/qcom,ids.h>
+     / {
+         model = "Qualcomm Technologies, Inc. sc7280 IDP SKU1 platform";
+         compatible = "qcom,sc7280-idp", "google,senor", "qcom,sc7280";
+
+         #board-id-cells = <2>;
+         board-id = <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(1)>,
+                    <QCOM_SOC_ID(SC7280) QCOM_SOC_REVISION(2)>,
+                    <QCOM_BOARD_ID(IDP, 1, 0) QCOM_BOARD_SUBTYPE(UFS, ANY, 1)>;
+         board-id-types = "qcom,soc-id",
+                          "qcom,soc-id",
+                          "qcom,board-id";
+
+         #address-cells = <2>;
+         #size-cells = <2>;
+      };
diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index f724834..c4cd440 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -8,9 +8,12 @@
 #define _DT_BINDINGS_ARM_QCOM_IDS_H
 
 /*
- * The MSM chipset and hardware revision used by Qualcomm bootloaders, DTS for
- * older chipsets (qcom,msm-id) and in socinfo driver:
+ * The MSM chipset ID used by Qualcomm bootloaders, DTS for
+ * older chipsets (soc-id) and in socinfo driver:
  */
+
+#define QCOM_SOC_ID(a)  ((QCOM_ID_##a) && 0xffff)
+
 #define QCOM_ID_MSM8260			70
 #define QCOM_ID_MSM8660			71
 #define QCOM_ID_APQ8060			86
@@ -266,16 +269,65 @@
 #define QCOM_ID_IPQ5302			595
 #define QCOM_ID_IPQ5300			624
 
+ /* The SOC revision used by Qualcomm bootloaders (soc-revision) */
+
+#define QCOM_SOC_REVISION(a)		(a & 0xff)
+
 /*
  * The board type and revision information, used by Qualcomm bootloaders and
- * DTS for older chipsets (qcom,board-id):
+ * DTS for older chipsets (board-id)
  */
+
 #define QCOM_BOARD_ID(a, major, minor) \
-	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | QCOM_BOARD_ID_##a)
+	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | ((QCOM_BOARD_ID_##a) & 0xff))
+
+#define QCOM_BOARD_ID_MTP		0x8
+#define QCOM_BOARD_ID_DRAGONBOARD	0x10
+#define QCOM_BOARD_ID_QRD		0x11
+#define QCOM_BOARD_ID_HDK		0x1F
+#define QCOM_BOARD_ID_ATP		0x21
+#define QCOM_BOARD_ID_IDP		0x22
+#define QCOM_BOARD_ID_SBC		0x24
+#define QCOM_BOARD_ID_QXR		0x26
+#define QCOM_BOARD_ID_CRD		0x28
+
+/*
+ * The platform subtype is used by Qualcomm bootloaders and
+ * DTS (board-subtype)
+ */
+#define QCOM_BOARD_SUBTYPE(a, b, SUBTYPE) \
+	(((QCOM_BOARD_BOOT_##a & 0xf) << 16) | ((QCOM_BOARD_DDRTYPE_##b & 0x7) << 8) | \
+	(SUBTYPE & 0xff))
+
+/* Board DDR Type where each value indicates higher limit */
+#define QCOM_BOARD_DDRTYPE_ANY		0x0
+#define QCOM_BOARD_DDRTYPE_128M		0x1
+#define QCOM_BOARD_DDRTYPE_256M		0x2
+#define QCOM_BOARD_DDRTYPE_512M		0x3
+#define QCOM_BOARD_DDRTYPE_1024M	0x4
+#define QCOM_BOARD_DDRTYPE_2048M	0x5
+#define QCOM_BOARD_DDRTYPE_3072M	0x6
+#define QCOM_BOARD_DDRTYPE_4096M	0x7
+
+/* Board Boot Device Type */
+#define QCOM_BOARD_BOOT_EMMC		0x0
+#define QCOM_BOARD_BOOT_UFS		0x1
+#define QCOM_BOARD_BOOT_NAND		0x2
+#define QCOM_BOARD_BOOT_OTHER		0x3
+
+/*
+ * The PMIC slave id is used by Qualcomm bootloaders to
+ * indicates which PMIC is attached (pmic-sid)
+ */
+
+#define QCOM_PMIC_SID(a)		(a & 0xff)
+
+/*
+ * The PMIC ID is used by Qualcomm bootloaders to describe the ID
+ * of PMIC attached to bus described by SID (pmic-model)
+ */
 
-#define QCOM_BOARD_ID_MTP			8
-#define QCOM_BOARD_ID_DRAGONBOARD		10
-#define QCOM_BOARD_ID_QRD			11
-#define QCOM_BOARD_ID_SBC			24
+#define QCOM_PMIC_MODEL(ID, major, minor) \
+	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | (ID & 0xff))
 
 #endif /* _DT_BINDINGS_ARM_QCOM_IDS_H */
-- 
2.7.4


