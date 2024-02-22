Return-Path: <linux-kernel+bounces-76549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D00585F8F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67132880E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE2B12F381;
	Thu, 22 Feb 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hicX5ReW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685A47F64;
	Thu, 22 Feb 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606572; cv=none; b=TUl7CUEt9BwvKFEYqlHCspVgUImro+Ql7KKm5jLPivhcE/QBGW4nQgeOZyXpPWxsWcRgDwAXw381CUOoMvd8Y728k6jMSswNlYmo5+VTiev3qYq5zVFH64oZfbxiQKrl9KsUesiOyL3Xuz3ceSok+MPsOa9ytyEKN5aji+TM7t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606572; c=relaxed/simple;
	bh=7dqHVymEpv+mbY9Ii99AQPmzVOgGT6bep74WvflVCio=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c60sinTakyKydZPhYLbmeSrqqK+EStADd6oBOiK0BMnXr6Yj7pnAzAOQs+kwBD1SQ8Dt3idoVIUJyitW4NT37lXMWSwZ8ABvcy2gLtyxyagMmw74fGj/WWy6xviO35NU3EOcyZj2fGP65Et2XXFPxHR/4+cNoH2ci2z9nwGOwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hicX5ReW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M1cGao002544;
	Thu, 22 Feb 2024 12:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=F0djyJzQX2boq62he0FY77tfcSeF1hlmz7vhqN4MXI8=; b=hi
	cX5ReW/Wtbbl0RCaW7zmhbOWSWfcCYUzS2uyeit+CfyTYagLhSoI5dpbWZgLsyft
	S/15vAvWsFnB+EV4bAROnOpfa2NdbCJzoAivOTohuNShB5mrz1k2unXHRho32bqd
	c+C0Cwn/Ec2vPogIhW23JJkl5R7C+1nYK6YViS0yRBBapWCkHpiuvMmdKL+eSphF
	68sWDc/j0mPawcjX4Oq4aqagiqJnxdaQxQyPyV57+Y/DkTvLLRiBFwRm9pDYljD7
	ZJVKwCbrx03RZSZYIctC8rrQZ1XhgwopqWjvo+GjY9hwBrRAQUvxi3jPFh4InwdW
	dpKuznfDkvBJjFTsFIMA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdvsehkac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 12:55:56 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MCtseU013656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 12:55:54 GMT
Received: from hu-sarohasa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 04:55:45 -0800
From: Sarosh Hasan <quic_sarohasa@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu
	<joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Prasad Sodagudi
	<psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>, Rob Herring
	<robh@kernel.org>
CC: <kernel@quicinc.com>, Sneh Shah <quic_snehshah@quicinc.com>,
        Suraj Jaiswal
	<quic_jsuraj@quicinc.com>
Subject: [PATCH net-next] net: stmmac: dwmac-qcom-ethqos: Update link clock rate only for RGMII
Date: Thu, 22 Feb 2024 18:25:17 +0530
Message-ID: <20240222125517.3356-1-quic_sarohasa@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6qj-1LaJaYXMpzY-ZwzeqVmwy3LF1NrY
X-Proofpoint-GUID: 6qj-1LaJaYXMpzY-ZwzeqVmwy3LF1NrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_10,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=998 adultscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402220103

Updating link clock rate for different speeds is only needed when
using RGMII, as that mode requires changing clock speed when the link
speed changes. Let's restrict updating the link clock speed in
ethqos_update_link_clk() to just RGMII. Other modes such as SGMII
only need to enable the link clock (which is already done in probe).

Signed-off-by: Sarosh Hasan <quic_sarohasa@quicinc.com>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 31631e3f89d0..9cd144fb3005 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -169,21 +169,23 @@ static void rgmii_dump(void *priv)
 static void
 ethqos_update_link_clk(struct qcom_ethqos *ethqos, unsigned int speed)
 {
-	switch (speed) {
-	case SPEED_1000:
-		ethqos->link_clk_rate =  RGMII_1000_NOM_CLK_FREQ;
-		break;
+	if (phy_interface_mode_is_rgmii(ethqos->phy_mode)) {
+		switch (speed) {
+		case SPEED_1000:
+			ethqos->link_clk_rate =  RGMII_1000_NOM_CLK_FREQ;
+			break;
 
-	case SPEED_100:
-		ethqos->link_clk_rate =  RGMII_ID_MODE_100_LOW_SVS_CLK_FREQ;
-		break;
+		case SPEED_100:
+			ethqos->link_clk_rate =  RGMII_ID_MODE_100_LOW_SVS_CLK_FREQ;
+			break;
 
-	case SPEED_10:
-		ethqos->link_clk_rate =  RGMII_ID_MODE_10_LOW_SVS_CLK_FREQ;
-		break;
-	}
+		case SPEED_10:
+			ethqos->link_clk_rate =  RGMII_ID_MODE_10_LOW_SVS_CLK_FREQ;
+			break;
+		}
 
-	clk_set_rate(ethqos->link_clk, ethqos->link_clk_rate);
+		clk_set_rate(ethqos->link_clk, ethqos->link_clk_rate);
+	}
 }
 
 static void ethqos_set_func_clk_en(struct qcom_ethqos *ethqos)
-- 
2.17.1


