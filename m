Return-Path: <linux-kernel+bounces-94928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A65A8746DA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D49B21AA2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605F617BAB;
	Thu,  7 Mar 2024 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jPqOo7Us"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1575E56E;
	Thu,  7 Mar 2024 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782630; cv=none; b=osxgY9kZlZFhKe3uwO3pafn1ADge2q6I5p9MSQvay9iPCemMSCJY74QTKTy00mOi/8jeBlrsnkdm6ZzF4ZDnjI/6NflkR8diQqcGI5vmfwLGn9wxHZFeL7NZfZkqrsQfzxnzAAxexz9fM/KK7AbvnA/w10ny9SaoiYkxIi15/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782630; c=relaxed/simple;
	bh=lyZ9Q6+RfYX19uOalFRBGyAlIDmVtOXIA/LKCIPA37Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCbvm3dmldd9Rnrn5q13QMxBr3NhhRaKW/GLCsM30O52cheEZ+r57GZ5eSy4lHHTx3egmMlKp5whp9pduPWf8D89oX9sWYJTcKa0yytiSPBAgdbsXAzmmWZ5v3ECBXCGxzvutbQuzgmwZLeWWZc2BwBp8ftBMUhAJG0KngPPlQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jPqOo7Us; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427129k2031657;
	Wed, 6 Mar 2024 19:36:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=XGbkZPV1JVkizVUt8II3CM1DI3YOn0sCKE5pBrzqqCY=; b=jPq
	Oo7UsKMxU61oycoV6BlgZIs4Kw9AS/YULoZMCkxFVBQZ1BF/DQufakDp9mEycXTB
	Mhj0adLhANyNjsjeYKQQG9ritiG62jjOQ33htB58Lkphbi/u8xqRTnewSJcB2wHz
	O7eWiFKv9wwH2DlV6vcZEUcE3tVowkaB+fA/LxV9xYl9nV+qVRK8RToMP4zhnBLH
	YSnd2U/i/VDjTMiMg8OrZpRKQ9n8zYTQR/YPQqgAHfGBLF33KLAVQFkXploh9SSm
	WXjWiBNDWIzcMAUIDwl7yCboofdZZylYAyp2A5rHmhZ6YaxetU5GHoswNMFnsvWW
	U9B4WIbEhIa4gKbFNkw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wq3jfrdh9-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 19:36:53 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 19:36:52 -0800
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 6 Mar 2024 19:36:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 6 Mar 2024 19:36:52 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id E139F3F707F;
	Wed,  6 Mar 2024 19:36:47 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>,
        <leo.yan@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v7 3/7] coresight: core: Add provision for panic callbacks
Date: Thu, 7 Mar 2024 09:06:21 +0530
Message-ID: <20240307033625.325058-4-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307033625.325058-1-lcherian@marvell.com>
References: <20240307033625.325058-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4DWl-SXKgRdEcCgCS_rc_Dh5Z5Edttth
X-Proofpoint-ORIG-GUID: 4DWl-SXKgRdEcCgCS_rc_Dh5Z5Edttth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-06_01,2023-05-22_02

Panic callback handlers allows coresight device drivers to sync
relevant trace data and trace metadata to reserved memory
regions so that they can be retrieved later in the subsequent
boot or in the crashdump kernel.

Signed-off-by: Linu Cherian <lcherian@marvell.com>

---
Changelog from v6:
* Rebase changes w.r.t struct coresight_device 

 drivers/hwtracing/coresight/coresight-core.c | 37 ++++++++++++++++++++
 include/linux/coresight.h                    | 12 +++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index b83613e34289..61d75aad476b 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -19,6 +19,7 @@
 #include <linux/property.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
+#include <linux/panic_notifier.h>
 
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
@@ -1365,6 +1366,36 @@ const struct bus_type coresight_bustype = {
 	.name	= "coresight",
 };
 
+static int coresight_panic_sync(struct device *dev, void *data)
+{
+	int mode;
+	struct coresight_device *csdev;
+
+	/* Run through panic sync handlers for all enabled devices */
+	csdev = container_of(dev, struct coresight_device, dev);
+	mode = coresight_get_mode(csdev);
+
+	if ((mode == CS_MODE_SYSFS) || (mode == CS_MODE_PERF)) {
+		if (panic_ops(csdev))
+			panic_ops(csdev)->sync(csdev);
+	}
+
+	return 0;
+}
+
+static int coresight_panic_cb(struct notifier_block *self,
+			       unsigned long v, void *p)
+{
+	bus_for_each_dev(&coresight_bustype, NULL, NULL,
+				 coresight_panic_sync);
+
+	return 0;
+}
+
+static struct notifier_block coresight_notifier = {
+	.notifier_call = coresight_panic_cb,
+};
+
 static int __init coresight_init(void)
 {
 	int ret;
@@ -1377,6 +1408,10 @@ static int __init coresight_init(void)
 	if (ret)
 		goto exit_bus_unregister;
 
+	/* Register function to be called for panic */
+	ret = atomic_notifier_chain_register(&panic_notifier_list,
+					     &coresight_notifier);
+
 	/* initialise the coresight syscfg API */
 	ret = cscfg_init();
 	if (!ret)
@@ -1391,6 +1426,8 @@ static int __init coresight_init(void)
 static void __exit coresight_exit(void)
 {
 	cscfg_exit();
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					     &coresight_notifier);
 	etm_perf_exit();
 	bus_unregister(&coresight_bustype);
 }
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 5f288d475490..b156467c9baa 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -315,6 +315,7 @@ enum cs_mode {
 #define link_ops(csdev)		csdev->ops->link_ops
 #define helper_ops(csdev)	csdev->ops->helper_ops
 #define ect_ops(csdev)		csdev->ops->ect_ops
+#define panic_ops(csdev)	csdev->ops->panic_ops
 
 /**
  * struct coresight_ops_sink - basic operations for a sink
@@ -384,11 +385,22 @@ struct coresight_ops_helper {
 	int (*disable)(struct coresight_device *csdev, void *data);
 };
 
+
+/**
+ * struct coresight_ops_panic - Generic device ops for panic handing
+ *
+ * @sync	: Sync the device register state/trace data
+ */
+struct coresight_ops_panic {
+	int (*sync)(struct coresight_device *csdev);
+};
+
 struct coresight_ops {
 	const struct coresight_ops_sink *sink_ops;
 	const struct coresight_ops_link *link_ops;
 	const struct coresight_ops_source *source_ops;
 	const struct coresight_ops_helper *helper_ops;
+	const struct coresight_ops_panic *panic_ops;
 };
 
 static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
-- 
2.34.1


