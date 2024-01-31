Return-Path: <linux-kernel+bounces-46327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D297843E07
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CF01C2517F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753BD7F46B;
	Wed, 31 Jan 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aUpOyNr1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AD7E56C;
	Wed, 31 Jan 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699437; cv=none; b=LA573Lw/M/cK5FyJU4j+RwFj/56f6ZzYKbMYuTDyo0674pHrGj6KIiHgN1LM7318QWHPuqiHB6wk6cq92QOcuNx2nNwokdYbitm0eHJkOvfUeIAYNKOPbfoL+jRyj01SYneUJzldvKpUAgKbR1rGuI66ZOV28x4XWYmjpQNu4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699437; c=relaxed/simple;
	bh=F8ej+RfKy5uRlP3BtIE6c20cYRN6falVBUA+PQCrR74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6FoGmIGdDV4uP/aMXZgb2uJXlileuZFrhR248FURipnQsxFn1zs6OJ4D5Azer5WxOKFTzREmPuT1+bv1IsE393lfGdvE0q1UD08q/01L2t92uktR7JWwVWYmt713Bhewqxnbb8779Qnh98D2RFowT7p+KX0drqA/Z6AbAoTdqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aUpOyNr1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V7eFb9008867;
	Wed, 31 Jan 2024 11:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=OdVX0vbjRwNHZr0+EmbFNFjxgdY3hDawnsBgwICg6LI=; b=aU
	pOyNr1ek2cy1DsCeLuVXm/m8B4KMcSxQgBqilrk9fB4zrDzjtTaFtKmwrasF1M8F
	TawRcIueETHIdvaho0n6noFkZ3c3KSkkpso5FOPTDYQVTo4ZWqw4qQndw2PCUz8J
	T0DTNJXSFdW04ZaBQ7xSdECksYjmRYvs5Vnc7T/zyIFAo+SjIM/VbW2d8iX1dl54
	LfW3A0eb1ONq2gw/Khl+93DmD6p4tLlWMNwNeaaCClS+X84aWo7V94TqKTWS9TIF
	vb21ZXcLhPdNHSxoETLVbEAowFcXbAXe0eFvc+rT3AoC/deGlno41qNod+s83jh+
	nXDMgrHc+2GQhxlUO15g==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyj148ey8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 11:10:12 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VBABK1030025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 11:10:11 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 03:10:02 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <corbet@lwn.net>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <matthias.bgg@gmail.com>, <kgene@kernel.org>,
        <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_mojha@quicinc.com>
Subject: [PATCH v8 10/10] soc: qcom: register ramoops region with APSS minidump
Date: Wed, 31 Jan 2024 16:38:37 +0530
Message-ID: <20240131110837.14218-11-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240131110837.14218-1-quic_mojha@quicinc.com>
References: <20240131110837.14218-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SehR-QhgzFHfMbNc2djop_zP3H8JOB0F
X-Proofpoint-ORIG-GUID: SehR-QhgzFHfMbNc2djop_zP3H8JOB0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_06,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310085

Register ramoops region with APSS minidump via ramoops
info notifier so that these region gets captured on
system crash.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/soc/qcom/qcom_minidump.c | 84 ++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
index c0f76a51d0e8..7ca43d938b13 100644
--- a/drivers/soc/qcom/qcom_minidump.c
+++ b/drivers/soc/qcom/qcom_minidump.c
@@ -18,8 +18,10 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
+#include <linux/pstore_ram.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 #include <soc/qcom/qcom_minidump.h>
 
 #include "qcom_minidump_internal.h"
