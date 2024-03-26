Return-Path: <linux-kernel+bounces-118478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B5C88BB81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0701C32452
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0113280C;
	Tue, 26 Mar 2024 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lY14P7Gk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8AB130AEC;
	Tue, 26 Mar 2024 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438870; cv=none; b=g6lBDb776i1JSP31TWXXay4X7jF5dApfjl0KAHjoifp/uAMNMWX4coCip0QjzOwac8eADE9Rq+Lcu633C7W52DyF80I0OM6QexAcKoGyzqyancEJT7UC0sbiZPGXaXHqYmNP8zr39erwhWYYSfkYjVLwUU4T5T56JvkzXgFWZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438870; c=relaxed/simple;
	bh=cr6d1YtaJMJnXA7T6RQPG8txmgH0XsljQTSlGhmTlZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fiTw/12TvfaF35bEQw90fYsRQW6Uyv1HidvujAr35m4PxkJ6AA1PM0rHGFvByNA0ib8n2GwM+GMmQax/I83Oil624jeulX1ekDdFYvRj5kxElAwdLkEL4cX5lpwgd1EtKD9S7BcB/YBv+h7U1sqwCgbxSkqfjljWSPSLihba8TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lY14P7Gk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q3JY9R000843;
	Tue, 26 Mar 2024 07:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=44iY2+07TJVazyktNEyLb6flAPduNQ6U/meDDbnqBlo=; b=lY
	14P7Gke4Sg9s53Gb38QDGjmyno1zgegsIiF3WFWpU/KqTZahI7d5q0iNAdb5OS18
	9k6W5Vy4xKCk9sjoIfscynBlqAVww7Y/0ioyTWUXHAfWKSu5/AZoGiWPlqPdfemI
	XNJoxxunZjrPbvmbfJtNtur0kfx+MywC49fqI3/EpeAlVKMG/ZO/zvOGKmJe3o2s
	sQuh1kxHUp4SsIMy6bG4cIKKGAuxtH19AFuWa3ciARZ8TvdCEAtG0naz4ogSP4hi
	45wma6vCXpEhB9T4yfVqlM010Pa+V3obXUuyVIYO5TlD1QsX4AIT9tQQaenz4Q4J
	08dqnX/YVS4SKs4IVMsA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x38amakp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 07:40:58 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42Q7evFZ013826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 07:40:57 GMT
Received: from hu-priyjain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 00:40:53 -0700
From: Priyansh Jain <quic_priyjain@quicinc.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath
	<thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_manafm@quicinc.com>, <quic_priyjain@quicinc.com>
Subject: [PATCH v4] thermal/drivers/tsens: Add suspend to RAM support for tsens
Date: Tue, 26 Mar 2024 13:10:33 +0530
Message-ID: <20240326074033.17002-1-quic_priyjain@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j_hoVeNHJz2ryj3Hv4SFRn1lnsDHh3bV
X-Proofpoint-GUID: j_hoVeNHJz2ryj3Hv4SFRn1lnsDHh3bV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260051

