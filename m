Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D925480F92D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377616AbjLLVZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377601AbjLLVZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:25:24 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE4CB3;
        Tue, 12 Dec 2023 13:25:30 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCKhZGQ020658;
        Tue, 12 Dec 2023 21:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=W/rDZcFYvEKxv7IsdcV7co3Hn2U+Y2v7rDJ2EcuzIiM=;
 b=lMsnfB5nnPiVooPPa14eKcCGc9n6A58AdXYjIiSlFz7zJbC+4Rm9VwdrA7QvcaAWHE2e
 Jn5hZJt5IFOP7NfiEpbA0L8rfjG8iBa5X9XHDM1h1KW9Ps05LqtGoc24De1KvSPE/rfD
 VV2eo4K+5OSccc7Wr5Z/mnHbn4PZIi8Q+FzjNsLLMyZNnEw3oR4HL6rCkJ8TCATu/Yau
 eNIS6Uqk3xCCGeztmw4God63KtRJWb6SgNXd87oOdw+EgJjj8GRChPPo9R9hXIpE0+S9
 5+uUOHN6iwYk/Sy+lS3NhJ1c5KDLwgh30B0/uj2nxan7969OcegeHJv11Y1VnL6FO4AN Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxxsxrw74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 21:25:28 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCLCpAi006430;
        Tue, 12 Dec 2023 21:25:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxxsxrw6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 21:25:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCLGS9w028229;
        Tue, 12 Dec 2023 21:25:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2xym8db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 21:25:27 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BCLPP1L15532770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 21:25:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F07F58052;
        Tue, 12 Dec 2023 21:25:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACAFA58056;
        Tue, 12 Dec 2023 21:25:24 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.61.187.43])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Dec 2023 21:25:24 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        stable@vger.kernel.org
Subject: [PATCH v2 1/6] s390/vfio-ap: always filter entire AP matrix
Date:   Tue, 12 Dec 2023 16:25:12 -0500
Message-ID: <20231212212522.307893-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212212522.307893-1-akrowiak@linux.ibm.com>
References: <20231212212522.307893-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HiSPbOm8GyCqj1LbJaIOpMQJNsqhpKN6
X-Proofpoint-GUID: 0jFDMgRjzEkbNPxfU8mCc2Myfzd-kemq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120165
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vfio_ap_mdev_filter_matrix function is called whenever a new adapter or
domain is assigned to the mdev. The purpose of the function is to update
the guest's AP configuration by filtering the matrix of adapters and
domains assigned to the mdev. When an adapter or domain is assigned, only
the APQNs associated with the APID of the new adapter or APQI of the new
domain are inspected. If an APQN does not reference a queue device bound to
the vfio_ap device driver, then it's APID will be filtered from the mdev's
matrix when updating the guest's AP configuration.

Inspecting only the APID of the new adapter or APQI of the new domain will
result in passing AP queues through to a guest that are not bound to the
vfio_ap device driver under certain circumstances. Consider the following:

guest's AP configuration (all also assigned to the mdev's matrix):
14.0004
14.0005
14.0006
16.0004
16.0005
16.0006

unassign domain 4
unbind queue 16.0005
assign domain 4

When domain 4 is re-assigned, since only domain 4 will be inspected, the
APQNs that will be examined will be:
14.0004
16.0004

Since both of those APQNs reference queue devices that are bound to the
vfio_ap device driver, nothing will get filtered from the mdev's matrix
when updating the guest's AP configuration. Consequently, queue 16.0005
will get passed through despite not being bound to the driver. This
violates the linux device model requirement that a guest shall only be
given access to devices bound to the device driver facilitating their
pass-through.

To resolve this problem, every adapter and domain assigned to the mdev will
be inspected when filtering the mdev's matrix.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: 48cae940c31d ("s390/vfio-ap: refresh guest's APCB by filtering AP resources assigned to mdev")
Cc: <stable@vger.kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 57 +++++++++----------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4db538a55192..9382b32e5bd1 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -670,8 +670,7 @@ static bool vfio_ap_mdev_filter_cdoms(struct ap_matrix_mdev *matrix_mdev)
  * Return: a boolean value indicating whether the KVM guest's APCB was changed
  *	   by the filtering or not.
  */
