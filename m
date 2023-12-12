Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9537B80EADA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346395AbjLLLwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346388AbjLLLw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:52:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B3ED5;
        Tue, 12 Dec 2023 03:52:34 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCBnek2025206;
        Tue, 12 Dec 2023 11:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        qcppdkim1; bh=FHdl/TT3won4UjUmJ6S5WbkkqP4hoRaNfjOceJqqX8M=; b=kc
        8Rt631FGOar3EabxtCIYtKL/rE5rLjCV0pivIhYtrKsULhUuDvJVnYMRCYh5S+AX
        QOLjmXx21Rvwg/Qf2slOwuO5sVG6u5nuCAmW/4TYXxEFdYvQx79a4SKXweNg3Y4l
        Nv5D+7l3cMNjbnr2BxiUVzSqn1ALwGlKnvcoHqJpTfZ+rWM9ff4NQNf/yn284Ue7
        P6DV98tVm9OWXMXYDvc0pM1vJJ5QCAn9HiWm9vEFvBFM9PlTyr7/RFlAUBR6ZUBl
        UUq0c7ik5nG/0KCxt3VLc1mXpxkWn5e/fn3PxGZqGAhvgTb3pyW64tAuHC4aW2vX
        zXTrpdEAp7NWOfxlh2gQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxepkh5ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:52:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCBqIGi000446
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:52:18 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 03:52:14 -0800
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
Subject: [PATCH v2 2/5] net: mdio: ipq4019: enable the SoC uniphy clocks for ipq5332 platform
Date:   Tue, 12 Dec 2023 19:51:47 +0800
Message-ID: <20231212115151.20016-3-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212115151.20016-1-quic_luoj@quicinc.com>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xNv-xfvERv4zNJNaDem4EyIwDkrRvFH3
X-Proofpoint-ORIG-GUID: xNv-xfvERv4zNJNaDem4EyIwDkrRvFH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the platform ipq5332, the related SoC uniphy GCC clocks need
to be enabled for making the MDIO slave devices accessible.

These UNIPHY clocks are from the SoC platform GCC clock provider,
which are enabled for the connected PHY devices working.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/mdio/mdio-ipq4019.c | 75 ++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 11 deletions(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index 5273864fabb3..582e41ab0990 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -35,15 +35,36 @@
 /* MDIO clock source frequency is fixed to 100M */
 #define IPQ_MDIO_CLK_RATE	100000000
 
+/* SoC UNIPHY fixed clock */
+#define IPQ_UNIPHY_AHB_CLK_RATE	100000000
+#define IPQ_UNIPHY_SYS_CLK_RATE	24000000
+
 #define IPQ_PHY_SET_DELAY_US	100000
 
 /* Maximum SOC PCS(uniphy) number on IPQ platform */
 #define ETH_LDO_RDY_CNT				3
 
+enum mdio_clk_id {
+	MDIO_CLK_MDIO_AHB,
+	MDIO_CLK_UNIPHY0_AHB,
+	MDIO_CLK_UNIPHY0_SYS,
+	MDIO_CLK_UNIPHY1_AHB,
+	MDIO_CLK_UNIPHY1_SYS,
+	MDIO_CLK_CNT
+};
+
 struct ipq4019_mdio_data {
 	void __iomem *membase;
 	void __iomem *eth_ldo_rdy[ETH_LDO_RDY_CNT];
-	struct clk *mdio_clk;
+	struct clk *clk[MDIO_CLK_CNT];
+};
+
+static const char *const mdio_clk_name[] = {
+	"gcc_mdio_ahb_clk",
+	"gcc_uniphy0_ahb_clk",
+	"gcc_uniphy0_sys_clk",
+	"gcc_uniphy1_ahb_clk",
+	"gcc_uniphy1_sys_clk"
 };
 
 static int ipq4019_mdio_wait_busy(struct mii_bus *bus)
@@ -209,14 +230,43 @@ static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 static int ipq_mdio_reset(struct mii_bus *bus)
 {
 	struct ipq4019_mdio_data *priv = bus->priv;
-	int ret;
+	int ret, index;
+	unsigned long rate;
+
+	/* For the platform ipq5332, there are two SoC uniphies available
+	 * for connecting with ethernet PHY, the SoC uniphy gcc clock
+	 * should be enabled for resetting the connected device such
+	 * as qca8386 switch, qca8081 PHY or other PHYs effectively.
+	 *
+	 * Configure MDIO/UNIPHY clock source frequency if clock instance
+	 * is specified in the device tree.
+	 */
+	for (index = MDIO_CLK_MDIO_AHB; index < MDIO_CLK_CNT; index++) {
+		switch (index) {
+		case MDIO_CLK_MDIO_AHB:
+			rate = IPQ_MDIO_CLK_RATE;
+			break;
+		case MDIO_CLK_UNIPHY0_AHB:
+		case MDIO_CLK_UNIPHY1_AHB:
+			rate = IPQ_UNIPHY_AHB_CLK_RATE;
+			break;
+		case MDIO_CLK_UNIPHY0_SYS:
+		case MDIO_CLK_UNIPHY1_SYS:
+			rate = IPQ_UNIPHY_SYS_CLK_RATE;
+			break;
+		default:
+			break;
+		}
 
-	/* Configure MDIO clock source frequency if clock is specified in the device tree */
-	ret = clk_set_rate(priv->mdio_clk, IPQ_MDIO_CLK_RATE);
-	if (ret)
-		return ret;
+		ret = clk_set_rate(priv->clk[index], rate);
+		if (ret)
+			return ret;
+
+		ret = clk_prepare_enable(priv->clk[index]);
+		if (ret)
+			return ret;
+	}
 
-	ret = clk_prepare_enable(priv->mdio_clk);
 	if (ret == 0)
 		mdelay(10);
 
@@ -240,10 +290,6 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->membase))
 		return PTR_ERR(priv->membase);
 
-	priv->mdio_clk = devm_clk_get_optional(&pdev->dev, "gcc_mdio_ahb_clk");
-	if (IS_ERR(priv->mdio_clk))
-		return PTR_ERR(priv->mdio_clk);
-
 	/* These platform resources are provided on the chipset IPQ5018 or
 	 * IPQ5332.
 	 */
@@ -271,6 +317,13 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 		}
 	}
 
+	for (index = 0; index < MDIO_CLK_CNT; index++) {
+		priv->clk[index] = devm_clk_get_optional(&pdev->dev,
+							 mdio_clk_name[index]);
+		if (IS_ERR(priv->clk[index]))
+			return PTR_ERR(priv->clk[index]);
+	}
+
 	bus->name = "ipq4019_mdio";
 	bus->read = ipq4019_mdio_read_c22;
 	bus->write = ipq4019_mdio_write_c22;
-- 
2.42.0

