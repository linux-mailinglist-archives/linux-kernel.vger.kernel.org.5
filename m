Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646327EBBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjKOD0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbjKOD02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:26:28 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF76F196;
        Tue, 14 Nov 2023 19:26:17 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF10xXa023787;
        Wed, 15 Nov 2023 03:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=5DXY0nDZnSMr33KmsTLop3NblIPu7xp2y0ys9TqpYzU=;
 b=Vnxid4PN/+1p95xx6sth+Y5UZgJysrCR6CTAXy49HsmNNRHP2UIM7V+lELs/wt9bEHGQ
 pbTultwKW1DbnaNp6bGa0u+XVqCA0+TVCvRVwM63984fsQSFfLvTjGOL55LgsTXojKmq
 sR8QmX2xO6KZ4LGFUZEIv05dcnWRK8XqVINmYzta6hGftigvFrsNYfjWjohNTOMwHVfg
 YajzDrqiAt0tPHUqWcK+uGNLg/2XItsEyTNT+x1+vfYyRngSrU1TmdAPlG15r/aJPTI+
 dKMCdVCe9gBue5IiJhPF82DW7Kzb+gKO76wery1z/Gs6O34cYLPYzyvrFoGOJ17sX4J4 Ug== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucfke0tme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:26:04 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AF3Q3AN027042
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:26:03 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 14 Nov 2023 19:25:59 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>
CC:     <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH 8/9] net: mdio: ipq4019: add qca8084 configurations
Date:   Wed, 15 Nov 2023 11:25:14 +0800
Message-ID: <20231115032515.4249-9-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115032515.4249-1-quic_luoj@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4NAnnWRyDbDXXoaCSaZvNVHyMXg0t5_-
X-Proofpoint-ORIG-GUID: 4NAnnWRyDbDXXoaCSaZvNVHyMXg0t5_-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_01,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=976 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY & PCS clocks need to be enabled and the reset
sequence needs to be completed to make qca8084 PHY
probeable by MDIO bus.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 133 +++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index 1c461c243ae0..9bdd49be2361 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -70,6 +70,30 @@
 #define QCA8084_PHY_ADDR_MASK			GENMASK(19, 0)
 #define QCA8084_PCS_ADDR_MASK			GENMASK(14, 0)
 
