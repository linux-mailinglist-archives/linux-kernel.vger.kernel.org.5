Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667AC80F94E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377937AbjLLV0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377606AbjLLVZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:25:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8414CF;
        Tue, 12 Dec 2023 13:25:35 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCLBLx7012625;
        Tue, 12 Dec 2023 21:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wAvNN1SeJ/lIs+/n8FB/TmcNHVe2pqXbsreNOYoG0dw=;
 b=gcAQwOkQrfddWBENs3iSKBy2/5jb/F+q5pehm4+mro7Qd2EUY5xTXLresPn7UamzXWEu
 VBqT48ulFan3kbIopcCRb77uPwsuHS2JMkT50BSvarF6N9x3sThJuZvuhJmQAOIWVcvn
 I71YG0kA3RoPf70ncBE5fw32NqgOH73EaIuItEb2530GiHVJrvDll/co9a46gNxbwrds
 ZOaIpb6v4vRDMEQYEOyu7Jj11td1QA/dcSoAkn2BSAfMtNSW0N/qB7enZ2z3ckTD4mle
 9ruYBdVLGsXJJajujxzZiR2miTSoVszbUEpE+OxXtSBUywG9d0feydwRLGwCop+I/KCf CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxy328gb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 21:25:34 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCLF5bS024131;
        Tue, 12 Dec 2023 21:25:33 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxy328gap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 21:25:33 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCLD0FI028212;
        Tue, 12 Dec 2023 21:25:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2xym8dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 21:25:32 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BCLPU2d37683862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 21:25:31 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7B3B58052;
        Tue, 12 Dec 2023 21:25:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0154F5805D;
        Tue, 12 Dec 2023 21:25:30 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.61.187.43])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Dec 2023 21:25:29 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        stable@vger.kernel.org
Subject: [PATCH v2 6/6] s390/vfio-ap: do not reset queue removed from host config
Date:   Tue, 12 Dec 2023 16:25:17 -0500
Message-ID: <20231212212522.307893-7-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212212522.307893-1-akrowiak@linux.ibm.com>
References: <20231212212522.307893-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p4a9rDnsUK8uVIzbeiirvL6bLz8rA2bC
X-Proofpoint-GUID: KZy8XATUXV6dnBfTl0LlNembbSnnnklW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120165
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a queue is unbound from the vfio_ap device driver, it is reset to
ensure its crypto data is not leaked when it is bound to another device
driver. If the queue is unbound due to the fact that the adapter or domain
was removed from the host's AP configuration, then attempting to reset it
will fail with response code 01 (APID not valid) getting returned from the
reset command. Let's ensure that the queue is assigned to the host's
configuration before resetting it.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Fixes: eeb386aeb5b7 ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: <stable@vger.kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e014108067dc..84decb0d5c97 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2197,6 +2197,8 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	q = dev_get_drvdata(&apdev->device);
 	get_update_locks_for_queue(q);
 	matrix_mdev = q->matrix_mdev;
+	apid = AP_QID_CARD(q->apqn);
+	apqi = AP_QID_QUEUE(q->apqn);
 
 	if (matrix_mdev) {
 		/* If the queue is assigned to the guest's AP configuration */
@@ -2214,8 +2216,16 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 		}
 	}
 
-	vfio_ap_mdev_reset_queue(q);
-	flush_work(&q->reset_work);
+	/*
+	 * If the queue is not in the host's AP configuration, then resetting
+	 * it will fail with response code 01, (APQN not valid); so, let's make
+	 * sure it is in the host's config.
+	 */
+	if (test_bit_inv(apid, (unsigned long *)matrix_dev->info.apm) &&
+	    test_bit_inv(apqi, (unsigned long *)matrix_dev->info.aqm)) {
+		vfio_ap_mdev_reset_queue(q);
+		flush_work(&q->reset_work);
+	}
 
 done:
 	if (matrix_mdev)
-- 
2.43.0

