Return-Path: <linux-kernel+bounces-53207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133A84A230
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645481C231ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE3B4E1CB;
	Mon,  5 Feb 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eHA+HCxN"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4F482C3;
	Mon,  5 Feb 2024 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157538; cv=none; b=TcsAx+zB+qZpM2HxiX4gPFiS8mlun1B0lJrksV2/ETdgw4d1VBYT1a2RSh5ac8PtJath0Z3x2qlcqKGv6eq5XzwRQRN/w9S8gFZ9PKIiSTKyIuJRf3LG6oL5OujWQ+3qSYCznRLVFabfanTOjyF/ey67LMfX9g4jP4Xiv8U7dvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157538; c=relaxed/simple;
	bh=EKMq2BJLYzGPLpMhLTlC4/Xem0+zzLuE6yCAvONsrlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=po3y2MPP9tFhCYpYv/yG8EDfXNWC61mw9Zgpy4tTCRcGBaUkze39JKebtLPG8oXId+P+ZZZx/8dXKyTg0Eee33QD1wmkdi1WFCO57k1B5r7+m6/iWZuIGzMMtpAWe98r46RJAxrSyu8T4KOn7xmqQ1c3+3tTvqdPFrECEsLBJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eHA+HCxN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415Hv0Oc021258;
	Mon, 5 Feb 2024 18:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JVnRdF81tuXESdXyDK4cVRTUeVgPDQeTxd0U+AATuFw=;
 b=eHA+HCxNWdR9EQPSsxTxHfQJXDhUjNjaUTls0F9qiOtqGvvp8UUhpSxRzAXFe0Fhxw1i
 gmSkxnPfkoJUQzlEpmS0W2uBIL72+3duXKqoUayE4MGvRmDezkBkYYzJo47syUO9gnb+
 VDA7UR+p5InUNt8feQzjkcvRgt+jTMGOeNjZwGVXeNfAI1iuwpsgaJEyrtN7eGPB5ODy
 pESzL9EZn9+hs6reVvA8j3Q5NFadlnZLBCjSub4VSk8XVbyUY9XX6GtkMXnUqo3cKSGm
 +8iv/pn6EER8HZs9saKH0zF4ViVtF/Vp2KNImx11V6lGDc9cc6zZJmJRnHHzcSNnmz9S qA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34gygpu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:13 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415Hv3ZT021755;
	Mon, 5 Feb 2024 18:25:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34gygpu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:13 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415HIuR6005421;
	Mon, 5 Feb 2024 18:25:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21aka1x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415IPB1120447824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 18:25:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B4C958056;
	Mon,  5 Feb 2024 18:25:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD68D5803F;
	Mon,  5 Feb 2024 18:25:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 18:25:10 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 1/9] ima: Rename backing_inode to real_inode
Date: Mon,  5 Feb 2024 13:24:58 -0500
Message-ID: <20240205182506.3569743-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205182506.3569743-1-stefanb@linux.ibm.com>
References: <20240205182506.3569743-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 15ri-6KcoOl1FIWMPNKb1puBrn8ynC6h
X-Proofpoint-ORIG-GUID: xHdMZTnl8ZD4cltJJVLqnQW6p7sdAYou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=676 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050138

Rename the backing_inode variable to real_inode since it gets its value
from real_inode().

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cc1217ac2c6f..f1a01d32b92a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -208,7 +208,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
 {
-	struct inode *backing_inode, *inode = file_inode(file);
+	struct inode *real_inode, *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
 	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
@@ -285,14 +285,16 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		iint->measured_pcrs = 0;
 	}
 
-	/* Detect and re-evaluate changes made to the backing file. */
-	backing_inode = d_real_inode(file_dentry(file));
-	if (backing_inode != inode &&
+	/*
+	 * Detect and re-evaluate changes made to the inode holding file data.
+	 */
+	real_inode = d_real_inode(file_dentry(file));
+	if (real_inode != inode &&
 	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
-		if (!IS_I_VERSION(backing_inode) ||
-		    backing_inode->i_sb->s_dev != iint->real_dev ||
-		    backing_inode->i_ino != iint->real_ino ||
-		    !inode_eq_iversion(backing_inode, iint->version)) {
+		if (!IS_I_VERSION(real_inode) ||
+		    real_inode->i_sb->s_dev != iint->real_dev ||
+		    real_inode->i_ino != iint->real_ino ||
+		    !inode_eq_iversion(real_inode, iint->version)) {
 			iint->flags &= ~IMA_DONE_MASK;
 			iint->measured_pcrs = 0;
 		}
-- 
2.43.0


