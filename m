Return-Path: <linux-kernel+bounces-119500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21488C9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4781F82358
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E44A1CAA6;
	Tue, 26 Mar 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ETqKf2xv"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7DE18EB0;
	Tue, 26 Mar 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471636; cv=none; b=SvWFB/93F8xdY3ETkmTTxgNHzYpkMu7Tf2+A7XFf3kwIPbzD4PQq3CbeLY0ilwpDNIslPkh0OyMks5SDXenj2yt/oR5mgc0sMv8Aeiy4LkLIUx+nfv1L+q4choxcPWhAZ4K9tMbZ9FZ7OK4Ed3QzeXS0/E/4OQ/zj1REZ/lCa3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471636; c=relaxed/simple;
	bh=5c6guQ2FUVHHwyr6ZU/rcOyICNnEuFH5vN8FXZhfREY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmoAW8UsymcwLBAVb73G7CHVdwxu5w+wrog9iZARGTBOgNPxF85cISCrnwD2lDmR4qy36RAC5s6Q/9B1LvgsXL30jPwM9m1gBQA31Cp/mellaB4Qh/rYlDYPObeZmFpxnP7XsPgYs/Tzk/GmVOPIGVxnifTmz4ra9/PM4RCb6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ETqKf2xv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QGabIx018359;
	Tue, 26 Mar 2024 16:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6XGvqxQKmD74K7o3lJi96exBfyvMPYZq144pIakSGTg=;
 b=ETqKf2xvEX4+qiNVnuG7mdjBTE4R5y0v4X3KYkIaCDDMbdfbpeiBCzjGOFa9N18Su1DD
 seXoJxFWGCCBLdrHrSjQttPrqkEn7gtgO1LwLXDFEoxPGTq9aGi1mB3fc+9HLv33eQzb
 t7cGptSUmEXnDWdBMCdn1Hh7mAWOQpvyv+wyQt8KNDMSO8UF4K+ZYYBs7k3aojEtv+qy
 CE3Z5y0GiGOqUOPMiIV0fPvfltoCin5mZw/rYtnPW8TLYQPUCB5Ce8FDswKIsuugZTp5
 6CZHqbZVMG5+1QL4EvUfp2ba/k50KSls32l3mG2mSN8NZDhrstunGjkjhu0Nn2CD/QSC lw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3xm7rme1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 16:47:12 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42QGFJap028620;
	Tue, 26 Mar 2024 16:47:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adp8waq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 16:47:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42QGl82x40960680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 16:47:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBFE758058;
	Tue, 26 Mar 2024 16:47:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DC8F58057;
	Tue, 26 Mar 2024 16:47:08 +0000 (GMT)
Received: from jason-laptop.home.arpa (unknown [9.61.173.44])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Mar 2024 16:47:08 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v4 2/5] s390/vfio-ap: Add sysfs attr, ap_config, to export mdev state
Date: Tue, 26 Mar 2024 12:47:03 -0400
Message-ID: <20240326164706.29167-3-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326164706.29167-1-jjherne@linux.ibm.com>
References: <20240326164706.29167-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HXRdIt08Ku6OaWyVPEPsQzp7ZFxoRobN
X-Proofpoint-GUID: HXRdIt08Ku6OaWyVPEPsQzp7ZFxoRobN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2403260119

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


