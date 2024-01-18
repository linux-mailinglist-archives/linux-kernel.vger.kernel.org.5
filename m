Return-Path: <linux-kernel+bounces-29836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B8C831433
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43063B255D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12BA2033C;
	Thu, 18 Jan 2024 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hid5dLq6"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898E11BC33;
	Thu, 18 Jan 2024 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705565080; cv=none; b=k3fdrMmk+mbx3aF+gvtpcf03XfxA2PYHyh1lc8snunaKJ6o5oT+nGHjrUPHIgwbt2RmAUUSLj3gyZ2btLMDacu331ye8hOtc0idX5xlpEzKAtUfirq13jbaDq3jd2Ncu/MHk9It17HVJJFUpRz9dA8hd+Jqk0Q1EQzVf18FOYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705565080; c=relaxed/simple;
	bh=0QdESbBtZ/ISvZsANzlPk0q0u9Eg1vmM5zr/uOfcCaI=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=VEigF9xv12yJSH3P2HT4YUQgR+idqtxxvACa5tHvyhSqt2VAE63P8sm6pfbDKmUMucaHlfbV9fUBWnxjPG46gm34ole2TmOGTDTJH01u3iHVA7w4/Dv3PNbgU51n9Bz583W07wvGXtoVdkKLlVCAoSPu15PWVTDchrRbR92gF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hid5dLq6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40I7wJRJ031217;
	Thu, 18 Jan 2024 08:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hnQzzb54EB6Nik9tA08SsWOYd/w2z1oIWszr1RROCZM=;
 b=hid5dLq6gdY3ewwsoy3mFW75v5sJh8x7pTlvEjBuWIzEh60czM6udDXOOPvZZVDf/+3l
 sdh1GZO6e2J70Q4cRDwNlr+3TllFAwglsYRGWTERLiEUfosEKeAe1W6nYPGuCgm5V6bz
 exfymJ6ZnJw3TJAeJehGNcl4kyXd82CkwSFlcltwWoIv+7qFWepcQdfljSgwa55IzUbi
 2+Jdr9yVmk/RLDCpU4wZFKgyKVll/QCvAOt106bJmZDKnTzXm7tBi7UqjTdX2+7PVNAb
 lOn+M7iLeKu7ERM6PNVWu7ig/86eO2Wcgv89PlPeKrykb4GdPXShLESpYAHXY3tHU72l gg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq02f86hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 08:04:11 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40I72xol000441;
	Thu, 18 Jan 2024 08:04:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm4ut2bda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 08:04:10 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40I848TM15008286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 08:04:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D570C2004B;
	Thu, 18 Jan 2024 08:04:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C712020043;
	Thu, 18 Jan 2024 08:04:06 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jan 2024 08:04:06 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, mingo@kernel.org,
        peterz@infradead.org, chandan.babu@oracle.com, anton@tuxera.com
Subject: [RFC PATCH 2/3] fs: remove duplicate ifdefs
Date: Thu, 18 Jan 2024 13:33:25 +0530
Message-Id: <20240118080326.13137-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240118080326.13137-1-sshegde@linux.ibm.com>
References: <20240118080326.13137-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P-8pNzrwHJ2K49DWfj4Oc0tgPfJY7qbK
X-Proofpoint-GUID: P-8pNzrwHJ2K49DWfj4Oc0tgPfJY7qbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_04,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180056

when a ifdef is used in the below manner, second one could be considered as
duplicate.

ifdef DEFINE_A
..code block...
ifdef DEFINE_A
..code block...
endif
..code block...
endif

There are few places in fs code where above pattern was seen.
No functional change is intended here. It only aims to improve code
readability.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 fs/ntfs/inode.c    | 2 --
 fs/xfs/xfs_sysfs.c | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index aba1e22db4e9..d2c8622d53d1 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2859,11 +2859,9 @@ int ntfs_truncate(struct inode *vi)
  *
  * See ntfs_truncate() description above for details.
  */
-#ifdef NTFS_RW
 void ntfs_truncate_vfs(struct inode *vi) {
 	ntfs_truncate(vi);
 }
-#endif

 /**
  * ntfs_setattr - called from notify_change() when an attribute is being changed
diff --git a/fs/xfs/xfs_sysfs.c b/fs/xfs/xfs_sysfs.c
index 17485666b672..d2391eec37fe 100644
--- a/fs/xfs/xfs_sysfs.c
+++ b/fs/xfs/xfs_sysfs.c
@@ -193,7 +193,6 @@ always_cow_show(
 }
 XFS_SYSFS_ATTR_RW(always_cow);

-#ifdef DEBUG
 /*
  * Override how many threads the parallel work queue is allowed to create.
  * This has to be a debug-only global (instead of an errortag) because one of
@@ -260,7 +259,6 @@ larp_show(
 	return snprintf(buf, PAGE_SIZE, "%d\n", xfs_globals.larp);
 }
 XFS_SYSFS_ATTR_RW(larp);
-#endif /* DEBUG */

 STATIC ssize_t
 bload_leaf_slack_store(
@@ -319,10 +317,8 @@ static struct attribute *xfs_dbg_attrs[] = {
 	ATTR_LIST(log_recovery_delay),
 	ATTR_LIST(mount_delay),
 	ATTR_LIST(always_cow),
-#ifdef DEBUG
 	ATTR_LIST(pwork_threads),
 	ATTR_LIST(larp),
-#endif
 	ATTR_LIST(bload_leaf_slack),
 	ATTR_LIST(bload_node_slack),
 	NULL,
--
2.39.3


