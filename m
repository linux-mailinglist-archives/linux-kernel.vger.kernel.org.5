Return-Path: <linux-kernel+bounces-154874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE178AE242
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD081F225A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33367BAFF;
	Tue, 23 Apr 2024 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E2tMDePN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D164CB55;
	Tue, 23 Apr 2024 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868437; cv=none; b=KMcny5m+npf2PCD2uzAHoHVYWg8dayDsLLeJ27Xu5RyZHrK01Ma53BakxM6tnblFZCXeRAyqjsAdGnkDSpELkfoGIjWuTzzGE47eGehr8PH3Aq95O5GhFJKR1RqF+lrM25LSRpEX43JVEXpSCbsSDKV/UXFcuwY+Hmx9XA0KQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868437; c=relaxed/simple;
	bh=UtpNEe7RCVCyvjmiQbOopIWJt3NeINXQPxdStX6uzGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dL4a8Km+6idLT678ZedonevDnP9tIt55OHOKTLEXsf2+g0DAUZQ+vMw1jzdbOlRCcEl3hRevOt3HdsWVvB+gx/u/6wEsuTyykjKze4RLyPI/Gvs42grKgT/idHTt+3qHhNbPy5G1d0b7TSUcfxRcG7MpEj2MdA4w8jTYByiyDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E2tMDePN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N7uX8A019524;
	Tue, 23 Apr 2024 10:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=ngidwSR8rhrotn4Wwssi/8HJt6GkxJpIhIcymAffNfk=; b=E2
	tMDePNdHhWwWORDe8P78B9ICMuZ4tWro5OPNQ28EZ0GNcnbtBRe3WILVURWK/Ckq
	av/vjxnGz4biIIzsE0w9TcmgR6aE7HzkBtVxANJhW4kHTEcINQ9SevGy6eKcrvHP
	wigmOhh+VB9wsCd6c4b7UXonw/ppy53fpoVP9XO4nGs8stPQSqJE3pbnYCXsZkG5
	dcfvHGlJiPb6sz+t4Kcz1pDuGcUTrLAT5B+dzntpX2GXdlEvpsT7amkYiRHAC/UV
	gg3yfkmq1HfVNYIp6YByd4w47V+rAdk26cWYjLVOxkgZQXglk5aDuvroAQFreO8j
	fcZjhO4AFSmIb7O0OYGw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp91rrcek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 10:33:43 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43NAXetW030325;
	Tue, 23 Apr 2024 10:33:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3xm6skdt6a-1;
	Tue, 23 Apr 2024 10:33:40 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NAXeTE030320;
	Tue, 23 Apr 2024 10:33:40 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 43NAXef6030319;
	Tue, 23 Apr 2024 10:33:40 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id 8E6645B13; Tue, 23 Apr 2024 18:33:39 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v4 1/3] bus: mhi: host: Add sysfs entry to force device to enter EDL
Date: Tue, 23 Apr 2024 18:33:35 +0800
Message-Id: <1713868417-37856-2-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713868417-37856-1-git-send-email-quic_qianyu@quicinc.com>
References: <1713868417-37856-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u91YeVTGBqAdZW4xFWRkqUKiU8mTMC8C
X-Proofpoint-ORIG-GUID: u91YeVTGBqAdZW4xFWRkqUKiU8mTMC8C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230028
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
 Documentation/ABI/stable/sysfs-bus-mhi | 13 +++++++++++++
 drivers/bus/mhi/host/init.c            | 33 +++++++++++++++++++++++++++++++++
 include/linux/mhi.h                    |  2 ++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
index 1a47f9e..b44f467 100644
--- a/Documentation/ABI/stable/sysfs-bus-mhi
+++ b/Documentation/ABI/stable/sysfs-bus-mhi
@@ -29,3 +29,16 @@ Description:	Initiates a SoC reset on the MHI controller.  A SoC reset is
                 This can be useful as a method of recovery if the device is
                 non-responsive, or as a means of loading new firmware as a
                 system administration task.
+
+What:           /sys/bus/mhi/devices/.../trigger_edl
+Date:           April 2024
+KernelVersion:  6.9
+Contact:        mhi@lists.linux.dev
+Description:    Writing a non-zero value to this file will force devices to
+                enter EDL (Emergency Download) mode. This entry only exists for
+                devices capable of entering the EDL mode using the standard EDL
+                triggering mechanism defined in the MHI spec v1.2. Once in EDL
+                mode, the flash programmer image can be downloaded to the
+                device to enter the flash programmer execution environment.
+                This can be useful if user wants to use QDL (Qualcomm Download,
+                which is used to download firmware over EDL) to update firmware.
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index 44f9349..7104c18 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -127,6 +127,30 @@ static ssize_t soc_reset_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(soc_reset);
 
+static ssize_t trigger_edl_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	if (!val)
+		return -EINVAL;
+
+	ret = mhi_cntrl->edl_trigger(mhi_cntrl);
+	if (ret)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_WO(trigger_edl);
+
 static struct attribute *mhi_dev_attrs[] = {
 	&dev_attr_serial_number.attr,
 	&dev_attr_oem_pk_hash.attr,
@@ -1018,6 +1042,12 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	if (ret)
 		goto err_release_dev;
 
+	if (mhi_cntrl->edl_trigger) {
+		ret = sysfs_create_file(&mhi_dev->dev.kobj, &dev_attr_trigger_edl.attr);
+		if (ret)
+			goto err_release_dev;
+	}
+
 	mhi_cntrl->mhi_dev = mhi_dev;
 
 	mhi_create_debugfs(mhi_cntrl);
@@ -1051,6 +1081,9 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
 	mhi_deinit_free_irq(mhi_cntrl);
 	mhi_destroy_debugfs(mhi_cntrl);
 
+	if (mhi_cntrl->edl_trigger)
+		sysfs_remove_file(&mhi_dev->dev.kobj, &dev_attr_trigger_edl.attr);
+
 	destroy_workqueue(mhi_cntrl->hiprio_wq);
 	kfree(mhi_cntrl->mhi_cmd);
 	kfree(mhi_cntrl->mhi_event);
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index cde01e1..d968e1a 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -353,6 +353,7 @@ struct mhi_controller_config {
  * @read_reg: Read a MHI register via the physical link (required)
  * @write_reg: Write a MHI register via the physical link (required)
  * @reset: Controller specific reset function (optional)
+ * @edl_trigger: CB function to trigger EDL mode (optional)
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