+/* QCA8084 GCC & security control registers */
+/* LDO control, BIT20 for PHY0 and PHY1, BIT21 for PHY2 and PHY3 */
+#define EPHY_CFG				0xC90F018
+#define EPHY_CFG_LDO_CTRL			GENMASK(21, 20)
+
+/* GEPHY TX&RX clock control register starts from GEPHY0_TX,
+ * end with GEPHY3_RX, the gap is 0x20.
+ */
+#define GEPHY0_TX_CBCR				0xC800058
+#define GEPHY3_RX_CBCR				0xC800138
+#define GEPHY_CBCR_GAP				0x20
+
+#define SRDS0_SYS_CBCR				0xC8001A8
+#define SRDS1_SYS_CBCR				0xC8001AC
+#define EPHY0_SYS_CBCR				0xC8001B0
+#define EPHY1_SYS_CBCR				0xC8001B4
+#define EPHY2_SYS_CBCR				0xC8001B8
+#define EPHY3_SYS_CBCR				0xC8001BC
+#define CLK_EN					BIT(0)
+#define CLK_RESET				BIT(2)
+
+#define GCC_GEPHY_MISC				0xC800304
+#define GCC_GEPHY_MISC_DSP_RESET		GENMASK(4, 0)
+
 enum mdio_clk_id {
 	MDIO_CLK_MDIO_AHB,
 	MDIO_CLK_UNIPHY0_AHB,
@@ -412,14 +436,121 @@ static int ipq_phy_addr_fixup(struct mii_bus *bus, struct device_node *mdio_node
 	return 0;
 }
 
+static inline int qca8084_clock_en_set(struct mii_bus *bus, u32 reg, bool enable)
+{
+	return qca8084_modify(bus, reg, CLK_EN, enable ? CLK_EN : 0);
+}
+
+static inline int qca8084_clock_reset(struct mii_bus *bus, u32 reg)
+{
+	int ret;
+
+	ret = qca8084_modify(bus, reg, CLK_RESET, CLK_RESET);
+	if (ret)
+		return ret;
+
+	usleep_range(20000, 21000);
+	return qca8084_modify(bus, reg, CLK_RESET, 0);
+}
+
+static int qca8084_clock_config(struct mii_bus *bus)
+{
+	u32 reg;
+	int ret;
+
+	/* Enable PCS */
+	ret = qca8084_clock_en_set(bus, SRDS0_SYS_CBCR, true);
+	if (ret)
+		return ret;
+
+	ret = qca8084_clock_en_set(bus, SRDS1_SYS_CBCR, true);
+	if (ret)
+		return ret;
+
+	/* Reset PCS */
+	ret = qca8084_clock_reset(bus, SRDS0_SYS_CBCR);
+	if (ret)
+		return ret;
+
+	ret = qca8084_clock_reset(bus, SRDS1_SYS_CBCR);
+	if (ret)
+		return ret;
+
+	/* Disable EPHY GMII RX & TX clock */
+	reg = GEPHY0_TX_CBCR;
+	while (reg <= GEPHY3_RX_CBCR) {
+		ret = qca8084_clock_en_set(bus, reg, false);
+		if (ret)
+			return ret;
+
+		reg += GEPHY_CBCR_GAP;
+	}
+
+	/* Enable EPHY */
+	ret = qca8084_clock_en_set(bus, EPHY0_SYS_CBCR, true);
+	if (ret)
+		return ret;
+
+	ret = qca8084_clock_en_set(bus, EPHY1_SYS_CBCR, true);
+	if (ret)
+		return ret;
+
+	ret = qca8084_clock_en_set(bus, EPHY2_SYS_CBCR, true);
+	if (ret)
+		return ret;
+
+	ret = qca8084_clock_en_set(bus, EPHY3_SYS_CBCR, true);
+	if (ret)
+		return ret;
+
+	/* Reset EPHY */
+	ret = qca8084_clock_reset(bus, EPHY0_SYS_CBCR);
+	if (ret)
+		return ret;
+
+	ret = qca8084_clock_reset(bus, EPHY1_SYS_CBCR);
+	if (ret)
+		return ret;
+
+	ret = qca8084_clock_reset(bus, EPHY2_SYS_CBCR);
+	if (ret)
+		return ret;
+
+	ret = qca8084_clock_reset(bus, EPHY3_SYS_CBCR);
+	if (ret)
+		return ret;
+
+	/* Deassert EPHY DSP */
+	ret = qca8084_modify(bus, GCC_GEPHY_MISC, GCC_GEPHY_MISC_DSP_RESET, 0);
+	if (ret)
+		return ret;
+
+	/* Enable efuse loading into analog circuit */
+	ret = qca8084_modify(bus, EPHY_CFG, EPHY_CFG_LDO_CTRL, 0);
+	if (ret)
+		return ret;
+
+	/* Sleep 10ms */
+	usleep_range(10000, 11000);
+	return 0;
+}
+
 static int ipq_mdio_preinit(struct mii_bus *bus)
 {
+	int ret;
 	struct device_node *mdio_node = dev_of_node(&bus->dev);
 
 	if (!mdio_node)
 		return 0;
 
-	return ipq_phy_addr_fixup(bus, mdio_node);
+	ret = ipq_phy_addr_fixup(bus, mdio_node);
+	if (ret)
+		return ret;
+
+	if (of_property_read_bool(mdio_node, "mdio-clk-fixup"))
+		ret = qca8084_clock_config(bus);
+
+	return ret;
 }
 
 /* For the CMN PLL block, the reference clock can be configured according to
-- 
2.42.0

