Return-Path: <linux-kernel+bounces-85554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F4786B7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984331C2610F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD9E74404;
	Wed, 28 Feb 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mbck3XZR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF271EB3;
	Wed, 28 Feb 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146226; cv=none; b=FTXwjq5Pau7+vAXlx3fOKBNMWmHCOcaS+xPbDB3LdPtYkfaMtBtDtPCSmDxnJqnkRmafn2XKXTzgl5mH1wtOPSLMs2sl4xvD3fjLRHjiOSzMi3LVp8w2/LRAG9rnjQi3yiuJ4+/YruMe+t1Z9/9L73AZLuahdEWg70ttWLXU52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146226; c=relaxed/simple;
	bh=eMm9aJv7SSxqr39wSNL3YYMZMz1HnjzBU+cyAH2AhDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KYJr/524AyUCRieondoJ+aUQiuEBtx2+cBIKjTHC/APNXd0BdEHDkn+OsTeOWprP+CUGr36EFnAG6fgWFFeuHDbvybL5WOjxU9LrOe2r+A54tTHTmP0HyAqk0KE/BHEObzHun8xmqMWTkmG95TWjeIL+JoJNQut5mxz2prpOIdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mbck3XZR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SBdYgb024776;
	Wed, 28 Feb 2024 18:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=wwIB7Z+EF1d95ClqG/Iw6PuvjVju+1e3xeWmF1pn7HA
	=; b=mbck3XZRVX37eRjJRPisyacMS0iuKNR8Zhw0QbNhyV4Uwv9fR9xCKn2W3F5
	SJHtURtvp0b3KpXlhy8ynrcKkEFUD8qnevUprll8XnslaSNimjh1SVLJmkLgG668
	RTjHxDhw2w/ZOEk1l54UylCwy3ihZ84Yn4qI4hnJnT3/Eg9MCkjJmzT5gpk+qcNf
	uPQskoWEyaGeYpaLXo6FQsu2klijYYYW9SsSTDp+mN3/GNAUSlYTbZgtoHNU9rBM
	qkuR7X3tmw6AEgkcYXcK11wAyfEAEcgpbUmUjBNr2xur9jzYgZOhx9Ktt++jO1oF
	mrI3fHYX/vpv5WIVRImqtDAA7AQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj458h7nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 18:50:18 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SIoG6k008661
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 18:50:16 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 10:50:13 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Date: Wed, 28 Feb 2024 10:50:00 -0800
Subject: [PATCH 2/3] firmware: qcom-scm: Support multiple waitq contexts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240228-multi_waitq-v1-2-ccb096419af0@quicinc.com>
References: <20240228-multi_waitq-v1-0-ccb096419af0@quicinc.com>
In-Reply-To: <20240228-multi_waitq-v1-0-ccb096419af0@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Prasad Sodagudi <quic_psdoagud@quicinc.com>,
        "Murali
 Nalajala" <quic_mnalajal@quicinc.com>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        Unnathi Chalicheemala <quic_uchalich@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709146213; l=5367;
 i=quic_uchalich@quicinc.com; s=20240202; h=from:subject:message-id;
 bh=eMm9aJv7SSxqr39wSNL3YYMZMz1HnjzBU+cyAH2AhDQ=;
 b=3ERQruRtRQniDNYtsv0fLSYf2/DIglBjHKOotYp3sEp6N8gvqj4pf/xlsXG0l8VXORLZ7Mjau
 +QQryaiT7E0A6vnUC8CT2O9MOXOVRwrWeRUi/5xHY2isfA20QNz3N3x
X-Developer-Key: i=quic_uchalich@quicinc.com; a=ed25519;
 pk=8n+IFmsCDcEIg91sUP/julv9kf7kmyIKT2sR+1yFd4A=
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YrJoN9xHW9ou1N2xNjSDPl_u0pP2-qTa
X-Proofpoint-ORIG-GUID: YrJoN9xHW9ou1N2xNjSDPl_u0pP2-qTa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280148

Currently, only a single waitqueue context is supported, with waitqueue
id zero. SM8650 firmware now supports multiple waitqueue contexts, so
add support to dynamically create and support as many unique waitqueue
contexts as firmware returns to the driver.
Unique waitqueue contexts are supported using xarray to create a
hash table for associating a unique wq_ctx with a struct completion
variable for easy lookup.
The waitqueue ids can be >=0 as now we have more than one waitqueue
context.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm-smc.c |  7 +++-
 drivers/firmware/qcom/qcom_scm.c     | 77 ++++++++++++++++++++++++++----------
 drivers/firmware/qcom/qcom_scm.h     |  3 +-
 3 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
