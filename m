Return-Path: <linux-kernel+bounces-123650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B11E890C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9771F239C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0E213777B;
	Thu, 28 Mar 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fvu49aws"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BA113AA4E;
	Thu, 28 Mar 2024 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660058; cv=none; b=GxbjpyoBL1YIECeYvJON5gSNI+UG54+Cbo7uLxBtvklxutm9HNht9yvBL1kSio5tt6rRZ2By68F+Kd9pnGG2+RIIbOWpwJ7PHM7zafHRTGBnLsFmIhimCcPyUhW3yLKzPyRbSMBOHkWaVgr1FfzVI99X9V6GBg8pmQ28GfA8m+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660058; c=relaxed/simple;
	bh=ajrl5xFbmylF1E3F9VzWsJKto7vjAyCDVhsDuTeVjBA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QRQUvUdhMYBlS1HjdTPnDwk/0xnHluig1ArkC2w7E/w67cY/6skwFF/RgnxvDQ7TYyfcK++bKS4vOBDsvGPOHsS8WIWf+c78g/WQKVGo2sCN+U25XKkEygxXr018Y2Gwu4HK60iyCls0NwqNah7WF5IUrIaTShVWra7b48hxSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fvu49aws; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SIJV4g022597;
	Thu, 28 Mar 2024 21:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=JOF2Pbv30CLpNYimCGXkm/AAsQpZuvKl6VsyKwY+MtM=; b=fv
	u49awsQlGVBan5iThbE8Y9qeMaX1KEAUK9JUhm0714nanPZ7oSDRmJKNtBkQTsL8
	G9VrrgRXEIQqGUz/qhP0u6dY08k4o0m8Z6hFHvSfQjTRMlTX3ctYYjY6w1RGCNvm
	BL7xfz8Yg8gBhx9yV5HTiNCzNhJa2PUqGVtp/kzuieXVrOR/yzTE0tGVGOgXXY3m
	yMdQLjwqxVVMUwso0/Zbgs4Zff/Ts3e8qhPXs8eDS4ScLJ2LOvwPWPdZfSNnqfzv
	RhO//+DKsR0+y9Z7Q7DTvyn+WkNz3b0sxgus+6o8gsBE9E2cnqMTMdYi2wrH/gDv
	PaN0UZD8+VqVYQwp55DA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x562rhtpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:07:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SL7NR0031485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:07:23 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 14:07:23 -0700
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
Subject: [PATCH v1] phy/qcom-qmp-combo: propagate correct return value at phy_power_on()
Date: Thu, 28 Mar 2024 14:07:15 -0700
Message-ID: <1711660035-9656-1-git-send-email-quic_khsieh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: KTSCs0on7MkxkVW-TvwmjEUi-JuSKZSE
X-Proofpoint-GUID: KTSCs0on7MkxkVW-TvwmjEUi-JuSKZSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280151

Currently qmp_combo_dp_power_on() always return 0 in regardless of
return value of cfg->configure_dp_phy(). This patch propagate
return value of cfg->configure_dp_phy() all the way back to caller.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 36632fa..884973a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2754,6 +2754,7 @@ static int qmp_combo_dp_power_on(struct phy *phy)
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *tx = qmp->dp_tx;
 	void __iomem *tx2 = qmp->dp_tx2;
+	int ret = 0;
 
 	mutex_lock(&qmp->phy_mutex);
 
@@ -2766,11 +2767,11 @@ static int qmp_combo_dp_power_on(struct phy *phy)
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


