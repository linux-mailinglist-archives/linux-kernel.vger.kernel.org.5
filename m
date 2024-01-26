Return-Path: <linux-kernel+bounces-40195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BBB83DC13
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2EA1C20C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3B71C2AE;
	Fri, 26 Jan 2024 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IMAcA0KE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B81C291;
	Fri, 26 Jan 2024 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279771; cv=none; b=u+z13hEUttcblMJ1Hx8f4cr9L7mQ9xsFSq16fk/ZgLK5bYjfEiPbNtBwWtI3+pIJyVL7smO3R4Bc6SxjuJ8REmbhwQJ+JzK0xA3ELVLAJQ4KRU4xq5AQr+Fu6mkTGgN0K+SKfUBbfz70kI0MTJmtKm+oigEWPDEdTiEdybTTXKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279771; c=relaxed/simple;
	bh=JfmPStXRRuk+e/C6LsDVMx3sKK3BV8TqGCQNeAqR3rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjP3S5t8uz8QwADCzfspyJ/CdUGppbEou7kdK4zFhE9YowaANltO6oJoUZgW53yyCUWOxkBDgUkcQ7aOT8T6UYa0uz6N//vL68eAW47oqm2evi0LxDDFhQ5RonVS/O5MhtMqIel6QrY3AmMHWTSG7XQ+PtYrIo8g19MheoA6on4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IMAcA0KE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QDNiXp009094;
	Fri, 26 Jan 2024 14:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8KQwGGE1OoEUuwhYZNpCz1AaEgoGOn7O9IUjthmazM0=;
 b=IMAcA0KEPhXc7qTBqVTMmjDOC+hGaEKRRLbHQMCP98wqgeOjn2rewyM4Rb7oMO+ECtHM
 m9rUWarhdtlLLS6AVYlEtAxC95keHirSX0vDbY9pYQy+V6gux+4mA6kvXJio4DWX+n4p
 ES4pYQ/nbyK9IeY0BVZpslXRV34PTppab4gEOEQg7NWuDnsHCAB6Ydl5yDzV7KsGxyFC
 4ppSj6aVpoD2f22EfeahWx6WkfeRG8I22bT2GxR2ClBAhs6YdX7worCSJdAZme5log9D
 QHRUsdJPMz8VmbsSlCyifSL/qrk2tLbQI7mAK39aeP+/N3s+sbn0+gnijEoKxxx28YNm NQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vvbxumcua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 14:36:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40QDJKRt028225;
	Fri, 26 Jan 2024 14:35:37 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vru732ssc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 14:35:37 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40QEZZac32375476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:35:35 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FDAC58063;
	Fri, 26 Jan 2024 14:35:35 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0797F58062;
	Fri, 26 Jan 2024 14:35:35 +0000 (GMT)
Received: from li-4795344c-3451-11b2-a85c-ab40c30bcc43.ibm.com (unknown [9.61.37.129])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jan 2024 14:35:34 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com
Subject: [PATCH 3/3] s390/vfio-ap: Add write support to sysfs attr ap_config
Date: Fri, 26 Jan 2024 09:35:33 -0500
Message-ID: <20240126143533.14043-4-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126143533.14043-1-jjherne@linux.ibm.com>
References: <20240126143533.14043-1-jjherne@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hj_KC82IzEPCJTd51iI75CP7Zfb9NZRD
X-Proofpoint-ORIG-GUID: hj_KC82IzEPCJTd51iI75CP7Zfb9NZRD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260107

Allow writing a complete set of masks to ap_config. Doing so will
cause the vfio-ap driver to replace the vfio-ap mediated device's entire
state with the given set of masks. If the given state cannot be set, then
no changes are made to the vfio-ap mediated device.

The format of the data written to ap_config is as follows:
{amask},{dmask},{cmask}\n

\n is a newline character.

amask, dmask, and cmask are masks identifying which adapters, domains,
and control domains should be assigned to the mediated device.

The format of a mask is	as follows:
0xNN..NN

