Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D179377E595
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbjHPPtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344325AbjHPPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:49:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEA226AD;
        Wed, 16 Aug 2023 08:49:01 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G5dcPK026811;
        Wed, 16 Aug 2023 15:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=UzTnNEDZCMATJ+B32eTcnoAxnAyB4+7H/HLlq+n5NQg=;
 b=aA7uBPrhAD2QrF9kflQxv6ixET580kzZXdrwcR3woUBOPbE2N6We86/cg0Jnq4Vp2H1v
 ACY+wg8hY3wwDZ2fxg84ZfTtG2joFBcauxXfaZLt3QEPEM53Pb6pU9ZQkU0iemgyzXpi
 JkBKmCU5bt2gbv8TmMrQdIKSaLuFE2mt+0T/yZfIDlyIDtQ+VdT8zcMe+/IG0bH5nG+/
 TRhWCVXljMdwTp3X8hj/7XeG0f1yqp0u+grb2pk8gJmWu1fu1+bPcI9yGZebL3CMmQhY
 qA2L7p49Mp77UpHk1osmpJvM2Jig4MZxD6QA7/4KSVb1gHRmFIw6K59x4G0QN4FCgt0G 2A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sg83rb52h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 15:48:49 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37GFmkJc002233;
        Wed, 16 Aug 2023 15:48:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3se35mayef-1;
        Wed, 16 Aug 2023 15:48:46 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37GFmkcV002227;
        Wed, 16 Aug 2023 15:48:46 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37GFmjVB002225;
        Wed, 16 Aug 2023 15:48:46 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 4A0955000A7; Wed, 16 Aug 2023 21:18:45 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        agross@kernel.org, kishon@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Manish Pandey <quic_mapa@quicinc.com>
Subject: [PATCH V1 2/2] phy: qcom-qmp-ufs: Add Phy Configuration support for SC7280
Date:   Wed, 16 Aug 2023 21:18:41 +0530
Message-Id: <20230816154841.2183-3-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230816154841.2183-1-quic_nitirawa@quicinc.com>
References: <20230816154841.2183-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S2mA1eWND5ePp7Yjhx2FDxXZRZMOXWIK
X-Proofpoint-ORIG-GUID: S2mA1eWND5ePp7Yjhx2FDxXZRZMOXWIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_15,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=766
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160137
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SC7280 specific register layout and table configs.

Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 142 ++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 03cd47faf3fd..c5ab5f0792f5 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -493,6 +493,70 @@ static const struct qmp_phy_init_tbl sm8150_ufsphy_hs_g4_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_BIST_FIXED_PAT_CTRL, 0x0a),
 };

+static const struct qmp_phy_init_tbl sc7280_ufsphy_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x35),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_TRAN_DRVR_EMP_EN, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl sc7280_ufsphy_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_LVL, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_BAND, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0xf1),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xed),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x3c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xe0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb1),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_LOW, 0xe0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH2, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0xb1),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl sc7280_ufsphy_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_RX_SIGDET_CTRL2, 0x6D),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0A),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_DEBUG_BUS_CLKSEL, 0x1F),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_RX_MIN_HIBERN8_TIME, 0xFF),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_PLL_CNTL, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TIMER_20US_CORECLK_STEPS_MSB, 0x16),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TIMER_20US_CORECLK_STEPS_LSB, 0xD8),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_PWM_GEAR_BAND, 0xAA),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_HS_GEAR_BAND, 0x06),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x03),
+};
+
 static const struct qmp_phy_init_tbl sm8250_ufsphy_hs_g4_tx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xe5),
 };
@@ -521,6 +585,47 @@ static const struct qmp_phy_init_tbl sm8250_ufsphy_hs_g4_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
 };

+static const struct qmp_phy_init_tbl sc7280_ufsphy_hs_g4_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_LVL, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_BAND, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0xf1),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x81),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x6f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x2c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xed),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_LOW, 0xe0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH2, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0xb1),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x0f),
+};
+
 static const struct qmp_phy_init_tbl sm8350_ufsphy_serdes[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0xd9),
 	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x11),
@@ -1162,6 +1267,40 @@ static const struct qmp_phy_cfg sm8550_ufsphy_cfg = {
 	.regs			= ufsphy_v6_regs_layout,
 };

+static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
+	.lanes                  = 2,
+
+	.offsets                = &qmp_ufs_offsets,
+
+	.tbls = {
+		.serdes         = sm8150_ufsphy_serdes,
+		.serdes_num     = ARRAY_SIZE(sm8150_ufsphy_serdes),
+		.tx             = sc7280_ufsphy_tx,
+		.tx_num         = ARRAY_SIZE(sc7280_ufsphy_tx),
+		.rx             = sc7280_ufsphy_rx,
+		.rx_num         = ARRAY_SIZE(sc7280_ufsphy_rx),
+		.pcs            = sc7280_ufsphy_pcs,
+		.pcs_num        = ARRAY_SIZE(sc7280_ufsphy_pcs),
+	},
+	.tbls_hs_b = {
+		.serdes         = sm8150_ufsphy_hs_b_serdes,
+		.serdes_num     = ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
+	},
+	.tbls_hs_g4 = {
+		.tx             = sm8250_ufsphy_hs_g4_tx,
+		.tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
+		.rx             = sc7280_ufsphy_hs_g4_rx,
+		.rx_num         = ARRAY_SIZE(sc7280_ufsphy_hs_g4_rx),
+		.pcs            = sm8150_ufsphy_hs_g4_pcs,
+		.pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
+	},
+	.clk_list               = sm8450_ufs_phy_clk_l,
+	.num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
+	.vreg_list              = qmp_phy_vreg_l,
+	.num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs                   = ufsphy_v4_regs_layout,
+};
+
 static void qmp_ufs_configure_lane(void __iomem *base,
 					const struct qmp_phy_init_tbl tbl[],
 					int num,
@@ -1682,6 +1821,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8550-qmp-ufs-phy",
 		.data = &sm8550_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sc7280-qmp-ufs-phy",
+		.data = &sc7280_ufsphy_cfg,
 	},
 	{ },
 };
--
2.17.1