@@ -56,12 +58,22 @@ struct minidump_elfhdr {
  * @dev: Minidump backend device
  * @apss_data: APSS driver data
  * @md_lock: Lock to protect access to APSS minidump table
+ * @work: Minidump work for any required execution in process context.
+ * @nb_cookie: Save the cookie, will be used for unregistering the callback.
  */
 struct minidump {
 	struct minidump_elfhdr	 elf;
 	struct device		 *dev;
 	struct minidump_ss_data	 *apss_data;
 	struct mutex		 md_lock;
+	struct work_struct	 work;
+	void			 *nb_cookie;
+};
+
+static LIST_HEAD(apss_md_rlist);
+struct md_region_list {
+	struct qcom_minidump_region md_region;
+	struct list_head list;
 };
 
 /*
@@ -530,6 +542,58 @@ static int qcom_apss_md_table_init(struct minidump *md,
 	return 0;
 }
 
+static int register_ramoops_region(const char *name, int id, void *vaddr,
+				   phys_addr_t paddr, size_t size)
+{
+	struct qcom_minidump_region *md_region;
+	struct md_region_list *mdr_list;
+	int ret;
+
+	mdr_list = kzalloc(sizeof(*mdr_list), GFP_KERNEL);
+	if (!mdr_list)
+		return -ENOMEM;
+
+	md_region = &mdr_list->md_region;
+	scnprintf(md_region->name, sizeof(md_region->name), "K%s%d", name, id);
+	md_region->virt_addr = vaddr;
+	md_region->phys_addr = paddr;
+	md_region->size = size;
+	ret = qcom_minidump_region_register(md_region);
+	if (ret < 0) {
+		pr_err("failed to register region in minidump: err: %d\n", ret);
+		return ret;
+	}
+
+	list_add(&mdr_list->list, &apss_md_rlist);
+
+	return 0;
+}
+
+static void register_ramoops_minidump_cb(struct work_struct *work)
+{
+	struct minidump *md = container_of(work, struct minidump, work);
+
+	md->nb_cookie = register_ramoops_info_notifier(register_ramoops_region);
+	if (IS_ERR_OR_NULL(md->nb_cookie)) {
+		pr_err("Fail to register ramoops info notifier\n");
+		md->nb_cookie = NULL;
+	}
+}
+
+static void qcom_ramoops_minidump_unregister(void)
+{
+	struct md_region_list *mdr_list;
+	struct md_region_list *tmp;
+
+	list_for_each_entry_safe(mdr_list, tmp, &apss_md_rlist, list) {
+		struct qcom_minidump_region *region;
+
+		region = &mdr_list->md_region;
+		qcom_minidump_region_unregister(region);
+		list_del(&mdr_list->list);
+	}
+}
+
 static void qcom_apss_md_table_exit(struct minidump_ss_data *mdss_data)
 {
 	memset(mdss_data->md_ss_toc, cpu_to_le32(0), sizeof(*mdss_data->md_ss_toc));
@@ -575,6 +639,22 @@ static int qcom_apss_minidump_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, md);
 
+	/*
+	 * Use separate context for registering ramoops region via workqueue
+	 * as minidump probe can get called in same context of platform device
+	 * register call from smem driver and further call to qcom_smem_minidump_ready()
+	 * can return -EPROBE_DEFER as __smem->minidump is not yet initialized because
+	 * of same context and it can only initialized after return from probe.
+	 *
+	 * qcom_apss_minidump_probe()
+	 *   register_ramoops_minidump_cb()
+	 *     register_ramoops_region()
+	 *       qcom_minidump_region_register()
+	 *         qcom_smem_minidump_ready()
+	 */
+	INIT_WORK(&md->work, register_ramoops_minidump_cb);
+	schedule_work(&md->work);
+
 	return ret;
 }
 
@@ -582,6 +662,10 @@ static void qcom_apss_minidump_remove(struct platform_device *pdev)
 {
 	struct minidump *md = platform_get_drvdata(pdev);
 
+	flush_work(&md->work);
+	qcom_ramoops_minidump_unregister();
+	if (md->nb_cookie)
+		unregister_ramoops_info_notifier(md->nb_cookie);
 	qcom_apss_md_table_exit(md->apss_data);
 }
 
-- 
2.43.0.254.ga26002b62827