Where NN..NN is 64 hexadecimal characters representing a 256-bit value.
The leftmost (highest order) bit represents adapter/domain 0.

For an example set of masks that represent your mdev's current
configuration, simply cat ap_config.

This attribute is intended to be used by an mdevctl callout script
supporting the mdev type vfio_ap-passthrough to atomically update a
vfio-ap mediated device's state.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 Documentation/arch/s390/vfio-ap.rst   |  27 ++++
 drivers/s390/crypto/vfio_ap_ops.c     | 188 +++++++++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h |   6 +-
 3 files changed, 197 insertions(+), 24 deletions(-)

diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
index 929ee1c1c940..a94f13916dea 100644
--- a/Documentation/arch/s390/vfio-ap.rst
+++ b/Documentation/arch/s390/vfio-ap.rst
@@ -380,6 +380,33 @@ matrix device.
     control_domains:
       A read-only file for displaying the control domain numbers assigned to the
       vfio_ap mediated device.
+    ap_config:
+      A read/write file that, when written to, allows the entire vfio_ap mediated
+      device's ap configuration to be replaced in one shot. Three masks are given,
+      one for adapters, one for domains, and one for control domains. If the
+      given state cannot be set, then no changes are made to the vfio-ap
+      mediated device.
+
+      The format of the data written to ap_config is as follows:
+      {amask},{dmask},{cmask}\n
+
+      \n is a newline character.
+
+      amask, dmask, and cmask are masks identifying which adapters, domains,
+      and control domains should be assigned to the mediated device.
+
+      The format of a mask is as follows:
+      0xNN..NN
+
+      Where NN..NN is 64 hexadecimal characters representing a 256-bit value.
+      The leftmost (highest order) bit represents adapter/domain 0.
+
+      For an example set of masks that represent your mdev's current
+      configuration, simply cat ap_config.
+
+      This attribute is intended to be used by automation. End users would be
+      better served using the respective assign/unassign attributes for adapters
+      and domains.
 
 * functions:
 
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 96293683b939..5ad134c1d5e6 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -764,10 +764,11 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 static void vfio_ap_mdev_link_queue(struct ap_matrix_mdev *matrix_mdev,
 				    struct vfio_ap_queue *q)
 {
-	if (q) {
-		q->matrix_mdev = matrix_mdev;
-		hash_add(matrix_mdev->qtable.queues, &q->mdev_qnode, q->apqn);
-	}
+	if (!q || vfio_ap_mdev_get_queue(matrix_mdev, q->apqn))
+		return;
+
+	q->matrix_mdev = matrix_mdev;
+	hash_add(matrix_mdev->qtable.queues, &q->mdev_qnode, q->apqn);
 }
 
 static void vfio_ap_mdev_link_apqn(struct ap_matrix_mdev *matrix_mdev, int apqn)
@@ -1048,21 +1049,25 @@ static void vfio_ap_mdev_unlink_adapter(struct ap_matrix_mdev *matrix_mdev,
 	}
 }
 
-static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
-					    unsigned long apid)
+static void vfio_ap_mdev_hot_unplug_adapters(struct ap_matrix_mdev *matrix_mdev,
+					    unsigned long *apids)
 {
-	int loop_cursor;
-	struct vfio_ap_queue *q;
 	struct ap_queue_table *qtable = kzalloc(sizeof(*qtable), GFP_KERNEL);
+	struct vfio_ap_queue *q;
+	unsigned long apid;
+	int loop_cursor;
 
 	hash_init(qtable->queues);
-	vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, qtable);
 
-	if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm)) {
-		clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
-		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+	for_each_set_bit_inv(apid, apids, AP_DEVICES) {
+		vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, qtable);
+
+		if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm))
+			clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
 	}
 
+	vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+
 	vfio_ap_mdev_reset_queues(qtable);
 
 	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
@@ -1073,6 +1078,15 @@ static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
 	kfree(qtable);
 }
 
