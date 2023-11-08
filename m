Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7827E5F05
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjKHUNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHUNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:13:49 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FE6D7;
        Wed,  8 Nov 2023 12:13:47 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8K1tG3031733;
        Wed, 8 Nov 2023 20:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=aZOnCNe/MOGyD1ea9B1x0UiaTyqSVLrTMWnFnwhgRBY=;
 b=s/q/FNKne8ZAR8qRwjF2gAaVVa8uZGbznq6l9/7rTD6pwXbFHXw4K4b5toXXL6pvPrlO
 t9npu0+iTZpBfgUI3e7P50rKywz8192LQr6p8bnvD+WiyQNHLxQm/yRM7eqVa2EMmCKp
 g+NnPDGxsvqMcVE9deKGkgFZXQyyDaHuXRba/UWzTAFxtIuWQkbBkVk2mtSnyFcq1FnP
 Ub1jNU/1AwGH/GWcwRxy+lFOrlg1JlUi3LvZ7SiNj5CYy7cTKYmff2zwrT0Dc/NVTDbB
 /JiP3V5mo8k6NdP0KOnoT/Mqx/nMIBIQe8VOTdnnMN0MjYbvpoJTGalR3RnzuPevtsgc Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8h0n0868-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 20:13:45 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A8K2kZN001544;
        Wed, 8 Nov 2023 20:13:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8h0n07yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 20:13:32 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8J85RT028363;
        Wed, 8 Nov 2023 20:11:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22f90y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 20:11:37 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A8KBa7921627582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Nov 2023 20:11:37 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB14558056;
        Wed,  8 Nov 2023 20:11:36 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BAA05803F;
        Wed,  8 Nov 2023 20:11:36 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.61.74.193])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Nov 2023 20:11:35 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, pasic@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com,
        Harald Freudenberger <freude@linux.ibm.com>
Subject: [PATCH v2] s390/vfio-ap: fix sysfs status attribute for AP queue devices
Date:   Wed,  8 Nov 2023 15:11:30 -0500
Message-ID: <20231108201135.351419-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zBsYuOn8gNwAkXyetzopGQaEtx5Z8XVr
X-Proofpoint-GUID: Kn2tOCvN-1ImytAvbTpdIpLJljF_Qrcp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_09,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'status' attribute for AP queue devices bound to the vfio_ap device
driver displays incorrect status when the mediated device is attached to a
guest, but the queue device is not passed through. In the current
implementation, the status displayed is 'in_use' which is not correct; it
should be 'assigned'. This can happen if one of the queue devices
associated with a given adapter is not bound to the vfio_ap device driver.
For example:

Queues listed in /sys/bus/ap/drivers/vfio_ap:
14.0005
14.0006
14.000d
16.0006
16.000d

Queues listed in /sys/devices/vfio_ap/matrix/$UUID/matrix
14.0005
14.0006
14.000d
16.0005
16.0006
16.000d

Queues listed in /sys/devices/vfio_ap/matrix/$UUID/guest_matrix
14.0005
14.0006
14.000d

The reason no queues for adapter 0x16 are listed in the guest_matrix is
because queue 16.0005 is not bound to the vfio_ap device driver, so no
queue associated with the adapter is passed through to the guest;
therefore, each queue device for adapter 0x16 should display 'assigned'
instead of 'in_use', because those queues are not in use by a guest, but
only assigned to the mediated device.

Let's check the AP configuration for the guest to determine whether a
queue device is passed through before displaying a status of 'in_use'.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4db538a55192..6e0a79086656 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1976,6 +1976,7 @@ static ssize_t status_show(struct device *dev,
 {
 	ssize_t nchars = 0;
 	struct vfio_ap_queue *q;
+	unsigned long apid, apqi;
 	struct ap_matrix_mdev *matrix_mdev;
 	struct ap_device *apdev = to_ap_dev(dev);
 
@@ -1983,8 +1984,21 @@ static ssize_t status_show(struct device *dev,
 	q = dev_get_drvdata(&apdev->device);
 	matrix_mdev = vfio_ap_mdev_for_queue(q);
 
+	/* If the queue is assigned to the matrix mediated device, then
+	 * determine whether it is passed through to a guest; otherwise,
+	 * indicate that it is unassigned.
+	 */
 	if (matrix_mdev) {
-		if (matrix_mdev->kvm)
+		apid = AP_QID_CARD(q->apqn);
+		apqi = AP_QID_QUEUE(q->apqn);
+		/*
+		 * If the queue is passed through to the guest, then indicate
+		 * that it is in use; otherwise, indicate that it is
+		 * merely assigned to a matrix mediated device.
+		 */
+		if (matrix_mdev->kvm &&
+		    test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
+		    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
 			nchars = scnprintf(buf, PAGE_SIZE, "%s\n",
 					   AP_QUEUE_IN_USE);
 		else
-- 
2.41.0

