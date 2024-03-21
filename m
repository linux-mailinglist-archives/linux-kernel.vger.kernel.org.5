Return-Path: <linux-kernel+bounces-109649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B6881BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A798D1C2164F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023282DF84;
	Thu, 21 Mar 2024 04:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YRERZmAm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F413BBC2;
	Thu, 21 Mar 2024 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710995570; cv=none; b=F67Hdl2953vVLgY7ARrV6jDGBjwYIHWVoF+V9zqUJ2V8RvH3SL7ORnX37ikN54C3GYoQF+PrD1mUarVbC0Hr/vDcO0CXJPDpDT3sNMVXCI/RHlwhVXtNfDnyqjpnPIhXB2BOsSUXDKTj6VElhQ4IUn0rZ/uwjMKrOtJIOqlimUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710995570; c=relaxed/simple;
	bh=6sK+tydVrHtCMmvWhxj1Qcyt7xJBmGedcVSAZPA5fQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvyv9FkAcE9jhoavaln4TSZobB0l3ihhBhA/w3Wp/CpcEnLF+aM97aiZ75svCbGO0eFFnJscHpIZ1vrUhj8T6xuQCRwmaVevt7L6Jj25P6N29/jw5GTfaBBehoNK5/s6ZgTVF/kaA625yr9IYR0KMsri5Zb4fZBm3uG5jUtOyvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YRERZmAm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42L2liKm017055;
	Thu, 21 Mar 2024 04:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=rxRJZt8WAFgOWZcEnhy6zK6+2BF7Upegn9AEcsxuO3w=; b=YR
	ERZmAmfPav6udT9FuQc0Gvnk/KoVNH3KvAMBdww1K1S/SdYIjIgREBp6j8p2105e
	i8QX1qVJRG52kx15akTYXOvMI8pIi4y8508n8f5v8ghIdVyj2e8HNY73TUkYASN2
	f9iRWDuDriGx4em7SiA3Wpyf5+qJ58/hVLRaY4eR+hAADXhnGzDb4YsxzNrnWsqt
	3974XRidn0hpha0Nr1N2PMLkan6aW28I2kJGOZ87kDPashLQXfvL9laCodyKP9hg
	J9NaDffAfdo6yn4qA8lkTfbWEz1PAJEy1DjfATH/g5i5pI6egJ5DJITJ4mO6Pv8q
	oE7XUtCDGY/LAmZp3w1g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyxq92122-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 04:32:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42L4Wg4r029377
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 04:32:43 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 21:32:38 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <djakov@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 2/2] clk: qcom: add IPQ9574 interconnect clocks support
Date: Thu, 21 Mar 2024 10:01:49 +0530
Message-ID: <20240321043149.2739204-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321043149.2739204-1-quic_varada@quicinc.com>
References: <20240321043149.2739204-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 42bWRczlBXmHoXRCekydr70oaTlrGL2J
X-Proofpoint-GUID: 42bWRczlBXmHoXRCekydr70oaTlrGL2J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_01,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210028

Unlike MSM platforms that manage NoC related clocks and scaling
from RPM, IPQ SoCs dont involve RPM in managing NoC related
clocks and there is no NoC scaling.

However, there is a requirement to enable some NoC interface
clocks for accessing the peripheral controllers present on
these NoCs.

