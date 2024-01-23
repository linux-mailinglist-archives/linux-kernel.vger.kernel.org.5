Return-Path: <linux-kernel+bounces-34607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838568382C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF841C2935F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474C25F874;
	Tue, 23 Jan 2024 01:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KgjGpngi"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37175F863
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974468; cv=none; b=Or2me/ZUP35nuJsCc32aI9e0rJrqIOs5m+Trt+3syNXXY8JXvnEkYm3FmDWMuf/gIeUWQCy7u1p1xD5aodIMqrDyZLkfhIP1zf1Ba5R3mBD542iKW3iUCYDRW3d70V7iXqke1zY176po2SKjgnOiw+nzIX2rqnwpyZY3CrCh0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974468; c=relaxed/simple;
	bh=jlfZpZtrTAEtwPjAPXh5F5XUyJRNCxItTgf/zQ4aTMs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YMV1wX2kl5S3VQQ02v/FIbRtpN7/VM9AAyL/Kvwrye5FE1ef4EPjSPUyPaOx5+pbSfOrwtxlzt6lGs4zjmugtCO3Qx5vMoyyaMQGrIVrgDpV4AxuRf2CzkF52iif8AvdsM7Lwkpv6zm6v3UkLjXFDJ/H9q7i/Xh/Ql+CFb89UiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KgjGpngi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N19N1f019181;
	Tue, 23 Jan 2024 01:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=TC/QpDTCm4nZZLQsXNsmNLF8U0JnbhWRqpM4J6CpmGw=;
 b=KgjGpngiLSD+eBHVRU5Ibbz++qjKmB2hMZcB+zdujrkg1eT12ZRGgI6j7dFI9AnReKhI
 UE9EtckNMvk7+Yn/QZHo3KMWiZA+v4gGLwVdQWgJI8FdLtzij+3vX6MNqE90ON07KXl/
 M4pn84Cnt+GsXJPuWlOf+xDLAtBTi3PVnM/I9UfPWIJB/mEe2/qU0Yf7ATBlF6P2O15O
 +E3HcsZ8kHrbvMJoPRrBk4ce3slCE4keLmyfDUQcfTbLTWoORhh9quxeMWjd8gCpU5T8
 IS94zEVs4CxngyR3xWhgvX729ibyKXbhP9o3xtA3uKCpOZcPs7hYRF75l51VQh1AJYFp 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79nd5v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 01:47:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40N1LdcN016231;
	Tue, 23 Jan 2024 01:47:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32q30cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO);
	Tue, 23 Jan 2024 01:47:31 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40N1lVdH038421;
	Tue, 23 Jan 2024 01:47:31 GMT
Received: from pp-thinkcentre-m82.us.oracle.com (dhcp-10-132-95-245.usdhcp.oraclecorp.com [10.132.95.245])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32q30br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO);
	Tue, 23 Jan 2024 01:47:31 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: muchun.song@linux.dev, mike.kravetz@oracle.com, akpm@linux-foundation.org
Subject: [PATCH v2] Hugetlb pages should not be reserved by shmat() if SHM_NORESERVE
Date: Mon, 22 Jan 2024 17:57:36 -0800
Message-Id: <1705975056-29419-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230010
X-Proofpoint-GUID: h2mzfpDa_XWWvZ62hbT7WCk9IJnARNor
X-Proofpoint-ORIG-GUID: h2mzfpDa_XWWvZ62hbT7WCk9IJnARNor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

For shared memory of type SHM_HUGETLB, hugetlb pages are reserved in
shmget() call. If SHM_NORESERVE flags is specified then the hugetlb
pages are not reserved. However when the shared memory is attached
with the shmat() call the hugetlb pages are getting reserved incorrectly
for SHM_HUGETLB shared memory created with SHM_NORESERVE.

Ensure that the hugetlb pages are not reserved for SHM_HUGETLB shared
memory in the shmat() call.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
v2: Modifed fix to call hugetlb_reserve_pages() with VM_NORESERVE instead
    as per vma lock is allocated in hugetlb_reserve_pages().
    
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


