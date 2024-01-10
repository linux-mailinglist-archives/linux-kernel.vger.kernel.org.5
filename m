Return-Path: <linux-kernel+bounces-22066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D19218298B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E211F29ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE9747F46;
	Wed, 10 Jan 2024 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Uvb1huRd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD304779D;
	Wed, 10 Jan 2024 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8cmJt020375;
	Wed, 10 Jan 2024 11:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=5wESy/498DHj/3BcjLShykVaFa+dINc2CeCNCA27zfU=; b=Uv
	b1huRdybB6OevBG9MI2XsqbUNjg/ej6GcFm8HtrRou3l/ZHC+Tf7ZHhM9Inf0R2J
	Swc7fic7uUSEHiFNFYn4sGXlgo5BPkxFk5ku2r9F4qYHOHn68Na3yO6Xo+asawSS
	tu6QE9sg/yFfYT6Yd2EWoxRLnrpJSgGEFg+ZPBiCfzVYnJcMQpuN5jyZrtbIgJCg
	/dll5pXip9WbboCEQGpw42K7VJMRKtmM16uELXU15pD8jm21GnreNNTclKnTCGwX
	4EFeNuegqzP1aH1qoCqcV8cU5nPcIMSlH4SBVjK3w1mGpXdxJUnCWD63tz8iI1jq
	CvRmESZpitK5h5ay3Apg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9vfj4gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:17:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABHgFC015830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:17:42 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:17:32 -0800
From: Suraj Jaiswal <quic_jsuraj@quicinc.com>
To: <quic_jsuraj@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma
	<bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Jose
 Abreu" <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Prasad Sodagudi
	<psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>, Rob Herring
	<robh@kernel.org>
CC: <kernel@quicinc.com>
Subject: [PATCH net-next v9 3/3] net: stmmac: Add driver support for DWMAC5 common safety IRQ
Date: Wed, 10 Jan 2024 16:46:49 +0530
Message-ID: <20240110111649.2256450-4-quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110111649.2256450-1-quic_jsuraj@quicinc.com>
References: <20240110111649.2256450-1-quic_jsuraj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Vi2IgmsK-UBJJA4X7OaYeDDSFlGMEzq_
X-Proofpoint-ORIG-GUID: Vi2IgmsK-UBJJA4X7OaYeDDSFlGMEzq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=942 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100092

Add support to listen HW safety IRQ like ECC(error
correction code), DPP(data path parity), FSM(finite state
machine) fault in common IRQ line.

Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 41 ++++++++++++++++++-
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 ++++
 4 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 721c1f8e892f..b9233b09b80f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -344,6 +344,7 @@ enum request_irq_err {
 	REQ_IRQ_ERR_ALL,
 	REQ_IRQ_ERR_TX,
 	REQ_IRQ_ERR_RX,
+	REQ_IRQ_ERR_SFTY,
 	REQ_IRQ_ERR_SFTY_UE,
 	REQ_IRQ_ERR_SFTY_CE,
 	REQ_IRQ_ERR_LPI,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 9f89acf31050..ca3d93851bed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -31,6 +31,7 @@ struct stmmac_resources {
 	int wol_irq;
 	int lpi_irq;
 	int irq;
+	int sfty_irq;
 	int sfty_ce_irq;
 	int sfty_ue_irq;
 	int rx_irq[MTL_MAX_RX_QUEUES];
@@ -297,6 +298,7 @@ struct stmmac_priv {
 	void __iomem *ptpaddr;
 	void __iomem *estaddr;
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
+	int sfty_irq;
 	int sfty_ce_irq;
 	int sfty_ue_irq;
 	int rx_irq[MTL_MAX_RX_QUEUES];
@@ -305,6 +307,7 @@ struct stmmac_priv {
 	char int_name_mac[IFNAMSIZ + 9];
 	char int_name_wol[IFNAMSIZ + 9];
 	char int_name_lpi[IFNAMSIZ + 9];
+	char int_name_sfty[IFNAMSIZ + 10];
 	char int_name_sfty_ce[IFNAMSIZ + 10];
 	char int_name_sfty_ue[IFNAMSIZ + 10];
 	char int_name_rx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 14];
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 47de466e432c..e0192a282121 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3592,6 +3592,10 @@ static void stmmac_free_irq(struct net_device *dev,
 		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
 			free_irq(priv->wol_irq, dev);
 		fallthrough;
+	case REQ_IRQ_ERR_SFTY:
+		if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq)
+			free_irq(priv->sfty_irq, dev);
+		fallthrough;
 	case REQ_IRQ_ERR_WOL:
 		free_irq(dev->irq, dev);
 		fallthrough;
@@ -3661,6 +3665,23 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		}
 	}
 
+	/* Request the common Safety Feature Correctible/Uncorrectible
+	 * Error line in case of another line is used
+	 */
+	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
+		int_name = priv->int_name_sfty;
+		sprintf(int_name, "%s:%s", dev->name, "safety");
+		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
+				  0, int_name, dev);
+		if (unlikely(ret < 0)) {
+			netdev_err(priv->dev,
+				   "%s: alloc sfty MSI %d (error: %d)\n",
+				   __func__, priv->sfty_irq, ret);
+			irq_err = REQ_IRQ_ERR_SFTY;
+			goto irq_error;
+		}
+	}
+
 	/* Request the Safety Feature Correctible Error line in
 	 * case of another line is used
 	 */
@@ -3798,6 +3819,21 @@ static int stmmac_request_irq_single(struct net_device *dev)
 		}
 	}
 
+	/* Request the common Safety Feature Correctible/Uncorrectible
+	 * Error line in case of another line is used
+	 */
+	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
+		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
+				  IRQF_SHARED, dev->name, dev);
+		if (unlikely(ret < 0)) {
+			netdev_err(priv->dev,
+				   "%s: ERROR: allocating the sfty IRQ %d (%d)\n",
+				   __func__, priv->sfty_irq, ret);
+			irq_err = REQ_IRQ_ERR_SFTY;
+			goto irq_error;
+		}
+	}
+
 	return 0;
 
 irq_error:
@@ -6022,8 +6058,8 @@ static irqreturn_t stmmac_interrupt(int irq, void *dev_id)
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return IRQ_HANDLED;
 
-	/* Check if a fatal error happened */
-	if (stmmac_safety_feat_interrupt(priv))
+	/* Check ASP error if it isn't delivered via an individual IRQ */
+	if (priv->sfty_irq <= 0 && stmmac_safety_feat_interrupt(priv))
 		return IRQ_HANDLED;
 
 	/* To handle Common interrupts */
@@ -7462,6 +7498,7 @@ int stmmac_dvr_probe(struct device *device,
 	priv->dev->irq = res->irq;
 	priv->wol_irq = res->wol_irq;
 	priv->lpi_irq = res->lpi_irq;
+	priv->sfty_irq = res->sfty_irq;
 	priv->sfty_ce_irq = res->sfty_ce_irq;
 	priv->sfty_ue_irq = res->sfty_ue_irq;
 	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 70eadc83ca68..ab250161fd79 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -743,6 +743,14 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
 	}
 
+	stmmac_res->sfty_irq =
+		platform_get_irq_byname_optional(pdev, "sfty");
+	if (stmmac_res->sfty_irq < 0) {
+		if (stmmac_res->sfty_irq == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_info(&pdev->dev, "IRQ safety IRQ not found\n");
+	}
+
 	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
 
 	return PTR_ERR_OR_ZERO(stmmac_res->addr);
-- 
2.25.1


