Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E697E7526DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjGMP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbjGMP0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:26:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A0B30E1;
        Thu, 13 Jul 2023 08:26:20 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DCraUi007421;
        Thu, 13 Jul 2023 15:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=fgQQD5BT6zHmZYJ4hIT1i+LyHKGipeMbg1HN10ft5Ds=;
 b=PEE8bReNRuQCUOpT5qbG5Qe3IO3PakWiBpSwJh7RN1d4NB7eXxycGT8nJZALDTFmpxfe
 WOg52q2nqbeGYV9XhReCp0SVJaKqS4TXnZRKxS4o4RBuLtrpnIKTE7Yzq0xQiTRZlylh
 im83pNw8cTUco+8NM4af+zOpccZ/BbI4pJOYv8zbPEr2xtSSAqL7JqlzUqoeXG5Bbd/J
 hIi67YYfysyP7jtYT8QIltCzIFZaDxMlxtIjw3Vbth3xKjRr5WRDwlrCTqUe8PWqKMdc
 moIspFCXQP091QcMDYYQ5rOz2uFBUtey+mo/SErNeCwblT3g7WG276lcf4gsonGoUNqK Yw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rt3qfhuyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 15:26:16 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DFQGq4006195
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 15:26:16 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 08:26:12 -0700
From:   Sridharan S N <quic_sridsn@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sridharan S N <quic_sridsn@quicinc.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: ipq9574: add support for the RDP417 variant
Date:   Thu, 13 Jul 2023 20:55:22 +0530
Message-ID: <20230713152522.1063154-3-quic_sridsn@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713152522.1063154-1-quic_sridsn@quicinc.com>
References: <20230713152522.1063154-1-quic_sridsn@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YyGTFzy2jC29qkR2YbGM3gykmbdnKF_-
X-Proofpoint-GUID: YyGTFzy2jC29qkR2YbGM3gykmbdnKF_-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501 mlxlogscore=732
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130135
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree support for the Reference Design
Platform(RDP) 417 based on IPQ9574 family of SoC.

Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
---
changes in v2:
	- updated commit message.Moved dependency to change log
	  This patch depends on below patchset:
	  https://lore.kernel.org/lkml/20230713105909.14209-2-quic_anusha@quicinc.com/
	

 arch/arm64/boot/dts/qcom/Makefile           |  1 +
 arch/arm64/boot/dts/qcom/ipq9574-rdp417.dts | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp417.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 337abc4ceb17..9c30344d08c1 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp417.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp418.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp417.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp417.dts
new file mode 100644
index 000000000000..9a5d4c3db1f2
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp417.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * IPQ9574 RDP417 board device tree source
+ *
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "ipq9574-rdp-common.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL01-C1";
+	compatible = "qcom,ipq9574-ap-al01-c1", "qcom,ipq9574";
+};
-- 
2.34.1

