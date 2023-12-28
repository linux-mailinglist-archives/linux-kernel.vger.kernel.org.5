Return-Path: <linux-kernel+bounces-12432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A3E81F4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C096B21AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 05:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9165666;
	Thu, 28 Dec 2023 05:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TwsBOJFt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF71FDC;
	Thu, 28 Dec 2023 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BS4QWWb001581;
	Thu, 28 Dec 2023 05:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=cuR4EwC1nbWYU9VZ+F23XRwCskQ3HdcANY3zrRt+aMw=; b=Tw
	sBOJFtQKbGFism3UKB2yEe89vYNVnXRbHTXpdSOjHmGSJY0q3VMvKr3sAYOrhXua
	Xa8WVaQIph8nPNMnlaqm1eTa3aekYaxrEuDBB1l+PPYf4oFldyvqLcPCgi9nsocX
	eBQsqL8reaF/1ykJFnh6YKmgcsH5mXL/ubiZrzyyvF3SsieIXrOE0S/aWpFNXZpJ
	vydszvE2gZen1TKEKXnXtcLwSG3S984Rc7phlGHdaoYcXpWeX3Iu5Z0LSNDPl+rq
	HOt37IkPMqMtq3/UxHYiygrBuWHNwZLRgdUOyf/P+JRs6Ho7n7PF9H0jnFnDrbus
	5TvZDBr7eO3uUl89J2CQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v8atftm8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Dec 2023 05:42:43 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BS5geWt015297;
	Thu, 28 Dec 2023 05:42:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3v5rmkwkaq-1;
	Thu, 28 Dec 2023 05:42:40 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BS5geh1015291;
	Thu, 28 Dec 2023 05:42:40 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3BS5gdHi015290;
	Thu, 28 Dec 2023 05:42:40 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id 0F7E956F0; Thu, 28 Dec 2023 13:42:39 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, quic_qianyu@quicinc.com
Subject: [PATCH 1/2] phy: qcom: qmp-pcie: Update PCIe1 PHY settings for SM8550
Date: Thu, 28 Dec 2023 13:42:36 +0800
Message-Id: <1703742157-69840-2-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1703742157-69840-1-git-send-email-quic_qianyu@quicinc.com>
References: <1703742157-69840-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3Xaf2Xclvu_f02ngsWv5ybWQF7e3Krrc
X-Proofpoint-GUID: 3Xaf2Xclvu_f02ngsWv5ybWQF7e3Krrc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=648 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312280043
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Can Guo <quic_cang@quicinc.com>

Align PCIe1 PHY settings with SM8550 latest PCIe PHY Hardware Programming
Guide.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c               | 16 +++++++++++-----
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h     |  2 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h          |  1 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h |  2 ++
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 2af7115..5f87ebc 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1823,10 +1823,9 @@ static const struct qmp_phy_init_tbl sm8550_qmp_gen4x2_pcie_serdes_tbl[] = {
 
 static const struct qmp_phy_init_tbl sm8550_qmp_gen4x2_pcie_ln_shrd_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RXCLK_DIV2_CTRL, 0x01),
-	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_Q_EN_RATES, 0xe),
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_DFE_DAC_ENABLE1, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH1, 0x00),
-	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH2, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_TX_ADAPT_POST_THRESH2, 0x0d),
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B0, 0x12),
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B1, 0x12),
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MODE_RATE_0_1_B2, 0xdb),
@@ -1843,6 +1842,7 @@ static const struct qmp_phy_init_tbl sm8550_qmp_gen4x2_pcie_ln_shrd_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH4_RATE3, 0x1f),
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH5_RATE3, 0x1f),
 	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_MARG_COARSE_THRESH6_RATE3, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_LN_SHRD_RX_SUMMER_CAL_SPD_MODE, 0x5b),
 };
 
 static const struct qmp_phy_init_tbl sm8550_qmp_gen4x2_pcie_tx_tbl[] = {
@@ -1855,13 +1855,15 @@ static const struct qmp_phy_init_tbl sm8550_qmp_gen4x2_pcie_tx_tbl[] = {
 };
 
 static const struct qmp_phy_init_tbl sm8550_qmp_gen4x2_pcie_rx_tbl[] = {
-	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_2, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_2, 0x0c),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_FO_GAIN_RATE_3, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_SO_GAIN_RATE_2, 0x04),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_PI_CONTROLS, 0x16),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_UCDR_SO_ACC_DEFAULT_VAL_RATE3, 0x00),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_IVCM_CAL_CTRL2, 0x80),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_IVCM_POSTCAL_OFFSET, 0x7c),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_DFE_3, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_TX_ADPT_CTRL, 0x10),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_VGA_CAL_MAN_VAL, 0x0a),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_GM_CAL, 0x0d),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_EQU_ADAPTOR_CNTRL4, 0x0b),
@@ -1883,11 +1885,13 @@ static const struct qmp_phy_init_tbl sm8550_qmp_gen4x2_pcie_rx_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B4, 0x78),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B5, 0x76),
 	QMP_PHY_INIT_CFG(QSERDES_V6_20_RX_MODE_RATE3_B6, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V6_20_VGA_CAL_CNTRL1, 0x00),
 };
 
 static const struct qmp_phy_init_tbl sm8550_qmp_gen4x2_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_G12S1_TXDEEMPH_M6DB, 0x17),
 	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_G3S2_PRE_GAIN, 0x2e),