-static bool vfio_ap_mdev_filter_matrix(unsigned long *apm, unsigned long *aqm,
-				       struct ap_matrix_mdev *matrix_mdev)
+static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
 {
 	unsigned long apid, apqi, apqn;
 	DECLARE_BITMAP(prev_shadow_apm, AP_DEVICES);
@@ -692,8 +691,8 @@ static bool vfio_ap_mdev_filter_matrix(unsigned long *apm, unsigned long *aqm,
 	bitmap_and(matrix_mdev->shadow_apcb.aqm, matrix_mdev->matrix.aqm,
 		   (unsigned long *)matrix_dev->info.aqm, AP_DOMAINS);
 
-	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
-		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
 			/*
 			 * If the APQN is not bound to the vfio_ap device
 			 * driver, then we can't assign it to the guest's
@@ -958,7 +957,6 @@ static ssize_t assign_adapter_store(struct device *dev,
 {
 	int ret;
 	unsigned long apid;
-	DECLARE_BITMAP(apm_delta, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -987,11 +985,8 @@ static ssize_t assign_adapter_store(struct device *dev,
 	}
 
 	vfio_ap_mdev_link_adapter(matrix_mdev, apid);
-	memset(apm_delta, 0, sizeof(apm_delta));
-	set_bit_inv(apid, apm_delta);
 
-	if (vfio_ap_mdev_filter_matrix(apm_delta,
-				       matrix_mdev->matrix.aqm, matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
 	ret = count;
@@ -1167,7 +1162,6 @@ static ssize_t assign_domain_store(struct device *dev,
 {
 	int ret;
 	unsigned long apqi;
-	DECLARE_BITMAP(aqm_delta, AP_DOMAINS);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -1196,11 +1190,8 @@ static ssize_t assign_domain_store(struct device *dev,
 	}
 
 	vfio_ap_mdev_link_domain(matrix_mdev, apqi);
-	memset(aqm_delta, 0, sizeof(aqm_delta));
-	set_bit_inv(apqi, aqm_delta);
 
-	if (vfio_ap_mdev_filter_matrix(matrix_mdev->matrix.apm, aqm_delta,
-				       matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
 	ret = count;
@@ -2091,9 +2082,7 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	if (matrix_mdev) {
 		vfio_ap_mdev_link_queue(matrix_mdev, q);
 
-		if (vfio_ap_mdev_filter_matrix(matrix_mdev->matrix.apm,
-					       matrix_mdev->matrix.aqm,
-					       matrix_mdev))
+		if (vfio_ap_mdev_filter_matrix(matrix_mdev))
 			vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 	}
 	dev_set_drvdata(&apdev->device, q);
@@ -2443,34 +2432,22 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *cur_cfg_info,
 
 static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 {
-	bool do_hotplug = false;
-	int filter_domains = 0;
-	int filter_adapters = 0;
-	DECLARE_BITMAP(apm, AP_DEVICES);
-	DECLARE_BITMAP(aqm, AP_DOMAINS);
+	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
 	mutex_lock(&matrix_mdev->kvm->lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
 
-	filter_adapters = bitmap_and(apm, matrix_mdev->matrix.apm,
-				     matrix_mdev->apm_add, AP_DEVICES);
-	filter_domains = bitmap_and(aqm, matrix_mdev->matrix.aqm,
-				    matrix_mdev->aqm_add, AP_DOMAINS);
-
-	if (filter_adapters && filter_domains)
-		do_hotplug |= vfio_ap_mdev_filter_matrix(apm, aqm, matrix_mdev);
-	else if (filter_adapters)
-		do_hotplug |=
-			vfio_ap_mdev_filter_matrix(apm,
-						   matrix_mdev->shadow_apcb.aqm,
-						   matrix_mdev);
-	else
-		do_hotplug |=
-			vfio_ap_mdev_filter_matrix(matrix_mdev->shadow_apcb.apm,
-						   aqm, matrix_mdev);
+	filter_adapters = bitmap_intersects(matrix_mdev->matrix.apm,
+					    matrix_mdev->apm_add, AP_DEVICES);
+	filter_domains = bitmap_intersects(matrix_mdev->matrix.aqm,
+					   matrix_mdev->aqm_add, AP_DOMAINS);
+	filter_cdoms = bitmap_intersects(matrix_mdev->matrix.adm,
+					 matrix_mdev->adm_add, AP_DOMAINS);
+
+	if (filter_adapters || filter_domains)
+		do_hotplug = vfio_ap_mdev_filter_matrix(matrix_mdev);
 
-	if (bitmap_intersects(matrix_mdev->matrix.adm, matrix_mdev->adm_add,
-			      AP_DOMAINS))
+	if (filter_cdoms)
 		do_hotplug |= vfio_ap_mdev_filter_cdoms(matrix_mdev);
 
 	if (do_hotplug)
-- 
2.43.0