index 16cf88acfa8e..80083e3615b1 100644
--- a/drivers/firmware/qcom/qcom_scm-smc.c
+++ b/drivers/firmware/qcom/qcom_scm-smc.c
@@ -103,7 +103,12 @@ static int __scm_smc_do_quirk_handle_waitq(struct device *dev, struct arm_smccc_
 			wq_ctx = res->a1;
 			smc_call_ctx = res->a2;
 
-			ret = qcom_scm_wait_for_wq_completion(wq_ctx);
+			if (!dev) {
+				/* Protect the dev_get_drvdata() call that follows */
+				return -EPROBE_DEFER;
+			}
+
+			ret = qcom_scm_wait_for_wq_completion(dev_get_drvdata(dev), wq_ctx);
 			if (ret)
 				return ret;
 
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index c1be8270ead1..4606c49ef155 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 
 #include "qcom_scm.h"
 
@@ -33,7 +34,7 @@ struct qcom_scm {
 	struct clk *iface_clk;
 	struct clk *bus_clk;
 	struct icc_path *path;
-	struct completion waitq_comp;
+	struct xarray waitq;
 	struct reset_controller_dev reset;
 
 	/* control access to the interconnect path */
@@ -1742,42 +1743,74 @@ bool qcom_scm_is_available(void)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_is_available);
 
-static int qcom_scm_assert_valid_wq_ctx(u32 wq_ctx)
+static struct completion *qcom_scm_get_completion(struct qcom_scm *scm, u32 wq_ctx)
 {
-	/* FW currently only supports a single wq_ctx (zero).
-	 * TODO: Update this logic to include dynamic allocation and lookup of
-	 * completion structs when FW supports more wq_ctx values.
+	struct completion *wq;
+	struct completion *old;
+	int err;
+
+	wq = xa_load(&scm->waitq, wq_ctx);
+	if (wq) {
+		/*
+		 * Valid struct completion *wq found corresponding to
+		 * given wq_ctx. We're done here.
+		 */
+		goto out;
+	}
+
+	/*
+	 * If a struct completion *wq does not exist for wq_ctx, create it. FW
+	 * only uses a finite number of wq_ctx values, so we will be reaching
+	 * here only a few times right at the beginning of the device's uptime
+	 * and then early-exit from idr_find() above subsequently.
 	 */
-	if (wq_ctx != 0) {
-		dev_err(__scm->dev, "Firmware unexpectedly passed non-zero wq_ctx\n");
-		return -EINVAL;
+	wq = kzalloc(sizeof(*wq), GFP_ATOMIC);
+	if (!wq) {
+		wq = ERR_PTR(-ENOMEM);
+		goto out;
 	}
 
-	return 0;
+	init_completion(wq);
+
+	old = xa_store(&scm->waitq, wq_ctx, wq, GFP_ATOMIC);
+	err = xa_err(old);
+	if (err) {
+		kfree(wq);
+		wq = ERR_PTR(err);
+	}
+
+out:
+	return wq;
 }
 
-int qcom_scm_wait_for_wq_completion(u32 wq_ctx)
+int qcom_scm_wait_for_wq_completion(struct qcom_scm *scm, u32 wq_ctx)
 {
-	int ret;
+	struct completion *wq;
 
-	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
-	if (ret)
-		return ret;
+	wq = qcom_scm_get_completion(scm, wq_ctx);
+	if (IS_ERR(wq)) {
+		pr_err("Unable to wait on invalid waitqueue for wq_ctx %d: %ld\n",
+						wq_ctx, PTR_ERR(wq));
+		return PTR_ERR(wq);
+	}
 
-	wait_for_completion(&__scm->waitq_comp);
+	wait_for_completion(wq);
 
 	return 0;
 }
 
 static int qcom_scm_waitq_wakeup(struct qcom_scm *scm, unsigned int wq_ctx)
 {
-	int ret;
+	struct completion *wq;
 
-	ret = qcom_scm_assert_valid_wq_ctx(wq_ctx);
-	if (ret)
-		return ret;
+	wq = qcom_scm_get_completion(scm, wq_ctx);
+	if (IS_ERR(wq)) {
+		pr_err("Unable to wake up invalid waitqueue for wq_ctx %d: %ld\n",
+						wq_ctx, PTR_ERR(wq));
+		return PTR_ERR(wq);
+	}
 
-	complete(&__scm->waitq_comp);
+	complete(wq);
 
 	return 0;
 }
@@ -1854,7 +1887,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	init_completion(&scm->waitq_comp);
+	platform_set_drvdata(pdev, scm);
+
+	xa_init(&scm->waitq);
 
 	__scm = scm;
 	__scm->dev = &pdev->dev;
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 4532907e8489..d54df5a2b690 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -62,7 +62,8 @@ struct qcom_scm_res {
 	u64 result[MAX_QCOM_SCM_RETS];
 };
 
-int qcom_scm_wait_for_wq_completion(u32 wq_ctx);
+struct qcom_scm;
+int qcom_scm_wait_for_wq_completion(struct qcom_scm *scm, u32 wq_ctx);
 int scm_get_wq_ctx(u32 *wq_ctx, u32 *flags, u32 *more_pending);
 
 #define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))

-- 
2.25.1


