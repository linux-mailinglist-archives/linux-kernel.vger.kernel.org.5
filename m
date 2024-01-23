Return-Path: <linux-kernel+bounces-35997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A14908399E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A7AB22E58
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C985C49;
	Tue, 23 Jan 2024 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I11P/kwN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EFC82D6E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039697; cv=none; b=XOOWWdCYYu5f7R17jlBfSknGT6DXmOhrkTU5r+jvflnTIcJjDu3wimbPtj3qbhn9rhArPG6BAkMi3uN/E6iXGQy1rqEimS0oW4GOl+XnXoRwo3aXfn+UoWhXiS8qMEv3WAoqoJzCEzFR5vR4Y9kzDKyc1HdAzIaFqBdboq07J4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039697; c=relaxed/simple;
	bh=9IEGG6PLhGqtk7d3upqqFRh5vj6GY8bnCuD2LwJUNsk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GrfmDIq0X9SiWiutcfCxP9qfoYjsD03D6DRoEY7MJGmFp5MyGh3gjItFgUxbWBWU+6jC7NqV7STss6yOwm7qmO1RNH3e3XtSxtJgC1PdsXUv7/+mUpdvtsMe4rZoj60rGszQ4Dz3F3MnNK8e3kozWwwRDoSZ5CiUjnDK8Fui6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I11P/kwN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGRDpM010751;
	Tue, 23 Jan 2024 19:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=4cvj7c2w+z41DgBXLGIzhGP2KC9m8gbIV2h/6Xm2E7c=;
 b=I11P/kwN3xlIMVsze4r4AjQR7rnVlK2rgaOneJe0CJFtIjNLw3D7mX24cwJKAQL1xqJw
 Yi3fXY7s8tRbr2HZAoL0NfpoaP2oNjL8VRHykKlPRSyi2L7RzyaV6hhU61JmytGcyPci
 /K2Ay+8DExnSAxe5zBtCgJW8WRe+nbLnUi+esvwPYiJg/+qTAF2yoHkKQtRsxIMm2o3o
 Q75g34T/gIdb8qIDZP1MtBJfuMW5JdxQheFA3SvLqXg7Im2AQH8JboxAszGsKESi4qbp
 lllT7Fbei66C9trjJOYD4FgnAeu5j8Mvkjyk41dUftM0IeCVFZjkSq2bdA73RQ4w86Bk Uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cxy5t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 19:54:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40NJGoJm001953;
	Tue, 23 Jan 2024 19:54:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs322uy92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO);
	Tue, 23 Jan 2024 19:54:48 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40NJsliO012746;
	Tue, 23 Jan 2024 19:54:47 GMT
Received: from pp-thinkcentre-m82.us.oracle.com (dhcp-10-132-95-245.usdhcp.oraclecorp.com [10.132.95.245])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs322uy3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO);
	Tue, 23 Jan 2024 19:54:47 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: muchun.song@linux.dev, mike.kravetz@oracle.com, akpm@linux-foundation.org
Subject: [PATCH v3] Hugetlb pages should not be reserved by shmat() if SHM_NORESERVE
Date: Tue, 23 Jan 2024 12:04:42 -0800
Message-Id: <1706040282-12388-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_11,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230148
X-Proofpoint-ORIG-GUID: PbxVhyfXH_cXUs6-8xQQ0Hu3MOa1QFGZ
X-Proofpoint-GUID: PbxVhyfXH_cXUs6-8xQQ0Hu3MOa1QFGZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

For shared memory of type SHM_HUGETLB, hugetlb pages are reserved in
shmget() call. If SHM_NORESERVE flags is specified then the hugetlb
pages are not reserved. However when the shared memory is attached
with the shmat() call the hugetlb pages are getting reserved incorrectly
for SHM_HUGETLB shared memory created with SHM_NORESERVE which is a bug.

-------------------------------
Following test shows the issue.

$cat shmhtb.c

int main()
{
	int shmflags = 0660 | IPC_CREAT | SHM_HUGETLB | SHM_NORESERVE;
	int shmid;

	shmid = shmget(SKEY, SHMSZ, shmflags);
	if (shmid < 0)
	{
		printf("shmat: shmget() failed, %d\n", errno);
		return 1;
	}
	printf("After shmget()\n");
	system("cat /proc/meminfo | grep -i hugepages_");

	shmat(shmid, NULL, 0);
	printf("\nAfter shmat()\n");
	system("cat /proc/meminfo | grep -i hugepages_");

	shmctl(shmid, IPC_RMID, NULL);
	return 0;
}

 #sysctl -w vm.nr_hugepages=20
 #./shmhtb

After shmget()
HugePages_Total:      20
HugePages_Free:       20
HugePages_Rsvd:        0
HugePages_Surp:        0

After shmat()
HugePages_Total:      20
HugePages_Free:       20
HugePages_Rsvd:        5 <--
HugePages_Surp:        0
--------------------------------

Fix is to ensure that hugetlb pages are not reserved for SHM_HUGETLB shared
memory in the shmat() call.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
v2: Modifed fix to call hugetlb_reserve_pages() with VM_NORESERVE instead
    as per vma lock is allocated in hugetlb_reserve_pages().
v3: Updated change log to describe user visible effect of the bug with
    a test case, as suggested by Andrew Morton.

 fs/hugetlbfs/inode.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f757d4f..40b12b0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -100,6 +100,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	loff_t len, vma_len;
 	int ret;
 	struct hstate *h = hstate_file(file);
+	vm_flags_t vm_flags;
 
 	/*
 	 * vma address alignment (but not the pgoff alignment) has
@@ -141,10 +142,20 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	file_accessed(file);
 
 	ret = -ENOMEM;
+
+	vm_flags = vma->vm_flags;
+	/*
+	 * for SHM_HUGETLB, the pages are reserved in the shmget() call so skip
+	 * reserving here. Note: only for SHM hugetlbfs file, the inode
+	 * flag S_PRIVATE is set.
+	 */
+	if (inode->i_flags & S_PRIVATE)
+		vm_flags |= VM_NORESERVE;
+
 	if (!hugetlb_reserve_pages(inode,
 				vma->vm_pgoff >> huge_page_order(h),
 				len >> huge_page_shift(h), vma,
-				vma->vm_flags))
+				vm_flags))
 		goto out;
 
 	ret = 0;
-- 
2.7.4


