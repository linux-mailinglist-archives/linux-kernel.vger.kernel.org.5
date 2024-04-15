Return-Path: <linux-kernel+bounces-145451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8171D8A5651
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CBA1C21EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69B79952;
	Mon, 15 Apr 2024 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TYJvVt+7"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC1174E11;
	Mon, 15 Apr 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194764; cv=none; b=A+JEZ5pmZSnJR3YNgQod9Ef3tvN6/GGb51hiKrY+VehYqRkE45sH+zDK+3c7eY91O05cMrqe6vIx+izx7Enq/PgHa+Z1Hf6ASDEI2SSV+qGiF7rVNqPj0jdtT7Lypx1hQZmuaCvhCTfnIXJJ93NBo4o64ZzaPaeobv+6zee9aUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194764; c=relaxed/simple;
	bh=5c6guQ2FUVHHwyr6ZU/rcOyICNnEuFH5vN8FXZhfREY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2/CVUKbs1TzlKTp2EaSRa21Ioa/g4+/nFv56ynmGblgmm9lNxQorVqElFHLcxXAWzvu7i72ZgrjKJWLuiIf+zS23hEWt5yby0wMMJkzA6hfTIANY6bkIEqgktnwhcyDbX99LVlC1wR4kEoYSxutFAG2YpJRBgAtfmDHOfPKFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TYJvVt+7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FF8k23030098;
	Mon, 15 Apr 2024 15:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6XGvqxQKmD74K7o3lJi96exBfyvMPYZq144pIakSGTg=;
 b=TYJvVt+7rupkMpB7Uo+1JsgR4qKrBDOsmFAKasYZUX/yerZIFoii3Py2d10e5Q8nTJhM
 bZi78CdB8fgXjvpa7/G4oNRL4aiQZD6iRx/8cAORFNcwXjkmV0ULaZpd0BWRe0hNfip7
 UuRy4idaoey/QgsShZw5Crpsz9I9u70nXPdiDXrZu5C+jctVmhkei6V9U9c5lVoHlClm
 zUddeA46jHGPPNOI927u/nQnoX58ZXJ6vRTpuyvbUKeU+8lngku0eJLxVMMRQTnAws1h
 yU08CClDtMSgGwqvvvyWJy/GNW4i/2eMmBh54yR70zpCf1xiwRPPLf5XiXuDCrrfzQyi sQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xh6m8r167-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:26:01 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FChWhr023572;
	Mon, 15 Apr 2024 15:26:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5cnrk8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:26:00 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FFPvrC46727542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 15:25:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CE925805E;
	Mon, 15 Apr 2024 15:25:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B950858043;
	Mon, 15 Apr 2024 15:25:56 +0000 (GMT)
Received: from jason-laptop.ibmuc.com (unknown [9.61.81.98])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 15:25:56 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v5 2/5] s390/vfio-ap: Add sysfs attr, ap_config, to export mdev state
Date: Mon, 15 Apr 2024 11:25:52 -0400
Message-ID: <20240415152555.13152-3-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240415152555.13152-1-jjherne@linux.ibm.com>
References: <20240415152555.13152-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SGw0_5sNH0CuDD0-vEru1XVSqGmfpvIW
X-Proofpoint-ORIG-GUID: SGw0_5sNH0CuDD0-vEru1XVSqGmfpvIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_12,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150100

Add ap_config sysfs attribute. This will provide the means for
setting or displaying the adapters, domains and control domains assigned
to the vfio-ap mediated device in a single operation. This sysfs
attribute is comprised of three masks: One for adapters, one for domains,
and one for control domains.

This attribute is intended to be used by mdevctl to query a vfio-ap
mediated device's state.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index fc169bc61593..e01f53a3c5b7 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1570,6 +1570,32 @@ static ssize_t guest_matrix_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(guest_matrix);
 
+static ssize_t write_ap_bitmap(unsigned long *bitmap, char *buf, int offset, char sep)
+{
+	return sysfs_emit_at(buf, offset, "0x%016lx%016lx%016lx%016lx%c",
+			 bitmap[0], bitmap[1], bitmap[2], bitmap[3], sep);
+}
+
+static ssize_t ap_config_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
+	int idx = 0;
+
+	idx += write_ap_bitmap(matrix_mdev->matrix.apm, buf, idx, ',');
+	idx += write_ap_bitmap(matrix_mdev->matrix.aqm, buf, idx, ',');
+	idx += write_ap_bitmap(matrix_mdev->matrix.adm, buf, idx, '\n');
+
+	return idx;
+}
+
+static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	return count;
+}
+static DEVICE_ATTR_RW(ap_config);
+
 static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_assign_adapter.attr,
 	&dev_attr_unassign_adapter.attr,
@@ -1577,6 +1603,7 @@ static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_unassign_domain.attr,
 	&dev_attr_assign_control_domain.attr,
 	&dev_attr_unassign_control_domain.attr,
+	&dev_attr_ap_config.attr,
 	&dev_attr_control_domains.attr,
 	&dev_attr_matrix.attr,
 	&dev_attr_guest_matrix.attr,
-- 
2.41.0


