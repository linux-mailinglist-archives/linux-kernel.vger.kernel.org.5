Return-Path: <linux-kernel+bounces-102512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4462F87B31A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007802891EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C6E54725;
	Wed, 13 Mar 2024 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tMIaBCSj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22774CB35;
	Wed, 13 Mar 2024 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363498; cv=none; b=bE5S41utqHJJJwQ2AcoBE+bTEXlluA2AkNFdhDxrKbTz4Vp6NUN5tq6dVL4fnReSATidKC9cauEAKSRNQnXuGPiGm7nI6+2xgbIdOybV5vj6qn0KF344PnDozphSFxMsumzFHHgT4+lSCwMt/FJ1xZRExz8N30ty90cOeLgXyTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363498; c=relaxed/simple;
	bh=tSlXTR1QKZXk2pfdOpSseZfCaKNekp47ZScfnD+Fa2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoCZtrGdXyZe74UvxrKKB29vOPEH/SgiSp9/hkIauM/vFpV2+e1RUp73aqOYeb3mwik4mxNzXYN4Eftasqg5ED+F2BvPHg/WThnNsbbCxRWfZpT8Sp6VEXqexnFNMKHqqNx6VcUvJ8biQ+dGTdqitpa4Jne+TWW1n6DWhJLzxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tMIaBCSj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DI22mp032526;
	Wed, 13 Mar 2024 20:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Qpf3+bKZA3IFFAh2Zgq/tCvKv4L+adz2xvIinaCNjGg=;
 b=tMIaBCSjDtyD9a6TFcS2Yt8nvhc1UMlC8ElDX7ZLWtY8nDElVEkZhmtVxoQ+BVh2/fkV
 vMxNoHJqU8BNjp95EPxvVC09i+0v9RWfE7eHif6XVrjXWD9tBRkHD95ngBBK5/9XS7IF
 1wFes6mHMx4a4k1eu4mAOMC+Spu8CLJV+XshdUiTr4QhnE2svWiAfZnA+5fDiyr0b5ci
 bRsl/E/p5CGVbHZm/RRbLB9IBkReIJsZOOZGHfJIls99+AmOAJyGQNXEYmSIaI/XOl16
 ZwTB0GKjfi9rWmD+q2nnCE5RTYsRuJXoai/Oh/x21CSolyGCDiJlDWvbNNY0Ddarp0Cx rA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wuh2ft0dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:58:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42DKXmuZ018134;
	Wed, 13 Mar 2024 20:58:14 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws23tgqr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:58:14 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42DKwBRQ27722226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 20:58:13 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE5675806C;
	Wed, 13 Mar 2024 20:58:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EBDF58060;
	Wed, 13 Mar 2024 20:58:10 +0000 (GMT)
Received: from jason-laptop.ibmuc.com (unknown [9.61.59.128])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Mar 2024 20:58:10 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
Subject: [PATCH v3 3/5] s390/vfio-ap: Ignore duplicate link requests in vfio_ap_mdev_link_queue
Date: Wed, 13 Mar 2024 16:58:05 -0400
Message-ID: <20240313205807.30554-4-jjherne@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: W0uojsw1S5QvGbUSieI5qg1r8ccupXKd
X-Proofpoint-GUID: W0uojsw1S5QvGbUSieI5qg1r8ccupXKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130160

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


