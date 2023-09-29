Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8787B3374
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjI2NUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjI2NUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:20:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DB51BD;
        Fri, 29 Sep 2023 06:20:03 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T8erTA021751;
        Fri, 29 Sep 2023 13:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=6QLJm1D7i56h+o69iGWP4+wo+mLQknyOTUMa5rk9RxI=;
 b=YT7gNH7/6KphtYlq74MRAnEl7PJpWEKUpWfS+s1y+gY3wqPAob9v+Vqm/ByN7IjzIrFv
 QN0SbMvqML7OnPtB8E63MSEKikGTpzeocpL/j7KKG2sxEdAxB7jbTcYAnkt8ry3r3Qhu
 tYDBfEZPRjkyVlM4PzD88K3Ae3Cu+HgdIfn0l7BEN0AiQ/7kcZBt2smE/uJ1HLKTYxsD
 w62miDi2FcUe/r2mDXSguJlKn3n65M1EfZLJxasMgEahYpd0Sy6ZUUwFkiTF6MWRYri0
 g1bB/Ya+HYWG5efpHwYDKSgkwu2Uj52ZsROsM04eb75aKEXCUPYCDsTGj+u+l2C6T+Ta OA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tdfbrsweu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 13:19:50 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38TDJk9i018540;
        Fri, 29 Sep 2023 13:19:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3t9s3m3gd4-1;
        Fri, 29 Sep 2023 13:19:46 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TDJksT018535;
        Fri, 29 Sep 2023 13:19:46 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-nitirawa-hyd.qualcomm.com [10.213.109.152])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 38TDJket018534;
        Fri, 29 Sep 2023 13:19:46 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2342877)
        id 8A6CB571638; Fri, 29 Sep 2023 18:49:45 +0530 (+0530)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mani@kernel.org, alim.akhtar@samsung.com, bvanassche@acm.org,
        avri.altman@wdc.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: [PATCH V4 2/4] arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 soc
Date:   Fri, 29 Sep 2023 18:49:34 +0530
Message-Id: <20230929131936.29421-3-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230929131936.29421-1-quic_nitirawa@quicinc.com>
References: <20230929131936.29421-1-quic_nitirawa@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Mit8PQ1QGjTSOxkEItx8SpccZbPzV4Ex
X-Proofpoint-GUID: Mit8PQ1QGjTSOxkEItx8SpccZbPzV4Ex
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=972 adultscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290114
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UFS host controller and PHY nodes for sc7280 soc.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 66 ++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 66f1eb83cca7..163e3df60966 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3353,6 +3353,72 @@
 			};
 		};

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
+			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_UFS_MEM_CFG 0>;
+
+			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_UFS_PHY_AHB_CLK>,
+				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
+			clock-names = "core_clk",
+				      "bus_aggr_clk",
+				      "iface_clk",
+				      "core_clk_unipro",
+				      "ref_clk",
+				      "tx_lane0_sync_clk",
+				      "rx_lane0_sync_clk",
+				      "rx_lane1_sync_clk";
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
+		};
+
 		usb_1_hsphy: phy@88e3000 {
 			compatible = "qcom,sc7280-usb-hs-phy",
 				     "qcom,usb-snps-hs-7nm-phy";
--
2.17.1

