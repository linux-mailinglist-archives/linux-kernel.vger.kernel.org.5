Return-Path: <linux-kernel+bounces-94021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFB9873888
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508701C20B83
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A1D13473F;
	Wed,  6 Mar 2024 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fNfvkpxv"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD36133425;
	Wed,  6 Mar 2024 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734132; cv=none; b=SaMqu4WmrTL7tq+7RVh/+xDUqYxhCmlHviVJPzQSnRc4/+SouCtOmpwH8wYPxVxlS7qLOiHApCSnokGfxnXDHDCHfl1GR7iGYUfZZiCJbrM/R+hZj0irjvVbZWdtabY95WOqvJgjv4ba04vG6nsitOOH5SnuHvuzyieSELx6pik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734132; c=relaxed/simple;
	bh=lt6br/zcsf0BxVFb9DI9HA9gGx29f9KmnuXhNw86vjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TyXV8LREWxLEzB2hzQKT7CiGhD3R/CvF+lDA2Q2vUmrwERCoT3YAX5r53kmIzsz+G+JdYG3PLkVCn/iW7L8OzM/DdcOSvRwD0mf/d5sOxy3c0dU2vHuprrkIjqcNNF40MO4S7DM3iA1I5sSn2qQRjt7CgXPwlOABPCp+QCmVtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fNfvkpxv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426E3RCj020066;
	Wed, 6 Mar 2024 14:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wueyJZ4PPou/jHHQ7D/OZdheN15Z6RQh96Oj72IlGak=;
 b=fNfvkpxvWe9XX+zNHA23VUNqE1poJ9K+HM+TLl4WSGSbazeaXr4VqpuVFMc8o2bhqU70
 3y7ywdytIPR2qda5VNh6dF1jzU3hkcZSxvWCA2b0LhtvpkQwt/JVvw1CUuWrJ/9j+rP7
 Uckj4nZJNWO9Bl1j0d2Jb/KevCxcZTFy3rArqFDDMkG3oJyAC2qbWcty3rmW56phJeVB
 P4x2w+vdP9YYvA+DmN34CwxQoyPD8hEjt0wK5F7op02Idh322GadbYY5GElG/+z+WkL6
 IHuHZTrnuVPJlnaSS4kVA3ZusAtpv/Q4jredQZCG9BULej/GJJZvpQrVzjpdpVxcV4vV pQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wpswn8f1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:08:49 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 426BxKZo024193;
	Wed, 6 Mar 2024 14:08:49 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsab60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 14:08:49 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 426E8j7033620470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Mar 2024 14:08:48 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B07E758070;
	Wed,  6 Mar 2024 14:08:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3097F58071;
	Wed,  6 Mar 2024 14:08:45 +0000 (GMT)
Received: from jason-laptop.home.arpa (unknown [9.61.164.86])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Mar 2024 14:08:45 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: [PATCH v2 2/5] s390/vfio-ap: Add sysfs attr, queue_configuration, to export mdev state
Date: Wed,  6 Mar 2024 09:08:40 -0500
Message-ID: <20240306140843.10782-3-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240306140843.10782-1-jjherne@linux.ibm.com>
References: <20240306140843.10782-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zkVvyfoaZU-Osqo6iQDpCOkKyX8yt1GR
X-Proofpoint-ORIG-GUID: zkVvyfoaZU-Osqo6iQDpCOkKyX8yt1GR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403060113

Add ap_config sysfs attribute. This will provide the means for
setting or displaying the adapters, domains and control domains assigned
to the vfio-ap mediated device in a single operation. This sysfs
attribute is comprised of three masks: One for adapters, one for domains,
and one for control domains.

This attribute is intended to be used by mdevctl to query a vfio-ap
mediated device's state.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 983b3b16196c..b1c1dc0233e1 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1557,6 +1557,32 @@ static ssize_t guest_matrix_show(struct device *dev,
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
@@ -1564,6 +1590,7 @@ static struct attribute *vfio_ap_mdev_attrs[] = {
 	&dev_attr_unassign_domain.attr,
 	&dev_attr_assign_control_domain.attr,
 	&dev_attr_unassign_control_domain.attr,
+	&dev_attr_ap_config.attr,
 	&dev_attr_control_domains.attr,
 	&dev_attr_matrix.attr,
 	&dev_attr_guest_matrix.attr,
-- 
2.41.0


