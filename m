Return-Path: <linux-kernel+bounces-41186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC74C83ED25
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B1728529B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AE52560F;
	Sat, 27 Jan 2024 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HMaB8xqJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4789470;
	Sat, 27 Jan 2024 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706360669; cv=none; b=OHzOpGkdKpt3V4ExIJqDUvmnZbEoiiNLdtF5nOuzWJuXkfMkb7jTkPP2z+6dn+FmtvZ5wpCAxic+P0TjUhE12xHg1aP3qRc/akL1aS1pddV0iDJj5haRC93XdPhLy7izmyiSvw3o9tvY/8OBcTQN/2TdVpBofQKxuNvTBfNnZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706360669; c=relaxed/simple;
	bh=ezGjLX/KGCvKrdFlYhkTSrLIz9F/ChMEXBwpfDh019g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=H3jNEHXT1z/xCmGkGtH5s1xeaR/IVLkWiKWSI9Dl8MSDrO+OIpzaPuME7H7W8LbuFPGB0N7LLk+DypvqKG5hn2PnJmn9mu9uwsTjVE9/ho1mgg2mWv9FzRzQ4nW1C5ATkWSA82r0YiHOpafca3OMdqfKjYiRIkI7kZesaq+5g4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HMaB8xqJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40RCxpbl001346;
	Sat, 27 Jan 2024 13:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=6oebARhWnbWU
	R8eKVVvlJcocYHJTcYCqahQxWhiBad0=; b=HMaB8xqJ9VBO09LxitQsHPjqo4eU
	nHql5VcTIerEBoOYBhoEy5mfoDQ5DnM5+htqCHATo4CvqHduCjbjjR/yAEGrrbcX
	WbWjbbbU2G0JahoXEi07W84d619FI5TWonzTuc4MM3yYYgPwjGtGc31cY3uaR6n1
	U0WFs3x9EWXGCk8nIWyJ/j+c9UzI/tgXH4KLjynl7YIS2B7sKNj5fjQ7of9UrYW/
	cCXBUGxAvqDT1N5FgQbeAHF8NNHN1iTu86NBtVHfWFPTtHF8Fl48DqGRUA+SpKvi
	MUwlak0zHdSPnECgXS9HR+LL49GqmB5Rg/A6RyD+6UFzKb5Flp6kjBCRVQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvq6sgrrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 13:04:07 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40RD44xr032026;
	Sat, 27 Jan 2024 13:04:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3vvtwkh1yy-1;
	Sat, 27 Jan 2024 13:04:04 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40RD43ad032020;
	Sat, 27 Jan 2024 13:04:03 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-snehshah-hyd.qualcomm.com [10.147.246.35])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 40RD43rP032019;
	Sat, 27 Jan 2024 13:04:03 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2319345)
	id A7D185013A4; Sat, 27 Jan 2024 18:34:02 +0530 (+0530)
From: Sneh Shah <quic_snehshah@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Sneh Shah <quic_snehshah@quicinc.com>, kernel@quicinc.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next] net: stmmac: dwmac-qcom-ethqos: Add support for pm ops
Date: Sat, 27 Jan 2024 18:33:27 +0530
Message-Id: <20240127130327.22443-1-quic_snehshah@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hfW17_9FU6EIZ5OE24pmXqy0sXMCugSJ
X-Proofpoint-ORIG-GUID: hfW17_9FU6EIZ5OE24pmXqy0sXMCugSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270097
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add qcom ethqos specific runtime and system sleep pm ops.
As part of system sleep qcom ethqos needs to disable all clocks.
This ops will be extended further with qcom specific features.

Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 51 ++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 31631e3f89d0..cba601ee9e01 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -720,6 +720,55 @@ static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)
 	netdev_dbg(priv->dev, "PTP rate %d\n", plat_dat->clk_ptp_rate);
 }
 
+static int qcom_ethqos_runtime_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	return stmmac_bus_clks_config(priv, false);
+}
+
+static int qcom_ethqos_runtime_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	return stmmac_bus_clks_config(priv, true);
+}
+
+static int qcom_ethqos_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	int ret;
+
+	if (!ndev || !netif_running(ndev))
+		return -EINVAL;
+
+	ret = stmmac_suspend(dev);
+
+	return stmmac_bus_clks_config(priv, false);
+}
+
+static int qcom_ethqos_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	int ret;
+
+	if (!ndev || !netif_running(ndev))
+		return -EINVAL;
+
+	stmmac_bus_clks_config(priv, true);
+
+	return stmmac_resume(dev);
+}
+
+const struct dev_pm_ops qcom_ethqos_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(qcom_ethqos_suspend, qcom_ethqos_resume)
+	SET_RUNTIME_PM_OPS(qcom_ethqos_runtime_suspend, qcom_ethqos_runtime_resume, NULL)
+};
+
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -838,7 +887,7 @@ static struct platform_driver qcom_ethqos_driver = {
 	.probe  = qcom_ethqos_probe,
 	.driver = {
 		.name           = "qcom-ethqos",
-		.pm		= &stmmac_pltfr_pm_ops,
+		.pm		= &qcom_ethqos_pm_ops,
 		.of_match_table = qcom_ethqos_match,
 	},
 };
-- 
2.17.1


