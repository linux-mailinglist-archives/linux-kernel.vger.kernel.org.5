Return-Path: <linux-kernel+bounces-167131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 682AC8BA4CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA201C21818
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10603E556;
	Fri,  3 May 2024 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jarkgbdv"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849928F47
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714698586; cv=none; b=ZRzO2hs6WW0PxOX7W+HlvDVYI1RT+QWKqNnj/52oJWt4Vdz2D/HQ7VL6GdMe4UNgRPaBF/XbS81UFReyF+AD+TnrUrjtEdae5zmFWwRQ1R+wcNjqYeZR2IPIzdFutcnh2RitSH3cnQi3V06GKL0WCrGWvili0gUaldSCLLYGshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714698586; c=relaxed/simple;
	bh=iayp5Ymt2FvhKu1bwN6Su6tiRmvTOj7tvklDVbpEaAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LMHewpoKhEqE0LvOIfgJ5LXy9PvL/TBAdRVJC1txBwEwVz+A2vwnZUQQ13uhE1uycsKzBj7T8loIwGK6zHwUhz1hyFTWlEXgCFm4BaNkR4o/e24DPZ8MeAsAVMPHOP7dS4JLE65sJGuAr9QY3jFGIOxQnum2FprZM+0Iv/p1Fw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jarkgbdv; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442MYFsU008652;
	Fri, 3 May 2024 01:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=lQ/aE5r73jz7sAhwozhn5KM1HznG3MJp5ZiMSMgpsgQ=;
 b=JarkgbdvNrJO/RDmT6uZH+SXL9lcOcakVBGKgVBbzE2TwtbVI1M+tY3FLCFDFxIXd9TQ
 8RYep6FKZULQEqT84xeZgRz1qapObZr9zSmAM5dfP5oVas8UfvRr1kXMxY7E/IVJzYCF
 55GkmTSc0H+k5gjCreKoRz0NQ+NXEWIh2ttBX85nSskkXrZzKooooMvGYvr3mWRE5JHu
 f1S6eVOTZZag+SY8PBhsv7HWjEl7KczUKCzkhsAPMIOPoe6GLOHMki1Bl/81ZNqm6cNb
 5nOZvslxH2H4TsZTypJ4Yt804LeAyL66An1IgfyJYvMGL2O1uim19sD8+moLue2Z9/ZD FQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9cyrg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 May 2024 01:09:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44300JsV006104;
	Fri, 3 May 2024 01:09:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtbp7y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO);
	Fri, 03 May 2024 01:09:24 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44319NBq035083;
	Fri, 3 May 2024 01:09:24 GMT
Received: from pp-thinkcentre-m82.us.oracle.com (dhcp-10-132-95-245.usdhcp.oraclecorp.com [10.132.95.245])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtbp7xd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO);
	Fri, 03 May 2024 01:09:24 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, willy@infradead.org,
        prakash.sangappa@oracle.com
Subject: [RFC PATCH 1/1] hugetlbfs: Add mount option to choose normal mmap behavior
Date: Thu,  2 May 2024 18:21:10 -0700
Message-Id: <1714699270-7360-2-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1714699270-7360-1-git-send-email-prakash.sangappa@oracle.com>
References: <1714699270-7360-1-git-send-email-prakash.sangappa@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_15,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405030006
X-Proofpoint-GUID: FyXI72XEtC_EkyeeYQSoka8OGImmMRXZ
X-Proofpoint-ORIG-GUID: FyXI72XEtC_EkyeeYQSoka8OGImmMRXZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Currently hugetlbfs file size gets extended in a PROT_WRITE mmap call,
if mmap size exceeds the file size. This is not normal filesystem behavior.

Some applications expect normal file system behavior for mmap, such that
the process would receive a signal when accessing mapped address beyond
file size. This will not happen if the file size gets extended by mmap(2).

Changing current behavior for hugetlbfs can potentially break existing
applications. Therefore provide a mount option "nommapfilesz" to choose
normal mmap behavior.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 fs/hugetlbfs/inode.c    | 19 ++++++++++++++++++-
 include/linux/hugetlb.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 6502c7e..e37867a 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -58,6 +58,7 @@ struct hugetlbfs_fs_context {
 	kuid_t			uid;
 	kgid_t			gid;
 	umode_t			mode;
+	ushort			nommapfilesz;
 };
 
 int sysctl_hugetlb_shm_group;
@@ -70,6 +71,7 @@ enum hugetlb_param {
 	Opt_pagesize,
 	Opt_size,
 	Opt_uid,
+	Opt_nommapfilesz,
 };
 
 static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
@@ -80,6 +82,7 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
 	fsparam_string("pagesize",	Opt_pagesize),
 	fsparam_string("size",		Opt_size),
 	fsparam_u32   ("uid",		Opt_uid),
+	fsparam_flag  ("nommapfilesz",  Opt_nommapfilesz),
 	{}
 };
 
@@ -159,7 +162,12 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		goto out;
 
 	ret = 0;
-	if (vma->vm_flags & VM_WRITE && inode->i_size < len)
+	/*
+	 * If filesystem is mounted with 'nommapfilesz' option, then
+	 * don't update file size.
+	 */
+	if (!(HUGETLBFS_SB(inode->i_sb)->nommapfilesz)
+			&& vma->vm_flags & VM_WRITE && inode->i_size < len)
 		i_size_write(inode, len);
 out:
 	inode_unlock(inode);
@@ -1169,6 +1177,8 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",mode=%o", sbinfo->mode);
 	if (sbinfo->max_inodes != -1)
 		seq_printf(m, ",nr_inodes=%lu", sbinfo->max_inodes);
+	if (sbinfo->nommapfilesz)
+		seq_puts(m, ",nommapfilesz");
 
 	hpage_size /= 1024;
 	mod = 'K';
@@ -1430,6 +1440,11 @@ static int hugetlbfs_parse_param(struct fs_context *fc, struct fs_parameter *par
 			ctx->min_val_type = SIZE_PERCENT;
 		return 0;
 
+	case Opt_nommapfilesz:
+		/* don't update file size in mmap call */
+		ctx->nommapfilesz = 1;
+		return 0;
+
 	default:
 		return -EINVAL;
 	}
@@ -1487,6 +1502,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbinfo->uid		= ctx->uid;
 	sbinfo->gid		= ctx->gid;
 	sbinfo->mode		= ctx->mode;
+	sbinfo->nommapfilesz    = ctx->nommapfilesz;
 
 	/*
 	 * Allocate and initialize subpool if maximum or minimum size is
@@ -1558,6 +1574,7 @@ static int hugetlbfs_init_fs_context(struct fs_context *fc)
 	ctx->min_hpages	= -1; /* No default minimum size */
 	ctx->max_val_type = NO_SIZE;
 	ctx->min_val_type = NO_SIZE;
+	ctx->nommapfilesz = 0; /* allows file size update in mmap call */
 	fc->fs_private = ctx;
 	fc->ops	= &hugetlbfs_fs_context_ops;
 	return 0;
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 77b30a8..282cab5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -537,6 +537,7 @@ struct hugetlbfs_sb_info {
 	kuid_t	uid;
 	kgid_t	gid;
 	umode_t mode;
+	ushort	nommapfilesz;
 };
 
 static inline struct hugetlbfs_sb_info *HUGETLBFS_SB(struct super_block *sb)
-- 
2.7.4


