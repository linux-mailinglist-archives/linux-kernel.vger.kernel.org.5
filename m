Return-Path: <linux-kernel+bounces-5033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FDD8185A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B0E8B22C43
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08D618658;
	Tue, 19 Dec 2023 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GCI3RbDN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2366C1802D;
	Tue, 19 Dec 2023 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ4eu3m001275;
	Tue, 19 Dec 2023 10:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=h8MEvm18p/trjQWILwtCbY1FmHFRFjnf0KYXKH6THuE=; b=GC
	I3RbDNJudOjDCNkMFOa09rM0JJVJqcRdhorYEkweYE1m+GD7HAd9ZzdPk9oc772e
	+1U0WMPbDeLXugs6Nn+CeRFYFlddUHH0zqfEalIb1BxzIgkTlzTUx+6KaTq5XZVY
	M9BI+GCFv2oynWGwg0L+WuligRjzL+rqWd7pnDmhVx0CjQ6ggb+p9DJmlRvwOgmz
	c/IzS4GxTnS3tv+QrLC/YAEVIo9h99+4cBx+ERct+h4iaQKVjf/MiVom7PXtRa+Z
	PRZ91t0sw3bH/uV9/HUmt0rlMCMLjcIhHwqAb55/imN7LW7hBbIpnyCtYXdFSFtY
	IF2UMaoxoIoyeHoA3EOQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2yyxha9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 10:49:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJAn2er014011
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 10:49:02 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 02:48:51 -0800
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
Subject: [PATCH net-next v7 3/3] net: stmmac: Add driver support for DWMAC5 common safety IRQ
Date: Tue, 19 Dec 2023 16:18:15 +0530
Message-ID: <20231219104815.3443231-4-quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219104815.3443231-1-quic_jsuraj@quicinc.com>
References: <20231219104815.3443231-1-quic_jsuraj@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Wstu8Jxh5rZS1eanX_ycRRbp1z-knhVD
X-Proofpoint-GUID: Wstu8Jxh5rZS1eanX_ycRRbp1z-knhVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190079

Add support to listen HW safety IRQ like ECC(error
correction code), DPP(data path parity), FSM(finite state
machine) fault in common IRQ line.

Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 +++++
 4 files changed, 46 insertions(+)

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
index 9f89acf31050..9aeaca01cace 100644
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 47de466e432c..f6639ffb017e 100644
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
@@ -3661,6 +3665,21 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 		}
 	}
 
+	/* Request the common Safety Feature Correctible/Uncorrectible
+	 * Error line in case of another line is used
+	 */
+	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
+		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
+				  0, dev->name, dev);
+		if (unlikely(ret < 0)) {
+			netdev_err(priv->dev,
+				   "%s: alloc safety failed %d (error: %d)\n",
+				   __func__, priv->sfty_irq, ret);
+			irq_err = REQ_IRQ_ERR_SFTY;
+			goto irq_error;
+		}
+	}
+
 	/* Request the Safety Feature Correctible Error line in
 	 * case of another line is used
 	 */
@@ -3798,6 +3817,21 @@ static int stmmac_request_irq_single(struct net_device *dev)
 		}
 	}
 
+	/* Request the common Safety Feature Correctible/Uncorrectible
+	 * Error line in case of another line is used
+	 */
+	if (priv->sfty_irq > 0 && priv->sfty_irq != dev->irq) {
+		ret = request_irq(priv->sfty_irq, stmmac_safety_interrupt,
+				  0, dev->name, dev);
+		if (unlikely(ret < 0)) {
+			netdev_err(priv->dev,
+				   "%s: alloc safety failed %d (error: %d)\n",
+				   __func__, priv->sfty_irq, ret);
+			irq_err = REQ_IRQ_ERR_SFTY;
+			goto irq_error;
+		}
+	}
+
 	return 0;
 
 irq_error:
@@ -7462,6 +7496,7 @@ int stmmac_dvr_probe(struct device *device,
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