-	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_COM_ELECIDLE_DLY_SEL, 0x25),
+	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_RX_SIGDET_LVL, 0xcc),
 	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_EQ_CONFIG4, 0x00),
 	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_EQ_CONFIG5, 0x22),
 	QMP_PHY_INIT_CFG(QPHY_V6_20_PCS_TX_RX_CONFIG1, 0x04),
@@ -1898,6 +1902,8 @@ static const struct qmp_phy_init_tbl sm8550_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_DRIVE, 0xc1),
 	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_OSC_DTCT_ATCIONS, 0x00),
 	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_EQ_CONFIG1, 0x16),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G3_RXEQEVAL_TIME, 0x27),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_RXEQEVAL_TIME, 0x27),
 	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_EQ_CONFIG5, 0x02),
 	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_PRE_GAIN, 0x2e),
 	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG1, 0x03),
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
index e3eb087..dfcecf3 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h
@@ -12,6 +12,8 @@
 #define QPHY_PCIE_V6_20_PCS_ENDPOINT_REFCLK_DRIVE	0x01c
 #define QPHY_PCIE_V6_20_PCS_OSC_DTCT_ATCIONS		0x090
 #define QPHY_PCIE_V6_20_PCS_EQ_CONFIG1			0x0a0
+#define QPHY_PCIE_V6_20_PCS_G3_RXEQEVAL_TIME		0x0f0
+#define QPHY_PCIE_V6_20_PCS_G4_RXEQEVAL_TIME		0x0f4
 #define QPHY_PCIE_V6_20_PCS_EQ_CONFIG5			0x108
 #define QPHY_PCIE_V6_20_PCS_G4_PRE_GAIN			0x15c
 #define QPHY_PCIE_V6_20_PCS_RX_MARGINING_CONFIG1	0x17c
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
index 9c3f1e4..4d9615c 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h
@@ -7,6 +7,7 @@
 #define QCOM_PHY_QMP_PCS_V6_20_H_
 
 /* Only for QMP V6_20 PHY - USB/PCIe PCS registers */
+#define QPHY_V6_20_PCS_G12S1_TXDEEMPH_M6DB		0x170
 #define QPHY_V6_20_PCS_G3S2_PRE_GAIN			0x178
 #define QPHY_V6_20_PCS_RX_SIGDET_LVL			0x190
 #define QPHY_V6_20_PCS_COM_ELECIDLE_DLY_SEL		0x1b8
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
index 6ed5339..7bac5d5 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h
@@ -23,6 +23,8 @@
 #define QSERDES_V6_20_RX_DFE_1					0xac
 #define QSERDES_V6_20_RX_DFE_2					0xb0
 #define QSERDES_V6_20_RX_DFE_3					0xb4
+#define QSERDES_V6_20_RX_TX_ADPT_CTRL				0xd4
+#define QSERDES_V6_20_VGA_CAL_CNTRL1				0xe0
 #define QSERDES_V6_20_RX_VGA_CAL_MAN_VAL			0xe8
 #define QSERDES_V6_20_RX_GM_CAL					0x10c
 #define QSERDES_V6_20_RX_EQU_ADAPTOR_CNTRL4			0x120
-- 
2.7.4


