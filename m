Return-Path: <linux-kernel+bounces-119501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349488C9B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9177F327605
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EFE1CD38;
	Tue, 26 Mar 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QDHNkpBZ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98DE12E75;
	Tue, 26 Mar 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471636; cv=none; b=N+of6ba/xDf7EpTyyiRvTmOPdTJbtjShBG9fKwn4k7hb7l0OuT93imJxyGEBMdxhqrrjjlu4oQ0gKzatKWsTDqxtcOGWareIqj9+nSJYHcSqGl9uAxCFoQPYz3veyKo38R2DKk829BBIzCSTkqT6HuHog2CWfh6yCnTE9sEcj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471636; c=relaxed/simple;
	bh=tSlXTR1QKZXk2pfdOpSseZfCaKNekp47ZScfnD+Fa2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXNVPLBTkSRcWiCNSCqhCUkifX/GNpkzeqIkKklyIjV6W8eVRh1icPYABReiqHl4hutZcDvJMugzApEnqUiHpH+yQBxX2AJP/JwzXlKGE97PmmAyXUsJsf44V8XNU+Vmpz3GItCkLbBxw0PePNvrZanhH/I9KEModDnCj75ftYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QDHNkpBZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QGdFVR026384;
	Tue, 26 Mar 2024 16:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Qpf3+bKZA3IFFAh2Zgq/tCvKv4L+adz2xvIinaCNjGg=;
 b=QDHNkpBZzoDQrLz0s3c7hmUhGuCUz6roiXGSnjyiiPonNBrQ5yOpU8ra/uM8BuMzkFED
 UnzG/cwVMaRFQHQVrfRkBWCnjBLFUjMN2gUuzwyOQ+ywRRh869IMPW2fWndR+A7I+360
 rrUgDPL016BOvjWRqjvV3BxpmOhheZjXlMcODA3SSeci+4QvVWXZcFSY596401/XRQ1V
 aChScIQvwdKH8/5uXf0OcwiipSdcct0ZF2nJ6nRs64uWaJQXoCz2ZjceRl3VLeEUBWFr
 GrTTES+YO+Z0/2KYujR3LgZuEB2rlmavfwEtNpFGQygssFoVERXSyQ2fN0K6+tYA1EdV 2Q== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x4224r0sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 16:47:13 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42QFrBkH028675;
	Tue, 26 Mar 2024 16:47:12 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adp8was-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 16:47:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42QGl97Y26149580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 16:47:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BCD55805D;
	Tue, 26 Mar 2024 16:47:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8A6558057;
	Tue, 26 Mar 2024 16:47:08 +0000 (GMT)
Received: from jason-laptop.home.arpa (unknown [9.61.173.44])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Mar 2024 16:47:08 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
Subject: [PATCH v4 3/5] s390/vfio-ap: Ignore duplicate link requests in vfio_ap_mdev_link_queue
Date: Tue, 26 Mar 2024 12:47:04 -0400
Message-ID: <20240326164706.29167-4-jjherne@linux.ibm.com>
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
X-Proofpoint-GUID: WgL9AiRxulnS5l87ACelRY5eP8ujM1yY
X-Proofpoint-ORIG-GUID: WgL9AiRxulnS5l87ACelRY5eP8ujM1yY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260119

vfio_ap_mdev_link_queue is changed to detect if a matrix_mdev has
already linked the given queue. If so, it bails out.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index e01f53a3c5b7..1499c2181122 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -794,10 +794,11 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
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
-- 
2.41.0


