Return-Path: <linux-kernel+bounces-81081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAD9866FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD8A1C255D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB86604DE;
	Mon, 26 Feb 2024 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BMQO1ZH/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E43CA4E;
	Mon, 26 Feb 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940602; cv=none; b=qW4XKN0+i1M5HK45595FiqFw2YLM5hF01vWT6PU7yKbu28wWAIv1rBKq4QL3NbT6F1SncSkfMyu/+kjSVpF4nATjrG9zIbVlt5T3vV5h/V+9njXYfRIMYKpACVAN+7Pxw7J9LKWyreeIRPQFSVmLQekCPaq3kAQXmYXZPwD13nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940602; c=relaxed/simple;
	bh=K4GBuBvY1jfaKNJfI+V2iQAToLrbcQCzobKkx+s7CfI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=otiKHpXIaZR9Zg3jh9jSvazyWHyEiP1pcKM574ZLnB0jwis9+jRuw4y+QtEcffRhhCuRdDRGpgFW1zxi/OyheND5DFZtZpgIj287yD1C7A9IGe3bXtKsOob4bkYHs+rJTVmBcV/h2UW2/t1LFhKVG31hWq624NNJvDkRJreuZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BMQO1ZH/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q9PrLp028933;
	Mon, 26 Feb 2024 09:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=tPqIhtoFZXpZFmCyP7Lnu9T4i55IofRcpfNy6UEYCmY=; b=BM
	QO1ZH/h1SrCYOvYK0GONf06sofiRF/gqfcIRaF/dC4hx2zVcCbBJslkuSVcAqEsr
	p1u61ruVFRdcebf8gUI/6lMpwVKge5lrCZdafHTGgKlsDuk2Skqt7QfRwClmgmJj
	LMWGj5TZkWv4VXjaStQpLq3ynH64vw0YLSdxd/iYo5UZAZP/C1iQPVJGKUrtaJnD
	FxeJScgVepVK+0R+fPR+ndyBdGEWfhA62tGSMFKVtDStXke42PUee9JE45XvGgg8
	iP7y3MNlIqDBn3gcGsfofSahzfM0MNKe/GbNkp1nVkUTj08YlouvGi3TC3HuY/uA
	/4hdsrVR/DByZ2STvVtQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxkrh25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 09:43:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41Q9h4OM019569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 09:43:04 GMT
Received: from hu-sarohasa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 01:42:54 -0800
From: Sarosh Hasan <quic_sarohasa@quicinc.com>
To: Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
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
CC: <kernel@quicinc.com>, Sneh Shah <quic_snehshah@quicinc.com>,
        Suraj Jaiswal
	<quic_jsuraj@quicinc.com>
Subject: [PATCH net-next v2] net: stmmac: dwmac-qcom-ethqos: Update link clock rate only for RGMII
Date: Mon, 26 Feb 2024 15:12:26 +0530
Message-ID: <20240226094226.14276-1-quic_sarohasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: tUDjRYwkIeEMxJzJSSUfF6jLBNtXEbHZ
X-Proofpoint-GUID: tUDjRYwkIeEMxJzJSSUfF6jLBNtXEbHZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=924 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402260073

Updating link clock rate for different speeds is only needed when
using RGMII, as that mode requires changing clock speed when the link
speed changes. Let's restrict updating the link clock speed in
ethqos_update_link_clk() to just RGMII. Other modes such as SGMII
only need to enable the link clock (which is already done in probe).

Signed-off-by: Sarosh Hasan <quic_sarohasa@quicinc.com>
---
v2 changelog:
- Addressed Konrad Dybcio comment on optimizing the patch
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 31631e3f89d0..c182294a6515 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -169,6 +169,9 @@ static void rgmii_dump(void *priv)
 static void
 ethqos_update_link_clk(struct qcom_ethqos *ethqos, unsigned int speed)
 {
+	if (!phy_interface_mode_is_rgmii(ethqos->phy_mode))
+		return;
+
 	switch (speed) {
 	case SPEED_1000:
 		ethqos->link_clk_rate =  RGMII_1000_NOM_CLK_FREQ;
-- 
2.17.1


