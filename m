Return-Path: <linux-kernel+bounces-156206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8248AFF78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1552D282E01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DB113BC3D;
	Wed, 24 Apr 2024 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F1ivTvpa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC903126F09;
	Wed, 24 Apr 2024 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713928927; cv=none; b=qclmrafR39O4VLgc/VhS/7IMnx+m4sMJXwMWMoMOGOhGqJxub/D62I/U3FrSmQ2SoxCFFqHxeeC3ddI9QsXhrq3Qb7OgFj1cecCIZwAOgI+9cukWAXzKN5gz11YTJ1T9PFiIN8Pm3TFBf2SohUBl5oYIuYd1MbqKDIK298K3iFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713928927; c=relaxed/simple;
	bh=EIIFnEMwdEY278Kga4iQhSJmia1fUeOcI5skRvJENiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LH1BgAqV8jYqjwJCWwKg8np/8BuEMkPLoPyLOZeV0DIzsrI4BbSYq8PAhufPQrX69uczsLt3BD6B/H8WKySH2kfuFGZOyAt41fD7o95UE830OmzAkwODA2+H3dboMH0ep9EHljSZvFP4vQrYq9QiSSSJxmAILX1WfFzFe6kx3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F1ivTvpa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O1VwmS020416;
	Wed, 24 Apr 2024 03:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=/7w+cOFKmMrq3pi2bmOTlYixSnwR2gJ2T5j4xQdbHyc=; b=F1
	ivTvpaxFwBFSqBlpzPlsDz1ymwV8WixgLuOLGG98KJ96zJH+vxTYHPaPqWoAoKbw
	ufunpJQVrnt0dfGD0JHSLwlKig9autXE79OcNnqvrC/jyibjROI2nvFhEoHAl0PJ
	5P93IQ854QW1A1H4GGxlElueVVHQEutjm9GzYJjpnaHXNvb342xKETyuIBa4O0Gh
	B+62F0zf7J5BVmFg/bKy1UKYdk4S+jEGp2KRt/odljN7w16wRND/qggS3XmTf00i
	OTJBZ0aJ+/iLjrKSLQWBujPmLBbo842YfZbzg8hSP1ONWpcnEkQp2tglJu6zUd4O
	xgpNehCSOMJalt5NoDjQ==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpcxejaq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 03:22:02 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43O3M0SI017006;
	Wed, 24 Apr 2024 03:22:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3xm6skgths-1;
	Wed, 24 Apr 2024 03:22:00 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43O3M07S017001;
	Wed, 24 Apr 2024 03:22:00 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 43O3M0H1017000;
	Wed, 24 Apr 2024 03:22:00 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id 006155B1D; Wed, 24 Apr 2024 11:21:59 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v5 1/3] bus: mhi: host: Add sysfs entry to force device to enter EDL
Date: Wed, 24 Apr 2024 11:21:53 +0800
Message-Id: <1713928915-18229-2-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713928915-18229-1-git-send-email-quic_qianyu@quicinc.com>
References: <1713928915-18229-1-git-send-email-quic_qianyu@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zRg59llwODUfOPD-T1EHF0nkhFEjJz3T
X-Proofpoint-ORIG-GUID: zRg59llwODUfOPD-T1EHF0nkhFEjJz3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240014
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
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
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