As part of suspend to RAM, tsens hardware will be turned off.
While resume callback, re-initialize tsens hardware.

Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
---
V3 -> V4: Make tsens_reinit function specific to tsens v2. Add
NULL resume callback support for platform whose versions < ver_2_x
in tsens ops.
V2 -> V3: Remove suspend callback & interrupt enablement part from
resume callback.
V1 -> V2: Update commit text to explain the necessity of this patch

 drivers/thermal/qcom/tsens-v0_1.c |  6 +++++
 drivers/thermal/qcom/tsens-v1.c   |  3 +++
 drivers/thermal/qcom/tsens-v2.c   |  1 +
 drivers/thermal/qcom/tsens.c      | 37 +++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h      |  5 +++++
 5 files changed, 52 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 32d2d3e33287..7ed85379247b 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -329,6 +329,7 @@ static const struct tsens_ops ops_8226 = {
 	.init		= init_8226,
 	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_common,
+	.resume		= NULL,
 };
 
 struct tsens_plat_data data_8226 = {
@@ -342,6 +343,7 @@ static const struct tsens_ops ops_8909 = {
 	.init		= init_8909,
 	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_common,
+	.resume		= NULL,
 };
 
 struct tsens_plat_data data_8909 = {
@@ -355,6 +357,7 @@ static const struct tsens_ops ops_8916 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8916,
 	.get_temp	= get_temp_common,
+	.resume		= NULL,
 };
 
 struct tsens_plat_data data_8916 = {
@@ -370,6 +373,7 @@ static const struct tsens_ops ops_8939 = {
 	.init		= init_8939,
 	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_common,
+	.resume		= NULL,
 };
 
 struct tsens_plat_data data_8939 = {
@@ -385,6 +389,7 @@ static const struct tsens_ops ops_8974 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8974,
 	.get_temp	= get_temp_common,
+	.resume		= NULL,
 };
 
 struct tsens_plat_data data_8974 = {
@@ -398,6 +403,7 @@ static const struct tsens_ops ops_9607 = {
 	.init		= init_9607,
 	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_common,
+	.resume		= NULL,
 };
 
 struct tsens_plat_data data_9607 = {
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index dc1c4ae2d8b0..770bf0917026 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -154,6 +154,7 @@ static const struct tsens_ops ops_generic_v1 = {
 	.init		= init_common,
 	.calibrate	= calibrate_v1,
 	.get_temp	= get_temp_tsens_valid,
+	.resume		= NULL,
 };
 
 struct tsens_plat_data data_tsens_v1 = {
@@ -166,6 +167,7 @@ static const struct tsens_ops ops_8956 = {
 	.init		= init_8956,
 	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_tsens_valid,
+	.resume		= NULL,
 };
 
 struct tsens_plat_data data_8956 = {
@@ -179,6 +181,7 @@ static const struct tsens_ops ops_8976 = {
 	.init		= init_common,
 	.calibrate	= tsens_calibrate_common,
 	.get_temp	= get_temp_tsens_valid,
+	.resume		= NULL,
 };
 
 struct tsens_plat_data data_8976 = {
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 29a61d2d6ca3..0cb7301eca6e 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -107,6 +107,7 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
 	.get_temp	= get_temp_tsens_valid,
+	.resume		= tsens_resume_common,
 };
 
 struct tsens_plat_data data_tsens_v2 = {
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6d7c16ccb44d..0ff588cb53b2 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -17,6 +17,7 @@
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/thermal.h>
 #include "../thermal_hwmon.h"
 #include "tsens.h"
@@ -1193,6 +1194,42 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 	return ret;
 }
 
+#ifdef CONFIG_SUSPEND
+static int tsens_reinit(struct tsens_priv *priv)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->ul_lock, flags);
+
+	if (tsens_version(priv) >= VER_2_X) {
+		/*
+		 * Re-enable the watchdog, unmask the bark.
+		 * Disable cycle completion monitoring
+		 */
+		if (priv->feat->has_watchdog) {
+			regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
+			regmap_field_write(priv->rf[CC_MON_MASK], 1);
+		}
+
+		/* Re-enable interrupts */
+		tsens_enable_irq(priv);
+	}
+
+	spin_unlock_irqrestore(&priv->ul_lock, flags);
+
+	return 0;
+}
+
+int tsens_resume_common(struct tsens_priv *priv)
+{
+	if (pm_suspend_target_state == PM_SUSPEND_MEM)
+		tsens_reinit(priv);
+
+	return 0;
+}
+
+#endif /* !CONFIG_SUSPEND */
+
 static int tsens_register(struct tsens_priv *priv)
 {
 	int i, ret;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index cb637fa289ca..cab39de045b1 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -634,6 +634,11 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
 int init_common(struct tsens_priv *priv);
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
 int get_temp_common(const struct tsens_sensor *s, int *temp);
+#ifdef CONFIG_SUSPEND
+int tsens_resume_common(struct tsens_priv *priv);
+#else
+#define tsens_resume_common            NULL
+#endif
 
 /* TSENS target */
 extern struct tsens_plat_data data_8960;
-- 
2.17.1


