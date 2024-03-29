Return-Path: <linux-kernel+bounces-125186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AA48921E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789801C262D7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E744F217;
	Fri, 29 Mar 2024 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IueKtM+q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F0E2AF13;
	Fri, 29 Mar 2024 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711730527; cv=none; b=ZAtMPOpaMTwVl2Z8KDWQy5xP/k0qdpyuWhxLzv/mX3ZNJktNzDjG18TVdoiNOKq8XxWIpxk0CoFBAtv88/y2YjTd9X4T3/pm8Pgu3vudGPJwvCDXvIEjcpZ4KAbK3pk3UbNWMRbc1yRlepyNECPnp9JMvbLX0Tu9zx2AU6aw/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711730527; c=relaxed/simple;
	bh=exGa4vc3yUI0belJY1c/x5dLGNfAQz/c5d0L3E9ssPc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fI4fqjxY/mKilNGYxaLGyUJ2jER/f2AIkThLaQtZohu0AM/Cg0VSdEWObZaIYLcYXDl1sUAdp+CpIFH80x+aKeVcIQjwVDpXcAyb+FUQvO6xisSA4ZjDL4SrMwrmcKnIWE5MWaJJzGNUq11+5KlO+azNhjQgzJMhCdLWpnpXO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IueKtM+q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TC9QZ1006585;
	Fri, 29 Mar 2024 16:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=iy4fArS6RL+x9fPCLyL31DSJ7krtKXCXNB9MQQ9rqKo=; b=Iu
	eKtM+qhUC1OgmLfeI8u/Qt/+NDouyUv4ys/y3MSUy94n+e9KE3dsyPWt4YuaKS8a
	4hBzWWGHRsse163E+PQHg8eUfZF+HUFZT1Qec8RGH67LMIMwv9ikQ7glQZp3Nmjr
	MW4hk71WYTrfkl9457yaoSm66ZaNznrZ5C4ZFja8ZXyF2UM58/XIQ5pTnPRVUC0a
	m5kJ9oo+LPBVdSmKNuGKarriaAuKXSBiM4TtTRuY5NgqiYSJA3JnEuKZCE1pE80E
	DO/9wlFfkAXZhqvLqCPaYkkaBuEIinW1oeITAlZQruvXTUmdtbfYtOcwc2nyLEUR
	BZ2lPHBczCBIMycZRcFQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5np29vav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 16:41:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TGfkTs021946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 16:41:46 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 09:41:45 -0700
From: Kuogee Hsieh <quic_khsieh@quicinc.com>
To: <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <abel.vesa@linaro.org>, <andersson@kernel.org>
CC: Kuogee Hsieh <quic_khsieh@quicinc.com>, <quic_abhinavk@quicinc.com>,
        <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] phy/qcom-qmp-combo: propagate correct return value at phy_power_on()
Date: Fri, 29 Mar 2024 09:41:35 -0700
Message-ID: <1711730495-30330-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 90N0YQZVFXb4HZCtSRj0n5qV5-tIGi-c
X-Proofpoint-GUID: 90N0YQZVFXb4HZCtSRj0n5qV5-tIGi-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290147

Currently qmp_combo_dp_power_on() always return 0 in regardless of
return value of cfg->configure_dp_phy(). This patch propagate
return value of cfg->configure_dp_phy() all the way back to caller.

Fixes: 52e013d0bffa ("phy: qcom-qmp: Add support for DP in USB3+DP combo phy")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 36632fa..513d99d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2343,8 +2343,10 @@ static int qmp_v3_configure_dp_phy(struct qmp_combo *qmp)
 	writel(0x05, qmp->dp_dp_phy + QSERDES_V3_DP_PHY_TX2_TX3_LANE_CTL);
 
 	ret = qmp_combo_configure_dp_clocks(qmp);
-	if (ret)
+	if (ret) {
+		dev_err(qmp->dev, "dp phy configure failed, err=%d\n", ret);
 		return ret;
+	}
 
 	writel(0x04, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG2);
 	writel(0x01, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
@@ -2519,8 +2521,10 @@ static int qmp_v4_configure_dp_phy(struct qmp_combo *qmp)
 	int ret;
 
 	ret = qmp_v456_configure_dp_phy(qmp);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(qmp->dev, "dp phy configure failed, err=%d\n", ret);
 		return ret;
+	}
 
 	/*
 	 * At least for 7nm DP PHY this has to be done after enabling link
@@ -2754,6 +2758,7 @@ static int qmp_combo_dp_power_on(struct phy *phy)
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *tx = qmp->dp_tx;
 	void __iomem *tx2 = qmp->dp_tx2;
+	int ret;
 
 	mutex_lock(&qmp->phy_mutex);
 
@@ -2766,11 +2771,11 @@ static int qmp_combo_dp_power_on(struct phy *phy)
 	cfg->configure_dp_tx(qmp);
 
 	/* Configure link rate, swing, etc. */
-	cfg->configure_dp_phy(qmp);
+	ret = cfg->configure_dp_phy(qmp);
 
 	mutex_unlock(&qmp->phy_mutex);
 
-	return 0;
+	return ret;
 }
 
 static int qmp_combo_dp_power_off(struct phy *phy)
-- 
2.7.4