+static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
+					    unsigned long apid)
+{
+	DECLARE_BITMAP(apids, AP_DEVICES);
+
+	set_bit_inv(apid, apids);
+	vfio_ap_mdev_hot_unplug_adapters(matrix_mdev, apids);
+}
+
 /**
  * unassign_adapter_store - parses the APID from @buf and clears the
  * corresponding bit in the mediated matrix device's APM
@@ -1235,21 +1249,24 @@ static void vfio_ap_mdev_unlink_domain(struct ap_matrix_mdev *matrix_mdev,
 	}
 }
 
-static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
-					   unsigned long apqi)
+static void vfio_ap_mdev_hot_unplug_domains(struct ap_matrix_mdev *matrix_mdev,
+					   unsigned long *apqis)
 {
-	int loop_cursor;
-	struct vfio_ap_queue *q;
 	struct ap_queue_table *qtable = kzalloc(sizeof(*qtable), GFP_KERNEL);
+	struct vfio_ap_queue *q;
+	unsigned long apqi;
+	int loop_cursor;
 
 	hash_init(qtable->queues);
-	vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, qtable);
 
-	if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
-		clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
-		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+	for_each_set_bit_inv(apqi, apqis, AP_DOMAINS) {
+		vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, qtable);
+
+		if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
+			clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
 	}
 
+	vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 	vfio_ap_mdev_reset_queues(qtable);
 
 	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
@@ -1260,6 +1277,15 @@ static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
 	kfree(qtable);
 }
 
+static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
+					   unsigned long apqi)
+{
+	DECLARE_BITMAP(apqis, AP_DOMAINS);
+
+	set_bit_inv(apqi, apqis);
+	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, apqis);
+}
+
 /**
  * unassign_domain_store - parses the APQI from @buf and clears the
  * corresponding bit in the mediated matrix device's AQM
@@ -1527,10 +1553,130 @@ static ssize_t ap_config_show(struct device *dev, struct device_attribute *attr,
 	return idx;
 }
 
+/* Number of characters needed for a complete hex mask representing the bits in ..  */
+#define AP_DEVICES_STRLEN	(AP_DEVICES/4 + 3)
+#define AP_DOMAINS_STRLEN	(AP_DOMAINS/4 + 3)
+#define AP_CONFIG_STRLEN	(AP_DEVICES_STRLEN + 2 * AP_DOMAINS_STRLEN)
+
+static int parse_bitmap(char **strbufptr, unsigned long *bitmap, int nbits)
+{
+	char *curmask;
+
+	curmask = strsep(strbufptr, ",\n");
+	if (!curmask)
+		return -EINVAL;
+
+	bitmap_clear(bitmap, 0, nbits);
+	return ap_hex2bitmap(curmask, bitmap, nbits);
+}
+
+static int ap_matrix_length_check(struct ap_matrix_mdev *matrix_mdev)
+{
+	unsigned long bit;
+
+	for_each_set_bit_inv(bit, matrix_mdev->matrix.apm, AP_DEVICES) {
+		if (bit > matrix_mdev->matrix.apm_max)
+			return -ENODEV;
+	}
+
+	for_each_set_bit_inv(bit, matrix_mdev->matrix.aqm, AP_DOMAINS) {
+		if (bit > matrix_mdev->matrix.aqm_max)
+			return -ENODEV;
+	}
+
+	for_each_set_bit_inv(bit, matrix_mdev->matrix.adm, AP_DOMAINS) {
+		if (bit > matrix_mdev->matrix.adm_max)
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void ap_matrix_copy(struct ap_matrix *dst, struct ap_matrix *src)
+{
+	bitmap_copy(dst->apm, src->apm, AP_DEVICES);
+	bitmap_copy(dst->aqm, src->aqm, AP_DOMAINS);
+	bitmap_copy(dst->adm, src->adm, AP_DOMAINS);
+}
+
 static ssize_t ap_config_store(struct device *dev, struct device_attribute *attr,
 			       const char *buf, size_t count)
 {
-	return count;
+	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
+	struct ap_matrix m_new, m_old, m_added, m_removed;
+	unsigned long newbit;
+	char *newbuf, *rest;
+	int rc = count;
+	bool do_update;
+
+	newbuf = rest = kstrndup(buf, AP_CONFIG_STRLEN, GFP_KERNEL);
+	if (!newbuf)
+		return -ENOMEM;
+
+	mutex_lock(&ap_perms_mutex);
+	get_update_locks_for_mdev(matrix_mdev);
+
+	/* Save old state */
+	ap_matrix_copy(&m_old, &matrix_mdev->matrix);
+
+	if (parse_bitmap(&rest, m_new.apm, AP_DEVICES) ||
+	    parse_bitmap(&rest, m_new.aqm, AP_DOMAINS) ||
+		parse_bitmap(&rest, m_new.adm, AP_DOMAINS)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	bitmap_andnot(m_removed.apm, m_old.apm, m_new.apm, AP_DEVICES);
+	bitmap_andnot(m_removed.aqm, m_old.aqm, m_new.aqm, AP_DOMAINS);
+	bitmap_andnot(m_added.apm, m_new.apm, m_old.apm, AP_DEVICES);
+	bitmap_andnot(m_added.aqm, m_new.aqm, m_old.aqm, AP_DOMAINS);
+
+	/* Need new bitmaps in matrix_mdev for validation */
+	ap_matrix_copy(&matrix_mdev->matrix, &m_new);
+
+	/* Ensure new state is valid, else undo new state */
+	rc = vfio_ap_mdev_validate_masks(matrix_mdev);
+	if (rc) {
+		ap_matrix_copy(&matrix_mdev->matrix, &m_old);
+		goto out;
+	}
+	rc = ap_matrix_length_check(matrix_mdev);
+	if (rc) {
+		ap_matrix_copy(&matrix_mdev->matrix, &m_old);
+		goto out;
+	}
+	rc = count;
+
+	/* Need old bitmaps in matrix_mdev for unplug/unlink */
+	ap_matrix_copy(&matrix_mdev->matrix, &m_old);
+
+	/* Unlink removed adapters/domains */
+	vfio_ap_mdev_hot_unplug_adapters(matrix_mdev, m_removed.apm);
+	vfio_ap_mdev_hot_unplug_domains(matrix_mdev, m_removed.aqm);
+
+	/* Need new bitmaps in matrix_mdev for linking new adapters/domains */
+	ap_matrix_copy(&matrix_mdev->matrix, &m_new);
+
+	/* Link newly added adapters */
+	for_each_set_bit_inv(newbit, m_added.apm, AP_DEVICES)
+		vfio_ap_mdev_link_adapter(matrix_mdev, newbit);
+
+	for_each_set_bit_inv(newbit, m_added.aqm, AP_DOMAINS)
+		vfio_ap_mdev_link_domain(matrix_mdev, newbit);
+
+	/* filter resources not bound to vfio-ap */
+	do_update = vfio_ap_mdev_filter_matrix(matrix_mdev->matrix.apm,
+				matrix_mdev->matrix.aqm, matrix_mdev);
+	do_update |= vfio_ap_mdev_filter_cdoms(matrix_mdev);
+
+	/* Apply changes to shadow apbc if things changed */
+	if (do_update)
+		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+out:
+	release_update_locks_for_mdev(matrix_mdev);
+	mutex_unlock(&ap_perms_mutex);
+	kfree(newbuf);
+	return rc;
 }
 static DEVICE_ATTR_RW(ap_config);
 
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 88aff8b81f2f..e2cf07c184bf 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -75,11 +75,11 @@ extern struct ap_matrix_dev *matrix_dev;
  */
 struct ap_matrix {
 	unsigned long apm_max;
-	DECLARE_BITMAP(apm, 256);
+	DECLARE_BITMAP(apm, AP_DEVICES);
 	unsigned long aqm_max;
-	DECLARE_BITMAP(aqm, 256);
+	DECLARE_BITMAP(aqm, AP_DOMAINS);
 	unsigned long adm_max;
-	DECLARE_BITMAP(adm, 256);
+	DECLARE_BITMAP(adm, AP_DOMAINS);
 };
 
 /**
-- 
2.41.0


