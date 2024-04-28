Return-Path: <linux-kernel+bounces-161542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 193418B4D83
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C63D1C20E7F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F5F74418;
	Sun, 28 Apr 2024 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CwWIQV1u"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF610F1;
	Sun, 28 Apr 2024 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714330055; cv=none; b=UnUKj2GD9wkUS2wEmCiJamvCo9ULtDd3b42h6sqWJGJo8yGVILjUe/UkqjJrjluW/tXtYQS3z4tavTauLEDN7IJZ8T75s5BJsvBBKMIbf/RDEJ6Uj9V5zNsOWrFrEYDuXYLZ/hGsEVELdQFQ2GDbb0gkYz6VcSqrL8ExPOoKAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714330055; c=relaxed/simple;
	bh=m6j5X7kkRsy0jNz4W4J2H+m9P4T+FREt7QZZgGMbxHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HwiCuxzaNBQEdu3HoFTi5rAJ9vuJRXZfv1cVFjcVFzl7UtklOYof1vgQ3Brm/Gq1FoY+uj03pnJX3pJR+vRoSCHKQoI1Gr4SKSyQyduJ1z+hz24nEUWRCnBvF9P/jn/RjYGA966P/PKNfcIS9Ma7alPvL0IIU01Qf9WAu8UT634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CwWIQV1u; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43SI02d7023839;
	Sun, 28 Apr 2024 18:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=I4ysU+McRbHc4h0GRmdtQ63jVm/RP8IBrMgQGol7Z2A=;
 b=CwWIQV1u79TDvzg30290GaenVGQVxC0EY5DkSwxHiLaaRs4Hlpf1QkPKn37oRi7r06/U
 XtjtdMpK5Vu8dDTm6mjtz5pSWRZ09/xiF9HNG/b4R7W9QuW94miwFgwfMHFIM0x9g1FE
 PN4bvDzijb2YRTk5vpZeKKIFJfkLxQI9SexiRIEJmrNnPTW27J+VOQRdruh4SpNg4e77
 t79+y8KRxpE7Re2mIHj0S7gBwvnGxNXosBePN/EKQEqaSmcWrlAaDGIyy0PeIGZNXNyQ
 FiWKNv7nhuxqlsiWpfrYESsw+kVDgLYGR6oQyNPlPgpcIhyxc7HoSWgevuhZo475IAPa ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdehbvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Apr 2024 18:47:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43SHOqfd008453;
	Sun, 28 Apr 2024 18:47:30 GMT
Received: from gms-ol9-upstr-build.osdevelopmeniad.oraclevcn.com (gms-ol9-upstr-build.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.194])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xrqt58jrm-1;
	Sun, 28 Apr 2024 18:47:30 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk
Subject: [RFC for-6.10/block] loop: Fix a race between loop detach and loop open
Date: Sun, 28 Apr 2024 18:47:29 +0000
Message-Id: <20240428184729.619458-1-gulam.mohamed@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-28_14,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404280134
X-Proofpoint-GUID: zSG1xs6jvJXIG742Mb2RQVQGc1xCp9p1
X-Proofpoint-ORIG-GUID: zSG1xs6jvJXIG742Mb2RQVQGc1xCp9p1

Description
===========

1. Userspace sends the command "losetup -d" which uses the open() call
   to open the device
2. Kernel receives the ioctl command "LOOP_CLR_FD" which calls the
   function loop_clr_fd()
3. If LOOP_CLR_FD is the first command received at the time, then the
   AUTOCLEAR flag is not set and deletion of the
   loop device proceeds ahead and scans the partitions (drop/add
   partitions)

	if (disk_openers(lo->lo_disk) > 1) {
		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
		loop_global_unlock(lo, true);
		return 0;
	}

 4. Before scanning partitions, it will check to see if any partition of
    the loop device is currently opened
 5. If any partition is opened, then it will return EBUSY:

    if (disk->open_partitions)
		return -EBUSY;
 6. So, after receiving the "LOOP_CLR_FD" command and just before the above
    check for open_partitions, if any other command
    (like blkid) opens any partition of the loop device, then the partition
    scan will not proceed and EBUSY is returned as shown in above code
 7. But in "__loop_clr_fd()", this EBUSY error is not propagated
 8. We have noticed that this is causing the partitions of the loop to
    remain stale even after the loop device is detached resulting in the
    IO errors on the partitions

Fix
---
Re-introduce the lo_open() call to restrict any process to open the loop
device when its being detached

Test case
=========
Test case involves the following two scripts:

script1.sh
----------
while [ 1 ];
do
	losetup -P -f /home/opt/looptest/test10.img
	blkid /dev/loop0p1
done

script2.sh
----------
while [ 1 ];
do
	losetup -d /dev/loop0
done

Without fix, the following IO errors have been observed:

kernel: __loop_clr_fd: partition scan of loop0 failed (rc=-16)
kernel: I/O error, dev loop0, sector 20971392 op 0x0:(READ) flags 0x80700
        phys_seg 1 prio class 0
kernel: I/O error, dev loop0, sector 108868 op 0x0:(READ) flags 0x0
        phys_seg 1 prio class 0
kernel: Buffer I/O error on dev loop0p1, logical block 27201, async page
        read

Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
---
 drivers/block/loop.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28a95fd366fe..9a235d8c062d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1717,6 +1717,24 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 }
 #endif
 
+static int lo_open(struct gendisk *disk, blk_mode_t mode)
+{
+        struct loop_device *lo = disk->private_data;
+        int err;
+
+        if (!lo)
+                return -ENXIO;
+
+        err = mutex_lock_killable(&lo->lo_mutex);
+        if (err)
+                return err;
+
+        if (lo->lo_state == Lo_rundown)
+                err = -ENXIO;
+        mutex_unlock(&lo->lo_mutex);
+	return err;
+}
+
 static void lo_release(struct gendisk *disk)
 {
 	struct loop_device *lo = disk->private_data;
@@ -1752,6 +1770,7 @@ static void lo_free_disk(struct gendisk *disk)
 
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
+	.open = 	lo_open,
 	.release =	lo_release,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.39.3