Hence adding a minimalistic interconnect driver that can enable
the relevant clocks. This is similar to msm8996-cbf's usage of
icc-clk framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi |  2 +
 drivers/clk/qcom/gcc-ipq9574.c        | 75 ++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 7f2e5cbf3bbb..efffbd085715 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/interconnect/qcom,ipq9574.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -306,6 +307,7 @@ gcc: clock-controller@1800000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			#interconnect-cells = <1>;
 		};
 
 		tcsr_mutex: hwlock@1905000 {
diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 0a3f846695b8..edbf223719e4 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -9,9 +9,16 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#if IS_ENABLED(CONFIG_INTERCONNECT)
+#include <linux/interconnect-clk.h>
+#include <linux/interconnect-provider.h>
+#endif
 
 #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
 #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
+#if IS_ENABLED(CONFIG_INTERCONNECT)
+#include <dt-bindings/interconnect/qcom,ipq9574.h>
+#endif
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
@@ -4301,6 +4308,35 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
 	[GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
 };
 
+
+#if IS_ENABLED(CONFIG_INTERCONNECT)
+static struct icc_clk_data *icc_ipq9574;
+
+static int noc_clks[] = {
+	GCC_ANOC_PCIE0_1LANE_M_CLK,
+	GCC_SNOC_PCIE0_1LANE_S_CLK,
+	GCC_ANOC_PCIE1_1LANE_M_CLK,
+	GCC_SNOC_PCIE1_1LANE_S_CLK,
+	GCC_ANOC_PCIE2_2LANE_M_CLK,
+	GCC_SNOC_PCIE2_2LANE_S_CLK,
+	GCC_ANOC_PCIE3_2LANE_M_CLK,
+	GCC_SNOC_PCIE3_2LANE_S_CLK,
+	GCC_SNOC_USB_CLK,
+	GCC_ANOC_USB_AXI_CLK,
+	GCC_NSSNOC_NSSCC_CLK,
+	GCC_NSSNOC_SNOC_CLK,
+	GCC_NSSNOC_SNOC_1_CLK,
+	GCC_NSSNOC_PCNOC_1_CLK,
+	GCC_NSSNOC_QOSGEN_REF_CLK,
+	GCC_NSSNOC_TIMEOUT_REF_CLK,
+	GCC_NSSNOC_XO_DCD_CLK,
+	GCC_NSSNOC_ATB_CLK,
+	GCC_MEM_NOC_NSSNOC_CLK,
+	GCC_NSSNOC_MEMNOC_CLK,
+	GCC_NSSNOC_MEM_NOC_1_CLK,
+};
+#endif
+
 static const struct of_device_id gcc_ipq9574_match_table[] = {
 	{ .compatible = "qcom,ipq9574-gcc" },
 	{ }
@@ -4327,7 +4363,44 @@ static const struct qcom_cc_desc gcc_ipq9574_desc = {
 
 static int gcc_ipq9574_probe(struct platform_device *pdev)
 {
-	return qcom_cc_probe(pdev, &gcc_ipq9574_desc);
+	int ret = qcom_cc_probe(pdev, &gcc_ipq9574_desc);
+#if IS_ENABLED(CONFIG_INTERCONNECT)
+	struct icc_provider *provider;
+	struct icc_clk_data *icd;
+	int i;
+#endif
+
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "%s failed\n", __func__);
+
+#if IS_ENABLED(CONFIG_INTERCONNECT)
+	icd = devm_kmalloc(&pdev->dev, ARRAY_SIZE(noc_clks) * sizeof(*icd),
+			   GFP_KERNEL);
+
+	if (IS_ERR_OR_NULL(icd))
+		return dev_err_probe(&pdev->dev, PTR_ERR(icd),
+				     "%s malloc failed\n", __func__);
+
+	icc_ipq9574 = icd;
+
+	for (i = 0; i < ARRAY_SIZE(noc_clks); i++, icd++) {
+		icd->clk = gcc_ipq9574_clks[noc_clks[i]]->hw.clk;
+		if (IS_ERR_OR_NULL(icd->clk)) {
+			dev_err(&pdev->dev, "%s: %d clock not found\n",
+				__func__, noc_clks[i]);
+			return -ENOENT;
+		}
+		icd->name = clk_hw_get_name(&gcc_ipq9574_clks[noc_clks[i]]->hw);
+	}
+
+	provider = icc_clk_register(&pdev->dev, IPQ_APPS_ID,
+				    ARRAY_SIZE(noc_clks), icc_ipq9574);
+	if (IS_ERR_OR_NULL(provider))
+		return dev_err_probe(&pdev->dev, PTR_ERR(provider),
+				     "%s: icc_clk_register failed\n", __func__);
+#endif
+
+	return 0;
 }
 
 static struct platform_driver gcc_ipq9574_driver = {
-- 
2.34.1


