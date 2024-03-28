Return-Path: <linux-kernel+bounces-122413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5867C88F6F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2CD1C248A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7003FBB8;
	Thu, 28 Mar 2024 05:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GRuZXFw4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA25847C;
	Thu, 28 Mar 2024 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711602192; cv=none; b=e63iasCDG8Ez70/bE/LLVJ4w6aGT82vss9Tm41M1aNYRNfR96RrTY92DIPFIR/ymnZuPQdClevqcGh1seHnhwg0ZDcRZIiKSiOQUPUMp+09xq5KWaNrNCPOnvuRvChqIWstyiniQAiELdMrR7w6RKdTGevMYymtnlD7uIEGib8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711602192; c=relaxed/simple;
	bh=xlFRxNyKuLqP31vimNSvMhRXam4KBxdrzgF44WGSPLw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZLAHYm6u7+PSgaudXQiXskC2RGDW5Uq1Ig42ToxUrtbaAgVF9Z0/zctYwCiAPCwuqcuzpKQcDtx9eYI+Wl5+eLnitoA7NNj7vp8Aq4OdOrHyRbIo9VcUM5X9b4yUxpOKiwflheDOpf5zSH0qqitdSDdtWmL1m7ydnklpZN1U05I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GRuZXFw4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S28wLf028556;
	Thu, 28 Mar 2024 05:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=lgZMh3HLz6p4PsgPAKimOwj4hambtBmUpciAVihBXD0=; b=GR
	uZXFw4i+a/DUilD/zxrtw9gseG/RxgC4vTMa8lDje5/48Dz0YYdqyW5q5GCWmK+A
	4TsAVhggvMdIpdAF4Xsxk9jfKHRuzyN4Mg3bovcMuqTtDY+/OhroB+T3/KNsSsUR
	EF2jR1enahpW7MIuFZ1hlUfUc/Aymm/6shr1btfZhgDcHdR8ehn2Vv/lV0N5Hpyo
	tLcYES/p4sTpi/iTBHepn5JE+OnaVZIRD/aMK4CNZnno7jVshRyHOthKYlLNUxo2
	1Kf2lZmwcEDvyU4KRlh6fDU7+b4idU4ZSTH5meuJi6QJR3LoNikY7njBvIkDB3zL
	PMjv2piRLwusf0ZnLDTA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u209p6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 05:02:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S52s6P011299
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 05:02:54 GMT
Received: from hu-priyjain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 27 Mar 2024 22:02:49 -0700
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
Subject: [PATCH v5] thermal/drivers/tsens: Add suspend to RAM support for tsens
Date: Thu, 28 Mar 2024 10:32:30 +0530
Message-ID: <20240328050230.31770-1-quic_priyjain@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0cNUL-xR9p4FwexMaIsX-J1Vw4InKDw_
X-Proofpoint-GUID: 0cNUL-xR9p4FwexMaIsX-J1Vw4InKDw_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_04,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280028

As part of suspend to RAM, tsens hardware will be turned off.
While resume callback, re-initialize tsens hardware.

Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
---
V4 -> V5: Remove unused spinlock from tsens_reinit function.
V3 -> V4: Make tsens_reinit function specific to tsens v2. Add
NULL resume callback support for platform whose versions < ver_2_x
in tsens ops.
V2 -> V3: Remove suspend callback & interrupt enablement part from
resume callback.
V1 -> V2: Update commit text to explain the necessity of this patch.

 drivers/thermal/qcom/tsens-v2.c |  1 +
 drivers/thermal/qcom/tsens.c    | 31 +++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h    |  5 +++++
 3 files changed, 37 insertions(+)

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
index 6d7c16ccb44d..1c9df4f84641 100644
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
@@ -1193,6 +1194,36 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 	return ret;
 }
 
+#ifdef CONFIG_SUSPEND
+static int tsens_reinit(struct tsens_priv *priv)
+{
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


