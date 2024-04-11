Return-Path: <linux-kernel+bounces-139695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BB38A0693
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A951F24B60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C613BAE2;
	Thu, 11 Apr 2024 03:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lMA89NG9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782C60B96;
	Thu, 11 Apr 2024 03:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805340; cv=none; b=KVIh/cj+I+AK3AQSFw3CXf1koKlb5+sfJ3suaKY0zA0HJhpfP/v0PKSdbQAS/tvwpf1o+UGnHHCqHWNRMtaR8AsRRbKX8KJ1Z2Bd0RfF2btMuToqT/OOBvwisc1l1/O5L/9+lm5MlS8T/bS2uleBrFIHPQj7bJYiqokiSZCc4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805340; c=relaxed/simple;
	bh=03o3OZMec3i6+7kXt9bjcwyykE6NhH/f7zbRnRjFZic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lo7DXwnE2BeVtkC92SGrhRt4eS5dIZMqYIxemgUaYJQggJ8GcRplwIGUpPMdVAXovWVLDjmVF2OqDNeTAY4FvBb79aFyQWwfnYY21/h/81Hz1b1ydSXbtnZinx1uQ+j+EiYceWJa5HAJXBQFvX6sceT8Gp4ewE/QOsPviqH4fHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lMA89NG9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B25w00028277;
	Thu, 11 Apr 2024 03:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=+yvAfit7ZAAA6z0gbZIpLHd60u1vYkDyZrFseJzEr+Q=; b=lM
	A89NG923m/IOs7QPl4LzL/yLcTpj7u3TDnsU9ZwgxPaTIt44qzspfxgx1zP/9yqQ
	CB7uN3kvzJs1kqZT0KkCkWYL0NJHPjOooz5nvpWUaQ01oANkAkwGnECf7/itN01L
	ngx95DnyHt2dXI9ckVFyAcVQXWT5jumSZW3tLeRuxLfCUYYcf177udP5MRrZ9UfV
	lXYK7pvy14366zdbjgFeVcqYl91DvklRJao8ObwoP2fAuvp7fHXRtNHOUhfpapaP
	TM/6xe9ugMgEIpF3PEf+UJUheYNw3fV5gTH0I/Nj5hyKf+zgX1X92jh8ja8iBpNC
	nSPZZlwX+LHpQXhdI3Qg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xe0pw16xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 03:15:35 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43B3FXlx018372;
	Thu, 11 Apr 2024 03:15:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3xayfkm15x-1;
	Thu, 11 Apr 2024 03:15:33 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43B3FWWc018354;
	Thu, 11 Apr 2024 03:15:33 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 43B3FWNK018363;
	Thu, 11 Apr 2024 03:15:33 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id 33A175ADF; Thu, 11 Apr 2024 11:15:32 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2 1/2] bus: mhi: host: Add sysfs entry to force device to enter EDL
Date: Thu, 11 Apr 2024 11:15:28 +0800
Message-Id: <1712805329-46158-2-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1712805329-46158-1-git-send-email-quic_qianyu@quicinc.com>
References: <1712805329-46158-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4talb_mII-ohnl83ahmVrGPauOSS4HJf
X-Proofpoint-ORIG-GUID: 4talb_mII-ohnl83ahmVrGPauOSS4HJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110022
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add sysfs entry to allow users of MHI bus force device to enter EDL.
Considering that the way to enter EDL mode varies from device to device and
some devices even do not support EDL. Hence, add a callback edl_trigger in
mhi controller as part of the sysfs entry to be invoked and MHI core will
only create EDL sysfs entry for mhi controller that provides edl_trigger
callback. All of the process a specific device required to enter EDL mode
can be placed in this callback.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/bus/mhi/host/init.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/mhi.h         |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 44f9349..333ac94 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -127,6 +127,32 @@ static ssize_t soc_reset_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(soc_reset);
 
+static ssize_t force_edl_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret < 0) {
+		dev_err(dev, "Could not parse string: %d\n", ret);
+		return ret;
+	}
+
+	if (!val)
+		return count;
+
+	ret = mhi_cntrl->edl_trigger(mhi_cntrl);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_WO(force_edl);
+
 static struct attribute *mhi_dev_attrs[] = {
 	&dev_attr_serial_number.attr,
 	&dev_attr_oem_pk_hash.attr,
@@ -1018,6 +1044,12 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	if (ret)
 		goto err_release_dev;
 
+	if (mhi_cntrl->edl_trigger) {
+		ret = sysfs_create_file(&mhi_dev->dev.kobj, &dev_attr_force_edl.attr);
+		if (ret)
+			goto err_release_dev;
+	}
+
 	mhi_cntrl->mhi_dev = mhi_dev;
 
 	mhi_create_debugfs(mhi_cntrl);
@@ -1051,6 +1083,9 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
 	mhi_deinit_free_irq(mhi_cntrl);
 	mhi_destroy_debugfs(mhi_cntrl);
 
+	if (mhi_cntrl->edl_trigger)
+		sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_force_edl.attr);
+
 	destroy_workqueue(mhi_cntrl->hiprio_wq);
 	kfree(mhi_cntrl->mhi_cmd);
 	kfree(mhi_cntrl->mhi_event);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index cde01e1..8db56d7 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -435,6 +435,7 @@ struct mhi_controller {
 	void (*write_reg)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
 			  u32 val);
 	void (*reset)(struct mhi_controller *mhi_cntrl);
+	int (*edl_trigger)(struct mhi_controller *mhi_cntrl);
 
 	size_t buffer_len;
 	int index;
-- 
2.7.4


