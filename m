Return-Path: <linux-kernel+bounces-102510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE2A87B317
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4961F262BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819A3535B7;
	Wed, 13 Mar 2024 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AQcixv3+"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8946556;
	Wed, 13 Mar 2024 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363497; cv=none; b=NkEZZgQ2VL4fKEaxLoIzXFLm5SV/W0YtGCkbMyP9M86oiIsjhDpO/BAqwqoq0ZkDsb4bmU6fOnk+FogEBZieY0IWg8LSeBlW0C6mz7kEhwcQn3Sg1ghR7oXfi+XcHG5jOv6LFwFsHXk2h2YNPacGCuRhkPC021CB4QQlA+wZ/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363497; c=relaxed/simple;
	bh=5c6guQ2FUVHHwyr6ZU/rcOyICNnEuFH5vN8FXZhfREY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOD9LWHV4Mvvuzcw33yunWGgIJMVuWDBNCIr7UOlPY6Y0gC3hrsLylQExzf4yy8127EqYTKldsjJIxGHPTxtCik/qmO3lDZ5kGpfSKu7UCzwrBQ0o57DIoNi9YpM3nBMODefjvUJqPKLmlxI3w3Fj3MViaKZJrp4HlXU1V1yG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AQcixv3+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DI20Yw032232;
	Wed, 13 Mar 2024 20:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6XGvqxQKmD74K7o3lJi96exBfyvMPYZq144pIakSGTg=;
 b=AQcixv3+txJZQDS65VyOll1w+c2Sr7M2w5G1cAZA48fF78Uu/wNWH8UQCKDLCGAy6vmF
 ADuqkk6Mk9ojF6tKs/9fNXUPGFHGwsRz6quI5xcBBLQISjT07R0pPTbvlrIJNWaI6ljW
 8MN5FMDsPnOQ/W6OjuXLjVC0N7nLafxrduP/9TzmBuVW0fWzDr2NM6PalQ+D1rtTF+QA
 hb5x8bJyNpLK1MBK13H0mBWbTo3+0uyO12lSG3hZA9JAuyB0TgTLFs28c1sMoc8t8c7U
 KwMF8lQHCXyTbMVXoqLBshaskLXDpqMzmmZRYx18jCQuDwPVUUX5A+0UQAQylSbqqntu qg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wuh2ft0de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:58:14 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42DKhk8A015539;
	Wed, 13 Mar 2024 20:58:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws2g00pjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:58:13 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42DKwAKq42729908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 20:58:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4271058068;
	Wed, 13 Mar 2024 20:58:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACB2158060;
	Wed, 13 Mar 2024 20:58:09 +0000 (GMT)
Received: from jason-laptop.ibmuc.com (unknown [9.61.59.128])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Mar 2024 20:58:09 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: [PATCH v3 2/5] s390/vfio-ap: Add sysfs attr, ap_config, to export mdev state
Date: Wed, 13 Mar 2024 16:58:04 -0400
Message-ID: <20240313205807.30554-3-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313205807.30554-1-jjherne@linux.ibm.com>
References: <20240313205807.30554-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Puf4sr_q5p2FzudwFj4d_Pb1UnRPcyqN
X-Proofpoint-GUID: Puf4sr_q5p2FzudwFj4d_Pb1UnRPcyqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130160

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


