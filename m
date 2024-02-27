Return-Path: <linux-kernel+bounces-83570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2810869BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023351C21F64
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98E41482F2;
	Tue, 27 Feb 2024 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Kiy+ndZe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9EC146E8D;
	Tue, 27 Feb 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050203; cv=none; b=SFa1e78FdgUXLSWVBwRBT0srbCv0BH+pbr1KnmMAUzJNH2UzCflOhvwsqiZXONHgpeRPdd+MiN62zn72566nBaxUIsNDNAULNfAoxdtRX0KdGebZIu4D34jPVU2Q+hXY2t45F6vtkBBAp+WDf+s+mI3bMe+41qJ2LfL9H5zzuNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050203; c=relaxed/simple;
	bh=s43zmuKBRFXWcfjaRTyVKFsDV6KAbShwjjA1KIWLInU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V/UNjV6hjBr1LdrgBP+urKRJdXbglaAy/QCcXz5wDM66MD1VmNDviKqIeFuoPY6i3v7OHYpTbj1Chqak6aT+HOmOZf70M/Tl813duPWuPMVcrKv2YEa+CJMNeFOB2nGzBH+2QRYz6JLD+pnZvrCWuYEqUHdpvErIBXC4zegUvI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Kiy+ndZe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41REcbd3032078;
	Tue, 27 Feb 2024 16:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=W5cStkw2N0yXySR6E2ojMZNdsHwBF2F9TtvVX4tdNoI=; b=Ki
	y+ndZewDiCfentwLV5U5trwW42iIV3jfTpzHv6x0MTJ5Pab5aPbvTnNGSwYCCxQM
	P+dOGoI3PG0iYeeODEhL5K07cptyJQAY8+M/rUifyB1xW2EKzteAPbD2KRX5C18y
	qZtEVTH1eWOcyNlAnb09T//SyPMvwpPxudDlVipJJ4MKvVD8z80cVPgQjoO2mFYG
	+hbs548pHcytOBdCROFdU3Ripv6YDd4h3rGluNmBWMmZyX5gnUIPJMYRSzLMf8Dv
	q3mw+6Hni4chMGoPuv/VzfCtb9HvM0rrzfo7YXWfqaYOemZR+2gITcFU1PpFGaeT
	QvgDs60VfBz8K788/aQQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh85qsjtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 16:09:53 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RG9p0L017287
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 16:09:51 GMT
Received: from hu-priyjain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 08:09:48 -0800
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
Subject: [PATCH v3] thermal/drivers/tsens: Add suspend to RAM support for tsens
Date: Tue, 27 Feb 2024 21:39:28 +0530
Message-ID: <20240227160928.2671-1-quic_priyjain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ZuJQTu5RyW5vI437EFPTCjqewwfDqb3K
X-Proofpoint-GUID: ZuJQTu5RyW5vI437EFPTCjqewwfDqb3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=956 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270124

As part of suspend to RAM, tsens hardware will be turned off.
While resume callback, re-initialize tsens hardware.

Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
---
V2 -> V3: Remove suspend callback & interrupt enablement part from
resume callback.
V1 -> V2: Update commit text to explain the necessity of this patch

 drivers/thermal/qcom/tsens-v2.c |  1 +
 drivers/thermal/qcom/tsens.c    | 40 +++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h    |  6 +++++
 3 files changed, 47 insertions(+)

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
index 6d7c16ccb44d..396c1cd71351 100644
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
@@ -1193,6 +1194,45 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 	return ret;
 }
 
+#ifdef CONFIG_SUSPEND
+static int tsens_reinit(struct tsens_priv *priv)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->ul_lock, flags);
+
+	/* in VER_0 TSENS need to be explicitly enabled */
+	if (tsens_version(priv) == VER_0)
+		regmap_field_write(priv->rf[TSENS_EN], 1);
+
+	/*
+	 * Re-enable the watchdog, unmask the bark.
+	 * Disable cycle completion monitoring
+	 */
+	if (priv->feat->has_watchdog) {
+		regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
+		regmap_field_write(priv->rf[CC_MON_MASK], 1);
+	}
+
+	/* Re-enable interrupts */
+	if (tsens_version(priv) >= VER_0_1)
+		tsens_enable_irq(priv);
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
index cb637fa289ca..7a147d9d8544 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -635,6 +635,12 @@ int init_common(struct tsens_priv *priv);
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
 int get_temp_common(const struct tsens_sensor *s, int *temp);
 
+#ifdef CONFIG_SUSPEND
+int tsens_resume_common(struct tsens_priv *priv);
+#else
+#define tsens_resume_common		NULL
+#endif
+
 /* TSENS target */
 extern struct tsens_plat_data data_8960;
 
-- 
2.17.1


