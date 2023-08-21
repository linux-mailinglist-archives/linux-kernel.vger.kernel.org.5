Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3431278268B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjHUJt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjHUJtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:49:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EA0CA;
        Mon, 21 Aug 2023 02:49:54 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37L67ulU026930;
        Mon, 21 Aug 2023 09:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=C1xrtnTCEI0c9A9ZcDZjDyrVR2cmlUvNVFKElkW8mZ8=;
 b=MKPiXpO241Vdg5BVkiVPwmwiPPeh0iluSLoEvs0aIMZbL+yClDO45Y2YGMkh8GiRSZo2
 T02zyT/NEL5vWpSQ8hzZZvzfJ9+gvEdlBGt9qJ0pQfxa8HKe2PMj2HsUKfXjJQDmzU/x
 A5+hVNbQNEmUI97rberUy5zsSHH+7/ffmBtVulf548cHWHdGNpi1/BE4pJ2hVvQzX/Wm
 xKzIkGv8avyHm6v+UI2h1SsEf7Ju9akV3ZV7gvOVRsxH/8kJ4jQvKwpiiF6yReTduQ0h
 PcQ8RRhPcQhA/RSfxOtWUNwCdm/ogMF/88nnXFpoNLG9UmtD9/uSL1qD0/puu2BuW+m6 1A== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjk3tkdfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 09:49:45 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37L9ngIE026955;
        Mon, 21 Aug 2023 09:49:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3sjptkfk0p-1;
        Mon, 21 Aug 2023 09:49:42 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37L9ngKt026949;
        Mon, 21 Aug 2023 09:49:42 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 37L9nfS0026948;
        Mon, 21 Aug 2023 09:49:42 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 56DD05013C0; Mon, 21 Aug 2023 15:19:41 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, alim.akhtar@samsung.com,
        bvanassche@acm.org, robh+dt@kernel.org, avri.altman@wdc.com,
        cros-qcom-dts-watchers@chromium.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V1 2/2] arm64: dts: qcom: sc7280: Add UFS host controller and phy nodes
Date:   Mon, 21 Aug 2023 15:19:37 +0530
Message-Id: <20230821094937.13059-3-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821094937.13059-1-quic_nitirawa@quicinc.com>
References: <20230821094937.13059-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p00SvnQ3hzl2ba8VBBmyot7p5RXDCIRG
X-Proofpoint-ORIG-GUID: p00SvnQ3hzl2ba8VBBmyot7p5RXDCIRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308210089
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UFS host controller and PHY nodes for sc7280.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 19 +++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 64 ++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 2ff549f4dc7a..c60cdd511222 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -451,6 +451,25 @@
 	status = "okay";
 };

+&ufs_mem_hc {
+	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
+	vcc-supply = <&vreg_l7b_2p9>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l9b_1p2>;
+	vccq-max-microamp = <900000>;
+	vccq2-supply = <&vreg_l9b_1p2>;
+	vccq2-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l10c_0p8>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
 &sdhc_1 {
 	status = "okay";

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 925428a5f6ae..d4a15d56b384 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -908,6 +908,70 @@
 			};
 		};

+		ufs_mem_phy: phy@1d87000 {
+			compatible = "qcom,sc7280-qmp-ufs-phy";
+			reg = <0x0 0x01d87000 0x0 0xe00>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_1_CLKREF_EN>;
+			clock-names = "ref", "ref_aux", "qref";
+
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
+
+			#clock-cells = <1>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+
+		};
+
+		ufs_mem_hc: ufs@1d84000 {
+			compatible = "qcom,sc7280-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0x0 0x01d84000 0x0 0x3000>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufs_mem_phy>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <2>;
+			#reset-cells = <1>;
+			resets = <&gcc GCC_UFS_PHY_BCR>;
+			reset-names = "rst";
+
+			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+
+			iommus = <&apps_smmu 0x80 0x0>;
+			dma-coherent;
+
+			clock-names = "core_clk",
+				      "bus_aggr_clk",
+				      "iface_clk",
+				      "core_clk_unipro",
+				      "ref_clk",
+				      "tx_lane0_sync_clk",
+				      "rx_lane0_sync_clk",
+				      "rx_lane1_sync_clk";
+			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_UFS_PHY_AHB_CLK>,
+				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
+			freq-table-hz =
+				<75000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<75000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+			status = "disabled";
+		};
+
 		sdhc_1: mmc@7c4000 {
 			compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
 			pinctrl-names = "default", "sleep";
--
2.17.1

