Return-Path: <linux-kernel+bounces-144794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E3C8A4ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002F5B22ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB003B18D;
	Mon, 15 Apr 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D/YpSzGg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A13219F3;
	Mon, 15 Apr 2024 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170955; cv=none; b=FRqYrJwepgkLe5Uk61+omgQc75pwHtsJzrdWqQbyV3iwiy+5xca9jdIiW8gqay+oe6qcHPku1NE0t/mUG9ldMM1OZf3kihB5NKbWsiJigNZLITet0lNuWowVY7w4udwls9TMqsXo4eHUr4c7CaQ8zryO+Cfq/0BGhX7Wz6cOLE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170955; c=relaxed/simple;
	bh=MMSPrUmwgN2qLdpt3KXhCkN/0191aCKN8f40hpNb6sE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZWtp5hkg7ljpirtrdyNVSs4fbTBbipjy7PYG9SQy7C5hR0bxXihA6KC0NmC4luqn2SrmA/2Zfg/qD9Dl0PNycEFfW0DMfNcDe1GOL0B6+QTT6pBaawTHjPZ/95q0taYFfmGyyMUaaH7C8rkf3r9K8wvRBMqBmZnJccYecPNMwOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D/YpSzGg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43F82B6r010720;
	Mon, 15 Apr 2024 08:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=oMEWZzM1rS6b1hQAERLelSHkbFuDmEIXiKyjw35akB8=; b=D/
	YpSzGgZd6c9hzIuXGo2CmDO4aEYUrvimLp6izzmur0Y3zL6Tb/CtqXJ2+kwfIfCS
	ALBxtFibzjgZze1TSPRS+5mjk7bjl4EUXVLfcQdpwnk/Fc4zG6YjR7NoMdRfcCDq
	/GHyWmOBzDOCkiBXA4WtYmGXxYMEJSu82mkJTfpYZj6By0ZYbWJw9zD89X+1gAfU
	xo406//WPJhBQtCm0+gVrrsVJLtqMa3bL8wNYski7hz1zRQCA2aonF5/6HFGC9wr
	WWxo9ss0yAsvzAUPu5pcA09KNamu7LvIfYYfELJRtU5CwlRCMlH93kB4AQmb/2/s
	ptdlHpPAVIVFmP4+aQfQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xgyq7r6tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 08:49:10 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43F8n8aD008759;
	Mon, 15 Apr 2024 08:49:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3xfk4khayk-1;
	Mon, 15 Apr 2024 08:49:08 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43F8n84g008754;
	Mon, 15 Apr 2024 08:49:08 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 43F8n7mm008753;
	Mon, 15 Apr 2024 08:49:08 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id 526235AFA; Mon, 15 Apr 2024 16:49:07 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v3 1/3] bus: mhi: host: Add sysfs entry to force device to enter EDL
Date: Mon, 15 Apr 2024 16:49:03 +0800
Message-Id: <1713170945-44640-2-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
References: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fMB-RU7igfulCOXQLzpsP2EkOVYvQ0Tl
X-Proofpoint-ORIG-GUID: fMB-RU7igfulCOXQLzpsP2EkOVYvQ0Tl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404150057
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
 Documentation/ABI/stable/sysfs-bus-mhi | 11 +++++++++++
 drivers/bus/mhi/host/init.c            | 35 ++++++++++++++++++++++++++++++++++
 include/linux/mhi.h                    |  2 ++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
index 1a47f9e..d0bf9ae 100644
--- a/Documentation/ABI/stable/sysfs-bus-mhi
+++ b/Documentation/ABI/stable/sysfs-bus-mhi
@@ -29,3 +29,14 @@ Description:	Initiates a SoC reset on the MHI controller.  A SoC reset is
                 This can be useful as a method of recovery if the device is
                 non-responsive, or as a means of loading new firmware as a
                 system administration task.
+
+What:           /sys/bus/mhi/devices/.../force_edl
+Date:           April 2024
+KernelVersion:  6.9
+Contact:        mhi@lists.linux.dev
+Description:    Force devices to enter EDL (emergency download) mode. Only MHI
+                controller that supports EDL mode and provides a mechanism for
+                manually triggering EDL contains this file. Once in EDL mode,
+                the flash programmer image can be downloaded to the device to
+                enter the flash programmer execution environment. This can be
+                useful if user wants to update firmware.
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
index cde01e1..8280545 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -353,6 +353,7 @@ struct mhi_controller_config {
  * @read_reg: Read a MHI register via the physical link (required)
  * @write_reg: Write a MHI register via the physical link (required)
  * @reset: Controller specific reset function (optional)
+ * @edl_trigger: CB function to enter EDL mode (optional)
  * @buffer_len: Bounce buffer length
  * @index: Index of the MHI controller instance
  * @bounce_buf: Use of bounce buffer
@@ -435,6 +436,7 @@ struct mhi_controller {
 	void (*write_reg)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
 			  u32 val);
 	void (*reset)(struct mhi_controller *mhi_cntrl);
+	int (*edl_trigger)(struct mhi_controller *mhi_cntrl);
 
 	size_t buffer_len;
 	int index;
-- 
2.7.4


