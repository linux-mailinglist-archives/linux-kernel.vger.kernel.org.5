Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422C67EBBB4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjKODZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbjKODZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:25:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E527E7;
        Tue, 14 Nov 2023 19:25:48 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF2JuxA008315;
        Wed, 15 Nov 2023 03:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=9Hf+mXfH3yTfS7jXfbFNT1Apfu+jaG7gmgzQIRd49kA=;
 b=odBSHrS+ptg1EBx3hmat+QlnNVqm6YBUPxgAJJ30P0ct2N7GXf47WbTsAc0fUwwXipNM
 VoiPG6gVaBzfrOv9G4ktrGwnEmFvhoWHIrrdGXUKxD3J4NNiyhHJRUL0jot5dOgDi2fF
 InR343erisn+uqBY7gU3coweYlq6Z5EdDOWmFPMCfk3GCVxRPIaN3ihU/+gOEPZEQfBH
 pECY6QyosVNlIQN9GhV6DrpM6T7/6grAplG6FZGY/EI0JBeW5p8hde814ky5HXVm8uZn
 AFlXbhlpkyntWKb0/bchBF4ngji/1F8giPQJCnD0ItkAhwYmbsL8grKAtKympKyfxwI7 Gw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucfka8u7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:25:35 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AF3PZvZ016141
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 03:25:35 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 14 Nov 2023 19:25:30 -0800
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
Subject: [PATCH 1/9] net: mdio: ipq4019: increase eth_ldo_rdy for ipq5332 platform
Date:   Wed, 15 Nov 2023 11:25:07 +0800
Message-ID: <20231115032515.4249-2-quic_luoj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: _wE0V0DvETp7XIFPwrxmAuugPYZkJuh9
X-Proofpoint-GUID: _wE0V0DvETp7XIFPwrxmAuugPYZkJuh9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_01,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
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

There are two PCS(UNIPHY) supported in SOC side on ipq5332,
and three PCS(UNIPHY) supported on ipq9574.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 55 +++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index abd8b508ec16..9d444f5f7efb 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -18,28 +18,31 @@
 #define MDIO_DATA_WRITE_REG			0x48
 #define MDIO_DATA_READ_REG			0x4c
 #define MDIO_CMD_REG				0x50
-#define MDIO_CMD_ACCESS_BUSY		BIT(16)
-#define MDIO_CMD_ACCESS_START		BIT(8)
-#define MDIO_CMD_ACCESS_CODE_READ	0
-#define MDIO_CMD_ACCESS_CODE_WRITE	1
-#define MDIO_CMD_ACCESS_CODE_C45_ADDR	0
-#define MDIO_CMD_ACCESS_CODE_C45_WRITE	1
-#define MDIO_CMD_ACCESS_CODE_C45_READ	2
+#define MDIO_CMD_ACCESS_BUSY			BIT(16)
+#define MDIO_CMD_ACCESS_START			BIT(8)
+#define MDIO_CMD_ACCESS_CODE_READ		0
+#define MDIO_CMD_ACCESS_CODE_WRITE		1
+#define MDIO_CMD_ACCESS_CODE_C45_ADDR		0
+#define MDIO_CMD_ACCESS_CODE_C45_WRITE		1
+#define MDIO_CMD_ACCESS_CODE_C45_READ		2
 
 /* 0 = Clause 22, 1 = Clause 45 */
 #define MDIO_MODE_C45				BIT(8)
 
-#define IPQ4019_MDIO_TIMEOUT	10000
-#define IPQ4019_MDIO_SLEEP		10
+#define IPQ4019_MDIO_TIMEOUT			10000
+#define IPQ4019_MDIO_SLEEP			10
 
 /* MDIO clock source frequency is fixed to 100M */
-#define IPQ_MDIO_CLK_RATE	100000000
+#define IPQ_MDIO_CLK_RATE			100000000
 
-#define IPQ_PHY_SET_DELAY_US	100000
+#define IPQ_PHY_SET_DELAY_US			100000
+
+/* Maximum SOC PCS(uniphy) number on IPQ platform */
+#define ETH_LDO_RDY_CNT				3
 
 struct ipq4019_mdio_data {
-	void __iomem	*membase;
-	void __iomem *eth_ldo_rdy;
+	void __iomem *membase;
+	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
 	struct clk *mdio_clk;
 };
 
@@ -210,13 +213,15 @@ static int ipq_mdio_reset(struct mii_bus *bus)
 	int ret;
 
 	/* To indicate CMN_PLL that ethernet_ldo has been ready if platform resource 1
-	 * is specified in the device tree.
+	 * or more resource are specified in the device tree.
 	 */
-	if (priv->eth_ldo_rdy) {
-		val = readl(priv->eth_ldo_rdy);
-		val |= BIT(0);
-		writel(val, priv->eth_ldo_rdy);
-		fsleep(IPQ_PHY_SET_DELAY_US);
+	for (ret = 0; ret < ETH_LDO_RDY_CNT; ret++) {
+		if (priv->eth_ldo_rdy[ret]) {
+			val = readl(priv->eth_ldo_rdy[ret]);
+			val |= BIT(0);
+			writel(val, priv->eth_ldo_rdy[ret]);
+			fsleep(IPQ_PHY_SET_DELAY_US);
+		}
 	}
 
 	/* Configure MDIO clock source frequency if clock is specified in the device tree */
@@ -252,11 +257,14 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->mdio_clk))
 		return PTR_ERR(priv->mdio_clk);
 
-	/* The platform resource is provided on the chipset IPQ5018 */
+	/* The platform resource is provided on the chipset IPQ5018/IPQ5332 */
 	/* This resource is optional */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (res)
-		priv->eth_ldo_rdy = devm_ioremap_resource(&pdev->dev, res);
+	for (ret = 0; ret < ETH_LDO_RDY_CNT; ret++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, ret + 1);
+		if (res)
+			priv->eth_ldo_rdy[ret] = devm_ioremap(&pdev->dev,
+							      res->start, resource_size(res));
+	}
 
 	bus->name = "ipq4019_mdio";
 	bus->read = ipq4019_mdio_read_c22;
@@ -288,6 +296,7 @@ static void ipq4019_mdio_remove(struct platform_device *pdev)
 static const struct of_device_id ipq4019_mdio_dt_ids[] = {
 	{ .compatible = "qcom,ipq4019-mdio" },
 	{ .compatible = "qcom,ipq5018-mdio" },
+	{ .compatible = "qcom,ipq5332-mdio" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ipq4019_mdio_dt_ids);
-- 
2.42.0

